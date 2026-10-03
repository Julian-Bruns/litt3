#!/usr/bin/env sage
"""Replace marked K coefficients by one algebraic prime-field variable.

The irreducible degree14 coefficient polynomial is imposed. Phase variables
still satisfy z^29=1 over an algebraic closure, so they are not restricted to F5.
"""
import argparse,json,sys
from pathlib import Path
from sage.all import GF,PolynomialRing
sys.path.insert(0,str(Path(__file__).parent))
from target_rank_system import build_target_rank


def main():
    p=argparse.ArgumentParser();p.add_argument('--source',required=True);p.add_argument('--output',type=Path,required=True)
    p.add_argument('--maximum-conjugate-degree',type=int,default=30)
    args=p.parse_args();ep=json.loads(args.source)
    R,eq,aux=build_target_rank(ep,True,args.maximum_conjugate_degree)
    S=PolynomialRing(GF(5),names=list(R.variable_names())+['a'],order='degrevlex');out=[]
    for q in eq:
        converted={}
        for mon,c in q.monomial_coefficients().items():
            for j,d in enumerate(c.polynomial()):
                if d:converted[tuple(map(int,mon))+(j,)]=int(d)
        out.append(S(converted))
    coefficient=S.zero()
    for j,c in enumerate(aux['field'].modulus()):coefficient+=S(c)*S.gen(9)**j
    out.append(coefficient)
    # Verify the conversion at arbitrary target phase roots and each coefficient
    # embedding. This checks the exact relation, not a prime-field point sample.
    import random
    rng=random.Random(105)
    for _ in range(3):
        pp=[aux['xi']**rng.randrange(29) for i in range(8)]+[aux['field'](rng.randrange(5))]
        for n in range(14):
            point=[z**(5**n) for z in pp]+[aux['field'].gen()**(5**n)]
            for original,converted in zip(eq,out):assert converted(*point)==original(*pp)**(5**n)
            assert out[-1](*point)==0
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(','.join(S.variable_names())+'\n5\n'+',\n'.join(str(q).replace(' ','') for q in out)+'\n')
    meta={'source':ep,'variables':10,'equations':len(out),'terms':sum(len(q.monomials()) for q in out),
          'degree':int(max(q.total_degree() for q in out)),'embedding_checks':42,
          'coefficient_polynomial':[int(c) for c in aux['field'].modulus()],
          'scope':'exact scalar-extension realization of genuine-target rank incidence; shared moments not imposed'}
    args.output.with_suffix('.json').write_text(json.dumps(meta,indent=2)+'\n');print(json.dumps(meta),flush=True)

if __name__=='__main__':main()
