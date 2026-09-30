"""Integral monic S=v^3(B1*z-C1) models and primitive rational scales.
All identities are in the full Laurent coordinate ring; no curve factorization.
"""
from endpoints import *
from univar import *

def remF(a,F):
 r=a.copy()
 for j in range(max((j for i,j in r),default=0),5,-1):
  p={i:c for (i,k),c in r.items() if k==j}
  for i,c in p.items():
   r=psub(r,pshift(pscale(F,c),(i,j-6)))
 return r

def dense_component(a,j):
 p={i:c for (i,k),c in a.items() if k==j};assert not p or min(p)>=0
 return [p.get(i,0) for i in range(max(p,default=-1)+1)]
def content(a):
 g=[]
 for j in range(max((j for i,j in a),default=-1)+1):g=ug(g,dense_component(a,j))
 return g

def exact_div(a,g):
 return pdivide_univ(a,{i:c for i,c in enumerate(g) if c})[0]

def primitive_pair(n,d):
 low=min(i for i,j in list(n)+list(d))
 if low<0:n=pshift(n,(-low,0));d=pshift(d,(-low,0))
 g=ug(content(n),content(d))
 n=exact_div(n,g);d=exact_div(d,g)
 return n,d,g

def substz(f,zn,zd,K):
 ans={}
 for (i,j),c in f.items():
  ans=padd(ans,pshift(pscale(pmul(ppow(zn,j),ppow(zd,K-j)),c),(i,0)))
 return ans

def wd(a):return max((i+6*j for i,j in a),default=-1)

def main():
 ends=json.loads((ROOT/'data'/'endpoint_curves.json').read_text())['endpoints'];mon=json.loads((ROOT/'data'/'monic_charts.json').read_text());out=[]
 for e,mn in zip(ends,mon):
  B0,B1=splitH(loads(e['B']));C0,C1=splitH(loads(e['C']));Delta=loads(e['Delta'])
  beta=pshift(B1,(1,0));chi=pshift(C1,(1,0));S={(0,1):1}
  F={}
  for (i,j),c in loads(mn['monic_equation']).items():F[(i+18-3*j,j)]=c
  assert min(i for i,j in F)>=0 and wd(F)==36 and F[(0,6)]==1
  zn=padd(S,pshift(chi,(2,0)));zd=pshift(beta,(2,0))
  # Validate the curve coordinate substitution, allowing exactly the prescribed B1 unit.
  Gsub=remF(substz(loads(e['G']),zn,zd,6),F)
  assert not Gsub
  Hn=psub(pshift(Delta,(13,0)),pmul(pshift(B0,(10,0)),S));Hd=pshift(pmul(beta,S),(9,0))
  assert not remF(psub(pmul(substz(loads(e['H_numerator']),zn,zd,1),Hd),pmul(substz(loads(e['H_denominator']),zn,zd,1),Hn)),F)
  branches=[]
  for b in e['branches']:
   K=max(j for i,j,c in b['numerator']+b['denominator'])
   nn=substz(loads(b['numerator']),zn,zd,K);dd=substz(loads(b['denominator']),zn,zd,K)
   nn=remF(nn,F);dd=remF(dd,F)
   n,d,removed=primitive_pair(nn,dd)
   assert not remF(psub(pmul(nn,d),pmul(dd,n)),F)
   expected=up(dense_component(beta,0),2 if b['name']=='small' else 3)
   assert removed == monic(expected), 'Only an already-unit beta power may be canceled'
   if b['name']=='small':
    assert max(j for i,j in n)<=4
    target=pshift(pmul(ppow(beta,4),S),(13,0))
    key=next(iter(d))
    assert key in target
    assert pscale(d,inv(d[key])) == pscale(target,inv(target[key])), 'small denominator shape'

   # Record the remaining denominator without localizing its base norm.
   row={'name':b['name'],'numerator':dumps(n),'denominator':dumps(d),'cancelled_univariate_factor':removed,'weighted_numerator_degree':wd(n),'weighted_denominator_degree':wd(d)}
   branches.append(row)
   print(e['r'],b['name'],'n_terms',len(n),'d_terms',len(d),'weights',wd(n),wd(d),'cancel_deg',len(removed)-1,flush=True)
  out.append({'r':e['r'],'variables':['v','S'],'F':dumps(F),'beta':dumps(beta),'chi':dumps(chi),'z_numerator':dumps(zn),'z_denominator':dumps(zd),'H_numerator':dumps(Hn),'H_denominator':dumps(Hd),'branches':branches})
 (ROOT/'data'/'integral_charts.json').write_text(json.dumps(out,separators=(',',':'))+'\n')
 (ROOT/'evidence'/'integral_chart_checks.json').write_text(json.dumps({'endpoints':[e['r'] for e in ends],'monic_weight':36,'coordinate_identity':True,'rational_scale_identities':12,'localizations':'No new localization; canceled v-polynomial factors must be nonzero or their canceled expressions proved regular by the quotient identity. Original denominators remain required.'},indent=2)+'\n')
if __name__=='__main__':main()
