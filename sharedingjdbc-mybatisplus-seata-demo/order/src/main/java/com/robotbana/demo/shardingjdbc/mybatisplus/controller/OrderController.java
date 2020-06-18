package com.robotbana.demo.shardingjdbc.mybatisplus.controller;

import com.robotbana.demo.shardingjdbc.mybatisplus.entity.Order;
import com.robotbana.demo.shardingjdbc.mybatisplus.service.OrderService;
import java.math.BigDecimal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/order")
public class OrderController {

  @Autowired
  private OrderService orderServiceImpl;

  /**
   * 创建订单
   */
  @GetMapping("/create")
  public String create(
      @RequestParam("productId") Long productId,
      @RequestParam("userId") Long userId,
      @RequestParam("buyCount") int count
  ) {
    orderServiceImpl.create(productId, userId, count);
    return "create order successfully";
  }

  /**
   * 修改订单状态
   */
  @RequestMapping("/update")
  public String update(@RequestParam("userId") Long userId, @RequestParam("money") BigDecimal money,
      @RequestParam("status") Integer status) {
    orderServiceImpl.update(userId, money, status);
    return "update order status successfully";
  }
  @RequestMapping("/add")
  public String add(Order order){

    orderServiceImpl.add(order);
    return "success";
  }

}
