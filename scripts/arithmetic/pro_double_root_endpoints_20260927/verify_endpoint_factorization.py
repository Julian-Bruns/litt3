"""Independent global check of Omega, using all scale coefficients and a
proved normal-form degree bound. This is not a finite ratio search.
"""
import ctypes as ct,json,gzip,hashlib,struct,time
from exact import *
from endpoint_geometry import DEST
from branch_root import weight,ud
from fast_arithmetic import library

def run():
 tic=time.time();obj=json.loads(gzip.open(DEST/'boundary_factor.json.gz','rb').read())
 factors=obj['factors'];polys=obj['nu_coefficients']+[z for f in factors for z in f['nu_coefficients']]
 assert len(polys)==22 and obj['nu_degree']==9
 bound=max(max(weight(p) for p in polys[:10]),sum(max(weight(v) for v in f['nu_coefficients']) for f in factors))
 nodes=bound//2+1;rows=max(max(map(len,z)) for z in polys)
 ar=[p[j][i] if i<len(p[j]) else 0 for i in range(rows) for p in polys for j in range(9)]
 src=json.loads((ROOT/'evidence/global_source.json').read_text());gq=[0]*30
 for q,u,a in src['critical_monic']:assert q+2*u<=9;gq[q*3+u]=a
 l=library('endpoint_factorization');IP=ct.POINTER(ct.c_int);l.endpoint_factor_checks.argtypes=[IP,ct.c_int,IP,ct.c_int,IP]
 out=(ct.c_int*(nodes*90))();status=l.endpoint_factor_checks((ct.c_int*len(ar))(*ar),rows,(ct.c_int*30)(*gq),nodes,out);assert status==0,status
 rec={'status':'passed','identity_weight_bound':bound,'identity_u_degree_bound':nodes-1,
      'distinct_complete_u_algebras_verified':nodes,'all_scale_coefficients':10,
      'output_sha256':hashlib.sha256(struct.pack('<%dI'%len(out),*out)).hexdigest(),
      'independence':'evaluated complete quotient algebras and scale-polynomial products, not the global rank-nine polynomial multiplication used for construction',
      'seconds':round(time.time()-tic,3)}
 (ROOT/'logs/endpoint_factorization_independent.json').write_text(json.dumps(rec,indent=2)+'\n')
 print('INDEPENDENT EXPANDED ENDPOINT PRODUCT VERIFIED',nodes,'complete algebras; seconds',rec['seconds'],flush=True)
 return rec
if __name__=='__main__':run()
