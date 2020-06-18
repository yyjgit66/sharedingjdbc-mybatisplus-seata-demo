package com.robotbana.demo.shardingjdbc.mybatisplus.entity;

import java.math.BigDecimal;
import lombok.Data;

@Data
public class Storage {

    private Long id;

    /**产品id*/
    private Long productId;

    /**库存数量*/
    private Integer total;

    private BigDecimal price;

}
