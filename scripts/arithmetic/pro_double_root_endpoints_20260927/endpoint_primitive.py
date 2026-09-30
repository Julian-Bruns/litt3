"""Verified primitive-element presentation of the complete quartic scale algebra.

Moment/Cauchy reconstruction uses an exact nondegeneracy certificate, not
probabilistic inference. A successful degree-n recurrence and gcd(h,N)=1
prove that the primitive element generates the whole n-dimensional algebra.
"""
import ctypes as ct,json,gzip,time,sys
from exact import *
from endpoint_geometry import DEST
from fast_arithmetic import library

def generate(x,verify=False):
 tic=time.time();inc=json.loads(gzip.open(DEST/f'incidence_{x}.json.gz','rb').read())
 part=next(p for p in inc['parts'] if p['projection_kind']=='same_sheet' and len(p['gcd'])==5)
 M=part['modulus'];G=part['gcd'];u=part['u'];d=len(M)-1;e=len(G)-1;n=d*e
 assert G[-1]==[1]
 from endpoint_incidence import complete_gcd
 blocks=list(complete_gcd(G,[pc(G[i],i%5) for i in range(1,len(G))],M))
 assert len(blocks)==1 and blocks[0]['gcd']==[[1]],'Scale algebra has nilpotents (method still valid, but must record them)'
 assert pgcd(G[0],M)==[1], 'zero scale requires its explicit localisation'
 l=library('endpoint_tower');IP=ct.POINTER(ct.c_int)
 l.endpoint_tower_moments.argtypes=[IP,ct.c_int,IP,ct.c_int,IP,ct.c_int,IP]
 l.endpoint_berlekamp_massey.argtypes=[IP,ct.c_int,IP]
 gg=[v for p in G[:-1] for v in p+[0]*(d-len(p))];uu=u+[0]*(d-len(u));attempts=[]
 for shift in [1,2,3,4,5,6,7,8,9,10]:
  out=(ct.c_int*(4*n+2))()
  status=l.endpoint_tower_moments((ct.c_int*len(M))(*M),d,(ct.c_int*len(gg))(*gg),e,(ct.c_int*d)(*uu),shift,out);assert status==0
  seq=list(out[:2*n+2]);qseq=list(out[2*n+2:3*n+2]);useq=list(out[3*n+2:4*n+2])
  pol=(ct.c_int*(2*n+3))();degree=l.endpoint_berlekamp_massey((ct.c_int*len(seq))(*seq),len(seq),pol)
  attempts.append({'auxiliary_shift_K_code':shift,'recurrence_degree':degree})
  print('PRIMITIVE',x,'shift',shift,'degree',degree,'target',n,flush=True)
  if degree==n:break
 else:raise RuntimeError('Auxiliary representation search failed; no geometric exclusion follows')
 N=list(pol[:n+1]);assert N[-1]==1
 for j in range(n+2):
  v=0
  for k,a in enumerate(N):v=add(v,mul(a,seq[j+k]))
  assert v==0,('exact recurrence',j)
 def numerator(s):return trim(pm(N,list(reversed(s[:n])))[n:])
 h=numerator(seq);kq=numerator(qseq);ku=numerator(useq)
 g,ih,jh=pxgcd(h,N);assert g==[1]
 qimage=prem(pm(kq,ih),N);uimage=prem(pm(ku,ih),N);nuimage=prem(ps([0,1],pc(qimage,shift)),N)
 assert prem(ps(pm(qimage,h),kq),N)==[] and prem(ps(pm(uimage,h),ku),N)==[]
 assert pgcd(N,pder(N))==[1]
 out={'x_code':x,'dimension':n,'base_modulus':M,'scale_modulus':G,'base_u':u,
      'auxiliary_shift_K_code':shift,'primitive_element':'z=nu+c*q',
      'modulus':N,'q':qimage,'u':uimage,'nu':nuimage,
      'moment_functional':'coefficient of q^(d-1)*nu^(e-1) in the monic tower normal form',
      'moments':seq,'q_moments':qseq,'u_moments':useq,
      'cauchy_numerator':h,'q_cauchy_numerator':kq,'u_cauchy_numerator':ku,
      'cauchy_bezout':[ih,jh],'representation_attempts':attempts,
      'base_and_scale_reduced':True,'nonzero_scale_unit':True,
      'proof':'exact moments + recurrence + h*ih+N*jh=1 imply the complete tower is K[z]/N, and q,u,nu have the displayed images'}
 payload=json.dumps(out,separators=(',',':')).encode();dest=DEST/f'primitive_{x}.json.gz'
 if verify:assert gzip.open(dest,'rb').read()==payload
 else:dest.write_bytes(gzip.compress(payload,mtime=0,compresslevel=9))
 print('COMPLETE QUARTIC ALGEBRA PRESENTED',x,'dimension',n,'seconds',round(time.time()-tic,3),flush=True)
 return out
if __name__=='__main__':
 args=[int(s) for s in sys.argv[1:] if not s.startswith('--')]
 for x in args:generate(x,'--verify' in sys.argv)
