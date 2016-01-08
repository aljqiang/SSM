package com.ssm.utils;

import org.apache.log4j.Logger;

import java.io.UnsupportedEncodingException;
import java.util.*;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

/**
 * Java Mail 工具栏
 * User: Larry
 * Date: 2016-01-08
 * Time: 10:44
 * Version: 1.0
 */

public class MailUtils {

    private static Logger log = Logger.getLogger(MailUtils.class);

    /**
     * 邮箱服务器地址
     */
    private static String host;

    /**
     * 发件人
     */
    private static String username;

    /**
     * 邮箱密码
     */
    private static String password;

    /**
     * 发件人邮箱
     */
    private static String from;

    /**
     * 发件人名称
     */
    private static String nick;

    /**
     * 邮箱组
     */
    private static Map<String, MailInfo> mailInfoMap = new HashMap<String, MailInfo>();

    static {
        try {
            /**单个邮箱发送*/
            // Test Data
//            host = "smtp.163.com";
//            username = "aljqiang";
//            password = "Laijq@9023*";
//            from = "aljqiang@163.com";
//            nick = "aljqiang";
            // nick + from 组成邮箱的发件人信息

            // 邮箱信息
            MailInfo mailInfo1 = new MailInfo("smtp.163.com", "aljqiang", "Laijq@9023*", "aljqiang@163.com", "aljqiang");
            MailInfo mailInfo2 = new MailInfo("192.168.230.238", "laijq", "hold?fish:palm", "laijq@rongrmb.com", "laijq");

            mailInfoMap.put("1", mailInfo1);
            mailInfoMap.put("2", mailInfo2);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 发送邮件
     *
     * @param mi 邮箱地址信息
     * @param to       收件人列表，以","分割
     * @param subject  标题
     * @param body     内容
     * @param filepath 附件列表,无附件传递null
     */
    public static boolean sendMail(MailInfo mi,String to, String subject, String body,
                                   List<String> filepath) throws AddressException, MessagingException,
            UnsupportedEncodingException {
        // 参数修饰
        if (body == null) {
            body = "";
        }
        if (subject == null) {
            subject = "无主题";
        }
        // 创建Properties对象
        Properties props = System.getProperties();
        // 创建信件服务器
        props.put("mail.smtp.host", mi.getHost());
        props.put("mail.smtp.port", "25");
        props.put("mail.smtp.auth", "true"); // 通过验证
        // 得到默认的对话对象
        Session session = Session.getDefaultInstance(props, null);
        // 创建一个消息，并初始化该消息的各项元素
        MimeMessage msg = new MimeMessage(session);
        nick = MimeUtility.encodeText(mi.getNick());
        msg.setFrom(new InternetAddress(mi.getNick() + "<" + mi.getFrom() + ">"));
        // 创建收件人列表
        if (to != null && to.trim().length() > 0) {
            String[] arr = to.split(",");
            int receiverCount = arr.length;
            if (receiverCount > 0) {
                InternetAddress[] address = new InternetAddress[receiverCount];
                for (int i = 0; i < receiverCount; i++) {
                    address[i] = new InternetAddress(arr[i]);
                }
                msg.addRecipients(Message.RecipientType.TO, address);
                msg.setSubject(subject);
                // 后面的BodyPart将加入到此处创建的Multipart中
                Multipart mp = new MimeMultipart();
                // 附件操作
                if (filepath != null && filepath.size() > 0) {
                    for (String filename : filepath) {
                        MimeBodyPart mbp = new MimeBodyPart();
                        // 得到数据源
                        FileDataSource fds = new FileDataSource(filename);
                        // 得到附件本身并至入BodyPart
                        mbp.setDataHandler(new DataHandler(fds));
                        // 得到文件名同样至入BodyPart
                        mbp.setFileName(fds.getName());
                        mp.addBodyPart(mbp);
                    }
                    MimeBodyPart mbp = new MimeBodyPart();
                    mbp.setText(body);
                    mp.addBodyPart(mbp);
                    // 移走集合中的所有元素
                    filepath.clear();
                    // Multipart加入到信件
                    msg.setContent(mp);
                } else {
                    // 设置邮件正文
                    msg.setText(body);
                }
                // 设置信件头的发送日期
                msg.setSentDate(new Date());
                msg.saveChanges();
                // 发送信件
                Transport transport = session.getTransport("smtp");
                System.out.println("##############邮件开始发送##############");
                transport.connect(mi.getHost(), mi.getUsername(), mi.getPassword());
                transport.sendMessage(msg,
                        msg.getRecipients(Message.RecipientType.TO));
                transport.close();
                return true;
            } else {
                System.out.println("None receiver!");
                return false;
            }
        } else {
            System.out.println("None receiver!");
            return false;
        }
    }

    public static void main(String[] args) throws AddressException,
            UnsupportedEncodingException, MessagingException {
        List<String> filepath = new ArrayList<>();

        try {
            // 单个邮箱发送
//            boolean result = MailUtils.sendMail(mailInfoMap.get("2"),"595227518@qq.com,aljqiang@aliyun.com", "测试邮件1", "这是一封测试邮件，请勿回复！！！",
//                    filepath);

            // 多个邮箱发送
            boolean result=false;
            for (int i = 0; i < 2; i++) {
                if (i < 1) {
                    filepath.add("D:\\in1.txt");
                    filepath.add("D:\\in2.txt");
                    result = MailUtils.sendMail(mailInfoMap.get("2"),"595227518@qq.com,aljqiang@aliyun.com", "测试邮件1", "这是一封测试邮件，请勿回复！！！", filepath);
                }else{
                    filepath.add("D:\\in1.txt");
                    filepath.add("D:\\in2.txt");
                    result = MailUtils.sendMail(mailInfoMap.get("1"),"595227518@qq.com,aljqiang@aliyun.com", "测试邮件1", "这是一封测试邮件，请勿回复！！！", filepath);
                }
                System.out.println(result ? "##############邮件发送成功##############" : "##############邮件发送失败##############");
            }

        } catch (Exception e) {
            System.out.println("##############邮件发送失败##############");
            e.printStackTrace();
        }
    }
}

class MailInfo {
    /**
     * 邮箱服务器地址
     */
    private String host;

    /**
     * 发件人
     */
    private String username;

    /**
     * 邮箱密码
     */
    private String password;

    /**
     * 发件人邮箱
     */
    private String from;

    /**
     * 发件人名称
     */
    private String nick;

    public MailInfo() {

    }

    public MailInfo(String host, String username, String password, String from, String nick) {
        this.host = host;
        this.username = username;
        this.password = password;
        this.from = from;
        this.nick = nick;
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
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

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getNick() {
        return nick;
    }

    public void setNick(String nick) {
        this.nick = nick;
    }
}
