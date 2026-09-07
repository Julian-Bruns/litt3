#!/usr/bin/env sage
"""Generate all four exact original-ideal linear certificates.

Only a12x16 constant kernel, an8-column row-space solve, and polynomial
identities are used. No candidate Groebner basis or Macaulay search.
"""
import json
from pathlib import Path
root=Path(__file__).resolve().parents[1]
data=root/'Research/computations'
d=json.loads((data/'genus_two_intrinsic_tensor.json').read_text())
k=GF(25,name='a',modulus=PolynomialRing(GF(5),'r')([2,4,1])); a=k.gen()
get=lambda s:k(sage_eval(s,locals={'a':a}))
P=PolynomialRing(k,names=['p0','p1','p2','p3','b0','b1','b2','b3'],order='degrevlex')
pp=P.gens()[:4]; bb=P.gens()[4:]
eqs=[sum(get(d['I'][h][j])*bb[j] for j in range(4))+
     sum(get(d['tensor_plus_Jinverse_alpha5_p'][i][j][h])*pp[i]*bb[j]**5
         for i in range(4) for j in range(4)) for h in range(12)]
eqs.append(sum(get(d['ell'][i][j])*pp[i]*bb[j] for i in range(4) for j in range(4))-1)
Lb=[bb[0]+(2*a+1)*bb[2]-(2*a+2)*bb[3],
    bb[1]+(2*a+1)*bb[2]-(2*a+1)*bb[3]]
Lp=[pp[0]+(2*a+1)*pp[3],pp[1]-a*pp[2]+pp[3]]
tensor=matrix(k,[[f.monomial_coefficient(p*b**5) for p in pp for b in bb] for f in eqs[:12]])
left=tensor.left_kernel().basis_matrix()
linear=matrix(k,[[f.monomial_coefficient(b) for b in bb] for f in eqs[:12]])
assert tensor.rank()==10 and (left*linear).rank()==2
bresult={}; blifts=[]
for g in Lb:
    rhs=vector(k,[g.monomial_coefficient(b) for b in bb])
    coeff=(left*linear).solve_left(rhs)*left
    lift=[P(c) for c in coeff]+[P.zero()]
    assert sum(c*f for c,f in zip(lift,eqs))==g
    blifts.append(lift)
    bresult[str(g)]={'found':True,'lift':[str(c) for c in lift]}
(data/'genus_two_linear_certificates.json').write_text(json.dumps({
    'current_algorithm':'constant left kernel of12x16 tensor matrix',
    'linear_consequences':bresult,'universal_tensor_image_rank':int(10),
    'constant_left_annihilators':[[str(c) for c in row] for row in left.rows()],
    'induced_b_linear_rows':[[str(c) for c in row] for row in (left*linear).rows()]},indent=2)+'\n')
subs={bb[0]:bb[0]-Lb[0],bb[1]:bb[1]-Lb[1]}
reduced=[f.subs(subs) for f in eqs]
mons=[p*b**5 for p in pp for b in bb[2:]]
N=reduced[4:12]
M=matrix(k,[[f.monomial_coefficient(mon) for mon in mons] for f in N])
assert M.rank()==5
assert all(sum(c*mon for c,mon in zip(row,mons))==f for row,f in zip(M.rows(),N))
reduction_lifts=[(f-r).lift(P.ideal(Lb)) for f,r in zip(eqs,reduced)]
norm=reduced[12]+1; presult={}
for g in Lp:
    product_lifts=[]
    for b in bb[2:]:
        rhs=vector(k,[(g*b**5).monomial_coefficient(mon) for mon in mons])
        lift=M.solve_left(rhs)
        assert sum(c*f for c,f in zip(lift,N))==g*b**5
        product_lifts.append(lift)
    lift=[P.zero() for f in eqs]
    for i,p in enumerate(pp):
        for j,b in enumerate(bb[2:]):
            c=norm.monomial_coefficient(p*b)**5*p**5
            for h,v in enumerate(product_lifts[j]): lift[h+4]+=c*v
    lift[12]-=g*sum(norm**j for j in range(5))
    assert sum(c*f for c,f in zip(lift,reduced))==g
    correction=[sum(lift[j]*reduction_lifts[j][h] for j in range(13)) for h in range(2)]
    full=[lift[j]-sum(correction[h]*blifts[h][j] for h in range(2)) for j in range(13)]
    assert sum(c*f for c,f in zip(full,eqs))==g
    presult[str(g)]={'lift':[str(c) for c in full],
        'maximum_multiplier_degree':int(max(c.total_degree() for c in full))}
(data/'genus_two_p_linear_certificates.json').write_text(json.dumps(presult,indent=2)+'\n')
print('All four exact original-ideal certificates PASS; no GB/Macaulay.',flush=True)
