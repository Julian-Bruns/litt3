#!/usr/bin/env sage
"""One NEW J: symbolic compact norm via quadratic/rank9 algebra, hard30s."""
import json,time,signal,argparse
from pathlib import Path
parser=argparse.ArgumentParser();parser.add_argument('--case',type=int);args=parser.parse_args()
started=time.monotonic();folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform');output=folder/('compact_norm_symbolic_prototype.json' if args.case is None else 'compact_source_pair_%02d_first.json'%args.case)
stages=[];out={'scope':'One new selected pair, pole3, symbolic critical-x numerator via18-dimensional algebra. No full-family or exceptional-source decision.','stages':stages}
def checkpoint(stage,objects=[]):
 vals=[z for a in objects for z in (a if isinstance(a,tuple) else (a,))]
 stages.append({'stage':stage,'seconds':time.monotonic()-started,'max_numerator_degree':max([int(z.numerator().degree()) if z else -1 for z in vals],default=-1),'max_denominator_degree':max([int(z.denominator().degree()) if z else -1 for z in vals],default=-1)})
 output.write_text(json.dumps(out,indent=2,default=int)+'\n');print(stage,stages[-1],flush=True)
def expired(s,f):
 out['hard_timeout']=True;out['seconds']=time.monotonic()-started;output.write_text(json.dumps(out,indent=2,default=int)+'\n');raise TimeoutError('compact symbolic new prototype hard30s')
