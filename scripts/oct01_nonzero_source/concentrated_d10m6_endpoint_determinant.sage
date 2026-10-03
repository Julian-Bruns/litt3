#!/usr/bin/env sage
"""Full first-slope auxiliary determinant, with source boundary retained."""
from sage.all import *
import argparse,json,time
from pathlib import Path
from math import comb
ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True);ap.add_argument('--root',type=int,default=145049);args=ap.parse_args();data=args.work/'data';start=time.time()
E=GF(5**24,'z');ZZ=PolynomialRing(E,'Z');Z=ZZ.gen();beta=(Z**2-Z-3).roots(multiplicities=False)[0]
def bcode(c):return E(c%5)+E(c//5)*beta
alpha=sum((bcode(c)*Z**i for i,c in enumerate((5,2,6,7,1))),ZZ.zero()).roots(multiplicities=False)[0];rho=(Z**3-bcode(6)).roots(multiplicities=False)[0]
cache={}
def decode(code):
    code=int(code)
    if code not in cache:
        n=code;v=E.zero()
        for j in range(3):
            q=n%390625;n//=390625;s=E.zero()
            for i in range(4):s+=bcode(q%25)*alpha**i;q//=25
            v+=s*rho**j
        cache[code]=v
    return cache[code]
L=PolynomialRing(E,'eta');eta=L.gen();R=PolynomialRing(E,('x','ee'));x,ee=R.gens()
def ep(coeffs):return sum((decode(c)*ee**i for i,c in enumerate(coeffs)),R.zero())
Pcodes=[11,22,18,5,19,20,15,16,9,22,1];P=sum((bcode(c)*x**i for i,c in enumerate(Pcodes)),R.zero());B=sum((bcode(c)*x**i for i,c in enumerate([8,14,19,2,10,19,3,24,18,16])),R.zero());Zbase=sum((bcode(c)*x**i for i,c in enumerate([8,14,19,2,10,19,3,24,18,16])),R.zero())-sum((bcode(c)*x**i for i,c in enumerate([18,20,20,15])),R.zero())
zero=[R.zero()]*3
def add(a,b):return [a[i]+b[i] for i in range(3)]
def scale(a,s):return [c*s for c in a]
def mul(a,b):
    out=[R.zero()]*5
    for i in range(3):
        for j in range(3):out[i+j]+=a[i]*b[j]
    return [out[0]+P*out[3],out[1]+P*out[4],out[2]]
def divide_y(f,n):
    out=zero[:]
    for char,component in enumerate(f):
        exponent,target=divmod(char-n,3)
        if exponent<0:
            q,r=component.quo_rem(P**(-exponent));assert not r;out[target]=q
        else:out[target]=component*P**exponent
    return out
source=next(r for r in json.loads((data/'concentrated_d10m6_source_family.json').read_text())['records'] if r['root']==args.root)
points=json.loads((data/'shifted_concentrated_projection.json').read_text())['records'];chosen=next(r for r in points if r['root_K_code']==args.root);root=decode(args.root);y0=decode(chosen['y0_extension_code']);characters=[1,1,1,1,1,2,0,0,2,2,2,2,2,0,0,0,0,1]
adapted=json.loads((data/'adapted_family.json').read_text());columns=[adapted['origin']]+adapted['directions'][5:]
nums=[ep(f)*y0**(1-e) for f,e in zip(source['kappa_numerators'],characters)];free=[ep(f)*y0**(1-e) for f,e in zip(source['cy_numerators'],characters)]
assert not any(free[:13])
N=[zero[:] for _ in range(6)]
for scalar,column in zip(nums[:13],columns):
    for tag,c in zip(adapted['labels'],column):
        if tag[0]=='kappa' or not c:continue
        degree,b,char=tag;N[degree][char]+=scalar*decode(c)*x**b
N[0]=zero[:];D=[]
for j in range(1,5):
    total=zero[:]
    for i in range(1,6):
        degree=5-i
        if degree>=j:total=add(total,scale(N[i],comb(degree,j)*(-B)**(degree-j)))
    D.append(scale(divide_y(total,5-j),j))
def ex(poly,xx):
    out=L.zero()
    for (i,j),c in poly.dict().items():out+=c*xx**i*eta**j
    return out
def value(function,xx,yy):return sum((ex(c,xx)*yy**j for j,c in enumerate(function)),L.zero())
input_aux=json.loads((data/'critical_quadratic_fixed_input.json').read_text())['auxiliary_functions']
aux=[[[sum((decode(c)*x**i for i,c in enumerate(component)),R.zero()) for component in f] for f in ns] for ns in input_aux]
omega=(ZZ.gen()**2+ZZ.gen()+1).roots(multiplicities=False)[0];endpoints=[(decode(p['root_K_code']),decode(p['y0_extension_code'])*omega**j) for p in points for j in range(3)]
matrix_rows=[];tags=[]
for xx,yy in endpoints:
    if (xx,yy)==(root,y0):continue
    d,c,b,a=[value(f,xx,yy) for f in D];center=value([Zbase,R.zero(),R.zero()],xx,yy)/yy
    row=[]
    for ns in aux:
        n0,n1,n2=[value(f,xx,yy) for f in ns]
        row.append(-a*n2-(b+a*center)*n1-(c+b*center+a*center**2)*n0)
    matrix_rows.append(row);tags.append(['ordinary',str(xx),str(yy)])
S=PolynomialRing(L,'r');r=S.gen();cut=4
def shift(poly):
    out=S.zero()
    for (i,j),c in poly.dict().items():
        for n in range(min(i,cut-1)+1):out+=c*comb(i,n)*root**(i-n)*eta**j*r**n
    return out
pp=shift(P);h=S.one()
for n in range(1,cut):h+=((pp[n]/pp[0]-(h**3)[n])/3)*r**n
yy=y0*h;yi=S.one()/y0
for n in range(1,cut):yi-=((yy*yi)[n]/y0)*r**n
def series(function):return sum((shift(c)*yy**j for j,c in enumerate(function)),S.zero())%r**cut
t=sum((decode(c)*x**i for i,c in enumerate(adapted['t'])),R.zero());center=(shift(Zbase)*yi+ex(t.derivative(x),root)*eta/y0*r)%r**cut
dd=list(map(series,D));a,b,c=dd[3],dd[2],dd[1];jet_columns=[]
for ns in aux:
    n0,n1,n2=list(map(series,ns));q0=-a*n2-(b+a*center)*n1-(c+b*center+a*center**2)*n0;q1=-a*n1-(b+2*a*center)*n0;q2=-a*n0
    jet_columns.append([q0[j] for j in range(4)]+[q1[j] for j in range(2)]+[q2[0]])
for j in range(7):matrix_rows.append([column[j] for column in jet_columns]);tags.append(['concentrated',int(j)])
M=matrix(L,matrix_rows);assert M.nrows()==15 and M.ncols()==15
row_degrees=[max(f.degree() for f in row) for row in M.rows()];bound=sum(row_degrees)
print('MATRIX_READY','ROW_DEGREES',row_degrees,'BOUND',bound,'SECONDS',time.time()-start,flush=True)
det=M.det();assert det and det.degree()<=bound
H=L(ep(source['H'])(0,eta));p2=L(ep(source['kappa_numerators'][2])(0,eta));leading=value(D[3],root,y0);unit=H*p2*leading;g=det;power=0
while True:
    gg=g.gcd(unit)
    if gg.degree()<=0:break
    g//=gg;power+=1
print('DET','DEG',det.degree(),'REMAINING',g.degree(),'POWER',power,'SECONDS',time.time()-start,flush=True)
save({'scope':'full eta polynomial auxiliary determinant on concentrated d10m6; freev independent D; all coefficient boundaries retained','E':E,'beta':beta,'alpha':alpha,'rho':rho,'L':L,'R':R,'Dhat':D,'source':source,'matrix':M,'row_tags':tags,'row_degree_bound':bound,'determinant':det,'H':H,'p2':p2,'leading_endpoint':leading,'unit':unit,'saturation_remaining':g,'saturation_power':power},str(data/f'concentrated_d10m6_endpoint_determinant_{args.root}.sobj'))
(data/f'concentrated_d10m6_endpoint_determinant_{args.root}.json').write_text(json.dumps({'root':int(args.root),'row_degree_bound':int(bound),'determinant_degree':int(det.degree()),'remaining_degree':int(g.degree()),'saturation_power':int(power),'source_denominator_degree':int(H.degree()),'freev_D_independent':True,'scope':'necessary quotient-jet auxiliary matrix, no existence decision'},separators=(',',':'))+'\n')
