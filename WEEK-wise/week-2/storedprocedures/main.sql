SET SERVEROUTPUT ON;

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE Savings_Accounts_Custom';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE Employee_Records_Custom';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE Bank_Accounts_Custom';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

CREATE TABLE Savings_Accounts_Custom (
  account_id NUMBER PRIMARY KEY,
  customer_id NUMBER,
  balance NUMBER(10,2)
);
/

CREATE TABLE Employee_Records_Custom (
  emp_id NUMBER PRIMARY KEY,
  name VARCHAR2(100),
  department VARCHAR2(50),
  salary NUMBER(10,2)
);
/

CREATE TABLE Bank_Accounts_Custom (
  account_id NUMBER PRIMARY KEY,
  customer_id NUMBER,
  balance NUMBER(10,2)
);
/

INSERT INTO Savings_Accounts_Custom VALUES (201, 1, 10000);
INSERT INTO Savings_Accounts_Custom VALUES (202, 2, 15000);
INSERT INTO Savings_Accounts_Custom VALUES (203, 3, 20000);

INSERT INTO Employee_Records_Custom VALUES (301, 'Ananya', 'Finance', 50000);
INSERT INTO Employee_Records_Custom VALUES (302, 'Rahul', 'HR', 40000);
INSERT INTO Employee_Records_Custom VALUES (303, 'Priya', 'Finance', 55000);

INSERT INTO Bank_Accounts_Custom VALUES (401, 1, 5000);
INSERT INTO Bank_Accounts_Custom VALUES (402, 1, 3000);
INSERT INTO Bank_Accounts_Custom VALUES (403, 2, 7000);

COMMIT;
/

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest_Custom AS
BEGIN
  FOR acc IN (SELECT account_id, balance FROM Savings_Accounts_Custom) LOOP
    UPDATE Savings_Accounts_Custom
    SET balance = balance + (balance * 0.01)
    WHERE account_id = acc.account_id;
  END LOOP;
  COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus_Custom (
  dept_name IN VARCHAR2,
  bonus_pct IN NUMBER
) AS
BEGIN
  UPDATE Employee_Records_Custom
  SET salary = salary + (salary * bonus_pct / 100)
  WHERE department = dept_name;
  COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE TransferFunds_Custom (
  from_acc IN NUMBER,
  to_acc IN NUMBER,
  amount IN NUMBER
) AS
  from_balance NUMBER;
BEGIN
  SELECT balance INTO from_balance FROM Bank_Accounts_Custom WHERE account_id = from_acc FOR UPDATE;

  IF from_balance >= amount THEN
    UPDATE Bank_Accounts_Custom SET balance = balance - amount WHERE account_id = from_acc;
    UPDATE Bank_Accounts_Custom SET balance = balance + amount WHERE account_id = to_acc;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transfer of ' || amount || ' successful.');
  ELSE
    RAISE_APPLICATION_ERROR(-20001, 'Insufficient balance in source account.');
  END IF;
END;
/

EXEC ProcessMonthlyInterest_Custom;
EXEC UpdateEmployeeBonus_Custom('Finance', 10);
EXEC TransferFunds_Custom(401, 402, 1000);
