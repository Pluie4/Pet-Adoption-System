package com.example.pets_adoption.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
import java.time.LocalDate;


@Data
@EqualsAndHashCode(callSuper = false)
public class Adoptions implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 领养记录id
     */
    @TableId(value = "ado_id", type = IdType.AUTO)
    private Long adoId;

    /**
     * 领养人id
     */
    private Long userId;

    /**
     * 宠物id
     */
    private Long petId;

    /**
     * 领养时间
     */
    private LocalDate adoDate;

    /**
     * 领养状态：0失败，1成功，2处理中
     */
    private Integer adoStatus;

    /**
     * 备注信息，领养情况
     */
    private String adoNote;

}
