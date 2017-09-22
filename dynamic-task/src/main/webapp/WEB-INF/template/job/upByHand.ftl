<!DOCTYPE html>
<html>
<head>
    <title>调度中心</title>
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
        <section class="content-header">
            <h1>使用教程<small>调度管理平台</small></h1>
            <ol class="breadcrumb">
                <li><a><i class="fa fa-dashboard"></i>调度中心</a></li>
                <li class="active">使用教程</li>
            </ol>
        </section>
        <!-- Main content -->
        <section class="content">
            <div class="form">
                    <div class="form-group">
                        <input type="text" id="setNowTime"  class="form-control" name="uploadTime" placeholder="上报时间" readonly="true">
                    </div>
                    <div class="form-group">
                        <input type="button"  class="btn btn-primary" value="选择时间" onClick="WdatePicker({el:$dp.$('setNowTime')})">
                    </div>
            </div>
            <div class="box-body" id="selAll">
                <table id="job_list" class="table table-bordered table-striped">
                    <thead>
                    <tr>
                        <th>上报服务</th>
                        <th>加工时间</th>
                        <th>加工状态</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                     <tr>
                        <td>
                            Excel数据
                        </td>
                        <td>
                            <span id="shzxHdTime">${Session["HDuploadTime"]}</span>
                        </td>
                        <td>
                            <span id="shzxHdSpan">${Session["HDuploadResult"]}</span>
                        </td>
                        <td>
                            <button class="btn btn-info btn-xs job_operate" onclick="upShzxHd()" type="button">开始加工</button>
                        </td>
                     </tr>
                        <tr>
                            <td>
                            上海资信
                            </td>
                            <td>
                                <span id="shzxTime">${Session["uploadTime"]}</span>
                            <td>
                                <span id="shzxSpan">${Session["uploadResult"]}</span>
                            </td>
                            <td>
                                <button class="btn btn-info btn-xs job_operate" onclick="upShzx()" type="button">开始加工</button>
                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                    </tfoot>
                </table>
            </div>
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
<script src="${request.contextPath}/static/My97DatePicker/WdatePicker.js"></script>
<script>var base_url = '${request.contextPath}';</script>
<script>
    function upShzx() {
        var time = $("#setNowTime").val();
        $("#shzxTime").text(time);
        $("#shzxSpan").text("开始加工");
        if (time == "" || time == undefined || time == null) {
            ComAlert.show(1, "上报时间不能为空。", function(){
                $("#shzxSpan").text("");
//                window.location.reload();
            });
        } else {
            ComAlert.show(1, "开始加工上海资信上报数据，请查看打包结果并选择上报",function(){
                $("#shzxSpan").text("正在加工");}
                );
            $.ajax({
                type: "GET",
                url: '${ctx}/handShzx/handleShzx',
                data: $("#setNowTime").serialize(),
                datatype:"json",
                success: function(result) {
                    $("#setNowTime").serialize();
                    if(result=="success"){
                        ComAlert.show(1, "上海资信加工完成");
                        window.location.reload();
                    }else {
                        ComAlert.show(1, "上海资信加工失败，请点击报告查询以查看详情", function(){
                            window.location.reload();
                        });
                    }
                }
            });
        }
    }
    function upShzxHd() {
        var time = $("#setNowTime").val();
        $("#shzxHdTime").text(time);
        $("#shzxHdSpan").text("开始加工");
        if (time == "" || time == undefined || time == null) {
            ComAlert.show(1, "上报时间不能为空", function(){
                $("#shzxHdSpan").text("");
            });
        } else {
            ComAlert.show(1, "开始加工上海资信合道上报数据，请查看打包结果并选择上报",function(){
                $("#shzxHdSpan").text("正在加工");}
                );
            $.ajax({
                type: "GET",
                url: '${ctx}/handShzx/handleShzxHd',
                data: $("#setNowTime").serialize(),
                datatype: "json",
                success: function (result) {
                    if (result == "success") {
                        ComAlert.show(1, "上海资信合道加工完成");
                        window.location.reload();
                    } else {
                        $("#shzxHdSpan").text("加工失败");
                        ComAlert.show(1, "合道加工失败，请点击报告查询以查看详情");
                        window.location.reload();
                    }
                }
            });
        }
    }
</script>
</body>
</html>