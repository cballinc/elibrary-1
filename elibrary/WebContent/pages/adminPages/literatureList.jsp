<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript">
function imgDel(delId) {
	Ext.Msg.confirm("Confirm", "Delete？",
		function(btn) {		    
			if (btn == "yes") {		
				Ext.Msg.alert("Notice","Completed!");
			}
		}
	);
};
var uploadPhotoId = "";
var categoryStore = new Ext.data.JsonStore({
	url : "<%=request.getContextPath()%>/listCategory.action",
	root:"nodes",
	fields:["categoryid","categoryname"] 
});
categoryStore.load();
var store = new Ext.data.JsonStore({//数据源
	url : "<%=request.getContextPath()%>/listLiterature.action", 
	root : "nodes",
	totalProperty : "total",
	fields:["literaturename","categoryid","author","press","price","num","lindex","literatureid","outnum"]
});
/* function renderPhoto(val) {
	alert('<a href="#" target="_blank"><img src="' + val + 'FileImage"> Photo</a>');
    return '<a href="#" target=_blank"><img src="' + val + 'FileImage"> Photo</a>';
} */
var limit=100;
var sm=new Ext.grid.CheckboxSelectionModel();//全选/反选 
var cm = new Ext.grid.ColumnModel([
	sm,
	{
		header : "Name",
		dataIndex : "literaturename",
		width : 150,
		editor : new Ext.form.TextField({
			id : "pro_edField1"
		}),
		sortable : true
	},{
		header : "Category",
		dataIndex : "categoryid",
		width : 100,
		sortable : true,
		renderer:function(categoryid){
        var count = categoryStore.getCount();
        for(var i=0;i<=count;i++){
            var temp = categoryStore.getAt(i).get('categoryid');
        	if(temp==categoryid){
        	     return categoryStore.getAt(i).get('categoryname');  
        	}    
        }
	},
		editor : new Ext.form.ComboBox({
			      typeAhead: true,
			      triggerAction: 'all',
			      lazyRender : true,
			      allowBlank : false,
			      blankText : "Please select category",
			      editable : false,
			      mode : 'remote',
			      store:categoryStore,
			      valueField: 'categoryid',
			      displayField: 'categoryname'
		})
	},{
		header : "Index",
		dataIndex : "lindex",
		width : 50,
		editor : new Ext.form.TextField({
			id : "pro_edField6"
		}),
		sortable : true
	},{
		header : "Author",
		dataIndex : "author",
		width : 80,
		editor : new Ext.form.TextField({
			id : "pro_edField2"
		}),
		sortable : true
	},{
		header : "Press",
		dataIndex : "press",
		width : 150,
		editor : new Ext.form.TextField({
			id : "pro_edField3"
		}),
		sortable : true
	},{
		header : "Price",
		dataIndex : "price",
		width : 50,
		editor : new Ext.form.TextField({
			id : "pro_edField4"
		}),
		sortable : true
	},{
		header : "Number",
		dataIndex : "num",
		width : 50,
		editor : new Ext.form.TextField({
			id : "pro_edField5"
		}),
		sortable : true
	},{
		header : "Borrowd Number",
		dataIndex : "outnum",
		width : 70,
		editor : new Ext.form.TextField({
			id : "pro_edField6"
		}),
		sortable : true
	}
	/* ,{
		header : "Photo",
		dataIndex : "literatureid",
		width : 70,
		renderer: renderPhoto
	} */
]);

