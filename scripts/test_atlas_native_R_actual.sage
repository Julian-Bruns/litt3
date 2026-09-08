#!/usr/bin/env sage
"""Replay retained actual atlas R blocks with the complete native checker."""
import argparse,json,time
from pathlib import Path
from atlas_factored_R_witness import FactoredRWitness
from atlas_native_R_checks import NativeRChecks,sha

ap=argparse.ArgumentParser();ap.add_argument('--folder',type=Path,required=True)
ap.add_argument('--directions',type=int,nargs='+',default=list(range(32)));args=ap.parse_args()
started=time.monotonic();folder=args.folder;data=load(str(folder/'oper.sobj'))
S,B,I,D,power,pivots,inverse=load(str(folder/'coordinates.sobj'))
engine=FactoredRWitness(data,B,I)
H=engine.flatten(load(str(folder/'coupled_R_certificate.sobj')))
rep=json.loads((folder/'builder.json').read_text())['rep']
output=Path(__file__).resolve().parents[2]/'litt3-computation-data/orbit11-structure'/('native-R-actual-'+rep)
output.mkdir(parents=True,exist_ok=True)
checker=NativeRChecks(H,engine.Bc,engine.Iproj,output);records=[]
for i in args.directions:
    path=folder/('direction_%02d.sobj'%i)
    record=checker.check_bound(path,int(i),sha(path));assert record['valid']
    record.update(direction=int(i),original_direction_sha256=sha(path));records.append(record)
report=dict(all_passed=True,field_degree_F5=engine.bridge.degree,records=records,
            original_R_rows=56,all_retained_compact_projection_identities_verified=True,
            original_coupled_witness_sha256=sha(folder/'coupled_R_certificate.sobj'),
            seconds=time.monotonic()-started)
temporary=output/'report.tmp.json';temporary.write_text(json.dumps(report,indent=2,default=int)+'\n')
temporary.replace(output/'report.json');print(json.dumps(report,default=int),flush=True)
