"""Evaluate the complete 123x51 fixed-target system over any finite extension.
This evaluates specified points only. It does not solve the global system.
"""
from pathlib import Path
import itertools,json
import numpy as np
from extension_fields import Field,kernel_field,dot_field
ROOT=Path(__file__).resolve().parents[1]
D=np.load(ROOT/'data'/'tensors.npz');V=np.load(ROOT/'data'/'fixed_tensors.npz')

def contract(t,coefficients,F):
    shape=t.shape[1:];n=int(np.prod(shape));out=[0]*n
    for c,a in zip(coefficients,t):
        if c:
            for i,x in enumerate(a.reshape(-1)):
                if x:out[i]=F.add(out[i],F.mul(int(c),int(x)))
    return np.array(out,dtype=object).reshape(shape).tolist()

def complete_matrix(xi,F):
    if len(xi)!=19 or not any(xi):raise ValueError('nonzero 19-vector required')
    z=[F.pow(c,25) for c in xi]
    tz=contract(D['T'],z,F);qz=contract(D['Q'],z,F)
    coeff=[F.mul(xi[i],z[j]) for i in range(19) for j in range(19)]
    top=contract(V['TOP'].reshape(361,43,35),coeff,F)
    return [r+[0]*16 for r in tz]+[a+b for a,b in zip(top,qz)]

def evaluation_matrix(xi,F):
    z=[F.pow(c,25) for c in xi];coeff=[F.mul(xi[i],z[j]) for i in range(19) for j in range(19)]
    top=contract(V['EVTOP'].reshape(361,2,35),coeff,F);ss=contract(V['EVS'],z,F)
    low=contract(V['EVPHI'],z,F);nu=contract(V['NU'],xi,F)
    return [nu+V['SEVAL'].tolist(),top[0]+ss[0],top[1]+ss[1],V['AF'][0].tolist()+[0]*16,low[0]+[0]*16,low[1]+[0]*16,V['AF'][1].tolist()+[0]*16,low[2]+[0]*16,low[3]+[0]*16]

def test(xi,modulus=(0,1)):
    F=Field(modulus);xi=list(map(int,xi));C=complete_matrix(xi,F);ker=kernel_field(C,F);EV=evaluation_matrix(xi,F)
    hs=[[dot_field(row,h,F) for row in EV] for h in ker];det={}
    for p in itertools.permutations(range(3)):
        sign=4 if sum(p[i]>p[j] for i in range(3) for j in range(i+1,3))%2 else 1
        for inds in itertools.product(range(len(hs)),repeat=3):
            c=sign
            for r in range(3):c=F.mul(c,hs[inds[r]][3*r+p[r]])
            k=tuple(sorted(inds));det[k]=F.add(det.get(k,0),c)
    det={k:v for k,v in det.items() if v}
    return {'xi':xi,'modulus':list(modulus),'coefficient_field_size':F.q,'z':[F.pow(c,25) for c in xi],'hom_dimension':len(ker),'invertible_global_morphism_exists':bool(det),'determinant_terms':[{'monomial':list(k),'coefficient':c} for k,c in sorted(det.items())],'kernel':ker}

if __name__=='__main__':
    a=[0]*13+[24,2,10,11,1,0]
    tests=[test(a),test([1,25]+[0]*17,[20,0,1])]
    assert tests[0]['hom_dimension']==4 and not tests[0]['invertible_global_morphism_exists']
    assert tests[1]['z'][1]!=tests[1]['xi'][1]
    (ROOT/'certificates'/'extension_field_checks.json').write_text(json.dumps(tests,indent=2)+'\n')
    for t in tests:print({k:v for k,v in t.items() if k not in ['kernel','determinant_terms']})
