#!/usr/bin/env python3
"""Independent absolute-field exhaustion of the short phase quotient lemma."""
import argparse,itertools,json,time
from pathlib import Path
from sage.all import GF,PolynomialRing,matrix

def main():
    p=argparse.ArgumentParser();p.add_argument('output',type=Path);a=p.parse_args();start=time.monotonic()
    K=GF(5**14,'z');z=K.multiplicative_generator()**((5**14-1)//29)
    assert z!=1 and z**29==1
    phases=[z**j for j in range(29)];found=[];counts={}
    for size in [1,2,3]:
        count=0
        for support in itertools.combinations(range(29),size):
            for tail in itertools.product(range(1,5),repeat=size-1):
                weights=(1,)+tail
                X=sum((w*phases[17*j%29] for j,w in zip(support,weights)),K.zero())
                Y=sum((w*phases[4*j%29] for j,w in zip(support,weights)),K.zero())
                assert X and Y;count+=1
                if Y**25*X==Y*X**25:
                    found.append(dict(support=list(support),weights=list(weights),ratio_one=bool(X==Y)))
        counts[size]=count
    assert found==[dict(support=[0],weights=[1],ratio_one=True)]
    E=GF(5**8,'a');R=PolynomialRing(E,'x');x=R.gen()
    b=(x*x-x-3).roots(multiplicities=False)[0];dec=lambda c:E(c%5)+E(c//5)*b
    alpha=(x**4+dec(7)*x**3+dec(6)*x*x+dec(2)*x+dec(5)).roots(multiplicities=False)[0]
    roots=[alpha**(25**i) for i in range(4)]
    f0=R([dec(c) for c in [20,12,13,8]]);f1=R([dec(c) for c in [21,21,20,2]])
    projection=lambda f,l:4*sum((E(pow(2,(-l*i)%4,5))*f(r) for i,r in enumerate(roots)),E.zero())
    aa=[projection(f0,l) for l in range(4)];bb=[projection(f1,l) for l in range(4)]
    assert all(aa[l] for l in [1,2,3]) and bb[3]==0
    assert all(aa[l]**25==E(pow(2,l,5))*aa[l] for l in [1,2,3])
    assert -bb[1]/aa[1]==dec(10) and -bb[2]/aa[2]==dec(18)
    assert dec(10)**-1==dec(9) and dec(18)**-1==dec(11)
    result=dict(result='PASS',counts=counts,solutions=found,
        root_character_ratios=[10,18],inverse_ratios=[9,11],seconds=time.monotonic()-start,
        method='absolute F5^14 arithmetic; ratio membership by 25th power; independent F5^8 root projections')
    a.output.parent.mkdir(parents=True,exist_ok=True);a.output.write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result),flush=True)

if __name__=='__main__':main()
