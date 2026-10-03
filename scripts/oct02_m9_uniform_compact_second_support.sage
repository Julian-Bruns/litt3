#!/usr/bin/env sage
"""New same-marking source-e pair trace norm; hard30s, no lambda resultant."""
import json,time,signal,argparse
from pathlib import Path
parser=argparse.ArgumentParser();parser.add_argument('--case',type=int);args=parser.parse_args()
started=time.monotonic();folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform');output=folder/('compact_second_source_support.json' if args.case is None else 'compact_source_pair_%02d_second.json'%args.case)
stages=[];out={'scope':'One fixed selected pair and pole3. Necessary norm of the SUM of the two c-double critical e-content equations, Cramer-cleared. Same marked sheet cover as first support; norm gcd is only a necessary relaxation.','stages':stages}
def checkpoint(stage,objects=[]):
 vals=[z for a in objects for z in (a if isinstance(a,tuple) else (a,))]
 stages.append({'stage':stage,'seconds':time.monotonic()-started,'max_numerator_degree':max([int(z.numerator().degree()) if z else -1 for z in vals],default=-1),'max_denominator_degree':max([int(z.denominator().degree()) if z else -1 for z in vals],default=-1)})
 output.write_text(json.dumps(out,indent=2,default=int)+'\n');print(stage,stages[-1],flush=True)
def expired(s,f):
 out['hard_timeout']=True;out['seconds']=time.monotonic()-started;output.write_text(json.dumps(out,indent=2,default=int)+'\n');raise TimeoutError('second source support hard30s')
signal.signal(signal.SIGALRM,expired);signal.setitimer(signal.ITIMER_REAL,30)
# Reuse only definitions up to the first norm's coefficient assembly; no settled
# symbolic norm computation is repeated.
src=Path('scripts/oct02_m9_uniform_compact_norm_symbolic.sage').read_text()
body=src[src.index("data=json.loads"):src.index("mm=[]")]
body=body.replace("checkpoint('functional',[tt]+ff)","pass")
exec(compile(body,'first_support_definitions','exec'))
# Interpolate E1 through the full-zero selected fiber and either selected c-zero.
izero=next(i for i in range(3) if not zz[i]);ione=pair[0]
D=c0[0]*c1[1]-c1[0]*c0[1];ts=sum(ell[i]*T(ss[i])/P(ss[i]) for i in range(3))
muc=-c1[0]*ts;nuc=c0[0]*ts
def HB(g,s):return ((Z*g)%P)(s)/P(s)
def ls(g):return sum(ell[i]*zz[i]*HB(g,ss[i]) for i in range(3))
def bf(g):return -c1[1]*HB(g,ss[izero])+c1[0]*ls(g),c0[1]*HB(g,ss[izero])-c0[0]*ls(g)
def qcoeff(functional_coeff):
 mm=[]
 for i in range(3):
  j,k=[n for n in range(3) if n!=i]
  n=add(sub(mul(mul(rr[j],rr[k]),functional_coeff[0]),mul(add(rr[j],rr[k]),functional_coeff[1])),functional_coeff[2])
  mm.append(div(n,mul(sub(rr[i],rr[j]),sub(rr[i],rr[k]))))
 return [scale(mul(KK[0],mm[0]),F(2)),scale(mul(KK[1],mm[1]),F(-2)),scale(mul(KK[2],mm[2]),F(-2)),
  scale(mul(mul(mm[0],KK[1]),div(sub(rr[2],rr[0]),sub(rr[2],rr[1]))),F(2)),
  scale(mul(mul(mm[0],KK[2]),div(sub(rr[0],rr[1]),sub(rr[2],rr[1]))),F(2))]
alpha=div(PP[1],PP[0]);beta_rel=div(PP[2],PP[0])
def mul9(a,b):
 result=[zero]*9
 for i,ai in enumerate(a):
  if ai!=zero:
   for j,bj in enumerate(b):
    if bj!=zero:
     iu=i//3+j//3;jv=i%3+j%3;c=mul(ai,bj)
     if iu>=3:c=mul(c,alpha);iu-=3
     if jv>=3:c=mul(c,beta_rel);jv-=3
     idx=3*iu+jv;result[idx]=add(result[idx],c)
 return result
def plus9(a,b):return [add(a[i],b[i]) for i in range(9)]
def scale9(a,c):return [mul(v,c) for v in a]
def embedq(cs):
 result=[zero]*9
 for idx,c in zip([0,6,2,3,1],cs):result[idx]=c
 return result
