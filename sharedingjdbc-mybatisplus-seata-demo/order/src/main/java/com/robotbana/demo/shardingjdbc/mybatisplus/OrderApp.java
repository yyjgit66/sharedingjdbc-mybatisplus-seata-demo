package com.robotbana.demo.shardingjdbc.mybatisplus;

import com.alibaba.druid.spring.boot.autoconfigure.DruidDataSourceAutoConfigure;
import com.baomidou.mybatisplus.autoconfigure.MybatisPlusAutoConfiguration;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;

@MapperScan({"com.robotbana.demo.shardingjdbc.mybatisplus.mapper"})
@EnableDiscoveryClient
@EnableFeignClients
@EnableConfigurationProperties
@SpringBootApplication(exclude = {
    DruidDataSourceAutoConfigure.class,
    DataSourceAutoConfiguration.class,
    MybatisPlusAutoConfiguration.class
})
public class OrderApp {
  public static void main(String[] args) {
    SpringApplication.run(OrderApp.class, args);
  }
}
