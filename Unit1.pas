unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, unit2, unit3, ExtCtrls, Grids, jpeg, StdCtrls, Buttons,
  shellapi,
  MPlayer;

type
  TForm1 = class(TForm)
    mainmenu: TMainMenu;
    menu: TMenuItem;
    Option1: TMenuItem;
    Nouvellepartie1: TMenuItem;
    N2: TMenuItem;
    Quitter1: TMenuItem;
    graphique: TMenuItem;
    sound: TMenuItem;
    Active1: TMenuItem;
    Desactiver1: TMenuItem;
    PleinEcran1: TMenuItem;
    Reduite1: TMenuItem;
    Difficult1: TMenuItem;
    Facile1: TMenuItem;
    Moyenne1: TMenuItem;
    Difficil1: TMenuItem;
    Aide1: TMenuItem;
    Commentjouer1: TMenuItem;
    AproposdeDevlopper1: TMenuItem;
    rouge: TSpeedButton;
    halwaselected: TSpeedButton;
    jaune: TSpeedButton;
    jjauneselcted: TSpeedButton;
    mauve: TSpeedButton;
    mauveselected: TSpeedButton;
    bleu: TSpeedButton;
    vertselected: TSpeedButton;
    bleuselected: TSpeedButton;
    vert: TSpeedButton;
    halwa: TSpeedButton;
    rougeselected: TSpeedButton;
    vide: TSpeedButton;
    vide1: TSpeedButton;
    Image1: TImage;
    Actualiser1: TMenuItem;
    Timer1: TTimer;
    close: TImage;
    sonactiver: TImage;
    sondesactiver: TImage;
    Panel1: TPanel;
    Label1: TLabel;
    niveaulabel: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Panel3: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Timer2: TTimer;
    Label6: TLabel;
    gagne: TImage;
    GAME: TStringGrid;
    lose: TImage;
    MediaPlayer1: TMediaPlayer;
    MediaPlayer2: TMediaPlayer;
    MediaPlayer3: TMediaPlayer;
    gamesound: TTimer;
    gamend: TTimer;
    MediaPlayer4: TMediaPlayer;
    procedure Quitter1Click(Sender: TObject);
    procedure Reduite1Click(Sender: TObject);
    procedure Active1Click(Sender: TObject);
    procedure Desactiver1Click(Sender: TObject);
    procedure Facile1Click(Sender: TObject);
    procedure Moyenne1Click(Sender: TObject);
    procedure Difficil1Click(Sender: TObject);
    procedure PleinEcran1Click(Sender: TObject);
    procedure AproposdeDevlopper1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Nouvellepartie1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure GAMEMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Actualiser1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure closeClick(Sender: TObject);
    procedure sonactiverClick(Sender: TObject);
    procedure sondesactiverClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Commentjouer1Click(Sender: TObject);
    procedure gamesoundTimer(Sender: TObject);
    procedure gamendTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  piece: array [1 .. 12] of string = (
    'rouge',
    'jaune',
    'bleu',
    'vert',
    'halwa',
    'mauve',
    'bleuselected',
    'vertselected',
    'halwaselected',
    'mauveselected',
    'jauneselected',
    'rougeselected'
  );
  Niveau: byte;
  X, Y, xv, yv: array [1 .. 10] of Integer;
  nb, nbsel, nb2, nbv, selx, sely, scor: Integer;
  inter: Longint;
  a: boolean;
  ss, mm, hh, dep, depmax: word;

implementation

{$R *.dfm}
{$R test.RES}

function exist(rechx, rechy: Integer): boolean;
var
  w: Integer;
begin
  w := 1;
  while (w <= nb2) and ((rechx <> X[w]) or (rechy <> Y[w])) do
    inc(w);

  if w > nb2 then
    result := false
  else
    result := true;

end;

procedure coloration();
var
  i, j: Integer;
