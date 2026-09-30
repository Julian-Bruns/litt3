import sys,json,time
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'src'));sys.path.insert(0,str(ROOT/'continuation'))
import field as F,poly as U,evaluate as E,explore_scale as S
start=time.time();r=S.getR(1,1); ar=r[::-1]
a2=S.bmul(ar,ar,125);a3=S.bmul(a2,ar,125)
f5=[U.frob(a2[i//5]) if i%5==0 else [] for i in range(125)]
f25=[U.frob(a2[i//25],2) if i%25==0 else [] for i in range(125)]
c=S.bmul(S.bmul(a3,f5,125),f25,125)
for i in range(71,81):
 a=c[i];v=next(j for j,x in enumerate(a) if x);g=U.gcd(a,U.deriv(a));
 print(i,'deg',len(a)-1,'valuation',v,'gcd_deriv',len(g)-1,flush=True)
print('gcd tails 71,72,73',U.gcd(U.gcd(c[71],c[72]),c[73]),'seconds',time.time()-start)
