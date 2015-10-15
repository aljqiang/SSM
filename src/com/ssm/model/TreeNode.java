package com.ssm.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class TreeNode implements Serializable {
    private static final long serialVersionUID = 2235783844919124916L;
    private String id;
    private String text;
    private String iconCls;  // 菜单图标
    private Attributes attributes;
    private String parentid;
    private List<TreeNode> children;

    public TreeNode() {
    }

    public TreeNode(Integer id, String text, String iconCls, String url, Integer parentid) {
        this.id = id.toString();
        this.text = text;
        this.iconCls = iconCls;
        this.attributes = new Attributes();
        this.attributes.setUrl(url);
        this.parentid = parentid.toString();
    }

    public void addChild(TreeNode child) {
        if (this.children == null) {
            this.children = new ArrayList<TreeNode>();
        }
        this.children.add(child);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getIconCls() {
        return iconCls;
    }

    public void setIconCls(String iconCls) {
        this.iconCls = iconCls;
    }

    public Attributes getAttributes() {
        return attributes;
    }

    public void setAttributes(Attributes attributes) {
        this.attributes = attributes;
    }

    public String getParentid() {
        return parentid;
    }

    public void setParentid(String parentid) {
        this.parentid = parentid;
    }

    public List<TreeNode> getChildren() {
        return children;
    }

    public void setChildren(List<TreeNode> children) {
        this.children = children;
    }

}