begin
  for i := 1 to 9 do
  begin
    for j := 1 to 9 do
    begin

      if Form1.GAME.Cells[i - 1, j - 1] = 'rouge' then
        Form1.GAME.Canvas.Draw((j * 72) - 72 + j - 1, (i * 63) - 63 + i - 1,
          Form1.rouge.Glyph)
      else if Form1.GAME.Cells[i - 1, j - 1] = 'rougeselected' then
        Form1.GAME.Canvas.Draw((j * 72) - 72 + j - 1, (i * 63) - 63 + i - 1,
          Form1.rougeselected.Glyph)
      else if Form1.GAME.Cells[i - 1, j - 1] = 'vert' then
        Form1.GAME.Canvas.Draw((j * 72) - 72 + j - 1, (i * 63) - 63 + i - 1,
          Form1.vert.Glyph)
      else if Form1.GAME.Cells[i - 1, j - 1] = 'vertselected' then
        Form1.GAME.Canvas.Draw((j * 72) - 72 + j - 1, (i * 63) - 63 + i - 1,
          Form1.vertselected.Glyph)
      else if Form1.GAME.Cells[i - 1, j - 1] = 'bleu' then
        Form1.GAME.Canvas.Draw((j * 72) - 72 + j - 1, (i * 63) - 63 + i - 1,
          Form1.bleu.Glyph)
      else if Form1.GAME.Cells[i - 1, j - 1] = 'bleuselected' then
        Form1.GAME.Canvas.Draw((j * 72) - 72 + j - 1, (i * 63) - 63 + i - 1,
          Form1.bleuselected.Glyph)
      else if Form1.GAME.Cells[i - 1, j - 1] = 'halwa' then
        Form1.GAME.Canvas.Draw((j * 72) - 72 + j - 1, (i * 63) - 63 + i - 1,
          Form1.halwa.Glyph)
      else if Form1.GAME.Cells[i - 1, j - 1] = 'halwaselected' then
        Form1.GAME.Canvas.Draw((j * 72) - 72 + j - 1, (i * 63) - 63 + i - 1,
          Form1.halwaselected.Glyph)
      else if Form1.GAME.Cells[i - 1, j - 1] = 'mauve' then
        Form1.GAME.Canvas.Draw((j * 72) - 72 + j - 1, (i * 63) - 63 + i - 1,
          Form1.mauve.Glyph)
      else if Form1.GAME.Cells[i - 1, j - 1] = 'mauveselected' then
        Form1.GAME.Canvas.Draw((j * 72) - 72 + j - 1, (i * 63) - 63 + i - 1,
          Form1.mauveselected.Glyph)
      else if Form1.GAME.Cells[i - 1, j - 1] = 'jaune' then
        Form1.GAME.Canvas.Draw((j * 72) - 72 + j - 1, (i * 63) - 63 + i - 1,
          Form1.jaune.Glyph)
      else if Form1.GAME.Cells[i - 1, j - 1] = 'jauneselected' then
        Form1.GAME.Canvas.Draw((j * 72) - 72 + j - 1, (i * 63) - 63 + i - 1,
          Form1.jjauneselcted.Glyph)
      else if Form1.GAME.Cells[i - 1, j - 1] = 'vide' then
        Form1.GAME.Canvas.Draw((j * 72) - 72 + j - 1, (i * 63) - 63 + i - 1,
          Form1.vide.Glyph)
      else if Form1.GAME.Cells[i - 1, j - 1] = 'vide1' then
        Form1.GAME.Canvas.Draw((j * 72) - 72 + j - 1, (i * 63) - 63 + i - 1,
          Form1.vide1.Glyph);

    end;
  end;
  Form1.GAME.Repaint;

end; // end coloration//

function existvide(): boolean;
var
  c, v: Integer;
begin
  result := false;
  for c := 0 to 8 do
    for v := 0 to 8 do
      if Form1.GAME.Cells[c, v] = 'vide' then
        result := (true);

end;

procedure recherche();
var
  i, j, t, h: Integer;

