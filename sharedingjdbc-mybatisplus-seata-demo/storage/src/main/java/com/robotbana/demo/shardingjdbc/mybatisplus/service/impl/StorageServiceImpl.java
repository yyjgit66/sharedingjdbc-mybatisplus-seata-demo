package com.robotbana.demo.shardingjdbc.mybatisplus.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.robotbana.demo.shardingjdbc.mybatisplus.entity.Storage;
import com.robotbana.demo.shardingjdbc.mybatisplus.mapper.StorageMapper;
import com.robotbana.demo.shardingjdbc.mybatisplus.service.StorageService;
import io.seata.core.context.RootContext;
import java.math.BigDecimal;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class StorageServiceImpl extends ServiceImpl<StorageMapper, Storage> implements
    StorageService {


  /**
   * 扣减库存
   *
   * @param productId 产品id
   * @param count 数量
   */
  @Override
  public void decrease(Long productId, Integer count) {
    String xid = RootContext.getXID();
    log.info("------->扣减库存开始,xid:{}", xid);
    baseMapper.decrease(productId, count);
    log.info("------->扣减库存结束");
  }

  @Override
  public BigDecimal findById(Long productId) {
    return baseMapper.findById(productId);
  }

  @Override
  public void add(Long productId, Integer price) {
    Storage storage = new Storage();
    storage.setPrice(BigDecimal.valueOf(price));
    storage.setProductId(productId);
    baseMapper.insert(storage);
  }
}
