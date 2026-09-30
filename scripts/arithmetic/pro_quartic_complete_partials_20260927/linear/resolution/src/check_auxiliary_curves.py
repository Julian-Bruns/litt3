"""Exact certificates for the three global infinity-factor curves.

Irreducible specializations are certificates for the AUXILIARY cubic curves,
not searches for points of the source square locus.
"""
from __future__ import annotations
import json,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path[:0]=[str(ROOT/'src'),str(ROOT/'intersection/src')]
import field as F,poly as U
from critical_cover import xgcd
F.init()

def powmod(a,n,f):
 b=[1]
 while n:
  if n&1:b=U.rem(U.mul(b,a),f)
  n//=2
  if n:a=U.rem(U.mul(a,a),f)
 return b

def main():
 if sys.flags.optimize:raise RuntimeError('Assertions must be enabled')
 D=json.loads((ROOT/'resolution/data/critical_coordinates.json').read_text())
 cf=D['cubic_f'];a0,d,b,c,e=[cf[k] for k in ['a0','d','b','c','e']]
 out=[]
 for j,row in enumerate(D['special_cubics']):
  s=row['s_K_code'];a=U.sub(a0,U.scale(d,s));disc=row['discriminant_q_ascending']
  gd,sd,td=xgcd(disc,U.deriv(disc));assert gd==[1]
  ga,sa,ta=xgcd(disc,a);assert ga==[1]
  certificate=None
  tried=[]
  for q in range(1,101):
   av=U.evalp(a,q)
   if not av:continue
   f=U.scale([U.evalp(p,q) for p in [e,c,b,a]],F.inv(av))
   frob_rem=powmod([0,1],F.ORDER,f)
   linear_test=U.sub(frob_rem,[0,1])
   g,u,v=xgcd(f,linear_test)
   tried.append(q)
   if g==[1]:
    assert U.add(U.mul(u,f),U.mul(v,linear_test))==[1]
    certificate={'q_K_code':q,'monic_cubic_u_ascending':f,
       'u_to_field_order_mod_f':frob_rem,'bezout_u':u,'bezout_v':v,
       'bezout_identity':'bezout_u*f+bezout_v*(u^390625-u mod f)=1',
       'tested_q_codes_until_certificate':tried}
    break
  if certificate is None:raise RuntimeError('Bounded auxiliary irreducibility test found no certificate')
  assert len(a)==2 and a[-1] and b[-1] and e[-1]
  # Distinct nonzero leading roots at q=infinity: one large branch,
  # and a quadratic with no zero or repeated root.
  large=F.neg(F.div(b[-1],a[-1]))
  quadratic=[e[-1],0,b[-1]]
  assert U.gcd(quadratic,U.deriv(quadratic))==[1]
  # All three original cubic factors have full degree on the completed fibre.
  q_completed=64426
  at_completed=[U.evalp(p,q_completed) for p in [e,c,b,a]]
  assert at_completed[-1] and U.evalp(disc,q_completed)
  out.append({'index':j,'s_K_code':s,
    'squarefree_discriminant_certificate':{'s':sd,'t':td,'identity':'s*D+t*Dprime=1'},
    'discriminant_leading_coefficient_coprimality':{'s':sa,'t':ta,'identity':'s*D+t*a=1'},
    'irreducibility_certificate':certificate,
    'infinity_branches':{'pole_orders_u':[4,2,2],'large_branch_leading':large,'two_small_leading_roots_polynomial':quadratic,'all_three_unramified':True},
    'completed_q_full_degree':True,'completed_q_discriminant_nonzero':True,
    'proved_geometry':{'geometrically_irreducible':True,'geometric_monodromy':'S3','finite_simple_branch_values':24,'genus':10,'affine_projective_root_model_smooth':True},
    'proof_location':'REPORT.md Sections 4 and 5; arithmetic checks alone are not asserted to be the entire proof.'})
 # These disjointness checks are useful audit data; no extra geometric theorem
 # about the compositum is claimed or needed.
 pair_gcds=[]
 for i in range(3):
  for j in range(i):
   g=U.gcd(D['special_cubics'][i]['discriminant_q_ascending'],D['special_cubics'][j]['discriminant_q_ascending'])
   pair_gcds.append({'indices':[j,i],'monic_gcd':g})
 result={'scope':'Three auxiliary ratio curves, not square residuals. No new q fibre is excluded.',
    'curves':out,'pair_discriminant_gcds':pair_gcds,
    'global_resultant_multiplicity_statement':{'claim':'min(v_C(F12),v_C(F13))=5 for each of the three infinity-factor curves',
      'dependencies':['previous universal fifth-power divisibility','accepted completed-fibre gcd p^5','geometric irreducibility and full-degree completed specializations above'],
      'large_resultants_recomputed':False},
    'square_locus_decision':'UNRESOLVED'}
 (ROOT/'resolution/data/auxiliary_curves.json').write_text(json.dumps(result,indent=2)+'\n')
 print(json.dumps({'status':'PASS','auxiliary_irreducible_fibre_q_codes':[r['irreducibility_certificate']['q_K_code'] for r in out],
  'three_geometric_monodromy_groups':['S3']*3,'three_genera':[10]*3,'simple_branch_values_each':24,
  'resultant_multiplicity':'exactly 5 along each curve, using the accepted fibre input',
  'main_square_decision':'UNRESOLVED'},indent=2))
if __name__=='__main__':main()
