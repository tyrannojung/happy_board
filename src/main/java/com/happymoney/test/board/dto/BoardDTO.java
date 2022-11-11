package com.happymoney.test.board.dto;

import com.happymoney.test.member.dto.MemberDTO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.stereotype.Component;

import java.sql.Date;

@Getter
@Setter
@ToString
@Component("BoardDTO")
public class BoardDTO {
    private int board_idx;
    private int member_idx;
    private String board_title;
    private String board_content;
    private Date board_udate;
    private Date board_rdate;

    /** Member DTO**/
    private MemberDTO memberDTO;

    /** Board Search **/
    private BoardSearchDTO boardSearchDTO;

    /** Board Paging 추후 리팩토링 **/
    private int pageStartNum;
    private int pageNemPer;
}