begin
  Form1.GAME.Enabled := false;
  Form1.Timer1.Enabled := false;

  nb := 0;
  nb2 := 0;
  nbv := 0;

  try
    for i := 0 to 8 do
    begin
      t := 0;
      for j := t to 6 do
      begin
        t := j + 1;
        nb := 1;
        while (Form1.GAME.Cells[i, j] = Form1.GAME.Cells[i, t]) and (t <= 8) and
          (Form1.GAME.Cells[i, j] <> 'vide') do
        begin
          inc(t);
          inc(nb);
        end;

        if nb >= 3 then
        begin
          for h := 1 to nb do
          begin
            if (exist(j + h - 1, i) = false) then
            begin
              inc(nb2);
              X[nb2] := j + h - 1;
              Y[nb2] := i;
            end;

          end;

        end;

      end;
    end;

  except
  end;

  try
    for i := 0 to 8 do
    begin
      t := 0;
      for j := t to 6 do
      begin
        t := j + 1;
        nb := 1;
        while (Form1.GAME.Cells[j, i] = Form1.GAME.Cells[t, i]) and (t <= 8) and
          (Form1.GAME.Cells[j, i] <> 'vide') do
        begin
          inc(t);
          inc(nb);
        end;

        if nb >= 3 then
        begin
          for h := 1 to nb do
          begin
            if (exist(i, j + h - 1) = false) then
            begin
              inc(nbv);
              inc(nb2);
              Y[nb2] := j + h - 1;
              X[nb2] := i;
            end;

          end;

        end;

      end;
    end;

  except
  end;

  if nb2 >= 3 then
  begin
    for i := 1 to nb2 do
      Form1.GAME.Cells[Y[i], X[i]] := 'vide';
    if (Form1.Active1.Checked = true) then
    begin
      Form1.MediaPlayer4.close;
      Form1.MediaPlayer4.Open;
      Form1.MediaPlayer4.Play;
    end;

    coloration();
    coloration();
    Form1.Timer1.Interval := 400;
    Form1.Timer1.Enabled := true;

  end
  else
    Form1.GAME.Enabled := true;

end;

procedure niveau3();
var
  alea, i, j: byte;
  verif1, verif2, verif3, verif4: boolean;
begin

  for i := 0 to 8 do
  begin
    for j := 0 to 8 do
    begin

      randomize;
      verif1 := true;
      verif2 := true;
      verif3 := true;
      verif4 := true;
      repeat
        alea := random(6) + 1;
        try
          if (Form1.GAME.Cells[i - 2, j] <> piece[alea]) then
          begin
            verif1 := true;
          end
          else
            verif1 := false;
        except
        end;
        try
          if (Form1.GAME.Cells[i + 2, j] <> piece[alea]) then
          begin
            verif2 := true;
          end
          else
            verif2 := false;
        except
        end;
        try
          if (Form1.GAME.Cells[i, j - 2] <> piece[alea]) then
          begin
            verif3 := true;
          end
          else
            verif3 := false;
        except
        end;
        try
          if (Form1.GAME.Cells[i, j + 2] <> piece[alea]) then
          begin
            verif4 := true;
          end
          else
            verif4 := false;
        except
        end;
      until ((verif1 = true) and (verif2 = true) and (verif3 = true) and
        (verif4 = true));

      Form1.GAME.Cells[i, j] := piece[alea];

    end;
  end;
  for i := 0 to 1 do
    Form1.GAME.Cells[i, 4] := 'vide1';
  for i := 8 downto 7 do
    Form1.GAME.Cells[i, 4] := 'vide1';
  for i := 0 to 1 do
    Form1.GAME.Cells[4, i] := 'vide1';
  for i := 8 downto 7 do
    Form1.GAME.Cells[4, i] := 'vide1';

end; // end level

procedure niveau2();
var
  alea, i, j: byte;
  verif1, verif2, verif3, verif4: boolean;
begin

  for i := 0 to 8 do
  begin
    for j := 0 to 8 do
    begin

      randomize;
      verif1 := true;
      verif2 := true;
      verif3 := true;
      verif4 := true;
      repeat
        alea := random(4) + 1;
        try
          if (Form1.GAME.Cells[i - 2, j] <> piece[alea]) then
          begin
            verif1 := true;
          end
          else
            verif1 := false;
        except
        end;
        try
          if (Form1.GAME.Cells[i + 2, j] <> piece[alea]) then
          begin
            verif2 := true;
          end
          else
            verif2 := false;
        except
        end;
        try
          if (Form1.GAME.Cells[i, j - 2] <> piece[alea]) then
          begin
            verif3 := true;
          end
          else
            verif3 := false;
        except
        end;
        try
          if (Form1.GAME.Cells[i, j + 2] <> piece[alea]) then
          begin
            verif4 := true;
          end
          else
            verif4 := false;
        except
        end;
      until ((verif1 = true) and (verif2 = true) and (verif3 = true) and
        (verif4 = true));

      Form1.GAME.Cells[i, j] := piece[alea];

    end;
  end;

  Form1.GAME.Cells[8, 8] := 'vide1';
  Form1.GAME.Cells[0, 0] := 'vide1';
  Form1.GAME.Cells[0, 8] := 'vide1';
  Form1.GAME.Cells[8, 0] := 'vide1';
  Form1.GAME.Cells[4, 4] := 'vide1';

