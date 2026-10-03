#!/usr/bin/env sage
"""K-only whole-slope source, top-eight numerator and cleared auxiliary model."""
from sage.all import *
import argparse,json,time
from pathlib import Path
from math import comb
ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True);ap.add_argument('--root',type=int,default=145049);args=ap.parse_args();data=args.work/'data';start=time.time()
K=GF(5**8,'z');ZZ=PolynomialRing(K,'Z');Z=ZZ.gen();beta=(Z**2-Z-3).roots(multiplicities=False)[0]
def bcode(c):return K(c%5)+K(c//5)*beta
alpha=sum((bcode(c)*Z**i for i,c in enumerate((5,2,6,7,1))),ZZ.zero()).roots(multiplicities=False)[0]
cache={}
def decode(c):
    c=int(c)
    if c not in cache:
        n=c;s=K.zero()
        for i in range(4):s+=bcode(n%25)*alpha**i;n//=25
        cache[c]=s
    return cache[c]
inputs=json.loads((data/f'twisted_concentrated_setup_{args.root}.json').read_text());source=next(r for r in json.loads((data/'concentrated_d10m6_source_family.json').read_text())['records'] if r['root']==args.root)
RR=PolynomialRing(K,('eta','lam'));eta,lam=RR.gens();R=PolynomialRing(RR,'x');x=R.gen();P=sum((decode(c)*x**i for i,c in enumerate(inputs['P_twisted'])),R.zero());Y=PolynomialRing(R,'y');y=Y.gen();A=Y.quotient(y**3-P,'yy');yy=A.gen()
def ep(raw):return sum((decode(c)*eta**i for i,c in enumerate(raw)),RR.zero())
def curve(raw):return sum((sum((decode(c)*x**i for i,c in enumerate(component)),R.zero())*yy**j for j,component in enumerate(raw)),A.zero())
H=ep(source['H']);nk=list(map(ep,source['kappa_numerators']));nc=list(map(ep,source['cy_numerators']));assert not any(nc[:13]);basis=[[curve(c) for c in row] for row in inputs['source_S_basis']];S=[sum((number*row[j] for number,row in zip(nk,basis)),A.zero()) for j in range(5)]
v=decode(inputs['v_scale_K'])*sum(((nk[13+j]+lam*nc[13+j])*x**j for j in range(4)),A.zero());v+=decode(inputs['v_scale_K'])*(nk[17]+lam*nc[17])*yy
q=curve(inputs['q0']);t=sum((decode(c)*x**i for i,c in enumerate(inputs['t'])),R.zero());F=[v*q*q+q*S[0]+H*t**3]+[q*S[j] for j in range(1,5)]+[S[0]+2*v*q]+S[1:]+[v];D=[j*S[j] for j in range(1,5)]
phi=[q]+[A.zero()]*4+[A.one()];derivative=[(j+1)*F[j+1] for j in range(10)];expected=[A.zero() for _ in range(10)]
for i in range(6):
    for j in range(4):expected[i+j]+=phi[i]*D[j]
assert derivative==expected
labels={tuple(label):i for i,label in enumerate(inputs['top_labels'])};embed=matrix(RR,21,8)
for j in range(8):
    if j<3:a5=v*x**j;a4=S[4]*x**j
    else:
        b,char=((0,0),(1,0),(2,0),(3,0),(0,1))[j-3];a5=A.zero();a4=v*x**b*yy**char
    for degree,function in ((5,a5),(4,a4)):
        for char,component in enumerate(function.lift().list()):
            for xx,coefficient in enumerate(component.list()):
                if coefficient:embed[labels[(degree,xx,char)],j]=coefficient
L=matrix(RR,[[ep(f) for f in row] for row in inputs['polynomial_left_inverse']]);extra=matrix(RR,[[ep(f) for f in row] for row in inputs['extra_top_matrix']]);low=-L*extra*embed
compat=matrix(RR,[[decode(c) for c in inputs['ordinary_top_form']],[ep(f) for f in inputs['concentrated_top_form']]])*embed
particular=[[curve(c) for c in row] for row in inputs['particular_functions']];lower=[[curve(c) for c in row] for row in inputs['lower_functions']];U=[]
for j in range(8):U.append([sum((particular[i][d]*embed[i,j] for i in range(21)),A.zero())+sum((lower[i][d]*low[i,j] for i in range(9)),A.zero()) for d in range(6)])
print('SOURCE_NUMERATOR_READY','SECONDS',time.time()-start,flush=True)
aux=[[curve(c) for c in row] for row in inputs['auxiliary_functions']]
def evaluate(function,xx,yyy):return sum((component(xx)*yyy**j for j,component in enumerate(function.lift().list())),RR.zero())
root=decode(args.root);rows=[];forcing=[]
for rawx,rawy in inputs['endpoints']:
    xx,yyy=decode(rawx),decode(rawy)
    if (xx,yyy)==(root,K.one()):continue
    dd=list(map(lambda f:evaluate(f,xx,yyy),D));d,c,b,a=dd;center=sum((decode(coefficient)*xx**j for j,coefficient in enumerate(inputs['Z'])),K.zero())/yyy;row=[]
    for ns in aux:
        n0,n1,n2=[evaluate(f,xx,yyy) for f in ns];row.append(-a*n2-(b+a*center)*n1-(c+b*center+a*center**2)*n0)
    rows.append(row);forcing.append([evaluate(v,xx,yyy)*xx**j for j in range(5)])
SR=PolynomialRing(RR,'r');r=SR.gen();cut=4;ys=SR(sum((decode(c)*r**i for i,c in enumerate(inputs['Y_endpoint_series'])),SR.zero()))
def series(function):
    result=SR.zero()
    for char,component in enumerate(function.lift().list()):
        shifted=SR.zero()
        for i,cc in enumerate(component.list()):
            for j in range(min(i,cut-1)+1):shifted+=cc*comb(i,j)*root**(i-j)*r**j
        result+=shifted*ys**char
    return result%r**cut
center=SR(sum((decode(cc)*r**i for i,cc in enumerate(inputs['base_translation_endpoint_series'][:cut])),SR.zero()))+eta*decode(inputs['center_slope_K'])*r
dd=list(map(series,D));a,b,c=dd[3],dd[2],dd[1];cols=[]
for ns in aux:
    n0,n1,n2=list(map(series,ns));q0=-a*n2-(b+a*center)*n1-(c+b*center+a*center**2)*n0;q1=-a*n1-(b+2*a*center)*n0;q2=-a*n0;cols.append([q0[j] for j in range(4)]+[q1[j] for j in range(2)]+[q2[0]])
for i in range(7):
    rows.append([col[i] for col in cols]);forcing.append([(series(v)*((root+r)**j))[i] if i<4 else RR.zero() for j in range(5)])
EE=PolynomialRing(K,'ee');ee=EE.gen()
def eta_poly(f):
    out=EE.zero()
    for (i,j),cc in f.dict().items():assert j==0;out+=cc*ee**i
    return out
M=matrix(EE,[[eta_poly(f) for f in row] for row in rows]);delta=M.det();assert delta and delta.degree()==87
B0=matrix(EE,15,5);B1=matrix(EE,15,5)
for i,row in enumerate(forcing):
    for j,f in enumerate(row):
        for (epower,lpower),cc in f.dict().items():
            assert lpower<=1
            (B0 if lpower==0 else B1)[i,j]+=cc*ee**epower
field=EE.fraction_field();solutions=M.change_ring(field).solve_right(B0.augment(B1).change_ring(field));cleared=matrix(EE,15,10,[EE(delta*s) for s in solutions.list()])
assert M*cleared==delta*B0.augment(B1)
def to_rr(f):return sum((cc*eta**i for i,cc in enumerate(f.list())),RR.zero())
Gamma=matrix(RR,15,5,[to_rr(cleared[i,j])+lam*to_rr(cleared[i,j+5]) for i in range(15) for j in range(5)])
print('AUX_READY','DELTA_DEG',delta.degree(),'CLEARED_DEG',max(f.degree() for f in cleared.list()),'SECONDS',time.time()-start,flush=True)
save({'scope':'whole-slope K-only necessary concentrated d10m6 incidence setup; delta=0 retained separately','root':int(args.root),'K':K,'beta':beta,'alpha':alpha,'RR':RR,'R':R,'A':A,'P':P,'F':F,'D':D,'v':v,'H':H,'U_top_eight':U,'top_embed':embed,'top_compatibility':compat,'auxiliary_functions':aux,'eta_ring':EE,'auxiliary_matrix':M,'auxiliary_delta':delta,'auxiliary_forcing':forcing,'cleared_auxiliary_solution':Gamma,'inputs':inputs,'source':source},str(data/f'twisted_d10m6_incidence_setup_{args.root}.sobj'))
