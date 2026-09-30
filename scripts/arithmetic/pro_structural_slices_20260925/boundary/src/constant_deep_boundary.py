"""Exact univariate elimination on v=1 after F4=F5=0; includes every pivot boundary."""
from degree_strata import *
from exact import FP

def wh_coefficient(f,hdeg):
    d={e[0]:c.v for e,c in f.items() if e[1]==hdeg}
    assert all(e[2]==e[3]==0 for e in f)
    return d

def clear_w(f):
    m=min([e[0] for e in f],default=0)
    return f*R.from_dict({(-min(m,0),0,0,0):K.one})

def to_fp(f):
    assert all(e[0]>=0 and e[1:]==(0,0,0) for e in f)
    d=[0]*(max([e[0] for e in f],default=-1)+1)
    for e,c in f.items():d[e[0]]=c.v
    return FP(d)

def h_parts(f):
    return [to_fp(R.from_dict({(e[0],0,0,0):c for e,c in f.items() if e[1]==i})) for i in range(max([e[1] for e in f],default=-1)+1)]

def main():
    j=json.loads((ROOT/'data'/'degree_strata_0.json').read_text());fs=list(map(deserialize_poly,j['reduced_F']))
    B,A=h_parts(clear_w(fs[0]));gg,S,T=A.xgcd(B)
    print('A degree',A.deg,'B degree',B.deg,'gcd(A,B)',gg,flush=True)
    assert gg==1
    pol=[]
    for idx,ff in enumerate(fs[1:],7):
        parts=h_parts(clear_w(ff));n=len(parts)-1;u=FP()
        for i,c in enumerate(parts):u+=c*((-B)**i)*(A**(n-i))
        pol.append(u)
        print('eliminant F',idx,'degree',u.deg,flush=True)
    G,C,D=pol[0].xgcd(pol[1]);print('gcd(F7,F8 eliminants) degree',G.deg,G,flush=True)
    out={'A':list(A.c),'B':list(B.c),'pivot_bezout':[list(S.c),list(T.c)],'eliminants':[list(u.c) for u in pol],'gcd78':list(G.c),'bezout78':[list(C.c),list(D.c)]}
    print('gcd(N7,A)',pol[0].gcd(A),'gcd(N7,B)',pol[0].gcd(B),'gcd(N7,w)',pol[0].gcd(x),flush=True)
    if len(pol)>2:print('gcd(F7,F8,F9)',G.gcd(pol[2]),flush=True)
    (ROOT/'data'/'constant_deep_boundary.json').write_text(json.dumps(out,indent=2)+'\n')

if __name__=='__main__':main()
