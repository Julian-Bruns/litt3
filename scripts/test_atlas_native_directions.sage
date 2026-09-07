#!/usr/bin/env sage
"""Compare complete native N, compactR and original56-rowR blocks exactly."""
import argparse,json,time
from pathlib import Path
from atlas_native_directions import NativeDirections

ap=argparse.ArgumentParser();ap.add_argument('--rep',required=True)
ap.add_argument('--directions',type=int,nargs='+',default=[0])
ap.add_argument('--coupled',action='store_true');args=ap.parse_args()
root=Path(__file__).resolve().parents[1]
folder=root.parent/'litt3-computation-data/atlas-all18'/args.rep/'tensor'
start=time.monotonic();data=load(str(folder/'oper.sobj'))
KU,K40,Qc,h0V=load(str(folder/'polynomial.sobj'))
S,Bc,Iproj,D,power,piv5,inverse5=load(str(folder/'coordinates.sobj'))
LS,t,expansions,dt=load(str(folder/'local.sobj'))
if (folder/'curve_coordinates.sobj').exists():
    curveS,curveD,curvepower,curvepiv5,curveinverse5=load(str(folder/'curve_coordinates.sobj'))
else:
    assert power.base_ring()==LS.base_ring() and inverse5.base_ring()==LS.base_ring()
    curvepower,curvepiv5,curveinverse5=power,piv5,inverse5
def basis(n): return sorted([(i,j) for j in range(3) for i in range(n//3+1)
                            if 3*i+10*j<=n],key=lambda m:3*m[0]+10*m[1])
engine=NativeDirections(data,KU,K40,Qc,Bc,Iproj,D,curvepower,piv5,curveinverse5,
                        expansions,basis(112),basis(192),basis(320))
setup=time.monotonic()-start;results=[]
for i in args.directions:
    begin=time.monotonic();actual=engine.direction(i);old=load(str(folder/('direction_%02d.sobj'%i)))
    assert actual==old
    result=dict(direction=i,all_N_compact_R_and_raw_R_entries_identical=True,
                seconds=time.monotonic()-begin)
    print(json.dumps(result),flush=True);results.append(result)
if args.coupled:
    all_blocks=[load(str(folder/('direction_%02d.sobj'%i))) for i in range(32)]
    witness=engine.coupled_R_certificate(all_blocks,Bc)
    witness_path=root.parent/'litt3-computation-data/orbit11-structure'/('coupled_R_witness_'+args.rep+'.sobj')
    save(witness,str(witness_path))
report=dict(rep=args.rep,degree_F5=engine.native.degree,setup_seconds=setup,
    results=results,total_seconds=time.monotonic()-start)
out=root.parent/'litt3-computation-data/orbit11-structure'/('native_directions_'+args.rep+'.json')
out.write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
