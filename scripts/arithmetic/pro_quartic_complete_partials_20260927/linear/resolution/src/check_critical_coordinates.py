"""Global source coordinates and four complete monic cubic charts.

No new square-locus exclusion is claimed. All identities are exact over K.
"""
from __future__ import annotations
import json,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path[:0]=[str(ROOT/'src'),str(ROOT/'intersection/src')]
import field as F,poly as U
from critical_cover import xgcd
F.init()

def plus(*polys):
 out=[]
 for p in polys:out=U.add(out,p)
 return out

def discriminant(a,b,c,e):
 return plus(U.mul(U.powp(b,2),U.powp(c,2)), U.mul(a,U.powp(c,3)),
             U.mul(U.powp(b,3),e),U.scale(U.mul(U.powp(a,2),U.powp(e,2)),3),
             U.scale(U.mul(U.mul(U.mul(a,b),c),e),3))

def s_eval(rows,s):
 return plus(*(U.scale(row,F.powk(s,i)) for i,row in enumerate(rows)))

def invert_matrix(mat):
 n=len(mat); m=[row[:]+[int(i==j) for j in range(n)] for i,row in enumerate(mat)]
 for j in range(n):
  r=next(i for i in range(j,n) if m[i][j]);m[j],m[r]=m[r],m[j]
  m[j]=[F.div(x,m[j][j]) for x in m[j]]
  for i in range(n):
   if i!=j:
    v=m[i][j];m[i]=[F.sub(x,F.mul(v,y)) for x,y in zip(m[i],m[j])]
 return [row[n:] for row in m]

