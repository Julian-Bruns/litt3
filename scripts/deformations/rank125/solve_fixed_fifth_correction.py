#!/usr/bin/env python3
"""Construct a fourth-digit correction at the actual fifth-line zero.

Uses triangular degree3/degree5/degree7 solves, with actual mixed-
characteristic E4 evaluations for unknown regular tails. The additive
relative identity is a separately proved input. Outputs stay external.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import sys
import time


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--engine-dir',type=Path,required=True)
    ap.add_argument('--quadratic-certificate',type=Path,required=True)
    ap.add_argument('--fifth-receipt',type=Path)
    ap.add_argument('--output',type=Path,required=True)
    ap.add_argument('--profile-only',action='store_true')
    args=ap.parse_args()
    root=Path(__file__).resolve().parents[3]
    assert not args.output.resolve().is_relative_to(root)
    os.environ['LITT3_REFERENCE_MODULUS']='625'
    os.environ['LITT3_REFERENCE_PRECISION']='1800'
    sys.path.insert(0,str(args.engine_dir.resolve()))
    from build_exact import build
    build()
    import primary as pr, schur as sh, cover_char5 as ch
    from rank125_fourth import Calculation
    from normal_projection import project
    start=time.monotonic()
    def log(*x):print(*x,'seconds',round(time.monotonic()-start,2),flush=True)
    data=ch.load();d=json.loads(args.quadratic_certificate.read_text())
    assert d['kernel_basis']==data['nus']
    qe=[tuple(e) for e in d['quotient_exponents']]
    qi=[pr.MONIDX[e] for e in qe]
    fixed=[1,2,11,12,15,16,27,30,31,39]
    assert all(all(not c or (sum(e)%2==1 and e[0]%2==1)
                   for e,c in zip(pr.MONS,data['nus'][i])) for i in fixed)
    Hc={1:101,2:14,11:122,12:93,15:117,16:115,27:83,30:74,31:58,39:8}
    qpair={}
    for ij,v in zip(d['quadratic_pairs'],d['quadratic_scalar_coefficients']):
        v=ch.quotient(v,data);qpair[tuple(ij)]=[v[i] for i in qi]
    def add(x,y):return [pr.ADD[a][b] for a,b in zip(x,y)]
    def scale(x,c):return [pr.MUL[a][c] for a in x]
    def lincomb(vs,cs):
        out=[0]*len(vs[0])
        for v,c in zip(vs,cs):out=add(out,scale(v,c))
        return out
    def qvalue(x,y):
        out=[0]*43
        for i,a in enumerate(x):
            if not a:continue
            for j,b in enumerate(y):
                if b:out=add(out,scale(qpair.get(tuple(sorted((i,j))),[0]*43),pr.MUL[a][b]))
        return out
    hc=[Hc.get(i,0) for i in range(43)]
    units=[[int(i==j) for i in range(43)] for j in range(43)]
    L={j:add(scale(d['carry_images'][j],4),scale(qvalue(hc,units[j]),2)) for j in fixed}
    low=[i for i,e in enumerate(qe) if sum(e)<=3]
    deg5=[i for i,e in enumerate(qe) if sum(e)==5]
    def solve(columns,rhs):
        n=len(columns);rows=[list(r)+[b] for r,b in zip(zip(*columns),rhs)]
        rr,pv=sh.rref(rows,n)
        assert all(not r[-1] for r in rr[len(pv):]),'inconsistent triangular target'
        x=[0]*n
        for i,p in enumerate(pv):x[p]=rr[i][-1]
        assert lincomb(columns,x)==rhs
        return x,pv
    lowcols=[[L[j][i] for i in low] for j in fixed]
    _,lowpiv=solve(lowcols,[0]*len(low))
    assert len(lowpiv)==3
    high=[j for j in fixed if d['kernel_leading_degrees'][j]>=7]
    rows=list(map(list,zip(*[[L[j][i] for i in low] for j in high])))
    rr,pv=sh.rref(rows,len(high))
    ker=[]
    for f in range(len(high)):
        if f in pv:continue
        v=[0]*len(high);v[f]=1
        for r,p in enumerate(pv):v[p]=pr.NEG[rr[r][f]]
        assert not any(lincomb([[L[j][i] for i in low] for j in high],v))
        ker.append(v)
    highcoeff=[lincomb([units[j] for j in high],v) for v in ker]
    highcols=[lincomb([[L[j][i] for i in deg5] for j in high],v) for v in ker]
    _,highpiv=solve(highcols,[0]*len(deg5))
    assert len(highpiv)==4
    gamma1=add(scale(units[27],11),units[30])
    gamma2=add(scale(units[27],87),units[31])
    gcols=[lincomb([L[j] for j in fixed],[v[j] for j in fixed]) for v in (gamma1,gamma2)]
    assert all(not x for col in gcols for e,x in zip(qe,col) if sum(e)!=7)
    _,gpiv=solve(gcols,[0]*43);assert len(gpiv)==2
    report={'status':'profile PASS','fixed_source_indices':fixed,'H_kernel_coefficients':Hc,
            'quotient_exponents':qe,'low_rows':low,'low_columns':lowcols,
            'low_pivots':lowpiv,'high_kernel_coefficients':highcoeff,
            'high_degree5_columns':highcols,'high_pivots':highpiv,
            'terminal_columns':gcols,'ranks':[3,4,2]}
    log('triangular fixed correction ranks PASS',3,4,2)
    if not args.profile_only:
        receipt=json.loads(args.fifth_receipt.read_text())
        assert receipt['lambda_code']==8 and receipt['fifth_scalar']==0
        E=[receipt['E5'][i] for i in qi]
        assert all(not c or (sum(e)%2 and e[0]%2) for e,c in zip(qe,E))
        calc=Calculation()
        def actual_response(v,name):
            scalar=lincomb(data['nus'],v)
            raw=calc.compare(scalar,name)
            e,normal,projection=project(raw['rho4'],calc)
            e=[e[i] for i in qi]
            response=add(add(e,scale(qvalue(v,v),4)),scale(qvalue(hc,v),2))
            report[name]={'kernel_coefficients':v,'E4':e,'Q':qvalue(v,v),
                          'mixed_Q':scale(qvalue(hc,v),2),'response':response,
                          'projection':projection,'checks':raw['checks']}
            log(name,'actual mixed-characteristic response PASS')
            return response
        lc,_=solve(lowcols,[pr.NEG[E[i]] for i in low])
        vlow=lincomb([units[j] for j in fixed],lc)
        residual=add(E,actual_response(vlow,'fifth_correction_low'))
        assert all(not residual[i] for i in low)
        hs,_=solve(highcols,[pr.NEG[residual[i]] for i in deg5])
        vhigh=lincomb(highcoeff,hs)
        residual=add(residual,actual_response(vhigh,'fifth_correction_high'))
        assert all(not c for e,c in zip(qe,residual) if sum(e)<7)
        gs,_=solve(gcols,scale(residual,4))
        terminal=lincomb([gamma1,gamma2],gs)
        residual=add(residual,lincomb(gcols,gs));assert not any(residual)
        total=add(add(vlow,vhigh),terminal)
        report.update(status='actual relative correction PASS',
                      fifth_receipt_sha256=hashlib.sha256(args.fifth_receipt.read_bytes()).hexdigest(),
                      terminal_coefficients=gs,fourth_translation=total,
                      zero_residual=residual,
                      scope='Exact additive relative identity plus two whole E4 tail evaluations; direct translated fifth tuple comparison is a separate check')
        log('complete fourth translation',[(i,c) for i,c in enumerate(total) if c])
    report['source_sha256']=hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    report['quadratic_certificate_sha256']=hashlib.sha256(args.quadratic_certificate.read_bytes()).hexdigest()
    args.output.write_text(json.dumps(report,indent=2)+'\n')


if __name__=='__main__':main()
