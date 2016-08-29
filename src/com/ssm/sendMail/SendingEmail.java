package com.ssm.sendMail;

/**
 * 发送email的最底层的类，提供了发送email的一切的基础功能
 * User: Larry
 * Date: 2016-01-13
 * Time: 10:19
 * Version: 1.0
 */

import java.security.Security;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

public class SendingEmail {

    private MimeMessage mimeMessage;    // MIME邮件对象
    private Multipart multipart;        // Multipart对象,邮件内容,标题,附件等内容均添加到其中后再生成MimeMessage对象
    private Session session;            // 邮件会话对象
    private Properties properties;        // 系统属性

    private String strSmtpHost = "";    // 邮件发送服务器
    private int intSmtpPort = -1;        // 邮件发送服务器端口号
    private String username = "";        // 登陆发送服务器的用户名
    private String password = "";        // 登陆发送服务器的密码
    private String addressFrom = "";    // 发送邮箱

    private Address address[];            // 邮件地址列表
    private String addressTo = "";        // 接收邮箱
    private String addressCopy = "";    // 抄送邮箱
    private String addressDarkCopy = "";// 暗送邮箱
    private boolean to_flag = false;
    private boolean cc_flag = false;
    private boolean bcc_flag = false;

    private boolean isNeedAuth = false; // smtp服务器是否需要认证
    private boolean isNeedNotification = false; // 发送的邮件是否需要加上已读回执

    private String mailbody = "";        // 邮件正文
    private String subject = "";        // 邮件主题
    private ArrayList<String> attachments;    // 邮件附件列表

    /**
     * 邮件发送类的构造函数
     * @param smtpHost    - 邮件发送服务器
     * @param username    - 登陆发送服务器的用户名
     * @param password    - 登陆发送服务器的密码
     * @param from        - 发送邮箱
     * @param to        - 接收邮箱
     * @param copy        - 抄送邮箱
     */
    public SendingEmail(String smtpHost, int port, String username, String password, String from, String to, String copy) {
        this.setStrSmtpHost(smtpHost);
        this.setIntSmtpPort(port);
        this.setUsername(username);
        this.setPassword(password);
        this.setAddressFrom(from);
        this.setAddressTo(to);
        this.setAddressCopy(copy);
    }

    /**
     * 不带任何参数的空构造函数
     */
    public SendingEmail() {

    }

    /**
     * 不带设置抄送地址的构造函数
     */
    public SendingEmail(String smtpHost, int port, String username, String password, String from, String to) {
        this.setStrSmtpHost(smtpHost);
        this.setIntSmtpPort(port);
        this.setUsername(username);
        this.setPassword(password);
        this.setAddressFrom(from);
        this.setAddressTo(to);
    }

