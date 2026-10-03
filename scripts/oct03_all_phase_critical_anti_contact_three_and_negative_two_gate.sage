"""PREPARED ONLY: NEW arbitrary-phase contact-three AND negative-phase contact-two gate.

No execution authorized. Fixed p, source z-index>=4, z(P)^3=1,
ordinary A/B/p units, q-zero included, arbitrary original kappa^3.
Triple frozen G_rho=p(-A)^2+rho*p(A)^2 entails H=H'=0.
ONE tiny new process tests H squarefree and the pure-even/odd factors.
Negative phase rho=-1 contact-two additionally requires pe or po repeated.
No old c2/c3, PSC/resultant/weight/Frobenius replay or phase sampling.
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
p=sum(elt(a)*A**i for i,a in enumerate([8,3,21,23,22,12,22,21,1,22,1]))
pp=p.derivative()
pe=sum(p[i]*A**i for i in range(0,11,2));po=p-pe
H=pp(-A)*p+p(-A)*pp
assert H==2*(pe*po.derivative()-pe.derivative()*po)
assert H.degree()==18 and H[18]==k(18)*p[9] and H[0]==2*p[0]*p[1]
assert H[0]!=0 and all(H[i]==0 for i in range(1,19,2))
Hp=H.derivative();assert Hp.degree()==17
emit({'event':'critical_anti_contact_three_setup','p_coefficients':codes(p),
      'field':'F25,beta^2=beta+3;a+5b encoding',
      'scope':'all original phases; ordinary nonzero A/B/p units, q-zero included; z(P)^3=1,source index>=4',
      'necessity':'triple root G_rho implies H=H_derivative=0',
      'H_coefficients':codes(H),'H_derivative_coefficients':codes(Hp)})
g,B0,B1=H.xgcd(Hp);assert B0*H+B1*Hp==g
row={'event':'critical_anti_contact_three_result','common_factor_coefficients':codes(g)}
if g.degree()==0:
    scale=g[0]**(-1);B0*=scale;B1*=scale
    assert B0*H+B1*Hp==1
    row.update({'verdict':'PASS','Bezout_H_coefficients':codes(B0),
                'Bezout_H_derivative_coefficients':codes(B1),
                'identity':'B0*H+B1*H_derivative=1',
                'conclusion':'no geometric critical ordinary anti-diagonal source index>=4 in any phase'})
else:
    row.update({'verdict':'UNRESOLVED','conclusion':'multiple-H exceptional locus remains; no whole exclusion'})
emit(row)

negative=[]
for label,g in [('even',pe),('odd',po)]:
    gp=g.derivative();common,C0,C1=g.xgcd(gp)
    assert C0*g+C1*gp==common
    row={'event':'negative_phase_anti_contact_two_result','factor':label,
         'g_coefficients':codes(g),'g_derivative_coefficients':codes(gp),
         'common_factor_coefficients':codes(common)}
    if common.degree()==0:
        scale=common[0]**(-1);C0*=scale;C1*=scale
        assert C0*g+C1*gp==1
        row.update({'verdict':'PASS','Bezout_g_coefficients':codes(C0),
                    'Bezout_gp_coefficients':codes(C1),
                    'identity':'C0*g+C1*g_derivative=1'})
        negative.append(True)
    else:
        row.update({'verdict':'UNRESOLVED'});negative.append(False)
    emit(row)
emit({'event':'all_phase_and_negative_anti_complete',
      'negative_phase_both_squarefree':all(negative),
      'negative_scope':'rho=-1,z(P)^3=1,ordinary nonzero A/B/p units incl q-zero,source index>=3',
      'negative_conclusion':'no geometric critical ordinary anti-diagonal source index>=3 at rho=-1'
          if all(negative) else 'negative-phase double-root locus unresolved',
      'no_source_decision':'remaining actual degree25/30/35 packets are not decided here'})

