package com.robotbana.demo.shardingjdbc.mybatisplus.entity;


import java.math.BigDecimal;
import lombok.Data;
import lombok.ToString;

/**
 * 订单
 */
@ToString
@Data
public class Order {

    private Long id;

    private Long userId;

    private Long productId;

    private Integer count;

    private BigDecimal money;

    /**订单状态：0：创建中；1：已完结*/
    private Integer status;

    private BigDecimal price;


}
