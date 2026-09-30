#!/usr/bin/env python3
"""Experimental whole sixth comparison above Vstar+tau*nu39.

Rebuilds a compatible fifth origin using full primary solves and whole
regular primitives, extracts its GENUINE preceding P3, and compares at
source15625/flat3125. The relative sixth quotient is a proved input;
no absolute sixth value is an input. Every generated object is external.
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


def snapshot_engine(original, output):
    here=Path(__file__).resolve().parent
    names=['field.py','primary.py','schur.py','cover_char5.py',
           'normal_projection.py','rank125_fourth.py','build_exact.py',
           'neutral5_gmp_convolution.py','exact_batch_conv.cpp',
           'primary.pkl','schur.pkl']
    sources={name:original/name for name in names}
    sources.update({'witt_cubic.py':here/'sixth_witt_cubic.py',
                    'batch_witt.py':here/'sixth_batch_witt.py',
                    'reconstruct_base_reference.py':here/'sixth_base_reference.py',
                    'fourth_engine.py':here/'higher_hodge_engine.py'})
    hashes={name:hashlib.sha256(p.read_bytes()).hexdigest() for name,p in sources.items()}
    digest=hashlib.sha256(json.dumps(hashes,sort_keys=True).encode()).hexdigest()
    target=output/('engine_'+digest[:16]);target.mkdir(exist_ok=True)
    for name,p in sources.items():
        dest=target/name
        if dest.exists():assert dest.read_bytes()==p.read_bytes(),dest
        else:dest.write_bytes(p.read_bytes())
    manifest={'bundle_sha256':digest,'files':{
        name:{'source':str(p.resolve()),'sha256':hashes[name]} for name,p in sources.items()}}
    (target/'source_manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
    return target,manifest


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--engine-dir',type=Path,required=True)
    ap.add_argument('--output-dir',type=Path,required=True)
    ap.add_argument('--prior-fifth-receipt',type=Path,required=True)
    ap.add_argument('--precision',type=int,default=4800)
    ap.add_argument('--tau-code',type=int,choices=range(125),default=0)
    ap.add_argument('--frobenius-variant',type=int,choices=(0,1),default=0)
    ap.add_argument('--branch',type=int,choices=(-1,1),default=1)
    ap.add_argument('--stop-after',choices=('fourth','fifth','sixth'),default='sixth')
    ap.add_argument('--first-prefix',type=Path,help='Previously checked first tuple, with its original source manifest')
    args=ap.parse_args();root=Path(__file__).resolve().parents[3]
    assert not args.output_dir.resolve().is_relative_to(root)
    args.output_dir.mkdir(parents=True,exist_ok=True)
    engine,manifest=snapshot_engine(args.engine_dir.resolve(),args.output_dir.resolve())
    os.environ['LITT3_REFERENCE_MODULUS']='15625'
    os.environ['LITT3_REFERENCE_PRECISION']=str(args.precision)
    sys.path.insert(0,str(engine))
    from build_exact import build
    native_library=build()
    import numpy as np
    import witt_cubic as w,batch_witt as b,primary as pr,schur as sh,cover_char5 as ch
    from field import pw
    from rank125_fourth import Calculation
    from fourth_engine import Engine
    from normal_projection import interpolate,to_affine_coordinates,split_base,project

    started=time.monotonic()
    def log(*x):print(*x,'seconds',round(time.monotonic()-started,2),flush=True)
    tag=f'tau{args.tau_code}_N{args.precision}_v{args.frobenius_variant}_b{args.branch}'
    result={'status':'running','tau_code':args.tau_code,'source_modulus':15625,
            'flat_modulus':3125,'workspace':args.precision,
            'frobenius_variant':args.frobenius_variant,'branch':args.branch,
            'source_manifest':manifest,
            'driver_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            'prior_fifth_receipt_sha256':hashlib.sha256(args.prior_fifth_receipt.read_bytes()).hexdigest(),
            'native_binary_sha256':hashlib.sha256(Path(native_library).read_bytes()).hexdigest(),
            'native_threads':os.environ.get('OMP_NUM_THREADS','runtime_default')}
    driver_snapshot=args.output_dir/('driver_'+result['driver_sha256']+'.py')
    if driver_snapshot.exists():assert driver_snapshot.read_bytes()==Path(__file__).read_bytes()
    else:driver_snapshot.write_bytes(Path(__file__).read_bytes())
    result['driver_snapshot']=str(driver_snapshot.resolve())
    def save(stage,objects=None):
        result['status']=stage;result['seconds']=time.monotonic()-started
        result['checks']=en.checks
        if objects is not None:
            object_path=args.output_dir/(tag+'_'+stage.replace(' ','_')+'.pkl')
            with object_path.open('wb') as f:
                pickle.dump(objects,f)
            result.setdefault('object_artifacts',{})[stage]={
                'path':str(object_path.resolve()),
                'sha256':hashlib.sha256(object_path.read_bytes()).hexdigest()}
        (args.output_dir/(tag+'.json')).write_text(json.dumps(result,indent=2)+'\n')
    calc=Calculation(args.frobenius_variant,args.branch);data=calc.data
    assert list(map(int,w.SIGT))==[15371,571,15244]
    for m in (125,625):
        for i in range(3):
            a=pow(pow((3,1,2)[i],-1,5),3125,15625)
            error=(calc.W[i]**5-a*calc.W[i]-b.Ser(a*calc.FU[i])).mod(m)
            calc.W[i]=(calc.W[i]+b.Ser(w.ci(a))*error).mod(m)
            check=(calc.W[i]**5-a*calc.W[i]-b.Ser(a*calc.FU[i])).mod(m).cut(60)
            assert check.prec>=60 and check.iszero(),('actual affine root',m,i,check)
    calc.Wpowers.clear()
    H=[0]*125
    for i,c in {1:101,2:14,11:122,12:93,15:117,16:115,27:83,30:74,31:58,39:8}.items():
        H=sh.padd(H,sh.pscale(data['nus'][i],c))
    V=[0]*125
    for i,c in {1:93,2:39,11:82,12:83,15:90,16:57,27:10,30:119,31:28,39:args.tau_code}.items():
        V=sh.padd(V,sh.pscale(data['nus'][i],c))
    nH,_,aff1,bound1=ch.primary_repair(H,data)
    nV,_,_,_=ch.primary_repair(V,data)
    def parities(poly):
        assert all((int(bool(c&1))+int(bool(c&2))+e[0])%2==0
                   for e,p in poly.items() for c,h in p),'jmath parity'
        assert all((int(bool(c&2))+sum(e))%2==1
                   for e,p in poly.items() for c,h in p),'first tame parity'
    parities(nH);parities(nV)
    first_path=args.output_dir/f'first_N{args.precision}_v{args.frobenius_variant}_b{args.branch}_{result["driver_sha256"][:12]}.pkl'
    if args.first_prefix is not None:
        first_path=args.first_prefix
        assert first_path.name.startswith(f'first_N{args.precision}_v{args.frobenius_variant}_b{args.branch}_')
    first_saved=None
    if first_path.exists():
        with first_path.open('rb') as f:first_saved=pickle.load(f)
        assert first_saved['H']==H
        old_files=first_saved['source_manifest']['files'];new_files=manifest['files']
        assert set(old_files)==set(new_files)
        changed={k for k in old_files if old_files[k]['sha256']!=new_files[k]['sha256']}
        assert changed<=({'fourth_engine.py'} if args.first_prefix else set())
        result['first_prefix_original_manifest']=first_saved['source_manifest']
        nv=first_saved['nv']
        log('hash-bound common first prefix loaded')
    else:
        log('actual affine roots625 and primary source polynomials PASS')
        nv=calc.evaluate(nH,m=625)
        log('third source evaluated')
    en=Engine(b.Ser,calc.o,nv)
    AP=b.Ser(w.peval(calc.o['AP'],calc.u))

    def solve_primary(normal):
        rhs=[[0]*125 for _ in range(6)]
        for we,vec in normal.items():
            e=tuple(4-x for x in we);idx=pr.MONIDX[e]
            fac=math.prod(math.factorial(4)//math.factorial(4-x) for x in e)%5
            for j,c in enumerate(vec):rhs[j][idx]=pr.MUL[c][pr.INV[fac]]
        scalar=sh.sum_poly([sh.pmul(a,x) for a,x in zip(data['ell'],rhs)])
        assert not any(ch.quotient(scalar,data)),'full target has nonzero scalar class'
        columns=[]
        for i in range(125):
            mon=[0]*125;mon[i]=1;columns.append(sh.pmul(data['f'],mon))
        rr,pv=sh.rref([list(r)+[scalar[i]] for i,r in enumerate(zip(*columns))],125)
        assert len(pv)==82 and all(not r[-1] for r in rr[len(pv):])
        x0=[0]*125
        for i,p in enumerate(pv):x0[p]=rr[i][-1]
        M=data['M'];inv=sh.matinv([[M[i][j][0] for j in range(1,6)] for i in range(1,6)])
        x=[x0]+[[0]*125 for _ in range(5)]
        for idx,e in enumerate(pr.MONS):
            rem=[]
            for i in range(1,6):
                value=pr.ADD[rhs[i][idx]][pr.NEG[sh.pmul(M[i][0],x0)[idx]]]
                for j in range(1,6):
                    for mi,ai in sh.RP[idx]:
                        if mi:value=pr.ADD[value][pr.NEG[pr.MUL[M[i][j][mi]][x[j][ai]]]]
                rem.append(value)
            sol=sh.mv(inv,rem)
            for j in range(1,6):x[j][idx]=sol[j-1]
        for i in range(6):assert sh.sum_poly([sh.pmul(M[i][j],x[j]) for j in range(6)])==rhs[i]
        poly={}
        for j,row in enumerate(x):
            for idx,c in enumerate(row):
                if not c:continue
                e=pr.MONS[idx];we=tuple(4-a for a in e)
                fac=math.prod(math.factorial(4)//math.factorial(4-a) for a in e)%5
                coef=pr.MUL[pr.MUL[pw(c,25)][pow(3,3*e[0]+e[2],5)]][fac]
                term=poly.setdefault(we,{})
                term[pr.NM[j]]=pr.ADD[term.get(pr.NM[j],0)][coef]
        poly={e:{k:v for k,v in p.items() if v} for e,p in poly.items() if any(p.values())}
        parities(poly)
        return x,poly

    def whole_split(value):
        coeffs=to_affine_coordinates(interpolate(value,150),calc)
        powers=[[(x**j).mod(5) for j in range(5)] for x in [-c for c in calc.chi]]
        shifts={e:(powers[0][e[0]]*powers[1][e[1]]*powers[2][e[2]]).mod(5) for e in pr.MONS}
        aff={};minimum=min(v.prec for v in coeffs.values())
        for e in reversed(pr.MONS):
            if coeffs[e].iszero():continue
            vec,bound,records=split_base(coeffs[e],e[0]%2,calc)
            minimum=min(minimum,bound.prec);assert not any(vec),'unrepaired whole normal'
            if records:aff[e]={(c,h):a for c,h,a in records}
            if bound.iszero():continue
            for f in itertools.product(*(range(a+1) for a in e)):
                if f==e:continue
                shift=tuple(e[i]-f[i] for i in range(3))
                fac=math.prod(math.comb(e[i],f[i]) for i in range(3))%5
                coeffs[f]=(coeffs[f]-bound*shifts[shift]*fac).mod(5)
        assert minimum>=2;parities(aff)
        assert all(h>=0 for p in aff.values() for c,h in p)
        return aff,minimum

    if first_saved is None:
        IU=[[b.Ser(x) for x in row] for row in calc.bf['IU']]
        IO=[[b.Ser(x) for x in row] for row in calc.bf['IO']]
        ov=en.overlap()
        log('whole source overlap PASS')
        rho3,G3=en.comparison(ov,IU,IO,b.Ser(0),25,5)
        en.zero(rho3-b.Ser(calc.bf['rho3'])+AP*calc.evaluate(nH,m=5).frob(),5,60,'third source sign')
        fa1=b.Ser(calc.bf['affine'])-calc.evaluate(aff1,m=625)
        fo1=b.Ser(calc.bf['formal'])-calc.evaluate(bound1,formal=True,m=625).shift(-2)
        assert fo1.valuation>=0
        log('both whole first repairs evaluated')
        en.zero(rho3-fa1-b.Z**2*fo1,5,60,'whole first repair')
        B2U,B2O=en.connections2()
        GU1=en.corrected(IU,-fa1,en.gi,B2U,outmod=3125)
        log('first affine normalization PASS')
        GO1=en.corrected(IO,fo1,b.Z**2*en.gi,B2O,outmod=3125)
        en.first_jet_check(ov,G3,GU1,GO1);en.horizontal_check(ov,G3,B2U,B2O,25)
        P2U=en.potential(GU1,en.gi,B2U,125)
        P2O=en.potential(GO1,b.Z**2*en.gi,B2O,125)
        log('first tuple and integral P2 lifts PASS')

        with first_path.open('wb') as f:
            pickle.dump({'source_manifest':manifest,'H':H,'nv':nv,'GU1':GU1,'GO1':GO1,
                         'P2U':P2U,'P2O':P2O,'checks':en.checks},f)
    else:
        GU1,GO1,P2U,P2O=(first_saved[k] for k in ('GU1','GO1','P2U','P2O'))
        en.checks.extend(first_saved['checks'])
        ov=en.overlap()
        IU=[[b.Ser(x) for x in row] for row in calc.bf['IU']]
        IO=[[b.Ser(x) for x in row] for row in calc.bf['IO']]
        _,G3=en.comparison(ov,IU,IO,b.Ser(0),25,5)
        en.first_jet_check(ov,G3,GU1,GO1)
        B2U,B2O=en.connections2();en.horizontal_check(ov,G3,B2U,B2O,25)
        for I in (GU1,GO1):
            en.zero(I[0][0]*I[1][1]-I[0][1]*I[1][0]-1,3125,30,'loaded first determinant')
            en.frame_certificates[id(I)]=(I,3125)
        log('common first tuple rechecked under current engine')
    result['first_prefix_cache']={'path':str(first_path.resolve()),
                                'sha256':hashlib.sha256(first_path.read_bytes()).hexdigest()}

    rho4,G4=en.comparison(ov,GU1,GO1,en.R,125,25)
    E4,N4,proj4=project(rho4,calc);assert not any(E4)
    log('complete fourth scalar zero')
    x4,n4default=solve_primary(N4)
    prior=json.loads(args.prior_fifth_receipt.read_text())
    assert prior['lambda_code']==8
    assert ch.records(n4default)==prior['source4'],'default fourth marking changed'
    log('full primary and prescribed fourth marking PASS')
    n4=ch.add(n4default,nV);parities(n4)
    # Any difference from adding the integral sections separately is an
    # allowed fifth-origin change; the complete fifth solve below is retained.
    n4v=calc.evaluate(n4,m=125);en.ell-=25*n4v
    ov=en.overlap()
    repaired4,G4=en.comparison(ov,GU1,GO1,en.R,125,25)
    en.zero(repaired4-rho4+AP*n4v.frob(),5,60,'complete fourth source response')
    aff2,min4=whole_split(repaired4)
    fa2=calc.evaluate(aff2,m=125)
    fo2=((repaired4-fa2).mod(5)).shift(-2)
    assert fo2.valuation>=0 and fo2.prec>=60
    en.zero(repaired4-fa2-b.Z**2*fo2,5,60,'whole second repair')
    log('whole second regular repairs evaluated')
    B4U,B4O=en.connections(P2U,P2O,3125)
    en.horizontal_check(ov,G4,B4U,B4O,125)
    GU2=en.corrected_connection(GU1,-fa2,en.gi,B2U,B4U,P2U,weight=25,outmod=3125)
    GO2=en.corrected_connection(GO1,fo2,b.Z**2*en.gi,B2O,B4O,P2O,weight=25,outmod=3125)
    en.jet_check(ov,G4,GU2,GO2,125,'complete fourth jet')
    P3U=en.potential(GU2,en.gi,B4U,125)
    P3O=en.potential(GO2,b.Z**2*en.gi,B4O,125)
    en.zero(P3U-P2U,25,30,'preceding affine truncation')
    en.zero(P3O-P2O,25,30,'preceding formal truncation')
    log('whole fourth tuple and genuine P3 modulo125 PASS')
    result.update(H=H,fourth_translation=V,source4_default=ch.records(n4default),
                  source4=ch.records(n4),primary_source4_coordinates=x4,
                  second_affine=ch.records(aff2),second_formal_precision=fo2.prec,
                  projection4=proj4,minimum_normal4_precision=min4,
                  P3_precision_U=P3U.prec,P3_precision_O=P3O.prec,checks=en.checks)
    save('fourth_complete',{'P3U':P3U,'P3O':P3O,'P2U':P2U,'P2O':P2O,
                          'GU2':GU2,'GO2':GO2,'ell':en.ell,'fa2':fa2,'fo2':fo2})
    if args.stop_after=='fourth':return

    rho5,G5=en.comparison(ov,GU2,GO2,P2U.mod(25),625,125)
    en.horizontal_check(ov,G5,B4U,B4O,625)
    E5,N5,proj5=project(rho5,calc);assert not any(E5),'known fifth-admissible line failed'
    x5,n5=solve_primary(N5)
    n5v=calc.evaluate(n5,m=25);en.ell-=125*n5v
    ov=en.overlap()
    repaired5,G5=en.comparison(ov,GU2,GO2,P2U.mod(25),625,125)
    en.zero(repaired5-rho5+AP*n5v.frob(),5,60,'complete fifth source response')
    en.horizontal_check(ov,G5,B4U,B4O,625)
    aff3,min5=whole_split(repaired5)
    fa3=calc.evaluate(aff3,m=25)
    fo3=((repaired5-fa3).mod(5)).shift(-2)
    assert fo3.valuation>=0 and fo3.prec>=60
    en.zero(repaired5-fa3-b.Z**2*fo3,5,60,'whole third repair')
    GU3=en.graph(GU2,-fa3,en.gi,P3U,125,3125)
    GO3=en.graph(GO2,fo3,b.Z**2*en.gi,P3O,125,3125)
    en.jet_check(ov,G5,GU3,GO3,625,'complete fifth jet')
    log('complete fifth tuple at the prescribed fourth point PASS')
    result.update(E5=E5,projection5=proj5,primary_source5_coordinates=x5,
                  source5=ch.records(n5),third_affine=ch.records(aff3),
                  third_formal_precision=fo3.prec,minimum_normal5_precision=min5,
                  rho5_precision=rho5.prec,checks=en.checks)
    save('fifth_complete',{'P3U':P3U,'P3O':P3O,'GU3':GU3,'GO3':GO3,
                         'ell':en.ell,'fa3':fa3,'fo3':fo3,'source5':n5})
    if args.stop_after=='fifth':return

    B6U,B6O=en.connections(P3U,P3O,3125)
    for i in range(2):
        for j in range(2):
            en.zero(B6U[i][j]-B4U[i][j],625,30,'sixth affine connection truncation')
            en.zero(B6O[i][j]-B4O[i][j],625,30,'sixth formal connection truncation')
    # Lift the SAME fifth Hodge lines into the actual sixth connection.
    # Only a weight625 determinant/first-column adjustment is needed.
    GU=en.corrected_connection(GU3,b.Ser(0),en.gi,B4U,B6U,P3U,weight=625,outmod=3125)
    GO=en.corrected_connection(GO3,b.Ser(0),b.Z**2*en.gi,B4O,B6O,P3O,weight=625,outmod=3125)
    rho6,G6=en.comparison(ov,GU,GO,P3U,3125,625)
    en.jet_check(ov,G6,GU,GO,625,'sixth comparison retains whole fifth prefix')
    en.horizontal_check(ov,G6,B6U,B6O,3125)
    log('whole sixth numerator divided and all horizontality entries PASS',rho6)
    E6,N6,proj6=project(rho6,calc)
    raw=to_affine_coordinates(interpolate(rho6,150),calc)
    b344,_,_=split_base(raw[(3,4,4)],True,calc)
    b444,_,_=split_base(raw[(4,4,4)],False,calc)
    trace=pr.NEG[b344[0]]
    for code,j in [(85,1),(85,2),(48,3)]:trace=pr.ADD[trace][pr.MUL[code][b444[j]]]
    assert trace==E6[pr.MONIDX[(1,0,0)]]
    allowed={(1,0,0),(1,1,1),(1,2,0),(3,0,0),(1,3,1),(1,4,0),
             (3,1,1),(3,2,0),(3,3,1),(3,4,0)}
    assert all(not c or e in allowed for e,c in zip(pr.MONS,E6)),'sixth tame quotient parity'
    result.update(E6=E6,normal6={str(e):v for e,v in N6.items()},projection6=proj6,
                  sixth_scalar=trace,rho6_precision=rho6.prec,two_trace_equal=True,
                  checks=en.checks)
    save('sixth_comparison_executed_requires_audit',{'rho6':rho6,'P3U':P3U,'P3O':P3O,
                                                  'GU':GU,'GO':GO,'ell':en.ell})
    log('actual sixth E100 candidate',trace)


if __name__=='__main__':main()
