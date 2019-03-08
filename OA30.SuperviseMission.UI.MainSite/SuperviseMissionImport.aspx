<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SuperviseMissionImport.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.SuperviseMissionImport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>导入模板</title>
    <link href="Css/style.css" rel="stylesheet" />
</head>
<body>
    <form action="WebServices/SuperviseMissionWebServices.asmx/SuperviseMissionImport" method="post" enctype="multipart/form-data" >
        <input type="file" name="file" value="" />
        <input type="submit" value="提交" />
    </form>
    
</body>
</html>
