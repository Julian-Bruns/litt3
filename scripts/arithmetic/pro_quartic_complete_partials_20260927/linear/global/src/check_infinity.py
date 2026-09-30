"""Global infinity factor and universal leading scale-tail identities.
This is not an exclusion of finite scale solutions.
"""
from pathlib import Path
import json,sys
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'src'));sys.path.insert(0,str(ROOT/'conceptual/src'))
import field as F,poly as U,evaluate as E,polynomial_model as PM
from check_concepts import theta_for
from laurent import LP
F.init()

def pevalrows(p,Hq):
 H,q=Hq
 out=0
 for (i,j,_,__),v in p:
  out=F.add(out,F.mul(v,F.mul(F.powk(H,i),F.powk(q,j))))
 return out

def hrow(p,q):
 out=[]
 for (i,j,_,__),v in p:
  while len(out)<=i:out.append(0)
  out[i]=F.add(out[i],F.mul(v,F.powk(q,j)))
 return U.trim(out)

def main():
 d=LP({(0,0,0,0):47171,(0,1,0,0):357608})
 psi=LP({tuple(e)+(0,0):v for e,v in PM.DATA['Psi']})
 k=F.div(F.scale(F.powk(24,6),2),F.powk(E.EPS,6))
 c=F.div(F.scale(F.powk(24,2),3),F.powk(E.EPS,2))
 assert F.powk(c,3)==k
 om=next(a for a in range(2,25) if F.powk(a,3)==1)
 factors=[psi-(d**2).shift((3,2,0,0))*LP({(0,0,0,0):F.mul(c,F.powk(om,j))}) for j in range(3)]
 p=psi**3-(d**6).shift((9,6,0,0))*LP({(0,0,0,0):k})
 prod=LP({(0,0,0,0):1})
 for f in factors:prod=prod*f
 assert prod==p
 completed_q=64426
 row=hrow(p.data(),completed_q)
 row=U.scale(row,F.inv(row[-1]))
 assert len(row)==10 and U.gcd(row,U.deriv(row))==[1]
 assert U.gcd(row,hrow(psi.data(),completed_q))==[1]
 assert row[0]
 checks=[]
 for h,w,lam in [(1,1,1),(2,3,4),(101,102,103),(251,12345,625)]:
  dic,_,fs,_=E.cramer(h,w)
  ts=[theta_for(dic,v) for v in (0,1,4)]
  th0=ts[0];th1=U.cscale(U.csub(ts[1],ts[2]),3)
  th2=U.cscale(U.csub(U.cadd(ts[1],ts[2]),U.cscale(ts[0],2)),3)
  u2=F.mul(F.scale(F.powk(24,2),4),F.powk(E.EPS,10))
  aa=F.div(F.scale(F.powk(h,3),3),F.powk(E.EPS,2))
  bb=F.neg(F.div(fs[6],F.powk(24,2)))
  u0=F.mul(u2,F.mul(aa,bb));u1=F.neg(F.mul(u2,F.add(aa,bb)))
  assert U.coeff(th0[2],40)==u0
  assert U.coeff(th1[1],42)==u1
  assert U.coeff(th2[0],44)==u2
  # Two extra scale evaluations recover the three edge coefficients of the norm.
  # x136 has scale degree3; x132 has scale degree6. Use the character norm edge directly.
  q0=F.powk(u0,3)
  q1=F.sub(F.powk(u1,3),F.scale(F.mul(u0,F.mul(u1,u2)),3))
  q2=F.powk(u2,3)
  assert q0==F.mul(q2,F.powk(F.mul(aa,bb),3))
  assert q1==F.neg(F.mul(q2,F.add(F.powk(aa,3),F.powk(bb,3))))
  assert F.add(F.powk(q1,2),F.mul(q0,q2))==F.mul(F.powk(q2,2),F.powk(F.sub(F.powk(aa,3),F.powk(bb,3)),2))
  q=F.powk(w,3);H=F.div(h,w);dq=F.add(47171,F.mul(357608,q))
  pv=pevalrows(p.data(),(H,q))
  # a^3+b^3=-p/(24^6 q^3 d^6).
  factor=F.neg(F.inv(F.mul(F.powk(24,6),F.mul(F.powk(q,3),F.powk(dq,6)))))
  assert F.add(F.powk(aa,3),F.powk(bb,3))==F.mul(factor,pv)
  checks.append({'h':h,'w':w,'F6':fs[6],'a':aa,'b':bb,'theta_edge':[u0,u1,u2],'norm_edge':[q0,q1,q2],'identities':True})
 # Universal identities in q0,q1,q2,U0,U1,V0,V1,W0,W1,W2,X0,X1.
 # Only Q^12,Q^11,Q^10 are needed after the universal q0^50 factor.
 # Use a small characteristic-five symbolic polynomial ring, not evaluations.
 sys.path.insert(0,str(ROOT/'conceptual/src'))
 from sparse5 import Poly
 n=12
 def var(i):return Poly(n,{tuple(int(j==i) for j in range(n)):1})
 def const(c):return Poly(n,{(0,)*n:c})
 zero=const(0)
 q0,q1,q2,aa,bb,cc,dd,ee,ff,gg,hh,ii=[var(i) for i in range(n)]
 def addp(a,b):return [(a[i] if i<len(a) else zero)+(b[i] if i<len(b) else zero) for i in range(max(len(a),len(b)))]
 def mulp(a,b):
  out=[zero for _ in range(len(a)+len(b)-1)]
  for i,x in enumerate(a):
   for j,y in enumerate(b):out[i+j]=out[i+j]+x*y
  return out
 def powp(a,e):
  b=[const(1)]
  while e:
   if e&1:b=mulp(b,a)
   e//=2
   if e:a=mulp(a,a)
  return b
 Q=[q0,q1,q2];UU=[aa,bb];VV=[cc,dd];WW=[ee,ff,gg]
 Q12=powp(Q,12);Q13=mulp(Q12,Q)
 rhs72=2*(q1**6)*(q2**5)*(q1*q1+q0*q2)
 assert Q13[18]==rhs72
 lhs71=3*(Q12[17]*aa+Q12[16]*bb)
 rhs71=(q1**5)*(q2**5)*(aa*(q1*q1+2*q0*q2)+2*bb*q0*q1)
 assert lhs71==rhs71
 Q11=powp(Q,11);Q10=powp(Q,10)
 lhs73=3*mulp(Q12,WW)[18]+mulp(Q11,mulp(UU,VV))[17]+mulp(Q10,powp(UU,3))[16]
 rhs73=2*(q1**5)*(q2**5)*(3*mulp(mulp(Q,Q),WW)[3]+mulp(Q,mulp(UU,VV))[2]+powp(UU,3)[1])
 assert lhs73==rhs73
 XX=[hh,ii]
 # Weight four: the coefficient of lambda^53 in the 72nd tail.
 lhs72next=3*mulp(Q12,XX)[17]+mulp(Q11,addp(mulp(UU,WW),[3*x for x in powp(VV,2)]))[17]+3*mulp(Q10,mulp(powp(UU,2),VV))[16]
 rhs72next=2*(q1**5)*(q2**5)*(3*mulp(mulp(Q,Q),XX)[2]+mulp(Q,addp(mulp(UU,WW),[3*x for x in powp(VV,2)]))[2]+3*mulp(powp(UU,2),VV)[1])
 assert lhs72next==rhs72next
 result={'scope':'Global leading-scale degree-drop factor; not a finite-square exclusion.',
         'C_K_code':k,'cube_root_C_K_code':c,'zeta3_K_code':om,
         'p_infty_definition':'Psi^3-C*q^6*d(q)^6*H^9',
         'p_infty_Hq_terms':p.data(),'cubic_factor_Hq_terms':[f.data() for f in factors],
         'degrees_H_q':[max(e[0] for e in p.d),max(e[1] for e in p.d)],
         'completed_fibre_q':completed_q,'completed_fibre_p_monic':row,
         'completed_fibre_checks':{'degree':9,'squarefree':True,'coprime_H_Psi':True},
         'identification_with_input_p':'Follows from these checks, the universal leading-tail vanishing, and the accepted degree-nine resultant-gcd input. No giant resultant rerun is claimed.',
         'edge_coefficient_diagnostics':checks,
         'universal_tail_leading_identities_symbolically_checked':True,
         'second_tail_next_coefficient_divisible_by_q1_fifth_power':True,
         'number_universal_identities':4}
 (ROOT/'global/data/infinity_factor.json').write_text(json.dumps(result,indent=2)+'\n')
 print(json.dumps({'status':'PASS','p_degrees':result['degrees_H_q'],'completed_p':row,'universal_tail_identities':True,'source_edge_diagnostics':len(checks),'finite_square_decision':'UNRESOLVED'},indent=2))
if __name__=='__main__':main()
