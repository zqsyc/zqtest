<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="UTF-8"%>
<%@ include file="/inc/system/contenthead.inc"%>

<html>
<head>
<title><s:text name="titleUpdate" /></title>
 <script src="<%=contextPath%>/oacontent/my97datepicker/WdatePicker.js"></script>
<script language="JavaScript">
        function ev_checkval() {
  
            Validator.appendAtt(document.getElementById('form.operId'), {dataType:"Limit",min:"1",max:"60",msg:"<s:text name="operId"/>不可为空或长度超过限制"}) ;
            Validator.appendAtt(document.getElementById('form.operName'), {dataType:"Limit",min:"1",max:"60",msg:"<s:text name="operName"/>不可为空或长度超过限制"}) ;
            <s:if test="isNew">
            Validator.appendAtt(document.getElementById('form.pssword'), {dataType:"SafeString",max:"64",msg:"<s:text name="pwd"/>设置太简单(5位以上字母与数字组合),不符合安全要求"}) ;
            </s:if>
           // Validator.appendAtt(document.getElementById('form.state'), {dataType:"Limit",min:"1",max:"1",msg:"<s:text name="state"/>不可为空"}) ;
          //  Validator.appendAtt(document.getElementById('form.dutyCode'), {dataType:"Limit",min:"0",max:"64",msg:"<s:text name="dutyCode"/>长度超过限制"}) ;
           // Validator.appendAtt(document.getElementById('form.email'), {dataType:"Email",msg:"<s:text name="email"/>格式错误"}) ;
         //   Validator.appendAtt(document.getElementById('form.telno'), {dataType:"Phone",msg:"<s:text name="telno"/>格式错误"}) ;
          //  Validator.appendAtt(document.getElementById('form.address'), {dataType:"Limit",min:"0",max:"255",msg:"<s:text name="address"/>长度超过限制"}) ;

            //排列顺序 不为空时判断是否为数字
            if(document.getElementById('form.orderNum').value.replace(/(^\s*)|(\s*$)/g, "").length > 0){
            	Validator.appendAtt(document.getElementById('form.orderNum'), {dataType:"Currency",max:"32",msg:"排列顺序只许输入数字！"}) ;
            }
			         	
            return Validator.Validate(document.getElementById('formItem'),2) ;
        }

        function doSave(cmdSave) {
            var ret = ev_checkval(); 

            if ( ret ) {
                enable();

                formItem.action = contextPath + cmdSave;
                formItem.submit();
            }
            return false;
        }
        function beforeSave(){
	       // if (parent.roll_list != null){
	        //    var value = parent.roll_list.selectParam() ;
	            
	        //    if (value.length>0){
	         //       var f = document.all['formItem'] ;
	         //       for (var i = 0 ; i < value.length ; i++){
	         //           var input = document.createElement("input") ;
	          //          input.name="param._selectitem" ;
	          //          input.type="hidden" ;
	          //          input.value = value[i] ;
	          //          f.appendChild(input) ;
	           //     }
	            //document.all['param._selectitem'].value = value;
	          //  }
	       // }
            var o = doSave('/system/operator_save.do') ;
            
            //var p = f.childNodes;
            //var z = 0;
            //var _selectitem = new Array();
           // for(var j = 0 ; j < p.length ; j++) {
            //	if("param._selectitem" == p[j].name) {
            //		_selectitem[z++] = p[j];
            //	}
           // }
            
           // for(var k = 0 ; k < _selectitem.length ; k++) {
           // 	f.removeChild(_selectitem[k]);
           // }
            return o ;
        }

      //选择角色
        function selectRole() {		

    	    var operId = document.getElementById("form.operId").value;
    	    //alert(operId);

    	    if(operId == ""){

				alert("增加角色没有指定的工号");
				return;
        	}
    	    //alert(operId);
    	   
    	  
    	    var url = contextPath +"/system/role_roleList.do?operId=" + operId;	
    		var rtn = window.showModalDialog(url, "dialogWidth=1000px;dialogHeight=800px;status:no;scroll=yes;");
    		//parent.frames["roll_list"].document.refresh();
    		//alert( '<%=contextPath%>/system/setrole_myrole.do?operId='+operId);
    		window.parent.frames["roll_list"].location = '<%=contextPath%>/system/setrole_myrole.do?operId='+operId;
    		
    	    window.parent.frames["roll_list"].location.reload();     		
    	}

    	//密码重置
    	function resetPwd(){

    	    var operId = '<s:property  value="form.operId" />';

    	    if(operId == ""){

				alert("没有指定的工号");
				return;
        	}

    	    formItem.action = "<%=contextPath%>/system/operator_pwdReSet.do";
    	    formItem.submit();
    	}

    	//改变入职日期，动态改变年假
    	var count=0;
    	function changeDutyDays(){
    	  var dutyDate =  document.getElementById("form.dutyDate").value;
          if(dutyDate==''){
        	  document.getElementById("dutyDay").innerText=0; 
        	  return;
          }
          count=count+1;
          if(count==2){
        	   
        		$.ajax({
       		   	 type: "POST",
       		   	 url: '<%=contextPath%>/system/operator_doChangeDutyDays.do',
       		   	 data: {
       				   		dutyDate:dutyDate
       				   },
       				   	 dataType: 'text',
       				   	 timeout: 60000,
       				   	 success: function (data) {
       						//alert(data);
       						document.getElementById("dutyDay").innerText=data; 
       			         },
       			         error: function (msg) {
       			            return false;
       			         }
       				});
              count=0;
          }
        }
    	
    </script>
    <link rel="stylesheet" type="text/css" href="<%= contextPath %>/oacontent/css/component/contentframe.css">
