unit Laba5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.MPlayer;

type
  TAnimation = class(TForm)
    TimerRunner: TTimer;
    MediaPlayer1: TMediaPlayer;

    procedure TimerRunnerTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    function WidthRect  (ARect : TRect) : Integer;
    function HeightRect  (ARect : TRect) : Integer;
    function CreateBmpRect (ARect : TRect) : TBitmap;
    procedure DrawImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Animation: TAnimation;

implementation
  const
        n=60;        // ����� ����
        khand1=0.5;  // ����������� ��� �����
        khand2=0.3;  // ����������� ��� ����������
        kleng1=0.4;  // ����������� ��� �����
        kleng2=0.6;  // ����������� ��� ������
  var x, y, i, j: integer;
      k, p, q: real;
      BackgroundBmp: TBitMap;


{$R *.dfm}

Procedure Body (x, y: integer; k: real; canvas: TCanvas);  // ��������� ��������� ����
begin
with canvas do
  begin
    Brush.Color:=clWhite;
    ellipse(round((x - 15) * k * P), round((y - 30) * k * Q),
      round((x + 15) * k * P), round(y* k * Q));
    moveto(round(x * k * P), round(y * k * Q));
    lineto(round(x * k * P), round((y + n) * k * Q));
  end;
end;

Procedure Hands1 (x, y: integer; k: real; canvas: TCanvas); // 1 ��������� ��� ��� ���� ������
begin
  with canvas do
  begin
    moveTo(round(x*k*P), round((y+10)*k*Q));
    lineTo(round((x+n*khand1*sin(pi/6))*k*P), round((y+10+n*khand1*cos(pi/6))*k*Q));   // ���������� ������������ ��� ������ ���� � ����, ��� �������� ��� ����� ���� ������ ���� �����������
    lineTo(round((x+n*khand1*sin(pi/6)+n*khand2*sin(pi/2))*k*P), round((y+10+n*khand1*cos(pi/6)+n*khand2*cos(pi/2))*k*Q));
    moveTo(round(x*k*P), round((y+10)*k*Q));
    lineTo(round((x-n*khand1*sin(pi/4))*k*P), round((y+10+n*khand1*cos(pi/4))*k*Q));
    lineTo(round((x-n*khand1*sin(pi/4))*k*P), round((y+10+n*khand1*cos(pi/4)+n*khand2)*k*Q));
  end;
end;

Procedure Hands2 (x, y: integer; k: real; canvas: TCanvas); // 2 ��������� ��� ��� ���� ������
begin
  with canvas do
  begin
    moveTo(round(x*k*P), round((y+10)*k*Q));
    lineTo(round((x+n*khand1*sin(pi/18))*k*P), round((y+10+n*khand1*cos(pi/18))*k*Q));
    lineTo(round((x+n*khand1*sin(pi/18)+n*khand2*sin(pi/18))*k*P), round((y+10+n*khand1*cos(pi/18)+n*khand2*cos(pi/18))*k*Q));
    moveTo(round(x*k*P), round((y+10)*k*Q));
    lineTo(round((x-n*khand1*sin(pi/12))*k*P), round((y+10+n*khand1*cos(pi/12))*k*Q));
    lineTo(round((x-n*khand1*sin(pi/12))*k*P), round((y+10+n*khand1*cos(pi/12)+n*khand2)*k*Q));
  end;
end;

Procedure Hands3 (x, y: integer; k: real; canvas: TCanvas); // 3 ��������� ��� ��� ���� ������
begin
  with canvas do
  begin
    moveTo(round(x*k*P), round((y+10)*k*Q));
    lineTo(round((x+n*khand1*sin(pi/12))*k*P), round((y+10+n*khand1*cos(pi/12))*k*Q));
    lineTo(round((x+n*khand1*sin(pi/12)+n*khand2*sin(pi/2))*k*P), round((y+10+n*khand1*cos(pi/12)+n*khand2*cos(pi/2))*k*Q));
    moveTo(round(x*k*P), round((y+10)*k*Q));
    lineTo(round((x-n*khand1*sin(pi/9))*k*P), round((y+10+n*khand1*cos(pi/9))*k*Q));
    lineTo(round((x-n*khand1*sin(pi/9)+n*khand2*sin(pi/6))*k*P), round((y+10+n*khand1*cos(pi/9)+n*khand2*cos(pi/6))*k*Q));
  end;
end;

