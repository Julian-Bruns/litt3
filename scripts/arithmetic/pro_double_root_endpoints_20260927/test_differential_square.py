"""Bounded exact tests of the universal differential-square presentation.
The universal ideal identity is proved in REPORT; tests do not replace it.
"""
import json,random,time
from exact import ROOT
from extension import E,Poly,init
from residual import sm,sf
from differential_square import (LINEAR_INDICES,QUADRATIC_INDICES,
    root_residual,differential_values,equations,verify_transfer,linear_rows)

def canonical_root(A):
    L=A[0][0]
    assert A[0].degree()==0
    al=[a/L for a in A]
    a2=sm(al,al,71);a3=sm(a2,al,71)
    return sm(sm(a3,sf(a2,1,71),71),sf(a2,2,71),71)

def triangular_checks(A,B):
    E0,D=verify_transfer(A,B)
    L=A[0][0];zero=Poly()
    # All coefficient identities, including dependent resonant D_m.
    for m in range(1,141):
        rhs=sum((A[i]*E0[m-i]*((m-2*i)%5)/L
                 for i in range(1,m)),zero)
        rhs=rhs-sum((B[i]*D[m-i-1] for i in range(1,min(70,m-1)+1)),zero)
        assert D[m-1]-E0[m]*(m%5)==rhs,('triangular',m)
    return E0,D

def context(mod,name):
    init(mod);rng=random.Random(270927);d=len(mod)-1
    rand=lambda:Poly(E([rng.randrange(390625) for _ in range(d)]))
    B=[rand() for _ in range(71)];B[0]=Poly(1);L=E(27)
    A=[a*L for a in sm(B,B,141)]
    residual,D=triangular_checks(A,B)
    assert not any(residual) and not any(D) and not any(equations(A,B))
    assert canonical_root(A)==B
    # A non-square input still has the unique normalized formal root to order70.
    A=[rand() for _ in range(141)];A[0]=Poly(L)
    B=canonical_root(A);residual,D=triangular_checks(A,B)
    assert not any(residual[:71]) and not any(equations(A,B)[:70])
    assert any(residual[71:]) and any(equations(A,B)[70:])
    # Verify explicit matrix coefficients against direct differential expansion.
    rows=linear_rows(A)
    for m,row in zip(LINEAR_INDICES,rows):
        assert sum((a*b for a,b in zip(row,B)),Poly())==D[m-1]
    traps=[]
    for n in (125,126,130,135,140):
        A=[Poly() for _ in range(141)];A[0]=Poly(1);A[n]=Poly(1)
        B=[Poly() for _ in range(71)];B[0]=Poly(1)
        er=equations(A,B);nonzero=[i+1 for i,p in enumerate(er) if p]
        assert nonzero==[n]
        DD=differential_values(A,B,full=True)
        if n%5==0:assert not any(DD)
        else:assert DD[n-1]==Poly((-n)%5)
        traps.append({'T_degree':n,'sole_nonzero_generator_index':n,
                      'differential_relaxation_accepts':not any(DD)})
    nilpotent=False
    if mod==[0,0,1]:
        eps=E([0,1]);assert eps and not eps*eps
        A=[Poly() for _ in range(141)];A[0]=Poly(1);A[140]=Poly(eps)
        B=[Poly() for _ in range(71)];B[0]=Poly(1)
        er=equations(A,B)
        assert not any(er[:139]) and er[139]==Poly(-eps)
        assert er[139] and not er[139]*er[139]
        assert not any(differential_values(A,B,full=True))
        triangular_checks(A,B);nilpotent=True
    return {'ring':name,'exact_square':'accepted, root recovered',
        'random_non_square':'rejected','generic_transfer_coefficients_checked':280,
        'triangular_coefficients_checked':140,'linear_matrix_rows_checked':112,
        'late_traps':traps,'nonzero_nilpotent_final_equation_retained':nilpotent}

def run():
    start=time.time()
    records=[context([0,1],'K'),context([0,0,1],'K[epsilon]/(epsilon^2)'),
             context([0,4,1],'K[e]/(e*(e-1))')]
    result={'status':'passed','scope':'bounded implementation tests, not a geometric census or global square exclusion',
        'contexts':records,'linear_indices':list(LINEAR_INDICES),
        'quadratic_indices':list(QUADRATIC_INDICES),
        'last16_linear_indices':[m for m in LINEAR_INDICES if m>=125],
        'last16_quadratic_indices':[m for m in QUADRATIC_INDICES if m>=125],
        'seconds':round(time.time()-start,3)}
    (ROOT/'logs/differential_square_tests.json').write_text(json.dumps(result,indent=2)+'\n')
    print('DIFFERENTIAL SQUARE TESTS PASSED',json.dumps(result),flush=True)
    return result
if __name__=='__main__':run()
