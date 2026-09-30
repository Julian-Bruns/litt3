#!/usr/bin/env python3
"""Certify the ordinary cubic base's two actual W5 executions.

The small field checks below are independent of the NumPy/Witt engine.
This records finite evidence for the scoped theorem; it neither replaces
its geometric proof nor evaluates a rank125 fifth obstruction.
"""
import argparse
import hashlib
import itertools
import json
import os
from pathlib import Path

ROOT=Path(__file__).resolve().parents[3]
DATA_ROOT=ROOT.parent/'litt3-computation-data/rank125_reference_20260914'


def digits(n):
    return [n%5,(n//5)%5,(n//25)%5]


def code(a):
    return sum((x%5)*5**i for i,x in enumerate(a))


def add(a,b):
    return code([x+y for x,y in zip(digits(a),digits(b))])


def neg(a):
    return code([-x for x in digits(a)])


def ring_mul(a,b,m):
    c=[0]*5
    for i,x in enumerate(a):
        for j,y in enumerate(b):
            c[i+j]+=x*y
    for j in (4,3):
        c[j-3]-=c[j];c[j-2]-=c[j]
    return [x%m for x in c[:3]]


def mul(a,b):
    return code(ring_mul(digits(a),digits(b),5))


def power(a,n):
    out=1
    while n:
        if n&1:
            out=mul(out,a)
        a=mul(a,a);n//=2
    return out


def dot(a,b):
    out=0
    for x,y in zip(a,b):
        out=add(out,mul(x,y))
    return out


def rank(matrix):
    a=[row[:] for row in matrix];r=0
    for j in range(len(a[0])):
        pivot=next((i for i in range(r,len(a)) if a[i][j]),None)
        if pivot is None:
            continue
        a[r],a[pivot]=a[pivot],a[r]
        inv=power(a[r][j],123)
        a[r]=[mul(inv,x) for x in a[r]]
        for i in range(len(a)):
            if i!=r:
                c=a[i][j]
                a[i]=[add(x,neg(mul(c,y))) for x,y in zip(a[i],a[r])]
        r+=1
    return r


def poly_mul(a,b):
    out=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b):
            out[i+j]=add(out[i+j],mul(x,y))
    return out


def check_sigma(sig):
    m=3125
    def sigma(a):
        out=[0,0,0];term=[1,0,0]
        for x in a:
            out=[(c+x*y)%m for c,y in zip(out,term)]
            term=ring_mul(term,sig,m)
        return out
    sig3=ring_mul(ring_mul(sig,sig,m),sig,m)
    assert [(x+y+(i==0))%m for i,(x,y) in enumerate(zip(sig3,sig))]==[0,0,0]
    assert code(sig)==power(5,5)
    for e in ([1,0,0],[0,1,0],[0,0,1]):
        assert sigma(sigma(sigma(e)))==e


def without_timings(value):
    if isinstance(value,dict):
        return {k:without_timings(v) for k,v in value.items() if k!='seconds'}
    if isinstance(value,list):
        return [without_timings(v) for v in value]
    return value


def check_affine_potential(run):
    # Independent small R25 power-series calculation. Here x=z^2,
    # s=1/u=x*reverse(F)(s); no Laurent/NumPy engine is imported.
    N=24;zero=[0,0,0];one=[1,0,0]
    def ra(a,b):
        return [(x+y)%25 for x,y in zip(a,b)]
    def rm(a,b):
        return ring_mul(a,b,25)
    def sp(a,b):
        out=[zero[:] for _ in range(N)]
        for i,x in enumerate(a):
            if not any(x):
                continue
            for j,y in enumerate(b[:N-i]):
                if any(y):
                    out[i+j]=ra(out[i+j],rm(x,y))
        return out
    F=[one]
    for root in ([0,0,0],[1,0,0],[2,0,0],[3,0,0],[0,1,0]):
        new=[zero[:] for _ in range(len(F)+1)]
        for i,c in enumerate(F):
            new[i]=ra(new[i],rm(c,[(-x)%25 for x in root]))
            new[i+1]=ra(new[i+1],c)
        F=new
    s=[zero[:] for _ in range(N)]
    for _ in range(N):
        rhs=[zero[:] for _ in range(N)]
        for c in F:
            rhs=sp(rhs,s);rhs[0]=ra(rhs[0],c)
        s=[zero[:]]+rhs[:-1]
    unit=s[1:]+[zero[:]]
    assert unit[0]==one
    inv=[zero[:] for _ in range(N)];inv[0]=one
    for n in range(1,N-1):
        value=zero[:]
        for j in range(1,n+1):
            value=ra(value,rm(unit[j],inv[n-j]))
        inv[n]=[(-x)%25 for x in value]
    coefficients=[[11,19,0],[14,8,0],[5,4,15],[7,10,5],[10,20,0]]
    powers=[[one]+[zero[:] for _ in range(N-1)]]
    for _ in range(4):
        powers.append(sp(powers[-1],inv))
    saved=dict(run['preceding_oper_mod25_through_30']['U'])
    assert min(saved)==-8
    for e in range(-8,30):
        value=zero[:]
        if e%2==0:
            for d,c in enumerate(coefficients):
                j=e//2+d
                if j>=0:
                    value=ra(value,rm(c,powers[d][j]))
        assert value==saved.get(e,zero),(e,value,saved.get(e,zero))
    return coefficients


def certify(paths):
    runs=[json.loads(p.read_text()) for p in paths]
    expected=[[118,113,119],[31,119,44],[2,0,123],[77,86,64]]
    M=[[115,7,36],[22,114,34],[5,81,13]]
    det=0
    for perm in itertools.permutations(range(3)):
        term=1
        for i,j in enumerate(perm):
            term=mul(term,M[i][j])
        if sum(perm[i]>perm[j] for i in range(3) for j in range(i+1,3))%2:
            term=neg(term)
        det=add(det,term)
    assert det==15 and rank(M)==3
    for run in runs:
        assert run['modulus']==3125
        assert run['base_primary_field_codes']==M
        first=run['first_reference']
        assert first['source_xi_field_codes']==expected[0]
        assert first['extension_scalar_field_code']==1
        assert first['checks']['initial_connection_exact_polynomial_mod5']
        matrix=first['dictionary_matrix_field_codes']
        rhs=first['dictionary_rhs_field_codes']
        sol=[1]+[power(x,5) for x in expected[0]]
        assert rank(matrix)==4 and [dot(row,sol) for row in matrix]==rhs
        assert first['source_xi_frobenius_field_codes']==sol[1:]
        check_sigma(first['witt_sigma_T'])
        potential=check_affine_potential(run)
        for p,h in run['source_sha256'].items():
            assert hashlib.sha256(Path(__file__).with_name(p).read_bytes()).hexdigest()==h,(p,'changed source')
        for i,row in enumerate(run['higher_reference_digits'],start=1):
            assert row['stage']==i+2
            assert row['source_coefficients_field_codes']==expected[i]
            image=[dot(r,[power(x,5) for x in expected[i]]) for r in M]
            assert image==row['unrepaired_normal_field_codes']
            assert row['repaired_normal_zero'] and row['normal_precision']>=60
            assert row['hodge_formal_valuation']>=0
            assert row['full_corrected_jet_modulus']==5**(i+1)
            assert row['full_corrected_jet_precision']>=20
            assert row['full_IC_horizontality_modulus']==5**(i+1)
            assert row['full_IC_horizontality_precision']>=20
    assert [r['frobenius_variant'] for r in runs]==[0,1]
    assert runs[1]['precision']>runs[0]['precision']>=3200
    # Verify that the alternative run really changed its affine Frobenius
    # by the stated F^3 gauge, rather than silently replaying the same input.
    def correction(run):
        return {i:code(c) for i,c in run['first_reference']['frobenius_corrections'][0]['u']}
    c0,c1=map(correction,runs)
    F=[1]
    for root in (0,1,2,3,5):
        F=poly_mul(F,[neg(root),1])
    F3=poly_mul(poly_mul(F,F),F)
    for i in range(max(len(F3),max(c0,default=0)+1,max(c1,default=0)+1)):
        assert add(c1.get(i,0),neg(c0.get(i,0)))==(F3[i] if i<len(F3) else 0)
    assert c0!=c1
    return {
        'theorem_id':'cubic_ordinary_base_reference','statement_version':1,
        'scope':'Actual ordinary BASE curve W5 and compatible previous flow W4; no rank125 fifth scalar',
        'independent_finite_checks':{
            'field_implementation':'pure Python polynomial arithmetic; independent of witt_cubic',
            'primary_determinant_field_code':det,'primary_rank':3,
            'initial_dictionary_rank':4,'whole_normal_source_equations':3,
            'witt_sigma_cubic_and_order3':True,'distinct_Frobenius_gauge_difference':'F^3',
            'preceding_affine_potential_R25_independent_series_check':True,
            'all_source_digits_agree':True,'source_hashes_match':True},
        'whole_preceding_affine_potential_mod25':{
            'basis':'coefficient triples in 1,T,T^2; increasing u-degree',
            'coefficients':potential,
            'whole_function_justification':'Regular on the affine product chart; all polar terms match and the constant at infinity is zero after subtraction; hence global regular difference is zero, digit by digit.'},
        'formal_tail_convention':'Whole quotient expressions in reconstruct_base_reference and reconstruct_base_tower; finite through_30 arrays are diagnostics only',
        'receipt_inputs':[{'path':os.path.relpath(p,ROOT),'sha256':hashlib.sha256(p.read_bytes()).hexdigest()} for p in paths],
        'executions':[without_timings(r) for r in runs],
        'audits':['Research/audits/RANK125_CANONICAL_BASE_REFERENCE_AUDIT_2026_09_14.md'],
        'checker_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--first-run',type=Path,default=DATA_ROOT/'computations/rank125_base_tower_w5_final.json')
    ap.add_argument('--second-run',type=Path,default=DATA_ROOT/'computations/rank125_base_tower_w5_final_other_frobenius.json')
    ap.add_argument('--output',type=Path,default=DATA_ROOT/'certificates/cubic_ordinary_base_reference.json')
    args=ap.parse_args()
    result=certify([args.first_run.resolve(),args.second_run.resolve()])
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print('PASS: independent base field/dictionary/source checks, two full gauges and precision receipts')


if __name__=='__main__':
    main()
