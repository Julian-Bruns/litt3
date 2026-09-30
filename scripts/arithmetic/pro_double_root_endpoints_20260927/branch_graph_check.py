"""Exact finite-algebra checks for rational-scale branch incidence graphs."""
import ctypes as ct,json,gzip,struct,subprocess,hashlib,time,sys,os
from exact import ROOT,DATA,pgcd,pxgcd,pm,pa,prem,trim

def library():
 p=ROOT/'src/libfinitenorm.so';s=ROOT/'src/finite_norm.cpp';f=ROOT/'src/field.cpp'
 if not p.exists() or p.stat().st_mtime<max(s.stat().st_mtime,f.stat().st_mtime):
  tmp=p.with_name(p.name+'.'+str(os.getpid())+'.tmp')
  subprocess.run(['g++','-O3','-std=c++17','-fPIC','-shared',str(s),'-o',str(tmp)],check=True)
  os.replace(tmp,p)
 l=ct.CDLL(str(p));l.ff_init();IP=ct.POINTER(ct.c_int)
 l.finite_norm_tails.argtypes=[IP,ct.c_int,IP,ct.c_int,IP,IP,IP,IP,IP]
 return l

def run(x,verify=False):
 start=time.time();d=json.loads(gzip.open(ROOT/'evidence/branch_root'/f'geometry_x_{x}.json.gz','rb').read())['finite'];M=d['scale_graph_modulus'];n=len(M)-1
 raw=gzip.open(ROOT/'evidence/norm_element.bin.gz','rb').read();a=struct.unpack('<%dI'%(len(raw)//4),raw)
 u=prem(d['u'],M);nu=d['nu'];u=u+[0]*(n-len(u));nu=nu+[0]*(n-len(nu))
 N=(ct.c_int*(141*n))();tails=(ct.c_int*(2*n))();l=library()
 status=l.finite_norm_tails((ct.c_int*len(a))(*a),45,(ct.c_int*len(M))(*M),n,(ct.c_int*n)(*u),(ct.c_int*n)(*nu),(ct.c_int*11)(*DATA['P']),N,tails)
 assert status==0,status
 tt=[trim(list(tails[i*n:(i+1)*n])) for i in range(2)]
 g,s,t=pxgcd(tt[0],M);print('root',x,'first tail gcd degree',len(g)-1,flush=True)
 if g!=[1]:
  g2,a,b=pxgcd(g,tt[1]);assert g2==[1],('two tails unresolved',len(g2)-1)
  coefs=[pm(a,s),b,pm(a,t)]
 else:coefs=[s,[],t]
 assert pa(pa(pm(coefs[0],tt[0]),pm(coefs[1],tt[1])),pm(coefs[2],M))==[1]
 out={'x_code':x,'status':'entire_scale_graph_excluded_including_nilpotents',
      'modulus':M,'degree':n,'u':trim(u),'nu':trim(nu),
      'norm_definition':'N=Norm(Theta(q,u,tau=q^2*nu)); N=q^4*Rtilde',
      'actual_norm_sha256':hashlib.sha256(struct.pack('<%dI'%len(N),*N)).hexdigest(),
      'tails_71_72':tt,'bezout_tail71_tail72_modulus':coefs,
      'identity':'s*tail71+t*tail72+h*M=1',
      'normalization':'C=(T^140*N(T^-1)/[x^140]N)^63 mod T^73'}
 dest=ROOT/'evidence/branch_root'/f'graph_x_{x}.json.gz';dest.parent.mkdir(parents=True,exist_ok=True);payload=json.dumps(out,separators=(',',':')).encode()
 if verify:assert gzip.open(dest,'rb').read()==payload
 else:dest.write_bytes(gzip.compress(payload,mtime=0,compresslevel=9))
 print('FULL BRANCH GRAPH EXCLUDED',x,'algebra length',n,'seconds',round(time.time()-start,3),flush=True)
 return out
if __name__=='__main__':run(int(sys.argv[1]) if len(sys.argv)>1 else 14,'--verify' in sys.argv)