end; // end level2

procedure niveau1();
var
  alea, i, j: byte;
  verif1, verif2, verif3, verif4: boolean;
begin

  for i := 0 to 8 do
  begin
    for j := 0 to 8 do
    begin

      randomize;
      verif1 := true;
      verif2 := true;
      verif3 := true;
      verif4 := true;
      repeat
        alea := random(3) + 1;
        try
          if (Form1.GAME.Cells[i - 2, j] <> piece[alea]) then
          begin
            verif1 := true;
          end
          else
            verif1 := false;
        except
        end;
        try
          if (Form1.GAME.Cells[i + 2, j] <> piece[alea]) then
          begin
            verif2 := true;
          end
          else
            verif2 := false;
        except
        end;
        try

          if (Form1.GAME.Cells[i, j - 2] <> piece[alea]) then
          begin
            verif3 := true;
          end
          else
            verif3 := false;
        except
        end;
        try
          if (Form1.GAME.Cells[i, j + 2] <> piece[alea]) then
          begin
            verif4 := true;
          end
          else
            verif4 := false;
        except
        end;
      until ((verif1 = true) and (verif2 = true) and (verif3 = true) and
        (verif4 = true));

      Form1.GAME.Cells[i, j] := piece[alea];

    end;
  end;

end; // end level

procedure initialisation();
var
  i, j: word;
begin
  ss := 0;
  mm := Niveau - 1;
  hh := 0;
  dep := 0;

  Form1.niveaulabel.Caption :=
    inttostr(strtoint(Form1.niveaulabel.Caption) + 1);

  Form1.Label5.Caption := '0/' + inttostr(depmax);
  Form1.Timer2.Enabled := true;
  nb := 0;
  nbsel := 0;
  nb2 := 0;

  for i := 1 to 8 do
    for j := 1 to 8 do
      Form1.GAME.Cells[i, j] := 'vide';

  nb := 0;
  if Niveau = 1 then
    niveau1()
  else if Niveau = 2 then
    niveau2()
  else
    niveau3();

  coloration();
  coloration();

end;

procedure TForm1.Quitter1Click(Sender: TObject);
var
  rep: byte;
begin
  rep := Application.messagebox('ya weldi mthabet t7eb to5rej ??',
    'Quitter Le Jeu ?', mb_yesNoCancel);
  if rep = idyes then
    Application.Terminate;
end;

procedure sound1();
begin
  if Form1.sound.Checked = true then
  begin
    Windows.Beep(2000, 100);
  end;
end;

procedure TForm1.Reduite1Click(Sender: TObject);
begin
  IF Reduite1.Checked = false THEN
  BEGIN
    close.Top := 630;
    sonactiver.Top := 633;
    sondesactiver.Top := 633;

  END;

  Reduite1.Checked := true;
  PleinEcran1.Checked := false;

  with Form1 do
  begin
    BorderStyle := bsSingle;
    FormStyle := fsStayOnTop;
    Left := 0;
    Top := 0;
    Height := Screen.Height - 40;
    Width := Screen.Width;
  end;

end;

procedure TForm1.Active1Click(Sender: TObject);
begin
  // open music
  gamesound.Enabled := true;
  MediaPlayer3.Open;
  MediaPlayer3.Play;
  MediaPlayer1.Open;
  MediaPlayer2.Open;
  // end open music
  Active1.Checked := true;
  Desactiver1.Checked := false;
  sonactiver.Visible := true;
  sondesactiver.Visible := false;
end;

procedure TForm1.Desactiver1Click(Sender: TObject);
begin
  // close music
  gamesound.Enabled := false;
  MediaPlayer3.close;
  gamend.Enabled := false;
  MediaPlayer1.close;
  MediaPlayer2.close;
  // end close music
  Desactiver1.Checked := true;
  Active1.Checked := false;
  sonactiver.Visible := false;
  sondesactiver.Visible := true;
end;

procedure TForm1.Facile1Click(Sender: TObject);
var
  rep: byte;
