package com.happymoney.test.member.mapper;

import com.happymoney.test.member.dto.MemberDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {
    public void insertTest(MemberDTO memberDTO);

    public int memberJoinAction(MemberDTO memberDTO);

    public MemberDTO memberInfo(MemberDTO memberDTO);

    public int memberExistCompare(MemberDTO memberDTO);

    public MemberDTO memberFindCheck(MemberDTO memberDTO);

    public int memberPasswordChangeUpdate(MemberDTO memberDTO);

}
