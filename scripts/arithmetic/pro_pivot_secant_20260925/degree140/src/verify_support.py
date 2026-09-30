"""Portable exact-data readers and certificate checks for the continuation."""
import json,struct
from pathlib import Path
from fractions import Fraction
import numpy as np
import exact as E

def load(path): return json.loads(Path(path).read_text())
def readpoly(path):
 a=list(map(int,Path(path).read_text().split()));assert a[0]==len(a)-1
 return E.poly(a[1:])
def monic(p): return E.scale(p,E.F.I(int(p[-1])))
def at_tensor(a,h):
 v=np.zeros(a.shape[1:],np.int32)
 for c in a[::-1]: v=E.F.add(E.F.mul(v,int(h)),c)
 return v

def specialize_sparse(row,q):
 out=np.zeros(1+max(e[0] for e,c in row),np.int32)
 for e,c in row:
  assert e[2:]==[0,0]
  out[e[0]]=E.F.A(int(out[e[0]]),E.F.M(c,E.F.P(q,e[1])))
 return E.poly(out)

def boundary(cube,record=None):
 """Certify all geometric roots of the highest-H coefficient, without searching unknowns."""
 deg=max(e[0] for e,c in cube['Psi']);top=np.zeros(1+max(e[1] for e,c in cube['Psi'] if e[0]==deg),np.int32)
 for e,c in cube['Psi']:
  if e[0]==deg: top[e[1]]=c
 nz=int(np.flatnonzero(top)[0]);T=E.poly(top[nz:]);assert nz==(1 if cube['root'] is None else 2)
 den=np.zeros(1+max(e[1] for e,c in cube['common_denominator_d']),np.int32)
 for e,c in cube['common_denominator_d']:
  assert e[0]==0 and e[2:]==[0,0];den[e[1]]=c
 if cube['root'] is None:
  assert deg==1 and len(T)==2 and len(den)==1
  q=E.F.N(E.F.M(int(T[0]),E.F.I(int(T[1]))));pivot=None
  assert q==15383 and int(E.evaluate(den,q))
 else:
  assert deg==3 and len(T)==3 and len(den)==2
  pivot=E.F.N(E.F.M(int(den[0]),E.F.I(int(den[1]))));assert E.evaluate(T,pivot)==0
  other=E.exactdiv(T,E.poly([E.F.N(pivot),1]));assert len(other)==2
  q=E.F.N(E.F.M(int(other[0]),E.F.I(int(other[1]))));assert q and q!=pivot and E.evaluate(den,q)
  assert record is not None and record['q']==q and record['pivot_q']==pivot
  assert np.array_equal(monic(T),E.mul(E.poly([E.F.N(q),1]),E.poly([E.F.N(pivot),1])))
 psi=specialize_sparse(cube['Psi'],q)
 assert psi[0] and len(psi)==(1 if cube['root'] is None else 3)
 if record is not None: assert psi.tolist()==record['Psi']
 return q,pivot,psi

def check_tensor_bounds(a,psi,constant,record):
 assert a.dtype==np.int32 and a.shape==((37 if constant else 73),7,141)
 assert not np.any(a[:,1:,140])
 lc=E.poly(a[:,0,140]);lead=E.mul(E.poly([0]*9+[1]),E.power(psi,3))
 scalar=E.F.M(int(lc[-1]),E.F.I(int(lead[-1])));assert np.array_equal(lc,E.scale(lead,scalar))
 if not constant: assert scalar==record['normalized_leading_scalar']
 inds=np.argwhere(a);low=[];high=[]
 for h,l,x in inds:
  m=140-int(x)
  assert 4*int(l)<=3*m
  if m:
   low.append(Fraction(int(h)-9,m));high.append(Fraction(int(h)-(len(lc)-1),m))
 n,p=min(low),max(high)
 assert n==(-Fraction(9,4) if constant else -3) and p==(3 if constant else 9)
 if constant:
  assert record['common_H_shift']==234 and record['interpolation_degree_bound']==546
  for e in record['errors']:
   assert 234+n*e['index']>=0 and 234+p*e['index']<=546
   assert e['degree_H']+e['H_shift_removed']<=546
 else:
  assert record['H_shift']==222 and record['Psi_power']==189 and record['degree_bound']==1266
  assert 222+n*74==0 and 222+2*189+p*74==1266
  assert record['H0_slope']==[-3,1] and record['Hinf_slope']==[9,1]
  assert len(E.poly(psi))==3 and psi[0]
  factorproduct=E.poly([1])
  for f in record['Psi_factors']: factorproduct=E.mul(factorproduct,E.poly(f))
  assert np.array_equal(monic(psi),factorproduct)
  assert [e['degree_H'] for e in record['errors']]==[1161,1164,1167,1170]
  assert [e['degree_mu'] for e in record['errors']]==[53,54,54,55]
  for e in record['errors']:
   assert e['H_removed']==30
   assert e['psi_factor_exponents_removed']==[0]*len(record['Psi_factors'])
   assert e['degree_H']+e['H_removed']<=1266
 for e in record['errors']:
  assert e['degree_mu']<=3*e['index']//4
  assert e['degree_H']==max(h for h,m,c in e['terms'])
  assert e['degree_mu']==max(m for h,m,c in e['terms'])
  assert len({(h,m) for h,m,c in e['terms']})==len(e['terms'])
  assert all(0<c<E.SIZE for h,m,c in e['terms'])
 return scalar