begin
  rep := Application.messagebox('Passer au NIVEAU Facile ?',
    'Changement de Niveau', mb_yesNoCancel);
  if rep = idyes then
  begin
    scor := 0;
    Label3.Caption := inttostr(scor);

    Label5.Caption := '0/' + inttostr(depmax);
    dep := 0;
    Niveau := 1;
    Facile1.Checked := true;
    Moyenne1.Checked := false;
    Difficil1.Checked := false;
    Nouvellepartie1.Click;
  end;
end;

procedure TForm1.Moyenne1Click(Sender: TObject);
var
  rep: byte;
begin

  rep := Application.messagebox('Passer au NIVEAU Difficulté Moyenne ?',
    'Changement de Niveau', mb_yesNoCancel);
  if rep = idyes then
  begin
    Niveau := 2;
    scor := 0;
    Label3.Caption := inttostr(scor);

    Label5.Caption := '0/' + inttostr(depmax);
    dep := 0;
    Facile1.Checked := false;
    Moyenne1.Checked := true;
    Difficil1.Checked := false;
    Nouvellepartie1.Click;
  end;
end;

procedure TForm1.Difficil1Click(Sender: TObject);
var
  rep: byte;
begin
  rep := Application.messagebox('Passer au NIVEAU Difficil ?',
    'Changement de Niveau', mb_yesNoCancel);
  if rep = idyes then
  begin

    Label5.Caption := '0/' + inttostr(depmax);
    dep := 0;
    Niveau := 3;
    scor := 0;
    Label3.Caption := inttostr(scor);
    Facile1.Checked := false;
    Nouvellepartie1.Click;
    Moyenne1.Checked := false;
    Difficil1.Checked := true;
  end;
end;

procedure TForm1.PleinEcran1Click(Sender: TObject);
begin
  Reduite1.Checked := false;

  IF PleinEcran1.Checked = false THEN
  BEGIN
    close.Top := 630 + 70;
    sonactiver.Top := 633 + 70;
    sondesactiver.Top := 633 + 70;
  END;
  PleinEcran1.Checked := true;
  with Form1 do
  begin
    BorderStyle := bsNone;
    FormStyle := fsStayOnTop;
    Left := 0;
    Top := 0;
    Height := Screen.Height;
    Width := Screen.Width;
  end;

end;

procedure TForm1.AproposdeDevlopper1Click(Sender: TObject);
begin

  Form1.Hide;
  form2.show;
  Timer2.Enabled := false;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  rStream: TResourceStream;
  fStream: TFileStream;
  fname1, fname2, fname3, fname4: string;
begin

  // mange
  { this part extracts the mp3 from exe }
  fname4 := ExtractFileDir(Paramstr(0)) + 'Mange.mp3';
  rStream := TResourceStream.Create(hInstance, 'mange', RT_RCDATA);
  try
    fStream := TFileStream.Create(fname4, fmCreate);
    try
      fStream.CopyFrom(rStream, 0);
    finally
      fStream.Free;
    end;
  finally
    rStream.Free;
  end;
  { this part plays the mp3 }
  MediaPlayer4.close;
  MediaPlayer4.FileName := fname4;
  MediaPlayer4.Open;
  // end mange

  // end game
  { this part extracts the mp3 from exe }
  fname2 := ExtractFileDir(Paramstr(0)) + 'Endgame.mp3';
  rStream := TResourceStream.Create(hInstance, 'endgame', RT_RCDATA);
  try
    fStream := TFileStream.Create(fname2, fmCreate);
    try
      fStream.CopyFrom(rStream, 0);
    finally
      fStream.Free;
    end;
  finally
    rStream.Free;
  end;
  { this part plays the mp3 }
  MediaPlayer1.close;
  MediaPlayer1.FileName := fname2;
  MediaPlayer1.Open;
  // end game sound

  // son jeu
  { this part extracts the mp3 from exe }
  fname1 := ExtractFileDir(Paramstr(0)) + 'Music.mp3';
  rStream := TResourceStream.Create(hInstance, 'music', RT_RCDATA);
  try
    fStream := TFileStream.Create(fname1, fmCreate);
    try
      fStream.CopyFrom(rStream, 0);
    finally
      fStream.Free;
    end;
  finally
    rStream.Free;
  end;
  { this part plays the mp3 }
  MediaPlayer3.close;
  MediaPlayer3.FileName := fname1;
  MediaPlayer3.Open;


  // end son de jeu

  // eat
  { this part extracts the mp3 from exe }
  fname3 := ExtractFileDir(Paramstr(0)) + 'Eat.mp3';
  rStream := TResourceStream.Create(hInstance, 'eat', RT_RCDATA);
  try
    fStream := TFileStream.Create(fname3, fmCreate);
    try
      fStream.CopyFrom(rStream, 0);
    finally
      fStream.Free;
    end;
  finally
    rStream.Free;
  end;
  { this part plays the mp3 }
  MediaPlayer2.close;
  MediaPlayer2.FileName := fname3;
  MediaPlayer2.Open;
  // end eat

  // timer 3 son de jeu//
  MediaPlayer3.Play;
  gamesound.Interval := MediaPlayer3.Length div 2;
  gamend.Interval := MediaPlayer1.Length div 2;

  depmax := 10;
  Reduite1.Checked := false;
  PleinEcran1.Checked := false;
  Reduite1.Click;
  Niveau := 1;
  nb := 0;
  scor := 0;
  Label3.Caption := inttostr(scor);
