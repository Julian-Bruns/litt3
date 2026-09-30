"""Independent extension-polynomial Bezout witnesses for endpoint incidences."""
import json,gzip,time,sys
from exact import *
from endpoint_geometry import ENDPOINTS,DEST
from endpoint_incidence import coefficient_jets,evaluate
from extension import init,E,Poly

def run(x,verify=False):
 tic=time.time();data=json.loads(gzip.open(DEST/f'incidence_{x}.json.gz','rb').read());raw=coefficient_jets(x);out=[]
 for idx,part in enumerate(data['parts']):
  M=part['modulus'];d=len(M)-1;u=part['u'];vals=evaluate(raw,M,u)
  init(M);F=Poly([E(c) for c in vals[:4]]);G=Poly([E(c) for c in vals[4:]])
  H,S,T=F.xgcd(G);assert H==Poly([E(c) for c in part['gcd']])
  assert S*F+T*G==H
  if H:assert not (F%H) and not (G%H)
  out.append({'part_index':idx,'modulus':M,'F':[trim(c) for c in F.records()],
   'G':[trim(c) for c in G.records()],'H':[trim(c) for c in H.records()],
   'S':[trim(c) for c in S.records()],'T':[trim(c) for c in T.records()],
   'identity':'S*F+T*G=H; H divides both F and G',
   'no_nonunit_pivot':True})
  print('ENDPOINT SCALE GCD WITNESS',x,idx,'base degree',d,'gcd degree',H.degree(),flush=True)
 obj={'x_code':x,'records':out};payload=json.dumps(obj,separators=(',',':')).encode();dest=DEST/f'gcd_witnesses_{x}.json.gz'
 if verify:assert gzip.open(dest,'rb').read()==payload
 else:dest.write_bytes(gzip.compress(payload,mtime=0,compresslevel=9))
 print('INDEPENDENT SCALE GCD WITNESSES BUILT',x,'seconds',round(time.time()-tic,3),flush=True)
 return obj
if __name__=='__main__':
 args=[int(s) for s in sys.argv[1:] if not s.startswith('--')]
 for x in args or ENDPOINTS:run(x,'--verify' in sys.argv)
