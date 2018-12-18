unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls,shellapi;

type
  TForm3 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses Unit1;

{$R *.dfm}
procedure coloration();
var i,j:integer;
begin
for i:=1 to 9  do
begin
 for j:=1 to 9 do
 begin

  if form1.GAME.Cells[i-1,j-1]='rouge' then
    FORM1.GAME.Canvas.Draw((J*72)-72+J-1,(I*63)-63+I-1,form1.rouge.Glyph)
    else if  form1.GAME.Cells[i-1,j-1]='rougeselected' then
     FORM1.GAME.Canvas.Draw((J*72)-72+J-1,(I*63)-63+I-1,form1.rougeselected.Glyph)
      else if  form1.GAME.Cells[i-1,j-1]='vert' then
     FORM1.GAME.Canvas.Draw((J*72)-72+J-1,(I*63)-63+I-1,form1.vert.Glyph)
       else if  form1.GAME.Cells[i-1,j-1]='vertselected' then
     FORM1.GAME.Canvas.Draw((J*72)-72+J-1,(I*63)-63+I-1,form1.vertselected.Glyph)
       else if  form1.GAME.Cells[i-1,j-1]='bleu' then
     FORM1.GAME.Canvas.Draw((J*72)-72+J-1,(I*63)-63+I-1,form1.bleu.Glyph)
       else if  form1.GAME.Cells[i-1,j-1]='bleuselected' then
     FORM1.GAME.Canvas.Draw((J*72)-72+J-1,(I*63)-63+I-1,form1.bleuselected.Glyph)
         else if  form1.GAME.Cells[i-1,j-1]='halwa' then
     FORM1.GAME.Canvas.Draw((J*72)-72+J-1,(I*63)-63+I-1,form1.halwa.Glyph)
        else if  form1.GAME.Cells[i-1,j-1]='halwaselected' then
     FORM1.GAME.Canvas.Draw((J*72)-72+J-1,(I*63)-63+I-1,form1.halwaselected.Glyph)
       else if  form1.GAME.Cells[i-1,j-1]='mauve' then
     FORM1.GAME.Canvas.Draw((J*72)-72+J-1,(I*63)-63+I-1,form1.mauve.Glyph)
       else if  form1.GAME.Cells[i-1,j-1]='mauveselected' then
     FORM1.GAME.Canvas.Draw((J*72)-72+J-1,(I*63)-63+I-1,form1.mauveselected.Glyph)
       else if  form1.GAME.Cells[i-1,j-1]='jaune' then
     FORM1.GAME.Canvas.Draw((J*72)-72+J-1,(I*63)-63+I-1,form1.jaune.Glyph)
         else if  form1.GAME.Cells[i-1,j-1]='jauneselected' then
     FORM1.GAME.Canvas.Draw((J*72)-72+J-1,(I*63)-63+I-1,form1.jjauneselcted.Glyph)
       else if form1.GAME.Cells[i-1,j-1]='vide' then
      form1.GAME.Canvas.Draw((J*72)-72+J-1,(I*63)-63+I-1,form1.vide.Glyph)
        else if form1.GAME.Cells[i-1,j-1]='vide1' then
      form1.GAME.Canvas.Draw((J*72)-72+J-1,(I*63)-63+I-1,form1.vide1.Glyph) ;




    


 end;
 end;
 form1.GAME.Repaint;

 end;//end coloration//

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
form1.Show;
form3.Hide;
if form1.game.Visible=true then
form1.timer2.Enabled:=true;
coloration();
end;

procedure TForm3.Label5Click(Sender: TObject);
begin
shellexecute(0,'open','https://www.facebook.com/ssognoss',nil,nil,sw_show);
end;

end.
