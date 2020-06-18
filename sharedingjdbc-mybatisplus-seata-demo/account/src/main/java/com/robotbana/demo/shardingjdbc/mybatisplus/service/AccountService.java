package com.robotbana.demo.shardingjdbc.mybatisplus.service;

import com.robotbana.demo.shardingjdbc.mybatisplus.entity.Account;
import java.math.BigDecimal;
import java.util.List;

public interface AccountService {

  /**
   * 扣减账户余额
   *
   * @param userId 用户id
   * @param money 金额
   */
  void decrease(Long userId, BigDecimal money);

  void addUser(Account account);

  List<Account> findList();
}
