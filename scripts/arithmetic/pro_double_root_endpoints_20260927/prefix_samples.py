"""Restartable exact global square-prefix generation on complete ratio algebras.
Samples are arithmetic evaluations of a proved bounded-degree global polynomial,
not a finite-field search and not exclusions of selected fibres.
"""
from pathlib import Path
import ctypes as ct,json,gzip,struct,hashlib,time,sys,subprocess,concurrent.futures,os
ROOT=Path(__file__).resolve().parent.parent
FIRST=71;NT=4;W=64;NODES=1375
CACHE=ROOT/'work/prefix_samples'
libpath=ROOT/'src/libtails.so'
_jetbuf=None;_gbuf=None;_lib=None;_nu=None;_ns=None

def prepare():
 if not libpath.exists() or libpath.stat().st_mtime<(ROOT/'src/tail_samples.cpp').stat().st_mtime:
  subprocess.run(['g++','-O3','-std=c++17','-fPIC','-shared',str(ROOT/'src/tail_samples.cpp'),'-o',str(libpath)],check=True)
 if not (ROOT/'evidence/normalized_jets.json.gz').exists():subprocess.run([sys.executable,str(ROOT/'src/normalize_jets.py')],check=True)

def init_worker():
 global _jetbuf,_gbuf,_lib,_nu,_ns
 raw=gzip.open(ROOT/'evidence/normalized_jets.json.gz','rb').read();jets=json.loads(raw)
 _ns=len(jets);_nu=max(len(z)//9 for row in jets for z in row)
 flat=[0]*(_nu*_ns*7*9)
 for n,row in enumerate(jets):
  for ti,z in enumerate(row):
   for k,a in enumerate(z):
    iu,iq=divmod(k,9);flat[((iu*_ns+n)*7+ti)*9+iq]=a
 _jetbuf=(ct.c_int*len(flat))(*flat)
 gs=[0]*30
 for iq,iu,a in json.loads((ROOT/'evidence/global_source.json').read_text())['critical_monic']:gs[3*iq+iu]=a
 _gbuf=(ct.c_int*30)(*gs);_lib=ct.CDLL(str(libpath));IP=ct.POINTER(ct.c_int)
 _lib.prefix_sample.argtypes=[IP,ct.c_int,ct.c_int,IP,ct.c_int,ct.c_int,ct.c_int,ct.c_int,IP]

def sample(arg):
 if isinstance(arg,tuple):u0,fresh=arg
 else:u0,fresh=arg,False
 path=CACHE/f'{u0}.bin.gz';mp=CACHE/f'{u0}.json'
 if path.exists() and mp.exists() and not fresh:
  r=json.loads(mp.read_text());raw=gzip.open(path,'rb').read();assert hashlib.sha256(raw).hexdigest()==r['sha256'];return r
 if _jetbuf is None:init_worker()
 t=time.time();out=(ct.c_int*(NT*W*9))()
 assert _lib.prefix_sample(_jetbuf,_nu,_ns,_gbuf,u0,FIRST,NT,W,out)==0
 raw=struct.pack('<%dI'%len(out),*out)
 deg=[max((i for i in range(W) if any(out[(h*W+i)*9:(h*W+i+1)*9])),default=-1) for h in range(NT)]
 r={'u_code':u0,'sha256':hashlib.sha256(raw).hexdigest(),'scale_degrees':deg,'seconds':round(time.time()-t,4)}
 CACHE.mkdir(parents=True,exist_ok=True);path.write_bytes(gzip.compress(raw,mtime=0));mp.write_text(json.dumps(r,separators=(',',':'))+'\n')
 if u0%50==0:print('PREFIX SAMPLE',u0,deg,r['seconds'],flush=True)
 return r

def main():
 prepare();n=int(sys.argv[1]) if len(sys.argv)>1 and sys.argv[1].isdigit() else NODES
 start=time.time();fresh='--fresh' in sys.argv
 with concurrent.futures.ProcessPoolExecutor(max_workers=4,initializer=init_worker) as pool:
  results=list(pool.map(sample,[(i,fresh) for i in range(n)],chunksize=4))
 out={'first_tail':FIRST,'tail_count':NT,'sample_count':n,'shape_per_sample':[NT,W,9],'sample_type':'complete K[q]/g(q,u0), not pointwise q evaluation','samples':results,'seconds':round(time.time()-start,3)}
 if n==NODES:(ROOT/'evidence/prefix_samples.json').write_text(json.dumps(out,separators=(',',':'))+'\n')
 print('PREFIX SAMPLING COMPLETE',n,'seconds',out['seconds'],flush=True)

if __name__=='__main__':main()
