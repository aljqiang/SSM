package com.ssm.IDao.sys;

import com.ssm.model.sys.Torganization;

public interface TorganizationMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Torganization record);

    int insertSelective(Torganization record);

    Torganization selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Torganization record);

    int updateByPrimaryKey(Torganization record);
}