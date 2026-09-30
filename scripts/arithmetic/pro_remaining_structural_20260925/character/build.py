"""Rebuild all exact pencil data from the specified Laurent transitions."""
import time,json,itertools,sys,platform
from pathlib import Path
import numpy as np
from exact import *
ROOT=Path(__file__).resolve().parents[1];t=time.time()
def log(*x):print(round(time.time()-t,2),*x,flush=True)
fm=basis(31);am=basis(20);gm=basis(131);qm=basis(120);nm=basis(24);lm=basis(124)
log('Python',platform.python_version(),'NumPy',np.__version__)
log('basis dimensions',*[len(a) for a in [fm,am,gm,qm,nm,lm]])
M=np.column_stack([raw_equations({},{},{},{},g0=mon(m)) for m in gm]+[raw_equations({},{},{},{},q0=mon(m)) for m in qm])
Mr,piv,H=rref(M,True);assert len(piv)==235;log('constant K',M.shape,'rank',len(piv))
ML=np.column_stack([raw_L({},{},{},mon(m)) for m in lm]);MLr,pivL,HL=rref(ML,True);assert len(pivL)==116;log('constant L',ML.shape,'rank',len(pivL))
raw=[];Ts=[];rawLs=[];Qs=[]
for j,(U,V) in enumerate(uv_powers()):
 R=np.column_stack([raw_equations(U,V,mon(m),{}) for m in fm]+[raw_equations(U,V,{},mon(m)) for m in am]);S=np.column_stack([raw_L(U,V,mon(m)) for m in nm])
 raw.append(R);Ts.append(mm(H[235:],R));rawLs.append(S);Qs.append(mm(HL[116:],S));log('coordinate',j,'T rank',rank(Ts[-1]),'Q rank',rank(Qs[-1]))
T=np.array(Ts);Q=np.array(Qs);AG=np.concatenate([T[j,:,23:] for j in range(19)],axis=1);NA=nullspace(AG.T).T;assert NA.shape==(29,80)
F=np.array([mm(NA,T[j,:,:23]) for j in range(19)]);log('global alpha span rank',rank(AG))
np.savez_compressed(ROOT/'data/pencils.npz',M=M,H=H,ML=ML,HL=HL,raw=np.array(raw),rawL=np.array(rawLs),T=T,Q=Q,alpha_annihilator=NA,F=F)
blocks={};mid=np.arange(11,19)
for key,ids in [('B',range(10)),('C',range(10,16)),('Omitted',range(16,19))]:
 X=F[list(ids)][:,:,mid].transpose(1,0,2);R,piv,HH=rref(X.reshape(29,-1),True);n=len(piv)
 blocks[key]=R[:n].reshape(n,len(ids),8);blocks[key+'_rows']=HH[:n];log(key,blocks[key].shape)
np.savez_compressed(ROOT/'data/blocks.npz',**blocks)
W0=T[:16][:,:,list(mid)+list(range(23,35))].transpose(1,0,2);R,piv,HH=rref(W0.reshape(80,-1),True);W=R[:len(piv)].reshape(-1,16,20);assert W.shape==(67,16,20)
np.savez_compressed(ROOT/'data/middle_system.npz',W=W,row_transform=HH)
groups=[[],[],[]]
for i,row in enumerate(W):
 types=set()
 for s,m in np.argwhere(row):
  if (s<10 and m<15) or (s>=10 and m==19):types.add(0)
  if (s>=10 and m<15) or (s<10 and 15<=m<19):types.add(1)
  if (s>=10 and 15<=m<19) or (s<10 and m==19):types.add(2)
 assert len(types)==1;groups[types.pop()].append(i)
A=W[groups[0]];BB=W[groups[1]];C=W[groups[2]];SB=C[:,:10,19];SC=C[:,10:,15:19]
RR,piv,H3=rref(SB,True);assert piv==list(range(10));CD=mm(H3,SC.reshape(14,24)).reshape(14,6,4)
np.savez_compressed(ROOT/'data/unmatched.npz',A=A,B=BB,C=C,SB=SB,SC=SC,H=H3,CD=CD,groupA=groups[0],groupB=groups[1],groupC=groups[2]);log('row groups',list(map(len,groups)),'SB rank',rank(SB))
EC=A[:,10:,19];_,epiv,EH=rref(EC,True);assert len(epiv)==6
(ROOT/'certificates/source_C_gamma_injection.json').write_text(json.dumps(dict(field='F25: beta^2=beta+3',matrix=EC.tolist(),left_inverse=EH[:6].tolist(),identity='left_inverse * matrix = I6',matrix_origin="data/unmatched.npz: A[:,10:,19]"),indent=2)+'\n')
log('source C gamma coefficient rank',len(epiv))
cm=list(itertools.combinations_with_replacement(range(6),2));co={m:i for i,m in enumerate(cm)};Mc=np.zeros((84,84),dtype=np.uint8)
for k in range(6):
 for r in range(14):
  for i in range(6):
   for j in range(4):Mc[k*14+r,co[tuple(sorted((k,i)))]*4+j]=SC[r,i,j]
R,piv,MI=rref(Mc,True);assert len(piv)==84;assert np.array_equal(mm(MI,Mc),np.eye(84,dtype=np.uint8))
np.savez_compressed(ROOT/'certificates/unmatched_gamma0.npz',matrix=Mc,inverse=MI);log('gamma=0 Macaulay rank',len(piv))
Bf=blocks['B'];Cf=blocks['C'];N=np.zeros((66,32,6),dtype=np.uint8)
for r in range(6):
 for l in range(4):
  for i in range(8):N[r*4+l,i*4+l,:]=Cf[r,:,i]
for r in range(4):
 for i in range(8):
  for k in range(4):N[24+r*8+i,i*4+k,:]=CD[10+r,:,k]
for r in range(10):
 for i in range(8):
  for j in range(6):
   for k in range(4):
    v=0
    for a in range(10):v=int(ADD[v,MUL[Bf[r,a,i],CD[a,j,k]]])
    N[56+r,i*4+k,j]=NEG[v]
np.savez_compressed(ROOT/'data/necessary_tensor.npz',N=N)
np.savez_compressed(ROOT/'data/residual_system.npz',H=A[:,:10,:15].transpose(0,2,1),J=BB[:,10:,:15].transpose(0,2,1))
meta=dict(field='F5[beta]/(beta^2-beta-3)',encoding='a+5b means a+b*beta, 0<=a,b<5',f_monomials=fm,alpha_monomials=am,g0_monomials=gm,q0_monomials=qm,n0_monomials=nm,a0_monomials=lm,source_names=[f'a{i}' for i in range(1,6)]+[f'b{i}' for i in range(1,6)]+[f'c{i}' for i in range(1,7)]+['u_y_x^-1','v_x^-2','v_x^-1'],source_variables='25th powers of extension coordinates',middle_map_order=['p'+str(i) for i in range(8)]+['alpha_const'+str(i) for i in range(7)]+['alpha_y'+str(i) for i in range(4)]+['gamma'],row_groups=groups)
(ROOT/'data/conventions.json').write_text(json.dumps(meta,indent=2)+'\n');log('SAVED')
