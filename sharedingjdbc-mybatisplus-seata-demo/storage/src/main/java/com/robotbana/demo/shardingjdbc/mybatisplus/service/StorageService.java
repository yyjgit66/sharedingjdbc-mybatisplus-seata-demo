package com.robotbana.demo.shardingjdbc.mybatisplus.service;

import java.math.BigDecimal;

public interface StorageService {

    /**
     * 扣减库存
     * @param productId 产品id
     * @param count 数量
     * @return
     */
    void decrease(Long productId, Integer count);

    /**
     * 增加库存
     * @param productId
     * @param num
     */
    void add(Long productId, Integer num);


    BigDecimal findById(Long productId);
}
