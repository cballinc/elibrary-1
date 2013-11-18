package com.akun.elibrary.action;

import java.util.List;

import net.sf.json.JSONArray;

import com.akun.elibrary.bean.Literature;
import com.akun.elibrary.bean.LiteratureExample;
import com.akun.elibrary.bo.LiteratureBO;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class LiteratureAction extends ActionSupport {
	private LiteratureBO literatureBO;
	private String retvalue;
	private String key;
	private String idsToDelete;
	private Literature literature;
	private String updateList;
	private String updateList2;
	/**
     * 查
     * @author 杨宗昆<br>
     * 方法说明：<br>
     * @return
     */
    public String listLiterature(){
    	if(key==""){
    		key="";
    	}
    	System.out.println(key);
    	List<Literature> list  = null;
    	String booknameSearch = "";
		String authorSearch = "";
		if (!key.contains("_")){
			booknameSearch = key;
		}else if (key.trim()!="_"&&!"_".equals(key.trim())){
			key = " "+key+" ";
			if(key.split("_")[0]!=null){
				booknameSearch = key.split("_")[0].trim();				
			}
			if(key.split("_")[1]!=null){
	    		authorSearch = key.split("_")[1].trim(); 
			}
		}
		System.out.println(booknameSearch);
		System.out.println(authorSearch);

    	if(authorSearch==""||"".equals(authorSearch)||authorSearch==null){
    		list = (List<Literature>)literatureBO.selectByKey(booknameSearch);
    	}else{
    		list = (List<Literature>)literatureBO.selectByNameAndAuthor(booknameSearch,authorSearch);
    	}
    	retvalue="{\"nodes\":";
		if(list!=null){
    		retvalue += JSONArray.fromObject(list);
    	}else{
    		retvalue += "[]";
    	}
    	retvalue += "}";
    	System.out.println(retvalue);
    	return SUCCESS;
    }
    
    /**
     * 改
     * @author 杨宗昆<br>
     * 方法说明：<br>
     * @return
     */
    public String updateLiterature() {
		int result = literatureBO.update(updateList,updateList2);
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
	public String deleteLiterature() {
		System.out.println(idsToDelete);
		int result = literatureBO.deleteByPrimaryKey(idsToDelete);
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
	public String addLiterature() {
			retvalue = "{\"success\":true,\"msg\":";
			int result = literatureBO.add(literature);
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
				retvalue += "\"名称或索引号输入重复\"";
			default:
				break;
			}
			retvalue += "}";

		
		return SUCCESS;
	}

	public String getUpdateList() {
		return updateList;
	}

	public void setUpdateList(String updateList) {
		this.updateList = updateList;
	}

	public String getUpdateList2() {
		return updateList2;
	}

	public void setUpdateList2(String updateList2) {
		this.updateList2 = updateList2;
	}

	public LiteratureBO getLiteratureBO() {
		return literatureBO;
	}

	public void setLiteratureBO(LiteratureBO literatureBO) {
		this.literatureBO = literatureBO;
	}

	public String getRetvalue() {
		return retvalue;
	}

	public void setRetvalue(String retvalue) {
		this.retvalue = retvalue;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getIdsToDelete() {
		return idsToDelete;
	}

	public void setIdsToDelete(String idsToDelete) {
		this.idsToDelete = idsToDelete;
	}

	public Literature getLiterature() {
		return literature;
	}

	public void setLiterature(Literature literature) {
		this.literature = literature;
	}
	
}