Procedure Legs1 (x, y: integer; k: real; canvas: TCanvas);  // 1 ��������� ��� ��� ���� ������
begin
  with canvas do
  begin
    moveTo(round(x*k*P), round((y+n)*k*Q));
    lineTo(round((x+n*kleng1*sin(pi/6))*k*P), round((y+n+n*kleng1*cos(pi/6))*k*Q));
    lineTo(round((x+n*kleng1*sin(pi/6)+n*kleng2*sin(pi/6))*k*P), round((y+n+n*kleng1*cos(pi/6)+n*kleng2*cos(pi/6))*k*Q));
    moveTo(round(x*k*P), round((y+n)*k*Q));
    lineTo(round((x-n*kleng1*sin(pi/9))*k*P), round((y+n+n*kleng1*cos(pi/9))*k*Q));
    lineTo(round((x-n*kleng1*sin(pi/9)-n*kleng2)*k*P), round((y+n+n*kleng1*cos(pi/9))*k*Q));
  end;
end;

Procedure Legs2 (x, y: integer; k: real; canvas: TCanvas);  // 2 ��������� ��� ��� ���� ������
begin
  with canvas do
  begin
    moveTo(round(x*k*P), round((y+n)*k*Q));
    lineTo(round((x+n*kleng1*sin(pi/4))*k*P), round((y+n+n*kleng1*cos(pi/4))*k*Q));
    lineTo(round((x+n*kleng1*sin(pi/4))*k*P), round((y+n+n*kleng1*cos(pi/4)+n*kleng2)*k*Q));
    moveTo(round(x*k*P), round((y+n)*k*Q));
    lineTo(round(x*k*P), round((y+n+n*kleng1)*k*Q));
    lineTo(round((x-n*kleng1*sin(pi/4)-n*khand2*sin(pi/8))*k*P), round((y+n+n*kleng1*cos(pi/4)+n*kleng2*cos(pi/8))*k*Q));
  end;
end;

Procedure Legs3 (x, y: integer; k: real; canvas: TCanvas);  // 3 ��������� ��� ��� ���� ������
begin
  with canvas do
  begin
    moveTo(round(x*k*P), round((y+n)*k*Q));
    lineTo(round((x+n*kleng1*sin(pi/9))*k*P), round((y+n+n*kleng1*cos(pi/9))*k*Q));
    lineTo(round((x+n*kleng1*sin(pi/9)-n*kleng2*sin(pi/4))*k*P), round((y+n+n*kleng1*cos(pi/9)+n*kleng2*cos(pi/4))*k*Q));
    moveTo(round(x*k*P), round((y+n)*k*Q));
    lineTo(round(x*k*P), round((y+n+n*kleng1)*k*Q));
    lineTo(round(x*k*P), round((y+n+n*kleng1+n*kleng2)*k*Q));
  end;
end;

Procedure Jump_Legs1 (x, y: integer; k: real; canvas: TCanvas);  // 1 ��������� ��� ��� ������ ��� �������
begin
  with canvas do
  begin
    moveTo(round(x*k*P), round((y+n)*k*Q));
    lineTo(round((x+n*kleng1*sin(pi/4))*k*P), round((y+n+n*kleng1*cos(pi/4))*k*Q));
    lineTo(round((x+n*kleng1*sin(pi/4)-n*kleng2*sin(pi/4))*k*P), round((y+n+n*kleng1*cos(pi/4)+n*kleng2*cos(pi/4))*k*Q));
  end;
end;

Procedure Jump_Hands1 (x, y: integer; k: real; canvas: TCanvas);  // 1 ��������� ��� ��� ������ ��� �������
begin
  with canvas do
  begin
    moveTo(round(x*k*P), round((y+10)*k*Q));
    lineTo(round((x-n*khand1*sin(pi/6))*k*P), round((y+10+n*khand1*cos(pi/6))*k*Q));
    lineTo(round((x-n*khand1*sin(pi/6)+n*khand2)*k*P), round((y+10+n*khand1*cos(pi/6))*k*Q));
  end;
end;

Procedure Jump_Legs2 (x, y: integer; k: real; canvas: TCanvas);  // 2 ��������� ��� ��� ������ ��� �������
begin
  with canvas do
  begin
    moveTo(round(x*k*P), round((y+n)*k*Q));
    lineTo(round((x-n*kleng1*sin(pi/6))*k*P), round((y+n+n*kleng1*cos(pi/6))*k*Q));
    lineTo(round((x-n*kleng1*sin(pi/6)-n*kleng2*sin(pi/6))*k*P), round((y+n+n*kleng1*cos(pi/6)+n*kleng2*cos(pi/6))*k*Q));
  end;
end;

