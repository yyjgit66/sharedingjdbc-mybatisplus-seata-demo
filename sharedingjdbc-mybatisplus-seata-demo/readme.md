

## 背景
项目需求背景下需要整合一下这两个中间件来实现分库分表 加分布式事务。之后搜了下整合 seata 和 shardingjdbc 参考了有七八篇文章，也试了三四篇文章的代码和步骤都没有成功（可能是我本地seata是用的1.2版本）。然后决定弄个最新的整合的demo，来实现分库分表加分布式事务的功能。
>**本demo不适用生产环境，高可用需要调整！！**
>**本demo不适用生产环境，高可用需要调整！！**
>**本demo不适用生产环境，高可用需要调整！！**

>重点参考链接
>其他作者集成版本有点老但思路很清晰: [传送门](https://www.jianshu.com/p/41ebdaf403c8)
>seata 官方github原版集成教程: [传送门](https://github.com/seata/seata-samples/tree/master/springboot-shardingsphere-seata)
> sharding 官方的集成: [传送门]([https://github.com/apache/shardingsphere/tree/master/examples/sharding-jdbc-example/transaction-example/transaction-base-seata-spring-boot-example](https://github.com/apache/shardingsphere/tree/master/examples/sharding-jdbc-example/transaction-example/transaction-base-seata-spring-boot-example)
)
## 集成环境信息

电脑本地需要启动的服务：
> seata server 版本： 1.2.0     【[官方下载](https://github.com/seata/seata/releases/download/v1.2.0/seata-server-1.2.0.zip) | [csdn下载](https://download.csdn.net/download/LQ137969328/12411552)】（正常启动）
> consul : 1.6.0      (docker启动 项目中有yml)
> 
软件版本 只列一些核心的其他细节信息在项目中查看
> springcloud : `Hoxton.RELEASE`
>springboot : `2.2.1.RELEASE`
>spring-cloud-alibaba-seata: `2.2.0.RELEASE`
>sharding-jdbc-spring-boot-starter: `4.1.0`
>sharding-transaction-base-seata-at `4.1.0`
>consul-api : `1.4.3`
>mybatis-plus-boot-starter: `3.1.0`

### seata Server端的配置
**seataServer 目录结构**
这里的 file.conf 和 registry.conf 是服务端的
在具体项目中还需要配置seata client端的配置
![seataServer目录](https://imgconvert.csdnimg.cn/aHR0cHM6Ly91cGxvYWQtaW1hZ2VzLmppYW5zaHUuaW8vdXBsb2FkX2ltYWdlcy8yMjU5MTM1LWFlMjM0NjdlOTFlMTFjMDYucG5n?x-oss-process=image/format,png)
 
以下是 `conf/file.conf`   **部分配置**  可能需要更变的项：
```java

## transaction log store, only used in seata-server
store {
  ## store mode: file、db
 ## 可能需要更变的地方
  mode = "db"


  ## database store property
  db {
    ## the implement of javax.sql.DataSource, such as DruidDataSource(druid)/BasicDataSource(dbcp) etc.
    datasource = "druid"
    ## mysql/oracle/postgresql/h2/oceanbase etc.
    dbType = "mysql"
    driverClassName = "com.mysql.jdbc.Driver"
    ## 可能需要更变的地方
    url = "jdbc:mysql://127.0.0.1:13306/seata"
    ## 可能需要更变的地方
    user = "root"
    ## 可能需要更变的地方
    password = "123456"
    minConn = 5
    maxConn = 30
   ##  这里的表创建语句在 resource/sql/seatDB.sql 语句中
   ##  这里的表创建语句在 resource/sql/seatDB.sql 语句中
   ##  这里的表创建语句在 resource/sql/seatDB.sql 语句中
    globalTable = "global_table"
    branchTable = "branch_table"
    lockTable = "lock_table"
    queryLimit = 100
    maxWait = 5000
  }
}


```
`registry.conf`  **部分配置** 重点修改的地方:
```java
registry {
  # file 、nacos 、eureka、redis、zk、consul、etcd3、sofa
  type = "consul"
```
```java
 consul {
    cluster = "seata-server"
    serverAddr = "127.0.0.1:8500"
  }
```
 
>`registry.conf` 中 
>>**registry** 节点 配置注册中心 我这里使用的是consul  具体情况具体对待。
>>**config** 节点 设置 seata server启动的时候 读取的配置。这里的 默认 `file` 选项 就是从 文件（file.conf）读取配置信息，也支持  `nacos` ,`apollo`,`zookeeper`,`consul`,`etcd3`

>`file.conf`  配置了seata服务端事物信息存储方式  db 或者 file

###  启动 consul 和 seataServer
>**启动顺序 mysql服务--> consul服务 ----> seata服务**

1.启动consul 我这里是 docker-compose 启动 ：
cd 到 提供的`docker-compose.yml`(文件在)文件目录下 执行：
```java
docker-compose up -d
```
2.启动 seata服务 解压 `seata.zip` 文件 或者 官方下载的是
`seata-server-1.2.0.zip`
**windows** 
执行 seata-->bin--> seata-server.bat 文件
**linux | mac**
执行 seata-->bin--> seata-server.sh 文件 `sh seata-server.sh`
至此  consul 和 seata 两个 服务（控制台没有错误信息的话）已经启动完成。下面来看看项目中的重点
### springboot项目中的使用
>项目resources目录下配置文件

#### 一、`application.yml`配置内容注意点：

1),配置ribbon的超时时间
```java
### Ribbon 配置
ribbon:
    # 连接超时
    ConnectTimeout: 2000
    # 响应超时 这个数值需要根据本机处理速度的时间调整我这里是  10秒
    # 在调用多个服务的时候 之间需要等待时间，如果这个设置太短 会出错误
    ReadTimeout: 10000
```
2),设置 事务组
```java
spring: 
    cloud:
         alibaba:
            seata:
                # 这里是自定义的事务组
                tx-service-group: my_tx_group
```
#### 二、registry.conf 

这个文件的内容和 seataServer 文件夹中的 `registry.conf `格式一致
我们只关注 文件中  `registry` 节点 `type` 的值的配置 我这里用的是`consul`   __seata-server__ 注册的服务名
```java
consul {
    cluster = "seata-server"
    serverAddr = "127.0.0.1:8500"
  }
```
#### 三、file.conf
主要是项目启动会使用这个 文件中的信息来初始化seata-client端。若配置了 配置中心 拉取配置 这个文件可以省略。如 在 registry.conf中指定 apollo  .(这块的东西可以去官网查看详情 我里用的file)




#### <a id="important">主要关注service节点file配置</a>
项目resource 目录下的 file.conf配置文件：
`vgroupMapping.my_tx_group = "seata-server"`
` seata-server.grouplist = "127.0.0.1:8091"`
这两个配置注意   `my_tx_group` 要和 `application.yml` 和 `seata.conf`中的 group的值 **要一致**。
还有个重点：如果要改动  `seata-server` 为 `my-seata-server` 请参照下方改动  
> `vgroupMapping.my_tx_group = "my-seata-server"`
> `前缀要跟着变动`
>` my-seata-server.grouplist = "127.0.0.1:8091"`
```java
service {
  #transaction service group mapping
  vgroupMapping.my_tx_group = "seata-server"
  #only support when registry.type=file, please don't set multiple addresses
  seata-server.grouplist = "127.0.0.1:8091"
  #degrade, current not support
  enableDegrade = false
  #disable seata
  disableGlobalTransaction = false
}
```
>项目中介绍

#### 一、Application.java springboot启动类
这里需要排除掉自动配置的类

`DruidDataSourceAutoConfigure.class`
`    DataSourceAutoConfiguration.class`
 `   MybatisPlusAutoConfiguration.class`

```java
@MapperScan({"com.robotbana.demo.shardingjdbc.mybatisplus.mapper"})
@EnableDiscoveryClient
@EnableFeignClients
@EnableConfigurationProperties
@SpringBootApplication(exclude = {
    DruidDataSourceAutoConfigure.class,
    DataSourceAutoConfiguration.class,
    MybatisPlusAutoConfiguration.class
})
public class AccountApp {

  public static void main(String[] args) {
    SpringApplication.run(AccountApp.class, args);
  }
}
```
#### 二 应用中的config配置java类
`MybatisPlusAutoConfig.java`
这个类的内容其实是照抄了mybatisplus中的 这个类
`MybatisPlusAutoConfiguration.java`
因为自带的配置类中有这个注解 `@AutoConfigureAfter({DataSourceAutoConfiguration.class})`  去掉这个不依赖 默认的DataSource注入

至于官网的demo 或者网上其他demo需要用 `GlobalTransactionScanner` 类来覆盖 seata-all 自带的同名这个类，在目前我整合这个版本中不需要这样做。主要整合mybatisplus就好了。 seata和shardingjdbc的整合会自动集成。

**刚开始用下面这个jar没整合成功**
```c
<dependency> 
     <groupId>io.seata</groupId> 
    <artifactId>seata-spring-boot-starter</artifactId> 
  </dependency>
```

### 常见问题
- 1，保证 seata server端版本和  应用整合的版本 不要差太多，我第一次就反了这个错误，seata-server用的1.2 本地用的 1.0. 这样会显示seata-service控制台显示日志回滚了 但是应用并未回滚生效
- 2，` seata no available service 'null' found, please make sure registry config correct ` 这个错误是 
`io.seata.core.rpc.netty.NettyClientChannelManager`这个类的 这个方法抛出来的。原因就是 seata1.0+ 更变了配置文件的静态值
```java
void reconnect(String transactionServiceGroup) {
    List availList = null;

    try {
      availList = this.getAvailServerList(transactionServiceGroup);
    } catch (Exception var7) {
      LOGGER.error("Failed to get available servers: {}", var7.getMessage(), var7);
      return;
    }

    if (CollectionUtils.isEmpty(availList)) {
  //点去这个方法 可以看到 有个静态变量有修改 
//PREFIX_SERVICE_MAPPING ="vgroupMapping." 
// 所以在file.conf 配置文件中
      String serviceGroup = RegistryFactory.getInstance().getServiceGroup(transactionServiceGroup);
      LOGGER.error("no available service '{}' found, please make sure registry config correct", serviceGroup);
    } else {
      Iterator var3 = availList.iterator();

      while(var3.hasNext()) {
        String serverAddress = (String)var3.next();

        try {
          this.acquireChannel(serverAddress);
        } catch (Exception var6) {
          LOGGER.error("{} can not connect to {} cause:{}", new Object[]{FrameworkErrorCode.NetConnect.getErrCode(), serverAddress, var6.getMessage(), var6});
        }
      }

    }
  }
```
解决方法参考 >> **[主要关注service节点file配置](#important)**     

- 3, 异常：Could not register branch into global session xid = status = Rollbacked（还有Rollbacking、AsyncCommitting等等二阶段状态） while expecting Begin
描述：分支事务注册时，全局事务状态需是一阶段状态begin，非begin不允许注册。属于seata框架层面正常的处理，用户可以从自身业务层面解决。
    出现场景（可继续补充）:
  * 1. 分支事务是异步，全局事务无法感知它的执行进度，全局事务已进入二阶段，该异步分支才来注册
   * 2. 服务a rpc 服务b超时（dubbo、feign等默认1秒超时），a上抛异常给tm，tm通知tc回滚，但是b还是收到了请求（网络延迟或rpc框架重试），然后去tc注册时发现全局事务已在回滚
   * 3. tc感知全局事务超时(@GlobalTransactional(timeoutMills = 默认60秒))，主动变更状态并通知各分支事务回滚，此时有新的分支事务来注册

seata 异常可以去  [seata官网](https://seata.io/)查看

----------------


###项目地址
 
 >[https://gitee.com/lanceq/springbootdemo/tree/master/sharedingjdbc-mybatisplus-seata-demo](https://gitee.com/lanceq/springbootdemo/tree/master/sharedingjdbc-mybatisplus-seata-demo)


 #### 项目的启动
项目拉取下来
-  执行sql文件： 需要依赖mysql 数据。在项目的 `resource/sql` 目录下有 两个sql 文件 都得在数据中执行。
- 项目启动顺序 ： **无启动顺序**  随便先启动  account 或者 order 都行。
- 查看控制台。启动完成后 观察控制待不抛错基本没什么问题。
这里为了小伙伴区分启动是否成功我把account启动成功的 控制台也贴一下：
```java
/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/bin/java -XX:TieredStopAtLevel=1 -noverify -Dspring.output.ansi.enabled=always -Dcom.sun.management.jmxremote -Dspring.jmx.enabled=true -Dspring.liveBeansView.mbeanDomain -Dspring.application.admin.enabled=true "-javaagent:/Applications/IntelliJ IDEA.app/Contents/lib/idea_rt.jar=59898:/Applications/IntelliJ IDEA.app/Contents/bin" -Dfile.encoding=UTF-8 -classpath /Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/jre/lib/charsets.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/jre/lib/deploy.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/jre/lib/ext/cldrdata.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/jre/lib/ext/dnsns.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/jre/lib/ext/jaccess.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/jre/lib/ext/jfxrt.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/jre/lib/ext/localedata.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/jre/lib/ext/nashorn.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/jre/lib/ext/sunec.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/jre/lib/ext/sunjce_provider.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/jre/lib/ext/sunpkcs11.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/jre/lib/ext/zipfs.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/jre/lib/javaws.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/jre/lib/jce.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/jre/lib/jfr.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/jre/lib/jfxswt.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/jre/lib/jsse.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/jre/lib/management-agent.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/jre/lib/plugin.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/jre/lib/resources.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/jre/lib/rt.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/lib/ant-javafx.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/lib/dt.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/lib/javafx-mx.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/lib/jconsole.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/lib/packager.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/lib/sa-jdi.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/lib/tools.jar:/Users/lance/project/javademo/springbootdemo/sharedingjdbc-mybatisplus-seata-demo/account/target/classes:/Users/lance/mavenRepo/org/springframework/boot/spring-boot-starter-web/2.2.1.RELEASE/spring-boot-starter-web-2.2.1.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/boot/spring-boot-starter/2.2.1.RELEASE/spring-boot-starter-2.2.1.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/boot/spring-boot/2.2.1.RELEASE/spring-boot-2.2.1.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/boot/spring-boot-starter-logging/2.2.1.RELEASE/spring-boot-starter-logging-2.2.1.RELEASE.jar:/Users/lance/mavenRepo/jakarta/annotation/jakarta.annotation-api/1.3.5/jakarta.annotation-api-1.3.5.jar:/Users/lance/mavenRepo/org/yaml/snakeyaml/1.25/snakeyaml-1.25.jar:/Users/lance/mavenRepo/org/springframework/boot/spring-boot-starter-json/2.2.1.RELEASE/spring-boot-starter-json-2.2.1.RELEASE.jar:/Users/lance/mavenRepo/com/fasterxml/jackson/core/jackson-databind/2.10.0/jackson-databind-2.10.0.jar:/Users/lance/mavenRepo/com/fasterxml/jackson/core/jackson-annotations/2.10.0/jackson-annotations-2.10.0.jar:/Users/lance/mavenRepo/com/fasterxml/jackson/core/jackson-core/2.10.0/jackson-core-2.10.0.jar:/Users/lance/mavenRepo/com/fasterxml/jackson/datatype/jackson-datatype-jdk8/2.10.0/jackson-datatype-jdk8-2.10.0.jar:/Users/lance/mavenRepo/com/fasterxml/jackson/datatype/jackson-datatype-jsr310/2.10.0/jackson-datatype-jsr310-2.10.0.jar:/Users/lance/mavenRepo/com/fasterxml/jackson/module/jackson-module-parameter-names/2.10.0/jackson-module-parameter-names-2.10.0.jar:/Users/lance/mavenRepo/org/springframework/boot/spring-boot-starter-tomcat/2.2.1.RELEASE/spring-boot-starter-tomcat-2.2.1.RELEASE.jar:/Users/lance/mavenRepo/org/apache/tomcat/embed/tomcat-embed-core/9.0.27/tomcat-embed-core-9.0.27.jar:/Users/lance/mavenRepo/org/apache/tomcat/embed/tomcat-embed-el/9.0.27/tomcat-embed-el-9.0.27.jar:/Users/lance/mavenRepo/org/apache/tomcat/embed/tomcat-embed-websocket/9.0.27/tomcat-embed-websocket-9.0.27.jar:/Users/lance/mavenRepo/org/springframework/boot/spring-boot-starter-validation/2.2.1.RELEASE/spring-boot-starter-validation-2.2.1.RELEASE.jar:/Users/lance/mavenRepo/jakarta/validation/jakarta.validation-api/2.0.1/jakarta.validation-api-2.0.1.jar:/Users/lance/mavenRepo/org/hibernate/validator/hibernate-validator/6.0.18.Final/hibernate-validator-6.0.18.Final.jar:/Users/lance/mavenRepo/org/jboss/logging/jboss-logging/3.4.1.Final/jboss-logging-3.4.1.Final.jar:/Users/lance/mavenRepo/com/fasterxml/classmate/1.5.1/classmate-1.5.1.jar:/Users/lance/mavenRepo/org/springframework/spring-web/5.2.1.RELEASE/spring-web-5.2.1.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/spring-webmvc/5.2.1.RELEASE/spring-webmvc-5.2.1.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/spring-expression/5.2.1.RELEASE/spring-expression-5.2.1.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/cloud/spring-cloud-starter-openfeign/2.2.0.RELEASE/spring-cloud-starter-openfeign-2.2.0.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/cloud/spring-cloud-starter/2.2.0.RELEASE/spring-cloud-starter-2.2.0.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/cloud/spring-cloud-context/2.2.0.RELEASE/spring-cloud-context-2.2.0.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/security/spring-security-rsa/1.0.7.RELEASE/spring-security-rsa-1.0.7.RELEASE.jar:/Users/lance/mavenRepo/org/bouncycastle/bcpkix-jdk15on/1.60/bcpkix-jdk15on-1.60.jar:/Users/lance/mavenRepo/org/bouncycastle/bcprov-jdk15on/1.60/bcprov-jdk15on-1.60.jar:/Users/lance/mavenRepo/org/springframework/cloud/spring-cloud-openfeign-core/2.2.0.RELEASE/spring-cloud-openfeign-core-2.2.0.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/cloud/spring-cloud-netflix-ribbon/2.2.0.RELEASE/spring-cloud-netflix-ribbon-2.2.0.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/cloud/spring-cloud-netflix-archaius/2.2.0.RELEASE/spring-cloud-netflix-archaius-2.2.0.RELEASE.jar:/Users/lance/mavenRepo/io/github/openfeign/form/feign-form-spring/3.8.0/feign-form-spring-3.8.0.jar:/Users/lance/mavenRepo/io/github/openfeign/form/feign-form/3.8.0/feign-form-3.8.0.jar:/Users/lance/mavenRepo/commons-fileupload/commons-fileupload/1.4/commons-fileupload-1.4.jar:/Users/lance/mavenRepo/commons-io/commons-io/2.2/commons-io-2.2.jar:/Users/lance/mavenRepo/org/springframework/cloud/spring-cloud-commons/2.2.0.RELEASE/spring-cloud-commons-2.2.0.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/security/spring-security-crypto/5.2.1.RELEASE/spring-security-crypto-5.2.1.RELEASE.jar:/Users/lance/mavenRepo/io/github/openfeign/feign-core/10.4.0/feign-core-10.4.0.jar:/Users/lance/mavenRepo/io/github/openfeign/feign-slf4j/10.4.0/feign-slf4j-10.4.0.jar:/Users/lance/mavenRepo/io/github/openfeign/feign-hystrix/10.4.0/feign-hystrix-10.4.0.jar:/Users/lance/mavenRepo/com/netflix/archaius/archaius-core/0.7.6/archaius-core-0.7.6.jar:/Users/lance/mavenRepo/com/google/code/findbugs/jsr305/3.0.1/jsr305-3.0.1.jar:/Users/lance/mavenRepo/com/netflix/hystrix/hystrix-core/1.5.18/hystrix-core-1.5.18.jar:/Users/lance/mavenRepo/org/hdrhistogram/HdrHistogram/2.1.9/HdrHistogram-2.1.9.jar:/Users/lance/mavenRepo/mysql/mysql-connector-java/5.1.37/mysql-connector-java-5.1.37.jar:/Users/lance/mavenRepo/com/alibaba/druid-spring-boot-starter/1.1.10/druid-spring-boot-starter-1.1.10.jar:/Users/lance/mavenRepo/com/alibaba/druid/1.1.10/druid-1.1.10.jar:/Users/lance/mavenRepo/org/slf4j/slf4j-api/1.7.29/slf4j-api-1.7.29.jar:/Users/lance/mavenRepo/org/springframework/boot/spring-boot-autoconfigure/2.2.1.RELEASE/spring-boot-autoconfigure-2.2.1.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/boot/spring-boot-starter-aop/2.2.1.RELEASE/spring-boot-starter-aop-2.2.1.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/spring-aop/5.2.1.RELEASE/spring-aop-5.2.1.RELEASE.jar:/Users/lance/mavenRepo/org/aspectj/aspectjweaver/1.9.4/aspectjweaver-1.9.4.jar:/Users/lance/mavenRepo/io/seata/seata-all/1.2.0/seata-all-1.2.0.jar:/Users/lance/mavenRepo/org/springframework/spring-context/5.2.1.RELEASE/spring-context-5.2.1.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/spring-core/5.2.1.RELEASE/spring-core-5.2.1.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/spring-jcl/5.2.1.RELEASE/spring-jcl-5.2.1.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/spring-beans/5.2.1.RELEASE/spring-beans-5.2.1.RELEASE.jar:/Users/lance/mavenRepo/io/netty/netty-all/4.1.43.Final/netty-all-4.1.43.Final.jar:/Users/lance/mavenRepo/com/alibaba/fastjson/1.2.60/fastjson-1.2.60.jar:/Users/lance/mavenRepo/com/typesafe/config/1.2.1/config-1.2.1.jar:/Users/lance/mavenRepo/commons-lang/commons-lang/2.6/commons-lang-2.6.jar:/Users/lance/mavenRepo/org/apache/commons/commons-pool2/2.7.0/commons-pool2-2.7.0.jar:/Users/lance/mavenRepo/commons-pool/commons-pool/1.6/commons-pool-1.6.jar:/Users/lance/mavenRepo/com/google/protobuf/protobuf-java/3.7.1/protobuf-java-3.7.1.jar:/Users/lance/mavenRepo/cglib/cglib/3.1/cglib-3.1.jar:/Users/lance/mavenRepo/org/ow2/asm/asm/4.2/asm-4.2.jar:/Users/lance/mavenRepo/aopalliance/aopalliance/1.0/aopalliance-1.0.jar:/Users/lance/mavenRepo/com/github/ben-manes/caffeine/caffeine/2.8.0/caffeine-2.8.0.jar:/Users/lance/mavenRepo/org/checkerframework/checker-qual/2.10.0/checker-qual-2.10.0.jar:/Users/lance/mavenRepo/com/google/errorprone/error_prone_annotations/2.3.3/error_prone_annotations-2.3.3.jar:/Users/lance/mavenRepo/org/postgresql/postgresql/42.2.8/postgresql-42.2.8.jar:/Users/lance/mavenRepo/org/projectlombok/lombok/1.18.8/lombok-1.18.8.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/sharding-jdbc-core/4.1.0/sharding-jdbc-core-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/shardingsphere-pluggable/4.1.0/shardingsphere-pluggable-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/shardingsphere-sql-parser-binder/4.1.0/shardingsphere-sql-parser-binder-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/shardingsphere-route/4.1.0/shardingsphere-route-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/shardingsphere-common/4.1.0/shardingsphere-common-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/shardingsphere-rewrite-engine/4.1.0/shardingsphere-rewrite-engine-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/shardingsphere-executor/4.1.0/shardingsphere-executor-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/shardingsphere-merge/4.1.0/shardingsphere-merge-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/sharding-transaction-core/4.1.0/sharding-transaction-core-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/shardingsphere-sql-parser-sql92/4.1.0/shardingsphere-sql-parser-sql92-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/shardingsphere-sql-parser-engine/4.1.0/shardingsphere-sql-parser-engine-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/shardingsphere-spi/4.1.0/shardingsphere-spi-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/shardingsphere-sql-parser-spi/4.1.0/shardingsphere-sql-parser-spi-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/shardingsphere-sql-parser-statement/4.1.0/shardingsphere-sql-parser-statement-4.1.0.jar:/Users/lance/mavenRepo/org/apache/commons/commons-collections4/4.2/commons-collections4-4.2.jar:/Users/lance/mavenRepo/org/antlr/antlr4-runtime/4.7.2/antlr4-runtime-4.7.2.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/shardingsphere-sql-parser-mysql/4.1.0/shardingsphere-sql-parser-mysql-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/shardingsphere-sql-parser-postgresql/4.1.0/shardingsphere-sql-parser-postgresql-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/shardingsphere-sql-parser-oracle/4.1.0/shardingsphere-sql-parser-oracle-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/shardingsphere-sql-parser-sqlserver/4.1.0/shardingsphere-sql-parser-sqlserver-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/sharding-core-route/4.1.0/sharding-core-route-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/sharding-core-common/4.1.0/sharding-core-common-4.1.0.jar:/Users/lance/mavenRepo/org/codehaus/groovy/groovy/2.4.5/groovy-2.4.5-indy.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/master-slave-core-route/4.1.0/master-slave-core-route-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/sharding-core-api/4.1.0/sharding-core-api-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/encrypt-core-api/4.1.0/encrypt-core-api-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/sharding-core-rewrite/4.1.0/sharding-core-rewrite-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/encrypt-core-rewrite/4.1.0/encrypt-core-rewrite-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/shadow-core-rewrite/4.1.0/shadow-core-rewrite-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/sharding-core-execute/4.1.0/sharding-core-execute-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/sharding-core-merge/4.1.0/sharding-core-merge-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/encrypt-core-merge/4.1.0/encrypt-core-merge-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/encrypt-core-common/4.1.0/encrypt-core-common-4.1.0.jar:/Users/lance/mavenRepo/com/google/guava/guava/18.0/guava-18.0.jar:/Users/lance/mavenRepo/org/slf4j/jcl-over-slf4j/1.7.29/jcl-over-slf4j-1.7.29.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/sharding-transaction-base-seata-at/4.1.0/sharding-transaction-base-seata-at-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/sharding-jdbc-spring-boot-starter/4.1.0/sharding-jdbc-spring-boot-starter-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/sharding-spring-boot-util/4.1.0/sharding-spring-boot-util-4.1.0.jar:/Users/lance/mavenRepo/org/apache/shardingsphere/sharding-transaction-spring/4.1.0/sharding-transaction-spring-4.1.0.jar:/Users/lance/mavenRepo/com/baomidou/mybatis-plus-boot-starter/3.1.0/mybatis-plus-boot-starter-3.1.0.jar:/Users/lance/mavenRepo/com/baomidou/mybatis-plus/3.1.0/mybatis-plus-3.1.0.jar:/Users/lance/mavenRepo/com/baomidou/mybatis-plus-extension/3.1.0/mybatis-plus-extension-3.1.0.jar:/Users/lance/mavenRepo/com/baomidou/mybatis-plus-core/3.1.0/mybatis-plus-core-3.1.0.jar:/Users/lance/mavenRepo/com/baomidou/mybatis-plus-annotation/3.1.0/mybatis-plus-annotation-3.1.0.jar:/Users/lance/mavenRepo/org/mybatis/mybatis/3.5.0/mybatis-3.5.0.jar:/Users/lance/mavenRepo/com/github/jsqlparser/jsqlparser/1.4/jsqlparser-1.4.jar:/Users/lance/mavenRepo/org/mybatis/mybatis-spring/2.0.0/mybatis-spring-2.0.0.jar:/Users/lance/mavenRepo/org/springframework/boot/spring-boot-starter-jdbc/2.2.1.RELEASE/spring-boot-starter-jdbc-2.2.1.RELEASE.jar:/Users/lance/mavenRepo/com/zaxxer/HikariCP/3.4.1/HikariCP-3.4.1.jar:/Users/lance/mavenRepo/org/springframework/spring-jdbc/5.2.1.RELEASE/spring-jdbc-5.2.1.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/spring-tx/5.2.1.RELEASE/spring-tx-5.2.1.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/cloud/spring-cloud-starter-consul-discovery/2.2.0.RELEASE/spring-cloud-starter-consul-discovery-2.2.0.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/cloud/spring-cloud-starter-consul/2.2.0.RELEASE/spring-cloud-starter-consul-2.2.0.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/cloud/spring-cloud-consul-core/2.2.0.RELEASE/spring-cloud-consul-core-2.2.0.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/cloud/spring-cloud-consul-discovery/2.2.0.RELEASE/spring-cloud-consul-discovery-2.2.0.RELEASE.jar:/Users/lance/mavenRepo/commons-configuration/commons-configuration/1.8/commons-configuration-1.8.jar:/Users/lance/mavenRepo/org/springframework/cloud/spring-cloud-netflix-hystrix/2.2.0.RELEASE/spring-cloud-netflix-hystrix-2.2.0.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/cloud/spring-cloud-starter-netflix-ribbon/2.2.0.RELEASE/spring-cloud-starter-netflix-ribbon-2.2.0.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/cloud/spring-cloud-starter-netflix-archaius/2.2.0.RELEASE/spring-cloud-starter-netflix-archaius-2.2.0.RELEASE.jar:/Users/lance/mavenRepo/com/netflix/ribbon/ribbon/2.3.0/ribbon-2.3.0.jar:/Users/lance/mavenRepo/com/netflix/ribbon/ribbon-transport/2.3.0/ribbon-transport-2.3.0.jar:/Users/lance/mavenRepo/io/reactivex/rxnetty-contexts/0.4.9/rxnetty-contexts-0.4.9.jar:/Users/lance/mavenRepo/io/reactivex/rxnetty-servo/0.4.9/rxnetty-servo-0.4.9.jar:/Users/lance/mavenRepo/javax/inject/javax.inject/1/javax.inject-1.jar:/Users/lance/mavenRepo/io/reactivex/rxnetty/0.4.9/rxnetty-0.4.9.jar:/Users/lance/mavenRepo/com/netflix/ribbon/ribbon-core/2.3.0/ribbon-core-2.3.0.jar:/Users/lance/mavenRepo/com/netflix/ribbon/ribbon-httpclient/2.3.0/ribbon-httpclient-2.3.0.jar:/Users/lance/mavenRepo/commons-collections/commons-collections/3.2.2/commons-collections-3.2.2.jar:/Users/lance/mavenRepo/com/sun/jersey/jersey-client/1.19.1/jersey-client-1.19.1.jar:/Users/lance/mavenRepo/com/sun/jersey/jersey-core/1.19.1/jersey-core-1.19.1.jar:/Users/lance/mavenRepo/javax/ws/rs/jsr311-api/1.1.1/jsr311-api-1.1.1.jar:/Users/lance/mavenRepo/com/sun/jersey/contribs/jersey-apache-client4/1.19.1/jersey-apache-client4-1.19.1.jar:/Users/lance/mavenRepo/com/netflix/servo/servo-core/0.12.21/servo-core-0.12.21.jar:/Users/lance/mavenRepo/com/netflix/netflix-commons/netflix-commons-util/0.3.0/netflix-commons-util-0.3.0.jar:/Users/lance/mavenRepo/com/netflix/ribbon/ribbon-loadbalancer/2.3.0/ribbon-loadbalancer-2.3.0.jar:/Users/lance/mavenRepo/com/netflix/netflix-commons/netflix-statistics/0.1.1/netflix-statistics-0.1.1.jar:/Users/lance/mavenRepo/io/reactivex/rxjava/1.3.8/rxjava-1.3.8.jar:/Users/lance/mavenRepo/org/springframework/cloud/spring-cloud-starter-loadbalancer/2.2.0.RELEASE/spring-cloud-starter-loadbalancer-2.2.0.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/cloud/spring-cloud-loadbalancer/2.2.0.RELEASE/spring-cloud-loadbalancer-2.2.0.RELEASE.jar:/Users/lance/mavenRepo/io/projectreactor/reactor-core/3.3.0.RELEASE/reactor-core-3.3.0.RELEASE.jar:/Users/lance/mavenRepo/org/reactivestreams/reactive-streams/1.0.3/reactive-streams-1.0.3.jar:/Users/lance/mavenRepo/io/projectreactor/addons/reactor-extra/3.3.0.RELEASE/reactor-extra-3.3.0.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/boot/spring-boot-starter-cache/2.2.1.RELEASE/spring-boot-starter-cache-2.2.1.RELEASE.jar:/Users/lance/mavenRepo/org/springframework/spring-context-support/5.2.1.RELEASE/spring-context-support-5.2.1.RELEASE.jar:/Users/lance/mavenRepo/com/stoyanr/evictor/1.0.0/evictor-1.0.0.jar:/Users/lance/mavenRepo/joda-time/joda-time/2.10.5/joda-time-2.10.5.jar:/Users/lance/mavenRepo/ch/qos/logback/logback-classic/1.2.3/logback-classic-1.2.3.jar:/Users/lance/mavenRepo/ch/qos/logback/logback-core/1.2.3/logback-core-1.2.3.jar:/Users/lance/mavenRepo/org/apache/logging/log4j/log4j-to-slf4j/2.12.1/log4j-to-slf4j-2.12.1.jar:/Users/lance/mavenRepo/org/apache/logging/log4j/log4j-api/2.12.1/log4j-api-2.12.1.jar:/Users/lance/mavenRepo/org/slf4j/jul-to-slf4j/1.7.29/jul-to-slf4j-1.7.29.jar:/Users/lance/mavenRepo/com/ecwid/consul/consul-api/1.4.3/consul-api-1.4.3.jar:/Users/lance/mavenRepo/com/google/code/gson/gson/2.8.6/gson-2.8.6.jar:/Users/lance/mavenRepo/org/apache/httpcomponents/httpcore/4.4.12/httpcore-4.4.12.jar:/Users/lance/mavenRepo/org/apache/httpcomponents/httpclient/4.5.10/httpclient-4.5.10.jar:/Users/lance/mavenRepo/commons-codec/commons-codec/1.13/commons-codec-1.13.jar:/Users/lance/mavenRepo/com/alibaba/cloud/spring-cloud-alibaba-seata/2.2.0.RELEASE/spring-cloud-alibaba-seata-2.2.0.RELEASE.jar:/Users/lance/mavenRepo/io/seata/seata-spring-boot-starter/1.2.0/seata-spring-boot-starter-1.2.0.jar com.robotbana.demo.shardingjdbc.mybatisplus.AccountApp
objc[41544]: Class JavaLaunchHelper is implemented in both /Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/bin/java (0x10b53e4c0) and /Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home/jre/lib/libinstrument.dylib (0x10b5b44e0). One of the two will be used. Which one is undefined.
2020-05-13 14:22:28.244  INFO 41544 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'org.springframework.cloud.autoconfigure.ConfigurationPropertiesRebinderAutoConfiguration' of type [org.springframework.cloud.autoconfigure.ConfigurationPropertiesRebinderAutoConfiguration] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v2.2.1.RELEASE)

2020-05-13 14:22:28.409  INFO 41544 --- [           main] c.r.d.s.mybatisplus.AccountApp           : No active profile set, falling back to default profiles: default
2020-05-13 14:22:29.385  INFO 41544 --- [           main] o.s.cloud.context.scope.GenericScope     : BeanFactory id=b75d0b1b-ce64-30e2-95a5-29b947dab60e
2020-05-13 14:22:29.445  INFO 41544 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'io.seata.spring.boot.autoconfigure.SeataAutoConfiguration' of type [io.seata.spring.boot.autoconfigure.SeataAutoConfiguration$$EnhancerBySpringCGLIB$$b2c8d830] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2020-05-13 14:22:29.455  INFO 41544 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'springApplicationContextProvider' of type [io.seata.spring.boot.autoconfigure.provider.SpringApplicationContextProvider] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2020-05-13 14:22:29.478  INFO 41544 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'failureHandler' of type [io.seata.tm.api.DefaultFailureHandlerImpl] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2020-05-13 14:22:29.484  INFO 41544 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'stringToNoneShardingStrategyConfigurationConverter' of type [org.apache.shardingsphere.spring.boot.converter.StringToNoneShardingStrategyConfigurationConverter] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2020-05-13 14:22:29.487  INFO 41544 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'spring.cloud.alibaba.seata-io.seata.spring.boot.autoconfigure.properties.SpringCloudAlibabaConfiguration' of type [io.seata.spring.boot.autoconfigure.properties.SpringCloudAlibabaConfiguration] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2020-05-13 14:22:29.489  INFO 41544 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'seata-io.seata.spring.boot.autoconfigure.properties.SeataProperties' of type [io.seata.spring.boot.autoconfigure.properties.SeataProperties] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2020-05-13 14:22:29.490  INFO 41544 --- [           main] i.s.s.b.a.SeataAutoConfiguration         : Automatically configure Seata
2020-05-13 14:22:29.523  INFO 41544 --- [           main] io.seata.config.FileConfiguration        : The configuration file used is registry.conf
2020-05-13 14:22:29.540  INFO 41544 --- [           main] io.seata.config.ConfigurationFactory     : load Configuration:FileConfiguration$$EnhancerByCGLIB$$862af1eb
2020-05-13 14:22:29.551  INFO 41544 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'configProperties' of type [io.seata.spring.boot.autoconfigure.properties.registry.ConfigProperties] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2020-05-13 14:22:29.553  INFO 41544 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'configFileProperties' of type [io.seata.spring.boot.autoconfigure.properties.registry.ConfigFileProperties] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2020-05-13 14:22:29.556  INFO 41544 --- [           main] io.seata.config.FileConfiguration        : The configuration file used is file.conf
2020-05-13 14:22:29.556  INFO 41544 --- [           main] io.seata.config.ConfigurationFactory     : load Configuration:FileConfiguration$$EnhancerByCGLIB$$862af1eb
2020-05-13 14:22:29.560  INFO 41544 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'serviceProperties' of type [io.seata.spring.boot.autoconfigure.properties.file.ServiceProperties] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2020-05-13 14:22:29.562  INFO 41544 --- [           main] i.s.s.a.GlobalTransactionScanner         : Initializing Global Transaction Clients ... 
2020-05-13 14:22:29.568  INFO 41544 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'threadFactoryProperties' of type [io.seata.spring.boot.autoconfigure.properties.file.ThreadFactoryProperties] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2020-05-13 14:22:29.572  INFO 41544 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'transportProperties' of type [io.seata.spring.boot.autoconfigure.properties.file.TransportProperties] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2020-05-13 14:22:29.651  INFO 41544 --- [           main] i.s.c.r.netty.AbstractRpcRemotingClient  : RpcClientBootstrap has started
2020-05-13 14:22:29.653  INFO 41544 --- [           main] i.s.s.a.GlobalTransactionScanner         : Transaction Manager Client is initialized. applicationId[account-server] txServiceGroup[my_tx_group]
2020-05-13 14:22:29.674  INFO 41544 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'rmProperties' of type [io.seata.spring.boot.autoconfigure.properties.file.RmProperties] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2020-05-13 14:22:29.674  INFO 41544 --- [           main] io.seata.rm.datasource.AsyncWorker       : Async Commit Buffer Limit: 10000
2020-05-13 14:22:29.675  INFO 41544 --- [           main] i.s.rm.datasource.xa.ResourceManagerXA   : ResourceManagerXA init ...
2020-05-13 14:22:29.686  INFO 41544 --- [           main] i.s.c.r.netty.AbstractRpcRemotingClient  : RpcClientBootstrap has started
2020-05-13 14:22:29.688  INFO 41544 --- [           main] i.s.s.a.GlobalTransactionScanner         : Resource Manager is initialized. applicationId[account-server] txServiceGroup[my_tx_group]
2020-05-13 14:22:29.688  INFO 41544 --- [           main] i.s.s.a.GlobalTransactionScanner         : Global Transaction Clients are initialized. 
2020-05-13 14:22:29.729  INFO 41544 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'spring.shardingsphere.sharding-org.apache.shardingsphere.shardingjdbc.spring.boot.sharding.SpringBootShardingRuleConfigurationProperties' of type [org.apache.shardingsphere.shardingjdbc.spring.boot.sharding.SpringBootShardingRuleConfigurationProperties] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2020-05-13 14:22:29.732  INFO 41544 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'spring.shardingsphere.masterslave-org.apache.shardingsphere.shardingjdbc.spring.boot.masterslave.SpringBootMasterSlaveRuleConfigurationProperties' of type [org.apache.shardingsphere.shardingjdbc.spring.boot.masterslave.SpringBootMasterSlaveRuleConfigurationProperties] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2020-05-13 14:22:29.735  INFO 41544 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'spring.shardingsphere.encrypt-org.apache.shardingsphere.shardingjdbc.spring.boot.encrypt.SpringBootEncryptRuleConfigurationProperties' of type [org.apache.shardingsphere.shardingjdbc.spring.boot.encrypt.SpringBootEncryptRuleConfigurationProperties] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2020-05-13 14:22:29.738  INFO 41544 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'spring.shardingsphere.shadow-org.apache.shardingsphere.shardingjdbc.spring.boot.shadow.SpringBootShadowRuleConfigurationProperties' of type [org.apache.shardingsphere.shardingjdbc.spring.boot.shadow.SpringBootShadowRuleConfigurationProperties] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2020-05-13 14:22:29.740  INFO 41544 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'spring.shardingsphere-org.apache.shardingsphere.shardingjdbc.spring.boot.common.SpringBootPropertiesConfigurationProperties' of type [org.apache.shardingsphere.shardingjdbc.spring.boot.common.SpringBootPropertiesConfigurationProperties] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2020-05-13 14:22:30.096  INFO 41544 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'org.apache.shardingsphere.shardingjdbc.spring.boot.SpringBootConfiguration' of type [org.apache.shardingsphere.shardingjdbc.spring.boot.SpringBootConfiguration$$EnhancerBySpringCGLIB$$7cffc12d] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2020-05-13 14:22:30.138  INFO 41544 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'org.springframework.transaction.annotation.ProxyTransactionManagementConfiguration' of type [org.springframework.transaction.annotation.ProxyTransactionManagementConfiguration] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2020-05-13 14:22:30.167  INFO 41544 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'com.alibaba.cloud.seata.feign.SeataFeignClientAutoConfiguration$FeignBeanPostProcessorConfiguration' of type [com.alibaba.cloud.seata.feign.SeataFeignClientAutoConfiguration$FeignBeanPostProcessorConfiguration] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2020-05-13 14:22:30.170  INFO 41544 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'seataFeignObjectWrapper' of type [com.alibaba.cloud.seata.feign.SeataFeignObjectWrapper] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2020-05-13 14:22:30.173  INFO 41544 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'org.springframework.cloud.autoconfigure.ConfigurationPropertiesRebinderAutoConfiguration' of type [org.springframework.cloud.autoconfigure.ConfigurationPropertiesRebinderAutoConfiguration] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2020-05-13 14:22:30.408  INFO 41544 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 8181 (http)
2020-05-13 14:22:30.418  INFO 41544 --- [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
2020-05-13 14:22:30.418  INFO 41544 --- [           main] org.apache.catalina.core.StandardEngine  : Starting Servlet engine: [Apache Tomcat/9.0.27]
2020-05-13 14:22:30.515  INFO 41544 --- [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
2020-05-13 14:22:30.515  INFO 41544 --- [           main] o.s.web.context.ContextLoader            : Root WebApplicationContext: initialization completed in 2079 ms
2020-05-13 14:22:31.072  INFO 41544 --- [           main] com.alibaba.druid.pool.DruidDataSource   : {dataSource-1} inited
2020-05-13 14:22:31.119  INFO 41544 --- [           main] com.alibaba.druid.pool.DruidDataSource   : {dataSource-2} inited
2020-05-13 14:22:31.291  INFO 41544 --- [           main] o.a.s.core.log.ConfigurationLogger       : ShardingRuleConfiguration:
defaultDataSourceName: ds0
defaultDatabaseStrategy:
  inline:
    algorithmExpression: ds$->{user_id % 2}
    shardingColumn: user_id
tables:
  account:
    actualDataNodes: ds$->{0..1}.account_$->{0..1}
    keyGenerator:
      column: user_id
      props:
        worker.id: '1'
      type: SNOWFLAKE
    logicTable: account
    tableStrategy:
      inline:
        algorithmExpression: account_$->{user_id % 2}
        shardingColumn: user_id

2020-05-13 14:22:31.292  INFO 41544 --- [           main] o.a.s.core.log.ConfigurationLogger       : Properties:
sql.show: 'true'
check.table.metadata.enabled: 'false'

2020-05-13 14:22:31.309  INFO 41544 --- [           main] ShardingSphere-metadata                  : Loading 1 logic tables' meta data.
2020-05-13 14:22:31.540  INFO 41544 --- [           main] ShardingSphere-metadata                  : Loading 3 tables' meta data.
2020-05-13 14:22:31.741  INFO 41544 --- [           main] ShardingSphere-metadata                  : Meta data load finished, cost 448 milliseconds.
2020-05-13 14:22:31.758  INFO 41544 --- [           main] io.seata.config.FileConfiguration        : The configuration file used is seata.conf
2020-05-13 14:22:31.824  INFO 41544 --- [           main] i.s.c.r.netty.NettyClientChannelManager  : will connect to 127.0.0.1:8091
2020-05-13 14:22:31.825  INFO 41544 --- [           main] io.seata.core.rpc.netty.RmRpcClient      : RM will register :jdbc:mysql://localhost:13306/seata_account_0
2020-05-13 14:22:31.827  INFO 41544 --- [           main] i.s.core.rpc.netty.NettyPoolableFactory  : NettyPool create channel to transactionRole:RMROLE,address:127.0.0.1:8091,msg:< RegisterRMRequest{resourceIds='jdbc:mysql://localhost:13306/seata_account_0', applicationId='account-server', transactionServiceGroup='my_tx_group'} >
2020-05-13 14:22:32.009  INFO 41544 --- [           main] io.seata.core.rpc.netty.RmRpcClient      : register RM success. server version:1.2.0,channel:[id: 0xf9f49e1b, L:/127.0.0.1:59907 - R:/127.0.0.1:8091]
2020-05-13 14:22:32.072  INFO 41544 --- [           main] i.s.core.rpc.netty.NettyPoolableFactory  : register success, cost 167 ms, version:1.2.0,role:RMROLE,channel:[id: 0xf9f49e1b, L:/127.0.0.1:59907 - R:/127.0.0.1:8091]
2020-05-13 14:22:32.073  INFO 41544 --- [           main] io.seata.core.rpc.netty.RmRpcClient      : will register resourceId:jdbc:mysql://localhost:13306/seata_account_1
2020-05-13 14:22:32.084  INFO 41544 --- [           main] .s.s.a.d.SeataAutoDataSourceProxyCreator : Auto proxy of [shardingDataSource]
2020-05-13 14:22:32.090  INFO 41544 --- [           main] o.s.aop.framework.CglibAopProxy          : Unable to proxy interface-implementing method [public final org.apache.shardingsphere.shardingjdbc.jdbc.core.connection.ShardingConnection org.apache.shardingsphere.shardingjdbc.jdbc.core.datasource.ShardingDataSource.getConnection()] because it is marked as final: Consider using interface-based JDK proxies instead!
2020-05-13 14:22:32.090  INFO 41544 --- [           main] o.s.aop.framework.CglibAopProxy          : Unable to proxy interface-implementing method [public final void org.apache.shardingsphere.shardingjdbc.jdbc.adapter.AbstractDataSourceAdapter.close() throws java.lang.Exception] because it is marked as final: Consider using interface-based JDK proxies instead!
2020-05-13 14:22:32.090  INFO 41544 --- [           main] o.s.aop.framework.CglibAopProxy          : Unable to proxy interface-implementing method [public final java.sql.Connection org.apache.shardingsphere.shardingjdbc.jdbc.adapter.AbstractDataSourceAdapter.getConnection(java.lang.String,java.lang.String) throws java.sql.SQLException] because it is marked as final: Consider using interface-based JDK proxies instead!
2020-05-13 14:22:32.090  INFO 41544 --- [           main] o.s.aop.framework.CglibAopProxy          : Unable to proxy interface-implementing method [public final java.util.logging.Logger org.apache.shardingsphere.shardingjdbc.jdbc.adapter.AbstractDataSourceAdapter.getParentLogger()] because it is marked as final: Consider using interface-based JDK proxies instead!
2020-05-13 14:22:32.090  INFO 41544 --- [           main] o.s.aop.framework.CglibAopProxy          : Unable to proxy interface-implementing method [public final void org.apache.shardingsphere.shardingjdbc.jdbc.unsupported.AbstractUnsupportedOperationDataSource.setLoginTimeout(int) throws java.sql.SQLException] because it is marked as final: Consider using interface-based JDK proxies instead!
2020-05-13 14:22:32.090  INFO 41544 --- [           main] o.s.aop.framework.CglibAopProxy          : Unable to proxy interface-implementing method [public final int org.apache.shardingsphere.shardingjdbc.jdbc.unsupported.AbstractUnsupportedOperationDataSource.getLoginTimeout() throws java.sql.SQLException] because it is marked as final: Consider using interface-based JDK proxies instead!
2020-05-13 14:22:32.091  INFO 41544 --- [           main] o.s.aop.framework.CglibAopProxy          : Unable to proxy interface-implementing method [public final java.lang.Object org.apache.shardingsphere.shardingjdbc.jdbc.adapter.WrapperAdapter.unwrap(java.lang.Class) throws java.sql.SQLException] because it is marked as final: Consider using interface-based JDK proxies instead!
2020-05-13 14:22:32.093  INFO 41544 --- [           main] o.s.aop.framework.CglibAopProxy          : Unable to proxy interface-implementing method [public final boolean org.apache.shardingsphere.shardingjdbc.jdbc.adapter.WrapperAdapter.isWrapperFor(java.lang.Class)] because it is marked as final: Consider using interface-based JDK proxies instead!
 _ _   |_  _ _|_. ___ _ |    _ 
| | |\/|_)(_| | |_\  |_)||_|_\ 
     /               |         
                        3.1.0 
2020-05-13 14:22:32.586  WARN 41544 --- [           main] c.n.c.sources.URLConfigurationSource     : No URLs will be polled as dynamic configuration sources.
2020-05-13 14:22:32.587  INFO 41544 --- [           main] c.n.c.sources.URLConfigurationSource     : To enable URLs as dynamic configuration sources, define System property archaius.configurationSource.additionalUrls or make config.properties available on classpath.
2020-05-13 14:22:32.590  WARN 41544 --- [           main] c.n.c.sources.URLConfigurationSource     : No URLs will be polled as dynamic configuration sources.
2020-05-13 14:22:32.590  INFO 41544 --- [           main] c.n.c.sources.URLConfigurationSource     : To enable URLs as dynamic configuration sources, define System property archaius.configurationSource.additionalUrls or make config.properties available on classpath.
2020-05-13 14:22:32.782  INFO 41544 --- [           main] o.s.s.concurrent.ThreadPoolTaskExecutor  : Initializing ExecutorService 'applicationTaskExecutor'
2020-05-13 14:22:33.453  INFO 41544 --- [           main] o.s.s.c.ThreadPoolTaskScheduler          : Initializing ExecutorService 'catalogWatchTaskScheduler'
2020-05-13 14:22:33.594  INFO 41544 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8181 (http) with context path ''
2020-05-13 14:22:33.607  INFO 41544 --- [           main] o.s.c.c.s.ConsulServiceRegistry          : Registering service with consul: NewService{id='account-server-8181', name='account-server', tags=[secure=false], address='192.168.1.105', meta=null, port=8181, enableTagOverride=null, check=Check{script='null', interval='10s', ttl='null', http='http://192.168.1.105:8181/actuator/health', method='null', header={}, tcp='null', timeout='null', dockerContainerID='null', shell='null', deregisterCriticalServiceAfter='null', tlsSkipVerify=null, status='null'}, checks=null}
2020-05-13 14:22:33.828  INFO 41544 --- [           main] c.r.d.s.mybatisplus.AccountApp           : Started AccountApp in 7.14 seconds (JVM running for 8.398)

```
#### 启动成功后访问接口
postman 访问 这个就不说了 。
说一个 idea自带的 RESTful 
 打开  tools --> HttpClient--> Test Restful WebService
这里贴出图片参数 访问后用默认的库导入应该是会 抛异常回滚。
![请求示例](https://imgconvert.csdnimg.cn/aHR0cHM6Ly91cGxvYWQtaW1hZ2VzLmppYW5zaHUuaW8vdXBsb2FkX2ltYWdlcy8yMjU5MTM1LTM3MWFlZDIxYjM4NDFiZWMucG5n?x-oss-process=image/format,png)


如果不想回滚可以给userId=1 的account表中改amount值
```sql
SELECT * FROM seata_account_1.account_1;

update seata_account_1.account_1 set amount=100 where user_id=1;
```
再次请求则成功