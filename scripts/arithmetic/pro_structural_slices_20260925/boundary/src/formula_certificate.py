"""Re-derive the universal 43-term resultant and its 55-term T-expansion.
This is an exact polynomial identity over F5, not an interpolation or sample test.
"""
import json,math,argparse
from pathlib import Path
from sympy.polys.rings import ring
from sympy.polys.domains import GF
ROOT=Path(__file__).resolve().parents[1]

def derive():
    R,n2,n3,n4,n5,Q,C,v=ring('N2,N3,N4,N5,Q,C,v',GF(5))
    fs={10:v,8:n2,7:n3,6:n4,5:n5+v*Q,3:n2*Q,2:n3*Q,1:n4*Q,0:n5*Q+C}
    s0=fs[0]*n2**9;s1=R.zero;ell=R.one;emm=R.zero
    for i in range(1,11):
        if i in fs:
            s1+=fs[i]*n2**(10-i)*ell;s0+=fs[i]*n2**(10-i)*emm
        ell,emm=n3*ell+n2*emm,3*n4*ell
    numerator=4*(n2*s0*s0+n3*s0*s1+2*n4*s1*s1)
    result=numerator.exquo(n2**9)
    assert numerator==n2**9*result and len(result)==43
    terms=[[list(e),int(c)%5] for e,c in sorted(result.items())]
    first={'variables':['N2','N3','N4','N5','Q','C','v'],'terms':terms}
    d={}
    for e,c in terms:
        for j in range(e[3]+1):
            f=e[:];f[3]-=j;f[4]+=j;f[6]+=j;f.append(e[6]+j)
            f=tuple(f);d[f]=(d.get(f,0)+c*math.comb(e[3],j))%5
    second={'variables':['N2','N3','N4','H5','Q','C','v','T'],'terms':[[list(e),c] for e,c in sorted(d.items()) if c]}
    assert len(second['terms'])==55 and max(e[-1] for e,c in second['terms'])==2
    return first,second

def main():
    p=argparse.ArgumentParser();p.add_argument('--write',action='store_true');a=p.parse_args()
    for name,out in zip(['resultant_formula.json','resultant_inverse_kappa.json'],derive()):
        f=ROOT/'data'/name
        if a.write:f.write_text(json.dumps(out,indent=2)+'\n')
        else:assert json.loads(f.read_text())==out,name
    print('43-term resultant and 55-term inverse-kappa expansion: exact polynomial identities PASS')
if __name__=='__main__':main()
