#!/usr/bin/env python3
"""Exact small residual tests after the new 29-phase argument.

Tests zeros a*R+5*D, D effective of degree B on the twelve marked
points, in L((a+5B)O).  R can be fixed by arithmetic/cubic symmetry.
Unknown section coefficients are geometric, not enumerated.
"""
import argparse,itertools,json,time
from pathlib import Path
from sage.all import matrix
from supported_one_sheet_jets import field_and_jets,compositions
p=argparse.ArgumentParser();p.add_argument('output',type=Path)
p.add_argument('--pairs',nargs='*',help='optional a:b pairs')
args=p.parse_args()
args.output.mkdir(parents=True,exist_ok=True)
start=time.monotonic()
pairs=([tuple(map(int,z.split(':'))) for z in args.pairs] if args.pairs else
       [(29,b) for b in range(1,6)]+[(24,b) for b in range(1,5)]+[(19,2)])
K,allcols,jets,field,code=field_and_jets(max(a+5*b for a,b in pairs))
summary=[]
for a,b in pairs:
    now=time.monotonic();n=a+5*b
    ids=[i for i,(ii,jj) in enumerate(allcols) if 3*ii+10*jj<=n]
    cols=[allcols[i] for i in ids]
    base=matrix(K,[[row[i] for i in ids] for row in jets[0][0][:a]])
    ker=base.right_kernel().basis_matrix().transpose()
    if ker.ncols()==0:
        piv=list(base.transpose().pivots());assert len(piv)==len(ids)
        record={'a':a,'b':b,'pole':n,'source_dimension':len(ids),'base_kernel_dimension':0,
                'base_rows':piv,'base_det':code(base.matrix_from_rows(piv).det()),
                'all_excluded':True,'systems':0}
    else:
        blocks=[]
        for i in range(4):
            for s in range(3):
                lo=a if (i,s)==(0,0) else 0
                blocks.append(matrix(K,[[row[t] for t in ids] for row in jets[i][s][lo:lo+5*b]])*ker)
        cert=[];survivors=[]
        for D in compositions(b,12):
            rows=[]
            for j,m in enumerate(D):
                if m:rows+=blocks[j][:5*m,:].rows()
            M=matrix(K,rows);piv=list(M.transpose().pivots())
            if len(piv)==ker.ncols():
                det=M.matrix_from_rows(piv).det();assert det
                cert.append({'D':D,'rows':piv,'det':code(det)})
            else:
                survivors.append({'D':D,'rank':len(piv),
                    'sections':[[code(c) for c in ker*v] for v in M.right_kernel().basis()]})
        record={'a':a,'b':b,'pole':n,'source_dimension':len(ids),'base_kernel_dimension':int(ker.ncols()),
                'kernel':[[code(c) for c in row] for row in ker.rows()],
                'records':cert,'survivors':survivors,'all_excluded':not survivors,
                'systems':len(cert)+len(survivors)}
    record.update(field=field,columns=cols,elapsed_seconds=round(time.monotonic()-now,3))
    (args.output/f'a{a}_b{b}.json').write_text(json.dumps(record,separators=(',',':'))+'\n')
    item={k:record[k] for k in ['a','b','pole','source_dimension','base_kernel_dimension','all_excluded','systems','elapsed_seconds']}
    summary.append(item);(args.output/'summary.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(item,flush=True)
print('COMPLETE',round(time.monotonic()-start,3),flush=True)
