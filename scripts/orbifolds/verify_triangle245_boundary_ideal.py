#!/usr/bin/env sage-python
"""Independent rational Groebner dimension check of the C3=0 chart."""
from sage.all import QQ, PolynomialRing
from pathlib import Path
import json
import sys
import time


def main():
    root=Path(sys.argv[1]);source=(root/'linear.ms').read_text().splitlines()
    R=PolynomialRing(QQ,names=source[0].split(','),order='degrevlex')
    equations=[R(e) for e in '\n'.join(source[2:]).split(',') if e.strip()]
    started=time.time();I=R.ideal(equations)
    basis=I.groebner_basis()
    assert all(e.reduce(basis)==0 for e in equations)
    assert I.dimension()==0 and I.vector_space_dimension()==12
    named=dict(zip(R.variable_names(),R.gens()))
    assert all(named[n].reduce(basis)==0 for n in ('b1','b3','c1'))
    result={'dimension':0,'length':12,'basis_size':len(basis),
            'odd_coefficients_zero':True,'seconds':time.time()-started,
            'algorithm':'Sage/Singular exact rational Groebner basis from the original input'}
    (root/'rational_groebner_basis.txt').write_text('\n'.join(map(str,basis))+'\n')
    (root/'rational_ideal_check.json').write_text(json.dumps(result,indent=2)+'\n')
    print(result,flush=True)


if __name__=='__main__':main()