Procedure Jump_Hands2 (x, y: integer; k: real; canvas: TCanvas); // 2 ��������� ��� ��� ������ ��� �������
begin
  with canvas do
  begin
    moveTo(round(x*k*P), round((y+10)*k*Q));
    lineTo(round((x+n*khand1*sin(pi/4))*k*P), round((y+10-n*khand1*cos(pi/4))*k*Q));
    lineTo(round((x+n*khand1*sin(pi/4)+n*khand2*sin(pi/4))*k*P), round((y+10-n*khand1*cos(pi/4)-n*khand2*cos(pi/4))*k*Q));
  end;
end;

Procedure Rotate_Body1 (x, y: integer; k: real; canvas: TCanvas);  // 1 ��������� ���� ��� �������
begin
with canvas do
  begin
    Brush.Color:=clWhite;
    ellipse(round((x - 15) * k * P), round((y - 30) * k * Q),
      round((x + 15) * k * P), round(y* k * Q));
    moveto(round((x-15) * k * P), round((y-15) * k * Q));
    lineto(round((x-15-n) * k * P), round((y-15) * k * Q));
  end;
end;

Procedure Rotate_Legs1 (x, y: integer; k: real; canvas: TCanvas);  // 1 ��������� ��� ��� �������
begin
  with canvas do
  begin
    moveTo(round((x-15-n)*k*P), round((y-15)*k*Q));
    lineTo(round((x-15-n+n*kleng1*sin(pi/6))*k*P), round((y-15+n*kleng1*cos(pi/6))*k*Q));
    lineTo(round((x-15-n+n*kleng1*sin(pi/6)-n*kleng2*sin(pi/4))*k*P), round((y-15+n*kleng1*cos(pi/6)+n*kleng2*cos(pi/4))*k*Q));
  end;
end;

Procedure Rotate_Hands1 (x, y: integer; k: real; canvas: TCanvas);  // 1 ��������� ��� ��� �������
begin
  with canvas do
  begin
    moveTo(round((x-25)*k*P), round((y-15)*k*Q));
    lineTo(round(((x-25)-n*khand1*sin(pi/6))*k*P), round((y-15+n*khand1*cos(pi/6))*k*Q));
    lineTo(round(((x-25)-n*khand1*sin(pi/6)-n*khand2*sin(pi/6))*k*P), round((y-15+n*khand1*cos(pi/6)+n*khand2*cos(pi/6))*k*Q));
  end;
end;

Procedure Rotate_Body2 (x, y: integer; k: real; canvas: TCanvas);  // 2 ��������� ���� ��� �������
begin
with canvas do
  begin
    Brush.Color:=clWhite;
    ellipse(round((x - 15) * k * P), round((y - 30) * k * Q),
      round((x + 15) * k * P), round(y* k * Q));
    moveto(round(x * k * P), round((y-30) * k * Q));
    lineto(round((x+n/2*sin(pi/3)) * k * P), round((y-30-n/2*cos(pi/3)) * k * Q));
    lineTo(round((x+n/2*sin(pi/3)) * k * P), round((y-30-n/2*cos(pi/3)-n/2) * k * Q));
  end;
end;

Procedure Rotate_Legs2 (x, y: integer; k: real; canvas: TCanvas);  // 2 ��������� ��� ��� �������
begin
  with canvas do
  begin
    moveTo(round((x+n/2*sin(pi/3))*k*P), round((y-30-n/2*cos(pi/3)-n/2)*k*Q));
    lineTo(round((x+n/2*sin(pi/3)-n*kleng1*sin(pi/4))*k*P), round((y-30-n/2*cos(pi/3)-n/2+n*kleng1*cos(pi/4))*k*Q));
    lineTo(round((x+n/2*sin(pi/3)-n*kleng1*sin(pi/4)-n*kleng2*sin(pi))*k*P), round((y-30-n/2*cos(pi/3)-n/2+n*kleng1*cos(pi/4)+n*kleng2*cos(pi))*k*Q));
  end;
end;

Procedure Rotate_Hands2 (x, y: integer; k: real; canvas: TCanvas); // 2 ��������� ��� ��� �������
begin
  with canvas do
  begin
    moveTo(round((x+5*sin(pi/3))*k*P), round((y-30-5*cos(pi/3))*k*Q));
    lineTo(round((x+5*sin(pi/3)+n*khand1*sin(pi/9))*k*P), round((y-30-5*cos(pi/3)-n*khand1*cos(pi/9))*k*Q));
    lineTo(round((x+5*sin(pi/3)+n*khand1*sin(pi/9)+n*khand2*sin(pi/9))*k*P), round((y-30-5*cos(pi/3)-n*khand1*cos(pi/9)-n*khand2*cos(pi/9))*k*Q));
  end;
