<!DOCTYPE html>
<html>
<head>
    <title>上传报告查询</title>
<#import "/common/common.macro.ftl" as netCommon>
<@netCommon.commonStyle />
    <!-- DataTables -->
    <link rel="stylesheet" href="${request.contextPath}/static/adminlte/plugins/datatables/dataTables.bootstrap.css">

</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <!-- header -->
<@netCommon.commonHeader />
    <!-- left -->
<@netCommon.commonLeft />

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header" id="selectAll">
            <h1>上传报告查询-上海资信息<small>调度管理平台</small></h1>
            <ol class="breadcrumb">
                <li><a><i class="fa fa-dashboard"></i>调度中心</a></li>
                <li class="active">上传报告查询-上海资信息</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-header">
                            <h3 class="box-title">上传报告查询-上海资信</h3>
                            <#--<button class="btn btn-info btn-xs job_operate" id="querySql" type="button">数据查询</button>-->
                            <#--<button class="btn btn-info btn-xs job_operate" id="uploadDetail" onclick="showAll()" type="button">上报详情</button>-->
                            <button class="btn btn-info btn-xs job_operate" id="uploadExcelNew" type="button">合道上传</button>
                            <button class="btn btn-info btn-xs job_operate" id="uploadByExcel" type="button">Excel上报</button>
                            <button class="btn btn-info btn-xs job_operate" id="delMsg" type="button">删除上报</button>
                        </div>

                        <div class="box-body" id="selAll">
                            <table id="job_list" class="table table-bordered table-striped">
                                <thead>
                                <tr>
                                    <th>上传文件名</th>
                                    <#--<th>文件类型</th>-->
                                    <th>加工时间</th>
                                    <th>上报时间</th>
                                    <th>上报状态</th>
                                    <th>上报结果</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <#if ziplist?exists && ziplist?size gt 0>
                                    <#list ziplist as item>
                                    <tr>
                                        <td>
                                        ${item['filename']}
                                        </td>
                                        <#--<td>-->
                                            <#--<#if item['filename']?substring(23,24) =="1">-->
                                                <#--<span>上报报文</span>-->
                                            <#--<#else>-->
                                                <#--<span>删除报文</span>-->
                                            <#--</#if>-->
                                        <#--</td>-->
                                        <td>
                                        ${item['createAt']?string("yyyy-MM-dd HH:mm:ss")}
                                        </td>
                                        <td>
                                        ${item['updateAt']?string("yyyy-MM-dd HH:mm:ss")}
                                        </td>
                                        <td id="shzxStatus">
                                            <#if 0=item.isUp>
                                                <span>尚未上报</span>
                                            <#elseif 1=item.isUp>
                                                <span>上报成功</span>
                                            <#elseif 9=item.isUp>
                                                <span>上报失败</span>
                                            <#else>
                                                <span>状态异常</span>
                                            </#if>
                                        </td>
                                        <td>
                                        <#if item['org'] =="jimu">
                                            <button class="btn btn-info btn-xs job_operate" onclick="showOne('${item['id']}','${item['filename']}')" type="button">详情</button>
                                        <#else>
                                            <button class="btn btn-info btn-xs job_operate" onclick="showOneAqy('${item['id']}','${item['filename']}')" type="button">安趣盈详情</button>
                                        </#if>
                                        </td>
                                        <td>
                                            <#if item['org'] =="jimu">
                                                <button class="btn btn-info btn-xs job_operate" onclick="upZip('${item['id']}','${item['isUp']}','jimu')"  type="button">上报</button>
                                            <#else>
                                                <button class="btn btn-info btn-xs job_operate" onclick="upZip('${item['id']}','${item['isUp']}','aqy')"  type="button">安趣盈上报</button>
                                            </#if>
                                        </td>
                                    </tr>
                                    </#list>
                                </#if>
                                </tbody>
                                <tfoot>
                                <#--<tr>-->
                                    <#--<th>上传文件名</th>-->
                                    <#--<th>加工时间</th>-->
                                    <#--<th>上报时间</th>-->
                                    <#--<th>上报状态</th>-->
                                    <#--<th>上传结果</th>-->
                                    <#--<th>操作</th>-->
                                <#--</tr>-->
                                </tfoot>
                            </table>
                        </div>

                        <div class="box-body" id="selOne" style="display:none;">
                            <table class="table table-bordered table-striped">
                                <tr>
                                    <td colspan="7" align="left" >
                                        当前文件为：<span id="showExcelId" ></span>
                                    </td>
                                </tr>
                            </table>
                            <table class="table table-bordered table-striped">
                                <thead>
                                <tr>
                                    <th>文件上传时间</th>
                                    <th>加载进度</th>
                                    <th>数据正确数量</th>
                                    <th>数据错误数量</th>
                                    <th>加载数据总数</th>
                                    <th>正确率</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>
                                        <span id = "uploadTime"></span>
                                    </td>
                                    <td>
                                        <span id = "uploading"></span>
                                    </td>
                                    <td>
                                        <span id = "uploadcounts"></span>
                                    </td>
                                    <td>
                                        <span id = "uploadcounte"></span>
                                    </td>
                                    <td>
                                        <span id = "uploadcount"></span>
                                    </td>
                                    <td>
                                        <span id = "correctrate"></span>
                                    </td>
                                    <td>
                                        <button class="btn btn-info btn-xs job_operate" id="downloadExcel" onclick="downloadEcel()" type="button">下载全量报告</button>
                                        <input type="text" style="display: none" id="excelurl" />
                                        <button class="btn btn-info btn-xs job_operate" id="downloadTxt" onclick="downloadTxt()" type="button">下载错误报告</button>
                                        <input type="text" style="display: none" id="txturl" />
                                        <button class="btn btn-info btn-xs job_operate" id="goBack" type="button">返回</button>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="box-body" id="AllResult" style="display:none;">
                            <table class="table table-bordered table-striped">
                                <tr>
                                    <td colspan="7" align="left" >
                                        本次上报详情如下：<span id="showExcelId" ></span>
                                    </td>
                                </tr>
                            </table>
                            <table class="table table-bordered table-striped">
                                <thead>
                                <tr>
                                    <th>上报时间</th>
                                    <th>上报进度</th>
                                    <th>数据正确数量</th>
                                    <th>数据错误数量</th>
                                    <th>加载数据总数</th>
                                    <th>正确率</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>
                                        <span id = "uploadTimeAll"></span>
                                    </td>
                                    <td>
                                        <span id = "uploadingAll"></span>
                                    </td>
                                    <td>
                                        <span id = "uploadTrueAll"></span>
                                    </td>
                                    <td>
                                        <span id = "uploadFalseAll"></span>
                                    </td>
                                    <td>
                                        <span id = "uploadTotalAll"></span>
                                    </td>
                                    <td>
                                        <span id = "uploadRateAll"></span>
                                    </td>
                                    <td>
                                        <button class="btn btn-info btn-xs job_operate" id="goBackTotal" type="button">返回</button>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="box-body" id="querySqlDiv" style="display:none;">
                            <form id="querSqlForm">
                                <table class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th colspan="2">通过积木编号（业务号）查询数据库中的信息</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td style="widows: 270px;" align="right">
                                            <span>需要查询的积木编号：</span>
                                        </td>
                                        <td>
                                            <textarea name="jmbIds" id="jmbId" style="width: 500px; height: 100px;"></textarea>
                                        </td>
                                        <td style="width: 150px;">
                                            <button class="btn btn-info btn-xs job_operate" id="uploadExcelbtn" onclick="querySql()" type="button">生成Excel</button>
                                        </td>
                                    </tr>
                                    </tbody>
                                    <tfoot id="showExcelDown">

                                    </tfoot>
                                </table>
                            </form>
                        </div>
                    <#--上传Excel-->
                        <div class="box-body" id="uploadFile" style="display:none;">
                            <form id="excelUpload">
                                <table class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th colspan="2">Excel文件上传(暂只支持文件后缀名为.xls，即Excel 97-03版本)</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>
                                            <span>要上传的文件</span>
                                        </td>
                                        <td>
                                            <input type="file" id="excelName" name = "excelPath">
                                        </td>
                                        <td>
                                                <button class="btn btn-info btn-xs job_operate" style="display:none;" id="uploadExcelSingle" onclick="uploadFilesSingle()" type="button">Excel上报</button>
                                                <button class="btn btn-info btn-xs job_operate" style="display:none;" id="uploadExcel" onclick="uploadFiles()" type="button">合道校验</button>
                                            <button class="btn btn-info btn-xs job_operate" id="goBackE" type="button">返回</button>
                                        </td>
                                    </tr>
                                    </tbody>
                                    <tfoot id="failExcelDown">
                                    </tfoot>
                                </table>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
                        <div class="box-body" id="delMsgDiv" style="display:none;">
                            <form id="delMsgForm">
                                <table class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th colspan="2">通过积木编号（业务号）报送给上海资信的数据</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>
                                            <span>需要删除的积木编号：</span>
                                        </td>
                                        <td>
                                            <input type="file" name="delFileName" />
                                        </td>
                                        <td>
                                            <button class="btn btn-info btn-xs job_operate" id="uploadDel" onclick="upDel()" type="button">上传并删除</button>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
        </section>

        <section class="content" style="display: none" id = "selectOne">


        </section>

    </div>

    <!-- footer -->
