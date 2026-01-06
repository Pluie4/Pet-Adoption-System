package com.example.pets_adoption.dto;

import lombok.Data;


@Data
public class AdoptionDTO {
    /**
     * 宠物id
     */
    private  Long petId;

    /**
     * 预约时间
     */
    private String adoptionData;
}
