package com.akun.elibrary.bo.imp;

import java.util.List;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;

import com.akun.elibrary.bean.Literature;
import com.akun.elibrary.bean.LiteratureExample;
import com.akun.elibrary.bo.LiteratureBO;
import com.akun.elibrary.dao.LiteratureDAO;

public class LiteratureBOImp implements LiteratureBO {
	private static final Logger LOGGER = Logger.getLogger(LiteratureBOImp.class);
    private LiteratureDAO literatureDAO;
	
	/**
	 * 增
	 * return 2添加成功，-1添加失败,5 重复
	 */
    @Override
	@SuppressWarnings("unchecked")
	public int add(Literature item) {
		int result = -1;
		//验证重复名
		LiteratureExample example = new LiteratureExample();
		example.createCriteria().andLiteraturenameEqualTo(item.getLiteraturename());
		List<Literature> list1 = (List<Literature>)literatureDAO.selectByExample(example);
		//验证重复索引号
		LiteratureExample example2 = new LiteratureExample();
		example2.createCriteria().andLindexEqualTo(item.getLindex());
		List<Literature> list2 = (List<Literature>)literatureDAO.selectByExample(example2);
		if (list1.size() == 0&&list2.size()==0) {
		try {
			item.setCategoryid(2);
			literatureDAO.insertSelective(item);
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
//			int[] ids = null;
//			for(int i=0;i<stringIds.length;i++){
//				ids[i]=Integer.parseInt(stringIds[i]);
//			}
			//System.out.println(ids[0]);
			try {
				for(int j=0;j<stringIds.length;j++){
					try {
						LiteratureExample example = new LiteratureExample();
						System.out.println(stringIds[j]);
						example.createCriteria().andLiteratureidEqualTo(stringIds[j]);
						literatureDAO.deleteByExample(example);
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
     * 查
     */
	@SuppressWarnings("unchecked")
	@Override
	public List<Literature> selectByExample(LiteratureExample example) {
		List<Literature> list = (List<Literature>)literatureDAO.selectByExample(example);
		return list;
	}
    /**
     * 改
     * return 0数据格式不正确，2修改成功，-1修改失败
     */
	@SuppressWarnings("unchecked")
	@Override
	public int update(String literatureJson, String literatureJson2) {
		int result = 0;
		if (literatureJson != null && !"".equals(literatureJson)) {
			JSONArray jsonArray = JSONArray.fromObject(literatureJson);
			List<Literature> literatureList = (List<Literature>) JSONArray.toCollection(jsonArray,
					Literature.class);
			JSONArray jsonArray2 = JSONArray.fromObject(literatureJson2);
			List<Literature> literatureList2 = (List<Literature>) JSONArray.toCollection(jsonArray2,
					Literature.class);
			LiteratureExample example = new LiteratureExample();
			if (result == 0) {
				int updatecount = 0;
				for(int i=0;i<literatureList.size();i++){
					example.createCriteria().andLiteratureidEqualTo(literatureList.get(i).getLiteratureid());
					try {
						literatureDAO.updateByExampleSelective(literatureList2.get(i), example);
						updatecount++;
					}
					catch (Exception e) {
				    		LOGGER.error(e.toString());
					}
				}
				if (updatecount == literatureList.size()) {
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

	public LiteratureDAO getLiteratureDAO() {
		return literatureDAO;
	}
	public void setLiteratureDAO(LiteratureDAO literatureDAO) {
		this.literatureDAO = literatureDAO;
	}
	@Override
	public int update(String literatureJson) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	/**
	 * 通过图书名搜索数据
	 */
    /* (non-Javadoc)
     * @see com.akun.elibrary.bo.LiteratureBO#selectByKey(java.lang.String)
     */
    @Override
    public List<Literature> selectByKey(String key) {
    	List<Literature> list = (List<Literature>)literatureDAO.selectByKey(key);
		return list;
    }
    
	
}