signal.signal(signal.SIGALRM,expired);signal.setitimer(signal.ITIMER_REAL,30)
data=json.loads((folder/'same_fiber_zero_parameter_resultants.json').read_text());R5=PolynomialRing(GF(5),'t')
E=GF(5**8,'e',modulus=R5(data['field_modulus']));beta=E(data['beta_coordinates']);RE=PolynomialRing(E,'x');xe=RE.gen()
def code(c):return E(c%5)+E(c//5)*beta
def epoly(cs):return RE([code(c) for c in cs])
Pe=epoly([11,22,18,5,19,20,15,16,9,22,1]);Ze=epoly([15,19,24,12,10,19,3,24,18,16]);Ae=epoly([1,21,14,22,13]);qe=epoly([13,18,24]);q3e=epoly([1,22,9,1])
aroots=[E(r['A_root']) for r in data['records']];pbase=Pe(aroots[0]);Pe/=pbase;Ze/=pbase
RU=PolynomialRing(E,'r0');uu=RU.gen();F=RU.fraction_field();u=F(uu);R=PolynomialRing(F,'x');x=R.gen()
def lift(g):return R([F(v) for v in g.list()])
P=lift(Pe);Z=lift(Ze);q=lift(qe);q3=lift(q3e);lam=-q3(u)/q(u);delta=q3+lam*q;K,rem=(Z*delta).quo_rem(P)
selected_e=aroots[1:];ss=[F(s) for s in selected_e]
pair_index,phase=(2,0) if args.case is None else divmod(args.case,3)
pair=[(0,1),(0,2),(1,2)][pair_index];zeta=(xe**2+xe+1).roots(multiplicities=False)[0];zz=[F.zero()]*3
for n,i in enumerate(pair):zz[i]=F((xe**3-Pe(selected_e[i])).roots(multiplicities=False)[0]*zeta**(phase if n else 0))
izero=next(i for i in range(3) if not zz[i])
ell=[1/prod(ss[i]-ss[j] for j in range(3) if j!=i) for i in range(3)]
Rd=(Z*delta)%P;Rdx=(Z*delta*x)%P;T=(Z**2*delta)%P
c0=vector(F,[Rd(ss[izero])/P(ss[izero]),sum(ell[i]*zz[i]*Rd(ss[i])/P(ss[i]) for i in range(3)),Rd[9]])
c1=vector(F,[Rdx(ss[izero])/P(ss[izero]),sum(ell[i]*zz[i]*Rdx(ss[i])/P(ss[i]) for i in range(3)),Rdx[9]])
w=c0.cross_product(c1);tt=w[1]*sum(ell[i]*T(ss[i])/P(ss[i]) for i in range(3))
def functional(g):
 h=(Z*g)%P
 return -w[0]*h(ss[izero])/P(ss[izero])-w[1]*sum(ell[i]*zz[i]*h(ss[i])/P(ss[i]) for i in range(3))-w[2]*h[9]
ff=[functional(x**i) for i in range(3)];checkpoint('functional',[tt]+ff)
A=delta[2]+u;B=delta[1]+delta[2]*u+u*u;zero=(F.zero(),F.zero());one=(F.one(),F.zero())
def scalar(a):return (F(a),F.zero())
def add(a,b):return (a[0]+b[0],a[1]+b[1])
def neg(a):return (-a[0],-a[1])
def sub(a,b):return add(a,neg(b))
def mul(a,b):return (a[0]*b[0]-a[1]*b[1]*B,a[0]*b[1]+a[1]*b[0]-a[1]*b[1]*A)
def inv(a):
 n=a[0]**2-A*a[0]*a[1]+B*a[1]**2
 assert n;return ((a[0]-A*a[1])/n,-a[1]/n)
def div(a,b):return mul(a,inv(b))
def scale(a,c):return (a[0]*c,a[1]*c)
def evaluate(g,a):
 v=zero
 for c in reversed(g.list()):v=add(mul(v,a),scalar(c))
 return v
rr=[scalar(u),(F.zero(),F.one()),(-A,-F.one())];PP=[evaluate(P,r) for r in rr];KK=[evaluate(K,r) for r in rr]
mm=[]
for i in range(3):
 j,k=[n for n in range(3) if n!=i]
 numerator=add(sub(scale(mul(rr[j],rr[k]),ff[0]),scale(add(rr[j],rr[k]),ff[1])),scalar(ff[2]))
 denominator=mul(sub(rr[i],rr[j]),sub(rr[i],rr[k]));mm.append(div(numerator,denominator))
aa=[scale(mul(KK[0],mm[0]),F(2)),scale(mul(KK[1],mm[1]),F(-2)),scale(mul(KK[2],mm[2]),F(-2)),
    scale(mul(mul(mm[0],KK[1]),div(sub(rr[2],rr[0]),sub(rr[2],rr[1]))),F(2)),
    scale(mul(mul(mm[0],KK[2]),div(sub(rr[0],rr[1]),sub(rr[2],rr[1]))),F(2))]
alpha=div(PP[1],PP[0]);beta_rel=div(PP[2],PP[0]);checkpoint('quadratic_coefficients',aa+[alpha,beta_rel])
def mul9(a,b):
 out=[zero]*9
 for i,ai in enumerate(a):
  if ai!=zero:
   for j,bj in enumerate(b):
    if bj!=zero:
     iu=i//3+j//3;jv=i%3+j%3;c=mul(ai,bj)
     if iu>=3:c=mul(c,alpha);iu-=3
     if jv>=3:c=mul(c,beta_rel);jv-=3
     idx=3*iu+jv;out[idx]=add(out[idx],c)
 return out
Q=[zero]*9
for idx,c in [(0,aa[0]),(6,aa[1]),(2,aa[2]),(3,aa[3]),(1,aa[4])]:Q[idx]=c
cube=mul9(mul9(Q,Q),Q);S=[mul(mul(PP[0],PP[0]),v) for v in cube];S[0]=add(S[0],scalar(tt**3));checkpoint('relative9_element',S)
def mulv(a,b):
 out=[zero]*3
 for i in range(3):
  for j in range(3):
   c=mul(a[i],b[j]);idx=i+j
   if idx>=3:c=mul(c,beta_rel);idx-=3
   out[idx]=add(out[idx],c)
 return out
def addv(a,b):return [add(a[i],b[i]) for i in range(3)]
def scalev(a,c):return [mul(v,c) for v in a]
rows=[S[0:3],S[3:6],S[6:9]];Nv=[zero]*3
for i,row in enumerate(rows):Nv=addv(Nv,scalev(mulv(mulv(row,row),row),one if i==0 else alpha if i==1 else mul(alpha,alpha)))
Nv=addv(Nv,scalev(mulv(mulv(rows[0],rows[1]),rows[2]),scale(alpha,F(-3))));checkpoint('first_cubic_norm',Nv)
a,b,c=Nv;final=add(add(mul(mul(a,a),a),mul(beta_rel,mul(mul(b,b),b))),mul(mul(beta_rel,beta_rel),mul(mul(c,c),c)))
final=sub(final,scale(mul(beta_rel,mul(mul(a,b),c)),F(3)));checkpoint('second_cubic_norm',[final])
assert final[1]==0,'Complementary-root symmetry failed'
def coords(v):return [int(c) for c in v.polynomial().list()]
out.update({'complete':True,'case':args.case,'selected_pair_indices':list(pair),'relative_phase':phase,'second_quadratic_component_zero':True,'numerator':[[int(c) for c in v.polynomial().list()] for v in final[0].numerator().list()],
            'denominator':[[int(c) for c in v.polynomial().list()] for v in final[0].denominator().list()],
            'field_modulus':data['field_modulus'],'beta':data['beta_coordinates'],'normalization_Pbase':coords(pbase),'seconds':time.monotonic()-started})
output.write_text(json.dumps(out,indent=2,default=int)+'\n');signal.setitimer(signal.ITIMER_REAL,0)
print('SYMBOLICcomplete numeratorDegree',final[0].numerator().degree(),'denominatorDegree',final[0].denominator().degree(),'seconds',out['seconds'],flush=True)