end;

procedure TForm1.Nouvellepartie1Click(Sender: TObject);
begin
  Panel1.Visible := true;
  Panel2.Visible := true;
  Panel3.Visible := true;
  scor := 0;
  depmax := 10;
  dep := 0;
  Label3.Caption := inttostr(scor);
  GAME.Visible := true;
  niveaulabel.Caption := '0';
  initialisation();

end;

procedure TForm1.FormResize(Sender: TObject);
begin
  coloration();
end;

procedure TForm1.GAMEMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  col, ligne: Integer;
  aux: string;
begin
  try
    if nbsel > 1 then
    begin
      nbsel := 0;
    end;
    try
      GAME.MouseToCell(X, Y, col, ligne);
    except
    end;
    if (nbsel = 0) and (pos('vide', GAME.Cells[ligne, col]) = 0) then
    begin
      selx := col;
      sely := ligne;
      if GAME.Cells[ligne, col] = 'rouge' then
        GAME.Cells[ligne, col] := 'rougeselected'
      else if GAME.Cells[ligne, col] = 'vert' then
        GAME.Cells[ligne, col] := 'vertselected'
      else if GAME.Cells[ligne, col] = 'jaune' then
        GAME.Cells[ligne, col] := 'jauneselected'
      else if GAME.Cells[ligne, col] = 'mauve' then
        GAME.Cells[ligne, col] := 'mauveselected'
      else if GAME.Cells[ligne, col] = 'halwa' then
        GAME.Cells[ligne, col] := 'halwaselected'
      else if GAME.Cells[ligne, col] = 'bleu' then
        GAME.Cells[ligne, col] := 'bleuselected';
      nbsel := 1;
      coloration();
      coloration();
    end
    else if nbsel = 1 then
    begin
      if (pos('selected', GAME.Cells[ligne, col]) <> 0) then
      begin
        GAME.Cells[ligne, col] := copy(GAME.Cells[ligne, col], 1,
          pos('selected', GAME.Cells[ligne, col]) - 1);
        nbsel := 0;
        coloration();
        coloration();
      end
      else
      begin
        if (((ligne = sely - 1) and (col = selx)) or
          ((ligne = sely) and (col = selx - 1)) or
          ((ligne = sely + 1) and (col = selx)) or
          ((ligne = sely) and (col = selx + 1))) then
        begin
          if ((pos('vide', GAME.Cells[ligne, col]) = 0) and
            (GAME.Cells[ligne, col] <> copy(GAME.Cells[sely, selx], 1,
            pos('selected', GAME.Cells[sely, selx]) - 1))) then

          begin

            try
              GAME.Cells[sely, selx] := copy(GAME.Cells[sely, selx], 1,
                pos('selected', GAME.Cells[sely, selx]) - 1);
              aux := GAME.Cells[ligne, col];
              GAME.Cells[ligne, col] := GAME.Cells[sely, selx];
              GAME.Cells[sely, selx] := aux;

            except
            end;

            recherche();
            if nb2 >= 3 then
            begin
              nbsel := 0;
              sound1();
              inc(dep);
              Label5.Caption := inttostr(dep) + '/' + inttostr(depmax);
            end;

            if nbsel > 0 then
            begin
              try

                aux := GAME.Cells[ligne, col];
                GAME.Cells[ligne, col] := GAME.Cells[sely, selx];
                GAME.Cells[sely, selx] := aux;
                GAME.Cells[sely, selx] := GAME.Cells[sely, selx] + 'selected';

              except
              end;
            end;

          end;
        end;

      end;

    end;
  Except
  end;

