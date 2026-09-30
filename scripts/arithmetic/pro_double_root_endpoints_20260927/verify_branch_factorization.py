"""Independent GLOBAL factorization of the actual residual at every P-root.
This evaluates all seven scale coefficients of Rstar as rank-nine polynomials,
not at sampled ratio or scale values. It checks
  Rstar(a)=q^e*(q-droot)^f*p_a(nu)^3
for each branch, and hence Res_x(P,Rstar)=q^98*(q-droot)^84*Lambda^3.
"""
from exact import *
import rank9 as R
from branch_geometry import ROOTS
from verify_branch_geometry import unit_element
from ratio_eliminant_data import load
from interpolate_global import library
import ctypes as ct,gzip,json,time

def run():
 tic=time.time();meta,raw=load();N=133;NS=7;NX=141;D=9;count=N*NS*D
 # The point-evaluation helper acts only in the fixed coefficient field K.
 flat=[raw[((i*NS+s)*NX+x)*D+j] for x in range(NX) for i in range(N) for s in range(NS) for j in range(D)]
 inp=(ct.c_int*len(flat))(*flat);out=(ct.c_int*count)();lib=library();records=[]
 powers={'q':0,'d_monic':0,'u':0}
 for x in ROOTS:
  lib.ff_evaluate_rows(inp,NX,count,x,out)
  actual=[R.from_flat(out,N,NS,s) for s in range(NS)]
  geo=json.loads(gzip.open(ROOT/'evidence/branch_root'/f'geometry_x_{x}.json.gz','rb').read())
  c=geo['components']['components'][0];p=c['nu_coefficients'];fac={k:3*v for k,v in c['stripped_common_units'].items()};fac['q']-=52
  assert min(fac.values())>=0
  cube=[R.zero() for _ in range(7)]
  for i in range(3):
   for j in range(3):
    for k in range(3):cube[i+j+k]=R.plus(cube[i+j+k],R.times(R.times(p[i],p[j]),p[k]))
  unit=unit_element(fac)
  assert all(actual[s]==R.times(unit,cube[s]) for s in range(7))
  for name in powers:powers[name]+=fac[name]
  records.append({'x_code':x,'scale_coefficients_checked':7,'unit_powers':fac,
                  'ratio_parameters':'global rank-nine polynomials; not specialized'})
  print('GLOBAL ACTUAL BRANCH FACTORIZATION',x,fac,flush=True)
 assert powers=={'q':98,'d_monic':84,'u':0}
 r={'status':'passed','global_factorizations':records,'identity':'Res_x(P,Rstar)=q^98*(q-droot)^84*Lambda^3',
    'residual_scale_degree_of_resultant':57,'source_array_sha256':meta['raw_sha256'],
    'no_ratio_or_scale_sampling':True,'seconds':round(time.time()-tic,3)}
 (ROOT/'logs/branch_global_factorization.json').write_text(json.dumps(r,indent=2)+'\n')
 print('EXACT GLOBAL RESULTANT FACTORIZATION VERIFIED',r['seconds'],flush=True)
 return r
if __name__=='__main__':run()