    /**
     * 设置邮件发送服务器地址和端口号(如果有的话)
     * @return 设置成功返回true，否则返回false
     */
    public boolean configSmtpHost() {

        Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
        final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";

        //System.out.println("设置邮件发送服务器：mail.smtp.host = " + this.getStrSmtpHost());
        try {
            if (this.getProperties() == null)
                this.setProperties(System.getProperties()); // 获得系统属性对象
            if (this.getStrSmtpHost().equalsIgnoreCase("smtp.gmail.com")) {
                // 设置SMTP主机(gmail的话需要SSL，所以如下设置)
                this.getProperties().setProperty("mail.smtp.host", this.getStrSmtpHost());
                this.getProperties().setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);
                this.getProperties().setProperty("mail.smtp.socketFactory.fallback", "false");
                // 设置SMTP主机端口号
                int port = this.getIntSmtpPort();
                if (port >= 0 && port <= 65535) {
                    this.getProperties().setProperty("mail.smtp.port", String.valueOf(port));
                }
                this.getProperties().setProperty("mail.smtp.socketFactory.port", "465");
            } else {
                this.getProperties().setProperty("mail.smtp.host", this.getStrSmtpHost());
            }

            return true;
        } catch (Exception e) {
            System.err.println("设置邮件发送服务器时发生错误！" + e);
            return false;
        }
    }

    /**
     * 获取邮件会话对象，创建MIME邮件对象
     * @return 设置成功返回true，否则返回false
     */
    public boolean createMimeMessage() {
        try {
            //System.out.println("正在获取邮件会话对象！");
            this.setSession(Session.getDefaultInstance(this.getProperties(), null)); // 获得邮件会话对象
        } catch (Exception e) {
            System.err.println("获取邮件会话对象时发生错误！" + e);
            return false;
        }

        //System.out.println("正在创建MIME邮件对象！");
        try {
            this.mimeMessage = new MimeMessage(session); // 创建MIME邮件对象
            this.multipart = new MimeMultipart();

            return true;
        } catch (Exception e) {
            System.err.println("创建MIME邮件对象失败！" + e);
            return false;
        }
    }

    /**
     * 设置邮件发送服务器是否需要身份认证
     * @return 设置成功返回true，否则返回false
     */
    public boolean setAuthentication() {
        //System.out.println("设置smtp身份认证：mail.smtp.auth = " + this.isNeedAuth());
        try {
            if (this.properties == null)
                this.properties = System.getProperties();

            if (this.isNeedAuth()) {
                this.properties.put("mail.smtp.auth", "true");
            } else {
                this.properties.put("mail.smtp.auth", "false");
            }
            return true;
        } catch (Exception e) {
            System.err.println("设置smtp身份认证失败！" + e);
            return false;
        }
    }

    public boolean setNotification() {
        //如果不需要已读回执，直接返回
        if (!this.isNeedNotification()) {
            return true;
        } else {
            try {
                this.getMimeMessage().setHeader("Disposition-Notification-To", this.getAddressFrom());
                return true;
            } catch (MessagingException e) {
                System.out.println("设置已读回执失败! " + e.getMessage());
                return false;
            }
        }
    }

    /**
     * 设置邮件主题
     * @return 设置成功返回true，否则返回false
     */
    public boolean setEmailSubject() {
        //System.out.println("正在设置邮件主题！");
        try {
            this.mimeMessage.setSubject(this.getSubject());
            return true;
        } catch (Exception e) {
            System.err.println("设置邮件主题发生错误！");
            return false;
        }
    }

    /**
     * 设置邮件正文
     * @return 设置成功返回true，否则返回false
     */
    public boolean setEmailbody() {
        //System.out.println("正在设置邮件正文！");
        try {
            BodyPart bp = new MimeBodyPart();
            bp.setContent("" + this.getMailbody(), "text/html;charset=GB2312");
            this.multipart.addBodyPart(bp);

            return true;
        } catch (Exception e) {
            System.err.println("设置邮件正文时发生错误！" + e);
            return false;
        }
    }

    /**
     * 添加单个的邮件附件文件
     * @param filename    - 邮件附件的文件完整地址
     * @return 添加成功返回true，否则返回false
     */
    public boolean addFile(String filename) {
        //System.out.println("增加邮件附件：" + filename);
        try {
            BodyPart bp = new MimeBodyPart();
            FileDataSource fileds = new FileDataSource(filename);
            bp.setDataHandler(new DataHandler(fileds));
            //防止中文附件名乱码问题而对文件名进行编码
            bp.setFileName(MimeUtility.encodeText(fileds.getName(), "gb2312", "B"));

            this.multipart.addBodyPart(bp);

            return true;
        } catch (Exception e) {
            System.err.println("增加邮件附件：" + filename + "发生错误！" + e);
            return false;
        }
    }

    /**
     * 批量添加附件，将类属性里面的邮件附件文件列表中的文件添加到邮件里。
     * @return 添加成功返回true，否则返回false
     */
    public boolean addAttachment() {
        try {
            List<String> files = this.getAttachments();
            for (int i = 0; i < files.size(); i++) {
                if (!this.addFile(files.get(i))) {
                    return false;
                }
            }
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * 设置发信人地址
     * @return 设置成功返回true，否则返回false
     */
    public boolean setFrom() {
        //System.out.println("设置发信人地址: "+this.getAddressFrom());
        if (this.getAddressFrom() == null || this.getAddressFrom().length() == 0) {
            System.out.println("请正确填写邮件发信人地址！");
            return false;
        }
        try {
            this.mimeMessage.setFrom(new InternetAddress(this.getAddressFrom())); // 设置发信人
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * 设置收信人地址
     * @return 设置成功返回true，否则返回false
     */
    public boolean setTo() {
        //System.out.println("设置收信人地址： "+this.getAddressTo());
        if (this.getAddressTo() == null || this.getAddressTo().length() == 0) {
            System.out.println("请正确填写邮件收信人地址！");
            return false;
        }
        try {
            String[] addrTo = this.getAddressTo().split(",");
            int receiverCount = addrTo.length;
            if (receiverCount > 0) {
                address = new InternetAddress[receiverCount];
                for (int i = 0; i < receiverCount; i++) {
                    address[i] = new InternetAddress(addrTo[i]);
                }
                this.mimeMessage.setRecipients(Message.RecipientType.TO, address);
                this.setTo_flag(true);
            }
            return true;
        } catch (Exception e) {
            return false;
        }

    }

    /**
     * 设置邮件抄送地址
     * @return 设置成功返回true，否则返回false
     */
    public boolean setCopyTo() {
        //System.out.println("设置邮件抄送地址: "+this.getAddressCopy());
        if (this.getAddressCopy() == null || this.getAddressCopy().length() == 0) {
            System.out.println("抄送地址-无！");
            return false;
        }
        try {
            String[] addrCopy = this.getAddressCopy().split(",");
            int receiverCount = addrCopy.length;
            if (receiverCount > 0) {
                address = new InternetAddress[receiverCount];
                for (int i = 0; i < receiverCount; i++) {
                    address[i] = new InternetAddress(addrCopy[i]);
                }
                this.mimeMessage.setRecipients(Message.RecipientType.CC, address);
                this.setCc_flag(true);
            }
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * 设置邮件暗送地址
     * @return 设置成功返回true，否则返回false
     */
    public boolean setDarkCopyTo() {
        //System.out.println("设置邮件暗送地址: "+this.getAddressDarkCopy());
        if (this.getAddressDarkCopy() == null || this.getAddressDarkCopy().length() == 0) {
            System.out.println("抄送地址-无！");
            return false;
        }
        try {
            String[] addrDarkCopy = this.getAddressDarkCopy().split(",");
            int receiverCount = addrDarkCopy.length;
            if (receiverCount > 0) {
                address = new InternetAddress[receiverCount];
                for (int i = 0; i < receiverCount; i++) {
                    address[i] = new InternetAddress(addrDarkCopy[i]);
                }
                this.mimeMessage.setRecipients(Message.RecipientType.BCC, address);
                this.setBcc_flag(true);
            }
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * 邮件发送的执行函数，所有的邮件发送操作在此函数里执行
     * @return 发送成功返回true，发送失败返回false
     */
    public boolean sendUp() {

        try {
            this.mimeMessage.setContent(multipart);
            this.mimeMessage.saveChanges();
            System.out.print("正在发送邮件..." + this.getAddressTo() + "...\t\t");

            Session mailSession = Session.getInstance(properties, null);
            Transport transport = mailSession.getTransport("smtp");
            transport.connect((String) properties.get("mail.smtp.host"), this.getUsername(), this.getPassword());

            if (this.isTo_flag())
                transport.sendMessage(mimeMessage, mimeMessage.getRecipients(Message.RecipientType.TO));
            if (this.isCc_flag())
                transport.sendMessage(mimeMessage, mimeMessage.getRecipients(Message.RecipientType.CC));
            if (this.isBcc_flag())
                transport.sendMessage(mimeMessage, mimeMessage.getRecipients(Message.RecipientType.BCC));

            System.out.println("成功！");
            transport.close();

            return true;
        } catch (Exception e) {
            System.err.println("邮件发送失败！" + e);
            return false;
        }
    }

    /////////////////////////////////////////////////////////
    //Getters and Setters
    public String getStrSmtpHost() {
        return strSmtpHost;
    }

    public void setStrSmtpHost(String strSmtpHost) {
        this.strSmtpHost = strSmtpHost;
    }

    public MimeMessage getMimeMessage() {
        return mimeMessage;
    }

    public void setMimeMessage(MimeMessage mimeMessage) {
        this.mimeMessage = mimeMessage;
    }

    public Session getSession() {
        return session;
    }

    public void setSession(Session session) {
        this.session = session;
    }

    public Properties getProperties() {
        return properties;
    }

    public void setProperties(Properties properties) {
        this.properties = properties;
    }

    public boolean isNeedAuth() {
        return isNeedAuth;
    }

    public void setNeedAuth(boolean isNeedAuth) {
        this.isNeedAuth = isNeedAuth;
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

    public Multipart getMultipart() {
        return multipart;
    }

    public void setMultipart(Multipart multipart) {
        this.multipart = multipart;
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

    public String getMailbody() {
        return mailbody;
    }

    public void setMailbody(String mailbody) {
        this.mailbody = mailbody;
    }

    public ArrayList<String> getAttachments() {
        return attachments;
    }

    public void setAttachments(ArrayList<String> attachments) {
        this.attachments = attachments;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getAddressDarkCopy() {
        return addressDarkCopy;
    }

    public void setAddressDarkCopy(String addressDarkCopy) {
        this.addressDarkCopy = addressDarkCopy;
    }

    public Address[] getAddress() {
        return address;
    }

    public void setAddress(Address[] address) {
        this.address = address;
    }

    public boolean isTo_flag() {
        return to_flag;
    }

    public void setTo_flag(boolean to_flag) {
        this.to_flag = to_flag;
    }

    public boolean isCc_flag() {
        return cc_flag;
    }

    public void setCc_flag(boolean cc_flag) {
        this.cc_flag = cc_flag;
    }

    public boolean isBcc_flag() {
        return bcc_flag;
    }

    public void setBcc_flag(boolean bcc_flag) {
        this.bcc_flag = bcc_flag;
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