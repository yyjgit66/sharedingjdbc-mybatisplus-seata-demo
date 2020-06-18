package com.robotbana.demo.shardingjdbc.mybatisplus.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.robotbana.demo.shardingjdbc.mybatisplus.entity.Account;
import com.robotbana.demo.shardingjdbc.mybatisplus.mapper.AccountMapper;
import com.robotbana.demo.shardingjdbc.mybatisplus.service.AccountService;
import io.seata.core.context.RootContext;
import java.math.BigDecimal;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class AccountServiceImpl extends ServiceImpl<AccountMapper, Account> implements
    AccountService {


  /**
   * 扣减账户余额
   *
   * @param userId 用户id
   * @param money 金额
   */
  @Override
  public void decrease(Long userId, BigDecimal money) {
    String xid = RootContext.getXID();
    log.info("------->扣减账户开始account中,xid:{}", xid);
    BigDecimal amount = baseMapper.findByUserId(userId);
    log.info("------->扣减账户开始amount {},money {},result {},xid:{}", amount, money,
        amount.compareTo(money), xid);
    if (amount.compareTo(money) < 0) {
      throw new RuntimeException("账户余额不足");
    }
    baseMapper.decrease(userId, money);
    log.info("------->扣减账户结束account中");

  }

  @Override
  public void addUser(Account account) {

    baseMapper.insertAccount(account);
  }

  @Override
  public List<Account> findList() {

    return baseMapper.selectList(null);
  }
}
