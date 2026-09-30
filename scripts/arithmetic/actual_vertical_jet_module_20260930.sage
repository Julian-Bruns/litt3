"""New universal vertical-jet test from the accepted affine source module.

Uses existing source basis data; does not reconstruct its settled constraints.
The new theorem forces three jets of the three derivative coefficients.
This script first records the exact module and its generic rank.
"""
import sys,json,time
from pathlib import Path
st=time.time(); src=Path(sys.argv[1]); out=Path(sys.argv[2]); out.mkdir(parents=True,exist_ok=True)
d=json.loads(src.read_text())
F5=GF(5); Z=PolynomialRing(F5,'z'); z=Z.gen()
K=GF(5**8,'a',modulus=z**8+z**6+2*z**3+4*z**2+2*z+2); a=K.gen()
beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def dec(n):
 n=int(n); v=K.zero()
 for i in range(4):
  c=n%25;n//=25;v+=(K(c%5)+K(c//5)*beta)*a**i
 return v
PX=PolynomialRing(K,'x'); x=PX.gen(); P=PX(list(map(dec,d['P']))); B=PX(list(map(dec,d['B0'])))
slots=d['slots']; vectors=[]
for case in d['cases'][:2]:
 vectors += [[dec(c) for c in row] for row in case['split']+case['kernel']]
base=matrix(K,vectors).row_space().basis(); print('unrestricted dimension',len(base),flush=True)
assert len(base)==8
def zero():return [PX.zero() for j in range(3)]
def add(u,v):return [u[j]+v[j] for j in range(3)]
def scale(u,c):return [c*f for f in u]
def mul(u,v):
 w=zero()
 for i in range(3):
  for j in range(3):
   w[(i+j)%3]+=u[i]*v[j]*(P if i+j>=3 else 1)
 return w
def divy(u,n):
 w=zero()
 for j in range(3):
  k=j-n; r=k%3; m=(k-r)//3
  if m<0:
   w[r],rem=u[j].quo_rem(P**(-m)); assert not rem
  else:w[r]=u[j]*P**m
 return w
def delta(u):
 return add(mul([f.derivative() for f in u],[0,0,PX(3)]),[u[1]*P.derivative(),2*u[2]*P.derivative(),PX.zero()])
columns=[]; kappa=[]; regular=[]
for vec in base:
 G={n:zero() for n in [2,3,4]}; kap=K.zero()
 for slot,c in zip(slots,vec):
  if not c:continue
  n,i,j=slot
  if n=='kappa':kap=c;continue
  if n not in G:continue
  mon=zero();mon[j]=c*x**i
  if n==2:mon=mul(mon,[0,0,PX.one()])
  G[n]=add(G[n],mon)
 g2=divy(G[2],2)
 g3=divy(add(G[3],scale(G[2],-3*B)),3)
 g4=divy(add(add(G[4],scale(G[3],-2*B)),scale(G[2],3*B**2)),4)
 reg=[g2,g3,g4]; regular.append(reg); col=[]
 for f in reg:col += [f,delta(f),delta(delta(f))]
 columns.append(col);kappa.append(kap)
FX=FunctionField(K,'x'); xx=FX.gen(); PY=PolynomialRing(FX,'Y'); Y=PY.gen()
C=FX.extension(Y**3-FX(P),'y'); y=C.gen()
def curve(u):return sum(C(FX(f))*y**j for j,f in enumerate(u))
M=matrix(C,9,8,lambda i,j:curve(columns[j][i])); kr=vector(C,kappa)
save({'K':K,'P':P,'B':B,'slots':slots,'basis':list(base),'regular_coefficients':regular,'jet_columns':columns,'kappa':kappa,'matrix':M,'curve':C},str(out/'vertical_jet_module.sobj'))
rank=M.rank(); aug=M.stack(matrix(C,1,8,list(kr))); rank_aug=aug.rank()
report={'module_dimension':8,'jet_rows':9,'generic_rank':int(rank),'rank_with_kappa':int(rank_aug),'seconds':time.time()-st,'scope':'new generic jet-module test, not a whole geometric-locus decision'}
print(report,flush=True)
if rank_aug==rank:
 # A rational left certificate, with its actual denominator divisor retained.
 coeff=M.transpose().solve_right(kr)
 assert coeff*M==kr
 save({'certificate':coeff,'matrix':M,'kappa':kr},str(out/'generic_kappa_certificate.sobj'))
 report['kappa_in_row_span']=True
else:report['kappa_in_row_span']=False
(out/'summary.json').write_text(json.dumps(report,indent=2,default=int)+'\n')
