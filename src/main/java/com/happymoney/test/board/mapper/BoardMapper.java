package com.happymoney.test.board.mapper;

import com.happymoney.test.board.dto.BoardDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {

    public List<BoardDTO> boardList(BoardDTO boardDTO);

    public int boardListCount(BoardDTO boardDTO);

    public BoardDTO boardDetail(BoardDTO boardDTO);

    public int boardCreateAction(BoardDTO boardDTO);

    public int boardUpdateAction(BoardDTO boardDTO);

    public int boardDeleteAction(BoardDTO boardDTO);

}
