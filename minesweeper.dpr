program Project63;
{$APPTYPE CONSOLE}
{$R+,Q+,X-}

uses
  System.SysUtils;

const
  Spielfeldbreite = 5;
  Spielfeldhöhe = 4;
  threshold = 0.2;

type
  TZustand = (HiddenLeer, HiddenBomb, ShownLeer, ShownBomb);
  TZellZustand = array [0 .. Spielfeldhöhe+1, 0 .. Spielfeldbreite+1] of TZustand;
  THorizental = array [1 .. Spielfeldbreite] of Byte;
  TVertikal = array [1 .. Spielfeldhöhe] of Byte;
  TCube = array [1 .. Spielfeldhöhe, 1 .. Spielfeldbreite] of Byte;
var
  I, J: Integer;
  ZellZustand: TZellZustand;
  Horizental: THorizental;
  Vertikal: TVertikal;
  GameOver: Boolean;
  AnzahlBomb, AnzahlHiddenleer: Integer;
  Cube : TCube;

begin
  for I := 0 to  Spielfeldhöhe+1 do
    Zellzustand [I,0] := HiddenLeer;
  for J := 0 to Spielfeldbreite+1 do
      Zellzustand [0,J] := HiddenLeer;
  for J := 0 to Spielfeldbreite+1 do
    Zellzustand [Spielfeldhöhe+1,0] := HiddenLeer;
  for I := 0 to  Spielfeldhöhe+1 do
    Zellzustand [I,Spielfeldbreite+1] := HiddenLeer;


  for I := 1 to Spielfeldhöhe do
    for J := 1 to Spielfeldbreite do
      if random < threshold then
        ZellZustand[I, J] := HiddenBomb
      else
        ZellZustand[I, J] := HiddenLeer;


  for I := 1 to Spielfeldbreite do
    Horizental[I] := I;
  for I := 1 to Spielfeldhöhe do
    Vertikal[I] := I;
  GameOver := False;


  while (not GameOver)  do
  begin
    write(' ');
    for I := 1 to Spielfeldbreite do
      Write(Horizental[I]);
    writeln;

    for I := 1 to Spielfeldhöhe do
    begin
      write(Vertikal[I]);
      for J := 1 to Spielfeldbreite do
        case (ZellZustand[I, J]) of
          HiddenLeer: Write('O');
          HiddenBomb: Write('O');
          ShownBomb: write('X');
          ShownLeer: write(Cube[I,J]);
        end;
      writeln;
    end;


  write('Geben Sie bitte Zeile ein: ');
    readln(I);
    Write('Geben Sie bitte Spalte ein: ');
    readln(J);

    if ZellZustand[I, J] = HiddenBomb then
    begin
      GameOver := True;
      ZellZustand[I, J] := ShownBomb;
      write(' ');
      for I := 1 to Spielfeldbreite do
        Write(Horizental[I]);
      writeln;
      for I := 1 to Spielfeldhöhe do
      begin
        write(Vertikal[I]);
        for J := 1 to Spielfeldbreite do
          case (ZellZustand[I, J]) of
            HiddenLeer: Write('O');
            HiddenBomb: Write('O');
            ShownBomb: write('X');
            ShownLeer: write(Cube[I,J]);
          end;
        writeln;
      end;
      writeln('Sie haben verloren');
    end
    else
    begin
      AnzahlBomb := 0;
      if (((I >= 1) and (I <= Spielfeldhöhe )) and
        ((J >= 1) and (J <= Spielfeldbreite ))) then
      begin
        if ZellZustand[I - 1, J - 1] = HiddenBomb then
          inc(AnzahlBomb);
        if ZellZustand[I, J - 1] = HiddenBomb then
          inc(AnzahlBomb);
        if ZellZustand[I + 1, J - 1] = HiddenBomb then
          inc(AnzahlBomb);
        if ZellZustand[I - 1, J] = HiddenBomb then
          inc(AnzahlBomb);
        if ZellZustand[I, J] = HiddenBomb then
          inc(AnzahlBomb);
        if ZellZustand[I + 1, J] = HiddenBomb then
          inc(AnzahlBomb);
        if ZellZustand[I - 1, J + 1] = HiddenBomb then
          inc(AnzahlBomb);
        if ZellZustand[I, J + 1] = HiddenBomb then
          inc(AnzahlBomb);
        if ZellZustand[I + 1, J + 1] = HiddenBomb then
          inc(AnzahlBomb);
        ZellZustand[I, J] := ShownLeer;
        Cube[I ,J] := AnzahlBomb;
      end;

    AnzahlHiddenleer:= 0;
    for I := 1 to Spielfeldhöhe do
      for J := 1 to Spielfeldbreite do
         if ZellZustand[I, J] = Hiddenleer then
            inc(AnzahlHiddenleer);
    if AnzahlHiddenleer = 0 then
      begin
      GameOver := True;
      write('Sie haben gewonnen');
      end;
    end;
  end;
  readln;
end.
