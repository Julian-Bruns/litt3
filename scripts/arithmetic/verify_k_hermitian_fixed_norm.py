#!/usr/bin/env python3
"""Independently rebuild fixed-point norm equations and replay identities.

Uses only coded F25 arithmetic and ordinary sparse-polynomial products.
The Sym18 section-space rank has its separate complete certificate.
This checks the actual sections, the nine-dimensional subspace, all
eleven fiber conditions, and the supplied identity for1. No CAS is used.
"""
import argparse
import ast
import hashlib
import json
from collections import Counter
from itertools import combinations_with_replacement
from math import factorial
from pathlib import Path
import pro_quadratic_twist_vanishing as q
from k_fifth_twist_probe import reconstruct, serialize


def dot(a,b):
    v=0
    for x,y in zip(a,b):v=q.ADD[v][q.MUL[x][y]]
    return v


def remainder(f):
    assert all(r==0 and m>=0 for r,m in f)
    f=dict(f)
    while f and (d:=max(m for r,m in f))>=10:
        c=f[(0,d)]
        f=q.add(f,{(0,d-10+j):v for j,v in enumerate(q.P)},q.NEG[c])
    return f


def product(a,b):return remainder(q.multiply(a,b))


def add25(f,e,c):
    v=q.ADD[f.get(e,0)][c]
    if v:f[e]=v
    else:f.pop(e,None)


def verify_fiber_identity():
    zeta=next(w for w in range(2,25) if q.ADD[q.ADD[q.MUL[w][w]][w]][1]==0)
    # (binary index, variable index, cubic weight), for a,b,c,d.
    entries=[(0,0,0),(5,1,1),(1,2,2),(6,3,0)]
    for sign in (1,2):
        result={(0,(0,0,0,0)):1}
        for power in range(3):
            new={}
            for (i,e),value in result.items():
                for j,var,weight in entries:
                    exponent=list(e);exponent[var]+=1
                    factor=1
                    for _ in range(sign*power*weight):factor=q.MUL[factor][zeta]
                    add25(new,(i+j,tuple(exponent)),q.MUL[value][factor])
            result=new
        expected={(0,(3,0,0,0)):1,(3,(0,0,3,0)):1,
                  (6,(2,0,0,1)):3,(6,(1,1,1,0)):2,
                  (12,(1,0,0,2)):3,(12,(0,1,1,1)):2,
                  (15,(0,3,0,0)):1,(18,(0,0,0,3)):1}
        assert result==expected
        def mul(f,g):
            out={}
            for e,c in f.items():
                for ee,cc in g.items():add25(out,tuple(x+y for x,y in zip(e,ee)),q.MUL[c][cc])
            return out
        coeff={i:{e:c for (ii,e),c in result.items() if ii==i} for i in (0,3,6,12,15,18)}
        for terms in relation_terms(True):
            value={}
            for scale,indices in terms:
                f={(0,0,0,0):1}
                for i in indices:f=mul(f,coeff[i])
                for e,c in f.items():add25(value,e,q.MUL[scale%5][c])
            assert not value


def relation_terms(full):
    result=[[(1,(6,6,6,18)),(-1,(12,12,12,0))]]
    if full:
        result += [[(1,(6,6,6,6)),(-9,(0,12,6,6)),(27,(0,0,12,12)),
                    (27,(0,15,3,6)),(-27,(0,0,18,6))],
                   [(1,(12,12,12,12)),(-9,(18,6,12,12)),(27,(18,18,6,6)),
                    (27,(18,15,3,12)),(-27,(18,18,0,12))]]
    return result


def all_quartic_coefficients(g,full):
    zero=(0,)*9
    linear={i:{tuple(int(j==h) for h in range(9)):c for j,c in enumerate(row) if c}
            for i,row in g.items()}
    cache={():{zero:q.ONE}}
    def tensor(indices):
        indices=tuple(sorted(indices))
        if indices in cache:return cache[indices]
        out={}
        for e,c in tensor(indices[:-1]).items():
            for ee,cc in linear[indices[-1]].items():
                power=tuple(a+b for a,b in zip(e,ee))
                v=q.add(out.get(power,{}),product(c,cc))
                if v:out[power]=v
                else:out.pop(power,None)
        cache[indices]=out
        return out
    equations=[]
    for terms in relation_terms(full):
        out=[{} for _ in range(10)]
        for scale,indices in terms:
            for e,coeff in tensor(indices).items():
                for (_,m),c in coeff.items():add25(out[m],e,q.MUL[scale%5][c])
        equations.append(out)
    return equations


