package com.ssm.IDao.sys;

import com.ssm.model.sys.Tdictionarytype;

public interface TdictionarytypeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Tdictionarytype record);

    int insertSelective(Tdictionarytype record);

    Tdictionarytype selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Tdictionarytype record);

    int updateByPrimaryKey(Tdictionarytype record);
}