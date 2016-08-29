package com.ssm.sendMail;

/**
 * 管理邮件发送的类，在本系统中属于从下向上数的第二层
 * User: Larry
 * Date: 2016-01-13
 * Time: 10:19
 * Version: 1.0
 */

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;

public class SendManager {
    /* Standard input stream */
    private BufferedReader stdIn =
            new BufferedReader(new InputStreamReader(System.in));

    private String mailbody = "";
    private String subject = "";

    //附件
    private ArrayList<String> files = new ArrayList<String>();

    private String strSmtpHost = "";    // 邮件发送服务器
    private int intSmtpPort = -1;        // 邮件发送服务器端口号
    private String username = "";        // 登陆发送服务器的用户名
    private String password = "";        // 登陆发送服务器的密码
    private String addressFrom = "";    // 发送邮箱

    private String addressTo = "";        // 接收邮箱
    private String addressCopy = "";    // 抄送邮箱
    private String addressDarkCopy = "";// 暗送邮箱

    private SendingEmail email = null;

    private boolean isNeedAuth = false;
    private boolean isNeedNotification = false; // 发送的邮件是否需要加上已读回执

    /**
     * 加入附件文件
     * @param filename - 附件名称
     * @return
     */
    public boolean setAttachment(String filename) {
        if (filename == null || filename.length() == 0) {
            return false;
        } else {
            this.files.add(filename);
            return true;
        }
    }

    /**
     * 设置邮件参数
     */
    public void setArguments() {

        email = new SendingEmail(strSmtpHost, intSmtpPort, username, password, addressFrom, addressTo);
        email.setAddressCopy(addressCopy);
        email.setAddressDarkCopy(addressDarkCopy);
        email.setNeedAuth(isNeedAuth);
        email.setMailbody(mailbody);
        email.setSubject(subject);
        email.setAttachments(files);
        email.setNeedNotification(isNeedNotification);
    }

    /**
     * 发送邮件
     */
    public void sendMail() {

        /**
         * 必须操作
         */
        //设置邮件发送服务器
        if (email.configSmtpHost() == false)
            return;
        //生成MIME对象
        if (email.createMimeMessage() == false)
            return;
        //设置邮件发送是否需要身份认证
        if (email.setAuthentication() == false)
            return;
        // 设置邮件接收地址
        if (email.setTo() == false)
            return;
        // 设置邮件发送地址
        if (email.setFrom() == false)
            return;
        if (email.setNotification() == false)
            return;
        /**
         * 可选操作
         */
        // 设置邮件抄送地址
        if (email.getAddressCopy() != null && email.getAddressCopy().length() > 0) {
            if (email.setCopyTo() == false)
                return;
        }
        // 设置邮件暗送地址
        if (email.getAddressDarkCopy() != null && email.getAddressDarkCopy().length() > 0) {
            if (email.setDarkCopyTo() == false)
                return;
        }
        // 设置邮件主题
        if (email.getSubject() != null && email.getSubject().length() > 0) {
            if (email.setEmailSubject() == false)
                return;
        } else {
            try {
                System.out.println("您的邮件没有设置邮件主题，要继续吗(y/n)");
                if (!stdIn.readLine().equalsIgnoreCase("y"))
                    return;
            } catch (Exception e) {
                System.out.println(e.getMessage());
                return;
            }
        }
        // 设置邮件正文
        if (email.getMailbody() != null && email.getMailbody().length() > 0) {
            if (email.setEmailbody() == false)
                return;
        } else {
            try {
                System.out.println("您的邮件没有任何正文内容，要继续吗(y/n)");
                if (!stdIn.readLine().equalsIgnoreCase("y"))
                    return;
            } catch (Exception e) {
                System.out.println(e.getMessage());
                return;
            }
        }
        // 设置邮件附件
        if (email.getAttachments() != null && email.getAttachments().size() > 0) {
            if (email.addAttachment() == false)
                return;
        }
        // 发送邮件
        if (email.sendUp() == false)
            return;
    }

    public String getMailbody() {
        return mailbody;
    }

    public void setMailbody(String mailbody) {
        this.mailbody = mailbody;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getStrSmtpHost() {
        return strSmtpHost;
    }

    public void setStrSmtpHost(String strSmtpHost) {
        this.strSmtpHost = strSmtpHost;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddressFrom() {
        return addressFrom;
    }

    public void setAddressFrom(String addressFrom) {
        this.addressFrom = addressFrom;
    }

    public String getAddressTo() {
        return addressTo;
    }

    public void setAddressTo(String addressTo) {
        this.addressTo = addressTo;
    }

    public String getAddressCopy() {
        return addressCopy;
    }

    public void setAddressCopy(String addressCopy) {
        this.addressCopy = addressCopy;
    }

    public String getAddressDarkCopy() {
        return addressDarkCopy;
    }

    public void setAddressDarkCopy(String addressDarkCopy) {
        this.addressDarkCopy = addressDarkCopy;
    }

    public boolean isNeedAuth() {
        return isNeedAuth;
    }

    public void setNeedAuth(boolean isNeedAuth) {
        this.isNeedAuth = isNeedAuth;
    }

    public int getIntSmtpPort() {
        return intSmtpPort;
    }

    public void setIntSmtpPort(int intSmtpPort) {
        this.intSmtpPort = intSmtpPort;
    }

    public boolean isNeedNotification() {
        return isNeedNotification;
    }

    public void setNeedNotification(boolean isNeedNotification) {
        this.isNeedNotification = isNeedNotification;
    }
}
