"""Executed low-degree certificate attempt on the FULL map-direction space.
Success on a monomial is ideal membership, not a complete decision by itself.
"""
from exact import *
from prolong import *
import pathlib,json,time
ROOT=pathlib.Path(__file__).resolve().parents[1]
T=np.load(ROOT/'data/pencils.npz')['T'];meta=json.load(open(ROOT/'data/bases.json'))
zg=np.empty(19,dtype=np.int64)
zg[[0,6,7]]=0;zg[list(range(1,6))+list(range(8,13))]=1;zg[13:]=2
wg=np.array([(j+(1 if typ=='alpha' else 0))%3 for typ,i,j in meta['w_basis']],dtype=np.int64)
rg=np.zeros(80,dtype=np.int64)
for r in range(80):
 inds=np.argwhere(T[:,r,:]);grades={(int(zg[z])+int(wg[w]))%3 for z,w in inds};assert len(grades)==1;rg[r]=grades.pop()
indices,nm=prolong_index(35,2);upper=monomial_tuples(35,2)
mg=np.array([sum(wg[i] for i in m)%3 for m in upper],dtype=np.int64)
colgrade=np.concatenate([(mg+zg[z])%3 for z in range(19)])
rowgrade=np.concatenate([(rg+wg[w])%3 for w in range(35)])
t=time.time();M=matrix_prolong(T,np.arange(35),indices,nm)
print('global matrix built',M.shape,'seconds',time.time()-t,flush=True)
unit=np.zeros(19*nm,dtype=bool);ranks=[]
for c in range(3):
 rows=np.flatnonzero(rowgrade==c);cols=np.flatnonzero(colgrade==c)
 R,p=rref(M[rows][:,cols]);ranks.append(len(p))
 counts=np.count_nonzero(R[:len(p)],axis=1)
 for i in np.flatnonzero(counts==1):unit[cols[p[i]]]=True
 print('grade',c,'shape',R.shape,'rank',len(p),'units',int(unit.sum()),'seconds',time.time()-t,flush=True)
flags=np.array([[bool(unit[z*nm+upper.index((j,j))]) for z in range(13)] for j in range(23)])
np.savez_compressed(ROOT/'data/global_degree_two.npz',unit=unit,flags=flags,ranks=np.array(ranks),rowgrade=rowgrade,colgrade=colgrade)
print('pure f-square memberships by f coordinate',flags.sum(axis=1).tolist(),flush=True)
print('total units',int(unit.sum()),'elapsed',time.time()-t,flush=True)
