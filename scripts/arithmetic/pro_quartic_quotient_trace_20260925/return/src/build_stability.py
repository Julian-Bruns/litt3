from exact import *
from pathlib import Path
import json
ROOT=Path(__file__).resolve().parents[1]
bm=L(23); raw=np.column_stack([vec(mul(e,{m:1}),forbidden(12)) for m in bm]);bk=kernel(raw)
sec=[]
for j in range(bk.shape[1]):
 b=poly(bk[:,j],bm);sec.append((plus(mul(e,b)),b))
sec.extend([({m:1},{}) for m in L(12)])
assert len(sec)==19
pair=np.array([[add(mul(u,a),mul(v,b)).get((-1,2),0) for a,b in sec] for u,v in COORDS],dtype=np.uint8)
R,piv=rref(np.column_stack([pair,np.eye(19,dtype=np.uint8)]),19);assert len(piv)==19
pinv=R[:,19:];assert np.array_equal(dot(pair,pinv),np.eye(19,dtype=np.uint8))
dual=[]
for j in range(19):dual.append((linear_combination(pinv[:,j],[a for a,b in sec]),linear_combination(pinv[:,j],[b for a,b in sec])))
# t=x^3/y, t^3*x -> 1, t^10*y ->1. Fiber coefficients have weights12 and23.
fiber=np.array([[sub(a,mul(e,b)).get((4,0),0),b.get((1,2),0)] for a,b in dual],dtype=np.uint8).T
np.savez_compressed(ROOT/'data/stability.npz',b_kernel=bk,pairing=pair,pairing_inverse=pinv,infinity_fiber=fiber)
def dump(p):return [[i,j,int(c)] for (i,j),c in sorted(p.items(),key=lambda z:(z[0][1],z[0][0]))]
json.dump({'convention':'Pairs [a,b] of polynomials in regular affine frames; triples [x_exponent,y_exponent,F25_code]. Infinity fiber uses the transformed first entry a-e*b.','dual_sections':[[dump(a),dump(b)] for a,b in dual],'infinity_fiber':fiber.tolist()},open(ROOT/'data/stability_sections.json','w'),indent=2)
print('dimension',len(sec),'Serre pairing rank',rank(pair),'infinity fiber rank',rank(fiber))
