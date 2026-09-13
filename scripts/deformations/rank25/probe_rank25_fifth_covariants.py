"""Finite-deck test for bounded cotangent-valued fifth-obstruction sections.

This is a linear-algebra probe. The required geometric support bound is
not inferred from its output. Run under a Python with numpy.
"""
import argparse
import importlib.util
import json
from pathlib import Path
import sys
import time

import numpy as np

ap=argparse.ArgumentParser(description=__doc__)
ap.add_argument('--evidence',type=Path,required=True)
ap.add_argument('--degree',type=int,default=3)
ap.add_argument('--output',type=Path,required=True)
ap.add_argument('--ordinary',type=Path)
args=ap.parse_args();st=time.time()
sys.path.insert(0,str(args.evidence/'lib'))
import finite_field as F
from locus import P,U,A,B,q,qi,s1,s2,v1,v2,Ap,Bp,exps,reduce_s

root=Path(__file__).resolve().parents[3]
pair=json.loads((root/'Research/computations/rank25_generalization_leverage.json').read_text())['constant_gradient_test']['exact_pairing']
pair=np.array([[F.IFP[F.ff(c)] for c in row] for row in pair],dtype=np.uint16)
xs=[U,v1+q*F.ff('4331'),v2+q*F.ff('2234'),A+'3003',B+'0314',q*F.ff('3112'),q,P(),P()]

def derivative(p,j):
    out={}
    for e,c in p.d.items():
        n=e[j]%5
        if n:
            k=tuple(a-int(i==j) for i,a in enumerate(e))
            out[k]=F.mul(n,c)
    return P(out)

theta0=P('3440')+q**2*(P('0343')+A*F.ff('1313')+B*F.ff('2324'))
theta0+=A**2*F.ff('2142')+A*B*F.ff('2010')+B**2*F.ff('3022')
theta0+=A**3*F.ff('0023')+A**2*B*F.ff('3122')+A*B**2*F.ff('4224')+B**3*F.ff('2132')
uc=-theta0*qi**2*F.inv(F.ff('2110'))
row=[]
for j in [1,2,3]:
    row.append([sum((derivative(x,j)*int(pair[i,col]) for i,x in enumerate(xs)),P()) for col in range(9)])
assert pair[0,0] == 1 and not np.any(pair[0,1:]), 'dU must pair only with the fixed trace coordinate'

def cmatrix(cols):
    keys=sorted(set().union(*(set((i,*e) for i,p in enumerate(c) for e in p.d) for c in cols)))
    idx={e:i for i,e in enumerate(keys)}
    out=np.zeros((len(keys),len(cols)),dtype=np.uint16)
    for j,c in enumerate(cols):
        for i,p in enumerate(c):
            for e,v in p.d.items():out[idx[(i,*e)],j]=v
    return out

def log(*x):print(*x,'seconds',round(time.time()-st,2),flush=True)

coords=[uc,xs[1],xs[2],A,B,q]
pw=[[x**j for j in range(args.degree+1)] for x in coords]
cols=[];labels=[]
for d in range(args.degree+1):
    for e in exps(6,d):
        mon=P(1)
        for i,j in enumerate(e):mon*=pw[i][j]
        for target in range(1,9):
            cols.append([mon*rr[target] for rr in row]);labels.append([target,list(e)])
orig=cmatrix(cols);log('section matrix',orig.shape)
_,piv=F.rref(orig,False)
cols=[cols[i] for i in piv];labels=[labels[i] for i in piv]
log('independent section dimension',len(cols))

# On trace zero the finite deck action is a translation in A,B with q fixed.
a=(Ap-A)*qi;b=(Bp-B)*qi
maxa=max((e[1] for c in cols for p in c for e in p.d),default=0)
maxb=max((e[2] for c in cols for p in c for e in p.d),default=0)
apow=[Ap**j for j in range(maxa+1)];bpow=[Bp**j for j in range(maxb+1)]
cache={}
def translate(p):
    out=P()
    for e,c in p.d.items():
        assert not e[0] and not e[4] and not e[5]
        k=e[1:4]
        if k not in cache:cache[k]=apow[k[0]]*bpow[k[1]]*(q**k[2] if k[2]>=0 else qi**(-k[2]))
        out+=cache[k]*c
    return out

diff=[];restr=[]
for j,col in enumerate(cols):
    trans=[translate(p) for p in col]
    trans[2]+=a*trans[0]+b*trans[1]
    diff.append([reduce_s(p-o) for p,o in zip(trans,col)])
    restr.append([P({e:c for e,c in p.d.items() if e[1]==e[2]==0}) for p in col])
    if (j+1)%100==0:log('translated sections',j+1)
