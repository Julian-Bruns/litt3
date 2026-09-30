"""Reconstruct every branch-incidence polynomial and its complete finite model.
All field elements x tested here are the TEN roots of the fixed P, not a
bounded search for the unknown ratio or scale. The source root stays r=9.
"""
from exact import *
import rank9 as R
from branch_root import extract,strip,weight,ud
from curve_eliminate import projection,remove_support
from factor import factor
import gzip,json,hashlib,time,sys
ROOTS=[14,9,2514,7367,20130,364472,281660,154113,139659,104315]

def squarefree_blocks(p):
 """Exact multiplicity decomposition over perfect K, without root restriction."""
 p=pc(p,inv(p[-1]));g=pgcd(p,pder(p));w=pexact(p,g);i=1;out={}
 while len(w)>1:
  y=pgcd(w,g);z=pexact(w,y)
  if len(z)>1:out[i]=z
  w=y;g=pexact(g,y);i+=1
 if len(g)>1:
  assert not pder(g)
  root=[power(g[j],5**7) for j in range(0,len(g),5)]
  for m,z in squarefree_blocks(root).items():out[5*m]=pm(out.get(5*m,[1]),z)
 product=[1]
 for m,z in out.items():
  assert pgcd(z,pder(z))==[1]
  product=pm(product,pp(z,m))
 assert product==p
 zs=list(out.values())
 assert all(pgcd(zs[i],zs[j])==[1] for i in range(len(zs)) for j in range(i))
 return out

def run(x,verify=False):
 tic=time.time();assert x in ROOTS and peval(DATA['P'],x)==0 and DATA['r']==9
 base=ROOT/'work/branch_root' if x==9 else ROOT/'work/branch_root'/f'x_{x}'
 base.mkdir(parents=True,exist_ok=True)
 jets=extract(x);components=[]
 for j,p in enumerate(jets):
  primitive,powers=strip(p)
  components.append({'V_degree':j,'stripped_common_units':powers,'nu_coefficients':primitive})
 data={'x_code':x,'fixed_source_r_code':9,'scale':'tau=q^2*nu','components':components,
       'actual_norm_array_sha256':hashlib.sha256(gzip.open(ROOT/'evidence/norm_element.bin.gz','rb').read()).hexdigest()}
 (base/'data.json').write_text(json.dumps(data,separators=(',',':'))+'\n')
 if x==9:
  p0,p1,p2=components[0]['nu_coefficients'];g0,g1,g2=components[1]['nu_coefficients']
  assert p2==g2==R.zero()
  det=R.minus(R.times(p1,g0),R.times(p0,g1));h,powers=strip([det]);h=h[0]
  units=pm(pm([0,1],DATA['d']),DATA['b']);pr=projection(h,units)
  assert len(remove_support(pr['content'],units)[0])==1
  assert pgcd(pr['primitive_linear_remainder'][1],pr['allowed_projection'])==[1]
  pr.update({'determinant':h,'determinant_unit_powers':powers,'units_used_to_remove':units})
  (base/'projection.json').write_text(json.dumps(pr,separators=(',',':'))+'\n')
  from branch_prepare import run as prepare
  fin=prepare();fin['factors']=factor(fin['modulus'])
  (base/'factored.json').write_text(json.dumps(fin,separators=(',',':'))+'\n')
  profile={}
  for f,m in fin['factors']:profile[m]=profile.get(m,0)+len(f)-1
  counts={'ratio_algebra_length':len(fin['modulus'])-1,'geometric_ratio_points':sum(profile.values()),
          'multiplicity_degree_profile':profile,'all_scale_certificates':len(fin['factors'])}
 else:
  from branch_other_projection import run as project
  from branch_prepare_generic import run as prepare
  pr=project(x);assert len(remove_support(pr['content'],pr['units_used_to_remove'])[0])==1
  fin=prepare(x);assert fin['scale_pivot_boundary_modulus']==[1],('unexcluded scale pivot boundary',x)
  blocks=squarefree_blocks(fin['scale_graph_modulus'])
  fin['squarefree_blocks']={str(k):v for k,v in blocks.items()}
  counts={'initial_ratio_algebra_length':len(fin['initial_modulus'])-1,
          'nonzero_scale_graph_length':len(fin['scale_graph_modulus'])-1,
          'zero_scale_removed_length':len(fin['excluded_zero_scale_factor'])-1,
          'scale_pivot_boundary_length':len(fin['scale_pivot_boundary_modulus'])-1,
          'geometric_scale_graph_points':sum(len(p)-1 for p in blocks.values()),
          'multiplicity_degree_profile':{m:len(p)-1 for m,p in blocks.items()}}
 out={'x_code':x,'fixed_source_r_code':9,'components':data,'projection':pr,'finite':fin,
      'counts':counts,'no_extra_unchecked_localization':True}
 dest=ROOT/'evidence/branch_root'/f'geometry_x_{x}.json.gz';dest.parent.mkdir(parents=True,exist_ok=True)
 payload=json.dumps(out,separators=(',',':')).encode()
 if verify:assert gzip.open(dest,'rb').read()==payload
 else:dest.write_bytes(gzip.compress(payload,mtime=0,compresslevel=9))
 print('COMPLETE BRANCH GEOMETRY',x,counts,'seconds',round(time.time()-tic,3),flush=True)
 return out
if __name__=='__main__':
 p=[1]
 for x in ROOTS:p=pm(p,[neg(x),1])
 assert p==DATA['P'] and len(set(ROOTS))==10
 args=[int(a) for a in sys.argv[1:] if not a.startswith('--')]
 for x in args or ROOTS:run(x,'--verify' in sys.argv)
