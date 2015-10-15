package com.ssm.model.sys;

public class TuserFj {
    private Integer id;

    private Integer userId;

    private String url;

    private String slturl;

    private String wjm;

    private String createtime;

    private String tomcaturl;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public String getSlturl() {
        return slturl;
    }

    public void setSlturl(String slturl) {
        this.slturl = slturl == null ? null : slturl.trim();
    }

    public String getWjm() {
        return wjm;
    }

    public void setWjm(String wjm) {
        this.wjm = wjm == null ? null : wjm.trim();
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime == null ? null : createtime.trim();
    }

    public String getTomcaturl() {
        return tomcaturl;
    }

    public void setTomcaturl(String tomcaturl) {
        this.tomcaturl = tomcaturl == null ? null : tomcaturl.trim();
    }
}