dm=cmatrix(diff);sm=cmatrix(restr)
log('difference / restriction matrices',dm.shape,sm.shape)
rankd=len(F.rref(dm,False)[1]);ranks=len(F.rref(np.vstack([dm,sm]),False)[1])
out={'status':'finite covariant-space calculation only; not a geometric support theorem',
     'degree':args.degree,'input_columns':int(orig.shape[1]),'section_dimension':len(cols),
     'finite_deck_difference_rank':rankd,'difference_plus_curve_restriction_rank':ranks,
     'invariant_section_dimension':len(cols)-rankd,
     'invariants_vanishing_on_known_curve':len(cols)-ranks,
     'known_curve':'A=B=0, U=2130+q^-2; q invertible',
     'interpretation':'Differences of fifth obstruction classes with identical ordinary channels, vanishing trace, and cubic Frobenius support would lie in this cotangent-valued space.',
     'independent_column_labels':labels,'seconds':time.time()-st}
args.output.write_text(json.dumps(out,indent=2)+'\n');log({k:v for k,v in out.items() if k!='independent_column_labels'})

if args.ordinary:
    ordinary=json.loads(args.ordinary.read_text())
    moved=[uc-P('2130'),xs[1],xs[2],A,B,q*F.ff('3112'),q]
    def frobp(p):
        return P({tuple(5*x for x in e):int(F.FROB[c]) for e,c in p.d.items()})
    fifth=[frobp(x) for x in moved]
    known=[P() for _ in range(9)]
    for i in range(7):
        di=ordinary['directions'][str(i)]
        direct=ordinary['moving_fourth_normal']['linear'][i]['direct_fourth_projection']
        for target in range(9):
            known[target]+=moved[i]*F.add(di['constant_projection'][target],direct[target])
        for j in range(7):
            co=di['mixed_first_directions'][j+1]['projection']
            for target in range(9):known[target]+=moved[i]*fifth[j]*int(co[target])
    for co in ordinary['moving_fourth_normal']['quadratic']:
        for target,c in enumerate(co['direct_fourth_projection']):
            known[target]+=moved[co['i']]*moved[co['j']]*int(c)
    assert not known[0].d,'known ordinary trace should vanish on the candidate chart'
    kw=[sum((frobp(rr[j])*known[j] for j in range(9)),P()) for rr in row]
    # Extend the translation cache to the (larger) known support.
    maxa=max(e[1] for p in kw for e in p.d);maxb=max(e[2] for p in kw for e in p.d)
    apow=[Ap**j for j in range(maxa+1)];bpow=[Bp**j for j in range(maxb+1)]
    kt=[translate(p) for p in kw]
    kt[2]+=frobp(a)*kt[0]+frobp(b)*kt[1]
    kd=[reduce_s(p-o) for p,o in zip(kt,kw)]
    # Inverse Frobenius in the finite etale AS coefficient algebra, not
    # inverse Frobenius of arbitrary geometric parameters by exponent125.
    from locus import H,inv2
    hi=inv2(H)
    sr1=s1*int(F.IFP[hi[0][0]])+s2*int(F.IFP[hi[0][1]])
    sr2=s1*int(F.IFP[hi[1][0]])+s2*int(F.IFP[hi[1][1]])
    def rootdiff(p):
        result=P()
        for e,c in p.d.items():
            assert all(i%5==0 for i in e[:4]),('non-Frobenius covariant defect',e,F.fmt(c))
            mon=P({tuple(i//5 for i in e[:4])+(0,0):int(F.IFP[c])})
            result+=mon*sr1**e[4]*sr2**e[5]
        return reduce_s(result)
    rhs=[-rootdiff(p) for p in kd]
    aug=cmatrix([*diff,rhs]);rr,piv=F.rref(aug)
    consistent=len(cols) not in piv
    log('inhomogeneous covariance',consistent,'rank',len(piv))
    out['ordinary_channel_covariance_consistent']=consistent
    if not consistent:
        args.output.write_text(json.dumps(out,indent=2)+'\n')
        raise AssertionError('proposed known channels do not admit a cubic covariant completion')
    particular=np.zeros(len(cols),dtype=np.uint16)
    for i,j in enumerate(piv):particular[j]=rr[i,-1]
    null=F.nullspace(dm)
    def combine(c):
        return [sum((col[i]*int(x) for x,col in zip(c,cols) if x),P()) for i in range(3)]
    def serial(p):return [[list(e),int(c)] for e,c in sorted(p.d.items())]
    out['particular_cotangent_root_section']=[serial(p) for p in combine(particular)]
    out['homogeneous_cotangent_root_sections']=[[serial(p) for p in combine(v)] for v in null]
    out['known_nonFrobenius_normal_part']=[serial(p) for p in known]
    out['root_cotangent_rows']=[[serial(p) for p in rr] for rr in row]
    out['particular_coefficients']=particular.tolist()
    out['homogeneous_coefficients']=null.tolist()
    out['seconds']=time.time()-st
    args.output.write_text(json.dumps(out,indent=2)+'\n')
    _,row_piv=F.rref(dm.T,False)
    _,col_piv=F.rref(dm,False)
    np.savez_compressed(args.output.with_suffix('.npz'),
      representation=orig,difference=dm,restriction=sm,
      covariance_augmented=aug,homogeneous_basis=null,
      particular=particular,pivot_rows=np.array(row_piv),pivot_columns=np.array(col_piv))
    log('saved covariance reconstruction space')
