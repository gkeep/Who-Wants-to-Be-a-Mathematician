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
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure get_question(Strength: Integer);
  public
  end;

var
  Form1: TForm1;
  answer: array [1..4] of String;
  correct_answer: String;
  current_question: Integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
     current_question := 1;
     get_question(1);

end;

procedure TForm1.get_question(Strength: Integer);
const
  logic_file_folder = 'Questions/L/';
  analysis_file_folder = 'Questions/A/';
var
  output_string: String;
  line_index: Integer;
  file_name: String;
  logic_question_files: TStringList;
  q_file: String;
  text_file: TextFile;
  rand_question_number: Integer;
  question: String;
begin
     Randomize;

     logic_question_files := TStringList.Create;
     FindAllFiles(logic_question_files, logic_file_folder, '*.txt', true);

     // 1 - Easy
     // 2 - Medium
     // 3 - Hard quesitons
     if Strength = 1 then
         rand_question_number := Random(4)
     else if Strength = 2 then
         rand_question_number := Random(5) + 5
     else if Strength = 3 then
         rand_question_number := Random(10) + 5;

     // Read file names from directory
     for q_file in logic_question_files do begin
        file_name := q_file;
     end;

     //Memo1.Lines.Add(file_name);

     file_name := logic_question_files[rand_question_number];

     // Remove used item from questions so it doesn't come up again
     //logic_question_files.Delete(rand_question_number);

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
     Memo1.Lines.Add(correct_answer);
     Memo1.Lines.Add(file_name);
     Memo1.Lines.Add(IntToStr(current_question));
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  output_string: String;
begin
  output_string := Button1.Caption;
  Delete(output_string, 1, 3);

  //Memo1.Lines.Add(Button1.Caption);

     if output_string = correct_answer then begin
        current_question := current_question + 1;

        if current_question <= 4 then
            get_question(1)
        else if current_question <= 10 then
            get_question(2)
        else if current_question <= 15 then
            get_question(3)
        else
            // you won screen
            Memo1.Lines.Add('You won!');
     end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
   output_string: String;
begin
   output_string := Button2.Caption;
   Delete(output_string, 1, 3);

   //Memo1.Lines.Add(Button2.Caption);

     if output_string = correct_answer then begin
        current_question := current_question + 1;

        if current_question <= 4 then
            get_question(1)
        else if current_question <= 10 then
            get_question(2)
        else if current_question <= 15 then
            get_question(3)
        else
            // you won screen
            Memo1.Lines.Add('You won!');
     end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  output_string: String;
begin
  output_string := Button3.Caption;
  Delete(output_string, 1, 3);

  //Memo1.Lines.Add(Button3.Caption);

   if output_string = correct_answer then begin
      current_question := current_question + 1;

      if current_question <= 4 then
          get_question(1)
      else if current_question <= 10 then
          get_question(2)
      else if current_question <= 15 then
          get_question(3)
      else
          // you won screen
          Memo1.Lines.Add('You won!');
   end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  output_string: String;
begin
  output_string := Button4.Caption;
  Delete(output_string, 1, 3);

  //Memo1.Lines.Add(Button4.Caption);

  if output_string = correct_answer then begin
     current_question := current_question + 1;

     if current_question <= 4 then
         get_question(1)
     else if current_question <= 10 then
         get_question(2)
     else if current_question <= 15 then
         get_question(3)
     else
         // you won screen
         Memo1.Lines.Add('You won!');
  end;
end;

end.

