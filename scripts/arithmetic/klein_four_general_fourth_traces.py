#!/usr/bin/env python3
"""Apply the universal fourth jet to actual endpoint multisets.

Uses the previously verified finite complete complementary-double-label
moment classification. Unknown curve coefficients are never bounded.
"""
import argparse
import json
import sys
from pathlib import Path

sys.path.insert(0,str(Path(__file__).parent/'pro_finite_loci_v4_20260926/v4/src'))
import structural_field as F
import moment_linearization as M


def fourth_sums(labels):
    f=F.lift25row([20,12,13,8]);g=F.lift25row([21,21,20,2])
    fs=[];gs=[]
    for _ in range(4):
        fs.append(f);gs.append(g);f=F.sigma(f);g=F.sigma(g)
    U=V=F.F0
    for ij in labels:
        i,j=divmod(ij,29)
        U=F.fa(U,F.fk(fs[i],F.ZPOW[17*j%29]))
        V=F.fa(V,F.fk(gs[i],F.ZPOW[4*j%29]))
    return U,V


def residuals(q,h,x,y,ep):
    U,V=fourth_sums(q);W,Z=fourth_sums(h)
    x3=F.kp(x,625);ym1=F.kp(F.kb(y),5)
    xm3=F.kp(F.kb(x),625);y1=F.kp(y,5)
    lift=lambda t:tuple(t)+(0,)*6
    r0=F.fs(F.fa(F.fm(ep,U),V),F.fk(F.fs(F.fm(ep,lift(x3)),lift(ym1)),F.old25(22)))
    r1=F.fs(F.fa(W,F.fm(ep,Z)),F.fk(F.fs(lift(xm3),F.fm(ep,lift(y1))),F.old25(22)))
    return r0,r1


def main(source,out):
    cert=json.loads(source.read_text());results=[]
    for row in cert['decoded_points']:
        phase=row['phase_representative'];q=[0,0,58,58];h=[29+phase,29+phase,87+phase,87+phase]
        p=row['point'];x=tuple(p['x_M2']);y=tuple(p['y_M6']);ep=tuple(p['epsilon'])
        chk=M.test_point(q,h,p['point'])
        assert chk['valid_nonzero_scale'] and tuple(chk['epsilon'])==ep
        rs=residuals(q,h,x,y,ep)
        results.append(dict(phase=phase,point_index=row['point_index'],
                            fourth_residuals=rs,passes=all(r==F.F0 for r in rs)))
    projections={}
    for name,row in [('F0',[20,12,13,8]),('F1',[21,21,20,2])]:
        v=F.lift25row(row);p=[]
        for lam in [1,2,3,4]:
            w=v;s=F.F0
            for i in range(4):
                s=F.fa(s,F.fc(w,4*pow(lam,-i,5)%5));w=F.sigma(w)
            p.append(s)
        projections[name]=p
    result=dict(scope='Every complementary-double-label moment solution, all phases, all degrees',
                canonical_fourth_projections=projections,checks=results,
                survivors=sum(r['passes'] for r in results))
    out.write_text(json.dumps(result,indent=2)+'\n')
    print('Checked',len(results),'complete moment points; fourth-jet survivors',result['survivors'])
    print('Eigenprojection supports:', {k:[j+1 for j,v in enumerate(vs) if v!=F.F0] for k,vs in projections.items()})


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('source',type=Path);p.add_argument('--output',type=Path,required=True)
    a=p.parse_args();main(a.source,a.output)
