"""Geometric Sigma membership over the algebraic closure, for an F25 point.
No enumeration of points of X is used. The finite affine test computes a
univariate polynomial-module basis of the ideal of all evaluation minors.
"""
from pathlib import Path
import itertools,json
import numpy as np
from exact import *
ROOT=Path(__file__).resolve().parents[1]

def trim(a):
    a=list(map(int,a))
    while a and a[-1]==0:a.pop()
    return a

def padd(a,b):
    c=list(a)+[0]*max(0,len(b)-len(a))
    for i,x in enumerate(b):c[i]=int(ADD[c[i],x])
    return trim(c)
def pneg(a):return [int(NEG[x]) for x in a]
def pscale(a,c):return trim([int(MUL[x,c]) for x in a])
def pmul(a,b):
    if not a or not b:return []
    c=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b):c[i+j]=int(ADD[c[i+j],MUL[x,y]])
    return trim(c)
def pdiv(a,b):
    if not b:raise ZeroDivisionError
    r=list(a);q=[0]*max(0,len(a)-len(b)+1)
    while r and len(r)>=len(b):
        n=len(r)-len(b);c=int(MUL[r[-1],INV[b[-1]]]);q[n]=c
        for j,x in enumerate(b):r[n+j]=int(ADD[r[n+j],NEG[MUL[c,x]]])
        r=trim(r)
    return trim(q),r

def vscale(v,c):return [pscale(p,c) for p in v]
def vsubtract_multiple(v,q,w):return [padd(a,pneg(pmul(q,b))) for a,b in zip(v,w)]
def repr_sub(a,q,b):
    out={i:list(p) for i,p in a.items()}
    for i,p in b.items():
        out[i]=padd(out.get(i,[]),pneg(pmul(q,p)))
        if not out[i]:del out[i]
    return out

def hermite_columns(vectors):
    """Triangular module basis; track exact combinations of original columns."""
    G=[None]*3;C=[None]*3
    for idx,V in enumerate(vectors):
        v=[p[:] for p in V];rep={idx:[1]}
        while any(v):
            r=max(i for i in range(3) if v[i])
            if G[r] is None:
                s=int(INV[v[r][-1]]);G[r]=vscale(v,s);C[r]={i:pscale(p,s) for i,p in rep.items()};break
            q,rem=pdiv(v[r],G[r][r]);v=vsubtract_multiple(v,q,G[r]);rep=repr_sub(rep,q,C[r])
            if rem:
                # Replace the pivot by a strictly smaller-degree remainder.
                old,oldrep=G[r],C[r];s=int(INV[v[r][-1]])
                G[r]=vscale(v,s);C[r]={i:pscale(p,s) for i,p in rep.items()}
                v,rep=old,oldrep
        if all(G[r] is not None and G[r][r]==[1] for r in range(3)):
            return G,C,idx+1
    return G,C,len(vectors)

def module_reduce(v,G):
    v=[p[:] for p in v]
    for r in reversed(range(3)):
        if v[r] and G[r] is not None:
            q,_=pdiv(v[r],G[r][r]);v=vsubtract_multiple(v,q,G[r])
    return v

def build_sections():
    bb=[LP.term(i,j) for i,j in basis(23)]
    Cb=np.column_stack([residual(e*b,12) for b in bb]);kb=kernel(Cb)
    ss=[]
    for i in range(kb.shape[1]):
        b=linear_combination(kb[:,i],bb);ss.append(((e*b).plus(),b))
    ss += [(LP.term(i,j),ZERO) for i,j in basis(12)]
    assert len(ss)==19
    pair=np.array([[(u*a if i<6 else u*b).coeff(-1,2) for a,b in ss] for i,u in enumerate(XIB)],dtype=np.uint8)
    rr,piv=rref(np.column_stack([pair,np.eye(19,dtype=np.uint8)]),19);assert len(piv)==19
    inv=rr[:,19:];assert np.array_equal(matmul(pair,inv),np.eye(19,dtype=np.uint8))
    dual=[(linear_combination(inv[:,i],[a for a,b in ss]),linear_combination(inv[:,i],[b for a,b in ss])) for i in range(19)]
    (ROOT/'data'/'dual_sections.json').write_text(json.dumps([{'a':a.terms(),'b':b.terms()} for a,b in dual],indent=2)+'\n')
    np.savez_compressed(ROOT/'data'/'serre_pairing.npz',pairing=pair,inverse=inv,Cb=Cb,kernel_b=kb)
    return dual

