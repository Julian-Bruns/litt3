#!/usr/bin/env python3
"""Execute bounded exact checks accompanying REPORT.md.

This does NOT search or decide the geometric mixed-phase comparison locus.
The finite-field witness is a test of the norm-alignment algebra only.
"""
from pathlib import Path
from itertools import product
from math import gcd as integer_gcd, comb
import argparse
import json
import platform
import sys
from exact import (F, Extension, trim, add, sub, scale, mul, power, mod,
    divmod_poly, gcd, powmod, derivative, compose_mod, evaluate, determinant,
    multiplication_matrix, characteristic_poly, norm_polynomial,
    inverse_primitive, irreducible_prime_degree)

ROOT=Path(__file__).resolve().parents[1]
DATA=json.loads((ROOT/'inputs/data.json').read_text())

def ensure(test, message):
    if not test: raise AssertionError(message)

def emit(message): print(message,flush=True)

def input_checks():
    P,A,Q=DATA['P'],DATA['A'],DATA['Q']
    ensure(F.mul(5,5)==8, 'iota^2=iota+3')
    ensure(all(F.mul(a,F.inv(a))==1 for a in range(1,25)), 'F25 inverses')
    ensure(derivative(Q)==mul(P,power(A,2)), "Q'=P*A^2")
    ensure(len(gcd(P,derivative(P)))==1, 'P squarefree')
    ensure(len(gcd(A,derivative(A)))==1, 'A squarefree')
    ensure(len(gcd(P,A))==1, 'gcd(P,A)=1')
    a=scale(A,F.inv(A[-1]))
    ensure(a==DATA['A_monic'], 'monic A row')
    x=[0,1]
    ensure(powmod(x,25**4,a)==x and len(gcd(a,sub(powmod(x,25**2,a),x)))==1,
           'A irreducible degree 4 over F25')
    z=DATA['zeta_minimal_over_F25']
    ensure(irreducible_prime_degree(z), 'zeta minimal polynomial irreducible')
    ensure(powmod(x,29,z)==[1] and mod(x,z)!=[1], 'zeta has order 29')
    ensure(pow(5,7,29)==28, '5^7=-1 modulo 29')
    ensure(integer_gcd(29,5**8-1)==1, 'unique b0 in F_(5^8)')
    K=Extension(a);alpha=K.element([0,1]);a4=K.embed(A[-1])
    pp,ap,app=derivative(P),derivative(A),derivative(derivative(A))
    AA=lambda row,elt:evaluate([K.embed(c) for c in row],elt,K)
    c=K.div(K.mul(K.integer(3),K.mul(K.pow(AA(ap,alpha),3),K.pow(AA(P,alpha),2))),K.pow(a4,3))
    b0=K.pow(c,pow(29,-1,K.order-1))
    ensure(K.pow(b0,29)==c,'b0^29=c_alpha')
    ca=[K.pow(c,25**i) for i in range(4)]
    ensure(len(set(ca))==4 and all(v!=K.zero for v in ca),'four distinct nonzero c_alpha')
    slope=K.div(K.mul(a4,K.pow(b0,4)),AA(ap,alpha))
    lam=K.mul(slope,K.sub(K.div(AA(pp,alpha),AA(P,alpha)),K.div(AA(app,alpha),AA(ap,alpha))))
    ensure(lam==K.element(DATA['Lambda_phase_one_row']), 'Lambda phase-one coefficient row')
    ensure(K.pow(lam,25)!=lam,'Lambda not in F25, hence not in K0')
    det=determinant(DATA['local_observability_matrix_F5'])
    ensure(det==3,'observability determinant')
    result={
      'Q_prime_equals_P_A_squared':True,'P_squarefree':True,'A_squarefree':True,
      'P_A_coprime':True,'A_irreducible_over_F25':True,
      'zeta_minimal_irreducible':True,'zeta_order':29,
      'c_alpha0_basis_codes':list(c),'b0_alpha0_basis_codes':list(b0),
      'Lambda_alpha0_basis_codes':list(lam),'observability_determinant':det,
      'not_checked':'The full five-label independence claim and previous endpoint exclusions remain supplied inputs.'}
    emit("PASS input arithmetic: Q'=PA^2; squarefreeness; A and zeta irreducible; c, b0, Lambda; determinant 3.")
    return result