end;

Procedure Rotate_Body3 (x, y: integer; k: real; canvas: TCanvas);  // 3 ��������� ���� ��� �������
begin
with canvas do
  begin
    Brush.Color:=clWhite;
    ellipse(round((x - 15) * k * P), round((y - 30) * k * Q),
      round((x + 15) * k * P), round(y* k * Q));
    moveto(round(x * k * P), round(y * k * Q));
    lineto(round((x-n/2*sin(pi/3)) * k * P), round((y+n/2*cos(pi/3)) * k * Q));
    lineTo(round((x-n/2*sin(pi/3)+n/2*sin(pi/12)) * k * P), round((y+n/2*cos(pi/3)+n/2*cos(pi/12)) * k * Q));
  end;
end;

Procedure Rotate_Legs3 (x, y: integer; k: real; canvas: TCanvas);   // 3 ��������� ��� ��� �������
begin
  with canvas do
  begin
    moveTo(round((x-n/2*sin(pi/3)+n/2*sin(pi/12)) * k * P), round((y+n/2*cos(pi/3)+n/2*cos(pi/12)) * k * Q));
    lineTo(round((x-n/2*sin(pi/3)+n/2*sin(pi/12)+n*kleng1*sin(pi/3))*k*P), round((y+n/2*cos(pi/3)+n/2*cos(pi/12)-n/2+n*kleng1*cos(pi/3))*k*Q));
    lineTo(round((x-n/2*sin(pi/3)+n/2*sin(pi/12)+n*kleng1*sin(pi/3)+n*kleng2*sin(pi))*k*P), round((y+n/2*cos(pi/3)+n/2*cos(pi/12)+n/2+n*kleng1*cos(pi/3)+n*kleng2*cos(pi))*k*Q));
  end;
end;

Procedure Rotate_Hands3 (x, y: integer; k: real; canvas: TCanvas);  // 3 ��������� ��� ��� �������
begin
  with canvas do
  begin
    moveTo(round((x-5*sin(pi/3))*k*P), round((y+5*cos(pi/3))*k*Q));
    lineTo(round((x-5*sin(pi/3)-n*khand1*sin(pi/15))*k*P), round((y+5*cos(pi/3)+n*khand1*cos(pi/15))*k*Q));
    lineTo(round((x-5*sin(pi/3)-n*khand1*sin(pi/15)-n*khand2*sin(pi/15))*k*P), round((y+5*cos(pi/3)+n*khand1*cos(pi/15)+n*khand2*cos(pi/15))*k*Q));
  end;
end;

Procedure Rotate_Body4 (x, y: integer; k: real; canvas: TCanvas);  // 4 ��������� ���� ��� �������
begin
with canvas do
  begin
    Brush.Color:=clWhite;
    ellipse(round((x - 15) * k * P), round((y - 30) * k * Q),
      round((x + 15) * k * P), round(y* k * Q));
    moveto(round(x * k * P), round(y * k * Q));
    lineto(round((x+n*sin(pi/12)) * k * P), round((y+n*cos(pi/12)) * k * Q));
  end;
end;

Procedure Rotate_Legs4 (x, y: integer; k: real; canvas: TCanvas);  // 4 ��������� ��� ��� �������
begin
  with canvas do
  begin
    moveTo(round((x+n*sin(pi/12)) * k * P), round((y+n*cos(pi/12)) * k * Q));
    lineTo(round((x+n*sin(pi/12)+n*kleng1*sin(pi/3))*k*P), round((y+n*cos(pi/12)+n*kleng1*cos(pi/3))*k*Q));
    lineTo(round((x+n*sin(pi/12)+n*kleng1*sin(pi/3)+n*kleng2*sin(pi/15))*k*P), round((y+n*cos(pi/12)+n*kleng1*cos(pi/3)+n*kleng2*cos(pi/15))*k*Q));
  end;
end;

Procedure Rotate_Hands4 (x, y: integer; k: real; canvas: TCanvas);  // 4 ��������� ��� ��� �������
begin
  with canvas do
  begin
    moveTo(round((x+5*sin(pi/12))*k*P), round((y+5*cos(pi/12))*k*Q));
    lineTo(round((x-5*sin(pi/12)-n*khand1*sin(pi/6))*k*P), round((y+5*cos(pi/12)+n*khand1*cos(pi/6))*k*Q));
    lineTo(round((x-5*sin(pi/12)-n*khand1*sin(pi/6)+n*khand2*sin(pi/3))*k*P), round((y+5*cos(pi/12)+n*khand1*cos(pi/6)+n*khand2*cos(pi/3))*k*Q));
  end;
