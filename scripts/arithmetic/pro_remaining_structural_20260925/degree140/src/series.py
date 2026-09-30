"""Exact formal infinity series and F_4,...,F_8, over Laurent parameter rings."""
from reconstruct import *
from laurent import LP

def sadd(a,b,N):return [(a[i] if i<len(a) else LP())+(b[i] if i<len(b) else LP()) for i in range(N)]
def smul(a,b,N):
 c=[LP() for _ in range(N)]
 for i,x in enumerate(a[:N]):
  if x:
   for j,y in enumerate(b[:N-i]):
    if y:c[i+j]=c[i+j]+x*y
 return c

def sscale(a,k):return [x*k for x in a]
def spow(a,n,N):
 if n==0:return [LP(1)]+[LP() for _ in range(N-1)]
 if n%5==0:
  u=spow(a,n//5,(N+4)//5);r=[LP() for _ in range(N)]
  for i,x in enumerate(u):
   if i*5<N:r[i*5]=x**5
  return r
 z=[LP(1)]+[LP() for _ in range(N-1)]
 while n:
  if n&1:z=smul(z,a,N)
  n>>=1
  if n:a=smul(a,a,N)
 return z

def shift(a,s,N):return [LP() for _ in range(s)]+a[:N-s] if s>=0 else a[-s:N-s]

def Yseries(N):
 # Coefficients in xi^3 only. Compute first in q=xi^3.
 M=(N+2)//3;y=[1]+[0]*(M-1)
 for n in range(1,M):
  known=0
  for i in range(n):
   for j in range(n-i+1):
    k=n-i-j
    if j<n and k<n:known=add(known,mul(y[i],mul(y[j],y[k])))
  rhs=P[10-n] if n<=10 else 0
  y[n]=mul(2,sub(rhs,known))
 out=[LP() for _ in range(N)]
 for i,c in enumerate(y):
  if i*3<N:out[i*3]=LP(c)
 return out

def normalized_tops(linear):
 h,w,s,u=[LP.var(i) for i in range(4)]
 z=w*div(2,epsilon);c=w*Cd+(h*Ca if linear else 0)
 e=-c*z-LP(eta)/(LP(24)*z)
 f=-(w**2)/LP(epsilon)-LP(div(8,24))*(z**5)
 return [LP(1),h,w,e,f],z

def normalized_vector(case):
 tops,z=normalized_tops(case['linear']);s,u=LP.var(2),LP.var(3)
 vec=[]
 for j in range(len(slots)):
  q=sum((tops[i]*case['split'][i][j] for i in range(5)),LP())
  q=q+s*case['kernel'][0][j]+u*case['kernel'][1][j]
  vec.append(q)
 return vec

def Hpolys(case):
 vec=normalized_vector(case);H={n:[[],[],[]] for n in [2,3,4,5]}
 for (n,i,j),c in zip(slots,vec):
  if not c or n=='kappa':continue
  q=cmon(i,j)
  if n==2:q=cmul(q,cmon(0,2))
  for j,p in enumerate(q):
   while len(H[n][j])<len(p):H[n][j].append(LP())
   for i,v in enumerate(p):H[n][j][i]=H[n][j][i]+c*v
 return H

def cinfinity(F,offset,N,Yp):
 out=[LP() for _ in range(N)]
 for j,p in enumerate(F):
  for i,c in enumerate(p):
   if not c:continue
   d=offset-3*i-10*j
   if d<0:raise ValueError(('negative leading exponent',offset,i,j))
   for m,y in enumerate(Yp[j][:max(0,N-d)]):
    if y:out[d+m]=out[d+m]+y*c
 return out

def critical_series(case,N=9):
 Hp=Hpolys(case);Y=Yseries(N);Yp=[spow(Y,j,N) for j in range(3)]
 AA=sscale(cinfinity(Hp[2],35,N,Yp),3)
 BB=sscale(cinfinity(Hp[3],46,N,Yp),2)
 CC=cinfinity(Hp[4],57,N,Yp)
 assert not AA[0] and BB[0]==mul(2,epsilon)
 rho=[LP() for _ in range(N)]
 for n in range(N):
  val=sadd(smul(AA,spow(rho,2,n+1),n+1),smul(BB,rho,n+1),n+1)[n]+CC[n]
  rho[n]=-val/BB[0]
 assert rho[0]==normalized_tops(case['linear'])[1]
 assert not any(sadd(sadd(smul(AA,spow(rho,2,N),N),smul(BB,rho,N),N),CC,N))
 T=sadd(cinfinity([Q,[],[]],57,N,Yp),shift(spow(rho,5,N),2,N),N)
 H=sadd(cinfinity(Hp[5],70,N,Yp),shift(sadd(smul(AA,spow(rho,3,N),N),sscale(smul(BB,spow(rho,2,N),N),2),N),2,N),N)
 F=sadd(smul(T,H,N),cinfinity(ty10,127,N,Yp),N)
 assert not any(F[:4])
 return F,Hp,rho

def main():
 data=json.loads((ROOT/'data'/'spaces.json').read_text());out=[]
 for v,case in enumerate(data['cases']):
  F,H,rho=critical_series(case)
  print('case',v,case['root'],'terms F4...8',[len(p.d) for p in F[4:]],flush=True)
  for i in [4,5]:
   assert all(e[2]+e[3]<=1 and e[2]>=0 and e[3]>=0 for e in F[i].d)
  mat=[[F[i].coeff(j,1) for j in [2,3]] for i in [4,5]]
  det=mat[0][0]*mat[1][1]-mat[0][1]*mat[1][0]
  assert not any(e[0] or e[2] or e[3] for e in det.d)
  print('kernel determinant',det.show(),flush=True)
  out.append({'index':v,'root':case['root'],'F':{str(i):F[i].dump() for i in range(4,9)},'kernel_matrix':[[x.dump() for x in row] for row in mat],'kernel_determinant':det.dump()})
 (ROOT/'data'/'boundary_series.json').write_text(json.dumps({'variables':['h','w','s','u'],'cases':out},indent=2)+'\n')
 print('ALL FORMAL SERIES CHECKS PASSED',flush=True)
if __name__=='__main__':main()
