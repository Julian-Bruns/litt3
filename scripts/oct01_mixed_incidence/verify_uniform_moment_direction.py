#!/usr/bin/env sage
"""Independent original-field checks, including an explicitly synthetic L=0.

The synthetic rows test algebra only and are not a genuine source/witness.
"""
import argparse
import json
import random
import sys
import time
from pathlib import Path
sys.path.insert(0,str(Path(__file__).parent))
from uniform_moment_direction import build_uniform
from direction_boundary import marked_field
from field import K,F,transpose,mat_inv,dot
from finite import phi
from incidence import endpoint


def audit(ep, source_rows=None):
    A=endpoint(ep) if source_rows is None else source_rows
    R,eq,labels,aux=build_uniform(ep,source_rows)
    rng=random.Random(112); emb=lambda z:(z,K.zero,K.zero,K.zero)
    inverse=mat_inv(transpose((A['E1'][1:],A['C'][1:],A['U'][1:])))
    points=[]
    for sample in range(5):
        while True:
            w,Y=[aux['embed'](K.decode(rng.randrange(5**14))) for i in range(2)]
            p=[w**(5**r) for r in range(14)]+[Y**(5**r) for r in range(14)]+[0]
            B=aux['B'][0](*p);fs=[fn(*p) for fn in aux['denominators']]
            if B and fs[0]:break
        p[-1]=1/B
        rn=[pol(*p) for pol in aux['directions'][0]]
        eps=tuple(aux['unembed'](-aux['embed'](A['V'][1])*q/fs[0]) for q in rn)
        X=aux['unembed'](aux['X'][0](*p));y=aux['unembed'](Y);x=phi(X,4)
        D=F.add(F.mul(eps,F.sub(A['E1'],emb(phi(X,7)))),emb(phi(y,7)))
        G=F.add(F.mul(eps,F.sub(A['C'],emb(y))),emb(X))
        Z=tuple(K.scale(phi(D[l],8),g) for l,g in enumerate((13,17,7)))+(K.zero,)
        W=F.sub(emb(phi(X,11)),F.mul(eps,F.add(Z,emb(phi(y,1)))))
        third=F.add(F.add(F.mul(eps,F.sub(A['U'],emb(x))),A['V']),emb(phi(y,8)))
        assert G[3]==K.zero and third[1:]==(K.zero,)*3
        shift=(K.sub(A['E1'][0],phi(X,7)),K.sub(A['C'][0],y),K.sub(A['U'][0],x))
        functional=tuple(dot(shift,col) for col in zip(*inverse))
        residuals={'original_third_0':third[0],
            'actual_rank_lift':K.sub(K.add(Z[0],phi(y,1)),dot(functional,Z[1:]))}
        residuals.update({f'actual_W_G_{l}':K.sub(W[l],K.scale(phi(G[l],11),dl)) for l,dl in enumerate((8,18,15))})
        for i,(name,r) in enumerate(labels[:70]):
            denominator=fs[r] if name=='original_third_0' else fs[(r+8)%14] if name=='actual_rank_lift' else fs[r]*fs[(r+8)%14]*fs[(r+11)%14]
            assert eq[i](*p)==aux['embed'](phi(residuals[name],r))*denominator
        assert all(pol(*p)==0 for pol in eq[70:])
        for name,row in dict(C=D,E1=G,U=W,V=Z).items():
            denominator=fs[0] if name in ('C','E1') else fs[8] if name=='V' else fs[0]*fs[8]
            got=tuple(aux['unembed'](pol(*p)/denominator) for pol in aux['prospective_rows'][name][0])
            assert got==row
        points.append(dict(w=aux['unembed'](w),Y=y))
    return dict(source=ep,synthetic=source_rows is not None,source_rows=A if source_rows is not None else None,
        L_zero=aux['L']==0,singular_first_moment=aux['unembed'](aux['singular_x']),
        random_points=points,point_checks=5,all_original_residuals_and_rows_checked=True)


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--output',required=True,type=Path);args=ap.parse_args();start=time.monotonic()
    fixtures=[((0,1),(2,3),(0,1),(4,5)),((0,1),(0,2),(0,1),(2,3)),
              ((0,1),(2,3),(0,1),(3,4)),((0,1),(0,1),(2,3),(4,5)),
              ((0,0),(0,1),(1,1),(2,3))]
    results=[audit(ep) for ep in fixtures]
    KK,b,embed,unembed=marked_field();synthetic=None
    for ep in fixtures:
        A=endpoint(ep);U=[embed(q) for q in A['U']]
        ratio=(U[2]**2-U[1]*U[3])/(U[1]**2-b(21)*U[3]**2)
        if ratio and ratio.is_square():
            k=ratio.sqrt();A['V']=tuple(A['V'][j] if j!=2 else unembed(k*embed(A['V'][1])) for j in range(4))
            synthetic=audit(ep,A);assert synthetic['L_zero'];break
    assert synthetic is not None, 'fixture list must exercise synthetic L=0'
    results.append(synthetic)
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(dict(results=results,seconds=time.monotonic()-start,
        scope='algebra checks; synthetic L=0 is not a genuine source or incidence witness'),indent=2)+'\n')
    print(json.dumps(dict(fixtures=len(results),point_checks=sum(r['point_checks'] for r in results),
        synthetic_L_zero=True,seconds=time.monotonic()-start)),flush=True)


if __name__=='__main__':main()
