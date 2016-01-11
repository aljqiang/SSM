package com.ssm.utils;

import org.apache.log4j.Logger;

import java.util.*;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

/**
 * Java Mail 工具类
 * User: Larry
 * Date: 2016-01-11
 * Time: 10:04
 * Version: 1.0
 */

public class MailUtils {
    public static void main(String[] args) {

        List<String> addressList = new ArrayList<>();
        addressList.add("aljqiang@aliyun.com");
        addressList.add("595227518@qq.com");

        List<String> filepath = new ArrayList<>();
        filepath.add("D://in1.txt");
        filepath.add("D://in2.txt");

        for (int i = 0; i < 2; i++) {
            MailUtils.send(mailInfoMap.get(String.valueOf(i + 1)), addressList, "Java Mail", "测试邮件, 这是一封测试邮件，请勿回复！！！", filepath);
        }
    }

    private static final Logger log = Logger.getLogger(MailUtils.class);

    public static final String ENCODEING = "UTF-8";


    private static Map<String, Mail> mailInfoMap = new HashMap<>();

    /**
     * 初始化发送邮箱组
     */
    static {
        Mail mail1 = new Mail("laijq@rongrmb.com", "192.168.230.238", "laijq@rongrmb.com",
                "hold?fish:palm");

        Mail mail2 = new Mail("aljqiang@163.com", "smtp.163.com", "aljqiang@163.com",
                "Laijq@9023*");

        mailInfoMap.put("1", mail1);
        mailInfoMap.put("2", mail2);
    }

    // 将字符串转换为中文,否则标题会发生乱码现象,QQ邮箱为UTF-8.用GBK.GB2312都会乱码.
    public String translateChinese(String strText) {
        try {
            // MimeUtility.encodeText(String text, String charset, String
            // encoding) throws java.io.UnsupportedEncodingException
            // text 头值 . charset 字符集。如果此参数为 null，则使用平台的默认字符集。
            // encoding 要使用的编码。当前支持的值为 "B" 和 "Q"。如果此参数为 null，则在大部分字符使用 ASCII
            // 字符集编码时使用 "Q" 编码；其他情况使用 "B" 编码。
            strText = MimeUtility.encodeText(new String(strText.getBytes(), "UTF-8"), "UTF-8", "B");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return strText;
    }

    /**
     * 获得指定SMTP服务器的的Session实例
     *
     * @param host
     * @param isAuth
     * @param user
     * @param pwd
     * @return
     */
    public static Session getSession(String host, boolean isAuth, final String user, final String pwd) {
        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.auth", String.valueOf(isAuth));

        Session session;
        if (user != null && user.length() > 0) {
            session = Session.getInstance(props,
                    new Authenticator() {
                        public PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(user, pwd);
                        }
                    }
            );
        } else {
            /**
             * 多个账号发送邮件使用getInstance()
             * */
            session = Session.getInstance(props, null);  // 非单例模式，每次加载用户自己定义的properties

            /**
             * 单个账号发送邮件使用getDefaultInstance()
             * */
//            session = Session.getDefaultInstance(props, null);  // 单例模式，从缓存中查找是否有properties存在，如果存在，则加载默认的properties，如果不存在才加载用户自己定义的properties
        }

        return session;
    }

    public static boolean send(final Mail mi, List<String> addressList, String subject, String content, List<String> filepath) {

        // 参数修饰
        if (content == null) {
            content = "";
        }
        if (subject == null) {
            subject = "无主题";
        }

        // 创建邮件Session所需的Properties对象.API建议使用set而不是put(putall).
        Properties props = new Properties();
        props.setProperty("mail.smtp.host", mi.getSmtpServer());
        props.setProperty("mail.smtp.auth", "true");
        // 创建Session对象,代表JavaMail中的一次邮件会话.
        // Authenticator==>Java mail的身份验证,如QQ邮箱是需要验证的.所以需要用户名,密码.
        // PasswordAuthentication==>系统的密码验证.内部类获取,或者干脆写个静态类也可以.
        Session session = Session.getInstance(props,
                new Authenticator() {
                    public PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(mi.getUserName(), mi.getPassword());
                    }
                }
        );

        try {
            // 构造MimeMessage并设置相关属性值,MimeMessage就是实际的电子邮件对象.
            MimeMessage msg = new MimeMessage(session);
            // 设置发件人
            msg.setFrom(new InternetAddress(mi.getFrom()));

            // 设置收件人,为数组,可输入多个地址.
            InternetAddress[] addresses = new InternetAddress[addressList.size()];
            for (int i = 0; i < addressList.size(); i++) {
                log.info("[发件人地址：" + addressList.get(i) + "]");
                addresses[i] = new InternetAddress(addressList.get(i));
            }

            // Message.RecipientType==>TO(主要接收人),CC(抄送),BCC(密件抄送)
            msg.setRecipients(Message.RecipientType.TO, addresses);
            // 设置邮件主题,如果不是UTF-8就要转换下.
            // subject=translateChinese(subject);
            msg.setSubject(subject);

            // =====================正文部分===========
            // 构造Multipart容器
            Multipart mp = new MimeMultipart();
            // =====================正文文字部分===========
            // 向Multipart添加正文
            MimeBodyPart mbpContent = new MimeBodyPart();
            mbpContent.setText(content);
            // 将BodyPart添加到MultiPart容器中
            mp.addBodyPart(mbpContent);

            // =====================正文附件部分===========
            // 向MulitPart添加附件,遍历附件列表,将所有文件添加到邮件消息里
            for (String efile : filepath) {
                MimeBodyPart mbpFile = new MimeBodyPart();
                // 以文件名创建FileDataSource对象
                FileDataSource fds = new FileDataSource(efile);
                // 处理附件
                mbpFile.setDataHandler(new DataHandler(fds));
                mbpFile.setFileName(fds.getName());
                // 将BodyPart添加到Multipart容器中
                mp.addBodyPart(mbpFile);
            }

            //  向MimeMessage添加Multipart
            msg.setContent(mp);
            msg.setSentDate(new Date());
            // 发送邮件,使用如下方法
            log.info("##############开始发送邮件##############");
            Transport.send(msg);

//            filepath.clear();

            log.info("##############邮件发送成功##############");
        } catch (Exception e) {
            log.error("##############邮件发送失败##############");
            e.printStackTrace();
            return false;
        }
        return true;
    }
}

class Mail {
    /**
     * 发件人
     */
    private String from;

    /**
     * 服务器地址
     */
    private String smtpServer;

    /**
     * 账号
     */
    private String userName;

    /**
     * 密码
     */
    private String password;

    public Mail() {

    }

    public Mail(String from, String smtpServer, String userName, String password) {
        this.from = from;
        this.smtpServer = smtpServer;
        this.userName = userName;
        this.password = password;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getSmtpServer() {
        return smtpServer;
    }

    public void setSmtpServer(String smtpServer) {
        this.smtpServer = smtpServer;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
