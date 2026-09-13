"""Exact coefficient certificate for the fourth obstruction's critical-locus model.

Run with ``sage -python scripts/deformations/rank25/check_rank25_critical_potential.py``.
This checks polynomial identities, not the geometric lifting construction.
"""
import argparse
import hashlib
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix, vector

root=Path(__file__).resolve().parents[3];data=root.parent/'litt3-computation-data'
ap=argparse.ArgumentParser(description='Check the rank25 fourth potential and its complete critical locus inputs.')
ap.add_argument('--output',type=Path,default=root/'Research/computations/rank25_critical_potential.json')
args=ap.parse_args()
primary=data/'rank25-w4-returned-20260911-bpG6EM/rank25_fourth_lift_certificate/work/receipts/universal2100.json'
sym=root/'Research/computations/rank25_generalization_leverage.json'
field_poly=PolynomialRing(GF(5),'t');tt=field_poly.gen()
k=GF(625,'t',modulus=tt**4+4*tt**3+tt**2+4*tt+3);t=k.gen()
def val(x):
    if isinstance(x,str):return sum(k(int(c))*t**i for i,c in enumerate(x))
    if isinstance(x,(list,tuple)):return sum(k(int(c))*t**i for i,c in enumerate(x))
    return k(x)
def fmt(x):return ''.join(str(int(k(x).polynomial()[i])) for i in range(4))
Y=PolynomialRing(k,[f'y{i}' for i in range(9)]);y=Y.gens()
raw=json.loads(primary.read_text());meta=json.loads(sym.read_text())['constant_gradient_test']
E=vector(Y,[val(c) for c in raw['constant']])
for i,row in enumerate(raw['linear_fifth']):E+=vector(Y,[val(c)*y[i] for c in row])
for row in raw['quadratic_fifth']:
    E+=vector(Y,[val(c)*y[row['i']]*y[row['j']] for c in row['coefficient']])
assert all(not val(c) for row in raw['linear_x'] for c in row)
P=matrix(k,[[val(c) for c in row] for row in meta['exact_pairing']])
V=sum((val(row['coefficient'])*Y.monomial(*row['exponents']) for row in meta['exact_cubic_potential']),Y(0))
assert vector(Y,[V.derivative(v) for v in y])==P*E
assert P.det()!=0
R=PolynomialRing(k,['U','m1','m2','a','b','h','s','z1','z2'])
U,m1,m2,a,b,h,s,z1,z2=R.gens();z=[z1,z2];m=vector(R,[m1,m2])
r=val('0224');change=Y.hom([U,m1,m2,a,b,h+r*s,s,z1,z2],R)
W=change(V)
restrict=Y.hom([R(0),R(0),R(0),a,b,R(0),R(0),R(0),R(0)],R)
fg=vector(R,[restrict(E[1]),restrict(E[2])])
prior_path=root/'Research/computations/rank25_w5_return_and_global_w4_locus_checks.json'
prior=json.loads(prior_path.read_text())
D=matrix(k,[[val(c) for c in row] for row in prior['mixed_matrix_y1y2']])
c=vector(k,[val(x) for x in prior['quadratic_s_coefficients']])
K=P.matrix_from_rows_and_columns([7,8],[1,2])
assert D.det() and K.det()
f=fg+s*(D*m)+s**2*c
kappa=W.monomial_coefficient(h**2)
assert kappa
base=kappa*h**2+vector(R,z).dot_product(K*f)
linear=[]
for j in range(2):
    d={}
    for exp,coef in (W-base).dict().items():
        if sum(exp[7:])!=1 or exp[7+j]!=1:continue
        assert exp[5]>=1
        e=list(exp);e[5]-=1;e[7+j]-=1;d[tuple(e)]=coef
    linear.append(R(d))
    assert all(sum(e)==1 and next(i for i,x in enumerate(e) if x) in [1,2,5,6] for e in d)
Lm=matrix(k,[[p.monomial_coefficient(v) for v in [m1,m2]] for p in linear])
alpha=vector(k,[p.monomial_coefficient(h) for p in linear])
beta=vector(k,[p.monomial_coefficient(s) for p in linear])
base+=h*vector(R,z).dot_product(Lm*m+alpha*h+beta*s)
rest=W-base;Q=[];cubic=[]
for top in [z1**2,z1*z2,z2**2]:
    row=[rest.monomial_coefficient(v*top) for v in [R(1),U,a,b]]
    Q.append(row)
    base+=sum(co*v*top for co,v in zip(row,[R(1),U,a,b]))
for top in [z1**3,z1**2*z2,z1*z2**2,z2**3]:
    co=rest.monomial_coefficient(top);cubic.append(co);base+=co*top
assert W==base

