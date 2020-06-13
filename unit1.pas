unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StrUtils, Forms, FileUtil, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ListBox1: TListBox;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure read_questions();
    procedure get_question(Strength: Integer);
    procedure win_check(button_text: String);
    procedure game_over(is_win: Boolean);
    function current_money(question_number: Integer) : Cardinal;
  public
  end;

var
  Form1: TForm1;
  answer: array [1..4] of String;
  correct_answer: String;
  current_question: Integer;
  logic_question_files: TStringList;
  analysis_question_files: TStringList;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
     read_questions();
     current_question := 1;
     get_question(1);
end;

procedure TForm1.read_questions();
const
  logic_file_folder = 'Questions/L/';
  analysis_file_folder = 'Questions/A/';
begin
     logic_question_files := TStringList.Create;
     FindAllFiles(logic_question_files, logic_file_folder, '*.txt', true);

     analysis_question_files := TStringList.Create;
     FindAllFiles(analysis_question_files, analysis_file_folder, '*.txt', true);
end;

procedure TForm1.get_question(Strength: Integer);
var
  output_string: String;
  line_index: Integer;
  file_name: String;
  text_file: TextFile;
  rand_question_number: Integer;
  question: String;
begin
     Randomize;

     // 1 - Easy
     // 2 - Medium
     // 3 - Hard quesitons
     if Strength = 1 then
         rand_question_number := Random(4)
     else if Strength = 2 then
         rand_question_number := Random(5) + 5
     else if Strength = 3 then
         rand_question_number := Random(10) + 5;

     file_name := logic_question_files[rand_question_number];

     // Remove used item from questions so it doesnt come up again
     logic_question_files.Delete(rand_question_number);

     line_index := 0;

     // Reading from plaintext file
     AssignFile(text_file, file_name);
     reset(text_file);

     while not eof(text_file) do begin
        line_index := line_index + 1;

        // Reads line into a string
        Readln(text_file, output_string);

        if line_index = 1 then
           question := output_string
        else if line_index >= 2 then begin
             if AnsiContainsStr(output_string, '+ ') then begin
                 Delete(output_string, 1, 2);
                 correct_answer := output_string;
             end
             else
                 Delete(output_string, 1, 2);

             answer[line_index - 1] := output_string;
        end;
     end;

     CloseFile(text_file);

     Button1.Caption := 'A: ' + answer[1];
     Button2.Caption := 'B: ' + answer[2];
     Button3.Caption := 'C: ' + answer[3];
     Button4.Caption := 'D: ' + answer[4];

     Memo1.Lines.Clear;
     Memo1.Lines.Add(question);

     // Debug stuff
     //Memo1.Lines.Add(correct_answer);
     //Memo1.Lines.Add(file_name);
     //Memo1.Lines.Add(IntToStr(current_question));
end;

procedure TForm1.win_check(button_text: String);
begin
  Delete(button_text, 1, 3);

  if button_text = correct_answer then begin
     current_question := current_question + 1;

     // Select current question in listbox
     ListBox1.ItemIndex := 15 - current_question;

     if current_question <= 4 then
         get_question(1)
     else if current_question <= 10 then
         get_question(2)
     else if current_question <= 15 then
         get_question(3)
     else
         game_over(true);
  end
  else
     game_over(false);
end;

function TForm1.current_money(question_number: Integer) : Cardinal; // cardinal == unsigned int
begin
  case question_number of
      0..4: current_money := 0;
      5..9: current_money := 5000;
      10..14: current_money := 100000;
      15: current_money := 3000000;
  end;
end;

procedure TForm1.game_over(is_win: Boolean);
begin
  Memo1.Lines.Clear;
  if is_win then
     Memo1.Lines.Add('Вы выиграли!')
  else
     Memo1.Lines.Add('Вы проиграли!');

  Memo1.Lines.Add('Вы уходите домой с ' + IntToStr(current_money(current_question - 1)) + ' рублей!');

  // Disable all buttons
  Button1.Enabled := false;
  Button2.Enabled := false;
  Button3.Enabled := false;
  Button4.Enabled := false;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  output_string: String;
begin
  output_string := Button1.Caption;
  win_check(output_string);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  output_string: String;
begin
  output_string := Button2.Caption;
  win_check(output_string);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  output_string: String;
begin
  output_string := Button3.Caption;
  win_check(output_string);
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  output_string: String;
begin
  output_string := Button4.Caption;
  win_check(output_string);
end;

end.

