#!/usr/bin/env python3
"""Finish the whole sixth comparison from a saved, checked fifth tuple."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import pickle
import sys
import time

from compare_sixth_fixed_line import snapshot_engine


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--engine-dir',type=Path,required=True)
    ap.add_argument('--output-dir',type=Path,required=True)
    ap.add_argument('--fifth-receipt',type=Path,required=True)
    ap.add_argument('--fifth-prefix',type=Path,required=True)
    ap.add_argument('--input-binding',type=Path,help='Explicit same-run binding for an older receipt without an embedded pickle hash')
    args=ap.parse_args()
    assert not args.output_dir.resolve().is_relative_to(Path(__file__).resolve().parents[3])
    receipt=json.loads(args.fifth_receipt.read_text())
    assert receipt['source_modulus']==15625 and receipt['flat_modulus']==3125
    assert receipt['status']=='fifth_complete' and not any(receipt['E5'])
    assert args.fifth_prefix.name==args.fifth_receipt.stem+'_fifth_complete.pkl'
    prefix_hash=hashlib.sha256(args.fifth_prefix.read_bytes()).hexdigest()
    if 'fifth_complete' in receipt.get('object_artifacts',{}):
        bound=receipt['object_artifacts']['fifth_complete']
        assert Path(bound['path']).resolve()==args.fifth_prefix.resolve() and bound['sha256']==prefix_hash
    else:
        assert args.input_binding is not None,'saved fifth tuple requires its original input binding'
        binding=json.loads(args.input_binding.read_text())
        for name,path in (('fifth_receipt',args.fifth_receipt),('fifth_prefix',args.fifth_prefix)):
            item=binding['files'][name]
            assert Path(item['path']).resolve()==path.resolve()
            assert item['sha256']==hashlib.sha256(path.read_bytes()).hexdigest()
        assert binding['files']['generating_driver']['sha256']==receipt['driver_sha256']
    first_path=Path(receipt['first_prefix_cache']['path'])
    assert hashlib.sha256(first_path.read_bytes()).hexdigest()==receipt['first_prefix_cache']['sha256']
    engine,manifest=snapshot_engine(args.engine_dir.resolve(),args.output_dir.resolve())
    for name,old in receipt['source_manifest']['files'].items():
        if name!='fourth_engine.py':assert manifest['files'][name]['sha256']==old['sha256']
    os.environ['LITT3_REFERENCE_MODULUS']='15625'
    os.environ['LITT3_REFERENCE_PRECISION']=str(receipt['workspace'])
    sys.path.insert(0,str(engine))
    from build_exact import build
    library=build()
    import witt_cubic as w,batch_witt as b,cover_char5 as ch,primary as pr
    from rank125_fourth import Calculation
    from fourth_engine import Engine
    from normal_projection import project,interpolate,to_affine_coordinates,split_base

    started=time.monotonic()
    def log(*x):print(*x,'seconds',round(time.monotonic()-started,2),flush=True)
    with first_path.open('rb') as f:first=pickle.load(f)
    with args.fifth_prefix.open('rb') as f:previous=pickle.load(f)
    assert first['H']==receipt['H']
    assert ch.records(previous['source5'])==receipt['source5']
    calc=Calculation(receipt['frobenius_variant'],receipt['branch'])
    en=Engine(b.Ser,calc.o,first['nv']);en.ell=previous['ell']
    P2U,P2O=first['P2U'],first['P2O']
    P3U,P3O=previous['P3U'],previous['P3O']
    GU3,GO3=previous['GU3'],previous['GO3']
    for I,older in ((GU3,first['GU1']),(GO3,first['GO1'])):
        # Frozen generation used the exact weight25 connection/graph and
        # weight125 graph formulas. Therefore det(I)=1 and I=older mod25
        # as whole integral frames, including their unrecorded tails.
        en.frame_certificates[id(I)]=(I,3125)
        en.frame_ancestors[id(I)]=(I,older,25)
        en.zero(older[0][0]*older[1][1]-older[0][1]*older[1][0]-1,3125,30,'original normalized first frame')
    en.zero(P3U-P2U,25,30,'genuine preceding affine truncation')
    en.zero(P3O-P2O,25,30,'genuine preceding formal truncation')
    B4U,B4O=en.connections(P2U,P2O,3125)
    B6U,B6O=en.connections(P3U,P3O,3125)
    for i in range(2):
        for j in range(2):
            en.zero(B6U[i][j]-B4U[i][j],625,30,'actual affine connection truncation')
            en.zero(B6O[i][j]-B4O[i][j],625,30,'actual formal connection truncation')
    GU=en.corrected_connection(GU3,b.Ser(0),en.gi,B4U,B6U,P3U,625,3125)
    GO=en.corrected_connection(GO3,b.Ser(0),b.Z**2*en.gi,B4O,B6O,P3O,625,3125)
    log('exact final reframe PASS',[[x.prec for x in row] for row in GU],[[x.prec for x in row] for row in GO])
    ov=en.overlap()
    rho6,G6=en.comparison(ov,GU,GO,P3U,3125,625)
    log('whole sixth numerator divided',rho6)
    en.jet_check(ov,G6,GU,GO,625,'actual sixth comparison retains whole fifth prefix')
    en.horizontal_check(ov,G6,B6U,B6O,3125)
    E6,N6,proj6=project(rho6,calc)
    raw=to_affine_coordinates(interpolate(rho6,150),calc)
    b344,_,_=split_base(raw[(3,4,4)],True,calc)
    b444,_,_=split_base(raw[(4,4,4)],False,calc)
    trace=pr.NEG[b344[0]]
    for code,j in ((85,1),(85,2),(48,3)):trace=pr.ADD[trace][pr.MUL[code][b444[j]]]
    assert trace==E6[pr.MONIDX[(1,0,0)]]
    allowed={(1,0,0),(1,1,1),(1,2,0),(3,0,0),(1,3,1),(1,4,0),(3,1,1),(3,2,0),(3,3,1),(3,4,0)}
    assert all(not c or e in allowed for e,c in zip(pr.MONS,E6))
    sources={str(p.resolve()):hashlib.sha256(p.read_bytes()).hexdigest() for p in
             (Path(__file__),args.fifth_receipt,args.fifth_prefix,first_path,Path(library))}
    if args.input_binding:sources[str(args.input_binding.resolve())]=hashlib.sha256(args.input_binding.read_bytes()).hexdigest()
    result={'status':'executed_sixth_comparison_requires_independent_audit','tau_code':receipt['tau_code'],
            'source_modulus':15625,'flat_modulus':3125,'workspace':receipt['workspace'],
            'frobenius_variant':receipt['frobenius_variant'],'branch':receipt['branch'],
            'sixth_scalar':trace,'E6':E6,'normal6':{str(e):v for e,v in N6.items()},
            'projection6':proj6,'rho6_precision':rho6.prec,'two_trace_equal':True,
            'checks':en.checks,'source_manifest':manifest,'input_and_source_sha256':sources,
            'original_fifth_driver_sha256':receipt['driver_sha256'],'seconds':time.monotonic()-started}
    tag=args.fifth_receipt.stem+'_sixth'
    (args.output_dir/(tag+'.json')).write_text(json.dumps(result,indent=2)+'\n')
    with (args.output_dir/(tag+'.pkl')).open('wb') as f:
        pickle.dump({'rho6':rho6,'GU':GU,'GO':GO,'P3U':P3U,'P3O':P3O,'ell':en.ell},f)
    log('actual sixth E100 candidate',trace)


if __name__=='__main__':main()
