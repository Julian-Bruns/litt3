"""Eliminate the first two additional infinity cancellations exactly, with no missed pivots."""
from infinity_series import *
from sympy.polys.groebnertools import groebner

def coeff_var(f,j):
    # Used only when f is affine linear in p,q.
    out={}
    for e,c in f.items():
        if e[j]:
            assert e[j]==1 and e[5-j]==0
            ee=list(e);ee[j]=0;out[tuple(ee)]=c
    return R.from_dict(out)

def no_pq(f):return R.from_dict({e:c for e,c in f.items() if e[2]==e[3]==0})
def mon_inv(f):
    if len(f)!=1:raise ValueError(('not a monomial',f))
    (e,c),=f.items();return R.from_dict({tuple(-i for i in e):1/c})

def substitute(f,pv,qv):
    out=ZERO;Pows={0:ONE};Qows={0:ONE}
    for i in range(1,max([e[2] for e in f],default=0)+1):Pows[i]=Pows[i-1]*pv
    for i in range(1,max([e[3] for e in f],default=0)+1):Qows[i]=Qows[i-1]*qv
    for e,c in f.items():out+=R.from_dict({(e[0],e[1],0,0):c})*Pows[e[2]]*Qows[e[3]]
    return out

def analyze(index):
    data=json.loads((ROOT/'data'/f'infinity_{index}.json').read_text());F=list(map(deserialize_poly,data['F']))
    A0,B0=coeff_var(F[4],2),coeff_var(F[4],3);A1,B1=coeff_var(F[5],2),coeff_var(F[5],3)
    C0,C1=no_pq(F[4]),no_pq(F[5]);det=A0*B1-A1*B0
    di=mon_inv(det)
    pv=(-C0*B1+C1*B0)*di;qv=(-A0*C1+A1*C0)*di
    assert not substitute(F[4],pv,qv) and not substitute(F[5],pv,qv)
    print('index',index,'determinant',det,'p=',pv,'q=',qv,flush=True)
    red=[]
    for i in range(6,len(F)):
        ff=substitute(F[i],pv,qv);red.append(ff)
        print('reduced F',i,'terms',len(ff),'degrees',[max([e[j] for e in ff],default=-1) for j in range(2)],flush=True)
        if len(ff)<30:print(ff,flush=True)
    out={'index':index,'determinant':serialize(det),'p_solution':serialize(pv),'q_solution':serialize(qv),'reduced_start':6,'reduced_F':[serialize(f) for f in red]}
    (ROOT/'data'/f'degree_strata_{index}.json').write_text(json.dumps(out,indent=2)+'\n')
    return red

if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--index',type=int,default=0);a=ap.parse_args();analyze(a.index)
