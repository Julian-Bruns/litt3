#!/usr/bin/env sage
"""NEW J111 source-e augmented minor norm; onecore hard45s, checkpointed."""
import json,time,signal,argparse
from pathlib import Path
parser=argparse.ArgumentParser();parser.add_argument('--case',type=int,default=0);parser.add_argument('--variant',choices=['sum','difference','full','gap'],default='sum');parser.add_argument('--profile',choices=['pole3','pole4'],default='pole3');parser.add_argument('--modulo-saved-gcd',action='store_true');args=parser.parse_args()
assert args.profile=='pole3' or args.variant=='gap','Only the uniform gap subsystem applies to pole4 here'
started=time.monotonic();folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform');output=folder/('source_e_J111_case%02d_%s.json'%(args.case,args.variant) if args.profile=='pole3' else 'source_e_pole4_uniform_gap.json');stages=[]
out={'scope':'One selected J111 phase orbit. Source-only E1 selected interpolation, gap17 and symmetric critical e pair augmented minor norm. No incidence/concurrency or annihilator assumption.','stages':stages}
if args.profile=='pole4':out['scope']='Uniform source gap17 norm on the pole4 CRT B0, with one lower b-single and the other two b-double/c-single critical fibers. No selected itinerary equations or annihilator hypothesis. Gap14 is NOT universal: affine b shift cancels it when lambda is nonzero.'
def checkpoint(stage,objects=[]):
 vals=[z for a in objects for z in (a if isinstance(a,tuple) else (a,))];stages.append({'stage':stage,'seconds':time.monotonic()-started,'max_numerator_degree':max([int(z.lift().degree() if args.modulo_saved_gcd else z.numerator().degree()) if z else -1 for z in vals],default=-1),'max_denominator_degree':0 if args.modulo_saved_gcd else max([int(z.denominator().degree()) if z else -1 for z in vals],default=-1)})
 output.write_text(json.dumps(out,indent=2,default=int)+'\n');print(stage,stages[-1],flush=True)
def expired(s,f):out.update(hard_timeout=True,seconds=time.monotonic()-started);output.write_text(json.dumps(out,indent=2,default=int)+'\n');raise TimeoutError('J111 norm hard45s')
signal.signal(signal.SIGALRM,expired);signal.setitimer(signal.ITIMER_REAL,45)
src=Path('scripts/oct02_m9_uniform_compact_norm_symbolic.sage').read_text();body=src[src.index('data=json.loads'):src.index('mm=[]')].replace("checkpoint('functional',[tt]+ff)",'pass')
if args.modulo_saved_gcd:
 body=body.replace("F=RU.fraction_field();u=F(uu)","uniform=folder/'source_e_J111_case00_gap.json'; saved=json.loads((uniform if uniform.exists() else folder/('source_e_J111_case%02d_difference.json'%args.case)).read_text()); modulus=RU([E(v) for v in saved['numerator' if uniform.exists() else 'gcd']]); modulus=modulus//modulus.gcd(modulus.derivative()); F=RU.quotient(modulus,'u');u=F.gen()")
exec(compile(body,'fixed_critical_definitions','exec'))
phase1,phase2=divmod(args.case,3);zz=[F((xe**3-Pe(s)).roots(multiplicities=False)[0]*zeta**k) for s,k in zip(selected_e,[0,phase1,phase2])]
alpha=div(PP[1],PP[0]);beta_rel=div(PP[2],PP[0]);z9=[zero]*9
def add9(a,b):return [add(a[i],b[i]) for i in range(9)]
def scale9(a,c):return [mul(v,c) for v in a]
def mul9(a,b):
 result=[zero]*9
 for i,ai in enumerate(a):
  if ai!=zero:
   for j,bj in enumerate(b):
    if bj!=zero:
     iu=i//3+j//3;jv=i%3+j%3;c=mul(ai,bj)
     if iu>=3:c=mul(c,alpha);iu-=3
     if jv>=3:c=mul(c,beta_rel);jv-=3
     result[3*iu+jv]=add(result[3*iu+jv],c)
 return result
