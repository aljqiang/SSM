package com.ssm.model.sys;

public class Tdictionary {
    private Integer id;

    private String code;

    private String text;

    private Integer dictionarytypeId;

    private Integer seq;

    private Integer state;

    private Integer isdefault;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code == null ? null : code.trim();
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text == null ? null : text.trim();
    }

    public Integer getDictionarytypeId() {
        return dictionarytypeId;
    }

    public void setDictionarytypeId(Integer dictionarytypeId) {
        this.dictionarytypeId = dictionarytypeId;
    }

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Integer getIsdefault() {
        return isdefault;
    }

    public void setIsdefault(Integer isdefault) {
        this.isdefault = isdefault;
    }
}