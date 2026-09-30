"""Exact countermodel to structural-only exclusion, NOT the prescribed G_i family.
Uses the same X, r, t and v. Its geometric square locus is one point.
"""
from pathlib import Path
import sys,json
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'src'));sys.path.insert(0,str(ROOT/'conceptual/src'))
sys.path.insert(0,str(ROOT/'intersection/src'));sys.path.insert(0,str(ROOT/'continuation/src'))
import field as F,poly as U,evaluate as E,polynomial_model as PM
from critical_cover import xgcd
from frobenius_rank import determinant
F.init()

# Polynomials in x with coefficients in K[B].
def trim(a):
 while a and not a[-1]:a.pop()
 return a
def add(a,b):return trim([U.add(a[i] if i<len(a) else [],b[i] if i<len(b) else []) for i in range(max(len(a),len(b)))])
def neg(a):return [U.neg(v) for v in a]
def sub(a,b):return add(a,neg(b))
def scale(a,c):return trim([U.scale(v,c) for v in a])
def byb(a,p):return trim([U.mul(v,p) for v in a])
def mul(a,b):
 if not a or not b:return []
 out=[[] for _ in range(len(a)+len(b)-1)]
 for i,c in enumerate(a):
  for j,d in enumerate(b):out[i+j]=U.add(out[i+j],U.mul(c,d))
 return trim(out)
def power(a,n):
 out=[[1]]
 while n:
  if n&1:out=mul(out,a)
  n//=2
  if n:a=mul(a,a)
 return out
def divmonic(a,p):
 assert p[-1]==1
 r=[v[:] for v in a];q=[[] for _ in range(max(0,len(a)-len(p)+1))]
 while len(r)>=len(p):
  k=len(r)-len(p);v=r[-1];q[k]=v
  for j,c in enumerate(p):r[j+k]=U.sub(r[j+k],U.scale(v,c))
  trim(r)
 return trim(q),r

def check_small_locus(T):
 # W=T+A*x+B*x^2; the x^9 equation on s!=0 forces A=A0+A1*B.
 p=E.P;t=T
 f1=F.sub(F.scale(t[3],3),p[9])
 f0=F.sub(F.add(F.scale(t[2],3),F.scale(F.powk(t[3],2),3)),F.add(F.mul(p[9],f1),p[8]))
 k0=F.sub(F.add(F.add(F.scale(t[1],3),F.mul(t[3],t[2])),F.powk(t[3],3)),
          F.add(F.add(F.mul(p[9],f0),F.mul(p[8],f1)),p[7]))
 k1=F.sub(t[3],F.scale(p[9],3))
 A=[F.scale(k0,3),F.scale(k1,3)]
 W=[[v] if v else [] for v in T]
 W[1]=U.add(W[1],A);W[2]=U.add(W[2],[0,1])
 FF,rem=divmonic(power(W,3),p)
 assert FF==[[f0,3],[f1],[1]]
 RR=sub(rem,FF) # W^3-(P+1)F
 assert len(RR)<=9 # coefficient x9 vanishes identically, not just at a sample.
 r8=RR[8]
 assert r8
 r82=U.mul(r8,r8);r83=U.mul(r82,r8);r84=U.mul(r82,r82)
 # After s=3/r8, multiply the remaining equations by r8^4.
 G=add(add(scale(byb(power(W,2),r84),2),scale(byb(RR,r83),3)),
       add(scale(byb(mul(W,FF),r82),4),power(FF,2)))
 assert len(G)<=8
 gcd=[];comb=[];selected=[]
 for i in range(len(G)-1,-1,-1):
  if not G[i]:continue
  gg,a,b=xgcd(gcd,G[i])
  comb=[U.mul(a,c) for c in comb]+[b]
  selected.append(i);gcd=gg
  if gcd==[1]:break
 assert gcd==[1],('nonempty unresolved countermodel boundary',gcd)
 check=[]
 for i,c in zip(selected,comb):check=U.add(check,U.mul(c,G[i]))
 assert check==[1]
 return {'normalization':'V=s*(T+A*x+B*x^2), s!=0',
         'A_ascending_B':A,'F_ascending_x_ascending_B':FF,
         'r8_ascending_B':r8,'s':'3/r8',
         'cleared_G_ascending_x_ascending_B':G,
         'bezout':{'selected_x_coefficients':selected,'coefficients_ascending_B':comb,'rhs':[1]},
         'conclusion':'The s!=0 locus is empty; on s=0 only a=b=0 is possible.'}

