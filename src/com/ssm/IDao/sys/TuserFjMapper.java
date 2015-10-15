package com.ssm.IDao.sys;

import com.ssm.model.sys.TuserFj;

public interface TuserFjMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TuserFj record);

    int insertSelective(TuserFj record);

    TuserFj selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TuserFj record);

    int updateByPrimaryKey(TuserFj record);
}