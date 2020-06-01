unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StrUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    question: String;
    answer: array [1..4] of String;
    correct_answer: String;
    textfile: TextFile;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
const
  FileName = 'Questions/1.txt';
var
  output_string: String;
  line_index: Integer;
begin

     line_index := 0;

     // Reading from plaintext file
     AssignFile(textfile, filename);
     reset(textfile);
     while not eof(textfile) do begin
        line_index := line_index + 1;

        // Reads line into a string
        Readln(textfile, output_string);

        if line_index = 1 then
           question := output_string
        else if line_index >= 2 then begin
             if AnsiContainsStr(output_string, '+ ') then begin
                correct_answer := output_string;
             end;

             Delete(output_string, 1, 2);
             answer[line_index - 1] := output_string;
        end;
     end;

     CloseFile(textfile);

     Button1.Caption := 'A: ' + answer[1];
     Button2.Caption := 'B: ' + answer[2];
     Button3.Caption := 'C: ' + answer[3];
     Button4.Caption := 'D: ' + answer[4];

     Memo1.Lines.Clear;
     Memo1.Lines.Add(question);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin

end;

end.