# Complete reduced four-point centre, checked through a univariate resultant.
AB=PolynomialRing(k,['a','b']);aa,bb=AB.gens()
toAB=R.hom([AB(0),AB(0),AB(0),aa,bb,AB(0),AB(0),AB(0),AB(0)],AB)
F,G=[toAB(p) for p in fg]
ka=PolynomialRing(k,'a');av=ka.gen()
res=F.resultant(G,bb)
res1=ka([res.monomial_coefficient(aa**i) for i in range(res.degree(aa)+1)])
assert res==sum(res1[i]*aa**i for i in range(res1.degree()+1))
assert res1.degree()==4 and res1.gcd(res1.derivative()).degree()==0
aroots=res1.roots(multiplicities=False);assert len(aroots)==4
kb=PolynomialRing(k,'b');bv=kb.gen();points=[]
for avalue in aroots:
    hom=AB.hom([kb(avalue),bv],kb)
    common=hom(F).gcd(hom(G));assert common.degree()==1
    bvalue=-common[0]/common[1]
    df=matrix(k,[[p.derivative(v)(avalue,bvalue) for v in [aa,bb]] for p in [F,G]])
    assert df.det()
    points.append({'a':fmt(avalue),'b':fmt(bvalue),'jacobian_determinant':fmt(df.det())})

# The two exact nonzero-top contradictions are coefficient identities.
top_checks=[]
for row in prior['top_parameter_exclusions']:
    slope=val(row['slope_y8_over_y7']);factor=val(row['row_multiplier'])
    nonzero=val(row['nonzero_constant_in_E6_minus_multiplier_E5_div_y7'])
    sub=Y.hom([*y[:8],slope*y[7]],Y)
    assert sub(E[0])==0 and sub(E[6]-factor*E[5])==nonzero*y[7] and nonzero
    top_checks.append({'slope':fmt(slope),'row_multiplier':fmt(factor),'nonzero_constant':fmt(nonzero)})
top=E[0];qa=top.monomial_coefficient(y[7]**2);qb=top.monomial_coefficient(y[7]*y[8]);qc=top.monomial_coefficient(y[8]**2)
assert top==qa*y[7]**2+qb*y[7]*y[8]+qc*y[8]**2 and qa and qc
hh=[val(p['slope']) for p in top_checks];assert hh[0]!=hh[1]
assert qa==qc*hh[0]*hh[1] and qb==-qc*sum(hh)

def matfmt(M):return [[fmt(c) for c in row] for row in M.rows()]
def polyfmt(p):return [{'exponents':list(map(int,e)),'coefficient':fmt(c)} for e,c in sorted(p.dict().items())]
out={'status':'PASS exact coefficient identities; geometric critical-locus argument is separate',
     'field_modulus':[3,4,1,4,1],'encoding':'abcd=a+b*t+c*t^2+d*t^3',
     'coordinate_change':'y=(U,m1,m2,a,b,h+0224*s,s,z1,z2)',
     'potential_formula':'kappa*h^2 + z^T*K*((F,G)^T+s*D*m+s^2*c) + h*z^T*(L*m+alpha*h+beta*s) + Q(U,a,b;z)+R3(z)',
     'P':matfmt(P),'P_determinant':fmt(P.det()),'kappa':fmt(kappa),
     'K':matfmt(K),'K_determinant':fmt(K.det()),'D':matfmt(D),'D_determinant':fmt(D.det()),
     'c':[fmt(x) for x in c],'L':matfmt(Lm),'alpha':[fmt(x) for x in alpha],
     'beta':[fmt(x) for x in beta],
     'Q_rows_z1_squared_z1z2_z2_squared_columns_1_U_a_b':[[fmt(x) for x in row] for row in Q],
     'R3_z1_cubed_z1_squared_z2_z1_z2_squared_z2_cubed':[fmt(x) for x in cubic],
     'F':polyfmt(F),'G':polyfmt(G),'centre_resultant_monic':[fmt(x) for x in res1.monic().list()],
     'centre_points':points,'top_contradictions':top_checks,
     'exact_checks':['gradient(V)=P*E in all nine original target coordinates','P invertible',
       'factored cubic potential equals original potential','complete four-point centre is étale',
       'both nonzero-top cases excluded by coefficient identities'],
     'source_sha256':{str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in [primary,sym,prior_path]}}
args.output.write_text(json.dumps(out,indent=2)+'\n')
for key in ['P_determinant','kappa','K','D','c','L','alpha','beta','Q_rows_z1_squared_z1z2_z2_squared_columns_1_U_a_b','R3_z1_cubed_z1_squared_z2_z1_z2_squared_z2_cubed','centre_points']:
    print(key,out[key])
print('PASS all exact factorization, centre and top-coordinate checks')
