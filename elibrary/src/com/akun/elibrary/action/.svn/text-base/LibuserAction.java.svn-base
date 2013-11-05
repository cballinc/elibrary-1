package com.akun.elibrary.action;

import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.akun.elibrary.bean.Libuser;
import com.akun.elibrary.bean.LibuserExample;
import com.akun.elibrary.bo.LibuserBO;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class LibuserAction extends ActionSupport {
    private	String username;
	private String userpwd;
    private String retvalue;
    private LibuserBO userBO;
    private String key;
    private List<Libuser> libuserList;
    private String updateLibuserList;
    private String updateLibuserList2;
	private String idsToDelete;
    private Libuser libuser;
    private String newPwd;
    private String newPwd2;
	private String oldPwd;
	HttpSession session;
	private int loginCounter;
	private String loginExceptUser;
    /**
     * 用户登录
     * @author 杨宗昆<br>
     * 方法说明：<br>
     * @return
     */
	public String login(){
		if(ServletActionContext.getRequest().getSession().getAttribute("loginCounter")!=null){
			if((Integer)ServletActionContext.getRequest().getSession().getAttribute("loginCounter")>=3){
				retvalue="登陆错误3次，不允许登录！";
				return SUCCESS;
			}
		}
		Libuser user = userBO.validateUser(username, userpwd);
		if(!(user==null)&&!"".equals(user)){
		    ServletActionContext.getRequest().getSession().setAttribute("userInfo", user);
			retvalue = "success";
		}else{
			//设置计数器记录登陆次数，3次登录失败则不允许登录
			if(ServletActionContext.getRequest().getSession().getAttribute("loginCounter") == null){
				loginCounter=1;
				ServletActionContext.getRequest().getSession().setAttribute("loginCounter", loginCounter);
			}else{
				loginCounter++;
				ServletActionContext.getRequest().getSession().setAttribute("loginCounter", loginCounter);
			}
			//retvalue = "error";
			retvalue="用户名或密码错误,   "+loginCounter+"次，三次登录失败则该用户不允许登录";
            if(loginCounter>=3){
			   retvalue="登陆错误3次，不允许登录！";	
			   //loginExceptUser = username;
			   //ServletActionContext.getRequest().getSession().setAttribute("loginExceptUser", loginExceptUser);
			}
		}
		System.out.println(retvalue);
		return SUCCESS;
	}
	/**
	 * 用户注销
	 * @author 杨宗昆<br>
	 * 方法说明：<br>
	 * @return
	 */
	public String logout(){
		ServletActionContext.getRequest().getSession().removeAttribute("userInfo");
		return SUCCESS;
	}
	
	/**
	 * 查
	 * @author 杨宗昆<br>
	 * 方法说明：<br>
	 * @return
	 */
	public String listLibuser(){
		if(key==null){
			key="";
		}
		LibuserExample example = new LibuserExample();
		example.createCriteria().andUsernameLike("%"+key+"%");
		libuserList = userBO.selectByExample(example);
		retvalue="{\"nodes\":";
    	if(libuserList!=null){
    		retvalue += JSONArray.fromObject(libuserList);
    	}else{
    		retvalue += "[]";
    	}
    	retvalue += "}";
		return SUCCESS;
	}
	/**
     * 改
     * @author 杨宗昆<br>
     * 方法说明：<br>
     * @return
     */
    public String updateLibuser() {
		int result = userBO.update(updateLibuserList,updateLibuserList2);
		switch (result) {
		case 0:
			retvalue = "数据格式不正确";
			break;
		case 1:
			retvalue = "保存的名称已被使用，请重新输入";
			break;
		case 2:
			retvalue = "修改成功";
			break;
		default:
			retvalue = "操作失败";
			break;
		}
		return SUCCESS;
	}
    
    /**
	 * 删一个或多个
	 * 
	 * @author 杨宗昆<br>
	 *         方法说明：<br>
	 * @param
	 * @return:
	 */
	public String deleteLibuser() {
		System.out.println(idsToDelete);
		int result = userBO.deleteByPrimaryKey(idsToDelete);
		switch (result) {
		case 0:
			retvalue = "数据格式不正确";
			break;
		case 1:
			retvalue = "已被引用，禁止删除";
			break;
		case 2:
			retvalue = "删除成功";
			break;
		default:
			retvalue = "操作失败";
			break;
		}
		return SUCCESS;
	}
	/**
	 * 增
	 * 
	 * @author 杨宗昆<br>
	 *         方法说明：<br>
	 * @param
	 * @return:
	 */
	public String addLibuser() {
			retvalue = "{\"success\":true,\"msg\":";
			int result = userBO.add(libuser);
			switch (result) {
			case -1:
				retvalue += "\"操作失败\"";
				break;
			case 0:
				retvalue += "\"数据格式不正确\"";
				break;
			case 2:
				retvalue += "\"操作成功\"";
				break;
			case 5:
				retvalue += "\"用户名或真实姓名已存在\"";
			default:
				break;
			}
			retvalue += "}";

		
		return SUCCESS;
	}
	
	/**
     * 修改密码
     * @author 杨宗昆<br>
     * 方法说明：<br>
     * @return
     */
	public String changeLibuserPwd(){
		int result=0;
		retvalue = "{\"success\":true,\"msg\":";
		if(oldPwd.equals(userpwd)){
		result = userBO.changePwd(username,newPwd,newPwd2);
		}else{
			result = 0;
		}
		switch (result) {
		case 0:
			retvalue += "\"原密码输入错误\"";
			break;
		case 2:
			retvalue += "\"操作成功\"";
			break;
		case 1:
			retvalue += "\"两次新密码输入不一致\"";
		default:
			retvalue += "\"操作失败\"";
		}
		retvalue += "}";
		return SUCCESS;
	}
	
	public String getOldPwd() {
		return oldPwd;
	}
	public void setOldPwd(String oldPwd) {
		this.oldPwd = oldPwd;
	}
	public String getNewPwd() {
		return newPwd;
	}
	public void setNewPwd(String newPwd) {
		this.newPwd = newPwd;
	}
	public String getNewPwd2() {
		return newPwd2;
	}
	public void setNewPwd2(String newPwd2) {
		this.newPwd2 = newPwd2;
	}
	public String getIdsToDelete() {
		return idsToDelete;
	}
	public void setIdsToDelete(String idsToDelete) {
		this.idsToDelete = idsToDelete;
	}
	public Libuser getLibuser() {
		return libuser;
	}
	public void setLibuser(Libuser libuser) {
		this.libuser = libuser;
	}
	public String getUpdateLibuserList() {
		return updateLibuserList;
	}
	public void setUpdateLibuserList(String updateLibuserList) {
		this.updateLibuserList = updateLibuserList;
	}
	public String getUpdateLibuserList2() {
		return updateLibuserList2;
	}
	public void setUpdateLibuserList2(String updateLibuserList2) {
		this.updateLibuserList2 = updateLibuserList2;
	}
	public List<Libuser> getLibuserList() {
		return libuserList;
	}
	public void setLibuserList(List<Libuser> libuserList) {
		this.libuserList = libuserList;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public LibuserBO getUserBO() {
		return userBO;
	}

	public void setUserBO(LibuserBO userBO) {
		this.userBO = userBO;
	}

	public String getRetvalue() {
		return retvalue;
	}

	public void setRetvalue(String retvalue) {
		this.retvalue = retvalue;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUserpwd() {
		return userpwd;
	}

	public void setUserpwd(String userpwd) {
		this.userpwd = userpwd;
	}
	public int getLoginCounter() {
		return loginCounter;
	}
	public void setLoginCounter(int loginCounter) {
		this.loginCounter = loginCounter;
	}
	public String getLoginExceptUser() {
		return loginExceptUser;
	}
	public void setLoginExceptUser(String loginExceptUser) {
		this.loginExceptUser = loginExceptUser;
	}
	
}