</head>
<body>
<div class="content-main" style="height:400px;">
<s:form action="operator_save.do" id="formItem" method="post"
	theme="simple">
	<s:hidden name="isNew" />

	<s:hidden name="querymode" />

	<s:hidden name="param._orderby" />
	<s:hidden name="param._desc" />
	<s:hidden name="param._pageno" />
	<s:hidden name="param._pagesize" />

	<div class="table_div">
	<table class="top_table" border=0>
		<tr>
			<td width="210" class="AreaName" align="left" valign=middle><s:if
				test="isNew">
                                                                新增操作员
                 </s:if> <s:else>
                                                                修改操作员
                 </s:else></td>
			<td align="right"></td>
		</tr>
	</table>
	</div>
		
	<aa:zone name="contentZone">
		<div class="table_div">
		<table cellspacing="4" class="form_table1">
			<tr>
				<td align="right" class="form_table_right">
				<div class="field-require"><s:text name="operId" />:</div>
				</td>
				<td align="left" class="form_table_left"><s:if test="isNew">
					<s:textfield cssStyle="form_input_1x" id="form.operId" name="form.operId"
					maxlength="60"	/>
				</s:if> <s:else>
					<s:textfield cssStyle="form_input_1x" id="form.operId" name="form.operId"
						disabled="true" />
				</s:else></td>



				<td align="right" class="form_table_right">
				<div class="field-require"><s:text name="operName" />:</div>
				</td>
				<td align="left" class="form_table_left"><s:textfield
					cssStyle="form_input_1x" id="form.operName" name="form.operName" maxlength="32" /></td>
				<td align="right" class="form_table_right">
				<div class="field-require"><s:text name="state" />:</div>
				</td>
				<td align="left" class="form_table_left"><j:selector id="form.state"
					name="form.state" definition="$STATUSFLAG" /></td>
				
			</tr>
			<tr>
				
				
				
			</tr>
			<tr>
				<td align="right" class="form_table_right">
				<div>手机号码:</div>
				</td>
				<td align="left" class="form_table_left"><s:textfield id="form.telno"
					cssStyle="form_input_1x" name="form.telno" maxlength="64" /></td>

				<td align="right" class="form_table_right">办公电话:</td>
				<td align="left" class="form_table_left"><s:textfield
					cssStyle="form_input_1x" id="form.address" name="form.address" maxlength="64" /></td>
				<td align="right" class="form_table_right"><s:text
					name="orderNum" />:</td>
				<td align="left" ><s:textfield cssStyle="width:50px" id="form.orderNum" name="form.orderNum" maxlength="32" />
				<font color="red" size=2>(数字越小排序越前)</font></td>
			</tr>
			<tr>

				<s:if test="isNew">
					<td align="right" class="form_table_right">组织:</td>
					<td align="left" class="form_table_left"><s:select id="form.orgCode"
						name="form.orgCode" list="orgList" listKey="orgCode"
						listValue="orgName" headerKey="" headerValue="" /></td>
					</td>
				</s:if>
				<s:else>
					<td align="right" class="form_table_right"><s:text name="sex" />:</td>
					<td align="left" class="form_table_left"><j:selector id="form.sex"
					name="form.sex" definition="$SEX" /></td>
				</s:else>
				<s:if test="isNew">

					<td align="right" class="form_table_right">
					<div class="field-require"><s:text name="pwd" />:</div>
					</td>
					<td align="left" class="form_table_left"><input id="form.pssword"
						type="password" name="form.pssword" value=aaa888 /> <!--s   :textfield cssStyle="form_input_1x" name="form.pssword" maxlength="64"/-->
					</td>
				</s:if>
				<s:else>
					<td align="right" class="form_table_right"><s:text
						name="orgCode" />:
					</div>
					</td>
					<td align="left" class="form_table_left"><s:select id="param._se_orgCode"
						name="param._se_orgCode" list="orgList" listKey="orgCode"
						listValue="orgName" headerKey="" headerValue="" /></td>
				</s:else>
				<td align="right" class="form_table_right"><s:text
					name="dutyCode" />:</td>
				<td align="left" class="form_table_left"><s:select id="form.dutyCode"
						name="form.dutyCode" list="dutyList" listKey="dictCode"
						listValue="dictName" headerKey="" headerValue="" />
						<!-- <s:textfield id="form.dutyCode" cssStyle="form_input_1x" 
						name="form.dutyCode" maxlength="64" />--></td>

			</tr>
			<tr>

				
					<td align="right" class="form_table_right">登录别名:</td>
					<td align="left" class="form_table_left"><s:textfield id="form.postcode"
					cssStyle="form_input_1x" name="form.postcode" maxlength="64" /></td>
					</td>

                    <td align="right" class="form_table_right">参加工作时间:</td>
					<td align="left" class="form_table_left" colspan="1"><s:textfield id="form.dutyDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" cssClass="datebox" name="form.dutyDate" cssStyle="width:50% !important"  onchange="changeDutyDays()">
                	 <s:param name="value"><s:date name="form.dutyDate" format="yyyy-MM-dd"/></s:param></s:textfield>(年假  <span id="dutyDay"><s:property value="form.dutyDay"/></span> 天)
					
					</td>
					<td align="right" class="form_table_right">联系人姓名:</td>
					<td align="left" class="form_table_left"><s:textfield id="form.realName"
					cssStyle="form_input_1x" name="form.realName" maxlength="64" /></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</table>
		</div>
	</aa:zone>