end;

procedure TForm1.Actualiser1Click(Sender: TObject);
begin
  coloration();
end;

procedure remplirTete();
var
  c: Integer;
begin
  Form1.GAME.Enabled := false;
  for c := 0 to 8 do
  begin

    if Form1.GAME.Cells[0, c] = 'vide' then
    begin

      randomize;
      if Niveau = 1 then
        Form1.GAME.Cells[0, c] := piece[random(6) + 1]
      else if Niveau = 2 then
        Form1.GAME.Cells[0, c] := piece[random(4) + 1]
      else
        Form1.GAME.Cells[0, c] := piece[random(6) + 1];
    end;

  end;
  if Niveau = 2 then
  BEGIN
    if Form1.GAME.Cells[1, 8] = 'vide' then
    BEGIN
      Form1.GAME.Cells[1, 8] := piece[random(6) + 1]
    end;

    if Form1.GAME.Cells[1, 0] = 'vide' then
    BEGIN
      Form1.GAME.Cells[1, 0] := piece[random(6) + 1]
    end;
  END;

  if Niveau = 3 then
  BEGIN
    if Form1.GAME.Cells[2, 4] = 'vide' then
    BEGIN
      Form1.GAME.Cells[2, 4] := piece[random(6) + 1]
    end;

  END;
  Form1.GAME.Enabled := true;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  i, j: Integer;
  axi: string;
  verticale, hori: boolean;

begin
  verticale := false;
  hori := false;
  if existvide() then
  begin
    remplirTete();
    GAME.Enabled := false;

    for i := 1 to nb2 - nbv do
    begin
      hori := true;
      for j := Y[i] downto 1 do
      begin
        // remplissage tete//
        remplirTete();
        // end remplissage tete//
        axi := GAME.Cells[j, X[i]];
        if axi = 'vide' then
        begin
          if (GAME.Cells[j - 1, X[i]] <> 'vide1') and
            (GAME.Cells[j - 1, X[i]] <> 'vide2') and
            (GAME.Cells[j - 1, X[i]] <> 'vide3') and
            (GAME.Cells[j - 1, X[i]] <> 'vide4') and
            (GAME.Cells[j - 1, X[i]] <> 'vide5') and
            (GAME.Cells[j - 1, X[i]] <> 'vide6') and
            (GAME.Cells[j - 1, X[i]] <> 'vide7') and
            (GAME.Cells[j - 1, X[i]] <> 'vide8') and
            (GAME.Cells[j - 1, X[i]] <> 'vide9') then
          BEGIN
            GAME.Cells[j, X[i]] := GAME.Cells[j - 1, X[i]];
            GAME.Cells[j - 1, X[i]] := axi;
          END
          else
          begin
            try
              GAME.Cells[j, X[i]] := GAME.Cells[j - 2, X[i]];
              GAME.Cells[j - 2, X[i]] := axi;
            except
            end;
          end;
        end;

      end;
      // remplissage tete//
      remplirTete();
      // end remplissage tete//
      coloration();
    end;
    if (Active1.Checked = true) and (hori = true) then
    begin
      MediaPlayer2.close;
      MediaPlayer2.Open;
      MediaPlayer2.Play;
    end;
    // test
    for i := nb2 - nbv + 1 to nb2 do
    begin
      verticale := true;
      for j := Y[i] downto 1 do
      begin
        // remplissage tete//
        remplirTete();
        // end remplissage tete//
        axi := GAME.Cells[j, X[i]];
        if axi = 'vide' then
        begin
          if (GAME.Cells[j - 1, X[i]] <> 'vide1') and
            (GAME.Cells[j - 1, X[i]] <> 'vide2') and
            (GAME.Cells[j - 1, X[i]] <> 'vide3') and
            (GAME.Cells[j - 1, X[i]] <> 'vide4') and
            (GAME.Cells[j - 1, X[i]] <> 'vide5') and
            (GAME.Cells[j - 1, X[i]] <> 'vide6') and
            (GAME.Cells[j - 1, X[i]] <> 'vide7') and
            (GAME.Cells[j - 1, X[i]] <> 'vide8') and
            (GAME.Cells[j - 1, X[i]] <> 'vide9') then
          BEGIN
            GAME.Cells[j, X[i]] := GAME.Cells[j - 1, X[i]];
            GAME.Cells[j - 1, X[i]] := axi;
          END
          else
          begin
            try
              GAME.Cells[j, X[i]] := GAME.Cells[j - 2, X[i]];
              GAME.Cells[j - 2, X[i]] := axi;
            except
            end;
          end;
        end;

      end;
      // remplissage tete//
      remplirTete();
      // end remplissage tete//
      coloration();
      sleep(90)

    end;
    // end test

    if (Active1.Checked = true) and (verticale = true) then
    begin
      MediaPlayer2.close;
      MediaPlayer2.Open;
      MediaPlayer2.Play;
    end;

    coloration();
    scor := nb2 * 5 + scor;
    Label3.Caption := inttostr(scor);
    GAME.Enabled := false;
    Timer2.Enabled := false;
    Timer1.Interval := 400;
  end
  else
  begin

    Timer2.Enabled := true;
    Timer1.Enabled := false;
    recherche();
    if nb2 < 3 then
    begin
      GAME.Enabled := true;
    end;
  end;

