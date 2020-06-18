package com.robotbana.demo.shardingjdbc.mybatisplus.service;

import com.robotbana.demo.shardingjdbc.mybatisplus.entity.Order;
import java.math.BigDecimal;

public interface OrderService {

    /**
     * 创建订单
     * @return
     */
    void create(Long productId, Long userId, int count);

    /**
     * 修改订单状态
     * @param userId
     * @param money
     * @param status
     */
    void update(Long userId, BigDecimal money, Integer status);

    /**
     * 添加
     * @param order
     */
    void add(Order order);
}
