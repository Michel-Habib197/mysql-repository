import sqlite3
import pandas as pd

#Connecting the database employees.db

conn = sqlite3.connect('employees.db')

#SQL query for bring data by employee and year

query = """
SELECT
    e.emp_no,
    e.first_name AS FirstName, 
    e.last_name AS LastName, 
    d.dept_name AS Department, 
    t.title AS Title,
    s.salary AS salary,
    strftime('%Y', s.from_date) AS year
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN departments d ON d.dept_no = de.dept_no
INNER JOIN salaries s ON s.emp_no = e.emp_no
INNER JOIN titles t ON t.emp_no = e.emp_no
"""
#Loading data in Pandas

df = pd.read_sql_query(query, conn)

# Converte a coluna de ano para inteiro
df['year'] = df['year'].astype(int)


# Pivotar os dados: linhas = funcionário; colunas = anos; valores = soma de salários
pivot = df.pivot_table(
    index=['emp_no', 'FirstName', 'LastName', 'Department', 'Title'],
    columns='year',
    values='salary',
    aggfunc='sum'

).reset_index()

# Exporta para CSV
pivot.to_csv('salaries_per_year.csv', index=False)

#Close the connection
conn.close

