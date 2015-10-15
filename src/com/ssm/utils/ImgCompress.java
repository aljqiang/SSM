/**
 * Project Name:lightmvc
 * File Name:ImgCompress.java
 * Package Name:light.mvc.utils
 * Date:2014-12-23上午10:58:53
 * Copyright (c) 2014, chenzhou1025@126.com All Rights Reserved.
 *
*/

package com.ssm.utils;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;

public class ImgCompress {
	 private Image img;  
	    private int width;  
	    private int height;  
	    @SuppressWarnings("deprecation")  
	    public static void main(String[] args) throws Exception {  
	        System.out.println("开始：" + new Date().toLocaleString());  
	        String f="F:\\tomcat6.0.43\\webapps\\lightmvc\\upload\\photo\\1419316118748无标题.png";
	        String f1="F:\\tomcat6.0.43\\webapps\\lightmvc\\upload\\photo\\suolt\\1419315073247无标题.png";
//	       String ff=f.substring(f.lastIndexOf("\\upload"),f.length());
//	        System.out.println(ff);
	        ImgCompress imgCom = new ImgCompress(f);  
	        imgCom.resize(80,100,f1);  
	        System.out.println("结束：" + new Date().toLocaleString());  
	    }  
	    /** 
	     * 构造函数 
	     */  
	    public ImgCompress(String fileName) throws IOException {  
	        File file = new File(fileName);// 读入文件  
	        img = ImageIO.read(file);      // 构造Image对象  
	        width = img.getWidth(null);    // 得到源图宽  
	        height = img.getHeight(null);  // 得到源图长  
	    }  
	    /** 
	     * 按照宽度还是高度进行压缩 
	     * @param w int 最大宽度 
	     * @param h int 最大高度 
	     */  
	    public void resizeFix(int w, int h,String f) throws IOException {  
	        if (width / height > w / h) {  
	            resizeByWidth(w,f);  
	        } else {  
	            resizeByHeight(h,f);  
	        }  
	    }  
	    /** 
	     * 以宽度为基准，等比例放缩图片 
	     * @param w int 新宽度 
	     */  
	    public void resizeByWidth(int w,String f) throws IOException {  
	        int h = (int) (height * w / width);  
	        resize(w, h,f);  
	    }  
	    /** 
	     * 以高度为基准，等比例缩放图片 
	     * @param h int 新高度 
	     */  
	    public void resizeByHeight(int h,String f) throws IOException {  
	        int w = (int) (width * h / height);  
	        resize(w, h,f);  
	    }  
	    /** 
	     * 强制压缩/放大图片到固定的大小 
	     * @param w int 新宽度 
	     * @param h int 新高度 
	     */  
	    public void resize(int w, int h,String file) throws IOException {  
	        // SCALE_SMOOTH 的缩略算法 生成缩略图片的平滑度的 优先级比速度高 生成的图片质量比较好 但速度慢  
	        BufferedImage image = new BufferedImage(w, h,BufferedImage.SCALE_SMOOTH );   
	        image.getGraphics().drawImage(img, 0, 0, w, h, null); // 绘制缩小后的图  
	        File destFile = new File(file);  
	        FileOutputStream out = new FileOutputStream(destFile); // 输出到文件流  
	        // 可以正常实现bmp、png、gif转jpg  
	        JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);  
	        encoder.encode(image); // JPEG编码  
	        out.close();  
	    }  
}

