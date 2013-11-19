package com.akun.elibrary.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.UUID;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

public class UploadAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String retvalue;
	private File upload;
	private String uploadFileName;
	private String uploadContentType;
	private String uploadPhotoId;
	//	Upload photos for books
	public String uploadPhoto() {
		
		retvalue = "{\"success\":true,\"msg\":";
		try { 
	        java.io.InputStream is = new FileInputStream(upload);  
	        System.out.println(upload.getName());
	        String newName = uploadPhotoId+"FileImage";
	        String exp = getFileExp(uploadFileName);
	        //File oldFile = new File(ServletActionContext.getServletContext().getRealPath("/")+ "UploadImages" + File.separator+newName);
	        String path = ServletActionContext.getServletContext().getRealPath("/")+ "/uploadedImages" + File.separator+newName+exp;
	        System.out.println(path+"~~~~~~~~~~~~~~~");
	        java.io.OutputStream os = new FileOutputStream(path);
	        byte buffer[] = new byte[8192];  
	        int count = 0;  
	        while ((count = is.read(buffer)) > 0)  
	            os.write(buffer, 0, count);  
	        os.close();  
	        is.close();  
	        retvalue += "\"Success!\"";
	     } catch (Exception e)  
	     {  
	    	 System.out.println(e);
	    	 retvalue += "\"Failed...\"";  
	     }  

		retvalue += "}";

	
	return SUCCESS;

	}
	public String getRetvalue() {
		return retvalue;
	}
	public void setRetvalue(String retvalue) {
		this.retvalue = retvalue;
	}
	private String getFileExp(String name){
		int pos = name.lastIndexOf(".");
		return name.substring(pos);
	}
	public File getUpload() {
		return upload;
	}
	public void setUpload(File upload) {
		this.upload = upload;
	}
	public String getUploadFileName() {
		return uploadFileName;
	}
	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}
	public String getUploadContentType() {
		return uploadContentType;
	}
	public void setUploadContentType(String uploadContentType) {
		this.uploadContentType = uploadContentType;
	}
	public String getUploadPhotoId() {
		return uploadPhotoId;
	}
	public void setUploadPhotoId(String uploadPhotoId) {
		this.uploadPhotoId = uploadPhotoId;
	}   
	
	
}
