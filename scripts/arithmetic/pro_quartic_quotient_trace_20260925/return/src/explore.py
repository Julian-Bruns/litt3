from exact import *
from pathlib import Path
D=np.load(Path(__file__).resolve().parents[1]/'data/matrices.npz')
T,Q,S,J=[D[x] for x in ['T','Q','S','J']]
print('coordinate ranks T Q S:')
for j in range(19):print(j,rank(T[j]),rank(Q[j]),rank(S[j]))
for nm,A in [('T',T),('Q',Q),('S',S)]:
 print(nm,'row span flattened rank',rank(A.transpose(1,0,2).reshape(A.shape[1],-1)),'column flatten rank',rank(A.reshape(-1,A.shape[2])))
 print(nm,'support per coord',[int(np.count_nonzero(a)) for a in A])
print('W basis b sparse');wm=L(151)
for col in range(11): print(col,poly(D['Wb'][:,col],wm))
print('J',J.tolist())
print('S nonzero rows by column',[[i for i in range(32) if np.any(S[:,i,j])] for j in range(11)])
rng=np.random.default_rng(9134)
for rep in range(10):
 z=rng.integers(0,25,19,dtype=np.uint8)
 print('random',rep,rank(evaluate(T,z)),rank(evaluate(Q,z)),rank(evaluate(S,z)))
print('S_w basis ranks', [rank(S[:,:,i].T) for i in range(11)])
for rep in range(10):
 w=rng.integers(0,25,11,dtype=np.uint8)
 Sw=np.column_stack([dot(S[j],w) for j in range(19)])
 print('w random',rep,rank(Sw))