var literatureGrid = new Ext.grid.EditorGridPanel({
	bodyStyle : "padding:0px 0px 0px 0px",
	height : 440,
	width : 785,
	height:470,
	autoScroll : true,
	cm : cm,
	sm : sm,
	store : store

});
var literaturenameTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '<font color = "red">*</font>名称',
	allowBlank: false,
	blankText: 'Cannot be blank!',
	width:220,
	anchor:'90%',
	maxLength : 50,
	name:"literature.literaturename",
	maxLengthText : "Maximum length is 20"
});
var lindexTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '<font color = "red">*</font>Index',
	allowBlank: false,
	blankText: 'Cannot be blank!',
	width:220,
	anchor:'90%',
	maxLength : 10,
	name:"literature.lindex",
	maxLengthText : "Maximum length is 10"
});
var authorTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '<font color = "red">*</font>Author',
	allowBlank: false,
	blankText: 'Cannot be blank!',
	width:220,
	anchor:'90%',
	maxLength : 20,
	name:"literature.author",
	maxLengthText : "Maximum length is 20"
});
var pressTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '<font color = "red">*</font>Press',
	allowBlank: false,
	blankText: 'Cannot be blank',
	width:220,
	anchor:'90%',
	maxLength : 50,
	name:"literature.press",
	maxLengthText : "Maximum lengthe is 50"
});
var priceTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '<font color = "red">*</font>Price',
	allowBlank: false,
	blankText: 'Cannot be blank',
	width:220,
	anchor:'90%',
	maxLength : 50,
	name:"literature.price",
	maxLengthText : "Maximum length is 10"
});
var numTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '<font color = "red">*</font>Sum Number',
	allowBlank: false,
	blankText: 'Cannot be blank!',
	width:220,
	anchor:'90%',
	maxLength : 10,
	name:"literature.num",
	maxLengthText : "Manximum length is 10"
});
var categoryCombo=new Ext.form.ComboBox({
	margins:'0 0 0 0', 
	fieldLabel: '<font color = "red">*</font>Category',		    	
	allowBlank:false, 
	width:220,
	height: 25,
	anchor:'90%',
	editable : false,
	hiddenName:"category.categoryid",
	mode:'local',
	store:categoryStore,
	valueField: 'categoryid',
    displayField: 'categoryname',
	triggerAction : 'all'
});

var closeButton=new Ext.Button({
	text:'Close',				
	minWidth:80,
	handler:function(){
		addWindow.hide();
	}
});

//上传图片类型  
var img_reg = /\.([jJ][pP][gG]){1}$|\.([jJ][pP][eE][gG]){1}$|\.([gG][iI][fF]){1}$|\.([pP][nN][gG]){1}$|\.([bB][mM][pP]){1}$/;  
  
