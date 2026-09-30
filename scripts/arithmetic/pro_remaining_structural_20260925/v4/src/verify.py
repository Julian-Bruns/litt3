#!/usr/bin/env python3
"""Reproduce the exact supporting checks in this PARTIAL research archive.

This does not decide existence and does not search actual S,u,v.
It checks arithmetic identities, the V4 arithmetic scaffold, all small integer
cases in the new genus-bound argument, and explicitly weakened pole profiles.
The geometric proofs are in REPORT.md and are not claimed to be machine proofs.
"""
from __future__ import annotations
import argparse
import csv
import hashlib
import io
import json
import math
from pathlib import Path
import platform
import sys
from finite25 import (add, neg, sub, mul, power, inv, div, trim, padd,
                      psub, pmul, ppow, pgcd, derivative, evaluate, Rat)
from v4 import Algebra

ROOT = Path(__file__).resolve().parents[1]


def encoded_field_checks():
    assert mul(5,5) == 8  # beta^2=beta+3
    for a in range(25):
        assert add(a, neg(a)) == 0
        assert power(a,25) == a
        if a:
            assert mul(a, inv(a)) == 1
        for b in range(25):
            assert add(a,b) == add(b,a)
            assert mul(a,b) == mul(b,a)
            for c in range(25):
                assert add(add(a,b),c) == add(a,add(b,c))
                assert mul(mul(a,b),c) == mul(a,mul(b,c))
                assert mul(a,add(b,c)) == add(mul(a,b),mul(a,c))
    return {'field_elements':25, 'triples_checked':25**3,
            'field_axioms': 'PASS'}


def endpoint_checks():
    problem = json.loads((ROOT/'data/problem.json').read_text())
    P,A = trim(problem['P']), trim(problem['A'])
    assert len(P)==11 and len(A)==5 and A[0]!=0 and A[-1]==13
    assert pgcd(P, derivative(P)) == (1,)
    assert pgcd(A, derivative(A)) == (1,)
    assert pgcd(P,A) == (1,)
    assert pgcd(P,derivative(A)) == (1,)
    product = pmul(P,ppow(A,2))
    Q = [0]*(len(product)+1)
    for i,c in enumerate(product):
        if (i+1)%5 == 0:
            assert c == 0
        else:
            Q[i+1] = div(c,(i+1)%5)
    Q = trim(Q)
    assert derivative(Q)==product
    expected = (0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24)
    assert Q == expected
    return {'Q':list(Q), 'derivative_Q':list(product),
            'convention':'ascending F_25-encoded rows; coefficients of Q at degrees divisible by 5 set to zero',
            'identity':'Q_prime=P*A^2', 'verified':True,
            'P_roots_in_F25':[i for i in range(25) if evaluate(P,i)==0],
            'A_roots_in_F25':[i for i in range(25) if evaluate(A,i)==0]}


def exponent_checks():
    # Coordinates are (epsilon exponent,t exponent).
    H=(4,-13); D=(-17,48)
    t29=tuple(-17*a-4*b for a,b in zip(H,D))
    eps=tuple(-4*a-b+c for a,b,c in zip(H,D,(0,-4)))
    assert t29==(0,29) and eps==(1,0)
    # lambda^4=eps^4*c^-13 and lambda^17=eps^17*c^-48.
    lam=tuple(b-4*a for a,b in zip((4,-13),(17,-48)))
    assert lam==(1,4)
    assert (-13*pow(4,-1,5))%5 == 3
    assert 4%5==4 and -25%5==0
    assert (3-4)%5 != 0 and (3-(-25))%5 != 0
    assert -25%29 == 4
    assert 4-9 == -5 and -13 != -5
    # Cube reconstruction: r^3=eps^-17*t^48*R^3/s^3=R.
    # s^3=eps^-17*t^48*R^2; coordinates (eps,t,R).
    s3=(-17,48,2)
    assert tuple(a-b for a,b in zip((-17,48,3),s3))==(0,0,1)
    # The primitive differential exponent is -26+16=-10, divisible by 5.
    assert -26+16==-10 and -10%5==0
    return {'t29_exponents':list(t29), 'epsilon_exponents':list(eps),
            'leading_ratio_exponents':list(lam),
            'primitive_stabilizer_valuations':{'left':-5,'right':-13},
            'cube_reconstruction':'PASS', 'local_nonzero_derivatives':'PASS'}


