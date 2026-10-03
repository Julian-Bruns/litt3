#!/usr/bin/env sage
"""Nine-variable exact genuine-target rank incidence for one actual source.

A positive rank point still needs the original shared-moment completion.
A unit ideal excludes every genuine full-support rank-three target on the source.
"""
import argparse,json,random,sys,time
from pathlib import Path
from sage.all import PolynomialRing
sys.path.insert(0,str(Path(__file__).parent))
from coefficient_split_system import build_coefficient_split,CW,EW,UW,VW
from field import K,mat_inv,transpose,mat_vec,ksum
from incidence import endpoint,phase_polynomials,f5rank


def build_target_rank(ep,frobenius=False,maximum_conjugate_degree=30):
    _,_,_,aux=build_coefficient_split(ep)
    KK,k=aux['field'],aux['embedded'];b=lambda c:k(K.elt(c))
    A=endpoint(ep);Ti=mat_inv(transpose((A['E1'][1:],A['C'][1:],A['U'][1:])))
    R=PolynomialRing(KK,names=[f'p{i}' for i in range(8)]+['n'],order='degrevlex');ps=R.gens()[:8];iv=R.gen(8)
    def row(weights,exponent):
        return [b(weights[l])*sum((KK(2)**(l*i)*(ps[2*i]**exponent+ps[2*i+1]**exponent) for i in range(4)),R.zero()) if weights[l] else R.zero() for l in range(4)]
    D,G,W,Z=row(CW,5),row(EW,8),row(UW,17),row(VW,4)
    h=[sum((k(Ti[i][j])*Z[j+1] for j in range(3)),R.zero()) for i in range(3)]
    eq=[D[l]*h[0]+G[l]*h[1]-k(A['V'][l])*h[2]+W[l] for l in range(1,4)]
    eq+=[p**29-1 for p in ps]
    eq+=[iv*D[1]*D[2]*D[3]-1]
    conjugates=[]
    if frobenius:
        for n in range(1,14):
            for f in eq[:3]:
                transformed={}
                for mon,c in f.monomial_coefficients().items():
                    exponent=tuple((int(v)*5**n)%29 for v in mon[:8])+(0,)
                    transformed[exponent]=transformed.get(exponent,KK.zero())+c**(5**n)
                polynomial=R(transformed)
                if polynomial.total_degree()<=maximum_conjugate_degree:
                    conjugates.append((n,len(eq)-12))
                    eq.append(polynomial)
    return R,eq,{'field':KK,'xi':aux['xi'],'embedded':k,'rows':{'C':D,'E1':G,'U':W,'V':Z},'source_inverse':Ti,'conjugates':conjugates}


def main():
    p=argparse.ArgumentParser();p.add_argument('--source',required=True);p.add_argument('--output',type=Path,required=True)
    p.add_argument('--solve',action='store_true');p.add_argument('--algorithm',default='singular:slimgb')
    p.add_argument('--frobenius',action='store_true')
    p.add_argument('--maximum-conjugate-degree',type=int,default=30)
    args=p.parse_args();ep=json.loads(args.source);start=time.monotonic();R,eq,aux=build_target_rank(ep,args.frobenius,args.maximum_conjugate_degree)
    rng=random.Random(104);A=endpoint(ep)
    for _ in range(5):
        target=tuple(tuple(sorted((rng.randrange(29),rng.randrange(29)))) for i in range(4));B=endpoint(target)
        point=[aux['xi']**j for pair in target for j in pair]+[aux['field'](rng.randrange(5))]
        for name,row in aux['rows'].items():
            for l in range(4):assert row[l](*point)==aux['embedded'](B[name][l])
        h=mat_vec(aux['source_inverse'],B['V'][1:])
        for l in range(1,4):
            expected=ksum((K.mul(B['C'][l],h[0]),K.mul(B['E1'][l],h[1]),K.neg(K.mul(A['V'][l],h[2])),B['U'][l]))
            assert eq[l-1](*point)==aux['embedded'](expected)
        assert all(q(*point)==0 for q in eq[3:11])
        if args.frobenius:
            index=12
            for n in range(1,14):
                for j in range(3):
                    transformed={}
                    for mon,c in eq[j].monomial_coefficients().items():
                        power=tuple((int(v)*5**n)%29 for v in mon[:8])+(0,)
                        transformed[power]=transformed.get(power,aux['field'].zero())+c**(5**n)
                    if R(transformed).total_degree()<=args.maximum_conjugate_degree:
                        assert eq[index](*point)==eq[j](*point)**(5**n);index+=1
            assert index==len(eq)
    meta={'source':ep,'variables':9,'equations':len(eq),'terms':sum(len(q.monomials()) for q in eq),
          'degree':int(max(q.total_degree() for q in eq)),'build_check_seconds':time.monotonic()-start,
          'direct_point_checks':5,'status':'exact genuine-target rank incidence; shared moments not imposed','algorithm':args.algorithm}
    args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(meta,indent=2)+'\n');print(json.dumps(meta),flush=True)
    if args.solve:
        start=time.monotonic();gb=R.ideal(eq).groebner_basis(algorithm=args.algorithm)
        meta.update(solver_seconds=time.monotonic()-start,basis_length=len(gb),unit_ideal=gb==[R.one()])
        args.output.write_text(json.dumps(meta,indent=2)+'\n');print(json.dumps(meta),flush=True)

if __name__=='__main__':main()
