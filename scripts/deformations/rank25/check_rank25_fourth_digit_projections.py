"""Exact adjoint projections of every compatible fourth curve digit.

Run with sage -python. This uses the retained finite fourth-level packet;
it is not a fifth-level geometric replay.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import argparse
import json
from pathlib import Path
import sys
import zipfile

from sage.all import GF, PolynomialRing, matrix, vector

sys.path.insert(0, str(Path(__file__).resolve().parent))
from scripts.deformations.rank25.rank25_pro_data_model import unpack


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output', type=Path, required=True)
    args = ap.parse_args()
    root = Path(__file__).resolve().parents[3]
    with zipfile.ZipFile(root/'Research/pro_inputs/rank25_all_fifth_lifts_inputs.zip') as z:
        data = unpack(json.loads(z.read('data.json')))
        fourth = unpack(json.loads(z.read('fourth.json')))
    fp = GF(5)
    pt = PolynomialRing(fp, 'T'); T = pt.gen()
    k = GF(625, 't', modulus=T**4+4*T**3+T**2+4*T+3); t = k.gen()
    def val(c):
        return sum(k(a)*t**i for i,a in enumerate(c))
    def fmt(c):
        return ''.join(str(int(c.polynomial()[i])) for i in range(4))
    M = matrix(k, [[val(c) for c in row] for row in data['hodge_matrix']])
    N = matrix(k, [[val(c) for c in row] for row in data['kernel_basis']]).transpose()
    lam = matrix(k, [[val(c) for c in row] for row in data['obstruction_dual_rows']])
    assert M.rank() == 66 and N.rank() == lam.rank() == 9
    assert M*N.apply_map(lambda c:c**5) == 0 and lam*N == 0 and lam*M == 0
    ell = M.transpose().solve_right(lam.apply_map(lambda c:c**5).transpose()).transpose()
    assert ell*M == lam.apply_map(lambda c:c**5)
    A = ell*N
    # Independent Y variables are the coefficient-Frobenius images of X.
    P = PolynomialRing(k, names=['Y'+str(i) for i in range(9)])
    y = P.gens()
    def polynomial_vector(block):
        n = len(block['constant'])
        r = vector(P, [val(c) for c in block['constant']])
        for i,col in enumerate(block['frobenius']):
            r += y[i]*vector(P, [val(c) for c in col])
        for i,j,col in block['quadratic']:
            r += y[i]*y[j]*vector(P, [val(c) for c in col])
        return r
    F = polynomial_vector(fourth['obstruction'])
    W = polynomial_vector(fourth['normal_on_candidates'])
    normal_ord = matrix(k, [[val(c) for c in row] for row in fourth['normal_on_candidates']['ordinary']]).transpose()
    assert normal_ord == N[:,:7]
    assert all(not val(c) for row in fourth['obstruction']['ordinary'] for c in row)
    V = ell.change_ring(P)*W
    # The candidate plane has Y7=Y8=0, Y5=r Y6.
    r = val((0,2,2,4))
    subst = dict(zip(y, [*y[:5],r*y[6],y[6],P(0),P(0)]))
    Fc = vector(P, [f.subs(subst) for f in F])
    Vc = vector(P, [v.subs(subst) for v in V])
    assert all(not Fc[i] for i in [0,3,4,5,6,7,8])
    I = P.ideal(Fc[1],Fc[2],y[5]-r*y[6],y[7],y[8])
    reduced = [I.reduce(v) for v in Vc]
    ordinary = A[:,:7]
    # Prove a displayed relation in the lower ideal coefficientwise when possible.
    monomials = sorted(set().union(*(set(v.monomials()) for v in [Fc[1],Fc[2],*Vc])),key=str)
    cols = matrix(k, [[f.monomial_coefficient(m) for f in [Fc[1],Fc[2]]] for m in monomials])
    relations = []
    for j,v in enumerate(Vc):
        rhs=vector(k,[v.monomial_coefficient(m) for m in monomials])
        try:
            co=cols.solve_right(rhs)
            assert co[0]*Fc[1]+co[1]*Fc[2] == v
            relations.append([fmt(c) for c in co])
        except ValueError:
            relations.append(None)
    def pol_terms(p):
        return [{'exponents':list(map(int,e)), 'coefficient':fmt(c)} for e,c in sorted(p.dict().items())]
    out = {
        'status':'PASS: finite fourth-digit projection identities; not a fifth obstruction',
        'field':'F5[t]/(t^4+4t^3+t^2+4t+3)',
        'equation':'For M zeta^[5]=R4(X,Y), (Lambda zeta)^[5] = A X + V(Y).',
        'ordinary_matrix_all9':[[fmt(c) for c in row] for row in A],
        'ordinary_matrix_on_candidates':[[fmt(c) for c in row] for row in ordinary],
        'ordinary_rank_on_candidates':int(ordinary.rank()),
        'quadratic_remainder_mod_fourth_ideal':[pol_terms(p) for p in reduced],
        'constant_F4_1_F4_2_combinations':relations,
        'adjoint_rows':[[fmt(c) for c in row] for row in ell],
        'full_V_on_candidate_plane':[pol_terms(v) for v in Vc],
        'zero_projected_rows_on_fourth_locus':[i for i in range(9) if not any(ordinary[i]) and not reduced[i]],
        'warning':'Inverse Frobenius on a geometric parameter is not the finite-field power125. These identities determine ordinary fourth-digit contributions only.'
    }
    args.output.write_text(json.dumps(out,indent=2)+'\n')
    print(json.dumps({k:v for k,v in out.items() if k not in ['adjoint_rows','full_V_on_candidate_plane']},indent=2))


if __name__ == '__main__':
    main()