def load_sections():
    f=ROOT/'data'/'dual_sections.json'
    if not f.exists():return build_sections()
    return [(LP.from_terms(s['a']),LP.from_terms(s['b'])) for s in json.loads(f.read_text())]

def sigma_generators(xi):
    xi=list(map(int,xi));lead=next(i for i,c in enumerate(xi) if c);dual=load_sections()
    a0,b0=dual[lead]
    W=[(a*xi[lead]-a0*xi[i],b*xi[lead]-b0*xi[i]) for i,(a,b) in enumerate(dual) if i!=lead]
    infinity=[[(a-e*b).coeff(4,0),b.coeff(1,2)] for a,b in W]
    witness=None
    for i,j in itertools.combinations(range(18),2):
        d=int(ADD[MUL[infinity[i][0],infinity[j][1]],NEG[MUL[infinity[i][1],infinity[j][0]]]])
        if d:witness={'rows':[i,j],'determinant':d};break
    minors=[a*d-b*c for (a,b),(c,d) in itertools.combinations(W,2)]
    vectors=[]
    for m in minors:
        for j in range(3):
            p=m*LP.term(0,j)
            assert all(i>=0 for i,j,c in p.terms())
            vectors.append([trim([p.coeff(i,j) for i in range(max(0,p.lo+p.a.shape[1]))]) for j in range(3)])
    return W,infinity,witness,vectors

def test_stability(xi,certificate=False):
    W,inf,ow,vs=sigma_generators(xi);G,C,used=hermite_columns(vs)
    unit=all(G[r] is not None and G[r][r]==[1] for r in range(3))
    # Verify every retained representation directly; no trust in reduction alone.
    for r in range(3):
        if G[r] is None:continue
        v=[[],[],[]]
        for i,p in C[r].items():
            v=[padd(a,pmul(p,b)) for a,b in zip(v,vs[i])]
        assert v==G[r]
    if not unit:
        assert all(not any(module_reduce(v,G)) for v in vs)
    out={'xi':list(map(int,xi)),'base_field':'F25','geometric_stable':unit and ow is not None,'finite_minor_ideal_is_unit':unit,'infinity_rank_two':ow is not None,'generators_processed':used}
    if certificate:
        out.update(Hermite_basis=G,combinations=[None if c is None else {str(i):p for i,p in c.items()} for c in C],infinity_matrix=inf,infinity_witness=ow)
    return out

def verify_certificate(c):
    _,inf,ow,vs=sigma_generators(c['xi']);G=c['Hermite_basis'];C=c['combinations']
    for r in range(3):
        if G[r] is None:continue
        out=[[],[],[]]
        for i,p in C[r].items():out=[padd(a,pmul(p,b)) for a,b in zip(out,vs[int(i)])]
        assert out==G[r]
        assert not any(G[r][r+1:])
    unit=all(G[r] is not None and G[r][r]==[1] for r in range(3))
    if not unit:assert all(not any(module_reduce(v,G)) for v in vs)
    assert inf==c['infinity_matrix']
    assert c['geometric_stable']==(unit and ow is not None)
    return True

if __name__=='__main__':
    build_sections();sources=[r['xi'] for r in json.loads((ROOT/'data'/'bounded_candidates.json').read_text())]
    sources.append([0]*13+[24,2,10,11,1,0])
    dual=load_sections()
    sources += [[a.eval(5,14) for a,b in dual],[b.eval(5,14) for a,b in dual],[(a-e*b).coeff(4,0) for a,b in dual],[b.coeff(1,2) for a,b in dual]]
    certs=[]
    for i,xi in enumerate(sources):
        c=test_stability(xi,True);assert verify_certificate(c);certs.append(c)
        print(i,'stable=',c['geometric_stable'],'finite unit=',c['finite_minor_ideal_is_unit'],'infinity rank2=',c['infinity_rank_two'],'used=',c['generators_processed'],flush=True)
    (ROOT/'certificates'/'stability.json').write_text(json.dumps(certs,indent=2)+'\n')
