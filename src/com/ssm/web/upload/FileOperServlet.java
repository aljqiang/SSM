package com.ssm.web.upload;

import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URI;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;

/**
 *
 * User: Larry
 * Date: 2016-01-11
 * Time: 10:04
 * Version: 1.0
 */

public class FileOperServlet extends HttpServlet {
	private static final long serialVersionUID = 3077738951269316317L;

	private static Logger log=Logger.getLogger(FileOperServlet.class);

	// 上传根文件夹
	private static String uploadFolder=null;
	private static String basePath="/UPLOAD";

	public void init() throws ServletException {
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.exec(request, response, "GET");
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.exec(request, response, "POST");
	}
	private void exec(HttpServletRequest request, HttpServletResponse response, String method)
			throws ServletException, IOException {
//		UploadHelper helper = (UploadHelper)ContextUtil.getBean("upHelper");
		String uploadFolder = FileOperServlet.getUploadFolder();
		String filename=request.getParameter("filename");
		String realname=request.getParameter("realname");

		response.setContentType("application/pdf");

		try {
			String strPdfPath = new String("Z:\\webapp\\UPLOAD\\test1.pdf");
			// 判断该路径下的文件是否存在
			File file = new File(strPdfPath);
			if (file.exists()) {
				DataOutputStream temps = new DataOutputStream(response
						.getOutputStream());
				DataInputStream in = new DataInputStream(
						new FileInputStream(strPdfPath));

				byte[] b = new byte[2048];
				while ((in.read(b)) != -1) {
					temps.write(b);
					temps.flush();
				}

				in.close();
				temps.close();
			} else {
				log.info(strPdfPath + "文件不存在!");
			}

		} catch (Exception e) {
			log.info(e.getMessage());
		}
	}

	public static String getUploadFolder(){
		if(uploadFolder==null){
			String fullPath = "";
			if(basePath.equalsIgnoreCase("/upload")){  //表示相对于context的根目录地址
				URL url = FileOperServlet.class.getClassLoader().getResource("");
				fullPath = new File(URI.create(url.toExternalForm())).getAbsolutePath();
				fullPath = fullPath.replaceAll("\\\\", "/");
				fullPath = fullPath.substring(0, fullPath.indexOf("WEB-INF")-1);
			}else{  //表示绝对地址
				fullPath = basePath;
				FileOperServlet.createFolder(fullPath + "/UPLOAD/1");
			}
			uploadFolder=fullPath;
			return uploadFolder;
		} else{
			return uploadFolder;
		}
	}

	private static boolean createFolder(String filefolder) {
		boolean ret = true;
		filefolder = filefolder.replaceAll("\\\\", "/");
		String strArr[] = filefolder.split("/");
		int strArrLen = strArr.length;
		String tmpstr = strArr[0];
		if (strArrLen > 2) {
			for (int i = 1; i < (strArrLen - 1); i++) {
				tmpstr += "/" + strArr[i];
				File dir = new File(tmpstr);
				if (!dir.isDirectory()) {
					if (!dir.mkdir()) {
						ret = false;
					}
				}
				dir = null;
			}
		}
		return ret;
	}

	public static void main(String[] args) {
		String str= FileOperServlet.getUploadFolder();
		System.out.println(str);
	}
}
