CREATE FUNCTION data_masking(in_column varchar(500) ) RETURNS varchar(100) 
begin

declare column_str varchar(500);
declare input_str_len int;
declare str_position int;
declare masked_value_int int;
declare masked_value_int_len int;
declare masked_value_position int;
declare masked_single_char varchar(5);
declare final_masked_value_str varchar(100);



-- initializing variables
set input_str_len = LENGTH(in_column); -- length of input string
set column_str = UPPER(in_column);
set str_position = 1; 
set masked_value_int =0 ; 

-- loop to get numeric masked value
while input_str_len>0  do 

   
   set masked_value_int =masked_value_int+(ascii(case when cast(substr(column_str,str_position,1)as char(1)) in( ' ' ,'�','”') then ' '
 else substr(column_str,str_position,1) end )*str_position);

   set  str_position=str_position+1;
   set input_str_len=input_str_len-1;
end while;

-- return concat(substr(in_column,1,1) ,substr(in_column,LENGTH(in_column),1),' ',hex(masked_value_int));

-- initializing variables
set masked_value_int_len=LENGTH(masked_value_int); -- length of masked numeric value
set masked_value_position=1;
set final_masked_value_str=concat(substr(column_str,1,1) ,substr(column_str,LENGTH(column_str),1),LENGTH(masked_value_int),' '); -- concatenating first char, last char and length of the input string

-- loop to convert numeric mask value to string
while masked_value_int_len>0  do 
   
   set masked_single_char =substr(masked_value_int,masked_value_position,1);

set final_masked_value_str=concat(final_masked_value_str,
case     when masked_single_char=1  then 'A' 
         when masked_single_char=2  then 'B' 
         when masked_single_char=3  then 'C' 
         when masked_single_char=4  then 'D' 
         when masked_single_char=5  then 'E' 
         when masked_single_char=6  then 'F' 
         when masked_single_char=7  then 'G' 
         when masked_single_char=8  then 'H' 
         when masked_single_char=9  then 'I' 
         when masked_single_char=10  then 'J' 
         when masked_single_char=11  then 'K' 
         when masked_single_char=12  then 'L' 
         when masked_single_char=13  then 'M' 
         when masked_single_char=14  then 'N' 
         when masked_single_char=15  then 'O' 
         when masked_single_char=16  then 'P' 
         when masked_single_char=17  then 'Q' 
         when masked_single_char=18  then 'R' 
         when masked_single_char=19  then 'S' 
         when masked_single_char=20  then 'T' 
         when masked_single_char=21  then 'U' 
         when masked_single_char=22  then 'V' 
         when masked_single_char=23  then 'W' 
         when masked_single_char=24  then 'X' 
         when masked_single_char=25  then 'Y' 
         when masked_single_char=26  then 'Z' 
else 'SN'
end);


   set  masked_value_position=masked_value_position+1;
   set masked_value_int_len=masked_value_int_len-1;
end while;

return final_masked_value_str;


end