end;

Procedure Back_Hands1 (x, y: integer; k: real; canvas: TCanvas);  // 1 ��������� ��� ��� ���� �����
begin
  with canvas do
  begin
    moveTo(round(x*k*P), round((y+10)*k*Q));
    lineTo(round((x-n*khand1*sin(pi/6))*k*P), round((y+10+n*khand1*cos(pi/6))*k*Q));
    lineTo(round((x-n*khand1*sin(pi/6)-n*khand2*sin(pi/2))*k*P), round((y+10+n*khand1*cos(pi/6)+n*khand2*cos(pi/2))*k*Q));
    moveTo(round(x*k*P), round((y+10)*k*Q));
    lineTo(round((x+n*khand1*sin(pi/4))*k*P), round((y+10+n*khand1*cos(pi/4))*k*Q));
    lineTo(round((x+n*khand1*sin(pi/4))*k*P), round((y+10+n*khand1*cos(pi/4)+n*khand2)*k*Q));
  end;
end;

Procedure Back_Legs1 (x, y: integer; k: real; canvas: TCanvas);  // 1 ��������� ��� ��� ���� �����
begin
  with canvas do
  begin
    moveTo(round(x*k*P), round((y+n)*k*Q));
    lineTo(round((x-n*kleng1*sin(pi/6))*k*P), round((y+n+n*kleng1*cos(pi/6))*k*Q));
    lineTo(round((x-n*kleng1*sin(pi/6)-n*kleng2*sin(pi/6))*k*P), round((y+n+n*kleng1*cos(pi/6)+n*kleng2*cos(pi/6))*k*Q));
    moveTo(round(x*k*P), round((y+n)*k*Q));
    lineTo(round((x+n*kleng1*sin(pi/9))*k*P), round((y+n+n*kleng1*cos(pi/9))*k*Q));
    lineTo(round((x+n*kleng1*sin(pi/9)+n*kleng2)*k*P), round((y+n+n*kleng1*cos(pi/9))*k*Q));
  end;
end;

Procedure Back_Hands2 (x, y: integer; k: real; canvas: TCanvas);  // 2 ��������� ��� ��� ���� �����
begin
  with canvas do
  begin
    moveTo(round(x*k*P), round((y+10)*k*Q));
    lineTo(round((x-n*khand1*sin(pi/18))*k*P), round((y+10+n*khand1*cos(pi/18))*k*Q));
    lineTo(round((x-n*khand1*sin(pi/18)-n*khand2*sin(pi/18))*k*P), round((y+10+n*khand1*cos(pi/18)+n*khand2*cos(pi/18))*k*Q));
    moveTo(round(x*k*P), round((y+10)*k*Q));
    lineTo(round((x+n*khand1*sin(pi/12))*k*P), round((y+10+n*khand1*cos(pi/12))*k*Q));
    lineTo(round((x+n*khand1*sin(pi/12))*k*P), round((y+10+n*khand1*cos(pi/12)+n*khand2)*k*Q));
  end;
end;

Procedure Back_Legs2 (x, y: integer; k: real; canvas: TCanvas);  // 2 ��������� ��� ��� ���� �����
begin
  with canvas do
  begin
    moveTo(round(x*k*P), round((y+n)*k*Q));
    lineTo(round((x-n*kleng1*sin(pi/4))*k*P), round((y+n+n*kleng1*cos(pi/4))*k*Q));
    lineTo(round((x-n*kleng1*sin(pi/4))*k*P), round((y+n+n*kleng1*cos(pi/4)+n*kleng2)*k*Q));
    moveTo(round(x*k*P), round((y+n)*k*Q));
    lineTo(round(x*k*P), round((y+n+n*kleng1)*k*Q));
    lineTo(round((x+n*kleng1*sin(pi/4)+n*khand2*sin(pi/8))*k*P), round((y+n+n*kleng1*cos(pi/4)+n*kleng2*cos(pi/8))*k*Q));
  end;
end;

