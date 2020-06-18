package com.robotbana.demo.shardingjdbc.mybatisplus.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.robotbana.demo.shardingjdbc.mybatisplus.entity.Storage;
import java.math.BigDecimal;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface StorageMapper extends BaseMapper<Storage> {

  /**
   * 扣减库存
   *
   * @param productId 产品id
   * @param count 数量
   */
  void decrease(@Param("productId") Long productId, @Param("count") Integer count);

  BigDecimal findById(Long productId);
}
