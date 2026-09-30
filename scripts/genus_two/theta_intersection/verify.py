#!/usr/bin/env python3
"""Verify the complete finite certificate, using only Python's standard library.

Run: python verify.py --data-dir /absolute/external/certificate/directory
No Sage, NumPy, network access, or input from a previous computation is needed.
All matrix entries are computed exactly in F_5[alpha]/(alpha^3+alpha+1).
"""
import json
from pathlib import Path
from core import *
from homogeneous import forms, macaulay

from locations import certificate_dir

def check(assertion, message):
    if not assertion:
        raise ArithmeticError(message)

def main():
    HERE=certificate_dir()
    data=json.loads((HERE/'data.json').read_text())
    cert=json.loads((HERE/'smoothness_certificates.json').read_text())
    check(data['alpha']==5 and data['beta']==powf(5,5)==106,'Frobenius coefficient')
    check(data['curve_coefficients']==f==[0,106,48,107,48,1],'Twisted curve coefficients')
    check([tuple(t['pair']) for t in data['covers']]==pairs,'All fifteen covers')
    check([tuple(t['pair']) for t in cert]==pairs,'All fifteen certificates')
    check(data['quadric_monomials']==[list(x) for x in mons2],'Quadric monomial order')
    check(data['quartic_monomials']==[list(x) for x in hommons(4,4)],'Quartic monomial order')

    # Verify each projective translation matrix by exact Mumford additions.
    # The true translation is projectively linear on |2 Theta|. Rank 15 of
    # these constraints identifies it uniquely, so this is not a point-sampling
    # inference about a nonlinear map.
    for cov in data['covers']:
        pair=tuple(cov['pair']);C,D=torsion(pair);M=cov['matrix'];eq=[]
        check(cov['square']!=0,'Nonzero square scalar')
        check(mm(M,M)==[[cov['square'] if i==j else 0 for j in range(4)] for i in range(4)],'Translation square')
        for A,B,E,G in cov['samples']:
            check(A[-1]==E[-1]==1 and len(A)==len(E)==3,'Reduced Mumford polynomials')
            check(not pmod(ps(pm(B,B),f),A),'Source divisor lies on C')
            check(not pmod(ps(pm(G,G),f),E),'Target divisor lies on C')
            check(pmod(A,C)!=[] and pxgcd(A,C)[0]==[1],'Coprime addition chart')
            check(coprime_add(A,B,C,D)==(E,G),'Exact addition by the specified character')
            X=kum(A,B);Y=kum(E,G)
            check(normalize(mv(M,X))==Y,'Matrix realizes the exact translation')
            for j in range(1,4):
                row=[0]*16
                for c in range(4):row[j*4+c]=mul(Y[0],X[c]);row[c]=NEG[mul(Y[j],X[c])]
                eq.append(row)
        check(len(null(eq))==1,'Unique projective translation matrix')

    # The sixteen theta-trope normals are the nodes of the decomposable
    # Kummer surface in the bundle-moduli projective space.
    nodes=[[1,0,0,0]]+[normalize(c['matrix'][0]) for c in data['covers']]
    check(nodes==data['dual_Kummer_nodes'],'Kummer nodes')
    check(len(set(map(tuple,nodes)))==16,'Distinct Kummer nodes')
    mon4=hommons(4,4);rows=[]
    for v in nodes:
        for i in range(4):
            row=[]
            for m in mon4:
                if not m[i]:row.append(0)
                else:
                    e=list(m);e[i]-=1;row.append(mul(m[i]%5,monval(e,v)))
            rows.append(row)
    ns=null(rows)
    check(len(ns)==1 and normalize(ns[0])==data['dual_Kummer'],'Unique quartic singular at these sixteen nodes')
    print('Verified: all translations; the decomposable Kummer quartic.')

    # Recompute Psi directly from the original, untwisted curve coefficients.
    a0=0;a1=alpha;a2=a4=sub(4,alpha);a3=add(1,alpha)
    W=[mul(3,a3),mul(3,a4),1]
    V=pa([NEG[a2]],pm([a4,2],W))
    Psi=monic(ps(pa([mul(2,a0),NEG[mul(2,a1)]],pc(W,a2)),pm(V,W)))
    check(Psi==data['Psi']==[63,81,75,53,6,1],'Dormant polynomial')
    zpol=[[55,82,104,115,87],[67,74,82,45,60],[19,60,68,13,18],[1]]
    cols=[pmod(pm(zpol[i],zpol[j]),Psi)+[0]*5 for i,j in mons2]
    evalrows=[[cols[j][i] for j in range(10)] for i in range(5)]

    labels=['0','1','2','3','alpha','infinity']
    for cov,certificate in zip(data['covers'],cert):
        M=tr(cov['matrix']);c=cov['square'];comp=[]
        for j in range(10):
            u=[0]*10;u[j]=1;v=quad_comp(u,M);v[j]=sub(v[j],c);comp.append(v)
        invrows=tr(comp)
        check(len(null(invrows))==6,'Six-dimensional invariant-quadratic space')
        ns=null(invrows+evalrows)
        check(len(ns)==1 and normalize(ns[0])==cov['quadric'],'Unique invariant quadric through all five dormant points')
        check([qval(cov['quadric'],x) for x in nodes]==cov['node_values'],'Node evaluations')
        check(all(cov['node_values']),'Candidate avoids every Kummer node')

        # Homogeneous, not affine: full rank implies (z0,z1,z2,z3)^9 is
        # contained in (Q,K,all 2x2 Jacobian minors).
        A,rowlabels=macaulay(forms(data,cov),9)
        check(len(A)==512 and all(len(r)==220 for r in A),'Macaulay matrix dimensions')
        check(certificate['degree']==9 and certificate['rank']==220,'Certificate degree and rank')
        chosen=certificate['rows']
        check(len(chosen)==len(set(chosen))==220 and all(0<=i<512 for i in chosen),'Selected minor')
        value=det([A[i] for i in chosen])
        check(value!=0 and value==certificate['determinant'],'Exact nonzero 220 by 220 determinant')
        a,b=cov['pair']
        print('{%s,%s}: invariant kernel dimension 1; degree-9 rank 220; determinant code %s' % (labels[a],labels[b],value))
    print('PASS: all fifteen homogeneous smoothness certificates verified.')
    print('Geometric interpretation: Proofs/projective_connections/backup_double_tower_dormant.md')

if __name__=='__main__':
    main()
