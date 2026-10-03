#!/usr/bin/env python3
"""Univariate polynomial source-rank model on the eight concentration profiles."""
import argparse,json,sys
from pathlib import Path
import numpy as np
ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(ARCHIVE/'src'))
from exact import Field,Poly
from infinity import InfinitySystem,POLES_V
from endpoint_jets import FiniteEndpoint,ENDPOINT_ROOTS,SOURCE_CHARACTERS
from finite_concentration import concentrated_matrix


def eliminate(p,rows,return_witness=False):
    a=[[list(f) for f in row] for row in rows];m=len(a);n=len(a[0])
    witness=[[[1] if i==j else [] for j in range(m)] for i in range(m)]
    order=list(range(1,n))+[0];pivots=[];r=0
    for col in order:
        candidates=[i for i in range(r,m) if a[i][col]]
        if not candidates:continue
        i=min(candidates,key=lambda j:len(a[j][col]))
        a[r],a[i]=a[i],a[r];witness[r],witness[i]=witness[i],witness[r]
        while True:
            candidates=[i for i in range(r+1,m) if a[i][col]]
            if not candidates:break
            i=candidates[0];q,remainder=p.divmod(a[i][col],a[r][col])
            if q:
                a[i]=[p.sub(f,p.mul(q,g)) for f,g in zip(a[i],a[r])]
                witness[i]=[p.sub(f,p.mul(q,g)) for f,g in zip(witness[i],witness[r])]
            if remainder:a[r],a[i]=a[i],a[r];witness[r],witness[i]=witness[i],witness[r]
        factor=p.k.inv(a[r][col][-1])
        a[r]=[p.scale(f,factor) for f in a[r]]
        witness[r]=[p.scale(f,factor) for f in witness[r]]
        pivots.append(col);r+=1
        if r==m:break
    result={'generic_rank':r,'generic_homogeneous_kernel_dimension':n-r,
            'pivot_columns':pivots,'row_echelon':a}
    if return_witness:result['row_transform']=witness
    if 0 in pivots:
        index=pivots.index(0)
        assert not any(a[index][1:])
        for column in range(n):
            total=[]
            for coefficient,row in zip(witness[index],rows):
                total=p.add(total,p.mul(coefficient,row[column]))
            assert total==(a[index][0] if column==0 else [])
        result.update(kappa_multiplier=a[index][0],kappa_identity=witness[index],
                      generic_kappa_allowed=False)
    else:result['generic_kappa_allowed']=True
    return result


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True)
    args=ap.parse_args();k=Field(args.work/'cache');p=Poly(k)
    family=json.loads((args.work/'data/adapted_family.json').read_text());system=InfinitySystem(k,family)
    records=[]
    for root in ENDPOINT_ROOTS:
        endpoint=FiniteEndpoint(k,family,root,cut=10);base=concentrated_matrix(endpoint)
        for d,m in ((0,12),(3,12),(6,12),(9,12),(10,6),(10,9),(10,10),(10,12)):
            raw,*_=system.case(d,[] if d==10 else [10-d],m)
            rows=[[list(f) for f in row] for row in base]
            for row in raw:
                assert len({SOURCE_CHARACTERS[i] for i,c in enumerate(row) if c})<=1
                rows.append([[int(c)] if c else [] for c in row]+[[] for _ in range(5)])
            for j,pole in enumerate(POLES_V):
                if pole>d:
                    row=[[] for _ in range(18)];row[13+j]=[1];rows.append(row)
            result=eliminate(p,rows)
            result.update(root_K_code=root,d=d,m=m,polynomial_matrix=rows)
            records.append(result)
    report={'scope':'generic source ranks over K(eta) with exact polynomial target identities; rank-drop slopes and nonzero leading forms remain included',
            'source_characters':SOURCE_CHARACTERS,'records':records}
    (args.work/'data/concentrated_source_ranks.json').write_text(json.dumps(report,separators=(',',':'))+'\n')
    print(json.dumps([{key:item[key] for key in ('root_K_code','d','m','generic_rank','generic_homogeneous_kernel_dimension','generic_kappa_allowed')}|
                      {'kappa_multiplier_degree':len(item.get('kappa_multiplier',[]))-1} for item in records]))


if __name__=='__main__':main()
