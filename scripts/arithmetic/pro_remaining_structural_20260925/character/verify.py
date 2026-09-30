"""Independent exact checks of stored identities; optional full reconstruction.
Usage: python src/verify.py [--rebuild]
"""
import argparse,itertools,json,subprocess,sys,tempfile,shutil,time
from pathlib import Path
import numpy as np
from exact import *
ROOT=Path(__file__).resolve().parents[1]
def check(condition,message):
 if not condition:raise AssertionError(message)
 print('PASS:',message,flush=True)
def main():
 pa=argparse.ArgumentParser();pa.add_argument('--rebuild',action='store_true');args=pa.parse_args()
 for a in range(25):
  for b in range(25):
   # Independent pair arithmetic verifies the lookup tables.
   x,y=a%5,a//5;s,t=b%5,b//5
   checkadd=(x+s)%5+5*((y+t)%5)
   checkmul=(x*s+3*y*t)%5+5*((x*t+y*s+y*t)%5)
   assert int(ADD[a,b])==checkadd and int(MUL[a,b])==checkmul
 check(all(MUL[a,INV[a]]==1 for a in range(1,25)),'field tables and nonzero inverses')
 D=np.load(ROOT/'data/pencils.npz');M=D['M'];H=D['H'];ML=D['ML'];HL=D['HL'];T=D['T'];Q=D['Q']
 check(np.array_equal(mm(H,M),np.r_[np.eye(235,dtype=np.uint8),np.zeros((80,235),dtype=np.uint8)]),'H M = [I_235;0]')
 check(np.array_equal(mm(HL,ML),np.r_[np.eye(116,dtype=np.uint8),np.zeros((43,116),dtype=np.uint8)]),'H_L M_L = [I_116;0]')
 check(rank(H)==315 and rank(HL)==159,'elimination transforms invertible')
 check(all(np.array_equal(T[i],mm(H[235:],D['raw'][i])) for i in range(19)),'all 19 full T pencil coefficients')
 check(all(np.array_equal(Q[i],mm(HL[116:],D['rawL'][i])) for i in range(19)),'all 19 full Q pencil coefficients')
 AG=np.concatenate([T[i,:,23:] for i in range(19)],axis=1);NA=D['alpha_annihilator']
 check(rank(AG)==51 and rank(NA)==29 and not np.any(mm(NA,AG)),'full 19-coordinate alpha annihilator')
 check(all(np.array_equal(D['F'][i],mm(NA,T[i,:,:23])) for i in range(19)),'f-only tensor from full alpha annihilator')
 B=np.load(ROOT/'data/blocks.npz');F=D['F'];mid=np.arange(11,19)
 for key,ids,n in [('B',range(10),10),('C',range(10,16),6),('Omitted',range(16,19),13)]:
  X=F[list(ids)][:,:,mid].transpose(1,0,2).reshape(29,-1);RR,piv=rref(X)
  check(len(piv)==n and np.array_equal(B[key].reshape(n,-1),mm(B[key+'_rows'],X)) and np.array_equal(B[key].reshape(n,-1),RR[:n]),key+' exact reduced row span')
 XB=F[:10][:,:,mid].transpose(1,0,2).reshape(29,-1)
 XC=F[10:16][:,:,mid].transpose(1,0,2).reshape(29,-1)
 XO=F[16:19][:,:,mid].transpose(1,0,2).reshape(29,-1)
 check(rank(np.concatenate([XB,XC,XO],axis=1))==29,'the three projected source column spaces form a direct sum (10+6+13)')
 Wdata=np.load(ROOT/'data/middle_system.npz');W=Wdata['W'];X=T[:16][:,:,list(mid)+list(range(23,35))].transpose(1,0,2).reshape(80,-1)
 WX=mm(Wdata['row_transform'],X)
 check(rank(Wdata['row_transform'])==80 and not np.any(WX[67:]) and np.array_equal(WX[:67],W.reshape(67,-1)),'67-equation full middle incidence, all corrections retained')
 U=np.load(ROOT/'data/unmatched.npz')
 for key,gi in [('A','groupA'),('B','groupB'),('C','groupC')]:check(np.array_equal(U[key],W[U[gi]]),'character row group '+key)
 all_rows=np.concatenate([U['groupA'],U['groupB'],U['groupC']])
 check(sorted(all_rows.tolist())==list(range(67)) and [len(U[k]) for k in ['groupA','groupB','groupC']]==[30,23,14],'character groups partition all 67 equations')
 for group,key in enumerate(['A','B','C']):
  for r,ss,m in np.argwhere(U[key]):
   allowed=((ss<10 and m<15) or (ss>=10 and m==19)) if group==0 else (((ss>=10 and m<15) or (ss<10 and 15<=m<19)) if group==1 else ((ss>=10 and 15<=m<19) or (ss<10 and m==19)))
   assert allowed
 check(True,'all off-block coefficients vanish; character separation is exact')
 check(rank(U['H'])==14,'14-row normalization transform is invertible')
 EI=json.loads((ROOT/'certificates/source_C_gamma_injection.json').read_text())
 check(np.array_equal(np.array(EI['matrix'],dtype=np.uint8),U['A'][:,10:,19]) and np.array_equal(mm(np.array(EI['left_inverse'],dtype=np.uint8),np.array(EI['matrix'],dtype=np.uint8)),np.eye(6,dtype=np.uint8)),'source C gamma injection: exact left inverse of the 30x6 coefficient matrix')
 C=U['C'];check(np.array_equal(U['SB'],C[:,:10,19]) and np.array_equal(U['SC'],C[:,10:,15:19]),'unmatched tensor extraction')
 check(np.array_equal(mm(U['H'],U['SB']),np.r_[np.eye(10,dtype=np.uint8),np.zeros((4,10),dtype=np.uint8)]),'source block SB injective; fixed normalization')
 check(np.array_equal(mm(U['H'],U['SC'].reshape(14,24)),U['CD'].reshape(14,24)),'exact elimination of ten source coordinates when gamma=1')
 cm=list(itertools.combinations_with_replacement(range(6),2));co={m:i for i,m in enumerate(cm)};Mc=np.zeros((84,84),dtype=np.uint8)
 for k in range(6):
  for r in range(14):
   for i in range(6):
    for j in range(4):Mc[k*14+r,co[tuple(sorted((k,i)))]*4+j]=U['SC'][r,i,j]
 cert=np.load(ROOT/'certificates/unmatched_gamma0.npz')
 check(np.array_equal(Mc,cert['matrix']),'84x84 matrix consists exactly of c_k times the unmatched equations')
 check(np.array_equal(mm(cert['inverse'],Mc),np.eye(84,dtype=np.uint8)) and np.array_equal(mm(Mc,cert['inverse']),np.eye(84,dtype=np.uint8)),'two-sided exact 84x84 inverse: geometric gamma=0 correction lemma')
 N=np.load(ROOT/'data/necessary_tensor.npz')['N'];NN=np.zeros_like(N);CD=U['CD']
 for r in range(6):
  for l in range(4):
   for i in range(8):NN[r*4+l,i*4+l,:]=B['C'][r,:,i]
 for r in range(4):
  for i in range(8):
   for k in range(4):NN[24+r*8+i,i*4+k,:]=CD[10+r,:,k]
 for r in range(10):
  for i in range(8):
   for j in range(6):
    for k in range(4):
     v=0
     for a in range(10):v=int(ADD[v,MUL[B['B'][r,a,i],CD[a,j,k]]])
     NN[56+r,i*4+k,j]=NEG[v]
 check(np.array_equal(N,NN),'66x32 necessary linear pencil, including all source rank boundaries')
 RS=np.load(ROOT/'data/residual_system.npz')
 check(np.array_equal(RS['H'],U['A'][:,:10,:15].transpose(0,2,1)) and np.array_equal(RS['J'],U['B'][:,10:,:15].transpose(0,2,1)),'exact residual 30-plus-23 equation tensors')
 c=np.array([16,22,12,7,21,1],dtype=np.uint8);z=np.r_[np.zeros(10,dtype=np.uint8),c]
 tm=contract_last(T[:16].transpose(1,2,0),z);qm=contract_last(Q[:16].transpose(1,2,0),z)
 check(rank(tm)==28 and rank(qm)==12,'explicit pure-v sanity point: Hom dimensions 7 and 4, not a witness')
 # Direct original formulas versus the algebraically shortened implementation.
 rng=np.random.default_rng(20260925);uv=uv_powers(False)
 for test in range(2):
  zz=rng.integers(0,25,16);u={};v={}
  for cc,(uu,vv) in zip(zz,uv):u=add(u,scale(uu,int(cc)));v=add(v,scale(vv,int(cc)))
  f=poly(rng.integers(0,25,len(basis(31))),basis(31));al=poly(rng.integers(0,25,len(basis(20))),basis(20));g0=mon(basis(131)[-1-test]);q0=mon(basis(120)[-2-test])
  a,q,r,ff,g,h,bb,dd=raw_equations(u,v,f,al,g0,q0,True);ps=sub(a,mul(e,f));bb2=add(mul(E,g),mul(add(v,mul(u,E)),f));dd2=add(neg(mul(e,h)),mul(E,sub(q,mul(e,g))),mul(add(v,mul(u,E)),ps))
  check(bb==bb2 and dd==dd2,'direct original map formulas agree, exact sample '+str(test+1))
 if args.rebuild:
  with tempfile.TemporaryDirectory() as td:
   td=Path(td);(td/'src').mkdir();(td/'data').mkdir();(td/'certificates').mkdir()
   for name in ['exact.py','build.py']:shutil.copy2(ROOT/'src'/name,td/'src'/name)
   subprocess.run([sys.executable,str(td/'src/build.py')],check=True)
   for path in list((td/'data').glob('*.npz'))+list((td/'certificates').glob('*.npz')):
    relative=path.relative_to(td);a=np.load(path);b=np.load(ROOT/relative)
    check(set(a.files)==set(b.files) and all(np.array_equal(a[k],b[k]) for k in a.files),'full reconstruction agrees: '+str(relative))
   check(json.loads((td/'data/conventions.json').read_text())==json.loads((ROOT/'data/conventions.json').read_text()),'full reconstruction conventions')
  check(json.loads((td/'certificates/source_C_gamma_injection.json').read_text())==json.loads((ROOT/'certificates/source_C_gamma_injection.json').read_text()),'full reconstruction agrees: source C gamma left inverse')
 print('ALL REQUESTED CHECKS PASSED. This verifies the stated partial results, not by itself the final existence decision.',flush=True)
if __name__=='__main__':main()
