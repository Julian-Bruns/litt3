"""Exact, exhaustive local branch-incidence spectrum; NOT a solution search.
All ten roots of P are treated, hence all 100 ordered root pairs.
"""
import json, random
from pathlib import Path
from ff25 import *
ROOT=Path(__file__).resolve().parents[1]
DATA=json.loads((ROOT/'inputs/coefficients.json').read_text())
P,A=DATA['P'],DATA['A']
def factor_equal_degree(f,d):
    if len(f)-1==d: return [pmonic(f)]
    rng=random.Random(81403+len(f))
    for attempt in range(200):
        a=[rng.randrange(25) for _ in range(len(f)-1)]
        g=pgcd(f,psub(ppow(a,(25**d-1)//2,f),[1]))
        if 1<len(g)<len(f):
            return factor_equal_degree(g,d)+factor_equal_degree(pexact(f,g),d)
    raise RuntimeError('deterministic factorization attempt cap reached')
linear_roots=[a for a in range(25) if peval(P,a)==0]
remaining=P
for a in linear_roots: remaining=pexact(remaining,[neg(a),1])
factors=sorted(factor_equal_degree(remaining,4))
H=factors[0]
# F_(25^4) represented in ascending base-25 digits modulo H.
Q=25**4

def unpack(a):
    z=[]
    for _ in range(4): z.append(a%25); a//=25
    return z

def pack(a): return sum(v*25**i for i,v in enumerate(a))
def ea(a,b): return pack([add(x,y) for x,y in zip(unpack(a),unpack(b))])
def en(a): return pack([neg(x) for x in unpack(a)])
def es(a,b): return ea(a,en(b))
def em(a,b): return pack(pmod(pmul(unpack(a),unpack(b)),H))
def ep(a,n):
    if n<0:
        if not a: raise ZeroDivisionError('zero in extension')
        n %= Q-1
    z=1
    while n:
        if n&1: z=em(z,a)
        a=em(a,a); n//=2
    return z

def etrim(a):
    a=list(a)
    while a and a[-1]==0: a.pop()
    return a

def epa(a,b):
    c=list(a)+[0]*max(0,len(b)-len(a))
    for i,v in enumerate(b): c[i]=ea(c[i],v)
    return etrim(c)
def epsub(a,b): return epa(a,[en(x) for x in b])
def epm(a,b):
    if not a or not b: return []
    c=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b):
            if x and y: c[i+j]=ea(c[i+j],em(x,y))
    return etrim(c)
def epdm(a,b):
    a=etrim(a); b=etrim(b)
    if not b: raise ZeroDivisionError
    quo=[0]*max(0,len(a)-len(b)+1); z=ep(b[-1],-1)
    while a and len(a)>=len(b):
        k=len(a)-len(b); c=em(a[-1],z); quo[k]=c
        for j,v in enumerate(b): a[j+k]=es(a[j+k],em(c,v))
        a=etrim(a)
    return etrim(quo),a
def epmod(a,m): return epdm(a,m)[1]
def eppow(a,n,m):
    z=[1]
    while n:
        if n&1: z=epmod(epm(z,a),m)
        a=epmod(epm(a,a),m); n//=2
    return z
def epgcd(a,b):
    while b: a,b=b,epmod(a,b)
    z=ep(a[-1],-1)
    return [em(x,z) for x in a]
def evale(poly,x):
    z=0
    for a in reversed(poly): z=ea(em(z,x),a)
    return z

def roots_over_extension(f):
    if len(f)==2: return [em(en(f[0]),ep(f[1],-1))]
    rng=random.Random(52900+sum(f))
    for attempt in range(200):
        a=[rng.randrange(Q) for _ in range(len(f)-1)]
        g=epgcd(f,epsub(eppow(a,(Q-1)//2,f),[1]))
        if 1<len(g)<len(f):
            quo,rem=epdm(f,g); assert not rem
            return roots_over_extension(g)+roots_over_extension(quo)
    raise RuntimeError('root splitting attempt cap reached')

def compute():
    # Degree-four Rabin irreducibility check.
    assert pgcd(H,psub(ppow([0,1],25**2,H),[0,1]))==[1]
    assert pmod(psub(ppow([0,1],25**4,H),[0,1]),H)==[]
    assert pgcd(P,pder(P))==[1]
    assert pgcd(P,A)==[1] and pgcd(P,pder(A))==[1]
    roots=sorted(roots_over_extension(P))
    assert len(roots)==10 and len(set(roots))==10
    assert all(evale(P,x)==0 for x in roots)
    assert all(ep(x,Q)==x for x in roots)
    prod=[1]
    for x in roots: prod=epm(prod,[en(x),1])
    assert prod==P
    Pd,Ad=pder(P),pder(A)
    kval=[em(em(ep(evale(Pd,x),26),ep(evale(Ad,x),13)),ep(evale(A,x),-61)) for x in roots]
    assert all(kval)
    hvalue=lambda x: em(em(ep(evale(Pd,x),2),evale(Ad,x)),ep(evale(A,x),-1))
    mval=[em(ep(hvalue(x),4),ep(evale(A,x),-17)) for x in roots]
    lval=[em(hvalue(x),ep(evale(A,x),-4)) for x in roots]
    assert len(set(mval))==10 and len(set(lval))==10
    pairs=[]; ratios={}
    for i,alpha in enumerate(roots):
        for j,beta in enumerate(roots):
            ratio=em(kval[j],ep(kval[i],-1))
            r=em(evale(A,beta),ep(evale(A,alpha),-1))
            h=lambda x: em(em(ep(evale(Pd,x),2),evale(Ad,x)),ep(evale(A,x),-1))
            hrat=em(h(beta),ep(h(alpha),-1))
            assert ratio==em(ep(hrat,13),ep(r,-48))
            b_over_eps7=em(ep(r,11),ep(hrat,-3))
            pairs.append({'alpha_index':i,'beta_index':j,'epsilon29':ratio,'b_over_epsilon7':b_over_eps7,'b29':em(ep(hrat,4),ep(r,-17)),'epsilon_b4':em(hrat,ep(r,-4))})
            ratios.setdefault(ratio,[]).append([i,j])
    assert len(ratios)==91 and len(ratios[1])==10
    assert all(len(v)==1 for r,v in ratios.items() if r!=1)
    assert all((i==j)==(em(kval[j],ep(kval[i],-1))==1) for i in range(10) for j in range(10))
    spectrum=sorted(ratios)
    polynomial=[1]
    for r in spectrum: polynomial=epm(polynomial,[en(r),1])
    assert all(x<25 for x in polynomial), 'spectrum polynomial failed descent to F25'
    assert pgcd(polynomial,pder(polynomial))==[1]
    assert all(evale(polynomial,x)==0 for x in spectrum)
    out={
        'scope':'exhaustive local spectrum at points ramified for both t and the cubic reconstruction; not an existence search',
        'F25_polynomial_factors': [[neg(x),1] for x in linear_roots]+factors,
        'extension_modulus_over_F25':H,
        'extension_encoding':'sum_{i=0}^3 digit_i*25^i, each digit_i is the F25 code; eta is the class of X modulo the displayed quartic',
        'roots_of_P_in_extension':roots,'K_values':kval,'distinct_K_values':len(set(kval)),
        'M_values_for_b29':mval,'L_values_for_epsilon_b4':lval,
        'distinct_M_values':len(set(mval)),'distinct_L_values':len(set(lval)),
        'ordered_pairs':pairs,
        'distinct_ratios':len(spectrum),'ratio_multiplicities':{str(r):len(v) for r,v in sorted(ratios.items())},
        'spectrum_polynomial_ascending_F25':polynomial,
        'epsilon_polynomial':'spectrum_polynomial(epsilon^29)',
        'epsilon_polynomial_degree':29*len(spectrum),
        'nonzero_epsilon_roots_count':29*len(spectrum)
    }
    print('P factor degrees:',[1]*len(linear_roots)+[len(f)-1 for f in factors])
    print('Extension modulus:',H)
    print('Roots:',roots)
    print('Distinct K values:',len(set(kval)))
    print('Distinct M and L values:',len(set(mval)),len(set(lval)))
    print('Ordered root pairs:',len(pairs))
    print('Distinct ratios:',len(spectrum))
    from collections import Counter
    print('Ratio multiplicity histogram:',dict(sorted(Counter(map(len,ratios.values())).items())))
    print('Squarefree spectrum degree:',len(polynomial)-1)
    print('Squarefree epsilon spectrum degree:',29*len(spectrum))
    print('All exact checks PASS; no global compatibility claim made.')
    return out

if __name__=='__main__':
    import argparse
    ap=argparse.ArgumentParser(); ap.add_argument('--output',type=Path); ap.add_argument('--check',type=Path)
    args=ap.parse_args(); out=compute()
    if args.output: args.output.write_text(json.dumps(out,indent=2,sort_keys=True)+'\n')
    if args.check:
        assert out==json.loads(args.check.read_text()),'stored spectrum differs'
        print('Stored spectrum matches exact regeneration.')