def write_coefficient_input(path,tensor,record,constant):
 raw=Path(str(path)+'.bin');a=np.ascontiguousarray(tensor,dtype=np.int32)
 with raw.open('wb') as f: f.write(struct.pack('=i',len(a)));f.write(a.tobytes())
 inp=Path(str(path)+'.txt')
 psi=[1] if constant else record['Psi'];shift=234 if constant else 222;power=0 if constant else 189;degree=546 if constant else 1266
 with inp.open('w') as f:
  f.write(f'{0 if constant else 1} {degree} {shift} {power} {len(psi)} '+' '.join(map(str,psi))+'\n')
  f.write(str(len(record['errors']))+'\n')
  for e in record['errors']:
   removed=e['H_shift_removed'] if constant else e['H_removed']
   f.write(f'{e["index"]} {removed} {len(e["terms"])} {e["degree_H"]} {e["degree_mu"]}\n')
   for h,m,c in e['terms']: f.write(f'{h} {m} {c}\n')
 return raw,inp

def coefficient_polys(e):
 p=[np.zeros(e['degree_H']+1,np.int32) for _ in range(e['degree_mu']+1)]
 for h,m,c in e['terms']:p[m][h]=c
 return [E.poly(a) for a in p]

def check_dual_bounds(cert,f,g,fast):
 m,n=f['degree_mu'],g['degree_mu'];assert cert['fixed_degrees']==[m,n]
 arrays=[coefficient_polys(f)[::-1],coefficient_polys(g)[::-1]];N=m+n
 for bi,z in enumerate(cert['bounds']):
  u=z['row_duals'];v=z['column_duals'];match=z['matching'];assert len(u)==len(v)==len(match)==N and sorted(match)==list(range(N))
  sign=z['sign'];assert sign in [-1,1] and z['bound']==sign*(sum(u)+sum(v))
  factor=z.get('factor');A=np.full((N,N),10**8,np.int64)
  for group,rows,offset in [(arrays[0],n,0),(arrays[1],m,n)]:
   weights=[]
   for p in group:
    if not len(p):weights.append(None)
    elif factor is not None:weights.append(fast.valuation(p,E.poly(factor)))
    elif sign==1:weights.append(int(np.flatnonzero(p)[0]))
    else:weights.append(-(len(p)-1))
   for i in range(rows):
    for j,w in enumerate(weights):
     if w is not None:A[offset+i,i+j]=w
  assert np.all(np.array(u)[:,None]+np.array(v)[None,:]<=A)
  assert all(A[i,match[i]]<10**8 and u[i]+v[match[i]]==A[i,match[i]] for i in range(N))
 lo,hi=[z['bound'] for z in cert['bounds'][:2]];assert cert['bounds'][0]['sign']==1 and cert['bounds'][1]['sign']==-1
 factors=[(z['bound'],z['factor']) for z in cert['bounds'][2:]]
 fs=[E.poly([0,1])]+[E.poly(p) for e,p in factors]
 for i in range(len(fs)):
  for j in range(i):assert len(fast.gcd(fs[i],fs[j]))==1
 deg=hi-lo-sum(e*(len(p)-1) for e,p in factors)
 assert cert['interpolation_point_count']==deg+1
 return lo,hi,factors,deg

def write_resultant_input(path,f,g,lo,hi,factors):
 with Path(path).open('w') as o:
  o.write(f'{lo} {hi} {f["degree_mu"]} {g["degree_mu"]}\n')
  for e in [f,g]:
   o.write(f'{len(e["terms"])} {e["degree_H"]} {e["degree_mu"]}\n')
   for h,m,c in e['terms']:o.write(f'{h} {m} {c}\n')
  o.write(f'{len(factors)}\n')
  for e,p in factors:o.write(f'{e} {len(p)} '+' '.join(map(str,p))+'\n')

def quotient_certificate(prefix,G,record,fast):
 C=readpoly(str(prefix)+'.radical');assert len(C)==10 and np.array_equal(E.power(C,5),G)
 assert len(fast.gcd(C,E.derivative(C)))==1
 assert C[0] and len(fast.gcd(C,E.poly(record['Psi'])))==1
 # No irreducibility or rationality of any root is assumed.
 tokens=iter(map(int,Path(str(prefix)+'.part0').read_text().split()))
 def rp():
  n=next(tokens);return E.poly([next(tokens) for _ in range(n)])
 def rlp():return [rp() for _ in range(next(tokens))]
 M=rp();assert np.array_equal(M,C);target=rlp();assert len(target)==1 and target[0].tolist()==[1]
 count=next(tokens);assert count==len(record['errors']);comb=[rlp() for _ in range(count)]
 assert next(tokens)==1 and next(tokens)==0
 assert list(tokens)==[]
 cover=list(map(int,Path(str(prefix)+'.cover').read_text().split()));assert cover==[1,len(C)]+C.tolist()
 def rem(p):return fast.divrem(p,C)[1] if len(p)>=len(C) else p
 total=[]
 for e,coef in zip(record['errors'],comb):
  fs=[rem(p) for p in coefficient_polys(e)]
  while len(total)<len(fs)+len(coef)-1:total.append(E.poly())
  for i,a in enumerate(coef):
   if not len(a):continue
   for j,b in enumerate(fs):
    if len(b):total[i+j]=E.add(total[i+j],rem(E.mul(a,b)))
 while total and not len(total[-1]):total.pop()
 assert len(total)==1 and total[0].tolist()==[1]
 return C.tolist()
