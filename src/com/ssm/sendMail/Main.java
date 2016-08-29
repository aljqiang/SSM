package com.ssm.sendMail;

/**
 * @author Zengming Zhang
 * @date 2009-3-19
 * 本程序是使用Javamail API和Jacob Office操作库编写的批量发送实名邀请函的Java程序。
 * 1、不仅可以提供全功能的邮件发送功能：
 * - 发送常规邮件（邮件主题、发送地址、接收地址、邮件正文）
 * - 邮件群发
 * - 支持抄送
 * - 支持附件的发送，可同时发送多个附件文件，附件的文件名可以为中文
 * - 支持秘送
 * - 支持已读回执
 * - 邮件服务器认证
 * - 等
 * 2、还可以提供实名制的邮件批量发送：
 * 邮件群发已经不是什么很了不起的功能了，但是实名制的邮件群发倒是迫切需要解决的事情，
 * 特别是办公室工作人员需要发送实名制的邀请函，如果每发送一个电子邮件，都要打开附件（如果
 * 附件是word的话，打开的速度又很慢，还容易死机）添加邀请人的姓名，并且还要在邮件的正文里
 * 面再复制一次邀请人的姓名，我觉得如果让我干这个，还不如让我去死。
 * 现在有了这个程序您只需要提供提供几个模板，配置好您的文件位置，所有的一切本程序可以
 * 为您轻松搞定。人应该干人该干的事情，计算机应该干计算机该干的事情，人要是老干计算机干的事
 * 情，不是人疯了就是世界末日来到了。
 * <p/>
 * 3、本程序是免费程序，虽然提供了非常实用的功能，但是本身还是有很多意想不到的bug，希望各
 * 位可以多多提出意见，不吝赐教！如有任何问题请发邮箱：nicegiving@gmail.com，如果我
 * 的网络没断的话我会在当天给您回复，谢谢您的支持。
 * <p/>
 * 邮件发送的主控程序
 */

/**
 * 邮件发送的主控程序
 */

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

import com.ssm.sendMail.*;


public class Main {

    static final String SPECIALSTRING = "XXXXXXXXXXXX";

    /**
     * 发邮件，该函数负责调用SendManager类并且设置它的参数来发送邮件。
     * @param mail
     * @param strSmtpHost
     * @param username
     * @param password
     * @param addressFrom
     * @param addressTo
     * @param addressCopy
     * @param addressDarkCopy
     * @param subject
     * @param mailbody
     * @param isNeedAuth
     */
    public static void send(SendManager mail,
                            String strSmtpHost,
                            String username,
                            String password,
                            String addressFrom,
                            String addressTo,    //reset
                            String addressCopy,
                            String addressDarkCopy,
                            String subject,
                            String mailbody,    //reset
                            boolean isNeedAuth,
                            boolean isNeedNotification) {
        /** 输入邮件参数 */
        mail.setStrSmtpHost(strSmtpHost);
        mail.setUsername(username);
        mail.setPassword(password);
        mail.setAddressFrom(addressFrom);
        mail.setAddressTo(addressTo);
        mail.setAddressCopy(addressCopy);
        mail.setAddressDarkCopy(addressDarkCopy);
        mail.setSubject(subject);
        mail.setMailbody(mailbody);
        mail.setNeedAuth(isNeedAuth);
        mail.setNeedNotification(isNeedNotification);

        /** 设置邮件参数，发送邮件 */
        mail.setArguments();
        mail.sendMail();
    }

    /**
     * 設置郵件正文中的姓名，方法如下：
     * 在原始的正文文件里面将需要写入姓名的地方用某个特殊符号代替，如本程序里面使用："XXXXXXXXXXXX"，然后待有了姓名之后将其替换。
     * @param mailbody
     * @param name
     * @return
     */
    public static String rebuildMailbody(String mailbody, String name) {
        String body = "";
        int i = mailbody.indexOf(SPECIALSTRING);
        body = mailbody.substring(0, i);
        body += name;
        body += mailbody.substring(i + 12);
        return body;
    }