<@netCommon.commonFooter />
    <!-- control -->
<@netCommon.commonControl />
</div>


<@netCommon.commonScript />
<@netCommon.comAlert />
<!-- DataTables -->
<script src="${request.contextPath}/static/adminlte/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="${request.contextPath}/static/adminlte/plugins/datatables/dataTables.bootstrap.min.js"></script>
<script src="${request.contextPath}/static/plugins/jquery/jquery.validate.min.js"></script>
<script>var base_url = '${request.contextPath}';</script>
<script>

    function delOne(values){
        $.ajax({
            type : 'GET',
            url : '/QueryShzx/delOne',
            data : {
                "serilano" :	values,
                "random"    :Math.random()
            },
            dataType : "text",
            success : function(resultString){
                if(resultString == "success"){
                    ComAlert.show(1, "删除成功!", function(){
                        window.location.reload();
                    });
                }
            },
        });
    }
    //上报文件上传
    function uploadFiles(){
        var filesPaht = $("#excelName").val();
        if(filesPaht == ""){
            ComAlert.show(2, "上传文件不能为空！");
            return false;
        }
        var formData = new FormData($( "#excelUpload" )[0]);
        $.ajax({
            url: '/QueryShzx/fileUpload' ,
            type: 'POST',
            data: formData,
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            success: function (resultString) {
                if(resultString == "success"){
                    ComAlert.show(1, "上传并校验成功，请点击手工补报对合道数据进行上报", function(){
                        window.location.reload();
                    });
                }else if(resultString == "An error occurred in the upload!"){
                    ComAlert.show(2, "上传时发生一个错误，请重新上传。", function(){
                        window.location.reload();
                    });
                }else if(resultString == "An error occurred in the filename!"){
                    ComAlert.show(2, "上传文件名不符合要求。正确格式应该以日期开头为：举例“2016-08-11合道补报”", function(){
                        window.location.reload();
                    });
                }else if(resultString == "An error occurred in the read!"){
                    ComAlert.show(2, "Excel读取时发生一个错误，请确保Excel数据格式符合要求", function(){
                        window.location.reload();
                    });
                }else if(resultString == "An error occurred in the insert!"){
                    ComAlert.show(2, "插入数据库时发生一个错误，请联系管理员查看日志", function(){
                        window.location.reload();
                    });
                }else if(resultString == "fail to false") {
                    ComAlert.show(2, "生成错误数据Excel时出错", function () {
                        window.location.reload();
                    });
                }else {
                    ComAlert.show(2, "校验不通过，下载错误数据", function(){
                        var results,fileName, filePath;
                        var fileInfos = resultString.split(",");
                        results = fileInfos[0];
                        filePath = fileInfos[1];
                        fileName = fileInfos[2];
                        $("#failExcelDown").html(
                                "<tr>" +
                                "<td align='left'>生成的错误数据excel为：</td>" +
                                "<td>"+fileName+"<input type='text' style='display: none' value='"+filePath+"' id='downXls' /></td>" +
                                "<td><button class='btn btn-info btn-xs job_operate' id='uploadExcel' onclick='downloadEcel1()' type='button'>下载错误数据Excel</button></td>" +
                                "</tr>"
                        );
                        $("#uploadExcelbtn").removeAttr("disabled");
                        $("#jmbId").removeAttr("disabled");
                    });
                }
            },
        });
    }

    //上报文件上传
    function uploadFilesSingle(){
        var filesPaht = $("#excelName").val();
        if(filesPaht == ""){
            ComAlert.show(2, "上传文件不能为空！");
            return false;
        }
        var formData = new FormData($( "#excelUpload" )[0]);
        $.ajax({
            url: '/QueryShzx/fileUploadSingle' ,
            type: 'POST',
            data: formData,
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            success: function (resultString) {
                if(resultString == "success"){
                    ComAlert.show(1, "上传并校验成功，请点击手工补报对上传数据进行打包", function(){
                        window.location.reload();
                    });
                }else if(resultString == "An error occurred in the upload!"){
                    ComAlert.show(2, "上传时发生一个错误，请重新上传。", function(){
                        window.location.reload();
                    });
                }else if(resultString == "An error occurred in the filename!"){
                    ComAlert.show(2, "上传文件名不符合要求。正确格式应该以日期开头为：举例“2016-12-23上海资信.xls”", function(){
                        window.location.reload();
                    });
                }else if(resultString == "An error occurred in the read!"){
                    ComAlert.show(2, "Excel读取时发生一个错误，请确保Excel数据格式符合要求", function(){
                        window.location.reload();
                    });
                }else if(resultString == "An error occurred in the insert!"){
                    ComAlert.show(2, "插入数据库时发生一个错误，请联系管理员查看日志", function(){
                        window.location.reload();
                    });
                }else if(resultString == "fail to false") {
                    ComAlert.show(2, "生成错误数据Excel时出错", function () {
                        window.location.reload();
                    });
                }else {
                    ComAlert.show(2, "校验不通过，下载错误数据", function(){
                        var results,fileName, filePath;
                        var fileInfos = resultString.split(",");
                        results = fileInfos[0];
                        filePath = fileInfos[1];
                        fileName = fileInfos[2];
                        $("#failExcelDown").html(
                                "<tr>" +
                                "<td align='left'>生成的错误数据excel为：</td>" +
                                "<td>"+fileName+"<input type='text' style='display: none' value='"+filePath+"' id='downXls' /></td>" +
                                "<td><button class='btn btn-info btn-xs job_operate' id='uploadExcel' onclick='downloadEcel1()' type='button'>下载错误数据Excel</button></td>" +
                                "</tr>"
                        );
                        $("#uploadExcelbtn").removeAttr("disabled");
                        $("#jmbId").removeAttr("disabled");
                    });
                }
            },
        });
    }

    //下载Excel
    function downloadEcel(){
        var xlsurl = $("#showExcelId").text();//获取到Excel路径
        if(xlsurl == ""){
            ComAlert.show(2, "未查询到要下载的文件!", function(){
                window.location.reload();
            });
            return;
        }
        var link="/QueryShzx/downloadXls?url="+xlsurl+"&random="+Math.random();
        window.open(link);
        return false;
    }

    //下载合道错误Excel
    function downloadEcel1(){
        var xlsurl = $("#downXls").val();//获取到Excel路径
        var link="/QueryShzx/downloadXlsHd?url="+xlsurl+"&random="+Math.random();
        window.open(link);
        return false;
    }

    //下载反馈
    function downloadTxt(){
        var txtrul = $("#txturl").val();//获取到要下载的错误报告地址
        var link="/QueryShzx/downloadTxt?url="+txtrul+"&random="+Math.random();
        window.open(link);
        return false;
    }

    //删除文件上传
    function upDel(){
        var filesPah = $("#delFileName").val();
        if(filesPah == ""){
            ComAlert.show(2, "上传文件不能为空！");
            return false;
        }
        var formData = new FormData($( "#delMsgForm" )[0]);
        $.ajax({
            url: '/QueryShzx/delExcel' ,
            type: 'POST',
            data: formData,
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            success: function (resultString) {
                if(resultString == "success"){
                    ComAlert.show(1, "上传并校验成功，请点击加工结果对要删除的数据进行上报上报", function(){
                        window.location.reload();
                    });
                }else if(resultString == "error in upload"){
                    ComAlert.show(2, "上传时发生一个错误，请重新上传。", function(){
                        window.location.reload();
                    });
                }else if(resultString == "error in read"){
                    ComAlert.show(2, "Excel读取时发生一个错误，请确保Excel数据、格式符合要求", function(){
                        window.location.reload();
                    });
                }else if(resultString == "error in insert"){
                    ComAlert.show(2, "插入数据库时发生一个错误，请联系管理员查看日志", function(){
                        window.location.reload();
                    });
                }else if(resultString == "error in zip") {
                    ComAlert.show(2, "打包zip时候出错", function () {
                        window.location.reload();
                    });
                }
            },
        });
    }
    //查询单条上报结果
    function showOne(value1,value2){
        $("#showExcelId").html(value2);
        $("#selOne").show();
        $("#AllResult").hide();
        $("#uploadFile").hide();
        $("#selAll").hide();
        $("#querySqlDiv").hide();
        $("#delMsgDiv").hide();
//        $.ajax({
//            type: 'GET',
//            url: '/QueryShzx/downloadExcel',
//            data: {
//                "serilano": value2,
//                "random"    :Math.random()
//            },
//            dataType: "text",
//            success: function (resultString) {
//                $("#excelurl").val(resultString);
//            },
//        });
        $.ajax({
            type : 'GET',
            url : '/QueryShzx/showOne',
            data : {
                "serilano" :	value1,
                "random"    :Math.random()
            },
            dataType : "text",
            success : function(resultString){
                $("#uploadTime").text("");
                $("#uploading").text("");
                $("#uploadcounts").text("");
                $("#uploadcounte").text("");
                $("#uploadcount").text("");
                $("#correctrate").text("");
                $("#txturl").text("");
                var rs = resultString.split("@");
                for(var i = 0 ; i < rs.length ; i ++){
                    var rss = rs[i].split(",");
                    if(rss[0] == "uploadTime"){
                        if(rss[1] == "loading"){
                            $("#uploadTime").text("暂无相关信息，稍后查询");
                            return;
                        }else if(rss[1] == "not found files !"){
                            $("#uploadTime").text("暂无相关信息，稍后查询");
                            return;
                        }else{
                            var temp =rss[1];
//                            alert(temp);
                            $("#uploadTime").text(temp);
                        }
                    }
                    if(rss[0] == "uploading"){
                        if(rss[1] == "show"){
                            $("#uploading").text("加载完成");
                        }else if(rss[1] == "loading"){
                            $("#uploading").text("loading");
                        }
                    }
                    if(rss[0] == "uploadcounts"){
                        $("#uploadcounts").text(rss[1]);
                    }
                    if(rss[0] == "uploadcounte"){
                        $("#uploadcounte").text(rss[1]);
                    }
                    if(rss[0] == "uploadcount"){
                        $("#uploadcount").text(rss[1]);
                    }
                    if(rss[0] == "correctrate"){
                        $("#correctrate").text(rss[1]);
                    }
                    if(rss[0] == "url"){
                        $("#txturl").val(rss[1]);
                    }
                }
            },
        });
    }
    function showOneAqy(value1,value2){
        $("#showExcelId").html(value2);
        $("#selOne").show();
        $("#AllResult").hide();
        $("#uploadFile").hide();
        $("#selAll").hide();
        $("#querySqlDiv").hide();
        $("#delMsgDiv").hide();
//        $.ajax({
//            type: 'GET',
//            url: '/QueryShzx/downloadExcel',
//            data: {
//                "serilano": value2,
//                "random"    :Math.random()
//            },
//            dataType: "text",
//            success: function (resultString) {
//                $("#excelurl").val(resultString);
//            },
//        });
        $.ajax({
            type : 'GET',
            url : '/QueryShzx/showOne',
            data : {
                "serilano" :	value1,
                "flag":"aqy",
                "random"    :Math.random()
            },
            dataType : "text",
            success : function(resultString){
                $("#uploadTime").text("");
                $("#uploading").text("");
                $("#uploadcounts").text("");
                $("#uploadcounte").text("");
                $("#uploadcount").text("");
                $("#correctrate").text("");
                $("#txturl").text("");
                var rs = resultString.split("@");
                for(var i = 0 ; i < rs.length ; i ++){
                    var rss = rs[i].split(",");
                    if(rss[0] == "uploadTime"){
                        if(rss[1] == "loading"){
                            $("#uploadTime").text("暂无相关信息，稍后查询");
                            return;
                        }else if(rss[1] == "not found files !"){
                            $("#uploadTime").text("暂无相关信息，稍后查询");
                            return;
                        }else{
                            var temp =rss[1];
//                            alert(temp);
                            $("#uploadTime").text(temp);
                        }
                    }
                    if(rss[0] == "uploading"){
                        if(rss[1] == "show"){
                            $("#uploading").text("加载完成");
                        }else if(rss[1] == "loading"){
                            $("#uploading").text("loading");
                        }
                    }
                    if(rss[0] == "uploadcounts"){
                        $("#uploadcounts").text(rss[1]);
                    }
                    if(rss[0] == "uploadcounte"){
                        $("#uploadcounte").text(rss[1]);
                    }
                    if(rss[0] == "uploadcount"){
                        $("#uploadcount").text(rss[1]);
                    }
                    if(rss[0] == "correctrate"){
                        $("#correctrate").text(rss[1]);
                    }
                    if(rss[0] == "url"){
                        $("#txturl").val(rss[1]);
                    }
                }
            },
        });
    }
    //查询本次上报结果
    function showAll(){
        $("#showExcelId").html();
        $("#AllResult").show();
        $("#selOne").hide();
        $("#uploadFile").hide();
        $("#selAll").hide();
        $("#querySqlDiv").hide();
        $("#delMsgDiv").hide();
        ComAlert.show(1, "正在查询本次上报详情");
        $.ajax({
            type : 'GET',
            url : '/handShzx/showAll',
            data : {
                "random"    :Math.random()
            },
            dataType : "text",
            success : function(resultString){
//                alert("得到已经上报的结果");
                $("#uploadTime").text("");
                $("#uploading").text("");
                $("#uploadcounts").text("");
                $("#uploadcounte").text("");
                $("#uploadcount").text("");
                $("#correctrate").text("");
                $("#txturl").text("");
                var rs = resultString.split("@");
                for(var i = 0 ; i < rs.length ; i ++){
                    var rss = rs[i].split(",");
                    if(rss[0] == "uploadtime"){
                        $("#uploadTimeAll").text(rss[1]);
                    }
                    if(rss[0] == "upload"){
                            $("#uploadingAll").text(rss[1]);
                    }
                    if(rss[0] == "uploadtrue"){
                            $("#uploadTrueAll").text(rss[1]);
                    }
                    if(rss[0] == "uploadfalse"){
                        $("#uploadFalseAll").text(rss[1]);
                    }
                    if(rss[0] == "uploadtotal"){
                        $("#uploadTotalAll").text(rss[1]);
                    }
                    if(rss[0] == "uploadrate"){
                        $("#uploadRateAll").text(rss[1]);
                    }
                }
            },
        });
    }
    //上报zip
    function upZip(value1,value2,value3){
        var data  =value1;
        var data2 = value2;
        var data3 = value3;
        if(0!=data2 && 9!=data2){
            ComAlert.show(2, "该ZIP包不能上报（已经上报成功或者报文无效）");
        }else {
            ComAlert.show(1, "上海资信开始上报", function () {
                $("#shzxStatus").children("span").text("正在上报");
            });
            $.ajax({
                type: "GET",
                url: '${ctx}/handShzx/upByZip',
                data: {
                    "id": data,
                    "org": data3
                },
                datatype: "json",
                success: function (result) {
                    if (result == "success") {
                        ComAlert.show(1, "上海资信合道上报成功", function () {
                           window.location.reload();
                            $("#shzxStatus").text("上报成功");
                        });
                    } else {
                        ComAlert.show(2, "上报失败，请点击详情。", function () {
                          window.location.reload();
                            $("#shzxStatus").text("上报失败");
                        });
                    }
                }
            });
        }
    }

    $("#download").click(function(){
        if($("#uploadTime").text()){
            ComAlert.show(2, "上海资信未加载完成数据。\n请稍候下载。");
            return;
        }
    });
    // 上传合道文件展示
    $("#uploadExcelNew").click(function(){
        $("#uploadExcelSingle").hide();
        $("#uploadExcel").show();
        $("#uploadFile").show();
        $("#selAll").hide();
        $("#delMsgDiv").hide();
        $("#selOne").hide();
        $("#AllResult").hide();
        $("#querySqlDiv").hide();

    });
    // 上传Excel文件展示
    $("#uploadByExcel").click(function(){
        $("#uploadExcel").hide();
        $("#uploadExcelSingle").show();
        $("#uploadFile").show();
        $("#selAll").hide();
        $("#delMsgDiv").hide();
        $("#selOne").hide();
        $("#AllResult").hide();
        $("#querySqlDiv").hide();

    });
    // 上传文件返回
    $("#goBackE").click(function(){
        $("#selAll").show();
        $("#uploadFile").hide();
        $("#selOne").hide();
        $("#delMsgDiv").hide();
        $("#AllResult").hide();
        $("#querySqlDiv").hide();
    });
    // 查询详细返回
    $("#goBack").click(function(){
        $("#selAll").show();
        $("#selOne").hide();
        $("#AllResult").hide();
        $("#delMsgDiv").hide();
        $("#uploadFile").hide();
        $("#querySqlDiv").hide();
    });
    $("#goBackTotal").click(function(){
        $("#selAll").show();
        $("#selOne").hide();
        $("#AllResult").hide();
        $("#delMsgDiv").hide();
        $("#uploadFile").hide();
        $("#querySqlDiv").hide();
    });
    $("#querySql").click(function(){
        $("#querySqlDiv").show();
        $("#delMsgDiv").hide();
        $("#selAll").hide();
        $("#selOne").hide();
        $("#AllResult").hide();
        $("#uploadFile").hide();
    });

    $("#delMsg").click(function(){
        $("#delMsgDiv").show();
        $("#querySqlDiv").hide();
        $("#selAll").hide();
        $("#selOne").hide();
        $("#AllResult").hide();
        $("#uploadFile").hide();
    });

</script>

</body>
</html>