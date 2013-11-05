package com.akun.elibrary.bo.imp;

import java.util.List;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;

import com.akun.elibrary.bean.Libuser;
import com.akun.elibrary.bean.LibuserExample;
import com.akun.elibrary.bo.LibuserBO;
import com.akun.elibrary.dao.LibuserDAO;

/**
 * 作          者：杨宗昆<br>
 * 创建日期： 2012-4-1 上午09:45:29<br>
 * 版          本： 1.00<br>
 * 版权所有
 */
public class LibuserBOImp implements LibuserBO {
    private LibuserDAO userDAO;
    
    public LibuserDAO getUserDAO() {
		return userDAO;
	}

	public void setUserDAO(LibuserDAO userDAO) {
		this.userDAO = userDAO;
	}

	//日志对象
    private static final Logger LOGGER = Logger.getLogger(LibuserBOImp.class);
    
	/**
	 * 验证登陆
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Libuser validateUser(String username, String userpwd) {
        if(!username.equals(null)&&!"".equals(username)&&!userpwd.equals(null)&&!"".equals(userpwd)){
        	LibuserExample userExample = new LibuserExample();
        	userExample.createCriteria().andUsernameEqualTo(username).andUserpwdEqualTo(userpwd);
        	List<Libuser> userList = (List<Libuser>)userDAO.selectByExample(userExample);
        	if(userList!=null&&userList.size()>0){
        		LOGGER.info("用户验证通过");
        		return userList.get(0);
        	}
        	LOGGER.info("用户不存在");
        }
		return null;
	}
	
	/**
	 * 增
	 * return 2添加成功，-1添加失败,5 重复
	 */
    @Override
	@SuppressWarnings("unchecked")
	public int add(Libuser item) {
		int result = -1;
		//验证重复用户名
		LibuserExample example = new LibuserExample();
		example.createCriteria().andUsernameEqualTo(item.getUsername());
		List<Libuser> list1 = (List<Libuser>)userDAO.selectByExample(example);
		//验证重复真实姓名
		LibuserExample example2 = new LibuserExample();
		example2.createCriteria().andRealnameEqualTo(item.getRealname());
		List<Libuser> list2 = (List<Libuser>)userDAO.selectByExample(example2);
		System.out.println(list1.size());
		System.out.println(list2.size());
		
		if (list1.size() == 0&&list2.size()==0) {
		try {
			userDAO.insertSelective(item);
			result = 2;
		}
		catch (Exception e) {
		    LOGGER.error(e.toString());
		}
		}else{
			result = 5;
		}
		return result;
	}

	/**
     * 删
     * return 0数据格式不正确，1不允许删除，2删除成功
     */
	@Override
	public int deleteByPrimaryKey(String idsToDelete) {
		int result = 1;
		if(idsToDelete != null && !"".equals(idsToDelete)){
			String[] stringIds = idsToDelete.split(",");
			try {
				for(int j=0;j<stringIds.length;j++){
					try {
						LibuserExample example = new LibuserExample();
						example.createCriteria().andUseridEqualTo(stringIds[j]);
						userDAO.deleteByExample(example);
					}
					catch (Exception e) {
					    LOGGER.error(e.toString());
					}
				}
				result = 2;
			}
			catch (Exception e) {
			    result = 0;
			}
			
		}else{
			result = 0;
		}
		return result;
	}
     
	/**
	 *查 
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Libuser> selectByExample(LibuserExample example) {
		List<Libuser> list = userDAO.selectByExample(example);
		return list;
	}

	@Override
	public int update(String LibuserJson) {
		// TODO Auto-generated method stub
		return 0;
	}

	/**
     * 改
     * return 0数据格式不正确，2修改成功，-1修改失败
     */
	@SuppressWarnings("unchecked")
	@Override
	public int update(String libuserJson, String libuserJson2) {
		int result = 0;
		if (libuserJson != null && !"".equals(libuserJson)) {
			JSONArray jsonArray = JSONArray.fromObject(libuserJson);
			List<Libuser> libuserList = (List<Libuser>) JSONArray.toCollection(jsonArray,
					Libuser.class);
			JSONArray jsonArray2 = JSONArray.fromObject(libuserJson2);
			List<Libuser> libuserList2 = (List<Libuser>) JSONArray.toCollection(jsonArray2,
					Libuser.class);
			LibuserExample example = new LibuserExample();
			if (result == 0) {
				int updatecount = 0;
				for(int i=0;i<libuserList.size();i++){
					example.createCriteria().andUseridEqualTo(libuserList.get(i).getUserid());
					try {
						userDAO.updateByExampleSelective(libuserList2.get(i), example);
						updatecount++;
					}
					catch (Exception e) {
				    		LOGGER.error(e.toString());
					}
				}
				if (updatecount == libuserList.size()) {
					result = 2;
				} else {
					result = -1;
				}
			} else {
				result = 0;
			}
		} else {
			result = -1;
		}

		return 2;
	}
    /**
     * 修改密码
     * return: 0 原密码输入错误, 1 两次密码输入不一致 , 2 成功
     */
	@SuppressWarnings("unchecked")
	@Override
	public int changePwd(String username, String pwd, String pwd2) {
		int result = 0;
		if(pwd.equals(pwd2)){
			LibuserExample example = new LibuserExample();
			example.createCriteria().andUsernameEqualTo(username);
			List<Libuser> list = userDAO.selectByExample(example);
			Libuser theuser = list.get(0);
			Libuser item = new Libuser();
			item.setEmail(theuser.getEmail());
			item.setRealname(theuser.getRealname());
			item.setTel(theuser.getTel());
			item.setUsername(theuser.getUsername());
			item.setUserpwd(pwd);
			userDAO.updateByExampleSelective(item, example);
			result = 2;
		}else{
			result = 1 ;
		}
		return result;
	}

}
