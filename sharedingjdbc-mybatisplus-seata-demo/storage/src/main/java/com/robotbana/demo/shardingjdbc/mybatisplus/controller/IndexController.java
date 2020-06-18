package com.robotbana.demo.shardingjdbc.mybatisplus.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class IndexController {

  @RequestMapping("/actuator/health")
  public String index(){

    return "success";
  }
}