def main():
 v=[F.neg(9),1];T=U.mul(E.t,v);J0=U.add(E.P,[1])
 assert len(T)==5 and T[-1]==1 and U.gcd(T,U.deriv(T))==[1]
 assert U.gcd(J0,U.deriv(J0))==[1] and U.gcd(J0,E.P)==[1]
 psi11=PM.psi_at(1,1)
 assert psi11 and all(1!=q for q in (10149,118020,64426))
 loc=check_small_locus(T)
 # The six degree-two obstruction columns, rows in increasing polynomial degree.
 x=[0,1];x2=[0,0,1]
 cols=[U.scale(U.mul(x,x),2),U.scale(U.mul(x2,x2),2),U.scale(U.mul(T,T),2),
       U.scale(U.mul(x,x2),4),U.scale(U.mul(x,T),4),U.scale(U.mul(x2,T),4)]
 rows=[2,3,4,5,6,8];matrix=[[U.coeff(c,i) for c in cols] for i in rows]
 det=determinant(matrix);assert det==2
 # Exact degree-140 square at a=b=0, lambda=1.
 theta0=[[1],[4],[1]]  # (1+y)#=1-y+y^2
 ff=U.monomial(6,1)
 delta=U.cmulpoly(theta0,T)
 theta=U.cmul(U.cpow(ff,2),U.cmul(U.cpow(delta,2),theta0))
 J=U.mul(U.shift(E.P,18),U.mul(U.powp(T,3),U.powp(J0,3)))
 R=U.norm(theta)
 assert U.pole(delta)==32 and U.pole(theta)==140
 assert len(J)==71 and len(R)==141 and R==U.mul(J,J)
 c=F.scale(E.EPS,2)
 DD=U.cscale(delta,F.mul(c,c))
 Gamma=U.cscale(U.cmulpoly(U.cmul(U.cpow(ff,2),delta),U.powp(E.t,5)),F.powk(c,-3))
 t2=U.cmulpoly(U.cmul(U.cpow(ff,2),U.cpow(delta,2)),T)
 t1=U.cscale(t2,3) # coefficient lambda in (lambda-1)^2 is -2=3.
 t0=U.cadd(theta,t2)
 disc=U.csub(U.cpow(t1,2),U.cscale(U.cmul(t2,t0),4))
 assert U.cmulpoly(disc,U.powp(E.t,10))==U.cmul(U.cpow(DD,3),U.cpow(Gamma,2))
 assert U.pole(t2)==132 and U.pole(t1)==132 and U.pole(t0)==140
 u=U.cmul(ff,delta)
 assert t2==U.cmulpoly(U.cpow(u,2),T)
 assert U.norm(t2)==U.mul(T,U.powp(U.mul(T,U.norm(u)),2))
 # The critical-square obstruction is an exact global polynomial identity.
 # A=T*(1+a*x+b*x^2), B=-T,C=T => B^2-4AC=T^2*(2+a*x+b*x^2).
 # Distinct parameter coefficients are checked separately.
 T2=U.mul(T,T)
 for par,AA,expected in [('constant',T,U.scale(T2,2)),('a',U.shift(T,1),U.shift(T2,1)),('b',U.shift(T,2),U.shift(T2,2))]:
  lhs=U.scale(U.mul(AA,T),1) # -4=1
  if par=='constant':lhs=U.add(lhs,T2)
  assert lhs==expected
 out={'scope':'COUNTERMODEL ONLY. Does not satisfy or claim the prescribed source equations (1)-(7).',
      'same_curve_and_T':'X:y^3=P; T=t*(x-[9])',
      'family':'U_ab=1+a*x+b*x^2-y+y^2; delta=T*U_ab; f=x^6*y; Theta=f^2*delta^2*(U_ab+T*(lambda-1)^2)',
      'parameter_shift':'a=H-1, b=q-1; its unique geometric square point is H=q=lambda=1.',
      'uniform_critical_discriminant':'Delta=(2*epsilon)^2*T*U_ab; nonsquare for every geometric a,b',
      'global_square_obstruction':'T^2*(2+a*x+b*x^2) is never the zero polynomial',
      'scale_discriminant_identity':'disc_lambda(Theta)=Delta^3*Gamma^2/t^10; Gamma=t^5*f^2*delta/(2*epsilon)^3',
      'norm_leading_scale_coefficient':'T*(T*Norm(f*delta))^2, nonzero and nonsquare',
      'all_fibres_degree':140,'square_root_degree':70,
      'point':{'a':0,'b':0,'H':1,'q':1,'lambda':1,'Theta':theta,'J':J,
               'Psi_at_1_1':psi11,'old_ratio_open_satisfied':True},
      'small_norm_locus_certificate':loc,
      'small_norm_scheme':{'ideal_in_a_b_s':'(a,b,s)^2','after_s_equals_lambda_minus_1_squared':'(a,b,(lambda-1)^2)^2','length':8,
                          'WARNING':'This length is for the degree-20 norm before multiplying by a square. The degree-140 countermodel has the same geometric support but its scheme length is not computed.'},
      'hessian':{'columns':cols,'rows':rows,'matrix':matrix,'determinant':det},
      'checks':{'norm_identity':True,'J0_squarefree':True,'critical_identity':True,'s_nonzero_exclusion_Bezout':True,'quadratic_rank6':True},
      'not_the_requested_witness':True}
 (ROOT/'global/data/countermodel.json').write_text(json.dumps(out,indent=2)+'\n')
 print(json.dumps({'status':'PASS','norm_identity':True,'J_degree':70,'countermodel_geometric_square_support':'single point (H,q,lambda)=(1,1,1)',
  's_nonzero_bezout_indices':loc['bezout']['selected_x_coefficients'],'G_degrees':[len(v)-1 for v in loc['cleared_G_ascending_x_ascending_B']],
  'hessian_determinant':det,'NOT_the_original_source':True},indent=2))
if __name__=='__main__':main()
