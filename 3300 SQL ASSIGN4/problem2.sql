execute procedure drop_if_exists('trigger', 'tr_salary_class_insert');

commit work;

set term # ;
create trigger tr_salary_class_insert for EMPLOYEE_TESTER after insert
as
DECLARE new_class VARCHAR(5);

BEGIN
-- below is an example for calling the stored procedure and 
-- putting the return value in a variable. 
select CLASS from f_class(NEW.salary) into :new_class;
-- Notice that the variable name is preceded by a colon when 
-- used in an SQL statement. 
-- Also notice that the INTO goes at the end of the 
-- select, unlike the standard. 
-- Finally, NEW holds value of the new row that was inserted into the table. 
-- delete triggers have an OLD variable that holds the value of the 
-- deleted row, and update triggers have both NEW and OLD. 
-- rest of trigger definition goes here 

update SALARY_CLASS
set OCCURRENCES = OCCURRENCES+1
where CLASS = :new_class;
end #
set term ; #

delete from EMPLOYEE_TESTER;
commit work;

insert into EMPLOYEE_TESTER
select * from EMPLOYEE;

commit work;

select * from SALARY_CLASS;

commit work;