def quartic_coefficients(g6,g18,g12,g0):
    """Homogeneous coefficient polynomials, computed in F25[x]/P."""
    out=[{} for _ in range(10)]
    for cubes,last,sign in [(g6,g18,1),(g12,g0,4)]:
        for triple in combinations_with_replacement(range(9),3):
            count=Counter(triple); factor=6
            for v in count.values():factor//=factorial(v)
            f=q.ONE
            for j in triple:f=product(f,cubes[j])
            for j in range(9):
                e=tuple(count.get(i,0)+(i==j) for i in range(9))
                h=product(f,last[j])
                for (_,m),c in h.items():add25(out[m],e,q.MUL[(sign*factor)%5][c])
    return out


def add5(f,e,c):
    v=(f.get(e,0)+c)%5
    if v:f[e]=v
    else:f.pop(e,None)


def parse25(text,names):
    """Parse retained polynomial syntax using only elementary field operations."""
    zero=(0,)*len(names)
    def add(f,g,sign=1):
        out=dict(f)
        for e,c in g.items():add25(out,e,q.MUL[sign][c])
        return out
    def mul(f,g):
        out={}
        for e,c in f.items():
            for ee,cc in g.items():add25(out,tuple(a+b for a,b in zip(e,ee)),q.MUL[c][cc])
        return out
    def read(node):
        if isinstance(node,ast.Constant):
            c=int(node.value)%5;return {zero:c} if c else {}
        if isinstance(node,ast.Name):
            if node.id=='a':return {zero:5}
            assert node.id in names, ('unknown polynomial variable', node.id)
            return {tuple(int(node.id==name) for name in names):1}
        if isinstance(node,ast.UnaryOp):
            assert isinstance(node.op,(ast.USub,ast.UAdd))
            return add({},read(node.operand),4 if isinstance(node.op,ast.USub) else 1)
        assert isinstance(node,ast.BinOp)
        if isinstance(node.op,ast.Pow):
            assert isinstance(node.right,ast.Constant) and int(node.right.value)>=0
            f={zero:1};g=read(node.left)
            for _ in range(int(node.right.value)):f=mul(f,g)
            return f
        f,g=read(node.left),read(node.right)
        if isinstance(node.op,ast.Add):return add(f,g)
        if isinstance(node.op,ast.Sub):return add(f,g,4)
        assert isinstance(node.op,ast.Mult)
        return mul(f,g)
    return read(ast.parse(text.replace('^','**'),mode='eval').body)


