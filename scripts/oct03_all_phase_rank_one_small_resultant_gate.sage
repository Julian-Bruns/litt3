"""PREPARED ONLY: arbitrary-phase ordinary contact-five finite locus.

No new numerical execution is authorized by this file.
Changed purpose: two 6x6 Sylvester determinants for the explicit static
quadratic/quartic rank-one locus. NO degree46 norm, PSC, or eta=1 replay.
An exact ordinary frozen contact-five point with s!=0,1 must satisfy
E=H=C=0, hence BOTH displayed univariate resultants vanish.
A gcd supported only on s=0,1 excludes the whole ordinary locus.
Any other factor is UNRESOLVED: no field sampling, lost degree-drop
stratum, or sufficient actual-source existence claim is permitted.
"""
from sage.all import *
import json,time
started=time.monotonic()
k=GF(25,name='beta',modulus=GF(5)['b'].gen()**2-GF(5)['b'].gen()-3)
beta=k.gen()
def elt(n): return k(n%5)+k(n//5)*beta
def code(a):
    v=a.polynomial().list()
    return int(v[0] if v else 0)+5*int(v[1] if len(v)>1 else 0)
def codes(f): return [code(a) for a in f.list()]
def emit(d):
    d['elapsed_seconds']=time.monotonic()-started
    print(json.dumps(d),flush=True)
R=PolynomialRing(k,'s');s=R.gen()
S=PolynomialRing(R,'W');W=S.gen();d=elt(23);alpha=2+4*d
v=W+1;Q=W**2-d
c2=W**2+(4+4*d)*W+4+d
c3=(1+3*d)*W**2+4*d*W+1+2*d
c4=W**2+d*W+3+2*d
E=s**2*(s+1)*c2+alpha*s**2*c3+(s+1)*v
D=s**3*c3-s**4*c2+2*d*s**2*c4
N=s**2*c4+(2-d)*v-(d+3)*D
H=N*D-2*d*v**2
C=(N-v)**2-d*v**2-s**5*v**2*Q
assert E.degree()==2 and H.degree()==4 and C.degree()==4
def nested(f): return [codes(R(a)) for a in f.list()]
emit({'event':'all_phase_rank_one_setup','field':'F25,beta^2=beta+3;a+5b encoding',
      'E_W_coefficients_s_ascending':nested(E),
      'H_W_coefficients_s_ascending':nested(H),
      'C_W_coefficients_s_ascending':nested(C),
      'scope':'ordinary A,B,p,q units;s!=0,1;arbitrary nonzero eta;necessary contact-five gate',
      'exceptions':['s0','s1','center','p-branch','q-zero','infinity']})
EC=E.sylvester_matrix(C);EH=E.sylvester_matrix(H)
assert EC.nrows()==6 and EH.nrows()==6
rC=R(EC.det())
assert rC(-1)!=0 and rC.degree()<=28
emit({'event':'resultant_E_C','coefficients':codes(rC),'degree':int(rC.degree()),
      's_minus_one_value':code(rC(-1))})
rH=R(EH.det())
emit({'event':'resultant_E_H','coefficients':codes(rH),'degree':int(rH.degree())})
g,bC,bH=rC.xgcd(rH)
assert bC*rC+bH*rH==g
g=g.monic();scale=(bC*rC+bH*rH).leading_coefficient()**(-1)
bC*=scale;bH*=scale
assert bC*rC+bH*rH==g
residual=g
m0=0;m1=0
while residual.degree()>0 and residual(0)==0:
    residual,rem=residual.quo_rem(s);assert rem==0;m0+=1
while residual.degree()>0 and residual(1)==0:
    residual,rem=residual.quo_rem(s-1);assert rem==0;m1+=1
assert g==s**m0*(s-1)**m1*residual
row={'event':'all_phase_rank_one_resultant_complete',
     'gcd_coefficients':codes(g),'Bezout_rC_coefficients':codes(bC),
     'Bezout_rH_coefficients':codes(bH),'s0_multiplicity':m0,'s1_multiplicity':m1,
     'residual_coefficients':codes(residual),'residual_degree':int(residual.degree()),
     'identity':'bC*Res_W(E,C)+bH*Res_W(E,H)=s^m0*(s-1)^m1*residual'}
if residual.degree()==0:
    row.update({'verdict':'PASS','conclusion':'all geometric ordinary generic-s contact-five candidates absent, for every eta'})
else:
    row.update({'verdict':'UNRESOLVED','conclusion':'new exact finite necessary s factor remains; E,H,C and all units must still be imposed'})
emit(row)
