package com.happymoney.test.member.service.impl;

import com.happymoney.test.member.dto.MemberDTO;
import com.happymoney.test.member.mapper.MemberMapper;
import com.happymoney.test.member.service.MemberService;
import org.springframework.stereotype.Service;

@Service("MemberService")
public class MemberServiceImpl implements MemberService {

    private final MemberMapper memberMapper;

    public MemberServiceImpl(MemberMapper memberMapper) {
        this.memberMapper = memberMapper;
    }

    public void insertTest(MemberDTO memberDTO){
        memberMapper.insertTest(memberDTO);
    }

    public int memberJoinAction(MemberDTO memberDTO){
        return memberMapper.memberJoinAction(memberDTO);
    }

    public MemberDTO memberInfo(MemberDTO memberDTO) {
        return memberMapper.memberInfo(memberDTO);
    }

    public int memberExistCompare(MemberDTO memberDTO){
        return memberMapper.memberExistCompare(memberDTO);
    }

    public MemberDTO memberFindCheck(MemberDTO memberDTO) {
        return memberMapper.memberFindCheck(memberDTO);
    }

    public int memberPasswordChangeUpdate(MemberDTO memberDTO) {
        return memberMapper.memberPasswordChangeUpdate(memberDTO);
    }
}
