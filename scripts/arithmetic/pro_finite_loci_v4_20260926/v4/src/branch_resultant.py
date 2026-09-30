"""Exact stationary-value resultant over F_25; no search over source curves.

The two indeterminates below are B and C, not the problem's endpoint labels.
The output is Norm(H(x)-C) in F_25[B,C][x]/(A(x)/ell-B/ell).
Only Python's standard library is used.
"""
from __future__ import annotations
from itertools import permutations
import ff25 as F

Poly = dict[tuple[int,int], int]

def const(c: int) -> Poly:
    return {(0,0):c} if c else {}

def add(a: Poly,b: Poly) -> Poly:
    r=dict(a)
    for e,c in b.items():
        z=F.add(r.get(e,0),c)
        if z:r[e]=z
        else:r.pop(e,None)
    return r

def scale(a: Poly,c: int) -> Poly:
    return {e:F.mul(v,c) for e,v in a.items() if F.mul(v,c)}

def mul(a: Poly,b: Poly) -> Poly:
    r:Poly={}
    for (i,j),c in a.items():
        for (k,l),d in b.items():
            e=(i+k,j+l); z=F.add(r.get(e,0),F.mul(c,d))
            if z:r[e]=z
            else:r.pop(e,None)
    return r

def det(a: list[list[Poly]]) -> Poly:
    n=len(a);r:Poly={}
    for p in permutations(range(n)):
        z=const(1)
        for i in range(n):z=mul(z,a[i][p[i]])
        parity=sum(p[i]>p[j] for i in range(n) for j in range(i+1,n))%2
        r=add(r,scale(z,4 if parity else 1))
    return r

def field_normal_basis(B:list[int], A:list[int]) -> dict:
    def red(p):return F.pdivmod(p,A)[1]
    def power(p,n):
        r=[1]
        while n:
            if n&1:r=red(F.pmul(r,p))
            p=red(F.pmul(p,p));n//=2
        return r
    cols=[power(B,25**i) for i in range(4)]
    matrix=[[[cols[j][i] if i<len(cols[j]) else 0] for j in range(4)] for i in range(4)]
    determinant=F.det_poly(matrix)
    assert determinant==[23]
    return {'canonical_B':B,'B_conjugates':cols,'B_normal_basis_determinant':determinant}

def certificate(P:list[int],A:list[int]) -> dict:
    ap=F.derivative(A)
    H=F.pmul(F.pmul(P,P),F.pmul(F.pmul(ap,ap),ap))
    assert len(H)==30
    ell=A[-1]; il=F.inv(ell)
    assert H[-1]==F.mul(4,F.power(ell,3))
    # Multiplication by x in the quotient A(x)=B.
    red4=[const(F.neg(F.mul(il,a))) for a in A[:-1]]
    red4[0]=add(red4[0],{(1,0):il})
    def xmul(v):
        r=[{},v[0],v[1],v[2]]
        for i in range(4):r[i]=add(r[i],mul(v[3],red4[i]))
        return r
    xp=[const(1),{},{},{}]
    hv=[{},{},{},{}]
    for c in H:
        for i in range(4):hv[i]=add(hv[i],scale(xp[i],c))
        xp=xmul(xp)
    cols=[]
    v=hv
    for _ in range(4):
        cols.append(v);v=xmul(v)
    matrix=[[dict(cols[j][i]) for j in range(4)] for i in range(4)]
    for i in range(4):matrix[i][i]=add(matrix[i][i],{(0,1):4})
    R=det(matrix)
    assert max(i for i,j in R)==29
    assert max(j for i,j in R)==4
    assert all(4*i+29*j<=116 for i,j in R)
    assert R[(0,4)]==1
    h4=F.power(H[-1],4)
    assert R[(29,0)]==F.neg(F.mul(h4,F.power(il,29)))
    assert sorted((i,j) for i,j in R if 4*i+29*j==116)==[(0,4),(29,0)]
    # Independently substitute B=A(x), C=H(x) into the resulting resultant.
    def powers(p,n):
        r=[[1]]
        for _ in range(n):r.append(F.pmul(r[-1],p))
        return r
    aa=powers(A,29);hh=powers(H,4)
    check=[]
    for (i,j),c in R.items():check=F.padd(check,F.scale(F.pmul(aa[i],hh[j]),c))
    assert not check
    delta_bound=2*116*377+116**2*(29+3)
    assert delta_bound==518056
    R_at_zero=[[29*j,F.mul(R.get((0,j),0),F.power(H[-1],j))]
               for j in range(5) if R.get((0,j),0)]
    assert len(R_at_zero)==5
    return {
      'purpose':'universal stationary-value norm; NOT a candidate or branch-polynomial search',
      'H_ascending_F25':H,
      'H_degree':29,'H_leading':H[-1],
      'resultant_convention':'Norm(H(x)-C) in F25(B,C)[x]/(A(x)/ell-B/ell)',
      'R0_terms':[[i,j,c] for (i,j),c in sorted(R.items())],
      'R0_term_count':len(R),
      'R0_weight_bound':'4*degree_B+29*degree_C <= 116, monomialwise',
      'R0_B29_coefficient':R[(29,0)],
      'R0_C4_coefficient':R[(0,4)],
      'R0_A_H_substitution_zero':True,
      'stationary_R_at_t_zero_sparse_Z_terms':R_at_zero,
      'stationary_R_Z116':'H_leading^4 * (1-t^29)',
      'stationary_R_t_degree_bound':377,
      'pair_sum_resultant_t_degree_bound_formula':'87464+13456*(e+3)',
      'pair_sum_resultant_t_degree_bound_e29':delta_bound,
      'branch_support_polynomial_degree_bound_e29':delta_bound+29,
      'expanded_pair_sum_resultant_computed':False,
      **field_normal_basis([21,19,20,22],A)
    }
