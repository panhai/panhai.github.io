using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using OA30.SuperviseMission.UI.CommonComponents.Utilities;
using OA30.SuperviseMission.UI.WebSiteInfo;

namespace OA30.SuperviseMission.UI.MainSite
{
    /// <summary>
    /// 文件下载的基础页
    /// </summary>
    public partial class DownFileBase : BasePage
    {
        protected override void OnPreInit(EventArgs e)
        {
            //判断是否收到CSRF攻击
            if (this.IsPostBack && OA30.Common.Security.CSRFTools.IsAttackByCSRF(this.Request.UrlReferrer, this.Request.Url))
            {
                throw new OA30.Common.Exception.UIExceptions.IsCSRFException(OA30.Common.Exception.UIExceptions.UIExceptionDescriptionCollection.CSRF);
            }

            base.OnPreInit(e);
        }
        static DownFileBase()
        {
            InitMimeList();
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// 发送文件数据
        /// </summary>
        /// <param name="fileBytes"></param>
        /// <param name="fileName"></param>
        protected void SendFileData(byte[] fileBytes, string fileName)
        {
            string ext = System.IO.Path.GetExtension(fileName).ToLower();
            string mimeValue = GetMimeValue(ext);
            try
            {
                Response.Clear();
                //mime值
                Response.AddHeader("Content-Type", mimeValue);
                //加入长度
                Response.AddHeader("Content-Length", fileBytes.Length.ToString());
                Response.BinaryWrite(fileBytes);
                Response.End();
            }
            catch (Exception ex)
            {
                //执行Response.End()会引发ThreadAbortException，这里退出即可
                if (ex is System.Threading.ThreadAbortException)
                    return;

                Response.Write("返回文件时出错：" + ex.Message);
                Response.Flush();
                Response.End();
            }
        }

        /// <summary>
        /// 发送文件数据
        /// </summary>
        /// <param name="serverBaseUrl"></param>
        /// <param name="serverFilePath"></param>
        /// <param name="skipUnZip"></param>
        /// <param name="clientFileName"></param>
        protected void SendFileData(string serverBaseUrl, string serverFilePath, bool skipUnZip, string displayName)
        {
            string ext = System.IO.Path.GetExtension(displayName).ToLower();
            string mimeValue = GetMimeValue(ext);
            System.IO.MemoryStream tmpMemoryStream = null;
            try
            {
                Response.Clear();
                //mime值
                Response.AddHeader("Content-Type", mimeValue);

                //因为文件服务器上存在1次或多次压缩的zip文件，如果是1次压缩，则直接返回数据[wukea 20130516]
                //如果是多次压缩，则解压后再返回
                if (serverFilePath.ToLower().EndsWith(".zip") && !skipUnZip)
                {
                    byte[] tmpFiledata =  CommonHelper.FileAccessTool.ReadFileFromServer(serverBaseUrl, serverFilePath, true);
                    tmpMemoryStream = new System.IO.MemoryStream(tmpFiledata);
                    //多次压缩，返回tmpFiledata即可
                    if (CSN.DotNetLibrary.Compression.Zip.ZipFile.IsFileZiped(tmpMemoryStream))
                    {
                        this.Response.BinaryWrite(tmpFiledata);
                        this.Response.Flush();
                    }
                    else
                    {
                        //一次压缩，不解压发送
                         CommonHelper.FileAccessTool.SendFileToUser(serverBaseUrl, serverFilePath, true, this.Response);
                    }
                }
                else
                {
                    CommonHelper.FileAccessTool.SendFileToUser(serverBaseUrl, serverFilePath, skipUnZip, this.Response);
                }

                Response.End();
            }
            catch (Exception ex)
            {
                //执行Response.End()会引发ThreadAbortException，这里退出即可
                if (ex is System.Threading.ThreadAbortException)
                    return;

                Response.Write("返回文件时出错：" + ex.Message);
                Response.Flush();
                Response.End();
            }
            finally
            {
                if (tmpMemoryStream != null)
                    tmpMemoryStream.Close();
            }
        }

        /*这种操作方式，在IIS下运作正常，在测试服务器上会是乱码，原因待查*/
        /// <summary>
        /// 发送文件(支持IE浏览器、firefox、chrome、遨游等pc浏览器，支持iOS的浏览器、支持长文件名；但不支持安卓系统。)
        /// </summary>
        /// <param name="serverBaseUrl"></param>
        /// <param name="serverFilePath"></param>
        /// <param name="skipUnZip"></param>
        /// <param name="displayName"></param>
        protected void SendFileAsAttachment(string serverBaseUrl, string serverFilePath, bool skipUnZip, string displayName)
        {
            Encoding headerEncoding = System.Text.Encoding.GetEncoding("GB2312");
            string fileDisposition = String.Format("attachment; filename=\"{0}\"", displayName);
            string ext = System.IO.Path.GetExtension(displayName).ToLower();
            string mimeValue = GetMimeValue(ext);
            System.IO.MemoryStream tmpMemoryStream = null;

            try
            {
                Response.Clear();
                Response.Charset = "utf-8";
                Response.HeaderEncoding = headerEncoding;
                Response.ContentEncoding = Encoding.UTF8;
                //mime值
                Response.AddHeader("Content-Type", mimeValue);
                //Disposition
                Response.AppendHeader("Content-Disposition", fileDisposition);
                ////加入长度
                //Response.AddHeader("Content-Length", fileBytes.Length.ToString());
                //Response.BinaryWrite(fileBytes);

                //因为文件服务器上存在1次或多次压缩的zip文件，如果是1次压缩，则直接返回数据[wukea 20130516]
                //如果是多次压缩，则解压后再返回
                if (serverFilePath.ToLower().EndsWith(".zip") && !skipUnZip)
                {
                    byte[] tmpFiledata = CommonHelper.FileAccessTool.ReadFileFromServer(serverBaseUrl, serverFilePath, true);
                    tmpMemoryStream = new System.IO.MemoryStream(tmpFiledata);
                    //多次压缩，返回tmpFiledata即可
                    if (CSN.DotNetLibrary.Compression.Zip.ZipFile.IsFileZiped(tmpMemoryStream))
                    {
                        this.Response.BinaryWrite(tmpFiledata);
                        this.Response.Flush();
                    }
                    else
                    {
                        //一次压缩，不解压发送
                        CommonHelper.FileAccessTool.SendFileToUser(serverBaseUrl, serverFilePath, true, this.Response);
                    }
                }
                else
                {
                     CommonHelper.FileAccessTool.SendFileToUser(serverBaseUrl, serverFilePath, skipUnZip, this.Response);
                }
                //Response.w
                Response.End();
            }
            catch (Exception ex)
            {
                //执行Response.End()会引发ThreadAbortException，这里退出即可
                if (ex is System.Threading.ThreadAbortException)
                    return;

                Response.Write("返回文件时出错：" + ex.Message);
                Response.Flush();
                Response.End();
            }
            finally
            {
                if (tmpMemoryStream != null)
                    tmpMemoryStream.Close();
            }
        }

        /*这种操作方式，在IIS下运作正常，在测试服务器上会是乱码，原因待查*/
        /// <summary>
        /// 发送文件(支持IE浏览器、firefox、chrome、遨游等pc浏览器，支持iOS的浏览器、支持长文件名；但不支持安卓系统。)
        /// </summary>
        /// <param name="fileBytes"></param>
        /// <param name="displayName"></param>
        protected void SendFileAsAttachment(byte[] fileBytes, string displayName)
        {
            Encoding headerEncoding = System.Text.Encoding.GetEncoding("GB2312");
            string fileDisposition = String.Format("attachment; filename=\"{0}\"", displayName);
            string ext = System.IO.Path.GetExtension(displayName).ToLower();
            string mimeValue = GetMimeValue(ext);

            try
            {
                Response.Clear();
                Response.Charset = "utf-8";
                Response.HeaderEncoding = headerEncoding;
                Response.ContentEncoding = Encoding.UTF8;
                //mime值
                Response.AddHeader("Content-Type", mimeValue);
                //Disposition
                Response.AppendHeader("Content-Disposition", fileDisposition);
                //加入长度
                Response.AddHeader("Content-Length", fileBytes.Length.ToString());
                Response.BinaryWrite(fileBytes);
                //Response.w
                Response.End();
            }
            catch (Exception ex)
            {
                //执行Response.End()会引发ThreadAbortException，这里退出即可
                if (ex is System.Threading.ThreadAbortException)
                    return;

                Response.Write("返回文件时出错：" + ex.Message);
                Response.Flush();
                Response.End();
            }
        }

        /// <summary>
        /// 回写错误信息
        /// </summary>
        /// <param name="msg"></param>
        protected void WriteErrorMsg(string msg)
        {
            try
            {
                Response.Clear();
                Response.Write(msg);
                Response.Flush();
                Response.End();
            }
            catch//会引发线程退出的异常，不处理
            {
            }
        }

        /// <summary>
        /// 回写错误信息
        /// </summary>
        /// <param name="msg"></param>
        /// <param name="statusCode"></param>
        protected void WriteErrorMsg(string msg, int statusCode)
        {
            try
            {
                Response.Clear();
                Response.StatusCode = statusCode;
                Response.Write(msg);
                Response.Flush();
                Response.End();
            }
            catch//会引发线程退出的异常，不处理
            {
            }
        }

        #region MIME相关的成员和函数

        /// <summary>
        /// 初始化MIME的数据
        /// </summary>
        private static void InitMimeList()
        {
            MimeItemsDic = new Dictionary<string, string>(256);

            System.IO.StringReader sr = new System.IO.StringReader(MIMIE_ITEMS);
            string line = null;
            while ((line = sr.ReadLine()) != null)
            {
                line = line.Trim();
                if (line.Length == 0)
                    continue;
                string[] arr = line.Split(':');
                if (arr.Length != 2)
                    continue;
                MimeItemsDic.Add(arr[0], arr[1]);
            }
        }

        /// <summary>
        /// 默认的MIME值
        /// </summary>
        private const string DEFAULT_MIMIE_ITEM = "application/octet-stream";

        #region MIMIE项(静态配置值)
        /// <summary>
        /// MIMIE项(静态配置值)
        /// </summary>
        private const string MIMIE_ITEMS = @"323:text/h323
acx:application/internet-property-stream
ai:application/postscript
aif:audio/x-aiff
aifc:audio/x-aiff
aiff:audio/x-aiff
asf:video/x-ms-asf
asr:video/x-ms-asf
asx:video/x-ms-asf
au:audio/basic
avi:video/x-msvideo
axs:application/olescript
bas:text/plain
bcpio:application/x-bcpio
bin:application/octet-stream
bmp:image/bmp
c:text/plain
cat:application/vnd.ms-pkiseccat
cdf:application/x-cdf
ceb:DOC/FOUNDER
cebx:DOC/FOUNDER
cer:application/x-x509-ca-cert
class:application/octet-stream
clp:application/x-msclip
cmx:image/x-cmx
cod:image/cis-cod
cpio:application/x-cpio
crd:application/x-mscardfile
crl:application/pkix-crl
crt:application/x-x509-ca-cert
csh:application/x-csh
css:text/css
dcr:application/x-director
der:application/x-x509-ca-cert
dir:application/x-director
dll:application/x-msdownload
dms:application/octet-stream
doc:application/msword
dot:application/msword
dvi:application/x-dvi
dxr:application/x-director
eps:application/postscript
etx:text/x-setext
evy:application/envoy
exe:application/octet-stream
fif:application/fractals
flr:x-world/x-vrml
gif:image/gif
gtar:application/x-gtar
gz:application/x-gzip
h:text/plain
hdf:application/x-hdf
hlp:application/winhlp
hqx:application/mac-binhex40
hta:application/hta
htc:text/x-component
htm:text/html
html:text/html
htt:text/webviewhtml
ico:image/x-icon
ief:image/ief
iii:application/x-iphone
ins:application/x-internet-signup
isp:application/x-internet-signup
jfif:image/pipeg
jpe:image/jpeg
jpeg:image/jpeg
jpg:image/jpeg
js:application/x-javascript
latex:application/x-latex
lha:application/octet-stream
lsf:video/x-la-asf
lsx:video/x-la-asf
lzh:application/octet-stream
m13:application/x-msmediaview
m14:application/x-msmediaview
m3u:audio/x-mpegurl
man:application/x-troff-man
mdb:application/x-msaccess
me:application/x-troff-me
mht:message/rfc822
mhtml:message/rfc822
mid:audio/mid
mny:application/x-msmoney
mov:video/quicktime
movie:video/x-sgi-movie
mp2:video/mpeg
mp3:audio/mpeg
mpa:video/mpeg
mpe:video/mpeg
mpeg:video/mpeg
mpg:video/mpeg
mpp:application/vnd.ms-project
mpv2:video/mpeg
ms:application/x-troff-ms
mvb:application/x-msmediaview
nws:message/rfc822
oda:application/oda
p10:application/pkcs10
p12:application/x-pkcs12
p7b:application/x-pkcs7-certificates
p7c:application/x-pkcs7-mime
p7m:application/x-pkcs7-mime
p7r:application/x-pkcs7-certreqresp
p7s:application/x-pkcs7-signature
pbm:image/x-portable-bitmap
pdf:application/pdf
pfx:application/x-pkcs12
pgm:image/x-portable-graymap
pko:application/ynd.ms-pkipko
pma:application/x-perfmon
pmc:application/x-perfmon
pml:application/x-perfmon
pmr:application/x-perfmon
pmw:application/x-perfmon
pnm:image/x-portable-anymap
pot,:application/vnd.ms-powerpoint
ppm:image/x-portable-pixmap
pps:application/vnd.ms-powerpoint
ppt:application/vnd.ms-powerpoint
prf:application/pics-rules
ps:application/postscript
pub:application/x-mspublisher
qt:video/quicktime
ra:audio/x-pn-realaudio
ram:audio/x-pn-realaudio
ras:image/x-cmu-raster
rgb:image/x-rgb
rmi:audio/mid
roff:application/x-troff
rtf:application/rtf
rtx:text/richtext
scd:application/x-msschedule
sct:text/scriptlet
setpay:application/set-payment-initiation
setreg:application/set-registration-initiation
sh:application/x-sh
shar:application/x-shar
sit:application/x-stuffit
snd:audio/basic
spc:application/x-pkcs7-certificates
spl:application/futuresplash
src:application/x-wais-source
sst:application/vnd.ms-pkicertstore
stl:application/vnd.ms-pkistl
stm:text/html
svg:image/svg+xml
sv4cpio:application/x-sv4cpio
sv4crc:application/x-sv4crc
swf:application/x-shockwave-flash
t:application/x-troff
tar:application/x-tar
tcl:application/x-tcl
tex:application/x-tex
texi:application/x-texinfo
texinfo:application/x-texinfo
tgz:application/x-compressed
tif:image/tiff:
tiff:image/tiff
tr:application/x-troff
trm:application/x-msterminal
tsv:text/tab-separated-values
txt:text/plain
uls:text/iuls
ustar:application/x-ustar
vcf:text/x-vcard
vrml:x-world/x-vrml
wav:audio/x-wav
wcm:application/vnd.ms-works
wdb:application/vnd.ms-works
wks:application/vnd.ms-works
wmf:application/x-msmetafile
wps:application/vnd.ms-works
wri:application/x-mswrite
wrl:x-world/x-vrml
wrz:x-world/x-vrml
xaf:x-world/x-vrml
xbm:image/x-xbitmap
xla:application/vnd.ms-excel
xlc:application/vnd.ms-excel
xlm:application/vnd.ms-excel
xls:application/vnd.ms-excel
xlt:application/vnd.ms-excel
xlw:application/vnd.ms-excel
xof:x-world/x-vrml
xpm:image/x-xpixmap
xwd:image/x-xwindowdump
z:application/x-compress
zip:application/x-zip-compressed
wma:audio/x-ms-wma";

        #endregion

        /// <summary>
        /// MIMIE的集合
        /// </summary>
        private static Dictionary<string, string> MimeItemsDic = null;

        /// <summary>
        /// 根据文件扩展名获取MIME的值
        /// </summary>
        /// <param name="fileExtension">文件扩展名</param>
        /// <returns>MIME值</returns>
        protected static string GetMimeValue(string fileExtension)
        {
            if (string.IsNullOrEmpty(fileExtension) || fileExtension.Trim().Length == 0)
                return DEFAULT_MIMIE_ITEM;

            string theType = fileExtension.Trim().ToLower();
            if (theType.StartsWith("."))
                theType = theType.Remove(0, 1);

            if (!MimeItemsDic.ContainsKey(theType))
                return DEFAULT_MIMIE_ITEM;

            return MimeItemsDic[theType];
        }

        #endregion
    }
}
