"""Validate full expansion against independent residuals and exact identities."""
from residual import *
import struct,hashlib,time

def run():
 st=time.time();p=ROOT/'build/Rcal.bin';N=struct.unpack('<Q',p.open('rb').read(8))[0]
 lead={};bd=[{}, {}, {}];count=0;keys=set();last=None;bounds=[0,0,0,10**6,-10**6];xstats={}
 with p.open('rb') as f:
  assert struct.unpack('<Q',f.read(8))[0]==N
  while chunk:=f.read(12*65536):
   for key,c in struct.iter_unpack('<qI',chunk):
    assert last is None or key>last
    assert 0<c<QFIELD
    last=key;count+=1
    x=key&1023;h=(key>>10)&63;m=(key>>16)&7;q=key>>19
    bounds=[max(bounds[0],x),max(bounds[1],h),max(bounds[2],m),min(bounds[3],q),max(bounds[4],q)]
    assert h+m<=36
    if x==140:lead[(h,q)]=c
    if h+m==36:
     assert (h,m) in [(36,0),(33,3),(30,6)]
     bd[m//3][(q,x)]=c
 assert count==N
 from symbolic import LP
 psi=LP({(0,i):c for i,c in enumerate(A0) if c})+LP({(1,i):c for i,c in enumerate(A1) if c})
 expect=LP({(9,7):div(mul(2,power(EPS,24)),power(PSISCALE,6))})*psi**3
 assert lead==expect.d
 cert=json.loads((ROOT/'evidence/infinity_boundary.json').read_text())
 for got,n in zip(bd,['A','B','C']):assert got=={(q,x):c for q,x,c in cert[n]}
 rows=[]
 for line in (ROOT/'build/full_evaluations.txt').read_text().splitlines():
  h,w,lam,*got=map(int,line.split());R,d=residual(h,w,lam,True)
  expected=pscale(R,power(power(w,3),13));expected +=[0]*(141-len(expected))
  assert got==expected
  rows.append({'h':h,'w':w,'lambda':lam,'coefficients_compared':141,'F6':d['F6'],'result':'PASS'})
 result={'status':'PASS','coefficient_count':N,'Rcal_sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'bounds_x_H_mu_qmin_qmax':bounds,'exact_checks':['strict sorted monomials and valid K codes','total (H,mu) degree at most 36','complete x-leading coefficient identity','complete highest-total-degree identity'], 'independent_evaluation_checks':rows,'scope':'global polynomial reconstructed by exact arithmetic; evaluations validate implementation, not emptiness or geometric search','seconds':time.time()-st}
 (ROOT/'evidence/full_expansion_checks.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result,sort_keys=True))
if __name__=='__main__':run()
