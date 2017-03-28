{
  Des:Delphi7.0调用税控动态库实例
    流程描述：
      1、动态库是自动加载，按例程
      2、打开连接，connectserver
      3、按结构组织数据，转成json格式,调用sendstructtojson
      4、发送数据,调用函数senddata(sendjson:Pchar)，如果返回200:12345:25300000001000000089:开票成功！,判断前三位是200，
          则说明开票成功，发送下一条数据，依次类推，直到发送完成
      5、断开连接(必须做该操作，否则服务端可能非法退出！)

      发送数据约定：
      1、如果alldetail='1',则打印开票项目的数量、单位、单价，否则则不打印(相关信息必须组织)；
      2、如果结算方式clearingform='',则不打印结算方式(相关信息必须组织)，否则则打印；
      3、税目编码taxitem必须是税控器上传的税目之一,否则开票不成功；

     返回状态约定：
      1、返回100:'连接服务器失败！'，没有连接成功，可能是开票程序没有启动
      2、返回200:12345:25300000001000000089:开票成功！
           第一位200是成功的标识；
           第二位12345是票据的唯一标识，是开票数据中传递给税控程序的id字段，业务程序靠此字段更新打印成功标志字段
           第三位25300000001000000089是20位的开票发票号码，由12为发票代码和8位发票号码构成
           第四位是返回的汉字提示，提示该发票成功
      3、返回500: 无法识别的命令！，表示发送的命令无效！
      4、返回600:税目信息不合法，请参照税控器上传税目信息进行对比！
      5、返回：666: 欢迎登录，连接税控器失败，请检查税控器状态！
      6、返回：777、888、999：软件授权问题！
      7、返回：555：自动分发录入的问题！
  By:NZJ
  Date:2011-03-15
}
unit testapp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TFtestapp = class(TForm)
    BConnectServer: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    EdtData: TEdit;
    LbLog: TListBox;
    EdtData1: TEdit;
    BtnSend: TButton;
    BSendTwoData: TButton;
    BtnDisconnect: TButton;
    Button3: TButton;
    BClose: TButton;
    StatusBar1: TStatusBar;
    procedure BConnectServerClick(Sender: TObject);
    procedure BtnSendClick(Sender: TObject);
    procedure BtnDisconnectClick(Sender: TObject);
    procedure BSendTwoDataClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BCloseClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Ftestapp: TFtestapp;
implementation

{$R *.dfm}
//发票项目明细结构
Type
RecDetail = record
taxname:array [0..20] of Char;     //开票项目名称小于或等于20个汉字
taxnum:string;                     //开票项目数量
taxunit:string;                    //开票项目单位(如件，吨)
taxprice:string;                   //开票项目单价
price:string;                      //开票项目金额 = 数量 * 单价
taxitem:string;                    //开票项目税目索引号[必须是税控器上传的税目之一]
end;
//发票数据结构
Type
RecTest = record
name :array [0..40] of Char;       //客户名称小于或等于20个汉字
totalprice:string;                 //开票金额[单位:元]
itemnum:integer;                   //开票项目的条目数[必须正确，是发票明细结构中条目的个数]
id:string;                         //票据的唯一标识[该信息开票成功后将回传业务系统]
alldetail:string;                  //是否打印数量、单位及单价['0':不打印;'1':打印]
memo1:string;                      //备注1
memo2:string;                      //备注2
Mydetail:array[0..4] of RecDetail; //开票项目明细，最多4条
end;

//动态调用数据约定
type
  TIntFunction=function():PChar;stdcall;
  TCanFunction=function(data:Pchar):Pchar;stdcall;
var
  HInst:THandle;          //实例窗口句柄
  FPointer:TFarProc;      //
  MyFunct:TIntFunction;
  CanFunct:TCanFunction;
{
  Des:开票数据结构转化成服务器可以接受的json类型。
  By:NZJ
  Date:2011-03-15
}
function sendstructtojson(input:RecTest):string;
var
 json:string;
 //S:RecTest;
 i:integer;
begin
  json:='{"name":"'+input.name+'","totalprice":"'+input.totalprice+'","itemnum":'+IntTostr(input.itemnum)+',"id":"';
  json:=json+input.id+'","alldetail":"'+input.alldetail;
  json:=json+'","memo1":"'+input.memo1+'","memo2:":"'+input.memo2+'","children":[';
  for i:=0 to input.itemnum-1 do
  begin
      json:=json+'{"taxname":"'+input.Mydetail[i].taxname+'","taxnum":"'+input.Mydetail[i].taxnum+'","taxunit":"';
      json:=json+input.Mydetail[i].taxunit+'","taxprice":"'+input.Mydetail[i].taxprice;
      json:=json+'","price":"'+input.Mydetail[i].price+'","taxitem":"'+input.Mydetail[i].taxitem+'"}';
      if(i<input.itemnum-1)then
        json:=json+',';
  end;
  json:=json+']};';
  result:=json;
