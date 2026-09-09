"""Rebuild every first-oper Bezout coefficient from SIX low-pole sections.

Uses polynomial arithmetic only; no Laurent primitives and no atlas solve.
All coefficients stay in the existing Frobenius-coordinate convention.
"""
import argparse,hashlib,itertools,json,time
from pathlib import Path
ap=argparse.ArgumentParser();ap.add_argument('--out',required=True);args=ap.parse_args()
out=Path(args.out).resolve();out.mkdir(parents=True,exist_ok=False)
started=time.monotonic()
def log(*s):print(round(time.monotonic()-started,2),*s,flush=True)
base=Path(__file__).resolve().parents[1]/'Research/computations'
paths=['wronskian_universal_image','wronskian_quadratic_bezout']
raw=[(base/(p+'.json')).read_bytes() for p in paths]
data,old=map(json.loads,raw)
k=GF(25,'a',modulus=PolynomialRing(GF(5),'j')([2,4,1]));a=k.gen()
cache={}
def get(c):
    if c not in cache:cache[c]=k(sage_eval(c,locals={'a':a}))
    return cache[c]
R=PolynomialRing(k,'x');x=R.gen()
F=R([2*a+1,4*a+2,3*a+3,a,3*a+4,4*a,3*a,3*a+1,a+4,4*a+2,1])
basis=lambda n:sorted([(i,j) for j in range(3) for i in range(n//3+1) if 3*i+10*j<=n],key=lambda p:3*p[0]+10*p[1])
def poly(v,mons):return tuple(sum((c*x**i for c,(i,h) in zip(v,mons) if h==j),R.zero()) for j in range(3))
def add(f,g):return tuple(u+v for u,v in zip(f,g))
def sub(f,g):return tuple(u-v for u,v in zip(f,g))
def mul(f,g):
    h=[R.zero() for j in range(3)]
    for i in range(3):
        for j in range(3):h[(i+j)%3]+=f[i]*g[j]*(F if i+j>=3 else 1)
    return tuple(h)
def delta(f):
    h=[R.zero() for j in range(3)]
    for j in range(3):
        h[(j+2)%3]+=f[j].derivative()*(F if j+2>=3 else 1)
        if j:h[j-1]+=2*j*F.derivative()*f[j]
    return tuple(h)
def fifth(f):return tuple([f[0]**5,F**3*f[2]**5,F*f[1]**5])
def coeff(f,mons):
    v=vector(k,[f[j][i] for i,j in mons]);assert poly(v,mons)==f;return v
mu=[tuple(q) for q in data['S_U_monomials']]
SU=matrix(k,[[get(c) for c in row] for row in data['S_U_basis']])
assert SU.nrows()==32
low=SU.matrix_from_columns([i for i,q in enumerate(mu) if 3*q[0]+10*q[1]>47]).left_kernel().basis_matrix()
assert low.nrows()==6
fr=low*SU;frames=[poly(row,mu) for row in fr.rows()]
assert all(all(3*i+10*j<=47 for i,c in enumerate(f[j].list()) if c) for f in frames for j in range(3))
ups=[poly(row,mu) for row in SU.rows()]
dframes=list(map(delta,frames));dups=list(map(delta,ups))
def wh(f,df,g,dg):return sub(mul(f,dg),mul(g,df))

decoders={}
def decode5(f,n):
    if n not in decoders:
        mons=basis(n);target=basis(5*n)
        H=matrix(k,[coeff(fifth(poly(vector(k,[int(i==h) for i in range(len(mons))]),mons)),target) for h in range(len(mons))]).transpose()
        piv=list(H.transpose().pivots());inv=H.matrix_from_rows(piv).inverse()
        decoders[n]=(mons,target,H,piv,inv)
    mons,target,H,piv,inv=decoders[n];v=coeff(f,target)
    w=inv*vector(k,[v[i] for i in piv]);assert H*w==v
    return poly(w,mons)
J=zero_matrix(k,6)
for i in range(6):
    for j in range(i+1,6):
        f=decode5(wh(frames[i],dframes[i],frames[j],dframes[j]),22)
        assert f[2].degree()<=0
        J[i,j]=3*f[2][0];J[j,i]=-J[i,j]
assert J.rank()==6
Ji=J.inverse();Ps=[]
for i in range(32):
    columns=[decode5(wh(ups[i],dups[i],frames[j],dframes[j]),35) for j in range(6)]
    Ps.append(matrix(R,3,6,lambda r,c:columns[c][r]))
    assert all(Ps[-1][r,c].degree()<=[11,8,5][r] for r in range(3) for c in range(6))
log('six-section frame, constant symplectic pairing, and192 quotient pairings PASS')
Q=PolynomialRing(k,['z','w']);z,w=Q.gens();pz=R.hom([z],Q);pw=R.hom([w],Q)
Az=[matrix(Q,3,6,[pz(c) for c in (P*Ji).list()]) for P in Ps]
Pw=[matrix(Q,3,6,[pw(c) for c in P.list()]) for P in Ps]
mons=[tuple(q) for q in old['L32_monomials']]
ratio=None;checked=0
for item in old['tensor']:
    i,j=map(int,item['pair'])
    numerator=-Az[i]*Pw[j].transpose()
    if i!=j:numerator-=Az[j]*Pw[i].transpose()
    kernels=[]
    for f in numerator.list():
        quotient,remainder=f.quo_rem(z-w);assert remainder==0
        kernels.append(quotient)
    B=matrix(k,24,24,lambda r,c:k(kernels[3*mons[r][1]+mons[c][1]].monomial_coefficient(z**mons[r][0]*w**mons[c][0])))
    oldB=matrix(k,[[get(c) for c in row] for row in item['matrix']])
    if ratio is None and B:
        position=next(h for h,c in enumerate(B.list()) if c)
        ratio=oldB.list()[position]/B.list()[position]
        assert ratio
    if ratio is not None:assert ratio*B==oldB,('coefficient mismatch',i,j,str(ratio))
    else:assert oldB==0
    checked+=1
    if checked%100==0:log('all entries replayed through quadratic coefficient',checked)
assert checked==528 and ratio
log('ALL528 inverse-cup matrices reconstructed', 'fixed Cech scale',ratio)
# Any selected columns whose section-products span L64 generate the
# entire cup map. The same spanning condition implies no base point.
mm=[poly(vector(k,[int(i==h) for i in range(24)]),mons) for h in range(24)]
prodmat=[matrix(k,[coeff(mul(s,t),basis(64)) for t in mm]).transpose() for s in mm]
costs=json.loads((base/'inverse_cup_seed_certificate.json').read_text())['seed_terms_per_equation']
columncost=[sum(costs[24*r+c] for r in range(24)) for c in range(24)]
top=mons.index((4,2));assert 3*mons[top][0]+10*mons[top][1]==32
triples=sorted([(i,j,top) for i,j in itertools.combinations([h for h in range(24) if h!=top],2)],
               key=lambda ij:(sum(columncost[h] for h in ij),ij))
column_choice=None;ranks=[]
for choice in triples:
    A=block_matrix(k,[[prodmat[h] for h in choice]])
    rank=A.rank();ranks.append(rank)
    if rank==56:
        column_choice=choice
        piv=list(A.pivots());minor=A.matrix_from_columns(piv)
        assert len(piv)==56 and minor.det()!=0
        break
assert column_choice is not None,('no monomial triple spans',max(ranks))
log('multiplication-spanning THREE columns',column_choice,'tested',len(ranks),
    'inverse equation terms',sum(columncost[h] for h in column_choice))
enc=lambda M:[[str(c) for c in row] for row in M.rows()]
report=dict(source_sha256={p:hashlib.sha256(b).hexdigest() for p,b in zip(paths,raw)},
    all528_quadratic_matrices_replayed=True,all304128_coefficients_replayed=True,
    every_division_exact=True,constant_cech_scale=str(ratio),frame_dimension=6,
    frame_combinations=enc(low),frame_pairing_frobenius=enc(J),
    P_coefficient_frobenius=[[[[str(c) for c in f.list()] for f in row] for row in P.rows()] for P in Ps],
    multiplication_spanning_columns=list(column_choice),
    multiplication_spanning_monomials=[mons[h] for h in column_choice],
    multiplication_minor_columns=piv,multiplication_minor_determinant=str(minor.det()),
    selected_inverse_equations=72,selected_inverse_terms=sum(columncost[h] for h in column_choice),
    cheaper_monomial_triples_tested=len(ranks)-1,
    seconds=time.monotonic()-started,
    scope='First acyclic oper exact representation, not an atlas solve or an all18 construction.')
(out/'certificate.json').write_text(json.dumps(report,indent=2,default=int)+'\n')
log('ALL coefficient identities PASS', 'fixed Cech scale',ratio)