Procedure Back_Hands3 (x, y: integer; k: real; canvas: TCanvas);  // 3 ��������� ��� ��� ���� �����
begin
  with canvas do
  begin
    moveTo(round(x*k*P), round((y+10)*k*Q));
    lineTo(round((x-n*khand1*sin(pi/12))*k*P), round((y+10+n*khand1*cos(pi/12))*k*Q));
    lineTo(round((x-n*khand1*sin(pi/12)-n*khand2*sin(pi/2))*k*P), round((y+10+n*khand1*cos(pi/12)+n*khand2*cos(pi/2))*k*Q));
    moveTo(round(x*k*P), round((y+10)*k*Q));
    lineTo(round((x+n*khand1*sin(pi/9))*k*P), round((y+10+n*khand1*cos(pi/9))*k*Q));
    lineTo(round((x+n*khand1*sin(pi/9)-n*khand2*sin(pi/6))*k*P), round((y+10+n*khand1*cos(pi/9)+n*khand2*cos(pi/6))*k*Q));
  end;
end;

Procedure Back_Legs3 (x, y: integer; k: real; canvas: TCanvas);  // 3 ��������� ��� ��� ���� �����
begin
  with canvas do
  begin
    moveTo(round(x*k*P), round((y+n)*k*Q));
    lineTo(round((x-n*kleng1*sin(pi/9))*k*P), round((y+n+n*kleng1*cos(pi/9))*k*Q));
    lineTo(round((x-n*kleng1*sin(pi/9)+n*kleng2*sin(pi/4))*k*P), round((y+n+n*kleng1*cos(pi/9)+n*kleng2*cos(pi/4))*k*Q));
    moveTo(round(x*k*P), round((y+n)*k*Q));
    lineTo(round(x*k*P), round((y+n+n*kleng1)*k*Q));
    lineTo(round(x*k*P), round((y+n+n*kleng1+n*kleng2)*k*Q));
  end;
end;

Procedure LongJump_Legs1 (x, y: integer; k: real; canvas: TCanvas);  // ��������� ��� ��� ������ ����� �����������
begin
  with canvas do
  begin
    moveTo(round(x*k*P), round((y+n)*k*Q));
    lineTo(round((x+n*kleng1*sin(pi/3))*k*P), round((y+n+n*kleng1*cos(pi/3))*k*Q));
    lineTo(round((x+n*kleng1*sin(pi/3)+n*kleng2*sin(pi/2.25))*k*P), round((y+n+n*kleng1*cos(pi/3)+n*kleng2*cos(pi/2.25))*k*Q));
    moveTo(round(x*k*P), round((y+n)*k*Q));
    lineTo(round((x-n*kleng1*sin(pi/2.25))*k*P), round((y+n+n*kleng1*cos(pi/2.25))*k*Q));
    lineTo(round((x-n*kleng1*sin(pi/2.25)-n*khand2*sin(pi/3))*k*P), round((y+n+n*kleng1*cos(pi/2.25)+n*kleng2*cos(pi/6))*k*Q));
  end;
end;

procedure TAnimation.FormActivate(Sender: TObject);
begin
  canvas.Pen.Width := 4;
  x:=50;  // ���������� � ���������� ���������
  y:=100; // ���������� � ���������� ���������
  k:=1;   // ��������� �������� ������������� ���������������
  i:=1;   // ��������� �������� ����������, ���������� �� ����� ��������
  TimerRunner.Interval:=80;
  DrawImage;
end;

procedure TAnimation.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BackgroundBmp.Free;
end;

procedure TAnimation.FormCreate(Sender: TObject); // ��� �������� �����
begin
MediaPlayer1.FileName := 'GymnasticSong.mp3';   // ���������� ������ ��������
Mediaplayer1.Open;             // ������������ �������� FileName  � ������
Mediaplayer1.Play;             // ���������� ������ ������ FileName � ��������� �.�. ��� ������� ������� ������ btPlay
end;

procedure TAnimation.FormResize(Sender: TObject); // ��� ��������� �������� ����, �������������� Background �� ����� ��������
begin
  DrawImage;
end;

function TAnimation.WidthRect  (ARect : TRect) : Integer;
begin
  result := ARect.Right - ARect.Left;
end;

function TAnimation.HeightRect (ARect : TRect) : Integer;
begin
  result := ARect.Bottom - ARect.Top;
end;



function TAnimation.CreateBmpRect (ARect : TRect) : TBitmap;
begin
  result := TBitmap.Create;
  result.Width  := abs (WidthRect (ARect));
  result.Height := abs (HeightRect (ARect));
end;

