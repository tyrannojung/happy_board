package com.happymoney.test.board.service.impl;

import com.happymoney.test.board.dto.BoardDTO;
import com.happymoney.test.board.mapper.BoardMapper;
import com.happymoney.test.board.service.BoardService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("BoardService")
public class BoardServiceImpl implements BoardService {

    private final BoardMapper boardMapper;

    public BoardServiceImpl(BoardMapper boardMapper) {
        this.boardMapper = boardMapper;
    }


    public List<BoardDTO> boardList(BoardDTO boardDTO) {
        return boardMapper.boardList(boardDTO);
    }

    public int boardListCount(BoardDTO boardDTO) {
        return boardMapper.boardListCount(boardDTO);
    }

    public BoardDTO boardDetail(BoardDTO boardDTO) {
        return boardMapper.boardDetail(boardDTO);
    }

    public int boardCreateAction(BoardDTO boardDTO) {
        return boardMapper.boardCreateAction(boardDTO);
    }

    public int boardUpdateAction(BoardDTO boardDTO) {
        return boardMapper.boardUpdateAction(boardDTO);
    }

    public int boardDeleteAction(BoardDTO boardDTO) {
        return boardMapper.boardDeleteAction(boardDTO);
    }

}
