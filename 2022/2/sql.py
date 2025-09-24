import pandas as pd
import sqlite3

x = pd.read_csv("x.csv")
c = sqlite3.connect(":memory:")
x.to_sql(name="x", index=False, con=c)

sql = """
select sum((3+V2-V1+1)%3*3) + sum(V2+1) as problem_1,
       sum((3+V2+V1-1)%3+1) + sum(V2*3) as problem_2
from x
"""

print(pd.read_sql_query(sql, c).T)

# or

sql = """
select sum(iif(V1==0 and V2==1
                or V1==1 and V2==2
                or V1==2 and V2==0, 7+V2, 0)) +
       sum(iif(V1==V2, 4+V2, 0)) +
       sum(iif(V1==0 and V2==2
            or V1==1 and V2==0
            or V1==2 and V2==1, 1+V2, 0)) as problem_1,
       sum(iif(V2==2, iif(V1==0, 8, iif(V1==1, 9, 7)), 0)) +
       sum(iif(V2==1, 4+V1, 0)) +
       sum(iif(V2==0, iif(V1==0, 3, iif(V1==1, 1, 2)), 0)) as problem_2
from x
"""

print(pd.read_sql_query(sql, c).T)