end;
{
  Des:连接服务器，函数名称connectserver,无参数
  By:NZJ
  Date:2011-03-15
}
procedure TFtestapp.BConnectServerClick(Sender: TObject);
var
  ret:string;
begin
try
  HInst:=LoadLibrary('SkDll.dll');
  if HInst>0 then
  try
    LbLog.Items.Add('正在连接 税控服务器...');
    FPointer:=GetProcAddress(HInst,PChar('connectserver'));
    if FPointer<>nil then
    begin
      MyFunct:=TIntFunction(FPointer);
      ret:=MyFunct();
      LbLog.Items.Add(ret);
    end
    else
      ShowMessage('服务没有启动！');
  finally
  end
  else
    ShowMessage('Library not found');
except
  on E:Exception do
     ShowMessage(E.Message);
  end;
end;
{
  Des:发送数据，必须已经连接了服务器，函数名称senddata,参数:发送数据的字符
  By:NZJ
  Date:2011-03-15
}
procedure TFtestapp.BtnSendClick(Sender: TObject);
var
  ret:string;
  senddatafromwindow:string;
  senddata:RecTest;
  s_sendjson:string;
begin
  senddata.name:='南天信息股份有限公司';
  senddata.totalprice:='2000';
  senddata.itemnum:=2;
  senddata.id:='12345';
  senddata.alldetail:='1';
  senddata.memo1:='备注：月租 80.00 新功能 0.00 国际 市话：20.00 长话 0.00 过网数据费 0.00 信息费 0.00';
  senddata.memo2:='上月余额：51.12 本月余额：51.12 累计实收： 100.00 合同号：P0022384 收费期间:2011-01-01 00:00:00 2011-02-28 23:59:59';

  senddata.Mydetail[0].taxname:='维修费';
  senddata.Mydetail[0].taxnum:='2';
  senddata.Mydetail[0].taxunit:='件';
  senddata.Mydetail[0].taxprice:='500.68';
  senddata.Mydetail[0].price:='1001.36';
  senddata.Mydetail[0].taxitem:='33';

  senddata.Mydetail[1].taxname:='收视费';
  senddata.Mydetail[1].taxnum:='12';
  senddata.Mydetail[1].taxunit:='月';
  senddata.Mydetail[1].taxprice:='120';
  senddata.Mydetail[1].price:='1000';
  senddata.Mydetail[1].taxitem:='33';
  s_sendjson:=sendstructtojson(senddata);

senddatafromwindow:=EdtData.Text;
//senddatafromwindow:=s_sendjson;
LbLog.Items.Add(senddatafromwindow);
if HInst>0 then
begin
    FPointer:=GetProcAddress(HInst,PChar('senddata'));
    if FPointer<>nil then
    begin
      CanFunct:=TCanFunction(FPointer);
      ret:=CanFunct(Pchar(senddatafromwindow));
      LbLog.Items.Add(ret);
    
    if copy(ret,1,3)<>'200' then//收数据成功
    begin
      //500,不可识别命令
      //600,税目不合法
      //断块与服务器的连接
      BtnDisconnect.Click;
    end;
    end
    else
      ShowMessage('数据发送没有成功！');
end;
end;


procedure TFtestapp.BtnDisconnectClick(Sender: TObject);
var
    ret:string;
begin
LbLog.Items.Add('发送断开服务连接指令给服务器！');
if HInst>0 then
begin
    FPointer:=GetProcAddress(HInst,PChar('disconnectserver'));
    if FPointer<>nil then
    begin
      MyFunct:=TIntFunction(FPointer);
      ret:=MyFunct();
      LbLog.Items.Add(ret);
      FreeLibrary(HInst);
    end
    else
      ShowMessage('断开服务指令没有成功！');
end;
end;
{
  Des:发送两条数据，数据组织参照发送一条数据
  By:NZJ
  Date:2011-03-15
}
procedure TFtestapp.BSendTwoDataClick(Sender: TObject);
var
  ret:string;
  senddata:string;
  senddata1:string;
begin
senddata:=EdtData.Text;
senddata1:=EdtData1.Text;
if HInst>0 then
begin
    FPointer:=GetProcAddress(HInst,PChar('senddata'));
    if FPointer<>nil then
    begin
      CanFunct:=TCanFunction(FPointer);
      ret:=CanFunct(Pchar(senddata));
      LbLog.Items.Add(senddata);
      LbLog.Items.Add(ret);
      if copy(ret,1,3)='200' then//收数据成功
      begin//发送第二条数据
      ret:=CanFunct(Pchar(senddata1));
      LbLog.Items.Add(senddata1);
      LbLog.Items.Add(ret);
      end;
    end
    else
      ShowMessage('数据发送没有成功,可能与服务器的连接已断开！');
end;
end;
procedure TFtestapp.Button3Click(Sender: TObject);
begin
  LbLog.Items.Clear;
end;

procedure TFtestapp.BCloseClick(Sender: TObject);
begin
  Close;
end;

end.

