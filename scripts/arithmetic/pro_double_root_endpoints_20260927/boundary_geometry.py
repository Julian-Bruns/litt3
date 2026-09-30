"""Exact coprimality and geometric-coverage checks for the certified divisors."""
from exact import *
import json

def run():
 fac=json.loads((ROOT/'evidence/ratio_factorizations.json').read_text())
 polys={k:v['polynomial'] for k,v in fac.items()}
 b,c,e,a0=[DATA[z] for z in ['b','c','e','a0']]
 polys['triple_pivot']=pc(ps(pp(b,2),pc(pm(a0,c),3)),2)
 polys['old_q64426']=[neg(64426),1]
 checks=[]
 def cert(x,y):
  g,A,B=pxgcd(polys[x],polys[y]);assert g==[1],(x,y,g)
  assert pa(pm(A,polys[x]),pm(B,polys[y]))==[1]
  checks.append({'left':x,'right':y,'A':A,'B':B})
 for x in ['b','e','leading_boundary','zero_F_projection']:
  for y in ['C','a0','d','old_q64426']:cert(x,y)
 for i,x in enumerate(['b','e','leading_boundary','zero_F_projection']):
  for y in ['b','e','leading_boundary','zero_F_projection'][i+1:]:cert(x,y)
 for x,y in [('b','c'),('c','e'),('zero_F_projection','triple_pivot')]:cert(x,y)
 certs=[json.loads(p.read_text()) for p in sorted((ROOT/'evidence').glob('boundary_*.json')) if p.name!='boundary_geometry.json']
 included=[x for x in certs if x.get('status')=='excluded_all_geometric_scales']
 assert len(included)==14,len(included)
 assert sum(x['degree'] for x in included)==65
 assert all([len(p)-1 for p in x['tails']]==[53,54] for x in included)
 expected={'b':5,'e':8,'leading_boundary':14,'leading_companion':14,'zero_F_projection':24}
 for bnd,n in expected.items():assert sum(x['degree'] for x in included if x['boundary']==bnd)==n
 out={'polynomials':polys,'coprimality_certificates':checks,
      'allowed_geometric_ratio_points':65,'certificate_residue_factors':14,'counts':expected,
      'removed_e_root':0}
 (ROOT/'evidence/boundary_geometry.json').write_text(json.dumps(out,separators=(',',':'))+'\n')
 print('25 exact coprimality identities; 14 residue-factor certificates covering 65 allowed geometric ratio points.',flush=True)
if __name__=='__main__':run()
