package com.robotbana.demo.shardingjdbc.mybatisplus.controller;

import com.alibaba.fastjson.JSON;
import com.robotbana.demo.shardingjdbc.mybatisplus.entity.Account;
import com.robotbana.demo.shardingjdbc.mybatisplus.service.AccountService;
import java.math.BigDecimal;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/account")
public class AccountController {

  @Autowired
  private AccountService accountService;

  @RequestMapping("/add")
  public String addUser(Account account){

    accountService.addUser(account);
    return "add successfully";
  }

  @RequestMapping("/decrease")
  public String decrease(Long userId, BigDecimal money){
    accountService.decrease(userId,money);
    return "success";
  }

  @ResponseBody
  @RequestMapping("/list")
  public String queryList(){
    List<Account> list = accountService.findList();
    return JSON.toJSONString(list);
  }
}
