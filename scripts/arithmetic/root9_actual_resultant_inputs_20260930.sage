"""Balance unit denominators before three exact fixed-degree resultants."""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time();d=load(str(root/'actual_seven_rational_coefficients.sobj'))
R=d['ring'];H,q=R.gens();K=R.base_ring();units=[H,q,d['Psi'],d['D']];powers=[{} for _ in units]
def up(i,n):
 if n not in powers[i]:powers[i][n]=units[i]^n
 return powers[i][n]
# mu=H^3*q^-7*Psi^-3*D^-3*zeta, a change only by original units.
scale=[3,-7,-3,-3];rows=[];denominators=[]
for j in range(4):
 terms=[(int(n),N,tuple(int(E[k])-int(n)*scale[k] for k in range(4))) for row,n,N,E in d['coefficients'] if row==j]
 assert len(terms)==[5,6,6,7][j]
 common=tuple(max(E[k] for n,N,E in terms) for k in range(4));cc=[]
 for n,N,E in terms:cc.append(N*prod(up(k,common[k]-E[k]) for k in range(4)))
 rows.append(cc);denominators.append(common)
 print('row',j,'coeff degrees',[N.degrees() for N in cc],'seconds',time.time()-start,flush=True)
def bound(A,B,var):
 m=len(A)-1;n=len(B)-1;s=m+n;M=[[-10^6]*s for _ in range(s)]
 for i in range(n):
  for j,N in enumerate(reversed(A)):
   if N:M[i][i+j]=int(N.degree(var))
 for i in range(m):
  for j,N in enumerate(reversed(B)):
   if N:M[n+i][i+j]=int(N.degree(var))
 dp={0:0}
 for i in range(s):
  new={}
  for mask,v in dp.items():
   for j in range(s):
    if not mask>>j&1 and M[i][j]>-10^6:
     mm=mask|(1<<j);new[mm]=max(new.get(mm,-10^9),v+M[i][j])
  dp=new
 return dp[(1<<s)-1]
tasks=[(0,j,bound(rows[0],rows[j],H),bound(rows[0],rows[j],q)) for j in [1,2,3]]
def code(c):return sum(int(v)*5^i for i,v in enumerate(K(c).polynomial().list()))
with (root/'actual_resultant_inputs.txt').open('w') as f:
 f.write(f'{len(rows)} {len(tasks)}\n')
 for cc in rows:
  f.write(str(len(cc))+'\n')
  for N in cc:
   dd=N.dict();f.write(str(len(dd))+'\n')
   for (h,qq),c in dd.items():f.write(f'{h} {qq} {code(c)}\n')
 for t in tasks:f.write(' '.join(map(str,t))+'\n')
save(dict(d,balanced_scale=scale,balanced_rows=rows,balanced_denominators=denominators,resultant_tasks=tasks),str(root/'actual_resultant_inputs'))
(root/'actual_resultant_inputs.json').write_text(json.dumps({'scope':'fixed-Sylvester determinant degree bounds','tasks':tasks,'scale':scale,'seconds':time.time()-start},indent=2,default=int)+'\n');print(tasks,flush=True)
