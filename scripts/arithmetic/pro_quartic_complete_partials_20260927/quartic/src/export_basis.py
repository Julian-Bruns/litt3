"""Construct t=zeta+zeta^-1 and its F5-degree-seven representation."""
import json
from exact_fields import *

def flat(a):
    if a.field is F25: return list(a.c)
    return [v for x in a.c for v in flat(x)]

def solve_mod5(mat, rhs):
    A = [[v%5 for v in row]+[r%5] for row,r in zip(mat,rhs)]
    n = len(A[0])-1; piv=[]; rr=0
    for c in range(n):
        k=next((k for k in range(rr,len(A)) if A[k][c]),None)
        if k is None: continue
        A[rr],A[k]=A[k],A[rr]
        d=pow(A[rr][c],3,5); A[rr]=[(d*v)%5 for v in A[rr]]
        for k in range(len(A)):
            if k != rr and A[k][c]:
                d=A[k][c]; A[k]=[(v-d*w)%5 for v,w in zip(A[k],A[rr])]
        piv.append(c); rr+=1
    if any(not any(row[:-1]) and row[-1] for row in A): raise ValueError('Inconsistent')
    if len(piv)!=n: raise ValueError('Not unique')
    out=[0]*n
    for r,c in enumerate(piv): out[c]=A[r][-1]
    return out

if __name__=='__main__':
    t=zeta+zeta**28
    ps=[K.one]
    for i in range(1,8): ps.append(ps[-1]*t)
    cols=[flat(v) for v in ps[:7]]
    mat=list(map(list,zip(*cols)))
    m=solve_mod5(mat,flat(-ps[7]))+[1]
    B=embed(beta,K)
    cols=ps[:7]+[B*v for v in ps[:7]]
    mat=list(map(list,zip(*(flat(v) for v in cols))))
    z=solve_mod5(mat,flat(zeta))
    print(json.dumps({'Kplus_generator':'t=zeta+zeta^-1','Kplus_modulus':m,
                     'zeta_as_u_plus_beta_v': [z[:7],z[7:]]},indent=2))
