package com.robotbana.demo.shardingjdbc.mybatisplus.feign;

import java.math.BigDecimal;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(value = "storage-server")
public interface StorageFeign {

    /**
     * 扣减库存
     * @param productId
     * @param count
     * @return
     */
    @GetMapping(value = "/storage/decrease")
    String decrease(@RequestParam("productId") Long productId, @RequestParam("count") Integer count);

    @GetMapping(value = "/storage/price")
    BigDecimal findById(@RequestParam("productId") Long productId);
}
