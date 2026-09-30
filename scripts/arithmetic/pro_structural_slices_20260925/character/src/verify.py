#!/usr/bin/env python3
"""Verify the proved scope from exact inputs, with no network or point search.
Default: verify hashes (when present), rebuild the pencils, check all proof
reductions, and execute both large Macaulay checks. All temporary products
are created outside the archive and removed on exit.
"""
from __future__ import annotations
import argparse,hashlib,json,os,subprocess,sys,tempfile,time
from pathlib import Path
import numpy as np
from exact import *
from macaulay import independent_equations,macaulay,monomials
import poly25 as pp
import build_pencils
ROOT=Path(__file__).resolve().parents[1]

def say(*args):print(*args,flush=True)
def load(name):return np.load(ROOT/name)
def hashes():
 path=ROOT/'SHA256SUMS'
 if not path.exists():say('Manifest absent (packaging run only).');return
 n=0
 for line in path.read_text().splitlines():
  expected,name=line.split('  ',1);p=ROOT/name
  assert p.is_file(),name
  assert hashlib.sha256(p.read_bytes()).hexdigest()==expected,name
  n+=1
 say('SHA-256 manifest PASS:',n,'files')

def member(R,p,t):
 t=t.copy()
 for r,j in enumerate(p):
  if t[j]:t=SUB[t,MUL[t[j],R[r]]]
 return not np.any(t)

def dense_check(A,d,nf,full=False,vectors=None):
 M,mons,_=macaulay(A,d);R,p=rref(M)
 if full:assert len(p)==M.shape[1]
 vs=np.eye(A.shape[1],dtype=np.uint8) if vectors is None else vectors
 for v in vs:
  for j in range(nf):
   t=np.zeros(M.shape[1],dtype=np.uint8)
   t[np.arange(A.shape[1])*len(mons)+mons.index((j,)*d)]=v
   assert member(R,p,t)
 return M.shape,len(p)

def cpp_text(A,d,nf):
 return ' '.join(map(str,A.shape))+'\n'+' '.join(map(str,A.flatten()))+f'\n{d} {nf}\n'

def cpp_check(exe,A,d,nf,expected,tag):
 say('Checking',tag,'...')
 proc=subprocess.run([str(exe)],input=cpp_text(A,d,nf),text=True,capture_output=True,check=True)
 res=json.loads(proc.stdout)
 for k,v in expected.items():assert res[k]==v,(tag,k,res[k],v)
 say(tag,'PASS',json.dumps(res,sort_keys=True))
 return res

def determinant(A):
 A=A.copy();n=len(A);out=1
 for j in range(n):
  nz=np.flatnonzero(A[j:,j])
  if not len(nz):return 0
  i=j+int(nz[0])
  if i!=j:A[[i,j]]=A[[j,i]];out=int(NEG[out])
  c=int(A[j,j]);out=int(MUL[out,c]);A[j]=MUL[INV[c],A[j]]
  A[j+1:]=SUB[A[j+1:],MUL[A[j+1:,j,None],A[j]]]
 return out

def det_univariate(A):
 n=len(A);xs=list(range(n+1))
 V=np.array([[pp.evaluate([0]*j+[1],x) for j in range(n+1)] for x in xs],dtype=np.uint8)
 R,p,H=rref(V,True);assert len(p)==n+1
 vals=np.array([determinant(ADD[A[:,:,0],MUL[x,A[:,:,1]]]) for x in xs],dtype=np.uint8)
 return pp.tr(mm(H,vals).tolist())

def mons2(d):return [(a,total-a) for total in range(d+1) for a in range(total+1)]
def fpow(a,n):
 v=1
 for _ in range(n):v=int(MUL[v,a])
 return v

def det_bivariate(A,degree):
 basis=mons2(degree);nodes=[(a,b) for a in range(degree+1) for b in range(degree+1-a)]
 V=np.array([[MUL[fpow(a,i),fpow(b,j)] for i,j in basis] for a,b in nodes],dtype=np.uint8)
 R,p,H=rref(V,True);assert len(p)==len(basis)
 vals=np.array([determinant(ADD[ADD[MUL[a,A[:,:,0]],MUL[b,A[:,:,1]]],A[:,:,2]]) for a,b in nodes],dtype=np.uint8)
 return {m:int(c) for m,c in zip(basis,mm(H,vals)) if c}

