execute procedure drop_if_exists('trigger', 'tr_salary_class_delete');
commit work;
execute procedure drop_if_exists('trigger', 'TR_SALARY_CLASS_INSERT');
commit work;
execute procedure drop_if_exists('trigger', 'tr_salary_class_update');
commit work;
execute procedure drop_if_exists('table', 'SALARY_CLASS');
commit work;
execute procedure drop_if_exists('procedure', 'F_CLASS');
commit work;


CREATE TABLE SALARY_CLASS
(
	CLASS VARCHAR(5) primary key,
	OCCURRENCES INT DEFAULT 0 
);

commit work;

set term # ;
EXECUTE BLOCK AS BEGIN
INSERT INTO SALARY_CLASS (CLASS, OCCURRENCES) VALUES ('ELITE', 0);
INSERT INTO SALARY_CLASS (CLASS, OCCURRENCES) VALUES ('HIGH', 0);
INSERT INTO SALARY_CLASS (CLASS, OCCURRENCES) VALUES ('MID', 0);
INSERT INTO SALARY_CLASS (CLASS, OCCURRENCES) VALUES ('LOW', 0);
END #

commit work#

create procedure f_class(salary SALARY)
returns (class VARCHAR(5)) as
begin
	if (salary < 40000) then
		class = 'LOW';
	else if (salary >= 40000 and salary < 68000) then
		class = 'MID';
	else if (salary >= 68000 and salary < 100000) then
		class = 'HIGH';
	else
		class = 'ELITE';
	SUSPEND;
END #
set term ; #


SELECT * FROM SALARY_CLASS;