def constant9(c):a=z9[:];a[0]=c;return a
def char0(c):return [constant9(c),z9[:],z9[:]]
def addc(a,b):return [add9(a[i],b[i]) for i in range(3)]
def scalec(a,c):return [scale9(row,c) for row in a]
def mulc(a,b):
 result=[z9[:] for i in range(3)]
 for i in range(3):
  for j in range(3):
   v=mul9(a[i],b[j]);k=i+j
   if k>=3:v=scale9(v,PP[0]);k-=3
   result[k]=add9(result[k],v)
 return result
def qcoeff(ff):
 mm=[]
 for i in range(3):
  j,k=[n for n in range(3) if n!=i];n=add(sub(mul(mul(rr[j],rr[k]),ff[0]),mul(add(rr[j],rr[k]),ff[1])),ff[2]);mm.append(div(n,mul(sub(rr[i],rr[j]),sub(rr[i],rr[k]))))
 aa=[scale(mul(KK[0],mm[0]),F(2)),scale(mul(KK[1],mm[1]),F(-2)),scale(mul(KK[2],mm[2]),F(-2)),scale(mul(mul(mm[0],KK[1]),div(sub(rr[2],rr[0]),sub(rr[2],rr[1]))),F(2)),scale(mul(mul(mm[0],KK[2]),div(sub(rr[0],rr[1]),sub(rr[2],rr[1]))),F(2))]
 if args.profile=='pole4':aa=[scale(mul(KK[0],mm[0]),F(-2)),scale(mul(KK[1],mm[1]),F(2)),scale(mul(KK[2],mm[2]),F(2)),scale(mul(KK[0],mm[1]),F(2)),scale(mul(KK[0],mm[2]),F(2))]
 result=z9[:]
 for index,c in zip([0,6,2,3,1],aa):result[index]=c
 return result
def HB(g,s):return ((Z*g)%P)(s)/P(s)
def interp(vs,r):return add(scale(sub(scalar(ss[1]),r),vs[0]/(ss[1]-ss[0])),scale(sub(r,scalar(ss[0])),vs[1]/(ss[1]-ss[0])))
sel0=sum(ell[i]*zz[i]*HB(delta,ss[i]) for i in range(3));sel1=sum(ell[i]*zz[i]*HB(delta*x,ss[i]) for i in range(3));Ts=sum(ell[i]*T(ss[i])/P(ss[i]) for i in range(3));gap0=Rd[9];gap1=Rdx[9]
sellast=char0(scalar(-Ts));sellast[2]=qcoeff([scalar(sum(ell[i]*zz[i]*HB(x**j,ss[i]) for i in range(3))) for j in range(3)])
gaplast=[z9[:],z9[:],qcoeff([scalar(((Z*x**j)%P)[9]) for j in range(3)])]
pairrows=[]
for i,index in [(1,3),(2,1)]:
 r=rr[i];rel=z9[:];rel[index]=one
 row=[]
 for g in [delta,delta*x]:
  c=char0(interp([zz[k]*HB(g,ss[k]) for k in [0,1]],r));c[1]=scale9(rel,neg(div(evaluate((Z*g)%P,r),PP[i])));row.append(c)
 c=char0(add(neg(interp([T(ss[k])/P(ss[k]) for k in [0,1]],r)),div(evaluate(T,r),PP[i])))
 c[2]=qcoeff([interp([zz[k]*HB(x**j,ss[k]) for k in [0,1]],r) for j in range(3)])
 h=qcoeff([div(evaluate((Z*x**j)%P,r),PP[i]) for j in range(3)]);c[0]=add9(c[0],scale9(mul9(rel,h),neg(PP[0])));row.append(c);pairrows.append(row)
