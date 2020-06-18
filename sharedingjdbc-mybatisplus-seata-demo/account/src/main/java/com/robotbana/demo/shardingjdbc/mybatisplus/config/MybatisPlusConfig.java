package com.robotbana.demo.shardingjdbc.mybatisplus.config;

import com.baomidou.mybatisplus.core.incrementer.IKeyGenerator;
import com.baomidou.mybatisplus.extension.incrementer.H2KeyGenerator;
import com.baomidou.mybatisplus.extension.plugins.PerformanceInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @description: Mybatis-Plus配置
 */
@Configuration
public class MybatisPlusConfig {

  /**
   * mybatis-plus SQL执行效率插件【生产环境可以关闭】
   */
  @Bean
  public PerformanceInterceptor performanceInterceptor() {
    return new PerformanceInterceptor();
  }

  /**
   * mybatis-plus分页插件<br>
   * 文档：http://mp.baomidou.com<br>
   */


  /**
   * 注入主键生成器
   */
  @Bean
  public IKeyGenerator keyGenerator() {
    return new H2KeyGenerator();
  }

}