def profile_checks():
    profiles=[]
    # Nonspecial ell != 1: a=(e,j)=(1,1), c=(3,2), d=(3,3).
    for a,c,d in product(range(6),range(3),range(2)):
        if a+2*c+3*d>5:continue
        weight=a+3*c+3*d
        delta=c+3*d+comb(a,2)+2*a*c+3*a*d+6*comb(c,2)+6*c*d
        ram=c+2*d
        profiles.append(dict(kind='ell!=1',a=a,c=c,d=d,weight=weight,
                             t_capacity=a+2*c+3*d,delta_lower=delta,ram=ram))
    # Special ell=1: b=(1,4), c=(3,2).
    for b,c in product(range(2),range(3)):
        if 4*b+2*c>5:continue
        weight=b+3*c
        delta=c+6*comb(c,2)+2*b*c
        ram=3*b+c
        profiles.append(dict(kind='ell=1',b=b,c=c,weight=weight,
                             t_capacity=4*b+2*c,delta_lower=delta,ram=ram))
    for p in profiles:
        ensure(2*p['delta_lower']+p['ram']>=8*p['weight']-30,
               'fiber inequality')
        ensure(p['weight']<=7,'weight at most 7')
    max_twice_gain=max(8*p['weight']-2*p['delta_lower']-p['ram'] for p in profiles)
    ensure(max_twice_gain==30,'sharp local gain 15')
    # Exhaustive dynamic program over 29 fibers. We allow arbitrary special
    # fibers here, a SUPERSET of actual patterns, so the bound is conservative.
    # Store minimum total delta for each (total weight, total tame different).
    choices=sorted(set((p['weight'],p['ram'],p['delta_lower']) for p in profiles))
    states={(0,0):0}
    for _ in range(29):
        nxt={}
        for (weight,ram),delta in states.items():
            for w,r,d in choices:
                key=(weight+w,ram+r);val=delta+d
                if val<nxt.get(key,10**9):nxt[key]=val
        states=nxt
    best=-1;optimal=[]
    for (weight,ram),delta in states.items():
        n=15+weight
        if n>218:continue
        genus_lower=max(0,(ram-8+1)//2)
        limit=4*n-35-delta-genus_lower
        if limit>best:best=limit;optimal=[]
        if limit==best:optimal.append([n,weight,ram,delta,genus_lower])
    ensure(best==464,'global contact budget 464')
    largest=max(m for m in range(best+1) if m%5==2)
    ensure(largest==462,'largest resonant order is 462')
    emit(f"PASS local profiles: {len(profiles)} profiles; 29-fiber relaxation gives L<=464, hence m<=462.")
    return {'profiles':profiles,'profile_count':len(profiles),
            'max_twice_local_gain':max_twice_gain,'dp_fiber_count':29,
            'dp_is_superset_of_actual_patterns':True,'max_total_contact_bound':best,
            'max_single_resonant_order':largest,
            'optimal_relaxed_state_count':len(optimal),
            'optimal_relaxed_degree_range':[min(o[0] for o in optimal),max(o[0] for o in optimal)],
            'one_maximizing_relaxed_state':optimal[0]}

def deterministic_linear_root(p,K):
    """Find a linear factor after restricting to K-rational roots.
    All trials are deterministic and explicitly bounded; this is test code,
    not a search over geometric comparison parameters.
    """
    x=[K.zero,K.one]
    h=gcd(p,sub(powmod(x,K.order,p,K),x,K),K)
    if len(h)<=1:return None
    seeds=[]
    for j in range(5):
        for a in range(25):
            z=[0]*5;z[j]=1;z[0]=F.add(z[0],a)
            seeds.append(K.element(z))
    while len(h)>2:
        split=None
        for c in seeds:
            b=add(x,[c],K)
            q=gcd(h,sub(powmod(b,(K.order-1)//2,h,K),[K.one],K),K)
            if 1<len(q)<len(h):split=q;break
        if split is None:raise RuntimeError('bounded deterministic test factorization exhausted')
        h=split
    return K.div(K.neg(h[0]),h[1])

def conjugate_norm_poly(element,K):
    p=[K.one]
    cur=element
    for _ in range(K.n):
        p=mul(p,[K.neg(cur),K.one],K)
        cur=K.pow(cur,25)
    ensure(cur==element,'Frobenius orbit closes')
    ensure(all(all(c==0 for c in a[1:]) for a in p),'norm coefficients in F25')
    return [a[0] for a in p]

def norm_alignment_check():
    A=DATA['A'];f=[4,4,0,0,0,1]
    ensure(irreducible_prime_degree(f),'finite-field test quintic irreducible')
    K=Extension(f);u=K.element([0,1]);a=evaluate([K.embed(c) for c in A],u,K)
    v=None;lam=None
    for candidate in range(2,25):
        p=[K.embed(c) for c in A]
        p[0]=K.sub(p[0],K.mul(K.embed(candidate),a))
        root=deterministic_linear_root(p,K)
        if root is not None:
            lam=candidate;v=root;break
    ensure(v is not None,'a finite-field norm-alignment test case exists in stated bounded trials')
    g=characteristic_poly(multiplication_matrix(list(v),f))
    ensure(g==conjugate_norm_poly(v,K),'g independently checked by Frobenius product')
    ensure(irreducible_prime_degree(g),'g irreducible')
    H1=norm_polynomial(f,A);H2=norm_polynomial(g,A)
    ensure(H1==conjugate_norm_poly(a,K),'H1 independent Frobenius check')
    av=evaluate([K.embed(c) for c in A],v,K)
    ensure(H2==conjugate_norm_poly(av,K),'H2 independent Frobenius check')
    ensure(av==K.mul(K.embed(lam),a),'actual fixed-A identity in the test field')
    left=[F.mul(c,F.pow(lam,i)) for i,c in enumerate(H2)]
    right=scale(H1,F.pow(lam,5))
    ensure(left==right,'H2(lambda*S)=lambda^5*H1(S)')
    U,d1,T1=inverse_primitive(f,A);W,d2,T2=inverse_primitive(g,A)
    V=[F.mul(c,F.pow(lam,i)) for i,c in enumerate(W)]
    ensure(compose_mod(U,A,f)==[0,1],'inverse primitive for u')
    ensure(compose_mod(W,A,g)==[0,1],'inverse primitive for v')
    reconstructed=compose_mod(V,A,f)
    ensure(K.element(reconstructed)==v,'canonical field identification recovers v')
    ensure(compose_mod(g,reconstructed,f)==[],'g(v)=0')
    ensure(sub(compose_mod(A,reconstructed,f),scale(mod(A,f),lam))==[],
           'A(v)=lambda*A(u) via quotient arithmetic')
    # All computations use unaveraged trace.  Tr(1)=0 in degree 5.
    ensure(F.integer(5)==0,'Tr(1)=0')
    altered=list(H2);altered[0]=F.add(altered[0],1)
    ensure([F.mul(c,F.pow(lam,i)) for i,c in enumerate(altered)]!=right,
           'changed norm coefficient is detected')
    emit(f"PASS norm alignment: finite-field sanity case lambda=[{lam}]; inverse bases nonzero; independent Frobenius check.")
    return {'scope':'Algebra sanity check over F25, NOT a curve or comparison witness.',
            'f':f,'g':g,'lambda_code':lam,'v_in_u_basis':list(v),
            'H1':H1,'H2':H2,'inverse_A_in_f':U,'inverse_A_in_g':W,
            'v_in_common_A_basis':V,'basis_determinants':[d1,d2],
            'basis_matrices':[T1,T2],
            'independent_Frobenius_norm_checks':True,
            'not_a_geometric_comparison':True}

def differential_checks():
    # In k(s), t=s^5-s, so d/dt=-d/ds.  Verify the implicit-
    # differentiation chain rule for 35 monomials t^i*s^j.
    t=[0,4,0,0,0,1];s=[0,1];count=0
    for i in range(7):
        for j in range(5):
            substituted=mul(power(t,i),power(s,j))
            lhs=scale(derivative(substituted),4)
            term_t=scale(mul(power(t,i-1),power(s,j)),i%5) if i else []
            term_s=scale(mul(power(t,i),power(s,j-1)),j%5) if j else []
            rhs=sub(term_t,term_s)
            ensure(lhs==rhs,'implicit derivative chain rule')
            count+=1
    # Divisor/ratio reconstruction is checked by integer exponent identities.
    ensure(3*48-11*13==1,'Bezout identity reconstructing t')
    ensure(3*17-11*4==7,'epsilon exponent in t reconstruction')
    ensure(3*64-17*13==-29,'proportional tensor scalar cubed')
    ensure(-10%5==0 and -10+2*13==16 and 16*13==16*13,
           'exact root differential exponents')
    for j in range(40):
        p=power(s,j)
        for _ in range(5):p=derivative(p)
        ensure(p==[],'fifth derivative in characteristic five')
    emit("PASS differential identities: 35 chain-rule monomials; reconstruction exponents; fifth derivatives vanish.")
    return {'implicit_derivative_monomials':count,'Bezout_48_13':[3,-11],
            'fifth_derivative_monomials':40,
            'geometric_differential_remainder_evaluated_on_actual_candidate':False}

def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('--output',type=Path,help='write complete bounded-check evidence JSON')
    args=parser.parse_args()
    result={'status':'PARTIAL: the actual mixed-phase existence problem is unresolved',
            'python':platform.python_version(),'dependencies':'Python standard library only',
            'input_checks':input_checks(),'profile_checks':profile_checks(),
            'norm_alignment_sanity_check':norm_alignment_check(),
            'differential_sanity_checks':differential_checks(),
            'full_geometric_search_executed':False}
    if args.output:
        args.output.parent.mkdir(parents=True,exist_ok=True)
        args.output.write_text(json.dumps(result,indent=2,sort_keys=True)+'\n')
    emit('ALL EXECUTED CHECKS PASS. NO EMPTINESS OR EXISTENCE CERTIFICATE IS CLAIMED.')

if __name__=='__main__':main()
