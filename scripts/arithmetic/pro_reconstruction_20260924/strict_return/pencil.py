"""Geometric certificate for the ENTIRE pencil <v_13,v_15>.

 This is only a sublocus of P18. Coefficients of every polynomial are F25
 codes in ascending powers of the pencil parameter. No field-point scan
 is used to infer emptiness: the certificate is a polynomial Bezout identity.
"""
from compute import *
import json
A25=ADD.tolist();M25=MUL.tolist();N25=NEG.tolist();I25=INV.tolist()
def trim(a):
 while a and a[-1]==0:a.pop()
 return a
def padd(a,b):
 c=list(a)+[0]*max(0,len(b)-len(a))
 for i,x in enumerate(b):c[i]=A25[c[i]][x]
 return trim(c)
def pneg(a):return [N25[x] for x in a]
def psub(a,b):return padd(a,pneg(b))
def pmul(a,b):
 if not a or not b:return []
 c=[0]*(len(a)+len(b)-1)
 for i,x in enumerate(a):
  if x:
   for j,y in enumerate(b):
    if y:c[i+j]=A25[c[i+j]][M25[x][y]]
 return trim(c)
def pscale(a,c):return trim([M25[c][x] for x in a])
def pdiv(a,b):
 if not b:raise ZeroDivisionError
 r=a.copy(); q=[0]*max(0,len(r)-len(b)+1); inv=I25[b[-1]]
 while len(r)>=len(b):
  k=len(r)-len(b);c=M25[r[-1]][inv];q[k]=c
  for j,x in enumerate(b):r[k+j]=A25[r[k+j]][N25[M25[c][x]]]
  trim(r)
 return trim(q),r
def exact(a,b):
 q,r=pdiv(a,b)
 assert not r,'Bareiss division was not exact'
 return q
def pxgcd(a,b):
 r0,r1=a.copy(),b.copy();s0,s1=[1],[];t0,t1=[],[1]
 while r1:
  q,r=pdiv(r0,r1)
  r0,r1=r1,r;s0,s1=s1,psub(s0,pmul(q,s1));t0,t1=t1,psub(t0,pmul(q,t1))
 c=I25[r0[-1]]
 return pscale(r0,c),pscale(s0,c),pscale(t0,c)
def detpoly(M0,M1):
 n=len(M0);mat=[[trim([int(M0[i,j]),int(M1[i,j])]) for j in range(n)] for i in range(n)]
 prev=[1];sgn=1
 for k in range(n-1):
  p=k
  while p<n and not mat[p][k]:p+=1
  if p==n:return []
  if p!=k:mat[k],mat[p]=mat[p],mat[k];sgn=N25[sgn]
  pivot=mat[k][k]
  for i in range(k+1,n):
   for j in range(k+1,n):mat[i][j]=exact(psub(pmul(pivot,mat[i][j]),pmul(mat[i][k],mat[k][j])),prev)
   mat[i][k]=[]
  prev=pivot
 return pscale(mat[-1][-1],sgn)
def blocks(M0,M1):
 S=np.logical_or(M0,M1);nr,nc=S.shape;seen=set();out=[]
 for n in range(nr+nc):
  if n in seen:continue
  q=[n];seen.add(n);cur=[]
  while q:
   i=q.pop();cur.append(i)
   js=nr+np.flatnonzero(S[i]) if i<nr else np.flatnonzero(S[:,i-nr])
   for j in js:
    j=int(j)
    if j not in seen:seen.add(j);q.append(j)
  if len(cur)>1:out.append((sorted(i for i in cur if i<nr),sorted(i-nr for i in cur if i>=nr)))
 return out

def create():
 D=np.load(ROOT/'hom_tensor.npz');T=D['T'];M0,M1=T[13],T[15]
 cert={'scope':'Only the projective pencil u=0, v=s*y^2*x^-6+t*y^2*x^-4',
       'tensor_indices_zero_based':[13,15],'blocks':[]}
 for rows,cols in blocks(M0,M1):
  B0=M0[np.ix_(rows,cols)];B1=M1[np.ix_(rows,cols)]
  assert len(rref(B1)[1])==len(cols)
  ds=[];bez=[];g=[];selected=[]
  for trial in range(40):
   c=trial%25
   perm=np.arange(len(rows)) if trial==0 else np.random.default_rng(trial).permutation(len(rows))
   Mt=ADD[B0,MUL[c,B1]][perm];_,piv=rref(Mt.T)
   if len(piv)!=len(cols):continue
   rs=sorted(rows[int(perm[int(i)])] for i in piv)
   if rs in selected:continue
   d=detpoly(M0[np.ix_(rs,cols)],M1[np.ix_(rs,cols)])
   assert d
   selected.append(rs);ds.append(d)
   if not g:
    inv=I25[d[-1]];g=pscale(d,inv);bez=[[inv]]
   else:
    g,s,t=pxgcd(g,d);bez=[pmul(s,z) for z in bez]+[t]
   print('block',len(rows),len(cols),'minor',len(ds),'gcd degree',len(g)-1,flush=True)
   if g==[1]:break
  if g!=[1]:raise RuntimeError('Pencil exclusion not certified: common polynomial divisor remains')
  total=[]
  for a,d in zip(bez,ds):total=padd(total,pmul(a,d))
  assert total==[1]
  cert['blocks'].append({'rows':rows,'columns':cols,'minor_rows':selected,'determinants':ds,'bezout':bez,'infinity_rank':len(cols)})
 (ROOT/'pencil_certificate.json').write_text(json.dumps(cert,indent=2)+'\n')
 print('CERTIFIED: every geometric point of this projective pencil has Hom(F^2 R,K)=0',flush=True)
 return cert

def verify():
 C=json.loads((ROOT/'pencil_certificate.json').read_text());T=np.load(ROOT/'hom_tensor.npz')['T'];M0,M1=T[13],T[15]
 assert [(b['rows'],b['columns']) for b in C['blocks']]==blocks(M0,M1)
 for b in C['blocks']:
  ds=[]
  for rows,d in zip(b['minor_rows'],b['determinants']):
   actual=detpoly(M0[np.ix_(rows,b['columns'])],M1[np.ix_(rows,b['columns'])])
   assert actual==d;ds.append(actual)
  total=[]
  for a,d in zip(b['bezout'],ds):total=padd(total,pmul(a,d))
  assert total==[1]
  assert len(rref(M1[np.ix_(b['rows'],b['columns'])])[1])==len(b['columns'])
 print('Pencil Bezout certificate verified.')
if __name__=='__main__':
 import sys
 if '--verify' in sys.argv:verify()
 else:create()
