"""PREPARED ONLY: new all-phase BOTH-P contact-six necessary gate.

No execution/lease is inferred. New purpose and new coefficients3..5;
not a replay of fixed root-weight separation or eta=1 gates.
Algebra B=F25[a,b]/(p(a),p(b)), dimension100, finite etale.
Set s=q(b)/q(a),eta=W(b)/W(a). Build the frozen V through b to h^5.
Actual wild b3 necessity contact>=6 forces coefficients3,4,5 zero.
A recorded identity a-b = sum M_j*J_j proves every such pair diagonal.
If the linear system is inconsistent, UNRESOLVED; no sampling or GB.
"""
from sage.all import *
import json,time
started=time.monotonic()
k=GF(25,name='beta',modulus=GF(5)['c'].gen()**2-GF(5)['c'].gen()-3)
beta=k.gen()
def elt(n): return k(n%5)+k(n//5)*beta
def code(v):
    t=v.polynomial().list()
    return int(t[0] if t else 0)+5*int(t[1] if len(t)>1 else 0)
def codes(f): return [code(v) for v in f.list()]
def emit(row):
    row['elapsed_seconds']=time.monotonic()-started
    print(json.dumps(row),flush=True)
R=PolynomialRing(k,'U');U=R.gen();d=elt(23)
p=sum(elt(c)*U**i for i,c in enumerate([8,3,21,23,22,12,22,21,1,22,1]))
q=U**2+d
def inv_mod(f):
    g,l,m=R(f).xgcd(p);assert g.degree()==0
    v=(l/g[0])%p;assert (R(f)*v)%p==1
    return v
u_inv=inv_mod(U);q_inv=inv_mod(q)
w=(U*p.derivative()**2*q_inv**9)%p;w_inv=inv_mod(w)
A=R.quotient(p,'aa');aa=A.gen()
S=PolynomialRing(A,'V');VV=S.gen()
pb=sum(A(c)*VV**i for i,c in enumerate(p.list()))
B=S.quotient(pb,'bb');b=B.gen();a=B(aa)
def ev(f,t):
    value=B(0)
    for c in reversed(R(f).list()): value=value*t+B(c)
    return value
assert ev(p,a)==0 and ev(p,b)==0
assert a*ev(u_inv,a)==1 and b*ev(u_inv,b)==1
assert ev(q,a)*ev(q_inv,a)==1 and ev(q,b)*ev(q_inv,b)==1
assert ev(w,a)*ev(w_inv,a)==1 and ev(w,b)*ev(w_inv,b)==1
s=ev(q,b)*ev(q_inv,a)
eta=ev(w,b)*ev(w_inv,a)
def flat(t):
    outer=B(t).list();out=[]
    for j in range(10):
        inner=A(outer[j] if j<len(outer) else 0).list()
        out.extend([k(inner[i] if i<len(inner) else 0) for i in range(10)])
    return out
def encoded(t): return [code(c) for c in flat(t)]
emit({'event':'all_phase_p_branch_contact_six_setup','p_coefficients':codes(p),
      'field':'F25,beta^2=beta+3;a+5b encoding',
      'basis':'a^i*b^j,0<=i,j<10,index=i+10*j',
      'dimension':100,'inverse_U':codes(u_inv),'inverse_q':codes(q_inv),
      'weight_W':codes(w),'inverse_weight_W':codes(w_inv),
      's_basis_coefficients':encoded(s),'eta_basis_coefficients':encoded(eta),
      'scope':'all geometric ordered P-root pairs;arbitrary eta eliminated by quadratic coefficient;contact>=6 necessary only'})
T=PolynomialRing(B,'h');h=T.gen()
def cut(f): return T(f).truncate(6)
v=[b]
inv_2b=B(3)*ev(u_inv,b)
for n in range(1,6):
    rhs=2*s*a if n==1 else s if n==2 else B(0)
    v.append(inv_2b*(rhs-sum(v[i]*v[n-i] for i in range(1,n))))
V=sum(v[i]*h**i for i in range(6))
assert cut(V**2-s*(a+h)**2-d*(s-1))==0
def series_p(t):
    value=T(0)
    for c in reversed(p.list()): value=cut(value*t+B(c))
    return value
pv=series_p(V);pa=series_p(a+h)
F=cut(cut(V**3)*cut(pv**2)-eta*s**11*cut((a+h)**3)*cut(pa**2))
assert F[0]==0 and F[1]==0 and F[2]==0
jets=[B(F[i]) for i in [3,4,5]]
emit({'event':'all_phase_p_branch_contact_six_jets',
      'jet_coefficients_a_b_ascending':[encoded(j) for j in jets],
      'first_three_coefficients_zero':True})
basis=[a**i*b**j for j in range(10) for i in range(10)]
columns=[flat(g*e) for g in jets for e in basis]
M=matrix(k,columns).transpose();target=vector(k,flat(a-b))
try:
    witness=M.solve_right(target)
except ValueError:
    emit({'event':'all_phase_p_branch_contact_six_complete','verdict':'UNRESOLVED',
          'ideal_span_rank':int(M.rank()),
          'conclusion':'a-b not certified in the new jet ideal;off-diagonal geometric candidates remain'})
else:
    assert M*witness==target
    multipliers=[sum(B(witness[100*j+i])*basis[i] for i in range(100)) for j in range(3)]
    assert sum(multipliers[j]*jets[j] for j in range(3))==a-b
    emit({'event':'all_phase_p_branch_contact_six_complete','verdict':'PASS',
          'Bezout_jet_multipliers_a_b_ascending':[encoded(t) for t in multipliers],
          'identity':'M3*J3+M4*J4+M5*J5=a-b in F25[a,b]/(p(a),p(b))',
          'conclusion':'every geometric contact-six P-root pair has a=b,eta=1,s=1;all noncritical off-diagonal pairs absent'})
