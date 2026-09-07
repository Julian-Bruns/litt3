#!/usr/bin/env sage
"""Bounded original-coordinate check without requiring an old full tensor.

Check three complete N rows and three complete original56-row R columns
against independent old-coordinate polynomial/Laurent calculations. The
native engine additionally checks every Wronskian fifth-power identity;
the fixed residue map has a separate exhaustive330-monomial verification.
"""
import argparse,hashlib,json,time
from pathlib import Path
from sage.env import SAGE_VERSION
from atlas_native_directions import NativeDirections
from atlas_series import coefficient,coefficients,transport,from_terms

ap=argparse.ArgumentParser();ap.add_argument('--rep',required=True)
ap.add_argument('--direction',type=int,default=0);args=ap.parse_args()
root=Path(__file__).resolve().parents[1]
folder=root.parent/'litt3-computation-data/atlas-all18'/args.rep/'tensor'
started=time.monotonic();data=load(str(folder/'oper.sobj'))
KU,K40,Qc,h0V=load(str(folder/'polynomial.sobj'))
S,Bc,Iproj,D,power,piv5,inverse5=load(str(folder/'coordinates.sobj'))
curveLS,curve_t,curve_ex,curve_dt=load(str(folder/'local.sobj'))
curveS,curveD,curvepower,curvepiv5,curveinverse5=load(str(folder/'curve_coordinates.sobj'))
def basis(n):
    return sorted([(i,j) for j in range(3) for i in range(n//3+1) if 3*i+10*j<=n],
                  key=lambda m:3*m[0]+10*m[1])
monsU,mons192,mons320=basis(112),basis(192),basis(320)
engine=NativeDirections(data,KU,K40,Qc,Bc,Iproj,D,curvepower,piv5,curveinverse5,
                        curve_ex,monsU,mons192,mons320)
setup=time.monotonic()-started
native_started=time.monotonic();actual=engine.direction(args.direction)
native_seconds=time.monotonic()-native_started
print(json.dumps(dict(stage='native_complete',setup_seconds=setup,
                      native_seconds=native_seconds)),flush=True)
k,R,x,F=data['k'],data['R'],data['x'],data['F'];Fp=F.derivative()
def poly(v,mons):
    answer=[{} for _ in range(3)]
    for c,(i,j) in zip(v,mons):
        if c:answer[j][i]=c
    return tuple(R(cs) for cs in answer)
def delta(v):
    answer=[R.zero() for _ in range(3)]
    for j,f in enumerate(v):
        answer[(j+2)%3]+=f.derivative()*F**((j+2)//3)
        if j:answer[j-1]+=2*j*f*Fp
    return tuple(answer)
def mul(v,w):
    answer=[R.zero() for _ in range(3)]
    for j,f in enumerate(v):
        for h,g in enumerate(w):answer[(j+h)%3]+=f*g*F**((j+h)//3)
    return tuple(answer)
uv=KU.row(args.direction);up=poly(uv,monsU);du=delta(up)
nrows=[0,19,63];wronskians=[]
for h in nrows:
    tp=poly(K40.row(h),mons192);dtp=delta(tp)
    wronskians.append(tuple(a-b for a,b in zip(mul(up,dtp),mul(tp,du))))
wc=matrix(k,[[v[j][i] for i,j in mons320] for v in wronskians],implementation='generic').transpose()
inv=matrix(k,inverse5.nrows(),inverse5.ncols(),inverse5.list(),implementation='generic')
coords=inv*wc.matrix_from_rows(piv5)
pm=matrix(k,power.nrows(),power.ncols(),power.list(),implementation='generic')
assert pm*coords==wc
nproj=matrix(k,Qc.ncols(),Qc.nrows(),Qc.transpose().list(),implementation='generic').apply_map(lambda c:c**5)
reference_N=coords.transpose()*nproj
assert reference_N==actual[0].matrix_from_rows(nrows)
print(json.dumps(dict(stage='original_N_rows_verified',rows=nrows,
    seconds=time.monotonic()-started),default=int),flush=True)
LS=LaurentSeriesRing(k,'t',default_prec=800);t=LS.gen()
def embed(c):
    return sum((k(cc)*data['a']**i for i,cc in enumerate(c.polynomial().list())),k.zero())
expansions={m:transport(s,LS,embed) for m,s in curve_ex.items()}
reducers={3*i+10*j:s for (i,j),s in expansions.items()}
def rem(s):
    assert s.valuation()>=-197 and s.precision_absolute()>132
    for pole in sorted(reducers,reverse=True):
        c=coefficient(s,-pole)
        if c:s-=c*reducers[pole]
    return s
gaps=[1,2,4,5,7,8,11,14,17]
domain=[-g for g in gaps]+list(range(1,32))
target=[-g for g in gaps]+list(range(1,48))
U=sum((c*expansions[m] for c,m in zip(uv,monsU)),LS.zero())
DB=D*Bc;rcolumns=[0,11,31]
for h in rcolumns:
    eta=from_terms(LS,{5*e:c**5 for e,c in zip(target,Bc.column(h))})
    primitive=from_terms(LS,{5*e:c**5 for e,c in zip(domain,DB.column(h))})
    raw=vector(k,coefficients(rem(t**(-85)*rem(U*eta)-U*primitive),target))
    assert raw==actual[2].column(h)
    assert Iproj*raw==actual[1].column(h)
    print(json.dumps(dict(stage='original_R_column_verified',column=h,rows=56,
        seconds=time.monotonic()-started),default=int),flush=True)
report=dict(rep=args.rep,direction=args.direction,degree_F5=engine.native.degree,
    field_model=engine.bridge.field_model,field_modulus=list(engine.native.modulus),
    sage_version=SAGE_VERSION,random_seed=None,N_rows=nrows,N_columns=32,
    R_columns=rcolumns,R_rows=56,compact_R_rows=32,
    all_selected_original_coordinate_entries_identical=True,
    setup_seconds=setup,native_seconds=native_seconds,total_seconds=time.monotonic()-started,
    input_sha256={name:hashlib.sha256((folder/name).read_bytes()).hexdigest() for name in
        ['oper.sobj','polynomial.sobj','coordinates.sobj','local.sobj','curve_coordinates.sobj']},
    scope='Bounded exact original-coordinate regression, not a complete second tensor or atlas exclusion')
out=root.parent/'litt3-computation-data/orbit11-structure'/('native_fresh_'+args.rep+'.json')
out.write_text(json.dumps(report,indent=2,default=int)+'\n')
save(actual,str(out.with_suffix('.sobj')))
print(json.dumps(report,default=int),flush=True)
