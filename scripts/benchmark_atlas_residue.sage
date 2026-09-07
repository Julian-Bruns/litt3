#!/usr/bin/env sage
"""Bounded exact comparison of native residue blocks with saved ORIGINAL rows."""
import argparse,json,time
from pathlib import Path
from atlas_series import coefficients
from atlas_residue_projection import ResidueProjection
from atlas_native_rref import NativeRref

ap=argparse.ArgumentParser();ap.add_argument('--rep',required=True)
ap.add_argument('--directions',type=int,nargs='+',default=[0]);args=ap.parse_args()
root=Path(__file__).resolve().parents[1]
folder=root.parent/'litt3-computation-data/atlas-all18'/args.rep/'tensor'
started=time.monotonic();data=load(str(folder/'oper.sobj'));k=data['k'];a=data['a']
KU,K40,Qc,h0V=load(str(folder/'polynomial.sobj'))
S,Bc,Iproj,D,power,piv5,inverse5=load(str(folder/'coordinates.sobj'))
LS,t,expansions,dt=load(str(folder/'local.sobj'))
def layers(k,d):
    if d['kind']=='finite_field': return [(k,d)]
    return layers(k.base_ring(),d['base'])+[(k,d)]
bridge=NativeRref(k,layers(k,data['field_description']))
flat=bridge.native_field; native=NativeRref(flat); aflat=bridge.to_native(a)
def flatten(M):
    return matrix(flat,M.nrows(),M.ncols(),[bridge.to_native(c) for c in M.list()],implementation='generic')
gaps=[1,2,4,5,7,8,11,14,17];domain=[-g for g in gaps]+list(range(1,32))
target=[-g for g in gaps]+list(range(1,48));projection=ResidueProjection(expansions,domain,target)
monsU=sorted([(i,j) for j in range(3) for i in range(38) if 3*i+10*j<=112],key=lambda m:3*m[0]+10*m[1])
curveU=matrix(LS.base_ring(),[coefficients(expansions[m],projection.u_exponents) for m in monsU]).transpose()
Bc5=flatten(Bc).apply_map(lambda c:c**5);Dbc5=flatten(D*Bc).apply_map(lambda c:c**5)
Ip=flatten(Iproj);setup=time.monotonic()-started;results=[]
for i in args.directions:
    begin=time.monotonic();uv=flatten(matrix(k,104,1,list(KU.row(i))))
    U=native.multiply(curveU,uv,base_generator=aflat).column(0)
    raw=projection.raw(U,Bc5,Dbc5,None,multiply=native.multiply,
        base_multiply=lambda A,B:native.multiply(A,B,base_generator=aflat))
    compact=native.multiply(Ip,raw)
    arithmetic=time.monotonic()-begin
    original=load(str(folder/('direction_%02d.sobj'%i)))
    assert flatten(original[2])==raw and flatten(original[1])==compact
    result=dict(direction=i,native_seconds=arithmetic,verified_seconds=time.monotonic()-begin,
        all56_original_rows_identical=True,compact32_rows_identical=True)
    results.append(result);print(json.dumps(result),flush=True)
report=dict(rep=args.rep,degree_F5=native.degree,setup_seconds=setup,results=results,
    operations=native.records,total_seconds=time.monotonic()-started,
    scope='All56 rawR and32 compactR rows per stated direction; no excluded atlas')
print(json.dumps({k:v for k,v in report.items() if k!='operations'}),flush=True)
out=root.parent/'litt3-computation-data/orbit11-structure'/('native_residue_'+args.rep+'.json')
out.write_text(json.dumps(report,indent=2)+'\n')
