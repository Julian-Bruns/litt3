"""Export only the small exact matrix for native bounded interpolation."""
import sys,json,time,itertools
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
d=load(str(root/'inverse_eta_rank_geometry_inputs.sobj'));M=d['matrix'];R=d['ring'];K=R.base_ring()
def absolute_code(c):return sum(int(a)*5^i for i,a in enumerate(c.polynomial().list()))
dh=max(sum(int(M[i,p[i]].degree(R.gen(0))) for i in range(3)) for p in itertools.permutations(range(3)))
dq=max(sum(int(M[i,p[i]].degree(R.gen(1))) for i in range(3)) for p in itertools.permutations(range(3)))
with (root/'inverse_eta_rank_matrix.txt').open('w') as f:
    f.write('3 '+str(dh)+' '+str(dq)+'\n')
    for p in M.list():
        f.write(str(len(p.dict()))+'\n')
        for e,c in p.dict().items():f.write(str(e[0])+' '+str(e[1])+' '+str(absolute_code(c))+'\n')
report={'encoding':'ascending absolute F5 polynomial coefficients of alpha, base5; native converter evaluates alpha=25',
        'shape':[3,3],'determinant_bidegree_bound':[dh,dq],'terms':sum(len(p.dict()) for p in M.list()),'seconds':time.time()-start}
(root/'inverse_eta_rank_matrix.json').write_text(json.dumps(report,indent=2,default=int)+'\n')
print(report,flush=True)
