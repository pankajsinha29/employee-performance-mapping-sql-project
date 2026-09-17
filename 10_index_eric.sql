EXPLAIN
SELECT * FROM emp_record_table WHERE FIRST_NAME = 'Eric';

CREATE INDEX idx_emp_first_name
ON emp_record_table(FIRST_NAME);

EXPLAIN
SELECT * FROM emp_record_table WHERE FIRST_NAME = 'Eric';
