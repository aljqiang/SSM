package com.ssm.web.upload;

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
 * 文件下载工具类
 * User: Larry
 * Date: 2016-01-11
 * Time: 10:04
 * Version: 1.0
 */

public class DownloadFileServlet extends HttpServlet {
	private static final long serialVersionUID = 3077738951269316317L;

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
		String uploadFolder = DownloadFileServlet.getUploadFolder();
		String filename=request.getParameter("filename");
		String realname=request.getParameter("realname");
		if(filename!=null && realname!=null){
			filename=filename.replaceAll("\\\\", "/");
			if(filename.indexOf("/")==0) filename=filename.substring(1);
			if(filename.indexOf("UPLOAD/")==0){
				realname=new String(realname.getBytes("ISO-8859-1"),"UTF-8");
				realname = URLDecoder.decode(realname, "UTF-8");
				realname = URLEncoder.encode(realname, "UTF-8");
				response.reset();
				response.setHeader("Server", "http://weibo.com/aljqiang/home?wvr=5");
				response.setHeader("Accept-Ranges", "bytes");
//				String sFile=uploadFolder + File.separator + filename;
				String sFile=new String("Z:\\webapp\\UPLOAD\\test1.pdf");
				RandomAccessFile raf=null;
				try{
					raf = new RandomAccessFile(sFile, "r");
					long pos = 0;
			        long len = raf.length();
			        String sRange = request.getHeader("Range");
					if (sRange != null){
						response.setStatus(HttpServletResponse.SC_PARTIAL_CONTENT);
						pos = Long.parseLong(request.getHeader("Range")
										.replaceAll("bytes=", "")
										.replaceAll("-", "")
						);
					}
					response.setHeader("Content-Length", Long.toString(len - pos));
					if (pos != 0) {
					   response.setHeader("Content-Range", new StringBuffer()
		                   .append("bytes ")
		                   .append(pos)
		                   .append("-")
		                   .append(Long.toString(len - 1))
		                   .append("/")
		                   .append(len)
		                   .toString()
						   );
					}
					OutputStream outs = response.getOutputStream();
					response.setContentType("application/octet-stream");
					response.setHeader("Content-Disposition","attachment; filename=\"" + realname+ "\"");
					FileInputStream fis = null;
					try{
						fis = new FileInputStream(raf.getFD());
						raf.seek(pos);
						byte[] b = new byte[1024];
						int i=0;
						while((i=fis.read(b)) != -1){
							outs.write(b,0,i);
						}
				    }catch(FileNotFoundException ex){
						response.reset();
						response.setContentType("text/html; charset=UTF-8");
						response.setHeader("Content-Disposition","text/html; title=wrong request!");
						response.getWriter().print("系统找不到相关文件!");
					}finally{
						if(fis!=null) fis.close();
						if(raf!=null) raf.close();
						outs.close();
					}
				}catch(FileNotFoundException ex){
					response.reset();
					response.setContentType("text/html; charset=UTF-8");
					response.setHeader("Content-Disposition","text/html; title=wrong request!");
					response.getWriter().print("系统找不到相关文件!");
				}
			}else{
				response.reset();
				response.setContentType("text/html; charset=UTF-8");
				response.setHeader("Content-Disposition","text/html; title=权限错误");
				response.getWriter().print("文件目录没有访问权限!");
			}
		}else{
			response.setContentType("text/html; charset=UTF-8");
			response.setHeader("Content-Disposition","text/html; title=错误请求");
			response.getWriter().print("参数错误!");
		}
	}

	public static String getUploadFolder(){
		if(uploadFolder==null){
			String fullPath = "";
			if(basePath.equalsIgnoreCase("/upload")){  //表示相对于context的根目录地址
				URL url = DownloadFileServlet.class.getClassLoader().getResource("");
				fullPath = new File(URI.create(url.toExternalForm())).getAbsolutePath();
				fullPath = fullPath.replaceAll("\\\\", "/");
				fullPath = fullPath.substring(0, fullPath.indexOf("WEB-INF")-1);
			}else{  //表示绝对地址
				fullPath = basePath;
				DownloadFileServlet.createFolder(fullPath + "/UPLOAD/1");
			}
			uploadFolder=fullPath;
			return uploadFolder;
		}else{
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
		String str=DownloadFileServlet.getUploadFolder();
		System.out.println(str);
	}
}