var win_uploadImage = new Ext.Window({  
    layout:'fit',  
    width:380,  
    closeAction:'hide',  
    height:380,  
    resizable:false,  
    shadow:false,  
    modal:true,  
    closable:true,  
    bodyStyle:'padding: 5 5 5 5',  
    animCollapse:true,  
    imageIndexName:'',  
    items:[{  
        xtype:'form',  
        id:'image-upload-form',  
        frame:true,  
        border:false,  
        isAdd:false,  
        enctype: 'multipart/form-data',  
        fileUpload : true,  
        layout : 'form',  
        items:[{  
           id : 'file-idx',  
           name : 'upload',  
           inputType : "file",  
           fieldLabel : '上传图片',  
           xtype : 'textfield',  
           blankText:'上传图片不能为空',  
           anchor : '100%'   
        },{  
           xtype : 'box',     
           id : 'browseImage',  
           fieldLabel : "预览图片",     
           autoEl : {  
               width : 300,  
               height : 300,  
               tag : 'img',  
                // type : 'image',  
               src : Ext.BLANK_IMAGE_URL,  
               style : 'filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale);',     
               complete : 'off',     
               id : 'imageBrowse'  
           }  
        }  
        ],  
        listeners : {     
            'render' : function(f) {  
                //  
                this.form.findField('file-idx').on('render', function() {  
                    //通過change事件,图片也动态跟踪选择的图片变化  
                    Ext.get('file-idx').on('change',  
                        function(field, newValue, oldValue) {  
                        //得到选择的图片路径  
                        var url = 'file://'+ Ext.get('file-idx').dom.value;  
                        //alert("url = " + url);     
                        //是否是规定的图片类型  
                        if (img_reg.test(url)) {  
                            if (Ext.isIE) {  
                                var image = Ext.get('imageBrowse').dom;     
                                image.src = Ext.BLANK_IMAGE_URL;// 覆盖原来的图片  
                                image.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = url;     
                            }// 支持FF  
                            else {  
                            	//alert('not ie');
                            	alert(Ext.get('file-idx').dom.files.item(0).getAsDataURL());
                                Ext.get('imageBrowse').dom.src = Ext.get('file-idx').dom.files.item(0).getAsDataURL();  
                            }  
                        }  
                    }, this);     
                }, this);     
            }     
        },   
        buttons:[{  
           text:'关闭',  
           handler:function(){  
                win_uploadImage.hide();  
           }  
           },{  
                text:'上传',  
                handler:function() {  
                    var furl="";  
                    furl = Ext.getCmp('image-upload-form').form.findField('upload').getValue();  
                    var type = furl.substring(furl.length - 3).toLowerCase();  
                    if (furl == "" || furl == null) {  
                        return;  
                    }  
                    if (type != 'jpg' && type != 'bmp' && type != 'gif' && type != 'png') {  
                        alert('仅支持jpg、bmp、gif、png格式的图片');  
                        return;  
                    }  
                    //alert(uploadPhotoId);
                    if (uploadPhotoId==""){
                    	alert('You have not select a book!');
                    }
                   Ext.getCmp('image-upload-form').form.submit({  
                        clienValidation:true,  
                        waitMsg:'正在上传请稍候',  
                        waitTitle:'提示',  
                        url:"<%=request.getContextPath()%>/uploadPhoto.action",
                        params: {uploadPhotoId: uploadPhotoId },
                        method:'POST',  
                        success:function(form,action){  
                            var picName = action.result.data;  
                            if(win_uploadImage.imageIndexName!=''){  
                                Ext.getCmp(win_uploadImage.imageIndexName).setValue(picName);  
                            }  
                            //reset form  
                            Ext.getCmp('image-upload-form').form.el.dom.reset();  
                            if (Ext.isIE) {  
                                var i_image = Ext.get('imageBrowse').dom;  
                                i_image.src = Ext.BLANK_IMAGE_URL;  
                                i_image.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = Ext.BLANK_IMAGE_URL;  
                            }else{  
                                Ext.get('imageBrowse').dom.src = Ext.BLANK_IMAGE_URL;  
                            }  
                              
                            win_uploadImage.hide();  
                            uploadPhotoId = "";
                        },  
                        failure:function(form,action){  
                            Ext.MessageBox.show({title: '失败',msg: '上传失败!',buttons: Ext.MessageBox.OK,icon: Ext.MessageBox.ERROR});  
                        }  
                   });
                }  
           }  
       ]  
}]  
});  

var addPanel = new Ext.form.FormPanel( {
	url : "<%=request.getContextPath()%>/addLiterature.action",
	method : "post",
	buttonAlign : 'center',
	labelAlign : 'right',				
	width : 500,
	//height : 1000,
	autoHeight:true,
	layout : "column",
	items:[{
		//控制padding
		columnWidth : 1,
		layout : 'form',
		height : 30,
		border : false
		
	}, {
		//名称
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : literaturenameTextFeild
	},{
		//索引号
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : lindexTextFeild
	},{
		//类别
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : categoryCombo
	}, {
		//作者 
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : authorTextFeild
	},{
		//出版社
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : pressTextFeild
	}, {
		//价格 
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : priceTextFeild
	},{
		//总数
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : numTextFeild
	}],
	buttons:[{
		text:'Save',
		handler:function(){
			addPanel.getForm().submit({
				waitTitle : 'Wait',  
                waitMsg : 'Processing the form, please wait...', 
				success : function(f, rep) {
					Ext.MessageBox.alert("Notice", rep.result.msg);
					addWindow.hide();
					store.reload();
				}
			});
		}
	},closeButton]
});
var addWindow = new Ext.Window( {
	layout : 'fit',
	hidden : true,
	width : 400,
	closeAction : 'hide',
	//height : 260,
	autoHeight:true,
	resizable : false,
	shadow : true,
	modal : true,
	closable : true,
	draggable :false,
	bodyStyle : 'padding:5 5 5 5',
	animCollapse : true,
	items : [ addPanel ]
});

