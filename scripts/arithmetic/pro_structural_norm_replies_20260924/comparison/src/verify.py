#!/usr/bin/env python3
"""Reproduce all finite, exact certificates for REPORT.md.

Default: recompute and compare every generated certificate byte-for-byte.
--write-certificates: create/replace the reproducible certificate files.
Only the Python standard library is used. No coefficient-field search is run.
"""
from __future__ import annotations
import sys
sys.dont_write_bytecode = True
import argparse
import csv
import io
import json
import math
import platform
import time
from collections import Counter
from datetime import datetime, timezone
from itertools import combinations, combinations_with_replacement
from pathlib import Path

from finite_fields import (
    FiniteField, ExtensionField, F25, F5_14, MU29_MODULUS,
    pdivmod, pgcd, ppowmod, psub, peval, pderiv, pmul,
)

ROOT = Path(__file__).resolve().parents[1]


def log(message: str) -> None:
    print(message, flush=True)


def encode_json(obj) -> str:
    return json.dumps(obj, indent=2, sort_keys=True) + "\n"


def csv_file(header):
    stream = io.StringIO(newline="")
    writer = csv.writer(stream, lineterminator="\n")
    writer.writerow(header)
    return stream, writer


def rank_and_rows(matrix, p=5):
    a=[list(row) for row in matrix]
    original=list(range(len(a)))
    n=len(a); m=len(a[0]); r=0; selected=[]
    for j in range(m):
        k=next((i for i in range(r,n) if a[i][j] % p),None)
        if k is None:
            continue
        a[r],a[k]=a[k],a[r]
        original[r],original[k]=original[k],original[r]
        selected.append(original[r])
        inv=pow(a[r][j] % p,-1,p)
        a[r]=[(v*inv)%p for v in a[r]]
        for i in range(r+1,n):
            if a[i][j] % p:
                c=a[i][j] % p
                a[i]=[(v-c*w)%p for v,w in zip(a[i],a[r])]
        r+=1
        if r==n:
            break
    return r,selected


def det_mod(matrix,p=5):
    a=[list(row) for row in matrix]
    n=len(a); out=1
    for j in range(n):
        k=next((i for i in range(j,n) if a[i][j] % p),None)
        if k is None:
            return 0
        if k!=j:
            a[k],a[j]=a[j],a[k]
            out=-out
        v=a[j][j] % p
        out=out*v % p
        inv=pow(v,-1,p)
        for i in range(j+1,n):
            c=a[i][j]*inv % p
            for t in range(j,n):
                a[i][t]=(a[i][t]-c*a[j][t]) % p
    return out % p


def check_fields(inputs,refs):
    assert inputs['characteristic'] == 5
    assert inputs['coefficient_field']['modulus_ascending_F5'] == list(F25.modulus)
    assert inputs['polynomial_order'] == 'ascending'
    assert refs['mu29_field']['characteristic'] == 5
    assert refs['mu29_field']['degree_over_F5'] == 14
    assert refs['A_splitting_field']['degree_over_F25'] == 4
    assert refs['A_splitting_field']['alpha_code'] == 25
    # An independent closed formula verifies every product in F25.
    for a in range(25):
        a0,a1=a%5,a//5
        for b in range(25):
            b0,b1=b%5,b//5
            expected=(a0*b0+3*a1*b1)%5 + 5*((a0*b1+a1*b0+a1*b1)%5)
            assert F25.mul(a,b)==expected
    for a in range(1,25):
        assert F25.mul(a,F25.inv(a))==1
    assert F25.pow(5,2)==F25.add(5,3)

    # Rabin irreducibility test for the degree-14 modulus over F5.
    F5=FiniteField(5,(0,1))
    modulus=list(MU29_MODULUS)
    assert modulus==refs['mu29_field']['modulus_ascending_F5']
    assert ppowmod(F5,[0,1],5**14,modulus)==[0,1]
    for d in (2,7):
        assert pgcd(F5,psub(F5,ppowmod(F5,[0,1],5**d,modulus),[0,1]),modulus)==[1]
    assert ppowmod(F5,[0,1],29,modulus)==[1]
    F=F5_14
    xi=refs['mu29_field']['xi_code']
    mu=[F.pow(xi,i) for i in range(29)]
    assert len(set(mu))==29 and F.pow(xi,29)==1 and xi!=1
    beta=refs['mu29_field']['beta_code']
    zeta=refs['mu29_field']['primitive_cube_root_code']
    assert F.sub(F.sub(F.mul(beta,beta),beta),3)==0
    assert F.pow(beta,25)==beta and beta not in range(5)
    assert zeta!=1 and F.add(F.add(F.mul(zeta,zeta),zeta),1)==0
    assert F.pow(zeta,25)==zeta
    assert F.order==6103515625

    P=inputs['P']; A=inputs['A']
    assert pgcd(F25,P,pderiv(F25,P))==[1]
    assert pgcd(F25,A,pderiv(F25,A))==[1]
    assert pgcd(F25,P,A)==[1]
    Am=[F25.div(a,A[-1]) for a in A]
    assert Am==refs['A_splitting_field']['modulus_ascending_F25_codes']
    assert ppowmod(F25,[0,1],25**4,Am)==[0,1]
    assert pgcd(F25,psub(F25,ppowmod(F25,[0,1],25**2,Am),[0,1]),Am)==[1]
    log('PASS fields: all 625 F25 products, inverses, two irreducibility tests, squarefreeness and coprimality.')
    return mu,beta,zeta,Am


