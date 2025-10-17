package com.sg.nusiss.gamevaultmicobackendwc.dto.shopping;

import lombok.Data;

@Data
public class UserProfileDTO {
    private Long uid;
    private String username;
    private String email;
    private String avatar;
}
