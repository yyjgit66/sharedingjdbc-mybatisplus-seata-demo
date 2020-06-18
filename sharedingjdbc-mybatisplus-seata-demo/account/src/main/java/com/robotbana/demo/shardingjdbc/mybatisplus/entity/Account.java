package com.robotbana.demo.shardingjdbc.mybatisplus.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.math.BigDecimal;
import lombok.Data;

@Data
public class Account {


    private Long id;
    /**用户id*/
    @TableId(type = IdType.ID_WORKER)
    private Long userId;

    /**总额度*/
    private BigDecimal amount;

}
