"""Executed exact checks. Use --reconstruct to rebuild the complete Hom tensor.

 This verifies the stated partial results, NOT emptiness of the full P18 locus.
"""
from compute import *
import geometry,pencil,json,sys
D={k:v.copy() for k,v in np.load(ROOT/'hom_tensor.npz').items()}
if '--reconstruct' in sys.argv:
 build()
 rebuilt=np.load(ROOT/'hom_tensor.npz')
 assert all(np.array_equal(v,rebuilt[k]) for k,v in D.items())
 print('All tensor entries reconstructed from the supplied curve and cocycles.')
A,B,L,T=D['A'],D['B'],D['L'],D['T']
assert A.shape==(315,235) and B.shape==(19,315,35)
assert L.shape==(80,315) and T.shape==(19,80,35)
assert len(rref(A)[1])==235
assert len(rref(L)[1])==80
assert not matmul(L,A).any()
assert all(np.array_equal(T[j],matmul(L,B[j])) for j in range(19))
assert len(rref(ADD[T[13],MUL[18,T[15]]])[1])==35
print('Exact quotient reduction and counterexample regression verified.')
pencil.verify()
old=json.loads((ROOT/'stability_sections.json').read_text())
geometry.stability_sections()
assert old==json.loads((ROOT/'stability_sections.json').read_text())
print('Dual sections for the entire geometric stability surface reconstructed.')

# Independent multiplication of all transition matrices checks the divisor
# frame constraints for a nontrivial choice involving both u and v.
xi=np.zeros(19,np.uint8);xi[0]=1;xi[13]=1
ff=add(mono(),mono(1,1));aa=add(pos(mul(e,ff)),mono(3,0))
H,residual=geometry.full_column(xi,aa,ff,mono(2,1),mono(3,2),mono(2,0),mono(1,0))
u=mono(-1,1);v=mono(-6,2);U=power(u,25);V=power(v,25)
one=mono();zero={}
G=[[one,neg(u),neg(v)],[zero,one,neg(e)],[zero,zero,one]]
Gqi=[[one,U,add(V,mul(U,E))],[zero,one,E],[zero,zero,one]]
def matrix_product(A,B):
 return [[add(*(mul(A[i][k],B[k][j]) for k in range(3))) for j in range(3)] for i in range(3)]
HV=matrix_product(matrix_product(G,H),Gqi)
for i,dt in enumerate((-1,-5,6)):
 for j,ds in enumerate((-25,-125,150)):
  bad={m:c for m,c in HV[i][j].items() if 3*m[0]+10*m[1]>dt-ds}
  if j<2:assert not bad
  else:
   if i==2:keys,cs=bas1(-144),residual[:152]
   elif i==1:keys,cs=bas1(-155),residual[152:315]
   else:keys,cs=bas1(-151),residual[315:]
   expected={m:int(c) for m,c in zip(keys,cs) if c}
   assert bad==expected
print('Full 3x3 transition equation and all divisor-frame residuals checked.')
xx,yy=geometry.base_point()
assert (xx,yy)==(5,14)
assert geometry.evaluate(P,xx,yy)==int(MUL[MUL[yy,yy],yy])
print('Affine determinant test point P*=([5],[14]) verified on X.')
print('PASS: all stated partial certificates. Full strict-return locus remains undecided.')