def v4_checks():
    t=Rat((0,1))
    alg=Algebra((t-1,t-2,t-3))
    e=[alg.basis(i) for i in range(4)]
    one=alg.scalar(1)
    count=0
    for a in e:
        for b in e:
            assert a*b==b*a
            for c in e:
                assert (a*b)*c==a*(b*c)
                count+=1
            assert (a*b).diff()==a.diff()*b+a*b.diff()
    f=one+e[1]*t+e[2]*(t+1)+e[3]*(t*t+2)
    assert f*f.inverse()==one
    for i in range(1,4):
        assert f.sigma(i).sigma(i)==f
        assert f.diff().sigma(i)==f.sigma(i).diff()
        for a in e:
            for b in e:
                assert (a*b).sigma(i)==a.sigma(i)*b.sigma(i)
    for sample in [f, e[1], (e[2]+one)/(e[1]+one)]:
        d=sample
        for _ in range(5):
            d=d.diff()
        assert not d
    w=e[1]+e[2]
    assert w.orbit_size()==4
    assert not w.c[3]
    assert not (w+w.sigma(3))
    r=e[1]+one
    R=r**3
    ss=(r**2)*alg.scalar(t**16)
    assert ss**3==alg.scalar(t**48)*(R**2)
    reconstructed=alg.scalar(t**16)*R/ss
    assert reconstructed==r
    return {'associativity_basis_triples':count,
            'conjugation_and_derivative_tests':'PASS',
            'fifth_derivative_tests':3,
            'cube_formula_test':'PASS',
            'abstract_example':{'d1':[4,1], 'd2':[3,1], 'd3':[2,1],
              'w':'z1+z2', 'orbit_size':4,
              'zero_character':3,
              'status':'ARITHMETIC TEST ONLY, NOT AN ENDPOINT CANDIDATE'}}


