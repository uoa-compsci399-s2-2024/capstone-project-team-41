package com.capstone.group41.remind.mate.models.dto;

import lombok.Getter;
import lombok.Setter;

public class FcmDTO {
    @Getter @Setter
    private String userId;

    @Getter @Setter
    private String fcmToken;
}
