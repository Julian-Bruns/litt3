#!/usr/bin/env sage
"""Exact existing-block regression with explicit CAS scratch lifetime."""
import argparse,json,time
from pathlib import Path
from atlas_native_directions import NativeDirections
from atlas_resources import release_scratch,resident_rss

ap=argparse.ArgumentParser();ap.add_argument('--rep',required=True)
ap.add_argument('--direction',type=int,default=0);args=ap.parse_args()
root=Path(__file__).resolve().parents[1]
folder=root.parent/'litt3-computation-data/atlas-all18'/args.rep/'tensor'
start=time.monotonic();data=load(str(folder/'oper.sobj'))
KU,K40,Qc,h0V=load(str(folder/'polynomial.sobj'))
S,Bc,Iproj,D,power,piv5,inverse5=load(str(folder/'coordinates.sobj'))
LS,t,ex,dt=load(str(folder/'local.sobj'))
cs,cd,cp,pi,ci=load(str(folder/'curve_coordinates.sobj'))
def basis(n):return sorted([(i,j) for j in range(3) for i in range(n//3+1) if 3*i+10*j<=n],
                          key=lambda m:3*m[0]+10*m[1])
engine=NativeDirections(data,KU,K40,Qc,Bc,Iproj,D,cp,pi,ci,ex,basis(112),basis(192),basis(320))
before=resident_rss();KU=K40=Qc=S=Bc=Iproj=D=power=inverse5=LS=t=ex=dt=None
released=release_scratch();after=resident_rss()
print(json.dumps(dict(stage='released_setup_scratch',resident_before=before,resident_after=after,
    allocator_bytes_released=released,seconds=time.monotonic()-start),default=int),flush=True)
answer=engine.direction(args.direction)
assert answer==load(str(folder/('direction_%02d.sobj'%args.direction)))
peak=resident_rss();answer=None;released_after=release_scratch();finished=resident_rss()
report=dict(rep=args.rep,direction=args.direction,degree_F5=engine.native.degree,
    all_N_compact_R_and_original56_R_entries_equal=True,setup_rss_before=before,
    setup_rss_after=after,rss_before_final_cleanup=peak,rss_after_final_cleanup=finished,
    allocator_bytes_released=[released,released_after],seconds=time.monotonic()-start)
out=root.parent/'litt3-computation-data/orbit11-structure'/('native_memory_'+args.rep+'.json')
out.write_text(json.dumps(report,indent=2,default=int)+'\n')
print(json.dumps(report,default=int),flush=True)
