from pathlib import Path
import json,platform,sys
from math import comb
import numpy as np,numba
from exact import *
from point_test import combine_tensor
ROOT=Path(__file__).resolve().parents[1]
def determinant(a):
    a=a.copy();n=len(a);out=1
    for c in range(n):
        p=next((i for i in range(c,n) if a[i,c]),None)
        if p is None:return 0
        if p!=c:a[[c,p]]=a[[p,c]];out=int(NEG[out])
        s=int(a[c,c]);out=int(MUL[out,s]);a[c]=MUL[INV[s],a[c]]
        for i in range(c+1,n):
            if a[i,c]:a[i]=ADD[a[i],MUL[NEG[a[i,c]],a[c]]]
    return out

def main():
    d=np.load(ROOT/'data'/'tensors.npz');out=[]
    for r in json.loads((ROOT/'data'/'bounded_candidates.json').read_text()):
        xi=r['xi'];t=combine_tensor(xi,d['T']);q=combine_tensor(xi,d['Q'])
        rows_t=rref(t.T)[1].tolist();rows_q=rref(q.T)[1].tolist()
        dt=determinant(t[rows_t,:]);dq=determinant(q[rows_q,:]);assert dt and dq
        out.append({'xi':xi,'T_rows':rows_t,'T_determinant':dt,'Q_rows':rows_q,'Q_determinant':dq})
    (ROOT/'certificates'/'candidate_minors.json').write_text(json.dumps(out,indent=2)+'\n')
    B=sum(comb(34+i,i)*comb(33-i,18-i)*26**i*25**(18-i) for i in range(19))
    b={'status':'proved upper bound, conditional only on supplied geometric inputs; NOT a decision','formula':'coefficient of t^18 in (1-26t)^(-35)*(1-25t)^(-16)','bound':str(B),'stable_cardinality_at_most':str(B),'individual_F25_residue_degree_at_most':str(B),'field_bound_exhaustive_search_executed':False}
    (ROOT/'certificates'/'degree_bound.json').write_text(json.dumps(b,indent=2)+'\n')
    env={'python':sys.version,'implementation':platform.python_implementation(),'platform':platform.platform(),'numpy':np.__version__,'numba':numba.__version__}
    (ROOT/'data'/'environment.json').write_text(json.dumps(env,indent=2)+'\n')
    print('16 T/Q maximal-minor certificates written; bound =',B);print(env)
if __name__=='__main__':main()
