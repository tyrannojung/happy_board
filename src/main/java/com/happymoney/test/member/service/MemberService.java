package com.happymoney.test.member.service;

import com.happymoney.test.member.dto.MemberDTO;

public interface MemberService {

    public void insertTest(MemberDTO memberDTO);

    public int memberJoinAction(MemberDTO memberDTO);

    public MemberDTO memberInfo(MemberDTO memberDTO);

    public int memberExistCompare(MemberDTO memberDTO);

    public MemberDTO memberFindCheck(MemberDTO memberDTO);

    public int memberPasswordChangeUpdate(MemberDTO memberDTO);

}
