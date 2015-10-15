package com.ssm.IDao.sys;

import com.ssm.model.sys.Tuser;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface TuserMapper {
    /** 用户登录*/
    Tuser LoginQuery(Map params);

    /** 获取用户记录*/
    List<Tuser> selectAll(@Param(value="start")int start,@Param(value="rows")int rows);

    /** 获取用户记录数*/
    int selectCount();
}