def verify_all(tmp):
 # Field laws and independent C++/Python small-matrix comparisons.
 assert int(MUL[5,5])==8
 for a in range(25):
  assert fpow(a,25)==a
  if a:assert int(MUL[a,INV[a]])==1
  for b in range(25):
   for c in range(25):
    assert MUL[MUL[a,b],c]==MUL[a,MUL[b,c]]
    assert MUL[a,ADD[b,c]]==ADD[MUL[a,b],MUL[a,c]]
 assert frob25(e).terms()==(e**25).terms()
 say('F25 laws and Laurent Frobenius PASS')
 exe=tmp/'macaulay_sparse'
 subprocess.run(['g++','-O3','-std=c++20',str(ROOT/'src/macaulay_sparse.cpp'),'-o',str(exe)],check=True)
 rng=np.random.default_rng(941)
 for case in range(4):
  A=rng.integers(0,25,(5+case,2,3),dtype=np.uint8);d=2+(case%2)
  M,mons,_=macaulay(A,d);R,p=rref(M);yes=0;fails=[]
  for z in range(2):
   for w in range(3):
    t=np.zeros(M.shape[1],dtype=np.uint8);t[z*len(mons)+mons.index((w,)*d)]=1
    if member(R,p,t):yes+=1
    else:fails.append(z*3+w)
  cpp_check(exe,A,d,3,{'rank':len(p),'targets_proved':yes,'failed':fails},f'independent arithmetic cross-check {case}')
 # Reconstruct from the actual Laurent transitions, not the retained tensors.
 out=tmp/'rebuilt';(out/'data').mkdir(parents=True)
 oldroot=build_pencils.ROOT;build_pencils.ROOT=out
 try:build_pencils.build()
 finally:build_pencils.ROOT=oldroot
 D=load('data/pencils.npz');rebuilt=np.load(out/'data/pencils.npz')
 assert set(D.files)==set(rebuilt.files)
 for key in D.files:assert np.array_equal(D[key],rebuilt[key]),key
 assert json.loads((out/'data/bases.json').read_text())==json.loads((ROOT/'data/bases.json').read_text())
 T=D['T'];Q=D['Q'];assert T.shape==(19,80,35) and Q.shape==(19,43,16)
 assert rank(D['C'])==235 and rank(D['Cq'])==116
 say('Actual T,Q and elimination/recovery matrices REBUILT AND MATCHED')
 # Recover the 29 alpha-free equations and the three source character blocks.
 AF=T[:,:,23:].transpose(1,0,2).reshape(80,-1)
 Lf=kernel(AF.T).T;assert Lf.shape==(29,80)
 At=np.stack([mm(Lf,T[z,:,:23]) for z in range(19)])
 fdata=load('data/fonly.npz');assert np.array_equal(Lf,fdata['L']) and np.array_equal(At,fdata['At'])
 zs=[[0,6,7],[1,2,3,4,5,8,9,10,11,12],list(range(13,19))]
 ws=[list(range(11))+[34],list(range(11,19))+list(range(23,30)),list(range(19,23))+list(range(30,34))]
 zg={i:g for g,s in enumerate(zs) for i in s};wg={i:g for g,s in enumerate(ws) for i in s}
 rg=[[],[],[]]
 for r in range(80):
  ii,jj=np.nonzero(T[:,r,:]);weights={(zg[int(i)]+wg[int(j)])%3 for i,j in zip(ii,jj)}
  assert len(weights)==1;rg[weights.pop()].append(r)
 assert list(map(len,rg))==[23,27,30]
 assert json.loads((ROOT/'data/grades.json').read_text())=={'z_groups':zs,'section_groups':ws,'row_groups':rg}
 chars=[]
 for j in range(3):
  inds=[i for i,b in enumerate(basis_L(31)) if b[1]==j];AA=At[:,:,inds]
  R,p,H=rref(AA.transpose(1,0,2).reshape(29,-1),True)
  B=np.stack([mm(H[:len(p)],a) for a in AA]);chars.append(B)
  assert np.array_equal(B,load(f'data/fonly_char{j}.npz')['B'])
  for r in range(B.shape[1]):
   supported=[g for g,s in enumerate(zs) if np.any(B[s,r,:])]
   assert len(supported)==1
 say('Alpha elimination, source grading, and row supports PASS')
 za,zb,zc=zs
 # Complete character 2.
 A2=independent_equations(chars[2][za].transpose(1,0,2))
 C2=independent_equations(chars[2][zc].transpose(1,0,2))
 assert np.array_equal(A2,load('certificates/j2_groupA.npz')['A'])
 assert np.array_equal(C2,load('certificates/j2_groupC.npz')['A'])
 say('j2 source A',dense_check(A2,2,4,full=True))
 say('j2 source C',dense_check(C2,4,4,full=True))
 B2=independent_equations(T[zb][:,:,ws[2]].transpose(1,0,2))
 assert np.array_equal(B2,load('data/j2_B_full.npz')['A'])
 other=[i for i in range(23,35) if i not in ws[2]]
 N=T[zb][:,:,other].transpose(1,0,2).reshape(80,-1);HP=kernel(N.T).T
 AP=independent_equations(np.stack([mm(HP,T[z][:,ws[2]]) for z in zb]).transpose(1,0,2))
 assert np.array_equal(AP,B2)
 say('j2 unrestricted-alpha projection PASS')
 cpp_check(exe,B2,6,4,{'rows':18216,'columns':17160,'rank':17160,'targets_proved':40,'failed':[]},'j2 complete character block')
 # Character 0, degrees <=2.
 common=[]
 for name,zi,deg in [('A',za,1),('B',zb,5)]:
  A=independent_equations(chars[0][zi,:,:3].transpose(1,0,2))
  Kc=kernel(A.transpose(0,2,1).reshape(-1,len(zi)));assert Kc.shape[1]==1
  ann=kernel(Kc.T).T;cert=load(f'certificates/j0_low2_{name}.npz')
  assert np.array_equal(A,cert['A']) and np.array_equal(Kc,cert['common'])
  assert np.array_equal(ann,cert['targets']) and int(cert['d'])==deg
  say('j0 degree<=2 source',name,dense_check(A,deg,3,vectors=ann));common.append(Kc)
 S=np.zeros((19,8),dtype=np.uint8);S[za,0]=common[0][:,0];S[zb,1]=common[1][:,0];S[np.ix_(zc,range(2,8))]=np.eye(6,dtype=np.uint8)
 assert rank(S)==8
 cols=[0,1,2]+list(range(23,35));TT=mm(S.T,T.reshape(19,-1)).reshape(8,80,35)[:,:,cols]
 A0=independent_equations(TT.transpose(1,0,2))
 cert=load('data/j0_low2_restricted.npz');assert np.array_equal(A0,cert['A']) and np.array_equal(S,cert['S'])
 cpp_check(exe,A0,3,3,{'rows':7320,'columns':5440,'rank':5343,'targets_proved':24,'failed':[]},'j0 all degree<=2')
 # Cubic leading-coefficient chart forces the source into the excluded P5.
 for name,zi,deg,nr,nc,rk in [('A',za,2,24,30,24),('B',zb,10,2860,2860,2794)]:
  A=independent_equations(chars[0][zi,:,:4].transpose(1,0,2))[:,:,[3,0,1,2]]
  cpp_check(exe,A,deg,1,{'rows':nr,'columns':nc,'rank':rk,'targets_proved':len(zi),'failed':[]},f'j0 cubic leading coefficient, source {name}')
 say('j0 degree<=3 window exclusion PASS (uses the accepted pure-v exclusion)')
 # Character 1, all p: eliminate source group A with arbitrary alpha.
 A1=independent_equations(chars[1][za].transpose(1,0,2))
 cert=load('certificates/j1_zA.npz');assert np.array_equal(A1,cert['A'])
 say('j1 universal zA elimination',dense_check(A1,3,8,full=True))
 B1=independent_equations(chars[1][zb].transpose(1,0,2))
 C1=independent_equations(chars[1][zc].transpose(1,0,2))
 assert B1.shape==(10,10,8) and C1.shape==(6,6,8)
 # All linear p: exact factor fields of det(B0+t B1).
 info=json.loads((ROOT/'data/j1_linear_determinants.json').read_text())
 pb=det_univariate(B1);pc=det_univariate(C1)
 assert pb==info['detB'] and pc==info['detC']
 assert determinant(B1[:,:,1])==info['B_at_infinity']!=0
 assert pp.gcd(pb,pp.derivative(pb))==[1]
 product=[1]
 for h in info['factors_B']:
  assert pp.irreducible(h);product=pp.mul(product,h)
 assert pp.monic(product)==pp.monic(pb)
 for number,h in enumerate(info['factors_B']):
  K=pp.Extension(h)
  def special(A):return [[K.elt([int(A[r,z,0]),int(A[r,z,1])]) for z in range(A.shape[1])] for r in range(A.shape[0])]
  bk=pp.kernel_extension(special(B1),K);ck=pp.kernel_extension(special(C1),K);assert len(bk)==len(ck)==1
  bases=[]
  for zi,ks in [(zb,bk),(zc,ck)]:
   for v in ks:
    z=[K.zero]*19
    for i,c in zip(zi,v):z[i]=c
    bases.append(z)
  TT=[]
  for r in range(80):
   row=[]
   for z in bases:
    for w in range(13):
     indices=[11,12] if w==0 else [22+w];vals=[K.one,K.elt([0,1])] if w==0 else [K.one];val=K.zero
     for i,c in enumerate(z):
      if c:
       for index,v in zip(indices,vals):val=K.add(val,K.mul(c,K.mul(K.scalar(int(T[i,r,index])),v)))
     row.append(val)
   TT.append(row)
  RR,p=pp.rref_extension(TT,K);RR=RR[:len(p)];assert len(p)==23
  assert 0 in p and RR[p.index(0)]==[K.one]+[K.zero]*25
  saved=json.loads((ROOT/f'certificates/j1_linear_factor_{number}.json').read_text())
  assert saved['tensor_equations']==json.loads(json.dumps(RR))
  assert saved['source_basis']==json.loads(json.dumps(bases))
  say('j1 linear factor PASS:',h,'rank 23, relation source_B * fscale = 0')
 # Quadratic chart p2=1: an exact polynomial unit certificate.
 c0=kernel(C1[:,:,:3].transpose(0,2,1).reshape(-1,6));assert c0.shape==(6,1)
 assert c0[:,0].tolist()==[16,22,12,7,21,1]
 CQ=C1[:,:5,:3];BB=B1[:,:,:3]
 polynomials=[det_bivariate(np.delete(CQ,r,axis=0),5) for r in range(6)]+[det_bivariate(BB,10)]
 saved=json.loads((ROOT/'data/j1_quadratic_rankdrop_polynomials.json').read_text())
 assert [[[i,j,c] for (i,j),c in p.items()] for p in polynomials]==saved['polynomials']
 uc=json.loads((ROOT/'certificates/j1_quadratic_rankdrop_unit.json').read_text());total={}
 for gi,a,b,c in uc['multipliers']:
  for (i,j),v in polynomials[gi].items():
   key=(i+a,j+b);vv=int(ADD[total.get(key,0),MUL[c,v]])
   if vv:total[key]=vv
   else:total.pop(key,None)
 assert total=={(0,0):1}
 say('j1 quadratic exceptional-rank loci: literal Nullstellensatz identity 1 PASS')
 # With zC in its constant kernel line, remove all unmatched alpha terms.
 II=T[zb][:,rg[1],34].T;JJ=T[zc][:,rg[1],30:34].transpose(1,0,2)
 R,p,H=rref(II,True);assert len(p)==10
 proj=np.stack([mm(H[10:],JJ[:,i,:]) for i in range(6)],axis=1)
 Dc=np.stack([mm(proj[:,:,i],c0[:,0]) for i in range(4)],axis=1)
 assert rank(Dc)==4
 say('j1 quadratic unmatched-alpha reduction: ranks 10 and 4 PASS')
 cols=[11,12,13]+list(range(23,30));BM=independent_equations(T[zb][:,:,cols].transpose(1,0,2))
 assert np.array_equal(BM,load('data/j1_low2_B_matched.npz')['A'])
 cpp_check(exe,BM,5,3,{'rows':21450,'columns':20020,'rank':19600,'targets_proved':30,'failed':[]},'j1 all degree<=2 matched block')
 say('ALL PROVED CLAIMS VERIFIED.')
 say('Scope: j=2 entire requested slice; j=0 deg(p)<=3; j=1 deg(p)<=2.')
 say('OPEN: j=0 degrees 4..10 and j=1 degrees 3..7. No witness is certified.')

if __name__=='__main__':
 parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--skip-manifest',action='store_true');parser.add_argument('--manifest-only',action='store_true');args=parser.parse_args()
 say('Python',sys.version.replace('\n',' '));say('NumPy',np.__version__)
 say(subprocess.check_output(['g++','--version'],text=True).splitlines()[0])
 if not args.skip_manifest:hashes()
 if not args.manifest_only:
  start=time.time()
  with tempfile.TemporaryDirectory(prefix='cubic-character-verify-') as temp:verify_all(Path(temp))
  say('Verification elapsed seconds:',round(time.time()-start,3))
