package com.robotbana.demo.shardingjdbc.mybatisplus.controller;


import com.robotbana.demo.shardingjdbc.mybatisplus.service.StorageService;
import io.seata.core.context.RootContext;
import java.math.BigDecimal;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/storage")
@Slf4j
public class StorageController {

  @Autowired
  private StorageService storageService;

  /**
   * 扣减库存
   *
   * @param productId 产品id
   * @param count 数量
   */
  @RequestMapping("/decrease")
  public String decrease(@RequestParam("productId") Long productId,
      @RequestParam("count") Integer count) {
    log.info("XID为：{}", RootContext.getXID());
    storageService.decrease(productId, count);
    log.info("XID为：{}", RootContext.getXID());
    return "Decrease storage success";
  }

  @GetMapping(value = "/price")
  public BigDecimal findById(@RequestParam("productId") Long productId) {
    return storageService.findById(productId);
  }

  @PostMapping(value = "/add")
  public String add(Long productId,Integer price) {
    storageService.add(productId,price);
    return "SUCCESS";
  }
}
