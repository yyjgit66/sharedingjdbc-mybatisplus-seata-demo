package com.robotbana.demo.shardingjdbc.mybatisplus.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.robotbana.demo.shardingjdbc.mybatisplus.entity.Order;
import java.math.BigDecimal;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface OrderMapper extends BaseMapper<Order> {

  /**
   * 创建订单
   */
  void create(Order order);

  /**
   * 修改订单金额
   */
  void updateStatus(@Param("userId") Long userId, @Param("money") BigDecimal money,
      @Param("status") Integer status);

  void add(Order order);
}
