"""Regenerate the fast Kummer presentation from the original alpha polynomial."""
import json
from exact_fields import *

def solve_field(mat, rhs, field):
    a=[list(row)+[r] for row,r in zip(mat,rhs)];n=len(rhs)
    for c in range(n):
        p=next(i for i in range(c,n) if a[i][c])
        a[c],a[p]=a[p],a[c];v=a[c][c].inverse();a[c]=[x*v for x in a[c]]
        for i in range(n):
            if i!=c:
                v=a[i][c];a[i]=[x-v*y for x,y in zip(a[i],a[c])]
    return [row[-1] for row in a]

if __name__=='__main__':
    theta=pi(evaluate(CODES['c'],alpha_T),2)
    d=theta**4;assert not any(d.c[1:])
    rows={}
    for name,row in CODES.items():
        z=evaluate(row,alpha_T);rows[name]=[]
        for j in range(4):
            v=pi(z,pow(2,j,5))/(theta**j);assert not any(v.c[1:])
            rows[name].append(to_code(v.c[0]))
    mat=list(map(list,zip(*[(theta**j).c for j in range(4)])))
    ar=solve_field(mat,alpha_T.c,F25)
    assert sum((embed(v,T)*theta**j for j,v in enumerate(ar)),T.zero)==alpha_T
    print(json.dumps({'kummer_generator':'theta=c-hat_2',
        'theta_fourth_power':to_code(d.c[0]),'polynomial_rows_in_theta':rows,
        'alpha_row_in_theta':[to_code(x) for x in ar]},indent=2))
