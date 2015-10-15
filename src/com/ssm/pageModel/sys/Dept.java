package com.ssm.pageModel.sys;

import org.apache.log4j.Logger;

/**
 * User: test
 * Date: 2015-08-17
 * Time: 10:13
 * Version: 1.0
 */

public class Dept implements java.io.Serializable {

    private static final long serialVersionUID = -582774156698070595L;

    private static Logger log= Logger.getLogger(Dept.class);

    private long id;
    private String dept_name;
    private Integer level_id;
    private Integer status;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getDept_name() {
        return dept_name;
    }

    public void setDept_name(String dept_name) {
        this.dept_name = dept_name;
    }

    public Integer getLevel_id() {
        return level_id;
    }

    public void setLevel_id(Integer level_id) {
        this.level_id = level_id;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
