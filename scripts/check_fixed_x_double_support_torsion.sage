"""Exact univariate osculating reduction for 9[2P+Q-3O]=0.

The saved Bezout identities certify rank eight everywhere and incompatible
top coefficients of a ninth power. No finite-field point sampling is used.
"""
from time import monotonic
from math import comb
from pathlib import Path
import json
import sys

started=monotonic()
def log(label,**kw):
    print(json.dumps(dict(stage=label,seconds=float(round(monotonic()-started,3)),**kw),default=int),flush=True)
k=GF(25,'a',modulus=PolynomialRing(GF(5),'z')([2,4,1])); a=k.gen()
R=PolynomialRing(k,'b'); b=R.gen()
out=Path(__file__).resolve().parents[1]/'Research/computations/fixed_x_double_support_torsion.json'
replay='--replay' in sys.argv
saved=json.loads(out.read_text()) if replay else None
def decode(values):return R([k(z[0])+k(z[1])*a for z in values])
F=b**10+(4*a+2)*b**9+(a+4)*b**8+(3*a+1)*b**7+3*a*b**6+4*a*b**5+(3*a+4)*b**4+a*b**3+(3*a+3)*b**2+(4*a+2)*b+2*a+1
assert F.gcd(F.derivative())==1
P=PolynomialRing(R,'S'); S=P.gen()
rhs=P([F**(j-1)*sum(R(comb(i,j))*F[i]*b**(i-j) for i in range(j,11)) if j else R(1) for j in range(11)])
if replay:
    series=PowerSeriesRing(R,'S',default_prec=18)
    H=P((series(rhs.list())**17).list())
else:
    H=P(1)
    for n in range(1,18):
        H+=(rhs[n]-(H**3)[n])/k(3)*S**n
assert (H**3-rhs).truncate(18)==0
H2=(H**2).truncate(18)
columns=[('B',i) for i in range(6)]+[('C',i) for i in range(3)]
J=matrix(R,[[ (H if kind=='B' else H2)[n-i] for kind,i in columns] for n in range(10,18)])
log('matrix_ready',shape=[8,9],max_degree=max(int(z.degree()) for z in J.list()))
deltas=[]
for j in range(9):
    cols=[i for i in range(9) if i!=j]
    d=(-1)**j*J.matrix_from_columns(cols).determinant()
    if replay:assert d==decode(saved['maximal_minors'][j])
    deltas.append(d)
    log('maximal_minor',column=j,degree=int(d.degree()))
content=R(0)
rank_bezout=[R(0)]*9
if replay:
    rank_bezout=[decode(z) for z in saved['rank_bezout']]
    content=R(1)
else:
    for j,d in enumerate(deltas):
        g,left,right=content.xgcd(d)
        rank_bezout=[left*z for z in rank_bezout]
        rank_bezout[j]+=right
        content=g
assert content!=0, 'Generic rank below eight: a different parameterization is required.'
assert sum(z*d for z,d in zip(rank_bezout,deltas))==content
primitive=vector(R,[d//content for d in deltas])
assert J*primitive==0
def away_from_branch(z):
    if z==0:return z
    z=z.monic()
    while True:
        g=z.gcd(F)
        if g.degree()<=0:return z
        z=z//g
rank_drop=away_from_branch(content)
BB=P(list(primitive[:6])); CC=P(list(primitive[6:]))
AA=-(BB*H+CC*H2).truncate(10)
assert (AA+BB*H+CC*H2).truncate(18)==0
NN=AA**3+BB**3*rhs+CC**3*rhs**2-3*AA*BB*CC*rhs
assert NN.truncate(18)==0 and NN.degree()<=27
residual=P([NN[i+18] for i in range(10)])
hh=residual[9]; h8=residual[8]
leading=away_from_branch(hh)
log('kernel_and_norm',primitive_degrees=[int(z.degree()) for z in primitive],rank_drop_degree=int(rank_drop.degree()),leading_degree=int(leading.degree()))
assert hh!=0, 'Generic osculating section has degree below27: handle that stratum directly.'
equations=[]
for j in (7,6):
    e=residual[j]*hh**(8-j)-k(comb(9,j))*(-h8)**(9-j)
    equations.append(e)
    log('ninth_power_equation',coefficient=j,degree=int(e.degree()))
if replay:
    assert equations==[decode(z) for z in saved['ninth_power_equations']]
    u7,u6=[decode(z) for z in saved['ninth_power_bezout']]
    gg=R(1)
else:
    gg,u7,u6=equations[0].xgcd(equations[1])
assert u7*equations[0]+u6*equations[1]==gg
assert gg!=0, 'Every generic osculating section satisfies the ninth-power test.'
generic=away_from_branch(gg)
# An actual certificate has exact pole27, hence hh!=0. At rank8 points
# where hh=0 there is no different section to choose, so they are excluded.
# Rank-drop points would need a separate argument: this curve has none.
assert content==1 and gg==1
def coefficients(z):return [[int(c[0]),int(c[1])] for c in z.list()]
result=dict(status='EXACT_DOUBLE_SUPPORT_EXCLUSION_CERTIFICATE',elapsed_seconds=monotonic()-started,
    field='F25:a^2+4a+2=0',generic_rank=8,
    maximal_minors=[coefficients(z) for z in deltas],
    rank_bezout=[coefficients(z) for z in rank_bezout],
    ninth_power_equations=[coefficients(z) for z in equations],
    ninth_power_bezout=[coefficients(u7),coefficients(u6)],
    rank_gcd=1,ninth_power_gcd=1,
    scope='No div(f)=18P+9Q-27O for finite nonbranch P,Q of distinct abscissas, over the algebraic closure. No field bound, Jacobian simplicity, or generic-only rank assumption. Three-distinct-point W3 and common covers remain open.')
if not replay:out.write_text(json.dumps(result,separators=(',',':'),default=int)+'\n')
log('replay_complete' if replay else 'complete',rank_gcd=int(content),ninth_power_gcd=int(gg),output=str(out))
