"""All-geometric-scale exclusion on the full finite boundary divisors.
No finite-field point scan: work in full quotient algebras and record Bezout
identities. A nonunit Euclidean pivot triggers an exact algebra split.
"""
from residual import *
from ff import Poly,X
import json, argparse, sys, time

def data_polys():return {k:Poly(v) for k,v in RATIO.items()}

def make_cases():
 r=data_polys();b,c,e=r['b'],r['c'],r['e']
 a=r['a0']; disc=b*b*c*c+a*c**3+b**3*e+3*a*a*e*e+3*a*b*c*e
 return [('b_zero',b),('e_zero',e),('cubic_leading_zero',c*c-4*b*e),('cubic_leading_companion',c*c-4*b*e),('zero_scale_companion',disc)]

def point(case,mod):
 q=ext.context(mod);r={k:peval(v,q) for k,v in RATIO.items()}
 if case=='b_zero':u=r['e']/r['c']
 elif case=='e_zero':u=3*r['c']/r['b']
 elif case=='cubic_leading_zero':u=2*r['c']/r['b']
 elif case=='cubic_leading_companion':u=r['c']/r['b']
 elif case=='zero_scale_companion':
  a,b,c,e=[r[k] for k in ['a0','b','c','e']]
  aa=a*(4*c*c-3*b*e)-b*b*c;bb=a*c*e-2*b*b*e
  u=3*c/b+bb/aa
 else:raise ValueError(case)
 return q,u

def allowed_modulus(case,mod):
 # Each identity here is a polynomial condition in q. Removing its gcd
 # removes exactly forbidden points (or points for which no allowed u exists).
 r=data_polys();q=X;b,c,e,d,a0=[r[k] for k in ['b','c','e','d','a0']]
 common=q*d*(q-10149)*(q-118020)*(q-64426)
 if case=='b_zero':
  den=c;num=e
 elif case=='e_zero':
  den=b;num=3*c
 elif case=='cubic_leading_zero':
  den=b;num=2*c
 elif case=='cubic_leading_companion':
  den=b;num=c
 elif case=='zero_scale_companion':
  aa=a0*(4*c*c-3*b*e)-b*b*c;bb=a0*c*e-2*b*b*e
  den=b*aa;num=3*c*aa+b*bb
 else:raise ValueError(case)
 V=a0*num**3+b*num*num*den+c*num*den**2+e*den**3
 ordinary=b*num+c*den
 prohibited=common*den*num*V*ordinary
 sf=mod//mod.gcd(mod.derivative())
 removed=sf.gcd(prohibited)
 allowed=(sf//removed).monic()
 return allowed,{'original_modulus':mod.monic().tolist(),'squarefree_modulus':sf.monic().tolist(),'removed_modulus':removed.tolist(),'allowed_modulus':allowed.tolist()}

def strip_mu(g):
 n=0
 while n<len(g) and not g[n]:n+=1
 return n,EP(g.a[n:])

def solve_block(case,mod,outdir,tag):
 start=time.time();q,u=point(case,mod);check_open(q,u)
 rr,A=residual(q,u)
 ts=Tails(A)
 pols=[];g=EP();witness=[];used=[]
 for n in range(71,141):
  f=ts.tail(n);pols.append(f);used.append(n)
  if not g:
   if not f:witness.append(EP());continue
   lead=f[f.degree()].inverse();g=f*lead
   witness=[EP() for _ in range(len(pols)-1)]+[EP(lead)]
  else:
   ng,aa,bb=g.xgcd(f)
   witness=[aa*z for z in witness]+[bb];g=ng
  k,nonzero=strip_mu(g)
  if nonzero.degree()==0:
   unit=nonzero[0].inverse();g=g*unit;witness=[z*unit for z in witness]
   lhs=EP()
   for z,f0 in zip(witness,pols):lhs=lhs+z*f0
   assert lhs==g
   assert g==EP([0]*k+[1])
   certificate={'case':case,'modulus':mod.tolist(),'u_formula':{'b_zero':'e/c','e_zero':'3c/b','cubic_leading_zero':'2c/b','cubic_leading_companion':'c/b','zero_scale_companion':'3c/b+(a0*c*e-2*b^2*e)/(a0*(4*c^2-3*b*e)-b^2*c)'}[case], 'tail_indices':used,'tail_degrees':[f0.degree() for f0 in pols], 'mu_power':k,'bezout_coefficients':[z.serialize() for z in witness], 'elapsed_seconds':round(time.time()-start,3)}
   file=outdir/(case+'_'+tag+'.json');file.write_text(json.dumps(certificate,separators=(',',':'))+'\n')
   return {'tag':tag,'degree':mod.degree(),'certificate':str(file.relative_to(ROOT)),'tail_indices':used,'tail_degrees':certificate['tail_degrees'],'mu_power':k,'elapsed_seconds':certificate['elapsed_seconds']}
 # A nonconstant gcd after all seventy equations gives an actual square algebra,
 # after quotienting by the gcd and applying the already checked localizations.
 return {'tag':tag,'degree':mod.degree(),'status':'SURVIVOR','gcd':g.serialize(),'elapsed_seconds':time.time()-start}

def run(case,mod,outdir):
 allowed,summary=allowed_modulus(case,mod)
 summary['case']=case;summary['blocks']=[];summary['splits']=[]
 queue=[(allowed,'0')] if allowed.degree()>0 else []
 if case=='zero_scale_companion' and allowed.degree()>0:
  from factor import factor_squarefree,irreducible
  factors=factor_squarefree(allowed)
  assert all(irreducible(f) for f in factors)
  summary['initial_factorization']=[f.tolist() for f in factors]
  queue=[(f,str(i)) for i,f in enumerate(factors)]
 while queue:
  m,tag=queue.pop()
  print(case,tag,'quotient degree',m.degree(),flush=True)
  try:
   result=solve_block(case,m,outdir,tag);summary['blocks'].append(result)
   print(' ',result,flush=True)
  except ext.NonUnit as ex:
   factor=ex.factor.monic()
   assert 0<factor.degree()<m.degree(),('nonunit but no proper split',ex.coefficient,ex.factor,m)
   complement=(m//factor).monic()
   assert factor.gcd(complement)==Poly(1)
   summary['splits'].append({'modulus':m.tolist(),'factor':factor.tolist(),'complement':complement.tolist()})
   queue += [(factor,tag+'a'),(complement,tag+'b')]
 summary['status']='excluded' if all('status' not in b for b in summary['blocks']) else 'survivor'
 return summary

def main():
 parser=argparse.ArgumentParser();parser.add_argument('--case',choices=[a for a,b in make_cases()]);args=parser.parse_args()
 outdir=ROOT/'data'/'boundary_certificates';outdir.mkdir(exist_ok=True)
 summaries=[]
 for case,mod in make_cases():
  if args.case and case!=args.case:continue
  summary=run(case,mod,outdir);summaries.append(summary)
  (ROOT/'checks'/(case+'.json')).write_text(json.dumps(summary,indent=2)+'\n')
 print(json.dumps([{'case':s['case'],'allowed_degree':len(s['allowed_modulus'])-1,'blocks':len(s['blocks']),'status':s['status']} for s in summaries],indent=2),flush=True)
if __name__=='__main__':main()