def check_arc(mu,beta,zeta):
    F=F5_14
    columns=[(F.digits(a),F.digits(F.mul(beta,a))) for a in mu]
    stream,writer=csv_file(['e0','e1','e2','e3','pivot_rows','minor_determinant_mod5'])
    count=0
    for rest in combinations(range(1,29),3):
        inds=(0,)+rest
        col=[v for i in inds for v in columns[i]]
        matrix=[list(row) for row in zip(*col)]
        rank,rows=rank_and_rows(matrix)
        assert rank==8
        determinant=det_mod([matrix[i] for i in rows])
        assert determinant!=0
        writer.writerow([*inds,' '.join(map(str,rows)),determinant])
        count+=1
    assert count==3276
    triples=[]
    zeta2=F.mul(zeta,zeta)
    for j in range(29):
        for k in range(29):
            if F.add(1,F.add(F.mul(zeta,mu[j]),F.mul(zeta2,mu[k])))==0:
                triples.append([0,j,k])
    assert triples==[[0,0,0]]
    log('PASS mu29 arc: 3276 full-rank 14x8 matrices with nonzero 8x8 minors; 841 affine-triple checks.')
    return stream.getvalue(),{'normalized_four_sets':count,'all_ranks_over_F5':8,
                             'normalized_affine_triples_tested':841,'affine_triple_solutions':triples}


def check_sums(mu):
    F=F5_14
    stream,writer=csv_file(['m','exponents','sum_code_F5_14'])
    counts={}
    for m in (2,3,4):
        seen={}
        for inds in combinations_with_replacement(range(29),m):
            value=0
            for i in inds:
                value=F.add(value,mu[i])
            assert value not in seen,('Repeated mu29 sum',seen.get(value),inds)
            seen[value]=inds
            writer.writerow([m,' '.join(map(str,inds)),value])
        assert len(seen)==math.comb(28+m,m)
        counts[str(m)]=len(seen)
    assert counts=={'2':435,'3':4495,'4':35960}
    log('PASS mu29 sums: 435 pairs, 4495 triples and 35960 quadruples, including repetitions; no collisions.')
    return stream.getvalue(),counts


def check_curve(inputs,Am):
    E=ExtensionField(F25,tuple(Am))
    P=inputs['P']; A=inputs['A']; Ap=pderiv(F25,A)
    alpha=[E.pow(25,25**i) for i in range(4)]
    assert len(set(alpha))==4
    inv29=pow(29,-1,E.order-1)
    rows=[]; weights=[]; bs=[]
    for a in alpha:
        assert peval(E,A,a)==0
        p=peval(E,P,a); ap=peval(E,Ap,a)
        assert p and ap
        c=E.div(E.mul(3,E.mul(E.pow(ap,3),E.pow(p,2))),E.pow(A[-1],3))
        b=E.pow(c,inv29)
        assert E.pow(b,29)==c
        weight=E.mul(E.mul(p,ap),E.pow(b,-14))
        rows.append({'alpha':a,'P_alpha':p,'A_prime_alpha':ap,'c_alpha':c,'b0_alpha':b,'W_alpha':weight})
        weights.append(weight);bs.append(b)
    assert len({r['c_alpha'] for r in rows})==4
    subsums=[]
    for mask in range(1,16):
        inds=[i for i in range(4) if mask>>i&1]
        total=0
        for i in inds:
            total=E.add(total,weights[i])
        assert total!=0
        subsums.append({'indices':inds,'sum_code':total})
    ratios=[]
    for i,j in combinations(range(4),2):
        d=E.div(bs[i],bs[j]); frob=E.pow(d,625)
        assert frob!=d
        ratios.append({'i':i,'j':j,'ratio_code':d,'power_625_code':frob,'degree_over_F25':4})
    assert [r['c_alpha'] for r in rows]==[49582,18014,375108,111330]
    assert bs==[356746,98060,384506,134116]
    assert weights==[370054,338804,224174,42772]
    log('PASS curve arithmetic: four distinct endpoint constants; all 15 nonempty weight subsums nonzero; all 6 ratios have degree 4 over F25.')
    return {'field_order':E.order,'inverse_29_mod_field_order_minus_1':inv29,
            'normalized_A':Am,'root_rows':rows,'nonempty_weight_subsums':subsums,'b0_ratios':ratios}