sumrow=[addc(pairrows[0][j],pairrows[1][j]) for j in range(3)];diff_inv=inv(sub(rr[1],rr[2]));diffrow=[scalec(addc(pairrows[0][j],scalec(pairrows[1][j],scalar(-1))),diff_inv) for j in range(3)]
if args.variant=='gap':f=gaplast
elif args.variant=='full':
 f=scalec(addc(mulc(sumrow[1],diffrow[2]),scalec(mulc(sumrow[2],diffrow[1]),scalar(-1))),scalar(sel0))
 f=addc(f,scalec(addc(mulc(sumrow[2],diffrow[0]),scalec(mulc(sumrow[0],diffrow[2]),scalar(-1))),scalar(sel1)))
 f=addc(f,mulc(sellast,addc(mulc(sumrow[0],diffrow[1]),scalec(mulc(sumrow[1],diffrow[0]),scalar(-1)))))
else:
 row=sumrow if args.variant=='sum' else diffrow
 f=scalec(row[2],scalar(sel0*gap1-sel1*gap0))
 f=addc(f,mulc(row[0],addc(scalec(gaplast,scalar(sel1)),scalec(sellast,scalar(-gap1)))))
 f=addc(f,mulc(row[1],addc(scalec(sellast,scalar(gap0)),scalec(gaplast,scalar(-sel0)))))
checkpoint('augmented_minor_character_elements',sum(f,[]))
a,b,c=f;S=add9(add9(mul9(mul9(a,a),a),scale9(mul9(mul9(b,b),b),PP[0])),scale9(mul9(mul9(c,c),c),mul(PP[0],PP[0])))
S=add9(S,scale9(mul9(mul9(a,b),c),scale(PP[0],F(-3))));checkpoint('diagonal_character_norm',S)
tail=Path('scripts/oct02_m9_uniform_compact_second_support.sage').read_text();tail=tail[tail.index('def mulv'):tail.index('firstfile=')];exec(compile(tail,'relative_cubic_norms','exec'))
if args.modulo_saved_gcd:
 result=final[0].lift();common=result.gcd(modulus)
 out.update(complete=True,case=args.case,variant=args.variant,second_quadratic_component_zero=True,modulo_saved_gcd=True,modulus_degree=int(modulus.degree()),norm_remainder=[[int(c) for c in v.polynomial().list()] for v in result.list()],gcd_degree=int(common.degree()),gcd=[[int(c) for c in v.polynomial().list()] for v in common.list()],seconds=time.monotonic()-started)
 output.write_text(json.dumps(out,indent=2,default=int)+'\n');signal.setitimer(signal.ITIMER_REAL,0);print('J111mod',args.case,'modulus',modulus.degree(),'gcd',common.degree(),'seconds',out['seconds'],flush=True);raise SystemExit
out.update(complete=True,case=args.case,variant=args.variant,profile=args.profile,second_quadratic_component_zero=True,numerator=[[int(c) for c in v.polynomial().list()] for v in final[0].numerator().list()],denominator=[[int(c) for c in v.polynomial().list()] for v in final[0].denominator().list()],seconds=time.monotonic()-started)
if args.variant=='gap' and args.profile=='pole3':
 d=json.loads((folder/'source_e_J111_case00_difference.json').read_text());out['equal_to_saved_common_support']=final[0].numerator().monic()==RU([E(v) for v in d['gcd']]).monic();assert out['equal_to_saved_common_support']
other=folder/('source_e_J111_case%02d_%s.json'%(args.case,'difference' if args.variant=='sum' else 'sum'))
if args.profile=='pole3' and other.exists() and json.loads(other.read_text()).get('complete'):
 d=json.loads(other.read_text());common=final[0].numerator().gcd(RU([E(v) for v in d['numerator']]));out.update(gcd_degree=int(common.degree()),gcd=[[int(c) for c in v.polynomial().list()] for v in common.list()])
output.write_text(json.dumps(out,indent=2,default=int)+'\n');signal.setitimer(signal.ITIMER_REAL,0);print('J111',args.case,args.variant,'degree',final[0].numerator().degree(),'gcd',out.get('gcd_degree'),'seconds',out['seconds'],flush=True)
