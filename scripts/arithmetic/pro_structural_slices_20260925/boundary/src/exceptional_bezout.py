"""Produce directly checkable unit-ideal identities on every exceptional pivot.
A finite-dimensional coefficient ansatz is used only to find a polynomial
identity. The returned exact identity, not the ansatz bound, proves exclusion.
"""
from exceptional_pivot import *
import itertools

def monomials(n,d):
    if n==1:return [(i,) for i in range(d+1)]
    return [(i,)+e for i in range(d+1) for e in monomials(n-1,d-i)]

def certificate(fs,target,bound):
    deg=[max(map(sum,f),default=-1) for f in fs]
    columns=[]
    for i,d in enumerate(deg):
        if d<0:continue
        for e in monomials(T.ngens,bound-d):columns.append((i,e))
    rows_mono=monomials(T.ngens,bound);positions={e:i for i,e in enumerate(rows_mono)}
    mat=[[0]*(len(columns)+1) for e in rows_mono]
    for j,(i,m) in enumerate(columns):
        for e,c in fs[i].items():mat[positions[tuple(a+b for a,b in zip(e,m))]][j]=c.v
    for e,c in target.items():mat[positions[e]][-1]=c.v
    rr,piv=rref(mat)
    if len(columns) in piv:return None
    sol=[0]*len(columns)
    for r,p in zip(rr,piv):sol[p]=r[-1]
    polys=[T.zero for _ in fs]
    for c,(i,m) in zip(sol,columns):
        if c:polys[i]+=T.from_dict({m:FE.code(c)})
    assert sum((a*b for a,b in zip(polys,fs)),T.zero)==target
    return polys,len(rows_mono),len(columns)

def run(index):
    st=time.monotonic();j=json.loads((ROOT/'data'/f'exceptional_pivot_{index}.json').read_text())
    fs=[T.from_dict({tuple(e):FE.code(c) for e,c in f}) for f in j['inputs']]
    assert j['last_index']==7
    for bd in range(max(max(map(sum,f),default=0) for f in fs),16):
        ans=certificate(fs,T.one,bd)
        if ans is not None:
            polys,rows,cols=ans;break
    else:raise ArithmeticError('No Bezout identity found in tested ansatz degrees; no exclusion claimed')
    out={'space_index':index,'s_value':j['s_value'],'variables':['lambda','pbar','qbar'],'inputs':j['inputs'],'multipliers':[[[list(e),c.v] for e,c in sorted(f.items())] for f in polys],'target':[[[0,0,0],1]],'identity':'sum multipliers[i]*inputs[i] = 1','ansatz_total_degree':bd,'linear_system_rows':rows,'linear_system_columns':cols,'status':'identity verified exactly; no parameter search'}
    (ROOT/'data'/f'exceptional_bezout_{index}.json').write_text(json.dumps(out,indent=2)+'\n')
    print('space',index,'exceptional unit identity degree',bd,'rows',rows,'columns',cols,'multiplier terms',[len(f) for f in polys],'seconds',round(time.monotonic()-st,3),flush=True)
    return out

if __name__=='__main__':
    a=argparse.ArgumentParser();a.add_argument('--index',type=int,default=1);args=a.parse_args();run(args.index)
