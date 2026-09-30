"""Actual norm and all-scale-incidence exclusion on a finite endpoint graph.

The first two actual square tails are necessary for the full 70-equation
square system. A Bezout identity involving either tail excludes that full
system on this whole finite algebra. These are not finite-field searches.
"""
import ctypes as ct,json,gzip,struct,hashlib,time,sys
from exact import *
from endpoint_geometry import DEST
from fast_arithmetic import library

def check_graph(x,index,verify=False):
 data=json.loads(gzip.open(DEST/f'incidence_{x}.json.gz','rb').read());part=data['parts'][index]
 assert 'unique_scale_root' in part and part['unique_scale_root'] is not None
 M=part['nonzero_scale_modulus'];assert len(M)>1
 u=prem(part['u'],M);nu=prem(part['nu'],M)
 return check(x,str(index),M,u,nu,verify,
     {'incidence_part_index':index,'projection_kind':part['projection_kind'],
      'projection_multiplicity':part['projection_multiplicity'],'scale_root_multiplicity':part['scale_root_multiplicity']})

def check(x,label,M,u,nu,verify=False,dependency=None,qimage=None):
 start=time.time();n=len(M)-1
 raw=gzip.open(ROOT/'evidence/norm_element.bin.gz','rb').read();a=struct.unpack('<%dI'%(len(raw)//4),raw)
 u=prem(u,M);nu=prem(nu,M);uu=u+[0]*(n-len(u));vv=nu+[0]*(n-len(nu))
 N=(ct.c_int*(141*n))();tails=(ct.c_int*(2*n))()
 if qimage is None:
  l=library();status=l.finite_norm_tails((ct.c_int*len(a))(*a),45,(ct.c_int*len(M))(*M),n,(ct.c_int*n)(*uu),(ct.c_int*n)(*vv),(ct.c_int*11)(*DATA['P']),N,tails)
 else:
  l=library('finite_norm_image');IP=ct.POINTER(ct.c_int)
  l.finite_image_norm_tails.argtypes=[IP,ct.c_int,IP,ct.c_int,IP,IP,IP,IP,IP,IP]
  qimage=prem(qimage,M);qq=qimage+[0]*(n-len(qimage))
  status=l.finite_image_norm_tails((ct.c_int*len(a))(*a),45,(ct.c_int*len(M))(*M),n,(ct.c_int*n)(*qq),(ct.c_int*n)(*uu),(ct.c_int*n)(*vv),(ct.c_int*11)(*DATA['P']),N,tails)
 assert status==0,status
 tt=[trim(list(tails[i*n:(i+1)*n])) for i in range(2)]
 g,s,t0=pxgcd(tt[0],M);print('ENDPOINT',x,label,'first tail gcd degree',len(g)-1,flush=True)
 if g!=[1]:
  g2,aa,bb=pxgcd(g,tt[1]);assert g2==[1],('two tails unresolved',len(g2)-1)
  coefs=[pm(aa,s),bb,pm(aa,t0)]
 else:coefs=[s,[],t0]
 assert pa(pa(pm(coefs[0],tt[0]),pm(coefs[1],tt[1])),pm(coefs[2],M))==[1]
 out={'x_code':x,'label':label,'status':'entire_finite_incidence_algebra_excluded',
      'modulus':M,'degree':n,'u':u,'nu':nu,'dependency':dependency,
      'norm_definition':'N=Norm(Theta(q,u,tau=q^2*nu)); N=q^4*Rtilde',
      'actual_norm_sha256':hashlib.sha256(struct.pack('<%dI'%len(N),*N)).hexdigest(),
      'tails_71_72':tt,'bezout_tail71_tail72_modulus':coefs,
      'identity':'s*tail71+t*tail72+h*M=1',
      'normalization':'C=(T^140*N(T^-1)/[x^140]N)^63 mod T^73'}
 if qimage is not None:out['q']=qimage
 payload=json.dumps(out,separators=(',',':')).encode();dest=DEST/f'certificate_{x}_{label}.json.gz'
 if verify:assert gzip.open(dest,'rb').read()==payload
 else:dest.write_bytes(gzip.compress(payload,mtime=0,compresslevel=9))
 print('ENDPOINT FINITE ALGEBRA EXCLUDED',x,label,'length',n,'seconds',round(time.time()-start,3),flush=True)
 return out
if __name__=='__main__':
 x=int(sys.argv[1]);label=sys.argv[2]
 if label=='quartic':
  p=json.loads(gzip.open(DEST/f'primitive_{x}.json.gz','rb').read())
  check(x,label,p['modulus'],p['u'],p['nu'],'--verify' in sys.argv,{'primitive_presentation':f'primitive_{x}.json.gz','covers_complete_quartic_scale_algebra':True},p['q'])
 else:check_graph(x,int(label),'--verify' in sys.argv)
