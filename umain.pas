unit umain;

{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Generics.Collections;

type
  { TUser }

  TUser = class
    id: word;
    userName: String;
    pass: String;
    usersList: TList<TUser>; /// Generics.Collections
    constructor Create(id: word; userName: String; pass: String; usersList: TList<TUser>); overload;
    function toString: String; override;
  end;

  { TFrMain }

  TFrMain = class(TForm)
    Button1: TButton;
    MemLog: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _count: word; /// default=0
  public
    user: TUser;
  end;

var
  FrMain: TFrMain;
  log: TStrings;

implementation

{$R *.lfm}

{ TFrMain }

procedure TFrMain.FormShow(Sender: TObject);
begin
  log:=MemLog.Lines;
  user:=TUser.Create;
end;

procedure TFrMain.Button1Click(Sender: TObject);
  var
    user: TUser;
begin
  Inc(_count);
  user:=TUser.Create(_count, 'userName-' + _count.ToString, 'pass-' + _count.ToString, TList<TUser>.Create);
  //user.usersList:=TList<TUser>.Create;
  log.Add(user.toString());
  user.usersList.Add(user);
  log.Add(user.usersList[0].userName);
end;

{ TUser }

constructor TUser.Create(id: word; userName: String; pass: String; usersList: TList<TUser>);
begin
  self.id:=id;
  self.userName:=userName;
  self.pass:=pass;
  self.usersList:=usersList;
end;

function TUser.toString: String;
begin
  inherited;
  Result:=Format('TUser: {"id": %d, "userName": "%s", "pass": "%s"}',
    [self.id, self.userName, self.pass]);
end;

end.

