"""Complete quotient models of endpoint-zero ratio projections.

This module keeps multiplicities. A degree block is a full coprime primary-
multiplicity block, never an isolated finite-field point sample.
"""
import gzip,json,time,sys
from exact import *
from curve_eliminate import remove_support
from branch_geometry import squarefree_blocks
from endpoint_geometry import ENDPOINTS,DEST

def prepare(x,verify=False):
  tic=time.time();geo=json.loads(gzip.open(DEST/f'geometry_{x}.json.gz','rb').read())
  records={}
  for name,pr in geo['projections'].items():
    M=pc(pr['allowed_projection'],inv(pr['allowed_projection'][-1]));oldM=M
    a,b=pr['primitive_linear_remainder'];gg,iv,_=pxgcd(b,M);assert gg==[1],('linear ratio pivot boundary',x,name,len(gg)-1)
    u=prem(pc(pm(a,iv),4),M)
    assert not prem(pa(pa(pm(DATA['b'],pmodpow(u,2,M)),pm(pc(DATA['c'],2),u)),pc(DATA['e'],3)),M)
    vals={'q':[0,1],'d':DATA['d'],'b':DATA['b'],'e':DATA['e'],
      'leading_companion':pa(pp(DATA['c'],2),pm(DATA['b'],DATA['e'])),
      'q10149':[neg(10149),1],'q64426':[neg(64426),1],
      'ordinary_double':prem(pa(pm(DATA['b'],u),DATA['c']),M),
      'u':u,'u24_minus1':ps(pmodpow(u,24,M),[1]),
      'Delta0':json.loads((ROOT/'evidence/ratio_factorizations.json').read_text())['zero_F_projection']['polynomial']}
    vals['F']=prem(pa(pa(pm(DATA['a0'],pmodpow(u,3,M)),pm(DATA['b'],pmodpow(u,2,M))),pa(pm(DATA['c'],u),DATA['e'])),M)
    removed={}
    for key,val in vals.items():
      M,removed[key]=remove_support(M,val)
      if len(removed[key])>1:print('ENDPOINT',x,name,'removed',key,len(removed[key])-1,flush=True)
    M=pc(M,inv(M[-1]));u=prem(u,M)
    blocks=squarefree_blocks(M)
    records[name]={'initial_modulus':oldM,'modulus':M,'u':u,'linear_pivot':b,
      'original_and_inherited_open_values':vals,'removed_support':removed,
      'multiplicity_blocks':{str(m):z for m,z in blocks.items()}}
    print('ENDPOINT',x,name,'length',len(M)-1,'geometric',sum(len(z)-1 for z in blocks.values()),
      'blocks',[(m,len(z)-1) for m,z in blocks.items()],flush=True)
  out={'x_code':x,'projections':records};dest=DEST/f'prepared_{x}.json.gz';payload=json.dumps(out,separators=(',',':')).encode()
  if verify:assert gzip.open(dest,'rb').read()==payload
  else:dest.write_bytes(gzip.compress(payload,mtime=0,compresslevel=9))
  print('ENDPOINT PREPARED',x,'seconds',round(time.time()-tic,3),flush=True)
  return out
if __name__=='__main__':
  args=[int(s) for s in sys.argv[1:] if not s.startswith('--')]
  for x in args or ENDPOINTS:prepare(x,'--verify' in sys.argv)
