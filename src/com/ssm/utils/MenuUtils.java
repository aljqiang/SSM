package com.ssm.utils;

import com.ssm.model.TreeNode;
import com.ssm.model.sys.Tresource;
import org.apache.log4j.Logger;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MenuUtils {

    private static Logger log= Logger.getLogger(MenuUtils.class);

    public static String buildMenus(List<Tresource> menuList) {

        if (menuList == null) {
            return null;
        }
        List<TreeNode> nodeList = new ArrayList<TreeNode>();
        for (Tresource m : menuList) {

            TreeNode treeNode = new TreeNode(m.getId(), m.getName(),m.getIcon(), m.getUrl(), m.getPid());
            nodeList.add(treeNode);
        }
        Map<String, TreeNode> map = new HashMap<String, TreeNode>();
        for (TreeNode node : nodeList) {
            map.put(node.getId(), node);
        }
        List<TreeNode> ret = new ArrayList<TreeNode>();
        for (TreeNode node : nodeList) {
            String id = node.getId();
            String parentid = node.getParentid();
            if (parentid.compareTo(id) == 0) {
                ret.add(node);
            } else {
                TreeNode parentNode = (TreeNode) map.get(parentid);
                if (parentNode == null) {
                    throw new RuntimeException(String.format("节点%s的父节点%s没找到", node.getId(), parentid));
                }
                parentNode.addChild(node);
            }
        }

        return createHtml(ret);
    }

    private static String createHtml(List<TreeNode> list) {
        String result = "";
        String menu = "<div title=\"%s\" iconCls=\"%s\"  style=\"padding:10px;\"><ul class=\"easyui-tree\" data-options='data:%s'></ul></div>";
        for (TreeNode o : list) {
            result = result + String.format(menu, new Object[]{o.getText(),o.getIconCls(),JsonUtil.toJSONString(o.getChildren())});
        }
        return result;
    }
}