    /**
     * @param args
     */
    public static void main(String[] args) {
        // TODO Auto-generated method stub
        SendManager mail = new SendManager();

        /** 各种邮件参数 */
        String strSmtpHost = "smtp.163.com";            // 邮件发送服务器
        int intSmtpPort = 25;                            // 邮件发送服务器端口号，gmail的smtp服务器是465号端口
        String username = "aljqiang@163.com";                // 登陆发送服务器的用户名，如：username@gmail.com
        String password = "Laijq@9023*";                    // 登陆发送服务器的密码，如：123446667
        String addressFrom = "aljqiang@163.com";                // 发送邮箱(邮件从哪个邮箱发出的)，如：username@gmail.com

        //多个地址之间用逗号隔开
        String addressTo = "laijq@rongrmb.com";        // 接收邮箱
        String addressCopy = "aljqiang@aliyun.com";                        // 抄;送邮箱
        String addressDarkCopy = "595227518@qq.com";                    // 暗送邮箱

        String subject = "Java Mail";                    // 邮件主题
        String mailbody = "测试邮件, 这是一封测试邮件，请勿回复！！！";                    // 邮件正文
        String mailBodyFile = "D:\\in1.txt";            // 邮件正文邮件，如：E:\\mail\\mailbody.html
        String addressFile = "D:\\in2.txt";                // 邮件地址文件，如：E:\\mail\\address.txt

        //发送邮件是否需要认证
        boolean isNeedAuth = true;
        //发送的邮件是否需要加上已读回执
        boolean isNeedNotification = true;

        //需要处理的文件
        String wordToReplace = "D:\\数据字典.docx";        // 原始的word文件，如：E:\\邀请函.doc
        String wordToSaveAs = "D:\\数据字典.docx";        // 如：E:\\邀请函_2.doc
        String wordStrFind = "信息回复内容库";            // 需要查找并替换的字符串;
        // 实现实名制的原理是这样的：读取word文件中的内容，将需要查找的字符串替换成邀请人的姓名。
        String wordStrReplace = "123321";                        // 替换成的字符串，比如邀请人的姓名

        //邮件附件,多个附件文件之间用逗号隔开
        String attachFile = "D:\\core.log," + wordToSaveAs;    // 连同实名制的邀请函一起加入附件


        /** 从文件读入邮件内容 */
        try {
            BufferedReader fileIn = new BufferedReader(new FileReader(mailBodyFile));
            String line = fileIn.readLine();
            while (line != null) {
                mailbody += line;
                line = fileIn.readLine();
            }
        } catch (IOException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }

        String mailbody_bak = mailbody;

        /**
         * 从地址文件中读取姓名和邮件信息，地址文件的格式如下：
         * 姓名1 <邮件地址1>,姓名2 <邮件地址2>,姓名3 <邮件地址3>,姓名4 <邮件地址4>
         */
        String names[], address[];
        String nameAndAddress = "";
        try {
            BufferedReader fileIn = new BufferedReader(new FileReader(addressFile));
            String line = fileIn.readLine();
            while (line != null) {
                nameAndAddress += line;
                line = fileIn.readLine();
            }
//            System.out.println(nameAndAddress);
        } catch (IOException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }

        // 設置人名列表和郵件地址列表
        names = nameAndAddress.split(",");
        address = new String[names.length];
        String temp[];
        for (int i = 0; i < names.length; i++) {
            temp = names[i].split("<");
            names[i] = temp[0].trim();
            System.out.println(temp[0]);
            address[i] = temp[0].substring(0, temp[0].length() - 1).trim();
        }


        //设置附件
        String files[] = attachFile.split(",");
        for (int i = 0; i < files.length; i++) {
            mail.setAttachment(files[i]);
        }

        //处理附件中的文件，在附件中加上邀请人的名字
        ReplaceWord word = new ReplaceWord();

        //循环发送邮件
        for (int i = 0; i < names.length; i++) {
            mailbody = rebuildMailbody(mailbody_bak, names[i]);

            System.out.print("[" + (i + 1) + "/" + names.length + "] 正在处理附件文件..." + names[i] + "...");

            //处理附件中的文件，在附件中加上邀请人的名字
            word.setDocPath(wordToReplace);
            word.setDocSaveAsPath(wordToSaveAs);
            word.setStrFind(wordStrFind);
            word.setStrReplace(names[i]);
            if (!word.replace()) {
                System.out.println("[" + i + "] 附件文件处理失败！");
                return;
            }

            // 发送邮件
            send(mail, strSmtpHost, username, password, addressFrom,
                    address[i],//reset
                    addressCopy, addressDarkCopy, subject,
                    mailbody,    //reset
                    isNeedAuth, isNeedNotification);

        }
        System.out.println("DONE");


    }

}
