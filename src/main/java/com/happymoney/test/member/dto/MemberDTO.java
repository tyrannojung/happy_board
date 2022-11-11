package com.happymoney.test.member.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.stereotype.Component;

import java.sql.Date;

@Getter
@Setter
@ToString
@Component("MemberDTO")
public class MemberDTO {

    private int member_idx;
    private String member_id;
    private String member_password;
    private String member_email;
    private String member_name;
    private int member_role;
    private String member_key;
    private Date member_udate;
    private Date member_rdate;

}
