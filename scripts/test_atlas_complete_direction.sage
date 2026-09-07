#!/usr/bin/env sage
"""Exact complete C++ direction vs immutable original-coordinate checkpoints."""
import argparse,hashlib,json,time
from pathlib import Path
from sage.env import SAGE_VERSION
from atlas_complete_directions import CompleteNativeDirections
from atlas_resources import resident_rss,release_scratch

ap=argparse.ArgumentParser();ap.add_argument('--rep',required=True)
ap.add_argument('--folder',help='Explicit immutable predecessor cache for regression')
ap.add_argument('--directions',type=int,nargs='+',default=[0]);args=ap.parse_args()
root=Path(__file__).resolve().parents[1]
folder=Path(args.folder) if args.folder else root.parent/'litt3-computation-data/atlas-all18'/args.rep/'tensor'
output=root.parent/'litt3-computation-data/orbit11-structure'/('complete_native_'+args.rep)
output.mkdir(parents=True,exist_ok=True)
start=time.monotonic();data=load(str(folder/'oper.sobj'))
KU,K40,Qc,h0=load(str(folder/'polynomial.sobj'))
S,Bc,Iproj,D,power,pivots,inverse=load(str(folder/'coordinates.sobj'))
LS,t,expansions,dt=load(str(folder/'local.sobj'))
cs,cd,cp,pi,ci=load(str(folder/'curve_coordinates.sobj'))
def basis(n):return sorted([(i,j) for j in range(3) for i in range(n//3+1)
    if 3*i+10*j<=n],key=lambda m:3*m[0]+10*m[1])
engine=CompleteNativeDirections(data,KU,K40,Qc,Bc,Iproj,D,cp,pi,ci,expansions,
    basis(112),basis(192),basis(320),output)
KU=K40=Qc=S=Bc=Iproj=D=power=inverse=LS=t=expansions=dt=None
release_scratch();setup_rss=resident_rss();records=[]
for i in args.directions:
    old=folder/('direction_%02d.sobj'%i)
    if not old.exists() and args.rep=='orbit_0004' and i==0:
        old=root.parent/'litt3-computation-data/orbit11-structure/native_fresh_orbit_0004.sobj'
    digest=hashlib.sha256(old.read_bytes()).hexdigest()
    result=engine.direction(i)
    assert result==load(str(old)),(args.rep,i,'original block mismatch')
    assert hashlib.sha256(old.read_bytes()).hexdigest()==digest
    records.append(dict(direction=int(i),original_checkpoint=str(old),original_sha256=digest,
        all_N64_compact_R32_raw_R56_entries_equal=True,native=engine.last_record))
    result=None;release_scratch()
report=dict(rep=args.rep,sage_version=SAGE_VERSION,field_modulus=list(engine.bridge.modulus),
    setup=engine.setup,setup_resident_rss_bytes=setup_rss,final_resident_rss_bytes=resident_rss(),
    seconds=time.monotonic()-start,records=records,
    scope='Exact direction regression only; no atlas exclusion')
(output/'report.json').write_text(json.dumps(report,indent=2,default=int)+'\n')
print(json.dumps(report,default=int),flush=True)
