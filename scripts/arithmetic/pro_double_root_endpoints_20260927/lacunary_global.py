"""Construct an exact identity in the central coefficients of Rstar.
This is not a square-locus decision. A successful identity rules out a
125-fold geometric root, globally and without a finite-field restriction.
"""
import sys,json,gzip,struct,ctypes as ct,time,hashlib
from exact import ROOT,DATA
from ratio_eliminant_data import load
from fast_arithmetic import library

def run(verify=False):
 meta,raw=load();lib=library('lacunary_module');IP=ct.POINTER(ct.c_int)
 lib.lacunary_certificate.argtypes=[IP,ct.c_int,IP,ct.c_int,IP,ct.c_int,IP]
 src=json.loads((ROOT/'evidence/global_source.json').read_text());g=[0]*30
 for iq,iu,a in src['critical_monic']:g[iq*3+iu]=a
 cap=8192;out=(ct.c_int*(109*9*cap))();stats=(ct.c_int*10)();stats[8:10]=DATA['d'];start=time.time()
 status=lib.lacunary_certificate((ct.c_int*len(raw))(*raw),133,(ct.c_int*30)(*g),40,out,cap,stats)
 print('LACUNARY STATUS',status,'stats',list(stats),'seconds',time.time()-start,flush=True)
 if status:return None
 done,reds,dp,md,events,nz=list(stats)[:6]
 cert=[]
 for i in range(done):
  p=list(out[i*cap:i*cap+md+1])
  while p and p[-1]==0:p.pop()
  if p:cert.append({'x':16+i//9,'q_power':i%9,'u_coefficients':p})
 rec={'status':'constructed_identity_requires_independent_check','identity':'sum C_i(u) q^j [x^i]Rstar(nu,x)=d(q)^e modulo g','d_power':dp,'source_sha256':meta['raw_sha256'],'central_indices':[16,124],'scale_arbitrary':True,'stats':{'rows_processed':done,'reductions':reds,'max_u_degree':md,'events':events,'nonzero_rows':len(cert),'stored_slots':nz},'certificate':cert}
 dest=ROOT/'evidence/lacunary_global.json.gz';data=json.dumps(rec,separators=(',',':')).encode()
 if verify:assert gzip.open(dest,'rb').read()==data
 else:dest.write_bytes(gzip.compress(data,mtime=0,compresslevel=9))
 return rec
if __name__=='__main__':run('--verify' in sys.argv)
