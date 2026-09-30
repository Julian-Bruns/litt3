"""Small geometric structure of the actual derivative trace top rows."""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
D=load(str(root/'actual_derivative_quartic_reduction.sobj'))
R=D['ring'];H,w=R.gens();K=R.base_ring();aa=K.gen()
bb=-(aa^4+2*aa^3+aa^2+2*aa)/(aa^3+aa^2+1)
def dec(n):
 out=K.zero()
 for i in range(4):
  c=n%25;n//=25;out+=(K(c%5)+(c//5)*bb)*aa^i
 return out
a0=sum(dec(c)*w^(3*i) for i,c in enumerate([89654,311173,214299,163299,315361,33043,356725,245794]))
psi=a0+H*w^3*(dec(299833)+dec(232505)*w^3)
units=[H,w,a0,psi,w^3-1,w^3-dec(15383)]
def strip(f):
 powers=[]
 for u in units:
  count=0
  while f:
   q,r=f.quo_rem(u)
   if r:break
   count+=1;f=q
  powers.append(count)
 return f,powers
B=PolynomialRing(K,names=('H','q'));hh,q=B.gens()
def desc(f):
 residue={int(e[1])%3 for e in f.dict()}
 assert len(residue)==1,residue
 rem=next(iter(residue))
 return B({(int(e[0]),int(e[1]-rem)//3):c for e,c in f.dict().items()})
records=[];equations=[]
for i,p in enumerate(D['quartic_leading']):
 f,pows=strip(p);g=desc(f);equations.append(g)
 record={'j':int(i),'unit_powers':list(map(int,pows)),'degrees':list(map(int,g.degrees())),
         'terms':len(g.dict()),'H_residues_mod5':sorted({int(e[0])%5 for e in g.dict()}),
         'q_residues_mod5':sorted({int(e[1])%5 for e in g.dict()})}
 records.append(record)
save({'ring':B,'equations':equations,'source':D},str(root/'actual_top_geometry'))
report={'scope':'quartic leading exceptional equations only','equations':records,'seconds':time.time()-start}
(root/'actual_top_geometry.json').write_text(json.dumps(report,indent=2,default=int)+'\n')
print(json.dumps(report,default=int),flush=True)