end;

procedure TForm1.closeClick(Sender: TObject);
begin
  Form1.Quitter1.Click;
end;

procedure TForm1.sonactiverClick(Sender: TObject);
begin
  Desactiver1.Click;
  Active1.Checked := false;
end;

procedure TForm1.sondesactiverClick(Sender: TObject);
begin
  Active1.Click;
end;

procedure TForm1.Timer2Timer(Sender: TObject);

begin
  inc(ss);
  mm := 50 - ss + (depmax div 2) + 4;
  Label6.Caption := inttostr(mm) + ' ';

  if (Niveau in [1 .. 3]) and (mm <= 0) and (dep < depmax) then
  begin
    if Active1.Checked = true then
    begin

      gamend.Enabled := true;
      gamesound.Enabled := false;
      MediaPlayer3.Stop;
      MediaPlayer1.Open;
      MediaPlayer1.Play;
    end;
    Timer2.Enabled := true;
    lose.Visible := true;
    GAME.Visible := false;
    Form1.Refresh;
    Timer2.Enabled := false;
    Form1.Refresh;
    showmessage('EL Marra ejjaya hihihi loOl <5sert>');
    shellexecute(0, 'open', pchar(Application.ExeName), nil, nil, sw_show);
    Application.Terminate;
  end

  // Next Level
  else if ((Niveau = 1) and (dep >= depmax)) then
  begin
    gagne.Visible := true;
    GAME.Visible := false;
    Form1.Refresh;
    Timer2.Enabled := false;
    sleep(3000);
    GAME.Visible := true;
    gagne.Visible := false;
    Niveau := 2;
    initialisation();

  end
  else if ((Niveau = 2) and (dep >= depmax)) then
  begin
    gagne.Visible := true;
    GAME.Visible := false;
    Timer2.Enabled := false;
    Form1.Refresh;
    sleep(3000);
    GAME.Visible := true;
    gagne.Visible := false;
    Niveau := 3;
    initialisation();
  end
  else if ((Niveau = 3) and (dep >= depmax)) then
  begin
    gagne.Visible := true;
    GAME.Visible := false;
    Timer2.Enabled := false;
    Form1.Refresh;
    sleep(3000);
    GAME.Visible := true;
    gagne.Visible := false;
    Niveau := 1;
    inc(depmax, 5);
    initialisation();
  end;

end;

procedure TForm1.Commentjouer1Click(Sender: TObject);
begin
  Form1.Hide;
  form3.show;
  Timer2.Enabled := false;
end;

procedure TForm1.gamesoundTimer(Sender: TObject);
begin
  MediaPlayer3.close;
  MediaPlayer3.Open;
  MediaPlayer3.Play;
end;

procedure TForm1.gamendTimer(Sender: TObject);
begin
  MediaPlayer1.close;
  MediaPlayer1.Open;
  MediaPlayer1.Play;
end;

end.
