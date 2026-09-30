#!/usr/bin/env python3
"""Produce an absolute degree-eight presentation, independently over F5."""
import json
from pathlib import Path
from independent_verify import add,mul,power

def digits(v):
    out=[]
    for _ in range(8):out.append(v%5);v//=5
    return out

def solve(columns,target):
    mat=[[columns[j][i] for j in range(8)]+[target[i]] for i in range(8)]
    for j in range(8):
        pivot=next(i for i in range(j,8) if mat[i][j])
        mat[j],mat[pivot]=mat[pivot],mat[j]
        inv=pow(mat[j][j],-1,5);mat[j]=[(inv*x)%5 for x in mat[j]]
        for i in range(8):
            if i!=j:
                a=mat[i][j];mat[i]=[(x-a*y)%5 for x,y in zip(mat[i],mat[j])]
    return [mat[i][-1] for i in range(8)]

def evaluate(row):
    out=0
    for c in reversed(row):out=add(mul(out,25),c)
    return out

cols=[digits(power(25,i)) for i in range(8)]
beta=solve(cols,digits(5))
coeff=solve(cols,digits(power(25,8)))
modulus=[(-c)%5 for c in coeff]+[1]
assert evaluate(beta)==5 and evaluate(modulus)==0
out={'characteristic':5,'degree':8,'generator_K_code':25,
     'absolute_modulus_ascending_F5':modulus,'beta_in_alpha_ascending_F5':beta}
root=Path(__file__).resolve().parents[1]
(root/'data'/'field_model.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,sort_keys=True))
print('PASS: absolute presentation and beta embedding verified in the tower field.')
