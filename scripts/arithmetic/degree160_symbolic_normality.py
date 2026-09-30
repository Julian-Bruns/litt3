#!/usr/bin/env python3
"""Symbolic necessary normality matrix, with no Frobenius relation omitted.

The matrix is linear in the inverse-Frobenius coordinates (U,V,1),
while h=u*h0+v*h1+h2 and U^5=u,V^5=v. Rank tests alone may be stronger.
Artifacts are written only to the explicitly supplied external directory.
"""
import argparse
import json
from pathlib import Path
from sage.all import *


def setup():
    k=GF(25,name='a',modulus=PolynomialRing(GF(5),'z')([2,4,1])); a=k.gen()
    R=PolynomialRing(k,'x'); x=R.gen()
    dec=lambda n:k(n%5)+(n//5)*a
    P=R([dec(n) for n in [11,22,18,5,19,20,15,16,9,22,1]])
    hs=[R([dec(24),2,1]),R([dec(5),dec(16),0,1]),
        R([dec(5),dec(20),0,0,dec(8),1])]
    js=[]
    for h in hs:
        hp=h*P
        j=R.zero()
        for i in range(hp.degree()+1):
            if (i+1)%5:
                j+=hp[i]/k(i+1)*x**(i+1)
            else:
                assert not hp[i]
        assert j.derivative()==hp
        js.append(j)
    fc=[x**(5*i)%P for i in range(10)]
    fm=matrix(k,10,10,lambda i,j:fc[j][i])
    roots=[]
    for j in js:
        c=fm.solve_right(vector(k,[(j%P)[i] for i in range(10)]))
        root=R([v**5 for v in c])
        assert root**5%P==j%P
        roots.append(root)
    return k,P,hs,js,roots


def matrix_at(k,P,hs,roots,u,v):
    R=P.parent();x=R.gen();h=u*hs[0]+v*hs[1]+hs[2]
    if h.gcd(h.derivative())!=1 or h.gcd(P)!=1:
        return None
    pinv=P.inverse_mod(h)
    rows=[]
    candidates=[]
    for root in roots:
        r0=-(h*h*root)%P
        t=r0*pinv%h
        aa=-2*t[4]
        r=r0+P*(aa*h.derivative()-t)
        assert not (r-aa*P*h.derivative())%h
        N=(h.derivative()*r.derivative()-aa*(4*P*h.derivative()*h.derivative(2)+
             3*P.derivative()*h.derivative()**2))%h
        rows.append([N[i] for i in range(5)])
        candidates.append((r,aa))
    return matrix(k,rows).transpose(),candidates


def symbolic(k,P,hs,roots,out):
    A=PolynomialRing(k,['u','v'],order='degrevlex');u,v=A.gens()
    R=PolynomialRing(A,'x');x=R.gen();P=R(P)
    h=u*R(hs[0])+v*R(hs[1])+R(hs[2])
    pcs=[P*x**i%h for i in range(5)]
    M=matrix(A,5,5,lambda i,j:pcs[j][i])
    determinant=M.determinant();adj=M.adjugate()
    print('denominator total degree',determinant.total_degree(),flush=True)
    columns=[]
    for root in roots:
        r0=-(h*h*R(root))%P
        tc=adj*vector(A,[(r0%h)[i] for i in range(5)])
        t=R(list(tc));aa=-2*t[4]
        r=determinant*r0+P*(aa*h.derivative()-t)
        assert not (r-aa*P*h.derivative())%h
        N=(h.derivative()*r.derivative()-aa*(4*P*h.derivative()*h.derivative(2)+
            3*P.derivative()*h.derivative()**2))%h
        columns.append([N[i] for i in range(5)])
    N=matrix(A,columns).transpose()
    save({'matrix':N,'denominator':determinant,'h':h},str(out/'normality_matrix.sobj'))
    print('matrix entry maximum degree',max(p.total_degree() for p in N.list()),flush=True)
    minors=N.minors(3)
    common=gcd(minors)
    print('minor gcd degree',common.total_degree(),flush=True)
    reduced=[p//common for p in minors if p]
    save({'minor_gcd':common,'reduced_minors':reduced},str(out/'normality_minors.sobj'))
    print('reduced minor degrees',[p.total_degree() for p in reduced],flush=True)
    gb=A.ideal(reduced).groebner_basis()
    print('minor Groebner degrees',[p.total_degree() for p in gb],flush=True)
    save(gb,str(out/'normality_minor_groebner.sobj'))
    disc=h.discriminant()
    kappa,rem=common.quo_rem(determinant**3)
    assert not rem and kappa.is_constant() and kappa
    target=determinant*disc
    multipliers=list(target.lift(A.ideal(reduced)))
    assert sum((a*b for a,b in zip(multipliers,minors)),A.zero()) == kappa*determinant**4*disc
    minor_rows=[list(s) for s in Subsets(range(5),3)]
    assert all(minors[i]==N.matrix_from_rows(rows).determinant()
               for i,rows in enumerate(minor_rows))
    encode=lambda c:int(c.polynomial()[0])+5*int(c.polynomial()[1])
    pack=lambda f:[[int(e[0]),int(e[1]),encode(c)] for e,c in sorted(f.dict().items())]
    receipt={'field_modulus_ascending':[2,4,1],'variables':['u','v'],
        'denominator':pack(determinant),'discriminant':pack(disc),
        'kappa':encode(kappa.constant_coefficient()),
        'matrix':[[pack(N[i,j]) for j in range(3)] for i in range(5)],
        'minor_rows':minor_rows,'multipliers':[pack(a) for a in multipliers],
        'identity':'sum_i multiplier_i det(matrix[minor_rows_i,:]) = kappa denominator^4 discriminant'}
    path=out/'normality_identity.json'
    if path.exists():
        old=json.loads(path.read_text())
        # Reconstruct every geometric input; the multiplier choice itself
        # need not be byte-identical across computer-algebra versions.
        for key in ['field_modulus_ascending','variables','denominator',
                    'discriminant','kappa','matrix','minor_rows']:
            assert old[key]==receipt[key],key
    path.write_text(json.dumps(receipt,separators=(',',':'))+'\n')
    print('PASS: reconstructed matrix and explicit rank identity; bytes',path.stat().st_size,flush=True)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output-dir',type=Path,required=True)
    parser.add_argument('--symbolic',action='store_true')
    args=parser.parse_args();args.output_dir.mkdir(parents=True,exist_ok=True)
    k,P,hs,js,roots=setup()
    counts={};bad=0
    for u in k:
        for v in k:
            result=matrix_at(k,P,hs,roots,u,v)
            if result is None:
                continue
            N,candidates=result
            counts[int(N.rank())]=counts.get(int(N.rank()),0)+1
            # This numerical expression must agree with the earlier
            # necessary-equation probe for the actual inverse fifth roots.
            vec=vector(k,[u**5,v**5,1])
            if N*vec==0:
                bad+=1
    print('valid F25 rank census',counts,'actual null vectors',bad,flush=True)
    (args.output_dir/'normality_rank_census.json').write_text(json.dumps({
        'ranks':counts,'actual_null_vectors':bad,'scope':'F25 probe only'},indent=2)+'\n')
    if args.symbolic:
        symbolic(k,P,hs,roots,args.output_dir)
