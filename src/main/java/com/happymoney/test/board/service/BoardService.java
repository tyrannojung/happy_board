package com.happymoney.test.board.service;

import com.happymoney.test.board.dto.BoardDTO;

import java.util.List;

public interface BoardService {

    public List<BoardDTO> boardList(BoardDTO boardDTO);

    public int boardListCount(BoardDTO boardDTO);

    public BoardDTO boardDetail(BoardDTO boardDTO);

    public int boardCreateAction(BoardDTO boardDTO);

    public int boardUpdateAction(BoardDTO boardDTO);

    public int boardDeleteAction(BoardDTO boardDTO);

}
