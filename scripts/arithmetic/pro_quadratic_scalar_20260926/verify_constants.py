#!/usr/bin/env python3
"""Verify the exact field data and projection/product certificates.
Python standard library only. Default verification does not change the archive.
Use --record only to regenerate evidence/constants.json.
"""
import argparse
import json
from pathlib import Path
from math import gcd
from field25 import ADD, NEG, MUL, INV, Field

ROOT = Path(__file__).resolve().parent.parent


def trim(a):
    a=list(a)
    while a and a[-1]==0:a.pop()
    return a


def p_add(a,b):
    c=[0]*max(len(a),len(b))
    for i,v in enumerate(a):c[i]=ADD[c[i]][v]
    for i,v in enumerate(b):c[i]=ADD[c[i]][v]
    return trim(c)


def p_mul(a,b):
    if not a or not b:return []
    c=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b):c[i+j]=ADD[c[i+j]][MUL[x][y]]
    return trim(c)


def p_divmod(a,b):
    a=trim(a);b=trim(b)
    if not b:raise ZeroDivisionError('zero polynomial')
    q=[0]*max(0,len(a)-len(b)+1)
    while a and len(a)>=len(b):
        pos=len(a)-len(b);c=MUL[a[-1]][INV[b[-1]]];q[pos]=c
        for j,v in enumerate(b):a[pos+j]=ADD[a[pos+j]][NEG[MUL[c][v]]]
        a=trim(a)
    return trim(q),a


def p_gcd(a,b):
    while b:a,b=b,p_divmod(a,b)[1]
    return [MUL[c][INV[a[-1]]] for c in a] if a else []


def build():
    data=json.loads((ROOT/'inputs/problem.json').read_text())
    A=data['A_monic']; f7=data['f7']; rows=data['rows']
    assert A==[5,2,6,7,1] and f7==[4,22,7,20,21,7,24,1]
    assert data['eta']==22
    B=Field(A); K=Field(f7)
    # Base-field relations and field axioms, exhaustively over the 25 codes.
    assert MUL[5][5]==8  # beta^2=3+beta
    assert B.pow(B.scalar(5),5)==B.scalar(21)  # beta^5=1-beta
    for a in range(25):
        assert ADD[a][NEG[a]]==0
        if a:assert MUL[a][INV[a]]==1
        for b in range(25):
            assert ADD[a][b]==ADD[b][a] and MUL[a][b]==MUL[b][a]
            for c in range(25):
                assert MUL[MUL[a][b]][c]==MUL[a][MUL[b][c]]
                assert MUL[a][ADD[b][c]]==ADD[MUL[a][b]][MUL[a][c]]
    # Rabin criterion: n=4 has prime divisor 2; n=7 has prime divisor 7.
    assert B.pow(B.gen,25**4)==B.gen
    assert p_gcd(A,list(B.sub(B.pow(B.gen,25**2),B.gen)))==[1]
    assert K.pow(K.gen,25**7)==K.gen
    assert p_gcd(f7,list(K.sub(K.pow(K.gen,25),K.gen)))==[1]
    assert K.pow(K.gen,29)==K.one
    assert all(K.pow(K.gen,j)!=K.one for j in range(1,29))
    assert B.pow(B.gen,5**42)==B.pow(B.gen,25)
    assert K.pow(K.gen,5**42)==K.gen
    assert len({B.pow(B.gen,25**j) for j in range(4)})==4
    assert gcd(4,7)==1
    projection={name:{str(lam):list(B.projection(tuple(row),lam)) for lam in (1,2,3,4)}
                for name,row in rows.items()}
    # Independently characterize each projection by its eigenvalue and the sum.
    for name,row in rows.items():
        total=B.zero
        for lam in (1,2,3,4):
            v=tuple(projection[name][str(lam)])
            assert B.pow(v,25)==B.scale(v,lam)
            total=B.add(total,v)
        assert total==tuple(row)
    assert all(tuple(projection['c'][str(l)])!=B.zero for l in (1,2,3,4))
    assert projection['e']['2']==projection['c']['2']
    assert tuple(projection['e']['3'])==B.zero
    assert tuple(projection['g']['3'])==B.zero
    assert tuple(projection['e']['4'])==B.scale(tuple(projection['c']['4']),12)
    for lam,v in zip((1,2,3,4),(13,17,0,7)):
        assert tuple(projection['g'][str(lam)])==B.scale(B.frob(tuple(projection['c'][str(lam)]),8),v)
    for lam,u in ((1,3),(2,14),(4,20)):
        assert tuple(projection['f'][str(lam)])==B.scale(B.frob(tuple(projection['e'][str(lam)]),11),u)
    c2=projection['c']['2'];c3=projection['c']['3']
    f2=projection['f']['2'];f3=projection['f']['3']
    assert B.mul(c3,f2)==B.scalar(5)
    assert B.mul(c2,f3)==B.scalar(17)
    assert B.div(B.scalar(5),B.scalar(17))==B.scalar(22)
    division={}
    for name,left,right,target in [('c3_f2',c3,f2,5),('c2_f3',c2,f3,17)]:
        raw=p_add(p_mul(left,right),[NEG[target]])
        quotient,remainder=p_divmod(raw,A)
        assert remainder==[]
        assert p_add(p_mul(A,quotient),[target])==p_mul(left,right)
        division[name]={'target_scalar':target,'quotient_by_A':quotient}
    powers5=[pow(5,r,29) for r in range(14)]
    assert len(set(powers5))==14 and pow(5,14,29)==1
    assert set((4,5,6,7,22,23,24,25))<=set(powers5)
    assert gcd(18,29)==1
    result={
        'projections':projection,
        'C3_F2':[5,0,0,0], 'C2_F3':[17,0,0,0], 'kappa':[22,0,0,0],
        'polynomial_division_certificates':division,
        'sigma_on_power_basis_columns':[list(B.pow(B.gen,25*i)) for i in range(4)],
        'powers_of_5_mod_29':powers5,
        'field_checks':{
            'F25_code_axioms':'passed', 'A_monic_irreducible':'passed Rabin criterion',
            'f7_irreducible':'passed Rabin criterion', 'zeta_exact_order_29':'passed',
            'sigma_restrictions':'passed', 'supplied_projection_and_jet_identities':'passed'
        }
    }
    return result


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--record',action='store_true')
    args=parser.parse_args()
    result=build();path=ROOT/'evidence/constants.json'
    if args.record:path.write_text(json.dumps(result,indent=2)+'\n')
    else:assert json.loads(path.read_text())==result
    print('PASS: exact F25 arithmetic, both irreducible moduli, order 29 and sigma restrictions.')
    print('PASS: all 16 coefficient projections and the supplied eigenvalue/jet identities.')
    print('C3*F2=[5], C2*F3=[17], ratio=[22].')
    print('Polynomial division certificates:',json.dumps(result['polynomial_division_certificates'],sort_keys=True))
    print('PASS: Frobenius exponents needed by the short-relation proof.')

if __name__=='__main__':main()
