"""Both generic and exceptional first-pivot branches for v=x-r."""
from degree_strata import *

def substitute_fraction(f,pv,qv,den):
    n=max((e[2]+e[3] for e in f),default=0)
    pp=[ONE];qq=[ONE];dd=[ONE]
    for i in range(n):pp.append(pp[-1]*pv);qq.append(qq[-1]*qv);dd.append(dd[-1]*den)
    out=ZERO
    for e,c in f.items():out+=R.from_dict({(e[0],e[1],0,0):c})*pp[e[2]]*qq[e[3]]*dd[n-e[2]-e[3]]
    return out,n

def strip_units(f,den):
    if not f:return f,0,0
    v=min(e[0] for e in f);f=f*R.from_dict({(-v,0,0,0):K.one})
    n=0
    while not f.rem([den]):
        f=f.exquo(den);n+=1
    return f,v,n

def analyze_linear(index):
    data=json.loads((ROOT/'data'/f'infinity_{index}.json').read_text());F=list(map(deserialize_poly,data['F']))
    A0,B0=coeff_var(F[4],2),coeff_var(F[4],3);A1,B1=coeff_var(F[5],2),coeff_var(F[5],3)
    C0,C1=no_pq(F[4]),no_pq(F[5]);det=A0*B1-A1*B0
    den=det*winv()**2;assert all(e[0]>=0 and e[1:]==(0,0,0) for e in den)
    pv=(-C0*B1+C1*B0)*winv()**2;qv=(-A0*C1+A1*C0)*winv()**2
    assert not substitute_fraction(F[4],pv,qv,den)[0] and not substitute_fraction(F[5],pv,qv,den)[0]
    print('index',index,'determinant',det,flush=True)
    red=[];strip=[]
    for i in range(6,len(F)):
        ff,dpow=substitute_fraction(F[i],pv,qv,den);ff,wpow,ddiv=strip_units(ff,den)
        red.append(ff);strip.append([dpow,wpow,ddiv])
        print('reduced F',i,'terms',len(ff),'degrees',[max([e[j] for e in ff],default=-1) for j in range(2)],'stripped w,D',wpow,ddiv,flush=True)
        if len(ff)<35:print(ff,flush=True)
    out={'index':index,'determinant':serialize(det),'denominator':serialize(den),'p_numerator':serialize(pv),'q_numerator':serialize(qv),'reduced_start':6,'reduced_F':[serialize(f) for f in red],'clearing_and_stripping':strip,'exceptional_branch':{'equations':[serialize(den),serialize(negwpoly(pv)[0]),serialize(negwpoly(qv)[0])],'status':'retained; see exceptional_pivot and exceptional_bezout certificates for this index'}}
    (ROOT/'data'/f'degree_strata_{index}.json').write_text(json.dumps(out,indent=2)+'\n')
    return red

if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--index',type=int,default=1);a=ap.parse_args();analyze_linear(a.index)
