CREATE TABLE Customers (
  customer_id NUMBER PRIMARY KEY,
  name VARCHAR2(100),
  age NUMBER,
  balance NUMBER(10,2),
  isVIP VARCHAR2(5)
);

CREATE TABLE Loans (
  loan_id NUMBER PRIMARY KEY,
  customer_id NUMBER,
  interest_rate NUMBER(5,2),
  due_date DATE,
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Customers VALUES (1, 'Ravi Kumar', 65, 12000, 'FALSE');
INSERT INTO Customers VALUES (2, 'Meena Shah', 45, 8000, 'FALSE');
INSERT INTO Customers VALUES (3, 'Arun Patel', 70, 15000, 'FALSE');

INSERT INTO Loans VALUES (101, 1, 10.5, SYSDATE + 20);
INSERT INTO Loans VALUES (102, 2, 9.0, SYSDATE + 40);
INSERT INTO Loans VALUES (103, 3, 8.5, SYSDATE + 10);

COMMIT;

BEGIN
  FOR rec IN (
    SELECT l.loan_id
    FROM Loans l
    JOIN Customers c ON l.customer_id = c.customer_id
    WHERE c.age > 60
  )
  LOOP
    UPDATE Loans
    SET interest_rate = interest_rate - 1
    WHERE loan_id = rec.loan_id;
  END LOOP;
  COMMIT;
END;
/

BEGIN
  FOR rec IN (
    SELECT customer_id
    FROM Customers
    WHERE balance > 10000
  )
  LOOP
    UPDATE Customers
    SET isVIP = 'TRUE'
    WHERE customer_id = rec.customer_id;
  END LOOP;
  COMMIT;
END;
/

SET SERVEROUTPUT ON;

BEGIN
  FOR rec IN (
    SELECT c.name, l.due_date
    FROM Loans l
    JOIN Customers c ON l.customer_id = c.customer_id
    WHERE l.due_date <= SYSDATE + 30
  )
  LOOP
    DBMS_OUTPUT.PUT_LINE('Reminder: Loan for ' || rec.name || ' is due on ' || TO_CHAR(rec.due_date, 'DD-Mon-YYYY'));
  END LOOP;
END;
/
