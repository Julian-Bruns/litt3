#!/usr/bin/env sage
"""Bounded full original-R witness check from existing immutable directions."""
import argparse,json,time
from pathlib import Path
from atlas_factored_R_witness import FactoredRWitness

ap=argparse.ArgumentParser();ap.add_argument('--rep',required=True)
ap.add_argument('--folder');ap.add_argument('--workers',type=int,default=1)
ap.add_argument('--memory-gib',type=float,default=8);args=ap.parse_args()
root=Path(__file__).resolve().parents[1];external=root.parent/'litt3-computation-data'
folder=Path(args.folder) if args.folder else external/'atlas-all18'/args.rep/'tensor'
data=load(str(folder/'oper.sobj'));S,Bc,Iproj,D,power,pivots,inverse=load(str(folder/'coordinates.sobj'))
engine=FactoredRWitness(data,Bc,Iproj)
out=external/'orbit11-structure'/('factored_R_'+args.rep)
result=engine.verify([folder/('direction_%02d.sobj'%i) for i in range(32)],out,args.workers,args.memory_gib)
old=folder/'coupled_R_certificate.sobj'
if old.exists():
    assert result==load(str(old))
    print(json.dumps(dict(rep=args.rep,exactly_equal_to_old_full_matrix_witness=True)),flush=True)
save(result,str(out/'coupled_R_certificate.sobj'))
