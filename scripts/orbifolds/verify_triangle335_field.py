#!/usr/bin/env sage-python
"""Verify the necessary elimination and the totally ramified field, exactly.

Run with Sage's Python and the directory containing open/ and boundary/.
Both presentations are compared by exact reduced Groebner bases. The
negative result does not rely on a numerical root calculation or on
assuming that the displayed models exhaust any unchecked solution set.
"""
from sage.all import QQ, PolynomialRing
from pathlib import Path
import json
import sys


def encode(poly):
    return [[list(exponents), str(coefficient)]
            for exponents, coefficient in sorted(poly.dict().items())]


def check_chart(path, names):
    ring = PolynomialRing(QQ, names=names, order='degrevlex')
    equations = [ring(line) for line in (path/'equations.txt').read_text().splitlines()]
    relations = [ring(line) for line in (path/'lex.txt').read_text().splitlines()]
    ideal = ring.ideal(equations)
    basis = ideal.groebner_basis()
    assert list(basis)==list(ring.ideal(relations).groebner_basis())
    assert ideal.dimension()==0
    print(path.name, 'equal exact reduced Groebner bases; quotient length',
          ideal.vector_space_dimension(), ': PASS', flush=True)
    return ring, relations


def main():
    root = Path(sys.argv[1])
    ring, relations = check_chart(root/'open',('b0','b1','b2','b3','c','inv'))
    b0,b1,b2,b3,c,v = ring.gens()
    univariate = PolynomialRing(QQ,'a'); a = univariate.gen()
    field_polynomial = a**5+5*a**3-5*a**2+2
    translated = field_polynomial(a-2)
    assert translated.leading_coefficient() == 1
    assert all(value.denominator()==1 and value%5==0 for value in translated.list()[:-1])
    assert translated[0]%25 != 0
    print('f(a-2) =', translated, '; 5-Eisenstein: PASS', flush=True)
    quotient = univariate.quotient(field_polynomial,'theta'); theta = quotient.gen()
    old_parameter = (QQ(-9398098319100927734375)/16599265906765726789632*theta**4
        +QQ(2618115071365673828125)/16599265906765726789632*theta**3
        -QQ(1461950258083642578125)/614787626176508399616*theta**2
        +QQ(35317573887190478515625)/8299632953382863394816*theta
        +QQ(30181833237649287109375)/16599265906765726789632)
    triangular = {}
    quintics = []
    for relation in relations:
        variables = set(relation.variables())
        if variables <= {v}:
            quintics.append(univariate({e[5]:co for e,co in relation.dict().items()}))
        else:
            others = variables-{v}
            assert len(others)==1
            variable = others.pop()
            assert relation.degree(variable)==1
            coefficient = relation.monomial_coefficient(variable)
            tail = relation-coefficient*variable
            assert set(tail.variables()) <= {v}
            triangular[str(variable)] = -univariate({e[5]:co for e,co in tail.dict().items()})/coefficient
    assert len(quintics)==1 and quintics[0].degree()==5
    assert set(triangular)=={'b0','b1','b2','b3','c'}
    assert quintics[0](old_parameter)==0 and old_parameter.lift().degree()>0
    print('exact field embedding and five linear coordinate relations: PASS', flush=True)
    # Recheck all input equations at the resulting universal field-valued model.
    values = {variable:triangular[str(variable)](old_parameter)
              for variable in (b0,b1,b2,b3,c)}
    values[v]=old_parameter
    hom = ring.hom([values[x] for x in ring.gens()],quotient)
    assert all(hom(ring(line))==0 for line in (root/'open'/'equations.txt').read_text().splitlines())
    print('field-valued coefficients satisfy the original equations: PASS', flush=True)
    boundary_ring, boundary = check_chart(root/'boundary',('b1','b2','b3','c','inv'))
    u1,u2,u3,bc,bi = boundary_ring.gens()
    target = boundary_ring.ideal([u1,u2,u3,bc-QQ(27)/4,bi-QQ(4)/27])
    assert all(relation in target for relation in boundary)
    assert all(relation in boundary_ring.ideal(boundary) for relation in target.gens())
    print('boundary coordinates rational and unique: PASS', flush=True)
    (root/'field_certificate.json').write_text(json.dumps({
        'field_polynomial_ascending':[str(x) for x in field_polynomial.list()],
        'eisenstein_translate_ascending':[str(x) for x in translated.list()],
        'old_parameter_ascending':[str(x) for x in old_parameter.lift().list()],
        'conclusion':'All normalized source models are defined over Q or a degree-five field totally ramified at 5.'
    },indent=2)+'\n')


if __name__=='__main__': main()
