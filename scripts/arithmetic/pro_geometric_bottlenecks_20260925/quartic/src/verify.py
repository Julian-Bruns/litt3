#!/usr/bin/env python3
"""Verify the archived partial results' finite certificates. This is not an existence solver."""
from __future__ import annotations
import datetime
import itertools
import json
import platform
import sys
from pathlib import Path
import ff25 as f
from extension import Extension,determinant
from build_certificates import algebra_certificate,tower_certificate

ROOT=Path(__file__).resolve().parents[1]

def check(condition: bool, message: str) -> None:
    if not condition:
        raise AssertionError(message)
    print('PASS:',message)

def main() -> None:
    print('UTC:',datetime.datetime.now(datetime.timezone.utc).isoformat())
    print('Python:',sys.version.replace('\n',' '))
    print('Platform:',platform.platform())
    print('Scope: finite arithmetic and local combinatorics, not geometric existence.')
    check(all((x*x-x-3)%5 for x in range(5)),'beta^2-beta-3 irreducible over F_5')
    check(all(f.mul(x,f.inv(x))==1 for x in range(1,25)),'all 24 nonzero F_25 elements have checked inverses')
    for x in range(25):
        for y in range(25):
            for z in range(25):
                if f.mul(x,f.add(y,z))!=f.add(f.mul(x,y),f.mul(x,z)):
                    raise AssertionError('distributivity')
    print('PASS: F_25 distributivity (15,625 triples)')
    cert=json.loads((ROOT/'certificates/algebra.json').read_text())
    check(cert==algebra_certificate(),'algebra certificate reproduced exactly from the source and input')
    for name,rec in cert['bezout'].items():
        check(rec['gcd']==[1] and f.padd(f.pmul(rec['s'],rec['left']),f.pmul(rec['t'],rec['right']))==[1],
              'Bezout '+name)
    for label in ['degree4_field','degree7_field']:
        rec=cert[label];r=rec['rabin_gcd']
        check(r['gcd']==[1] and f.padd(f.pmul(r['s'],r['left']),f.pmul(r['t'],r['right']))==[1],
              label+' Rabin gcd certificate')
        key='x_q4_minus_x' if label=='degree4_field' else 'x_q7_minus_x'
        check(rec[key]==[],label+' Frobenius remainder zero')
    primitive=cert['exact_primitive']
    check(primitive['integration_obstructions']==[] and
          f.derivative(primitive['Q'])==primitive['PA2'],
          'normalized polynomial primitive Qprime=P*A^2 (no integration obstruction)')
    e4=cert['degree4_field'];E=Extension(e4['modulus'])
    check(E.pow(tuple(e4['b']),29)==tuple(e4['H']),'b^29=H in F_(25^4)')
    check(e4['determinant']==23 and determinant(e4['normal_basis_matrix'])==23,
          'four conjugate 29th roots form a normal basis (determinant [23])')
    # Independent determinant calculation: the 24-term Leibniz formula.
    det_leibniz=0
    matrix=e4['normal_basis_matrix']
    for permutation in itertools.permutations(range(4)):
        term=1
        for i in range(4):term=f.mul(term,matrix[i][permutation[i]])
        inversions=sum(permutation[i]>permutation[j] for i in range(4) for j in range(i+1,4))
        det_leibniz=f.add(det_leibniz,f.neg(term) if inversions%2 else term)
    check(det_leibniz==23,'normal-basis determinant independently checked by all 24 Leibniz terms')
    check(len(set(map(tuple,e4['I_conjugates'])))==4,
          "I=A'^20/P^6 has four distinct values at the four A-roots")
    e7=cert['degree7_field'];Z=Extension(e7['modulus']);z=tuple(e7['zeta'])
    check(z!=Z.one and Z.pow(z,29)==Z.one,'zeta has exact order 29')
    sums=e7['unordered_pair_sums']
    check(len(sums)==435 and len({tuple(r['sum']) for r in sums})==435,
          'all 435 unordered pair sums in mu_29 are distinct')
    check(all(tuple(r['sum'])!=Z.zero for r in sums),'no unordered mu_29 pair has zero sum')
    # Redundant direct check in the 28-coordinate tensor-product basis.
    # The irreducible degree-4 and degree-7 fields are linearly disjoint.
    endpoints=[tuple(f.mul(a,b) for a in root for b in zp)
               for root in e4['b_conjugates'] for zp in e7['zeta_powers']]
    check(len(endpoints)==116 and len(set(endpoints))==116,
          'all 116 endpoint constants distinct in the 28-coordinate field basis')
    endpoint_pair_sums=set()
    for i,a in enumerate(endpoints):
        for b in endpoints[i:]:
            pair_sum=tuple(f.add(x,y) for x,y in zip(a,b))
            if pair_sum in endpoint_pair_sums:raise AssertionError('endpoint pair-sum collision')
            endpoint_pair_sums.add(pair_sum)
    check(len(endpoint_pair_sums)==6786,
          'all 6,786 unordered endpoint-pair sums distinct (direct exhaustive check)')
    check(cert['A_pair_sums']['depressed_row']==[17,2,18,0,13] and
          cert['A_pair_sums']['A_depressed_at_AP_center']==5,
          'auxiliary Sidon certificate for the four A-roots')
    towers=json.loads((ROOT/'certificates/local_towers.json').read_text())
    check(towers==tower_certificate(),'local tower certificate reproduced exactly')
    check(towers['group_orders']=={'C4':4,'D4':8,'V4':4},'permutation group orders 4,8,4')
    weights={g:set() for g in ['C4','V4','D4']}
    for rec in towers['records']:
        check_indices=all(p['e_t']==p['e_lower']*p['e_upper'] and p['e_t'] in [1,2,4] for p in rec['fibers'])
        if not check_indices:raise AssertionError('tower ramification indices')
        for dec in rec['decorations']:weights[rec['group']].add(dec['weight'])
    print('PASS: e_t=e_lower*e_upper, and no parameter index 3, in every inertia case')
    check(5 not in weights['C4'] and 5 not in weights['V4'] and 5 in weights['D4'],
          'weight 5 locally possible only in D4 among these three groups')
    # Exact integer exponent checks, before reduction modulo characteristic.
    check(3*48-11*13==1,'Bezout reconstruction exponent for t')
    # r^3 = kappa^3*t^48*F^3/B0^3, with
    # B0^3 = kappa^3*t^48*F^2: exponents of (kappa,t,F) are (0,0,1).
    check((3-3,3*16-48,3-2)==(0,0,1),'r reconstruction exponents')
    # Coefficient check for the first subleading endpoint expansion.
    check((3*(-3)**2*(-2))%5==1 and (-3)**3%5==3 and 6%5==1,
          'characteristic-five cubic expansion coefficients used for endpoint c')
    # The genus-bound coefficient identities in F1,F3,a_single,a_pair,b_single,b_pair.
    d=[1,3,1,2,3,6];C=[0,1,1,1,3,3]
    R=[2*x-y for x,y in zip(d,[0,2,0,8,0,6])]
    check(R==[2,4,2,-4,6,6],'fixed-point/pole count coefficient identity')
    left=[d[i]+2*C[i]-[0,1,0,4,0,3][i] for i in range(6)]
    right=[3*d[i]-[2,5,0,6,0,9][i] for i in range(6)]
    check(left==right and 2*2+12-7==3*12-27,'uniform strengthened genus-bound algebra')
    check(all(s*(4-s)+s*(s-1)//2==3*s-s*(s-1)//2 for s in range(5)),
          'V4 three-pairing sum for simple common poles')
    check(1+3+3==9-2 and 2+3+3==18-10,'V4 three-pairing sums for triple common poles')
    index=json.loads((ROOT/'claims.json').read_text())
    statuses={'accepted_input','proved','computationally_checked','conditional','open'}
    indexed={claim['id']:claim for claim in index['claims']}
    check(len(indexed)==len(index['claims']) and
          all(claim['status'] in statuses for claim in indexed.values()),
          'claim index has unique identifiers and valid statuses')
    for claim in indexed.values():
        for dependency in claim['dependencies']:
            if dependency not in indexed:raise AssertionError('missing claim dependency: '+dependency)
        for item in claim['evidence']:
            path=(ROOT/item['path']).resolve()
            if ROOT not in path.parents or not path.is_file():
                raise AssertionError('invalid evidence path: '+item['path'])
    visiting=set();visited=set()
    def visit(identifier):
        if identifier in visiting:raise AssertionError('cyclic claim dependencies')
        if identifier in visited:return
        visiting.add(identifier)
        for dependency in indexed[identifier]['dependencies']:visit(dependency)
        visiting.remove(identifier);visited.add(identifier)
    for identifier in indexed:visit(identifier)
    check(index['overall_status']=='partial' and index['existence_decision']=='unresolved' and
          indexed['DECISION']['status']=='open',
          'claim index dependencies and paths verified; overall decision explicitly unresolved')
    print('RESULT: ALL EXECUTED CHECKS PASSED.')
    print('NOT CLAIMED: existence or nonexistence of the requested S,t,u,v.')

if __name__=='__main__':
    try:main()
    except Exception as exc:
        print('FAIL:',repr(exc),file=sys.stderr)
        raise
