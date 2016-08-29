package com.ssm.sendMail;

import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;

/**
 * 替换word文件里面的字符，将word文件里面的特殊字符替换成发送的邀请人的姓名
 * User: Larry
 * Date: 2016-01-13
 * Time: 10:19
 * Version: 1.0
 */

public class ReplaceWord {

    private String docPath = "";    // 要处理的word文件的路径
    private String docSaveAsPath = "";    // 处理后的文件另存为的路径(如果路径为空，则替换原有文件)
    private String strFind = "";    // 要查找的关键字
    private String strReplace = "";    // 要替换的关键字

    public ReplaceWord(String docPath, String docSaveAsPath, String strFind, String strReplace) {
        this.setDocPath(docPath);
        this.setDocSaveAsPath(docSaveAsPath);
        this.setStrFind(strFind);
        this.setStrReplace(strReplace);
    }

    public ReplaceWord() {

    }

    public boolean replace() {
        boolean returnFlag = false;
        ActiveXComponent app = new ActiveXComponent("Word.Application"); // 启动word
        String inFile = this.getDocPath(); // 要替换的word文件
        try {
            app.setProperty("Visible", new Variant(false)); // 设置word不可见
            Dispatch docs = app.getProperty("Documents").toDispatch();
            Dispatch doc = Dispatch.invoke(
                    docs,
                    "Open",
                    Dispatch.Method,
                    new Object[]{inFile,
                            new Variant(false),
                            new Variant(true)},    // 以只读方式打开word
                    new int[1]).toDispatch();

            Dispatch selection = app.getProperty("Selection").toDispatch();// 获得对Selection组件
            Dispatch.call(selection, "HomeKey", new Variant(6));// 移到开头
            Dispatch find = Dispatch.call(selection, "Find").toDispatch();// 获得Find组件
            Dispatch.put(find, "Text", this.getStrFind()); // 查找字符串
            Dispatch.call(find, "Execute"); // 执行查询
            Dispatch.put(selection, "Text", this.getStrReplace()); // 替换字符串

            if (this.getDocSaveAsPath() == null || this.getDocSaveAsPath().length() == 0) {
                Dispatch.call(doc, "Save"); // 保存文件
            } else {
                Dispatch.call(doc, "SaveAs", this.getDocSaveAsPath()); // 文件另存为
            }
            //close document without saving changes
            // 0 = wdDoNotSaveChanges
            //-1 = wdSaveChanges
            //-2 = wdPromptToSaveChanges
            Dispatch.call(doc, "Close", new Variant(0));
            returnFlag = true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            returnFlag = false;
        } finally {
            app.invoke("Quit", new Variant[]{});
            app.safeRelease();
        }

        return returnFlag;
    }


    public String getDocPath() {
        return docPath;
    }


    public void setDocPath(String docPath) {
        this.docPath = docPath;
    }


    public String getDocSaveAsPath() {
        return docSaveAsPath;
    }


    public void setDocSaveAsPath(String docSaveAsPath) {
        this.docSaveAsPath = docSaveAsPath;
    }


    public String getStrFind() {
        return strFind;
    }


    public void setStrFind(String strFind) {
        this.strFind = strFind;
    }


    public String getStrReplace() {
        return strReplace;
    }


    public void setStrReplace(String strReplace) {
        this.strReplace = strReplace;
    }


}
