#!/usr/bin/env python3
"""Experimental whole fifth comparison above the explicit fixed fourth line.

Uses the returned, separately audited fourth engine as an explicit source
dependency. All caches and outputs must be outside the research workspace.
The second source is solved against the FULL six-row primary, and the
second formal repair is the whole quotient, never a finite tail model.
No fifth value is an input. This source is not itself a theorem.
"""
import argparse
import hashlib
import itertools
import json
import math
import os
from pathlib import Path
import pickle
import sys
import time


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--engine-dir',type=Path,required=True)
    ap.add_argument('--output-dir',type=Path,required=True)
    ap.add_argument('--precision',type=int,default=3200)
    ap.add_argument('--lambda-code',type=int,choices=range(125),default=0)
    ap.add_argument('--frobenius-variant',type=int,choices=(0,1),default=0)
    ap.add_argument('--branch',type=int,choices=(-1,1),default=1)
    ap.add_argument('--stop-after-fourth',action='store_true')
    args=ap.parse_args()
    root=Path(__file__).resolve().parents[3]
    for p in (args.engine_dir,args.output_dir):
        assert not p.resolve().is_relative_to(root),'Generated data must be outside litt3'
    args.output_dir.mkdir(parents=True,exist_ok=True)
    os.environ['LITT3_REFERENCE_MODULUS']='3125'
    os.environ['LITT3_REFERENCE_PRECISION']=str(args.precision)
    sys.path.insert(0,str(args.engine_dir.resolve()))
    from build_exact import build
    build()
    import numpy as np
    import witt_cubic as w
    import batch_witt as b
    import primary as pr
    import schur as sh
    import cover_char5 as ch
    from field import pw,digits
    from rank125_fourth import Calculation
    from fourth_engine import Engine
    from normal_projection import interpolate,to_affine_coordinates,split_base,project

    started=time.monotonic()
    def log(*xs):print(*xs,'seconds',round(time.monotonic()-started,2),flush=True)
    calc=Calculation(args.frobenius_variant,args.branch)
    data=calc.data
    # Lift the ACTUAL affine roots through125; resectioning their Laurent
    # coefficients is not a substitute for an affine lift of the first graph.
    for i in range(3):
        a=pow(pow((3,1,2)[i],-1,5),625,3125)
        error=(calc.W[i]**5-a*calc.W[i]-b.Ser(a*calc.FU[i])).mod(125)
        calc.W[i]=(calc.W[i]+b.Ser(w.ci(a))*error).mod(125)
        check=(calc.W[i]**5-a*calc.W[i]-b.Ser(a*calc.FU[i])).mod(125).cut(60)
        assert check.prec>=60 and check.iszero(),('affine root125',i,check)
    calc.Wpowers.clear()
    hcoeffs={1:101,2:14,11:122,12:93,15:117,16:115,27:83,30:74,31:58}
    H=[0]*125
    for i,c in hcoeffs.items():H=sh.padd(H,sh.pscale(data['nus'][i],c))
    H=sh.padd(H,sh.pscale(data['nus'][39],args.lambda_code))
    n,n5,aff1,bound1=ch.primary_repair(H,data)

    def even_jmath(poly):
        return all((int(bool(c&1))+int(bool(c&2))+e[0])%2==0
                   for e,p in poly.items() for (c,h) in p)
    assert all(even_jmath(p) for p in (n,aff1,bound1))
    assert all(h>=0 for p in aff1.values() for (c,h) in p)
    assert all(h<=pr.BOUND[c] for p in bound1.values() for (c,h) in p)
    nv=calc.evaluate(n,m=125)
    en=Engine(b.Ser,calc.o,nv)
    IU=[[b.Ser(x) for x in row] for row in calc.bf['IU']]
    IO=[[b.Ser(x) for x in row] for row in calc.bf['IO']]
    ov=en.overlap()
    rho3,G3=en.comparison(ov,IU,IO,b.Ser(0),25,5)
    an5=b.Ser(w.peval(calc.o['AP'],calc.u))*nv.frob()
    en.zero(rho3-b.Ser(calc.bf['rho3'])+an5,5,60,'negative marked third source sign')
    fa1=b.Ser(calc.bf['affine'])-calc.evaluate(aff1,m=125)
    fo1=b.Ser(calc.bf['formal'])-calc.evaluate(bound1,formal=True,m=125).shift(-2)
    assert fo1.valuation>=0
    en.zero(rho3-fa1-b.Z**2*fo1,5,60,'whole first regular repair')
    B2U,B2O=en.connections2()
    GU=en.corrected(IU,-fa1,en.gi,B2U,outmod=625)
    GO=en.corrected(IO,fo1,b.Z**2*en.gi,B2O,outmod=625)
    en.first_jet_check(ov,G3,GU,GO)
    en.horizontal_check(ov,G3,B2U,B2O,25)
    log('whole first repaired tuple PASS')

    def potential(I,di,B):
        I=en.mmod(I,25);B=en.mmod(B,25);di=di.mod(25)
        c=[I[i][0] for i in range(2)];h=[I[i][1] for i in range(2)]
        cc=en.covariant(c,di,B)
        value=(-en.mu*(c[0]*cc[1]-c[1]*cc[0])).mod(25)
        hh=en.covariant(h,di,B)
        for i in range(2):
            en.zero(hh[i]+c[i],25,30,'actual preceding oper upper entry')
            en.zero(cc[i]+value*h[i],25,30,'actual preceding oper potential')
        return value

    # Save the PRECEDING potential before the new second graph. It includes
    # the moving first repair; its canonical base specialization is not enough.
    P2U=potential(GU,en.gi,B2U)
    P2O=potential(GO,b.Z**2*en.gi,B2O)
    en.zero(P2U-en.R,5,40,'preceding potential residue')
    en.zero(P2O-(b.Z**4*en.R-b.Z**3*en.D(en.gi)),5,40,'formal preceding residue')

    def normal_coordinates(normal):
        result=[[0]*125 for _ in range(6)]
        for we,vec in normal.items():
            e=tuple(4-x for x in we);idx=pr.MONIDX[e]
            factor=math.prod(math.factorial(4)//math.factorial(4-x) for x in e)%5
            for j,c in enumerate(vec):result[j][idx]=pr.MUL[c][pr.INV[factor]]
        return result

    def solve_primary(normal):
        rhs=normal_coordinates(normal)
        scalar=sh.sum_poly([sh.pmul(a,x) for a,x in zip(data['ell'],rhs)])
        assert not any(ch.quotient(scalar,data)),'fourth class is not admissible'
        columns=[]
        for i in range(125):
            mon=[0]*125;mon[i]=1;columns.append(sh.pmul(data['f'],mon))
        rows=[list(r)+[scalar[i]] for i,r in enumerate(zip(*columns))]
        reduced,pivots=sh.rref(rows,125)
        assert len(pivots)==82 and all(not r[-1] for r in reduced[len(pivots):])
        x0=[0]*125
        for i,p in enumerate(pivots):x0[p]=reduced[i][-1]
        M=data['M'];BC=[[M[i][j][0] for j in range(1,6)] for i in range(1,6)]
        inv=sh.matinv(BC)
        x=[x0]+[[0]*125 for _ in range(5)]
        for idx,e in enumerate(pr.MONS):
            rr=[]
            for i in range(1,6):
                value=pr.ADD[rhs[i][idx]][pr.NEG[sh.pmul(M[i][0],x0)[idx]]]
                for j in range(1,6):
                    for mi,ai in sh.RP[idx]:
                        if mi:value=pr.ADD[value][pr.NEG[pr.MUL[M[i][j][mi]][x[j][ai]]]]
                rr.append(value)
            sol=sh.mv(inv,rr)
            for j in range(1,6):x[j][idx]=sol[j-1]
        for i in range(6):
            assert sh.sum_poly([sh.pmul(M[i][j],x[j]) for j in range(6)])==rhs[i]
        poly={}
        for j,v in enumerate(x):
            for idx,c in enumerate(v):
                if not c:continue
                e=pr.MONS[idx];we=tuple(4-a for a in e)
                factor=math.prod(math.factorial(4)//math.factorial(4-a) for a in e)%5
                coefficient=pr.MUL[pr.MUL[pw(c,25)][pow(3,3*e[0]+e[2],5)]][factor]
                term=poly.setdefault(we,{})
                term[pr.NM[j]]=pr.ADD[term.get(pr.NM[j],0)][coefficient]
        poly={e:{k:v for k,v in p.items() if v} for e,p in poly.items() if any(p.values())}
        assert even_jmath(poly),'chosen full primary preimage must preserve the fixed involution'
        return x,poly

    def whole_split(value,cut=150):
        coeffs=to_affine_coordinates(interpolate(value,cut),calc)
        powers=[[(x**j).mod(5) for j in range(5)] for x in [-c for c in calc.chi]]
        shifts={e:(powers[0][e[0]]*powers[1][e[1]]*powers[2][e[2]]).mod(5) for e in pr.MONS}
        normal={};aff={};minimum=min(v.prec for v in coeffs.values())
        for e in reversed(pr.MONS):
            if coeffs[e].iszero():continue
            vec,bound,records=split_base(coeffs[e],e[0]%2,calc)
            minimum=min(minimum,bound.prec)
            if any(vec):normal[e]=vec
            if records:aff[e]={(c,h):a for c,h,a in records}
            if bound.iszero():continue
            for f in itertools.product(*(range(a+1) for a in e)):
                if f==e:continue
                shift=tuple(e[i]-f[i] for i in range(3))
                factor=math.prod(math.comb(e[i],f[i]) for i in range(3))%5
                coeffs[f]=(coeffs[f]-bound*shifts[shift]*factor).mod(5)
        assert minimum>=2 and even_jmath(aff)
        assert all(h>=0 for p in aff.values() for (c,h) in p)
        return normal,aff,minimum

    rho4,G4=en.comparison(ov,GU,GO,en.R,125,25)
    E4,N4,projection4=project(rho4,calc)
    assert not any(E4),'actual fixed line fourth comparison'
    x4,n4=solve_primary(N4)
    log('full fourth primary preimage PASS',sum(map(len,n4.values())),'terms')
    n4v=calc.evaluate(n4,m=25)
    en.ell=en.ell-25*n4v
    ov=en.overlap()
    repaired4,G4=en.comparison(ov,GU,GO,en.R,125,25)
    en.zero(repaired4-rho4+b.Ser(w.peval(calc.o['AP'],calc.u))*n4v.frob(),5,60,'actual fourth source response')
    normal4,aff2,min4=whole_split(repaired4)
    assert not normal4,'whole fourth normal after source repair'
    fa2=calc.evaluate(aff2,m=25)
    # Its definition is the WHOLE repaired cochain minus the actual affine
    # polynomial, divided by z^2. The finite normal algorithm determines only
    # the affine polynomial, not the higher coefficients of this quotient.
    fo2=((repaired4-fa2).mod(5)).shift(-2)
    assert fo2.valuation>=0 and fo2.prec>=60
    en.zero(repaired4-fa2-b.Z**2*fo2,5,60,'whole second regular repair')
    log('whole fourth normal and genuine second primitive PASS',min4)
    zu=b.Ser(calc.o['zeta']);zo=b.Z**4*(en.g/b.Z**2).frob()
    phiP2=(P2U.frob()+(en.fuz-b.Z**5)*P2U.deriv().frob()).mod(25)
    BU=[[b.Ser(0),-zu],[-25*phiP2*zu,b.Ser(0)]]
    BO=[[b.Ser(0),-zo],[-25*P2O.frob()*zo,b.Ser(0)]]
    en.horizontal_check(ov,G4,BU,BO,125)
    GU2=en.corrected(GU,-fa2,en.gi,BU,weight=25,outmod=625)
    GO2=en.corrected(GO,fo2,b.Z**2*en.gi,BO,weight=25,outmod=625)
    comp=en.mm(en.mm(en.mi(GO2,125),G4,125),[[en.tau(x,125) for x in row] for row in GU2],125)
    for i in range(2):
        for j in range(2):en.zero(comp[i][j]-ov['J'][i][j],125,30,f'complete corrected second jet {i}{j}')
    log('complete repaired fourth tuple PASS')
    result={'status':'whole fourth repaired; fifth not yet evaluated','lambda_code':args.lambda_code,
            'source_modulus':3125,'flat_modulus':625,'workspace':args.precision,
            'frobenius_variant':args.frobenius_variant,'infinity_branch':args.branch,
            'H':H,'primary_source4_coordinates':x4,'source4':ch.records(n4),
            'second_affine':ch.records(aff2),'second_formal_definition':'(whole repaired rho4 - actual affine polynomial)/z^2, then the regular coefficient section; other branch by jmath transport',
            'source4_response_checked':True,'normal4_zero':True,'second_primitive_precision':fo2.prec,
            'normal4_projection_minimum_precision':min4,'projection4':projection4,'checks':en.checks}
    tag=f'lambda{args.lambda_code}_N{args.precision}_v{args.frobenius_variant}_b{args.branch}'
    with open(args.output_dir/(tag+'_fourth_objects.pkl'),'wb') as f:
        pickle.dump({'GU2':GU2,'GO2':GO2,'P2U':P2U,'P2O':P2O,'source4':n4,'fa2':fa2,'fo2':fo2,'rho4_repaired':repaired4},f)
    if not args.stop_after_fourth:
        rho5,G5=en.comparison(ov,GU2,GO2,P2U,625,125)
        en.horizontal_check(ov,G5,BU,BO,625)
        log('whole fifth numerator divided and horizontality PASS',rho5)
        E5,normal5,projection5=project(rho5,calc)
        raw=to_affine_coordinates(interpolate(rho5,150),calc)
        b344,_,_=split_base(raw[(3,4,4)],True,calc)
        b444,_,_=split_base(raw[(4,4,4)],False,calc)
        trace=pr.NEG[b344[0]]
        for code,j in [(85,1),(85,2),(48,3)]:trace=pr.ADD[trace][pr.MUL[code][b444[j]]]
        assert trace==E5[pr.MONIDX[(1,0,0)]],'independent two-trace normalization'
        result.update(status='executed experimental whole fifth comparison; requires independent audit',
                      fifth_scalar=trace,E5=E5,projection5=projection5,rho5_precision=rho5.prec,
                      independent_two_trace_equal=True)
        with open(args.output_dir/(tag+'_fifth_cochain.pkl'),'wb') as f:pickle.dump(rho5,f)
        log('actual fifth E100',trace)
    result['source_sha256']={p.name:hashlib.sha256(p.read_bytes()).hexdigest()
                             for p in [Path(__file__)]+sorted(args.engine_dir.glob('*.py'))+sorted(args.engine_dir.glob('*.cpp'))}
    result['seconds']=time.monotonic()-started
    (args.output_dir/(tag+'.json')).write_text(json.dumps(result,indent=2)+'\n')
    log(result['status'])


if __name__=='__main__':main()