procedure TAnimation.DrawImage;
begin
  P := ClientWidth / 1000;     // ����������� ��������������� �� ������
  Q := ClientHeight / 600;     // ����������� ��������������� �� ������
  BackgroundBmp := CreateBMPRect (Canvas.ClipRect);   // ������ ������ ������ TBitMap �� ������� ������� ������� �����
                                            // ��� ��������� �������� �� ��������� �������
  with BackgroundBmp.Canvas do begin
    //             ����
    //----------------------------------------
      Brush.Color:=clSkyBlue;
      Pen.Color:=clSkyBlue;
      Rectangle(round(0*P),round(0*Q),round(1000*P),round(120*Q));

    //             C�����
    //----------------------------------------
      Brush.Color:=clYellow;
      Pen.Color:=clYellow;
      Pen.Width:=4;
      Ellipse(round(450*P),round(70*Q),round(550*P),round(170*Q));
      moveTo(round(450*P),round(110*Q));
      lineTo(round(400*P),round(110*Q));
      moveTo(round(550*P),round(110*Q));
      lineTo(round(600*P),round(110*Q));
      moveTo(round(500*P),round(70*Q));
      lineTo(round(500*P),round(40*Q));
      moveTo(round(475*P),round(95*Q));
      lineTo(round((475-50*sin(pi/3))*P),round((95-50*cos(pi/3))*Q));
      moveTo(round(525*P),round(95*Q));
      lineTo(round((525+50*sin(pi/3))*P),round((95-50*cos(pi/3))*Q));
      moveTo(round(475*P),round(75*Q));
      lineTo(round((475-50*sin(pi/6))*P),round((75-50*cos(pi/6))*Q));
      moveTo(round(525*P),round(75*Q));
      lineTo(round((525+50*sin(pi/6))*P),round((75-50*cos(pi/6))*Q));

    //             �����
    //----------------------------------------
      Brush.Color:=clGreen;
      Pen.Color:=clGreen;
      Rectangle(round(0*P),round(120*Q),round(1000*P),round(1000*Q));

    //             ������
    //----------------------------------------
      Brush.Color:=clGrayText;
      Pen.Color:=clGrayText;
      Ellipse(round(0*P),round(150*Q),round(800*P),round(600*Q));
      Rectangle(round(0*P),round(150*Q),round(420*P),round(300*Q));
      Rectangle(round(0*P),round(450*Q),round(420*P),round(600*Q));

    //        ����� ������ ������
    //----------------------------------------
      Brush.Color:=clGreen;
      Pen.Color:=clGreen;
      Ellipse(round(320*P),round(280*Q),round(520*P),round(450*Q));
      Rectangle(round(0*P),round(280*Q),round(420*P),round(450*Q));

    //             ������
    //----------------------------------------
      Brush.Color:=clMaroon;
      Pen.Color:=clMaroon;
      Rectangle(round(920*P),round(150*Q),round(930*P),round(300*Q));
      Rectangle(round(850*P),round(270*Q),round(860*P),round(420*Q));
      Rectangle(round(900*P),round(400*Q),round(910*P),round(550*Q));
      Brush.Color:=clLime;
      Pen.Color:=clLime;
      Ellipse(round(880*P),round(150*Q),round(970*P),round(20*Q));
      Ellipse(round(810*P),round(270*Q),round(900*P),round(140*Q));
      Ellipse(round(860*P),round(400*Q),round(950*P),round(280*Q));

    //        ����������� 1
    //----------------------------------------
      Pen.Color:=clBlack;
      Pen.Width:=3;
      moveTo(round(440*P),round(510*Q));
      lineTo(round(440*P),round(460*Q));
      lineTo(round(540*P),round(510*Q));
      lineTo(round(540*P),round(560*Q));

    //        ����������� 2
    //----------------------------------------
      moveTo(round(250*P),round(510*Q));
      lineTo(round(250*P),round(460*Q));
      lineTo(round(350*P),round(510*Q));
      lineTo(round(350*P),round(560*Q));

    //        ����������� 3
    //----------------------------------------
      moveTo(round(60*P),round(510*Q));
      lineTo(round(60*P),round(460*Q));
      lineTo(round(160*P),round(510*Q));
      lineTo(round(160*P),round(560*Q));
  end;
end;

