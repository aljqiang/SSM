package com.ssm.IDao.sys;

import com.ssm.model.sys.Torganization;

import java.util.List;
import java.util.Map;

public interface TorganizationMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Torganization record);

    int insertSelective(Torganization record);

    Torganization selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Torganization record);

    int updateByPrimaryKey(Torganization record);

    /**
     * 获取组织机构
     */
    List<Torganization> getOrgTree(Map params);
}