** Write a stored procedure to create a new user registration and return status :

validations:
------------

 -> user id should be generate automatically

 -> min. length of password is 6 chars

 -> password should be start with an ALPHABET

 -> Enter and Confirm passwords should be same

 -> role should be accepts ADMIN, EMPLOY, or GUEST only


 Create table user_details(user_id varchar2(10),user_name varchar2(10),password varchar2(10),role varchar2(10));


 Sequence for to generate USER IDs automatically :

 create sequence userid_seq
 start with 1
 increment by 1;
 /



Create or replace procedure create_user_proc
(p_user_name In user_details.user_name%type,p_password In user_details.password%type,p_cnf_password In user_details.password%type,p_role In user_details.role%type ,p_status out Varchar)
                                        is
begin
if length(p_password)>6 then 
p_status:= 'Min password length should be 6 charcter';
elsif ASCII(substr(p_password,1,1))Not between 97 and 122 and
      ASCII(substr(p_password,1,1))Not between 65 and 90 then
p_status:= 'Password should be start with alphabet';
elsif p_password !=p_cnf_password then
p_status:='Enter password and cnf password should be same';
elsif p_role Not In('admin','employee','guest') then
p_status:='Invalid role...';
else
Insert into user_details values(userid_seq.nextval,p_user_name,p_password,p_role);
p_status:='User created succefully';
end if;
end create_user_proc;
/


calling above program :

declare
p_status varchar2(100);
begin
create_user_proc('&user_name','&password','&cnf_password','&role',p_status);
dbms_output.put_line(p_status);
end;
/