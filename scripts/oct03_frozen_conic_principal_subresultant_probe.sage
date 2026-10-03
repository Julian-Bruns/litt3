"""Fresh bounded arbitrary-geometric ordinary finite-C10 necessary gate.

No Groebner basis, no finite-field sample replay, no group enumeration.
At the stated ordinary finite locus, contact >=10 makes the frozen-conic
norm N have a root of multiplicity >=10, hence gcd(N,dN/dX) degree >=9.
For fixed degrees46,45, all principal subresultant coefficients PSC0..8
then vanish. Both degrees stay fixed away from s=0,1 because LC(N)=
s^22(1-s). The explicitly excluded s=0,1 are preserved in every output.

This instrumented exact polynomial subresultant algorithm emits a flushed
checkpoint at every remainder. It stores every used PSC, and may stop as
soon as their common factor away from s=0,1 is one. Partial checkpoints
do not claim a decision. Run externally with30s timeout and one thread.
"""
from sage.all import *
import json, time
started=time.monotonic()
k=GF(25,name='beta',modulus=GF(5)['b'].gen()**2-GF(5)['b'].gen()-3)
beta=k.gen()
def elt(n): return k(n%5)+k(n//5)*beta
def code(a):
    v=a.polynomial().list()
    return int(v[0] if v else 0)+5*int(v[1] if len(v)>1 else 0)
def emit(obj):
    obj['elapsed_seconds']=time.monotonic()-started
    print(json.dumps(obj),flush=True)

# One tiny deficient-remainder calibration BEFORE the large PRS, in the
# same bounded process. This is a new algorithm/index check, not a replay
# of the fixed-curve numerical probe. Installed Sage's subresultants code
# uses the same pseudo-remainder and scaling formulas.
Rw=PolynomialRing(k,'W');W=Rw.gen()
tiny_f=W**4+W**2+W+1
tiny_g=W**3+W
def tiny_indexed_subresultants(f,g):
    a=g;b=f.pseudo_quo_rem(-g)[1]
    scale=g.leading_coefficient()**(f.degree()-g.degree())
    out={}
    while b:
        da=int(a.degree());eb=int(b.degree());delta=da-eb
        out[da-1]=b
        if delta>1:
            c=Rw(b.leading_coefficient()**(delta-1)*b/scale**(delta-1))
            out[eb]=c
            for j in range(eb+1,da-1): out[j]=Rw.zero()
        else: c=b
        if eb==0: break
        b=Rw(a.pseudo_quo_rem(-b)[1]/(scale**delta*a.leading_coefficient()))
        a=c;scale=a.leading_coefficient()
    return out
tiny_indexed=tiny_indexed_subresultants(tiny_f,tiny_g)
tiny_builtin=tiny_f.subresultants(tiny_g)
assert [tiny_indexed[j] for j in sorted(tiny_indexed) if tiny_indexed[j]]==tiny_builtin
assert tiny_indexed[2].degree()==1  # S2 deficient, and PSC2 zero.
tiny_minors={}
for j in range(3):
    m=int(tiny_f.degree());n=int(tiny_g.degree())
    rows=[W**e*tiny_f for e in range(n-j-1,-1,-1)]
    rows +=[W**e*tiny_g for e in range(m-j-1,-1,-1)]
    cols=list(range(m+n-j-1,j-1,-1))
    principal=matrix(k,[[row[e] for e in cols] for row in rows]).det()
    assert principal==tiny_indexed[j][j]
    tiny_minors[j]=code(principal)
emit({'event':'tiny_deficient_subresultant_check','verdict':'PASS',
      'f':str(tiny_f),'g':str(tiny_g),
      'indexed_nonzero_subresultants':{str(j):str(v) for j,v in tiny_indexed.items() if v},
      'principal_Sylvester_minor_codes':tiny_minors,
      'builtin_Sage_nonzero_subresultants':[str(v) for v in tiny_builtin],
      'installed_algorithm':'Sage polynomial_element.pyx subresultants, schoolbook Ducos/Lazard scaling'})
Rs=PolynomialRing(k,'s');s=Rs.gen()
R=PolynomialRing(Rs,'X');X=R.gen()
P=sum(elt(n)*X**i for i,n in enumerate([11,22,18,5,19,20,15,16,9,22,1]))
shift=P(X-1);square=shift**2
even=sum(square[2*i]*X**i for i in range(11))
odd=sum(square[2*i+1]*X**i for i in range(10))
d0=elt(23);T=s*X**2+d0*(s-1)
A=T**2*odd(T);B=T*even(T)
C=A-s**11*X**3*shift**2
N=C**2-T*B**2
Nd=N.derivative()
assert N.degree()==46 and Nd.degree()==45
assert N.leading_coefficient()==s**22*(1-s)
assert Nd.leading_coefficient()==N.leading_coefficient()
emit({'event':'initialized','degree_N':46,'degree_N_derivative':45,
      'maximum_coefficient_degree_s':max(int(c.degree()) for c in N.list() if c),
      'leading_coefficient':'s^22*(1-s)',
      'retained_exceptions':['s=0','s=1'],
      'scope':'ordinary finite: Xi,q0(xi),P(xi) nonzero; kappa^3=1; necessary gate only'})

def scalar_exact_div(poly,den):
    coeff=[]
    for c in poly.list():
        q,r=c.quo_rem(den)
        assert r==0
        coeff.append(q)
    return R(coeff)

used={};candidate=None
def strip_known(poly):
    if poly==0: return poly
    for factor in [s,s-1]:
        while poly.degree()>0:
            q,r=poly.quo_rem(factor)
            if r!=0: break
            poly=q
    return poly.monic()

def record_psc(j,poly):
    global candidate
    if j<0 or j>8: return False
    value=Rs(poly[j])
    if j in used:
        assert used[j]==value
        return False
    used[j]=value
    if value:
        candidate=value if candidate is None else gcd(candidate,value)
    reduced=None if candidate is None else strip_known(candidate)
    emit({'event':'principal_subresultant','index':int(j),
          'coefficient_degree_s':-1 if value==0 else int(value.degree()),
          'coefficient_codes':[code(c) for c in value.list()],
          'used_indices':sorted(int(i) for i in used),
          'common_factor_away_from_known_exceptions_degree':None if reduced is None else int(reduced.degree()),
          'common_factor_away_from_known_exceptions_codes':None if reduced is None else[code(c) for c in reduced.list()]})
    if reduced is not None and reduced.degree()==0:
        emit({'event':'necessary_gate_excluded','used_indices':sorted(int(i) for i in used),
              'conclusion':'No root multiplicity>=10 for any geometric s outside0,1; only stated ordinary finite locus',
              'unresolved':['s=1 diagonal frozen branch','finite P-branches','Xi=0','q0=0','actual source existence']})
        return True
    return False

# Instrumented schoolbook subresultants, equivalent to Sage's documented
# polynomial_element.subresultants algorithm. A has degree d, B=S_(d-1)
# may have smaller degree e; if d-e>1 the scaled C is S_e. Intervening
# principal coefficients vanish. No polynomial gcd over k(s) is substituted
# for these integral principal subresultants.
A=Nd
scale=Nd.leading_coefficient()**(N.degree()-Nd.degree())
B=N.pseudo_quo_rem(-Nd)[1]
step=0
decided=False
while B:
    step+=1
    da=int(A.degree());eb=int(B.degree());delta=da-eb
    assert delta>=1
    emit({'event':'subresultant_remainder','step':step,'index':da-1,'degree_X':eb,
          'maximum_coefficient_degree_s':max(int(c.degree()) for c in B.list() if c)})
    if record_psc(da-1,B):
        decided=True;break
    if delta>1:
        C=scalar_exact_div(B.leading_coefficient()**(delta-1)*B,scale**(delta-1))
        for j in range(eb+1,da-1):
            if record_psc(j,R.zero()):
                decided=True;break
        if decided: break
        if record_psc(eb,C):
            decided=True;break
    else:
        C=B
    if eb==0: break
    denominator=scale**delta*A.leading_coefficient()
    B=scalar_exact_div(A.pseudo_quo_rem(-B)[1],denominator)
    A=C
    scale=A.leading_coefficient()
if not decided:
    reduced=None if candidate is None else strip_known(candidate)
    emit({'event':'finished_unresolved','used_indices':sorted(int(i) for i in used),
          'common_factor_degree':None if reduced is None else int(reduced.degree()),
          'common_factor_codes':None if reduced is None else[code(c) for c in reduced.list()],
          'conclusion':'Necessary candidate factor retained; no arbitrary-geometric decision beyond emitted data'})