procedure TAnimation.TimerRunnerTimer(Sender: TObject);
begin
  Canvas.Draw(0,0,BackgroundBmp);  // ������� ������������ �������� �� ������� ������� BackgroundBmp �� ������ �����
  case i of
    1: // ��������� 1 ��� ���� ������
      begin
        Body(x, y, k, canvas);
        Legs1(x, y, k, canvas);
        Hands1(x, y, k, canvas);
        inc(i);
      end;
    2: // ��������� 2 ��� ���� ������
      begin
        Body(x, y, k, canvas);
        Legs2(x, y, k, canvas);
        Hands2(x, y, k, canvas);
        inc(i);
      end;
    3: // ��������� 3 ��� ���� ������
      begin
         Body(x, y, k, canvas);
         Legs3(x, y, k, canvas);
         Hands3(x, y, k, canvas);
         i:=1;
      end;
    4:  // ��������� 1 ��� ������ ����� ��������
      begin
        Body(x, y+10, k, canvas);
        Jump_Legs1(x, y+10, k, canvas);
        Jump_Hands1(x, y+10, k, canvas);
        inc(i)
      end;
    5:  // ��������� 2 ��� ������ ����� ��������
      begin
        Body(x, y-10, k, canvas);
        Jump_Legs2(x, y-10, k, canvas);
        Jump_Hands2(x, y-10, k, canvas);
        inc(i);
      end;
    6:  // ��������� 1 ��� �������
      begin
        x:=x+10;
        Rotate_Body1(x, y+30, k, canvas);
        Rotate_Legs1(x, y+30, k, canvas);
        Rotate_Hands1(x, y+30, k, canvas);
        inc(i);
      end;
    7:  // ��������� 2 ��� �������
      begin
        x:=x+10;
        Rotate_Body2(x, y+50, k, canvas);
        Rotate_Legs2(x, y+50, k, canvas);
        Rotate_Hands2(x, y+50, k, canvas);
        inc(i);
      end;
    8:  // ��������� 3 ��� �������
      begin
        x:=x+10;
        Rotate_Body3(x, y-50, k, canvas);
        Rotate_Legs3(x, y-50, k, canvas);
        Rotate_Hands3(x, y-50, k, canvas);
        inc(i);
      end;
    9:  // ��������� 2 ��� �������
      begin
        x:=x+10;
        Rotate_Body2(x, y+50, k, canvas);
        Rotate_Legs2(x, y+50, k, canvas);
        Rotate_Hands2(x, y+50, k, canvas);
        inc(i);
      end;
    10: // ��������� 4 ��� �������
      begin
        x:=x+10;
        Rotate_Body4(x, y-20, k, canvas);
        Rotate_Legs4(x, y-20, k, canvas);
        Rotate_Hands4(x, y-20, k, canvas);
        i:=4;
      end;
    11:  // ��������� 1 ��� ���� �����
      begin
        Body(x, y, k, canvas);
        Back_Legs1(x, y, k, canvas);
        Back_Hands1(x, y, k, canvas);
        inc(i);
      end;
    12:  // ��������� 2 ��� ���� �����
      begin
        Body(x, y, k, canvas);
        Back_Legs2(x, y, k, canvas);
        Back_Hands2(x, y, k, canvas);
        inc(i);
      end;
    13:  // ��������� 3 ��� ���� �����
      begin
        Body(x, y, k, canvas);
        Back_Legs3(x, y, k, canvas);
        Back_Hands3(x, y, k, canvas);
        i:=11;
      end;
    14:  //  ��������� ��� ������ ����� �����������
      begin
        x:=x-2;
        Body(x, y, k, canvas);
        Back_Hands1(x, y, k, canvas);
        LongJump_Legs1(x, y, k, canvas);
        if j<=3 then
          begin
            i:=14;
            inc(j);
          end
        else
          i:=11;
      end;
  end;
  if (x<460) and (y=100) then  // ��� ������
    begin
      x := x + 2;
      if (x=130) or (x=220) or (x=310) then  // �������
        i:=4;
      if (x=194) or (x=284) or (x=374) then  // ����� �����
        i:=1;
    end;
    if (x>=460) and (y<200) then  // ������� (��� ������)
      begin
        k := k+0.0027;   // ����������� ����������� ���������������
        x:=x+2;
        y:=y+2;
      end;
    if (x<=560) and (y>=200) and (y<300) then   // ������� (��� �����)
      begin
        if y=200 then   // ������ ����������� ����
          i:=11;
        k:=k+0.0027;    // ����������� ����������� ���������������
        x:=x-2;
        y:=y+2;
      end;
    if (x<=460) and (y=300) then  // ��� �����
      begin
        x:=x-2;
        if (x=400) or (x=250) or (x=100)then  // ������ ����� �����������
          begin
          i:=14;
          j:=0;
          end;
      end;
    if (x=50) and (y=300) then   // ������������ � ��������� ���������
    begin
      x:=50;
      y:=100;
      k:=1;
      i:=1;
    end;
end;

end.
