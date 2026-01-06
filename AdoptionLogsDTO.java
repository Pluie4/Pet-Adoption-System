package com.example.pets_adoption.dto;

import com.example.pets_adoption.entity.Adoptions;
import com.example.pets_adoption.entity.Pets;
import com.example.pets_adoption.entity.Users;
import lombok.Data;

/**
 * @description 领养记录
 */
@Data
public class AdoptionLogsDTO extends Adoptions {


    /**
     * 宠物信息
     */
    private Pets pet;

    /**
     * 领养人信息
     */
    private Users user;
}
