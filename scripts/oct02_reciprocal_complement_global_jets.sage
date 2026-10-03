#!/usr/bin/env sage
"""Universal H0(F*Nperp) via the complete 17-section augmentation basis."""
import json,time
from pathlib import Path
started=time.time()
L=FunctionField(GF(5),'s');s=L.gen()
K=FunctionField(L,'x');x=K.gen();F=(x**4-1)*(x+s**2)
zero=(K.zero(),K.zero());one=(K.one(),K.zero())
def add(a,b):return (a[0]+b[0],a[1]+b[1])
def scale(a,c):return (a[0]*c,a[1]*c)
def mul(a,b):return (a[0]*b[0]+F*a[1]*b[1],a[0]*b[1]+a[1]*b[0])
def der(a):return (a[0].derivative(),a[1].derivative()+a[1]*F.derivative()/(2*F))
def jet(first,tau=zero):
 out=[zero,first]
 for j in range(1,4):out.append(scale(add(der(out[-1]),mul(tau,out[-1])),K(1)/(j+1)))
 return out
def jmul(a,b):return [sum_pair([mul(a[i],b[j-i]) for i in range(j+1)]) for j in range(5)]
def sum_pair(values):
 out=zero
 for a in values:out=add(out,a)
 return out
eta=(K.zero(),1/F);tau=scale(eta,2*s*x)
J=jet(eta);Jx=jet(scale(eta,x))
N0=jet(eta,tau);Nx=jet(scale(eta,x),tau)
unit=[one]+[zero]*4
def jpow(a,n):
 out=unit
 for _ in range(n):out=jmul(out,a)
 return out
sections=[];labels=[]
for n in range(1,5):
 for a in range(n+1):sections.append(jmul(jpow(J,a),jpow(Jx,n-a)));labels.append('J^%s Jx^%s'%(a,n-a))
sections.append([zero,zero,zero,(1/F,K.zero()),(-F.derivative()/(2*F**2),K.zero())]);labels.append('order3_even')
sections.append([zero]*4+[(K.zero(),1/F**2)]);labels.append('order4_odd_0')
sections.append([zero]*4+[(K.zero(),x/F**2)]);labels.append('order4_odd_1')
assert len(sections)==17
def pair(a,b):return sum_pair([scale(mul(a[i],b[5-i]),5-2*i) for i in range(1,5)])
values=[[pair(n,g) for g in sections] for n in [N0,Nx]]
# Direct universal sections needed for the proof, independently of rank.
c1=[L.zero()]*17;c2=[L.zero()]*17
for j,c in [(0,1),(2,3*s),(5,s**2),(9,4*s**3)]:c1[j]=c
for j,c in [(1,1),(3,3*s),(6,s**2),(10,4*s**3),(16,s**2)]:c2[j]=c
direct=[[sum_pair([scale(sections[j][h],cs[j]) for j in range(17)]) for h in range(5)] for cs in [c1,c2]]
assert all(pair(n,g)==zero for n in [N0,Nx] for g in direct)
minor=add(mul(direct[0][1],direct[1][2]),scale(mul(direct[0][2],direct[1][1]),-1))
assert minor==(2/F,K.zero())
# The first section is the canonical A^3 embedding: its connection is -3 tau.
for j in range(1,5):
 connection=der(direct[0][j])
 if j<4:connection=add(connection,scale(direct[0][j+1],-(j+1)))
 assert connection==scale(mul(tau,direct[0][j]),-3)
rows=[]
for equation in range(2):
 for char in range(2):
  col=[values[equation][j][char] for j in range(17)]
  denominator=lcm([f.denominator() for f in col])
  polys=[(f*denominator).numerator() for f in col]
  rows.extend([[p[k] for p in polys] for k in range(max(p.degree() for p in polys)+1)])
matrix0=matrix(L,rows);kernel=matrix0.right_kernel_matrix()
ks=[]
for row in kernel.rows():ks.append([sum_pair([scale(sections[j][h],row[j]) for j in range(17)]) for h in range(5)])
wedge_nonzero=False;witness=None
if len(ks)>=2:
 for i in range(1,5):
  for j in range(i+1,5):
   w=add(mul(ks[0][i],ks[1][j]),scale(mul(ks[0][j],ks[1][i]),-1))
   if w!=zero:wedge_nonzero=True;witness=[i,j];break
  if witness:break
out={'scope':'universal smooth Y_S, S=-s^2; complete 17 global augmentation jet sections',
 'matrix_shape':[matrix0.nrows(),matrix0.ncols()],'rank':matrix0.rank(),
 'h0_F_Nperp':kernel.nrows(),'first_two_sections_generic_wedge_nonzero':wedge_nonzero,
 'wedge_witness':witness,'basis_labels':labels,
 'direct_two_sections_orthogonal':True,'direct_minor_equals_2_over_F':True,
 'first_section_character_A_cubed':True,
 'kernel_coefficients':[[str(a) for a in row] for row in kernel.rows()],
 'seconds':time.time()-started,'sage_version':version()}
dest=Path('../litt3-computation-data/oct02_reciprocal_twisted_cartier');dest.mkdir(exist_ok=True)
(dest/'complement_global_jets.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
print(json.dumps(out,indent=2,default=int))
