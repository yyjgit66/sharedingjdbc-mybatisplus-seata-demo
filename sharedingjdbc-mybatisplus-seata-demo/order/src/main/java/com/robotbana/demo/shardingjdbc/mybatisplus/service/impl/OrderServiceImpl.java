package com.robotbana.demo.shardingjdbc.mybatisplus.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.robotbana.demo.shardingjdbc.mybatisplus.entity.Order;
import com.robotbana.demo.shardingjdbc.mybatisplus.feign.AccountFeign;
import com.robotbana.demo.shardingjdbc.mybatisplus.feign.StorageFeign;
import com.robotbana.demo.shardingjdbc.mybatisplus.mapper.OrderMapper;
import com.robotbana.demo.shardingjdbc.mybatisplus.service.OrderService;
import io.seata.core.context.RootContext;
import io.seata.spring.annotation.GlobalTransactional;
import java.math.BigDecimal;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class OrderServiceImpl extends ServiceImpl<OrderMapper, Order> implements OrderService {


  @Autowired
  private StorageFeign storageFeign;

  @Autowired
  private AccountFeign accountFeign;

  /**
   * 创建订单
   *
   * @return
   */
  @Override
  @GlobalTransactional(name="order_tx")
  public void create(Long productId, Long userId, int count) {
    try {
      log.info("------->交易开始");
      BigDecimal price = storageFeign.findById(productId);
      log.info("------->  获取商品单价 {}",price);
      BigDecimal totalAmount =  price.multiply(new BigDecimal(count));
      Order order = new Order();
      order.setCount(count);
      order.setProductId(productId);
      order.setUserId(userId);
      order.setMoney(totalAmount);

      //本地方法
      log.info("------->  创建订单 {}",order);
      baseMapper.create(order);

      //远程方法 扣减库存
      log.info("------->  扣减库存  xid {}",RootContext.getXID());
      storageFeign.decrease(order.getProductId(), order.getCount());

      //远程方法 扣减账户余额

      log.info("------->扣减账户");
      accountFeign.decrease(order.getUserId(), totalAmount);
      log.info("------->扣减账户结束");
     // int i = 1 / 0;
      log.info("------->交易结束");
      log.info("------->XID为：" + RootContext.getXID());
    } catch (Exception e) {
      throw new RuntimeException("事务执行失败，回滚",e);
    }

  }

  /**
   * 修改订单状态
   */
  @Override
  public void update(Long userId, BigDecimal money, Integer status) {
    log.info("修改订单状态，入参为：userId={},money={},status={}", userId, money, status);
    baseMapper.updateStatus(userId, money, status);
  }

  @Override
  public void add(Order order) {
    baseMapper.add(order);
  }
}
