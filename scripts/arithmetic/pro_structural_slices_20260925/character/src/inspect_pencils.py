from exact import *
from pathlib import Path
D=np.load(Path(__file__).resolve().parents[1]/'data/pencils.npz');T=D['T'];Q=D['Q']
fs=basis_L(31); al=basis_L(20)
print('f',fs,'alpha',al)
print('T global row rank',rank(T.transpose(1,0,2).reshape(80,-1)))
print('Q global row rank',rank(Q.transpose(1,0,2).reshape(43,-1)))
print('T support count per z',np.count_nonzero(T,axis=(1,2)))
print('T row support count',np.count_nonzero(T,axis=(0,2)))
for j in range(3):
 cols=[i for i,b in enumerate(fs) if b[1]==j]+list(range(23,35))
 A=T[:,:,cols]
 print('slice',j,'cols',len(cols),'linear eq rank',rank(A.transpose(1,0,2).reshape(80,-1)))
 print('alpha only eq rank',rank(T[:,:,23:].transpose(1,0,2).reshape(80,-1)))
 # Eliminate equations involving alpha: left kernel of flattened tensor.
 L=kernel(T[:,:,23:].transpose(1,0,2).reshape(80,-1).T).T
 At=np.stack([mm(L,T[z,:,:23]) for z in range(19)])
 print('alpha elimination left dim',L.shape, 'f-only eq rank in slice',rank(At[:,:,[i for i,b in enumerate(fs) if b[1]==j]].transpose(1,0,2).reshape(L.shape[0],-1)))
 for jj in range(3):
  c=[i for i,b in enumerate(fs) if b[1]==j]+[23+i for i,b in enumerate(al) if b[1]==jj]
  print('  alpha char',jj,'bilinear rank',rank(T[:,:,c].transpose(1,0,2).reshape(80,-1)))
np.savez_compressed(Path(__file__).resolve().parents[1]/'data/fonly.npz',L=L,At=At)