def genus_checks():
    count=0
    for j0 in range(30):
        for j1 in range(30-j0):
            for j2 in range(30-j0-j1):
                colors=(j0,j1,j2); j=sum(colors)
                for s in range(30-j):
                    low=[10+j-x for x in colors]
                    uv=[3+s+2*j-x for x in colors]
                    alt=[25+j-x for x in colors]
                    # Choose any two nonzero w characters. The third is
                    # provided by the noncollapse input for u,v.
                    for missing in range(3):
                        others=[i for i in range(3) if i!=missing]
                        B=low[others[0]]+low[others[1]]+uv[missing]-3
                        assert B==20+s+3*j
                        assert B<=12+s+3*j+8  # n>=12+s+3j
                        # When exactly this character vanishes in w,
                        # u_missing vanishes to order at least 4 at infinity.
                        refined=low[others[0]]+low[others[1]]+(s+2*j-colors[missing]-4)-3
                        assert refined==13+s+3*j
                        assert refined<=12+s+3*j+1
                        assert refined<=42+2*j
                        C=low[others[0]]+low[others[1]]+alt[missing]-3
                        assert C==42+2*j<=100
                        count+=1
                    assert sum(low)-3==27+2*j<=85
                    count+=1
    rows=[]
    for n in range(14,183):
        jmax=min(29,(n-12)//3)
        upper_g=min(3*n-30,n+8,100,42+2*jmax)
        lower_branch=8*n-3*upper_g+3
        assert lower_branch>=74
        assert math.factorial(n)<=3**(5*n)
        E=4*(8*n+1)**2+180*n+4
        assert E==256*n*n+244*n+8
        rows.append({'n':n,'genus_T':8*n+1,'genus_S_upper':upper_g,
                     'cubic_branch_lower':lower_branch,
                     'field_degree_bound_exponent_E':E})
    assert min(r['cubic_branch_lower'] for r in rows)==74
    assert [r['n'] for r in rows if r['cubic_branch_lower']==74]==[19]
    assert rows[-1]['field_degree_bound_exponent_E']==8524160
    return {'integer_configurations':count,'degree_values':len(rows),
            'minimum_cubic_branch_bound':74,
            'field_bound':'d <= 3^(256*n^2+244*n+8), over F_25',
            'largest_exponent':8524160}, rows


def branch_colors(j):
    b=max(j,3)
    options=[]
    for b0 in range(b+1):
        for b1 in range(b-b0+1):
            bb=(b0,b1,b-b0-b1)
            if len({x%2 for x in bb})!=1:
                continue
            if min(b-x for x in bb)<2:
                continue
            options.append(bb)
    assert options
    bb=min(options,key=lambda x:(max(x)-min(x),x))
    if b==j:
        jj=bb
    else:
        left=j; jj=[]
        for cap in bb:
            v=min(cap,left); jj.append(v); left-=v
        assert left==0
        jj=tuple(jj)
    return bb,jj


def profile_checks():
    """Search count profiles, NOT curves, equations, or moment constraints."""
    out=[]; attempted=0
    for n in range(14,183):
        weight=n-12; answer=None
        for j in range(min(29,weight//6),-1,-1):
            rem=weight-6*j; slots=29-j
            for c4 in range(min(slots,rem//4),-1,-1):
                for c3 in range(min(slots-c4,(rem-4*c4)//3),-1,-1):
                    for c2 in range(min(slots-c4-c3,(rem-4*c4-3*c3)//2),-1,-1):
                        c1=rem-4*c4-3*c3-2*c2
                        cc=(c1,c2,c3,c4)
                        if min(cc)<0 or sum(cc)>slots:
                            continue
                        attempted+=1
                        freq=[29-j-sum(cc),j+c1,c2,c3,c4]
                        if max(freq)>=28:
                            continue  # constant-except-one modulo five
                        bb,jj=branch_colors(j); b=sum(bb); g=b-3
                        C=c2+3*c3+6*c4
                        mu=4*c2+c3+3*c4+8*j
                        bounds=[3*n-21-4*C,3*n-21-mu,3*n-30-C-10*j,
                                20+sum(cc)+3*j,42+2*j,27+2*j]
                        a2=[c2+c3+2*c4,c3+2*c4,c3+2*c4]
                        a1=[c1+c3,c1+2*c2+c3,c1+2*c2+c3]
                        for i in range(3):
                            f3=2*jj[i]; b2=j-jj[i]
                            assert 3*f3+a1[i]+2*a2[i]+6*b2==weight
                            bounds.append(3*n-27-5*f3-6*a2[i]-9*b2)
                            h=(b-bb[i])//2
                            assert h>=1
                            if h>10+j-jj[i] or h>3+sum(cc)+2*j-jj[i]:
                                bounds.append(-1)
                        if g>min(bounds):
                            continue
                        answer={'n':n,'simple_fiber_counts_by_weight_1_2_3_4':list(cc),
                                'triple_fibers_one_pole':0,'triple_fibers_two_poles':j,
                                'triple_fiber_inertia_counts':list(jj),
                                'all_branch_inertia_counts':list(bb),
                                'genus':g,'residue_frequency_0_1_2_3_4':freq,
                                'interpretation':'ONLY A WEAKENED NUMERICAL PROFILE; NO ENDPOINT FUNCTIONS; MOMENT EQUATIONS NOT CHECKED'}
                        break
                    if answer:break
                if answer:break
            if answer:break
        assert answer is not None, n
        out.append(answer)
    return {'count_profiles_attempted':attempted,'degree_values_with_profile':len(out),
            'scope':'bounded search of counts only; not geometric existence'}, out


def manifest_check():
    p=ROOT/'MANIFEST.sha256'
    if not p.exists():
        raise FileNotFoundError('MANIFEST.sha256 missing')
    count=0
    seen=set()
    for line in p.read_text().splitlines():
        digest,name=line.split('  ',1)
        assert name not in seen, f'duplicate manifest name: {name}'
        seen.add(name)
        f=ROOT/name
        assert f.resolve().is_relative_to(ROOT.resolve()), name
        assert f.is_file(),name
        assert hashlib.sha256(f.read_bytes()).hexdigest()==digest,name
        count+=1
    actual={f.relative_to(ROOT).as_posix() for f in ROOT.rglob('*')
            if f.is_file() and f!=p and '__pycache__' not in f.parts}
    assert actual==seen, f'manifest file-set mismatch: {actual ^ seen}'
    print(f'MANIFEST PASS: {count} files')


def check_or_write(path, text, write):
    p=ROOT/path
    if write:
        p.parent.mkdir(parents=True,exist_ok=True)
        p.write_text(text,encoding='utf-8')
    else:
        assert p.read_text(encoding='utf-8')==text, f'data mismatch: {path}'


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--write-data',action='store_true',help='rebuild small supporting data; changes hashes')
    parser.add_argument('--check-manifest',action='store_true')
    args=parser.parse_args()
    if args.check_manifest:
        manifest_check()
    print('STATUS: PARTIAL; ACTUAL KLEIN-FOUR EXISTENCE UNRESOLVED')
    print('Python:',platform.python_version())
    result={'status':'UNRESOLVED','geometric_existence_search_executed':False}
    result['field']=encoded_field_checks();print('PASS: F_25 arithmetic')
    q=endpoint_checks();print('PASS: P,A and exact polynomial Q_prime=P*A^2')
    result['exponents']=exponent_checks();print('PASS: exact exponent and local-leading-order identities')
    result['v4']=v4_checks();print('PASS: biquadratic arithmetic and abstract support counterexample')
    result['genus'],rows=genus_checks();print('PASS: genus-bound integer configurations:',result['genus']['integer_configurations'])
    result['profiles'],profiles=profile_checks();print('PASS: weakened count profiles for all 169 degrees (NOT actual candidates)')
    print('PASS: cubic branch lower bound >=74; field-degree-bound exponent <=8524160')
    fmt=lambda x:json.dumps(x,indent=2,sort_keys=True)+'\n'
    check_or_write('data/Q.json',fmt(q),args.write_data)
    check_or_write('data/check_results.json',fmt(result),args.write_data)
    check_or_write('data/numerical_profiles.json',fmt(profiles),args.write_data)
    buf=io.StringIO(newline='')
    writer=csv.DictWriter(buf,fieldnames=list(rows[0]),lineterminator='\n')
    writer.writeheader();writer.writerows(rows)
    check_or_write('data/arithmetic_bounds.csv',buf.getvalue(),args.write_data)
    print('PASS: supporting data reproduced exactly')
    print('No S,u,v witness and no emptiness certificate have been produced.')


if __name__=='__main__':
    main()
