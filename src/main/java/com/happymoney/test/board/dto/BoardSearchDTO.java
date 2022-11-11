package com.happymoney.test.board.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.stereotype.Component;

import java.sql.Date;

@Getter
@Setter
@ToString
@Component("BoardSearchDTO")
public class BoardSearchDTO {

    private String search_subject;
    private String search_content;
    private Date search_start_date;
    private Date search_end_date;
}
