package com.akun.elibrary.dao.imp;

import com.akun.elibrary.bean.Category;
import com.akun.elibrary.bean.CategoryExample;
import com.akun.elibrary.dao.CategoryDAO;

import java.util.List;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

public class CategoryDAOImpl extends SqlMapClientDaoSupport implements CategoryDAO {

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.category
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    public CategoryDAOImpl() {
        super();
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.category
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    public int countByExample(CategoryExample example) {
        Integer count = (Integer)  getSqlMapClientTemplate().queryForObject("dbo_category.ibatorgenerated_countByExample", example);
        return count.intValue();
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.category
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    public int deleteByExample(CategoryExample example) {
        int rows = getSqlMapClientTemplate().delete("dbo_category.ibatorgenerated_deleteByExample", example);
        return rows;
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.category
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    public int deleteByPrimaryKey(Integer categoryid) {
        Category key = new Category();
        key.setCategoryid(categoryid);
        int rows = getSqlMapClientTemplate().delete("dbo_category.ibatorgenerated_deleteByPrimaryKey", key);
        return rows;
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.category
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    public void insert(Category record) {
        getSqlMapClientTemplate().insert("dbo_category.ibatorgenerated_insert", record);
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.category
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    public void insertSelective(Category record) {
        getSqlMapClientTemplate().insert("dbo_category.ibatorgenerated_insertSelective", record);
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.category
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    @SuppressWarnings("unchecked")
	public List selectByExample(CategoryExample example) {
        List list = getSqlMapClientTemplate().queryForList("dbo_category.ibatorgenerated_selectByExample", example);
        
        return list;
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.category
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    public Category selectByPrimaryKey(Integer categoryid) {
        Category key = new Category();
        key.setCategoryid(categoryid);
        Category record = (Category) getSqlMapClientTemplate().queryForObject("dbo_category.ibatorgenerated_selectByPrimaryKey", key);
        return record;
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.category
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    public int updateByExampleSelective(Category record, CategoryExample example) {
        UpdateByExampleParms parms = new UpdateByExampleParms(record, example);
        int rows = getSqlMapClientTemplate().update("dbo_category.ibatorgenerated_updateByExampleSelective", parms);
        return rows;
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.category
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    public int updateByExample(Category record, CategoryExample example) {
        UpdateByExampleParms parms = new UpdateByExampleParms(record, example);
        int rows = getSqlMapClientTemplate().update("dbo_category.ibatorgenerated_updateByExample", parms);
        return rows;
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.category
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    public int updateByPrimaryKeySelective(Category record) {
        int rows = getSqlMapClientTemplate().update("dbo_category.ibatorgenerated_updateByPrimaryKeySelective", record);
        return rows;
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.category
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    public int updateByPrimaryKey(Category record) {
        int rows = getSqlMapClientTemplate().update("dbo_category.ibatorgenerated_updateByPrimaryKey", record);
        return rows;
    }

    /**
     * This class was generated by Apache iBATIS ibator.
     * This class corresponds to the database table dbo.category
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    private static class UpdateByExampleParms extends CategoryExample {
        private Object record;

        public UpdateByExampleParms(Object record, CategoryExample example) {
            super(example);
            this.record = record;
        }

        public Object getRecord() {
            return record;
        }
    }
}