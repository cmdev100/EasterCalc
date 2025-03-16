program EasterCalc;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, Math;

type
  TDateRec = record
    Year: Integer;
    Month: Integer;
    Day: Integer;
    function AsString: string;
  end;

function TryGetYear(const AStr: string; out AYear: Integer): Boolean;
begin
  Result := TryStrToInt(AStr, AYear) and InRange(AYear, 1000, 3000);
end;

procedure CalcEasterDay(var ADateRec: TDateRec);
var
  a, b, c, d, e: Integer;
begin
  a := ADateRec.Year mod 19;
  b := ADateRec.Year mod 4;
  c := ADateRec.Year mod 7;
  d := (19*a + 24) mod 30;
  e := (2*b + 4*c + 6*d + 5) mod 7;

  if (d + e) > 9 then
  begin
    ADateRec.Month := 4;
    ADateRec.Day := d + e - 9
  end
  else
  begin
    ADateRec.Month := 3;
    ADateRec.Day := 22 + d + e;
  end;

end;

{ TDateRec }
function TDateRec.AsString: string;
begin
  Result := Format('%d-%.2d-%.2d', [Year, Month, Day]);
end;

var
  LReadStr: string;
  LDone: Boolean;
  LDateRec: TDateRec;
begin
  try
    WriteLn('Please enter a year (YYYY):');

    repeat
      LDone := True;
      LDateRec := Default(TDateRec);

      Readln(LReadStr);

      if SameText(LReadStr, 'Exit') then
        Exit
      else if TryGetYear(LReadStr, LDateRec.Year) then
      begin
        CalcEasterDay(LDateRec);
        WriteLn(Format('The easter day is: %s.', [LDateRec.AsString]));
      end
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
