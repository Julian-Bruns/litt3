"""Retain and decide the omitted-pivot branch D(w^3)=0 for linear v."""
from infinity_series import *
from sympy.polys.groebnertools import groebner
T,l,pp,qq=ring('l,pp,qq',K,order='grevlex')

def specialize_weighted(f,svalue):
    residues={(e[0]+e[1]+2*e[2]+2*e[3])%3 for e in f}
    if not residues:return T.zero
    assert len(residues)==1,residues
    r=residues.pop();out=T.zero
    for e,c in f.items():
        n=(e[0]+e[1]+2*e[2]+2*e[3]-r)//3
        out+=T.from_dict({e[1:]:c*FE.code(power(svalue,n))})
    return out

def run(index,last=9):
    st=time.monotonic();j=json.loads((ROOT/'data'/f'degree_strata_{index}.json').read_text())
    den=deserialize_poly(j['denominator']);assert set(e[0] for e in den)=={0,3}
    sv=fdiv(neg(den[(0,0,0,0)].v),den[(3,0,0,0)].v);assert sv
    dat=json.loads((ROOT/'data'/f'infinity_{index}.json').read_text())
    fs=[specialize_weighted(deserialize_poly(f),sv) for f in dat['F'][4:last+1]]
    print('index',index,'exceptional s=',sv,'sizes',[len(f) for f in fs],flush=True)
    G=groebner(fs,T)
    print('Groebner',G if sum(map(len,G))<100 else [len(g) for g in G],flush=True)
    U,u,a,b,c=ring('u,l,pp,qq',K,order='grevlex')
    inp=[U.from_dict({(0,)+e:v for e,v in g.items()}) for g in G]+[u*a-1]
    GG=groebner(inp,U)
    print('saturated unit?',GG==[U.one],flush=True)
    out={'space_index':index,'last_index':last,'s_value':sv,'variables':['l=h/w','pp=p/w^2','qq=q/w^2'],'inputs':[[[list(e),c.v] for e,c in sorted(f.items())] for f in fs],'groebner':[[[list(e),c.v] for e,c in sorted(f.items())] for f in G],'saturated_unit':GG==[U.one]}
    (ROOT/'data'/f'exceptional_pivot_{index}.json').write_text(json.dumps(out,indent=2)+'\n')
    print('Seconds',time.monotonic()-st,flush=True)

if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--index',type=int,default=1);ap.add_argument('--last',type=int,default=9);a=ap.parse_args();run(a.index,a.last)
