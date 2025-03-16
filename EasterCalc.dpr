program EasterCalc;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, Math;

function TryGetYear(const AStr: string; out AYear: Integer): Boolean;
begin
  Result := TryStrToInt(AStr, AYear) and InRange(AYear, 1000, 3000);
end;

function CalcEasterDay(LYear: Integer): string;
var
  a, b, c, d, e,
  LDay, LMonth: Integer;
begin
  a := LYear mod 19;
  b := LYear mod 4;
  c := LYear mod 7;
  d := (19 *a + 24) mod 30;
  e := (2*b+4*c+6*d+5) mod 7;

  if (d + e) > 9 then
  begin
    LMonth := 4;
    LDay := d + e - 9
  end
  else
  begin
    LMonth := 3;
    LDay := 22 + d + e;
  end;

  Result := Format('%d-%.2d-%.2d', [LYear, LMonth, LDay]);
end;

var
  LReadStr: string;
  LYear: Integer;
  LDone: Boolean;
begin
  try
    WriteLn('Please enter a year (YYYY):');

    repeat
      LDone := True;

      Readln(LReadStr);

      if SameText(LReadStr, 'Exit') then
        Exit
      else if TryGetYear(LReadStr, LYear) then
        WriteLn(Format('The easter day is: %s.', [CalcEasterDay(LYear)]))
      else
      begin
        WriteLn(Format('The entered data (%s) is not a valid year.' + sLineBreak +
          'Try again: ', [LReadStr]));
        LDone := False;
      end;

    until LDone;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