var query = new Ext.form.TextField({
	id:"queryforlist",
	anchor:'90%',
	enableKeyEvents : true,
	initEvents: function() {
		var keyPress = function(e){  
			if (e.getKey() == e.ENTER) {  
				store.reload({
					params : {
						key : query.getValue(),
						start : 0,
						limit : limit
					}
				});
			} 
		};  
		this.el.on("keypress", keyPress, this);
	}
});
store.on("beforeload", function(){
	store.baseParams.searchAddition = query.getRawValue();
});
var queryLabel = new Ext.form.Label({
	text:'Category Name：'
});

var queryButton = new Ext.Button({
	text:'Search',
	width:'30',
	handler:function(){
		var queryValue = query.getValue();
		store.reload({
			params :{key:queryValue,start:0,limit:limit}
		});
	}
});

//资料列表主显panel 
var literaturePanel = new Ext.Panel( {
	title : "<center><p><font size=3>Book Management</font></p></center>",
	width : "768",
	frame : true,
	height : 510,
	tbar : ['-', {
		text : "Add",
		width:80,
		handler : function() {						
			addWindow.show();//添加资料信息弹窗
			addPanel.form.reset();
			addWindow.setTitle('Add Book Info');							
		}
	},'-', {
		text : "Upload Photo",
		width:80,
		handler : function() {					
			var wh =  literatureGrid.getSelectionModel().getSelections();
			if(wh.length<1 || wh.length>1){
				Ext.Msg.alert('Notice', 'Please selece only one record!');
				return;
			}
			uploadPhotoId =wh[0].get("literatureid");
			win_uploadImage.show();
			win_uploadImage.setTitle('Upload Photo');							
		}
	},'-',{
		xtype :"button",
		width:80,
		text:"Delete",
		handler:function(){
			var wh =  literatureGrid.getSelectionModel().getSelections();//通过多选框删除
			var ids="";
			if(wh.length<1){
				Ext.Msg.alert('Notice', 'Please selece at least one record!');
				return;
			}
			for(var i=0;i<wh.length;i++){
				ids+=wh[i].get("literatureid")+",";// 获取id
			}
			
			if(ids!=""){
				ids=ids.substring(0,ids.length-1);
			}
            //alert(ids[0]+10);
			Ext.Msg.confirm("Comfirm","Delete？",function(btn){

				if (btn == 'yes'){
					 Ext.Ajax.request({//删除action
						url: '<%=request.getContextPath()%>/deleteLiterature.action',
						success: function(res){
							Ext.Msg.alert('Notice', res.responseText);
							store.reload();//重新加载列表
						},
						failure: function(res){
							alert(res);
						},
						params: {idsToDelete: ids }//传给deleteAction的参数（学生学号）
					});
				}
			});
		}
	/* },"->",{//图片上传
		xtype: 'triggerfield',  
		fieldLabel: '图像1',  
		labelAlign: 'left', 
		//text : 'Photo',
		id:'idx_CheckPic1',  
		readOnly:true,  
		width: 180,  
		//triggerClass:'x-form-image-trigger',  
		//name: 'checkPic1',  
		emptyText:'123',
		onTriggerClick : function(){  
			//alert("	123");
		    win_uploadImage.setTitle("上传图片-" + "图像1");  
		    win_uploadImage.imageIndexName = 'idx_CheckPic1';  
		    win_uploadImage.show();   
		}   */
	},"->",{//搜索框
		xtype :"label",
		text:"Book Name Keywords:",
		width:120
	},query,"&nbsp",queryButton],
	items:[{
		columnWidth : 0.5,
		layout : 'form',
		border : false,
		items : literatureGrid
	}],
	//右下角显示分页信息与保存按钮 
	bbar : new Ext.PagingToolbar( {
		pageSize : 15,
		displayInfo : true,
		displayMsg : 'List {0} to {1} records，total {2} ',
		store:store,
		emptyMsg : "No record"
	}),	
	buttons :[
	{
		text:'Save',
		xtype:'button',
		handler : function() {
			var mr = store.getModifiedRecords(); // 获取所有更新过的记录
			if (mr.length > 0) {
				var tempUpdate = "[";
				for (var i = 0; i < mr.length; i++) {
					if (mr[i].get("lindex").trim() != null
					 && mr[i].get("lindex").trim() != ""&&mr[i].get("literaturename").trim() != null
					  && mr[i].get("literaturename").trim() != "") {
						var data="{";
						data+='"literatureid":"'+mr[i].get("literatureid")+' ",';
						data+='"literaturename":"'+mr[i].get("literaturename")+' ",';
						data+='"lindex":"'+mr[i].get("lindex")+' ",';
						data+='"categoryid":"'+mr[i].get("categoryid")+' ",';
						data+='"author":"' + mr[i].get("author")+' ",';
						data+='"press":"'+mr[i].get("press")+' ",';
						data+='"price":"'+mr[i].get("price")+' ",';
						data+='"num":"' + mr[i].get("num")+' ",';
						data+="}";
						tempUpdate+=data+",";
					}
				}
				if(tempUpdate != "["){
					tempUpdate=tempUpdate.substring(0,tempUpdate.length-1);
				}
				tempUpdate+="]";
                alert("tempUpdate");
                alert(tempUpdate);
				var tempUpdate2 = "[";
				for (var i = 0; i < mr.length; i++) {
					if (mr[i].get("lindex").trim() != null
					 && mr[i].get("lindex").trim() != ""&&mr[i].get("literaturename").trim() != null
					  && mr[i].get("literaturename").trim() != "") {
						var data="{";
						data+='"literaturename":"'+mr[i].get("literaturename")+' ",';
						data+='"lindex":"'+mr[i].get("lindex")+' ",';
						data+='"categoryid":"'+mr[i].get("categoryid")+' ",';
						data+='"author":"' + mr[i].get("author")+' ",';
						data+='"press":"'+mr[i].get("press")+' ",';
						data+='"price":"'+mr[i].get("price")+' ",';
						data+='"num":"' + mr[i].get("num")+' ",';
						data+="}";
						tempUpdate2+=data+",";
					}
				}
				if(tempUpdate2 != "["){
					tempUpdate2=tempUpdate2.substring(0,tempUpdate.length-1);
				}
				tempUpdate2+="]";
				alert("tempUpdate2");
                alert(tempUpdate2);
				if (tempUpdate.length >2) {
					Ext.Ajax.request({//更新ACTION
						url : '<%=request.getContextPath()%>/updateLiterature.action',
						params : {
							updateList : tempUpdate,
							updateList2 : tempUpdate2
						},
						method : 'POST',
						success: function(res){
							Ext.Msg.alert('Notice', res.responseText);
							store.reload();
							mr.length=0;			  											
						},
						failure : function(response, options) {}
					});
				}
			}
		}
	}]
});

Ext.onReady(function() {
	Ext.QuickTips.init();//表单错误提示
	Ext.form.Field.prototype.msgTarget = 'under';
	literaturePanel.render("literatureListPanel");
	store.load({params : {key:''}});//传分页控制参数 
});
	
</script>
</head>
<body>
<div id="literatureListPanel"></div>
</body>
</html>