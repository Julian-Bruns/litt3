"""Independent sparse-polynomial verification of the complete J-boundary certificates."""
from integral_chart import *
import argparse

def main():
 records=json.loads((ROOT/'data'/'J_algebras.json').read_text());summary=[]
 for row in records:
  f=row['v_modulus'];a={(i,0):c for i,c in enumerate(row['S_relation_a']) if c};b={(i,0):c for i,c in enumerate(row['S_relation_b']) if c}
  def red(p):
   p=p.copy()
   for j in range(max((j for i,j in p),default=-1),4,-1):
    terms=[(i,c) for (i,k),c in p.items() if k==j]
    for i,c in terms:
     p.pop((i,j),None)
     p=psub(p,pshift(pscale(a,c),(i,j-4)))
     p=psub(p,pshift(pscale(b,c),(i,j-5)))
   return pdivide_univ(p,{i:c for i,c in enumerate(f) if c},strict=False)[1]
  def addp(x,y):return padd(x,y)
  def mult(x,y):return red(pmul(x,y))
  def pw(x,n):
   r={(0,0):1}
   while n:
    if n&1:r=mult(r,x)
    n//=2
    if n:x=mult(x,x)
   return r
  def decode(rr):return {(i%6,i//6):c for i,c in enumerate(rr) if c}
  one={(0,0):1};v={(1,0):1};S={(0,1):1}
  assert not red(loads(row['integral_chart']['F']))
  source=(ROOT/'evidence'/f"J_tails_{row['r']}.txt").read_text().splitlines();assert source[0]==f"r {row['r']} dimension 30"
  base={};branches=[];current=base
  for line in source[1:]:
   bits=line.split()
   if bits[0]=='branch':current={'index':int(bits[1])};branches.append(current)
   else:
    assert len(bits)==31
    current[bits[0]]=decode(list(map(int,bits[1:])))
  assert len(branches)==4
  ch=row['integral_chart'];hn=red(loads(ch['H_numerator']));hd=red(loads(ch['H_denominator']))
  assert mult(base['H'],hd)==hn
  endpoint=next(e for e in json.loads((ROOT/'data'/'endpoint_curves.json').read_text())['endpoints'] if e['r']==row['r'])
  assert mult(base['q'],pw(v,3))=={(0,0):endpoint['P_r']}
  q=base['q'];H=base['H'];a0={}
  for c in reversed([89654,311173,214299,163299,315361,33043,356725,245794]):a0=padd(mult(a0,q),{(0,0):c})
  a1=mult(q,padd({(0,0):299833},pscale(q,232505)));psi=padd(a0,mult(a1,H))
  beta=red(loads(ch['beta']));delta=red(loads(row['delta_polynomial']))
  op=one
  for u in [v,S,beta,delta,H,q,psi,psub(q,one),psub(q,{(0,0):15383}),a0]:op=mult(op,u)
  assert op==base['base_open'] and mult(op,base['base_open_inverse'])==one
  for br,bch in zip(branches,ch['branches']):
   n=red(loads(bch['numerator']));d=red(loads(bch['denominator']))
   assert mult(br['mu'],d)==n
   assert mult(d,br['mu'])==br['branch_open']
   assert mult(br['branch_open'],br['branch_open_inverse'])==one
   assert padd(mult(br['C71'],br['U']),mult(br['C72'],br['V']))==one
   assert not br['V'], 'First-tail inverse claim requires V=0'
   print('r',row['r'],'branch',br['index'],'full_algebra_dimension',30,'C71_INVERSE=PASS OPENS=PASS',flush=True)
  summary.append({'r':row['r'],'algebra_dimension':30,'branches':4,'base_and_scale_open_units':True,'source_coordinate_identities':True,'tail_unit_certificates':4,'C71_alone_is_unit':True,'verification':'independent Python sparse ideal reduction'})
 (ROOT/'evidence'/'J_verification.json').write_text(json.dumps(summary,indent=2)+'\n')
if __name__=='__main__':main()
