package com.ssm.IDao.sys;

import com.ssm.model.sys.Trole;

public interface TroleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Trole record);

    int insertSelective(Trole record);

    Trole selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Trole record);

    int updateByPrimaryKey(Trole record);
}