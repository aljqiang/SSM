package com.ssm.IDao.sys;

import com.ssm.model.sys.Tdictionary;

public interface TdictionaryMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Tdictionary record);

    int insertSelective(Tdictionary record);

    Tdictionary selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Tdictionary record);

    int updateByPrimaryKey(Tdictionary record);
}