def check_confluent_m4(mu):
    F=F5_14
    sq=[F.mul(a,a) for a in mu]
    p4=[F.mul(a,a) for a in sq]
    pair={}
    for i in range(29):
        for j in range(29):
            a,b=mu[i],mu[j]
            pair[i,j]=[
                F.mul(F.add(a,b),F.add(sq[i],sq[j])),
                F.add(F.add(F.mul(3,sq[i]),F.mul(2,F.mul(a,b))),sq[j]),
                F.add(F.mul(3,a),b),1]
    stream,writer=csv_file(['e0','e1','e2','e3','rejection','root_a','root_b_or_jet_order','value_a','value_b_or_jet_coefficient'])
    count=0; value_survivors=[]; final_survivors=[]; jet_witnesses=[]
    for rest in combinations_with_replacement(range(29),3):
        inds=(0,)+rest
        multiplicities=Counter(inds)
        values={}
        for i in multiplicities:
            val=p4[i]  # mu_i^(-112) = mu_i^4
            for j in inds:
                val=F.mul(val,pair[i,j][0])
            values[i]=val
        first=next(iter(values))
        bad=next((i for i in values if values[i]!=values[first]),None)
        if bad is not None:
            writer.writerow([*inds,'different_values',first,bad,values[first],values[bad]])
            count+=1
            continue
        value_survivors.append(list(inds))
        rejected=False
        for i,m in multiplicities.items():
            if m==1:
                continue
            co=[1]+[0]*(m-1)
            for j in inds:
                co=pmul(F,co,pair[i,j])[:m]
                co += [0]*(m-len(co))
            # Binomial(-112,k) = (1,3,3,1) mod 5 for 0<=k<=3.
            invseries=[F.mul(c,F.pow(mu[i],4-k)) for k,c in enumerate([1,3,3,1][:m])]
            ratio=pmul(F,co,invseries)[:m]
            ratio += [0]*(m-len(ratio))
            jet=next((k for k in range(1,m) if ratio[k]),None)
            if jet is not None:
                writer.writerow([*inds,'nonconstant_jet',i,jet,ratio[0],ratio[jet]])
                jet_witnesses.append({'exponents':list(inds),'root_index':i,'ratio_taylor_coefficients':ratio})
                rejected=True
                break
        if not rejected:
            final_survivors.append(list(inds))
        count+=1
    assert count==4495
    assert value_survivors==[[0,0,0,0]]
    assert final_survivors==[]
    assert jet_witnesses[0]['ratio_taylor_coefficients'][0:2]==[1,4]
    log('PASS confluent m=4: all 4495 normalized multisets excluded; sole value survivor (0,0,0,0) has first jet 4, not 0.')
    return stream.getvalue(),{'normalized_multisets_tested':count,'value_survivors':value_survivors,
                             'confluent_survivors':final_survivors,'jet_witnesses':jet_witnesses}


def build_certificates():
    inputs=json.loads((ROOT/'data/input.json').read_text())
    refs=json.loads((ROOT/'data/reference_fields.json').read_text())
    mu,beta,zeta,Am=check_fields(inputs,refs)
    arc_csv,arc_summary=check_arc(mu,beta,zeta)
    sums_csv,sums_summary=check_sums(mu)
    curve=check_curve(inputs,Am)
    m4_csv,m4_summary=check_confluent_m4(mu)
    summary={'mu29_field_order':F5_14.order,'mu29_codes':mu,'arc':arc_summary,
             'additive_sum_counts':sums_summary,'confluent_m4':m4_summary,
             'scope':'Exact finite endpoint arithmetic only. The geometric proof is in REPORT.md. No quartic reconstruction search is claimed.'}
    return {'arc_rank_checks.csv':arc_csv,'mu29_sum_checks.csv':sums_csv,
            'confluent_m4_checks.csv':m4_csv,'curve_checks.json':encode_json(curve),
            'arithmetic_summary.json':encode_json(summary)}


def main():
    if not __debug__:
        raise RuntimeError("Do not use -O, -OO, or PYTHONOPTIMIZE: verification requires assertions.")
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--write-certificates',action='store_true')
    args=parser.parse_args()
    started=time.monotonic()
    log('UTC start: '+datetime.now(timezone.utc).isoformat())
    log('Python: '+sys.version.replace('\n',' '))
    log('Platform: '+platform.platform())
    generated=build_certificates()
    certdir=ROOT/'certificates'
    certdir.mkdir(exist_ok=True)
    for name,text in generated.items():
        target=certdir/name
        if args.write_certificates:
            target.write_text(text,encoding='utf-8',newline='')
        else:
            assert target.exists(),f'Missing certificate: {target}'
            assert target.read_bytes()==text.encode('utf-8'),f'Certificate mismatch: {target}'
    log(('WROTE' if args.write_certificates else 'PASS byte-for-byte comparison of')+f' {len(generated)} certificate files.')
    log('RESULT: PASS. No assertion failed.')
    log(f'Elapsed seconds: {time.monotonic()-started:.6f}')
    log('UTC finish: '+datetime.now(timezone.utc).isoformat())


if __name__=='__main__':
    main()
