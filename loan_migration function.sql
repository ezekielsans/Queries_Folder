/*
	INSERT INTO loan_statement (
    acctno, statement_date, principal_due, interest_due, 
    fines_due, principal_paid, interest_paid, fines_paid, 
    previous_balance, current_balance
)
*/


DO 
$$

BEGIN
PERFORM 

EXPLAIN ANALYZE SELECT 
    lc.acctno,
    s.stmt_date::date,
    COALESCE(NULLIF(prin_due, '            ')::numeric, 0.00) AS prin_due,
    COALESCE(NULLIF(int_due, '            ')::numeric, 0.00) AS int_due,
    COALESCE(NULLIF(fines_due, '            ')::numeric, 0.00) AS fines_due,
    COALESCE(NULLIF(prin_pd, '            ')::numeric, 0.00) AS prin_pd,
    COALESCE(NULLIF(int_pd, '            ')::numeric, 0.00) AS int_pd,
    COALESCE(NULLIF(fines_pd, '            ')::numeric, 0.00) AS fines_pd,
    COALESCE(NULLIF(prev_bal, '            ')::numeric, 0.00) AS prev_bal,
    COALESCE(NULLIF(pres_bal, '            ')::numeric, 0.00) AS pres_bal
FROM 
    stmt_ s
JOIN 
    loan_class lc ON CONCAT('LN', replace(s.acctno, '-', ''), '_', s.loancode, s.loanser) = SUBSTRING(lc.acctno, 0, 13);

RAISE NOTICE 'HELLO % ', ls.acctno;
END 
$$;

SELECT COUNT(*) FROM   loan_statement 

DO 
$$
DECLARE
tatatatime timestamp;
BEGIN

tatatatime:=returncustomdate1();
RAISE NOTICE 'TIME: %',tatatatime;

END

$$
SELECT * FROM loan_statement


602,883
