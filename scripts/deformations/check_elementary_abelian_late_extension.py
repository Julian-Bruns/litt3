"""Exact local checks for the elementary-abelian late-descent extension.

The proof uses Fourier bounds and the already audited group-independent
geometric comparison. These finite computations audit its new image
inclusion and index arithmetic, not the global geometry.
"""
import json
from pathlib import Path
from sage.all import GF, PolynomialRing


def main():
    P=PolynomialRing(GF(5),['u','v','w'],order='degrevlex');u,v,w=P.gens()
    results=[]
    for power in (2,4):
        I=P.ideal([u**5,v**5,w**5,u*v+w**power])
        monomials=[u**a*v**b*w**c for a in range(5) for b in range(5) for c in range(5) if a+b+c>=8]
        assert all(I.reduce(z)==0 for z in monomials)
        results.append({'type':f'uv+w^{power}','length':int(I.vector_space_dimension()),
                        'J8_monomials_tested':len(monomials),'all_zero':True,
                        'groebner_basis':[str(z) for z in I.groebner_basis()]})
    pure=P.ideal([u**5,v**5,w**5,u*v])
    assert pure.reduce(u**4*w**4)!=0
    counts=0
    for rank in range(2,13):
        for m in range(rank,rank+5):
            M=m+rank+1
            assert 2*(m+1)>=m+rank+2 # square-zero curve ideal
            assert 3*m>=M
            assert 2*m+1>=M
            assert 2*m+2>=M
            for j in range(0,251):
                val=sum((j//5**i) for i in range(1,7))
                assert j+1-val>=1
                counts+=1
    out={'status':'PASS exact finite local checks','models':results,
         'pure_node_extra_radical_warning':'u4*w4 survives modulo (uv,u5,v5,w5); nondegenerate binary symbol alone does not imply J8 image in rank3.',
         'index_checks':counts,
         'scope':'Image inclusions for A1/A3 and finite precision diagnostics; not an initial bootstrap or common-cover verdict.'}
    dst=Path(__file__).resolve().parents[2]/'Research/computations/elementary_abelian_late_extension_checks.json'
    dst.write_text(json.dumps(out,indent=2)+'\n');print(json.dumps(out,indent=2))


if __name__=='__main__':main()
