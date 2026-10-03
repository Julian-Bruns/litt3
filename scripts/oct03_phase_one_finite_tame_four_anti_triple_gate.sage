"""PREPARED ONLY: changed-purpose finite TAME index-four contact-three gate.

No execution is authorized. A new bounded one-thread lease is required.
This does NOT rerun the wild contact-five PSC or degree12 logarithmic gate.
At original phase kappa^3=1,z(P)^3=1,actual finite source z-index FOUR,
ord(dz)=3. At ordinary Xi/P units the frozen V=-A numerator has contact
at least THREE. Its factors normalize to fixed g_c=p_even+c*p_odd,
c=2 or3. A triple root requires g_c,g_c',HasseD2(g_c) common root.
This ONE tiny process emits those arrays and a complete Bezout identity,
or an explicit unresolved factor, separately for both fixed c-values.
"""
from sage.all import *
import json,time
started=time.monotonic()
k=GF(25,name='beta',modulus=GF(5)['b'].gen()**2-GF(5)['b'].gen()-3)
beta=k.gen()
def elt(n):return k(n%5)+k(n//5)*beta
def code(a):
    v=a.polynomial().list()
    return int(v[0] if v else 0)+5*int(v[1] if len(v)>1 else 0)
def codes(f):return [code(a) for a in f.list()]
def emit(d):
    d['elapsed_seconds']=time.monotonic()-started
    print(json.dumps(d),flush=True)
R=PolynomialRing(k,'A');A=R.gen()
P=sum(elt(a)*A**i for i,a in enumerate([11,22,18,5,19,20,15,16,9,22,1]))
p=P(A-1)
pe=sum(p[i]*A**i for i in range(0,11,2))
po=p-pe
emit({'event':'tame_four_contact_three_setup','p_coefficients':codes(p),
      'field':'F25,beta^2=beta+3;a+5b encoding',
      'scope':'actual finite source z-index4,original kappa^3=1,z^3=1,ordinary Xi/P units; q0 zeros included',
      'not_a_replay':['no PSC data','no logarithmic degree12 gate','no root enumeration']})
verdicts=[]
for c in [2,3]:
    g=pe+c*po;gp=g.derivative()
    g2=sum(k(binomial(i,2))*g[i]*A**(i-2) for i in range(2,g.degree()+1))
    assert g.degree()==10 and gp.degree()==8 and g2.degree()==7
    h,a,b=g.xgcd(gp);assert a*g+b*gp==h
    z,u,v=h.xgcd(g2);assert u*h+v*g2==z
    row={'event':'tame_four_anti_triple_result','odd_scale':c,
         'g_coefficients':codes(g),'g_derivative_coefficients':codes(gp),
         'g_Hasse_D2_coefficients':codes(g2),'common_factor_coefficients':codes(z)}
    if z.degree()==0:
        scale=z[0]**(-1);B0=scale*u*a;B1=scale*u*b;B2=scale*v
        assert B0*g+B1*gp+B2*g2==1
        row.update({'verdict':'PASS','Bezout_g_coefficients':codes(B0),
                    'Bezout_gp_coefficients':codes(B1),'Bezout_H2_coefficients':codes(B2),
                    'identity':'B0*g+B1*g_derivative+B2*HasseD2(g)=1'})
        verdicts.append(True)
    else:
        row['verdict']='UNRESOLVED';verdicts.append(False)
    emit(row)
emit({'event':'tame_four_contact_three_complete','both_pass':all(verdicts),
      'conclusion':'all geometric anti-diagonal contact-three roots absent' if all(verdicts)
      else 'necessary triple-root candidate factor remains; no whole exclusion'})