<div class="clearfix" style="margin:20px 0; text-align:center">
		<s:i18n name="public">
		<!--j  :purChk permid="OPERATOR_ADD"-->
		<input type="button" class="return" id="btnSave" name="btnSave" onclick="return beforeSave();" value="<s:text name="button_save" />"/>

		<s:if test="!isNew">
			<input type="button" class="return" id="btnSave" name="btnSave" onclick="return selectRole();" value="增加角色"/>

			<input type="button" class="return" id="btnSave" name="btnSave" onclick="return resetPwd();" value="密码重置">
		</s:if>
		
		<input type="button" class="return" onclick="openTargetUri('operator_content','<%=contextPath%>/system/operator_list.do?param._se_orgCode=<s:property value="form.orgCode"/>');" value="<s:text name="button_return" />"/>
		
		<aa:zone name="errorZone">
			<s:property value="resultmsg" escape="false" />
		</aa:zone>
	</s:i18n>
	</div>
</s:form>
<script language="javascript"> 
	ajaxAnywhere.getZonesToReload = function(url,submitButton) {
		//判断逻辑,根据按钮，和url来判断要刷新哪个zone
		return "errorZone,contentZone";  //返回zon id。
	}
</script>
<script language="javascript">
	/*设置表单提交通过ajax进行*/
	ajaxAnywhere.substituteFormSubmitFunction();  

	/*控制那些按钮需要使用ajax效果,传按钮ID */
	ajaxAnywhere.substituteSubmitButtonsBehaviorByIDs(true,"btnSave");
</script>
<s:if test="isNew">
	<script>
var operId="${form.operId}";
if(operId!=""){
parent.parent.operator_content.location.reload() ;
}

</script>
	<script>
 if (parent.mybox != null) {

  parent.mybox.rows=document.body.scrollHeight + ",4,*";
  }
</script>
</s:if>
</body>
</html>