def chart_equations(homogeneous,chart,names):
    out=[]; size=len(names)
    for f in homogeneous:
        g={}
        for e,c in f.items():
            if any(e[:chart]):continue
            ee=[0]*size
            for j in range(chart+1,9):ee[names.index(f'b{j}')]=e[j]
            add5(g,tuple(ee),c%5)
            ee[-1]=1;add5(g,tuple(ee),c//5)
        if g:out.append(g)
    if chart==8:
        e=[0]*size;e[names.index('unused')]=1;out.append({tuple(e):1})
    field={}
    for power,c in [(2,1),(1,4),(0,2)]:
        e=[0]*size;e[-1]=power;add5(field,tuple(e),c)
    out.append(field)
    return out


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('sections',type=Path)
    ap.add_argument('prepared',type=Path)
    ap.add_argument('certificate',type=Path)
    ap.add_argument('--basis-only',action='store_true',
                    help='Reconstruct equations and match a completed independent F25 unit-basis receipt; do not claim a replayed Bezout identity.')
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    verify_fiber_identity()
    data=json.loads(args.sections.read_text())
    prepared=json.loads(args.prepared.read_text())
    cert=json.loads(args.certificate.read_text())
    assert prepared['fixed_point_quartic_relation']
    assert prepared['section_input_sha256']==hashlib.sha256(args.sections.read_bytes()).hexdigest()
    assert cert['input_sha256']==hashlib.sha256(args.prepared.read_bytes()).hexdigest()
    source=[s for s in data['sections'] if s['C3_character']==0]
    assert len(source)==10
    for s in source:
        affine,other=reconstruct(data['columns'],s['coordinates'],18)
        assert serialize(affine)==s['affine'] and serialize(other)==s['other_chart']
        assert all((r+18-i)%3==0 for i,f in enumerate(affine) for r,m in f)
    bad=sorted({(i,r,m) for s in source for i in (4,9,14) for r,m,c in s['affine'][i]})
    M=[[next((c for rr,mm,c in s['affine'][i] if (rr,mm)==(r,m)),0)
        for s in source] for i,r,m in bad]
    assert len(q.rref(M)[1])==1
    B=prepared['invariant_coordinates']
    assert len(B)==9 and len(q.rref(B)[1])==9
    assert all(dot(row,col)==0 for row in M for col in B)
    finite={};infinity={}
    full=prepared.get('full_fiber_relations',False)
    for i in ((0,3,6,12,15,18) if full else (0,6,12,18)):
        fi=[];inf=[]
        for row in B:
            f={}
            for c,s in zip(row,source):
                f=q.add(f,{(r,m):v for r,m,v in s['affine'][i]},c)
            fi.append(remainder(f))
            vals=[next((c for r,m,c in s['other_chart'][i]
                        if r==0 and m==(-90+11*i)//3),0) for s in source]
            v=dot(row,vals)
            inf.append({(0,0):v} if v else {})
        finite[i]=fi;infinity[i]=inf
    finite_equations=all_quartic_coefficients(finite,full)
    assert finite_equations[0]==quartic_coefficients(finite[6],finite[18],finite[12],finite[0])
    equations=[f for row in finite_equations for f in row]
    for extra in all_quartic_coefficients(infinity,full):
        assert all(not f for f in extra[1:])
        equations.append(extra[0])
    names=prepared['variables']+['a']
    rebuilt=chart_equations(equations,prepared['chart'],names)
    # Sage can spell a coefficient with signed representatives. Reduce a^2-a+2
    # only after comparing F25 coefficients, not the identity being replayed.
    def reduce25(f):
        g={}
        for e,c in f.items():
            power=1
            for _ in range(e[-1]):power=q.MUL[power][5]
            add25(g,e[:-1],q.MUL[c][power])
        return g
    if args.basis_only:
        assert cert['status']=='COMPLETE' and cert['empty']
        assert cert['variables']==prepared['variables']
        assert cert['groebner_basis']==['1']
        recorded=[parse25(f,prepared['variables']) for f in cert['equations']]
        assert [reduce25(f) for f in rebuilt[:-1]]==recorded
        receipt={'status':'PASS','chart':prepared['chart'],
                 'scope':'Independently rebuilt all actual fixed-point equations and matched the completed independent F25 unit-basis computation. No Bezout multiplier replay is claimed in this receipt.',
                 'fiber_relations':3 if full else 1,
                 'input_hashes':{p.name:hashlib.sha256(p.read_bytes()).hexdigest()
                                 for p in (args.sections,args.prepared,args.certificate)}}
        args.output.write_text(json.dumps(receipt,indent=2)+'\n')
        print('PASS chart',prepared['chart'],'rebuilt equations and independent unit basis',flush=True)
        return
    assert cert['variables']==names
    recorded=[{tuple(e):c for e,c in f} for f in cert['equations']]
    assert [reduce25(f) for f in rebuilt]==[reduce25(f) for f in recorded]
    assert cert['empty'] and len(cert['multipliers'])==len(recorded)
    print('REBUILT chart',prepared['chart'],'all fixed-point equations',flush=True)
    total={};zero=(0,)*len(cert['variables'])
    for f,h in zip(recorded,cert['multipliers']):
        for e,c in h:
            for ee,cc in f.items():
                add5(total,tuple(a+b for a,b in zip(e,ee)),c*cc)
    assert total=={zero:1}
    receipt={'status':'PASS','chart':prepared['chart'],
             'scope':'Actual section reconstruction, nine-dimensional invariant norm subspace, all fixed-point equations, and literal prime-field identity1 independently verified.',
             'fiber_relations':3 if full else 1,
             'witness_terms':sum(len(h) for h in cert['multipliers']),
             'input_hashes':{p.name:hashlib.sha256(p.read_bytes()).hexdigest()
                             for p in (args.sections,args.prepared,args.certificate)}}
    args.output.write_text(json.dumps(receipt,indent=2)+'\n')
    print('PASS chart',prepared['chart'],'terms',receipt['witness_terms'],flush=True)


if __name__=='__main__':main()