def main():
 if sys.flags.optimize:raise RuntimeError('Assertions must be enabled')
 old=json.loads((ROOT/'data/cube_free.json').read_text())
 d=old['d_q_ascending'];psi_rows=[[] for _ in range(4)]
 for (h,q),v in old['Psi']:
  psi_rows[h]+=[0]*max(0,q+1-len(psi_rows[h]));psi_rows[h][q]=v
 primitive=[U.exactdiv(p,d) for p in psi_rows]
 assert [U.mul(p,d) for p in primitive]==psi_rows
 a0=U.exactdiv(primitive[3],[0,0,1]);b=U.exactdiv(primitive[2],[0,1]);c=primitive[1];e=U.shift(primitive[0],1)
 assert [len(x)-1 for x in [a0,b,c,e]]==[1,5,6,9]
 g,ub,uc=xgcd(b,c)
 assert g==[1]
 assert plus(U.mul(ub,b),U.mul(uc,c))==[1]
 # a(q,s)=a0(q)-s*d(q). D is the cubic discriminant in u.
 D0=discriminant(a0,b,c,e)
 D1=plus(U.scale(U.mul(d,U.powp(c,3)),4),U.scale(U.mul(U.mul(a0,d),U.powp(e,2)),4),U.scale(U.mul(U.mul(U.mul(d,b),c),e),2))
 D2=U.scale(U.mul(U.powp(d,2),U.powp(e,2)),3)
 Ds=[D0,D1,D2]
 assert [len(x)-1 for x in Ds]==[24,21,20]
 for s in [0,1,2,3,4,101]:
  assert s_eval(Ds,s)==discriminant(U.sub(a0,U.scale(d,s)),b,c,e)
 # Four evaluation values on the projective u-line.
 taus=[0,1,2,3]
 V=[[F.powk(t,j) for j in range(4)] for t in taus];Vi=invert_matrix(V)
 weights=[plus(U.scale(ub,Vi[2][j]),U.scale(uc,Vi[1][j])) for j in range(4)]
 evaluations=[];chart_rows=[]
 total=[[],[]]
 for j,t in enumerate(taus):
  E0=plus(e,U.scale(c,t),U.scale(b,F.powk(t,2)),U.scale(a0,F.powk(t,3)))
  E1=U.scale(d,F.neg(F.powk(t,3)))
  evaluations.append([E0,E1])
  total=[U.add(total[i],U.mul(weights[j],rr)) for i,rr in enumerate([E0,E1])]
  # f(t+1/z)*z^3 = a + (3*a*t+b) z + f'(t) z^2 + f(t) z^3.
  z0=[a0,U.neg(d)]
  z1=[plus(U.scale(a0,F.scale(t,3)),b),U.scale(d,F.neg(F.scale(t,3)))]
  z2=[plus(U.scale(a0,F.scale(F.powk(t,2),3)),U.scale(b,F.scale(t,2)),c),U.scale(d,F.neg(F.scale(F.powk(t,2),3)))]
  z3=[E0,E1]
  chart_rows.append([z0,z1,z2,z3])
 assert total==[[1],[]]
 inf=json.loads((ROOT/'global/data/infinity_factor.json').read_text())
 cs=[F.mul(inf['cube_root_C_K_code'],F.powk(inf['zeta3_K_code'],j)) for j in range(3)]
 special=[]
 for j,s in enumerate(cs):
  Di=s_eval(Ds,s)
  assert len(Di)==25 and U.gcd(Di,U.deriv(Di))==[1]
  assert U.gcd(Di,U.sub(a0,U.scale(d,s)))==[1]
  # Comparison with old discriminants is done from the old coefficients.
  oldrows=[[] for _ in range(4)]
  for (h,q,xx,yy),v in inf['cubic_factor_Hq_terms'][j]:
   assert xx==yy==0
   oldrows[h]+=[0]*max(0,q+1-len(oldrows[h]));oldrows[h][q]=v
  old_disc=discriminant(oldrows[3],oldrows[2],oldrows[1],oldrows[0])
  assert old_disc==U.mul(U.shift(U.powp(d,4),2),Di)
  special.append({'s_K_code':s,'discriminant_q_ascending':Di,'discriminant_degree':24,'squarefree':True,'coprime_leading_u_coefficient':True})
 out={
  'scope':'Global change of source coordinates and complete monic cubic chart cover. NOT a decision of the square locus.',
  'field':'K and codes from data/input.json',
  'new_variables':{'u':'q*H=h*w^2','s':'F6/h^3=Psi/(q^2*d(q)^2*H^3)'},
  'Psi_exact_factorization':{'factor_d':d,'primitive_H_rows_ascending_q':primitive,'primitive_bidegree_H_q':[3,8]},
  'F6_simplification':'F6=Psi_primitive/(q*d)',
  'cubic_f':{'definition':'f(u)=(a0-s*d)*u^3+b*u^2+c*u+e', 'a0':a0,'d':d,'b':b,'c':c,'e':e,'q_degrees_a0_b_c_e':[1,5,6,9]},
  'primitive_form_certificate':{'identity':'ub*b+uc*c=1','ub':ub,'uc':uc},
  'discriminant':{'definition':'D(q,s)=sum s^j*D_j(q)','s_rows_ascending_q':Ds,'row_degrees_q':[24,21,20]},
  'charts':{'taus':taus,'f_tau_s_rows_ascending_q':evaluations,'weights_q_ascending':weights,'cover_identity':'sum weights_tau*f(tau)=1','z_polynomials_ascending':chart_rows,'monic_relation':'listed z-polynomial divided by f(tau)','source_open':'z*(1+tau*z)!=0, in addition to original base units','coordinate_inverse':'u=tau+1/z, H=u/q'},
  'infinity_degree_drop':{'equation':'s^3=Cinf','Cinf_K_code':inf['C_K_code'],'three_s_K_codes':cs,'original_identity':'pinf=q^6*d^6*H^9*(s^3-Cinf)','no_new_fibre_exclusion':True},
  'special_cubics':special,
  'scheme_scope':'Ring isomorphism after adding s by its unit-denominator definition; chart cover and localization valid over arbitrary K-algebras, including nilpotents.'
 }
 path=ROOT/'resolution/data/critical_coordinates.json';path.write_text(json.dumps(out,indent=2)+'\n')
 print(json.dumps({'status':'PASS','Psi_common_factor_d':'proved by polynomial division','primitive_Psi_bidegree':[3,8],'cubic_q_degrees':[1,5,6,9],'global_cover_identity':'1','discriminant_bidegree':[24,2],'special_s_K_codes':cs,'special_discriminants_squarefree':True,'square_locus_decision':'UNRESOLVED'},indent=2))
if __name__=='__main__':main()
