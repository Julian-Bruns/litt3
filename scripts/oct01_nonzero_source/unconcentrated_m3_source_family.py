#!/usr/bin/env python3
"""Tiny exact source-kernel and literal finite-frame family; no existence claim."""
import argparse,json,sys,time
from pathlib import Path
import numpy as np
ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(ARCHIVE/'src'))
from exact import Field,Curve,Poly,B0_CODES,L0_CODES,Q_CODES,monomials
from infinity import InfinitySystem
from strata import SOURCE_NAMES
p=argparse.ArgumentParser();p.add_argument('--work',type=Path,required=True);args=p.parse_args();start=time.time();data=args.work/'data';k=Field(args.work/'cache');C=Curve(k);P=Poly(k);family=json.loads((data/'adapted_family.json').read_text());system=InfinitySystem(k,family);record=system.record(10,[],3)
assert record['affine_S_dimension']==8 and record['equality_rank']==4
indices=[0,1,6,7,8,9,10,11,12];free=indices[1:];zero=C.zero();one=C.const(1);Z=C.polyx(P.sub(B0_CODES,L0_CODES));y=C.monomial(0,1)
S=[];D=[];short_d2_numerators=[]
for index in indices:
    ss,q=C.frame(system.N[index]);dd=[C.scale(ss[j],j) for j in range(1,5)];S.append(ss);D.append(dd)
    short_d2_numerators.append(C.add(C.mul(y,dd[2]),C.scale(C.mul(Z,dd[3]),3)))
assert all(C.pole(n)<=24 for n in short_d2_numerators)
assert C.pole(short_d2_numerators[1])==24 and all(C.pole(n)<=23 for j,n in enumerate(short_d2_numerators) if j!=1)
for j,index in enumerate(indices):
    if index==1:
        assert D[j][3][1:]==[[],[]];linear=D[j][3][0];assert len(linear)==2 and linear[0]==k.mul(12,linear[1])
    else:assert D[j][3]==zero
q=C.frame(system.N[0])[1];phi=[q]+[zero]*4+[one]
def polmul(a,b):
    out=[C.zero() for _ in range(len(a)+len(b)-1)]
    for i,f in enumerate(a):
        for j,g in enumerate(b):out[i+j]=C.add(out[i+j],C.mul(f,g))
    return out
def fromS(ss):return polmul(phi,ss)+[zero]
F=[fromS(ss) for ss in S];F[0][0]=C.add(F[0][0],C.power(C.polyx(family['t']),3));phi2=polmul(phi,phi);vlabels=monomials(10)
for b,char in vlabels:F.append([C.mul(C.monomial(b,char),f) for f in phi2])
assert len(F)==14 and all(len(ff)==11 for ff in F)
for j,ff in enumerate(F):
    derivative=[C.scale(ff[i+1],(i+1)%5) for i in range(10)];expected=polmul(phi,D[j])+[zero] if j<len(D) else [zero]*10;assert derivative==expected
matrix,tags,*_=system.case(10,[],3);basis=np.vstack((record['origin'],record['directions']));assert not np.any(k.matmul(matrix,basis.T)) and len(k.rref(basis)[1])==9
report={'scope':'necessary full m3 Newton coefficient family; concentration excluded separately; no irreducibility or etale realization assertion','kappa':1,'affine_source_dimension':13,'S_dimension':8,'v_dimension':5,'homogeneous_source_indices':indices,'source_parameter_names':[SOURCE_NAMES[i] for i in free]+[f'v_x{b}_y{r}' for b,r in vlabels],'S_basis_finite':S,'D_basis_finite':D,'F_affine_columns_finite':F,'q_finite':q,'P':C.P,'t':family['t'],'Z':Z,'m3_open':'sourceindex1 !=0 and v_y!=0','short_d2_ycleared_columns':short_d2_numerators,'short_d2_exactpole14_witness':{'index1_leading_code':C.leading(short_d2_numerators[1]),'other_columns_pole_bound':23},'critical_leading_line':'delta3 = nonzero scalar*(x+[12]); already intrinsic in linear source family','record':record,'seconds':time.time()-start}
(data/'unconcentrated_m3_source_family.json').write_text(json.dumps(report,separators=(',',':'))+'\n');print(json.dumps({key:report[key] for key in ('affine_source_dimension','S_dimension','v_dimension','source_parameter_names','short_d2_exactpole14_witness','seconds')}))