G0=[zero]*9;G1=[zero]*9;G2=[zero]*9
for i,relidx in [(1,3),(2,1)]:
 r=rr[i];rD=evaluate(Rd,r);rxD=evaluate(Rdx,r);tr=evaluate(T,r)
 linear=scale(sub(r,scalar(ss[izero])),1/(ss[ione]-ss[izero]))
 ec=add(scale(sub(one,linear),-D*T(ss[izero])/P(ss[izero])),scale(linear,zz[ione]*(muc*HB(delta,ss[ione])+nuc*HB(delta*x,ss[ione]))-D*T(ss[ione])/P(ss[ione])))
 G0[0]=add(G0[0],add(ec,scale(div(tr,PP[i]),D)))
 # All rows are divided by P(ri), valid on the ordinary locus. Poles at
 # P(ri)=0 remain explicitly outside this ordinary support calculation.
 hc=div(add(scale(rD,muc),scale(rxD,nuc)),PP[i]);G1[relidx]=sub(G1[relidx],hc)
 eff=[];hff=[]
 for j in range(3):
  g=x**j;muB,nuB=bf(g)
  eff.append(scale(linear,zz[ione]*(D*HB(g,ss[ione])+muB*HB(delta,ss[ione])+nuB*HB(delta*x,ss[ione]))))
  hff.append(div(add(add(scale(evaluate((Z*g)%P,r),D),scale(rD,muB)),scale(rxD,nuB)),PP[i]))
 G2=plus9(G2,embedq(qcoeff(eff)))
 shift=[zero]*9;shift[relidx]=one
 G0=plus9(G0,scale9(mul9(shift,embedq(qcoeff(hff))),scale(PP[0],F(-1))))
checkpoint('pair_trace_character_elements',G0+G1+G2)
S=plus9(plus9(mul9(mul9(G0,G0),G0),scale9(mul9(mul9(G1,G1),G1),PP[0])),scale9(mul9(mul9(G2,G2),G2),mul(PP[0],PP[0])))
S=plus9(S,scale9(mul9(mul9(G0,G1),G2),scale(PP[0],F(-3))))
checkpoint('diagonal_character_norm',S)
def mulv(a,b):
 result=[zero]*3
 for i in range(3):
  for j in range(3):
   c=mul(a[i],b[j]);idx=i+j
   if idx>=3:c=mul(c,beta_rel);idx-=3
   result[idx]=add(result[idx],c)
 return result
def addv(a,b):return [add(a[i],b[i]) for i in range(3)]
def scalev(a,c):return [mul(v,c) for v in a]
rows=[S[0:3],S[3:6],S[6:9]];Nv=[zero]*3
for i,row in enumerate(rows):Nv=addv(Nv,scalev(mulv(mulv(row,row),row),one if i==0 else alpha if i==1 else mul(alpha,alpha)))
Nv=addv(Nv,scalev(mulv(mulv(rows[0],rows[1]),rows[2]),scale(alpha,F(-3))));checkpoint('first_cubic_norm',Nv)
a,b,c=Nv;final=add(add(mul(mul(a,a),a),mul(beta_rel,mul(mul(b,b),b))),mul(mul(beta_rel,beta_rel),mul(mul(c,c),c)))
final=sub(final,scale(mul(beta_rel,mul(mul(a,b),c)),F(3)));checkpoint('second_cubic_norm',[final])
assert final[1]==0,'Pair trace complementary symmetry failed'
firstfile='compact_norm_symbolic_prototype.json' if args.case is None else 'compact_source_pair_%02d_first.json'%args.case
first=json.loads((folder/firstfile).read_text());fnum=RU([E(v) for v in first['numerator']]);common=fnum.gcd(final[0].numerator())
out.update({'complete':True,'case':args.case,'selected_pair_indices':list(pair),'relative_phase':phase,'second_quadratic_component_zero':True,'numerator':[[int(c) for c in v.polynomial().list()] for v in final[0].numerator().list()],
 'denominator':[[int(c) for c in v.polynomial().list()] for v in final[0].denominator().list()], 'gcd_degree':int(common.degree()),
 'gcd':[[int(c) for c in v.polynomial().list()] for v in common.list()], 'selected_cramer_determinant_numerator':[[int(c) for c in v.polynomial().list()] for v in D.numerator().list()],
 'seconds':time.monotonic()-started})
output.write_text(json.dumps(out,indent=2,default=int)+'\n');signal.setitimer(signal.ITIMER_REAL,0)
print('SECONDcomplete numeratorDegree',final[0].numerator().degree(),'denominatorDegree',final[0].denominator().degree(),'gcdDegree',common.degree(),'seconds',out['seconds'],flush=True)
