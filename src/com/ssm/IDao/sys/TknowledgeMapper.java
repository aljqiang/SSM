package com.ssm.IDao.sys;

import com.ssm.model.sys.Tknowledge;

public interface TknowledgeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Tknowledge record);

    int insertSelective(Tknowledge record);

    Tknowledge selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Tknowledge record);

    int updateByPrimaryKey(Tknowledge record);
}