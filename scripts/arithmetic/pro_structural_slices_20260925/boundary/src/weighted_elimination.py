"""Weighted two-variable compression and exact Groebner checks on deep boundaries."""
from infinity_series import *
from sympy.polys.groebnertools import groebner
import sys

S,ss,ll=ring('s,l',K,order='grevlex')

def compress(f,weight):
    residues={(e[0]+weight*e[1])%3 for e in f}
    if not residues:return S.zero,0,0
    assert len(residues)==1,residues
    r=residues.pop();d={((e[0]+weight*e[1]-r)//3,e[1]):c for e,c in f.items()}
    low=min(a for a,b in d);shift_s=-min(0,low)
    out=S.from_dict({(a+shift_s,b):c for (a,b),c in d.items()})
    return out,r,shift_s

def data2(f):return [[list(e),c.v] for e,c in sorted(f.items())]

def run(index,maxindex=8):
    st=time.monotonic();j=json.loads((ROOT/'data'/f'degree_strata_{index}.json').read_text());weight=2 if index==0 else 1
    fs=[compress(deserialize_poly(f),weight)[0] for f in j['reduced_F'][:maxindex-5]]
    print('index',index,'compressed inputs',[(len(f),f.degree(ss),f.degree(ll)) for f in fs],flush=True)
    G=groebner(fs,S)
    print('Groebner',len(G),'terms',[len(g) for g in G],flush=True)
    for g in G:
        if len(g)<30:print(g,flush=True)
    den=S.one if index==0 else compress(deserialize_poly(j['denominator']),1)[0]
    T,u,s,l=ring('u,s,l',K,order='grevlex')
    fsT=[T.from_dict({(0,)+e:c for e,c in f.items()}) for f in G]
    dd=T.from_dict({(0,)+e:c for e,c in den.items()})
    g2=groebner(fsT+[u*s*l*dd-1],T)
    print('Saturated Groebner',len(g2),'terms',[len(g) for g in g2],'unit?',g2==[T.one],flush=True)
    out={'space_index':index,'h_weight':weight,'last_index':maxindex,'variables':['s=w^3','l=h/w^weight'],'polynomials':[data2(f) for f in fs],'denominator':data2(den),'groebner':[data2(f) for f in G],'saturated_unit':g2==[T.one],'saturated_groebner':[[[list(e),c.v] for e,c in sorted(f.items())] for f in g2]}
    (ROOT/'data'/f'weighted_elimination_{index}.json').write_text(json.dumps(out,indent=2)+'\n')
    print('Seconds',time.monotonic()-st,flush=True)

if __name__=='__main__':
    a=argparse.ArgumentParser();a.add_argument('--index',type=int,default=1);a.add_argument('--last',type=int,default=8);x=a.parse_args();run(x.index,x.last)
