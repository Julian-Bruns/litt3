#!/usr/bin/env sage-python
"""Independent checks possible from the returned neutral-five W4 note.

This deliberately does NOT claim to replay the producer's corrected
Hodge matrices.  It reconstructs the finite-field geometry from the audited
input model, checks the displayed target vector and the small jet test, and
records which central computation remains unavailable.
"""
import argparse
import hashlib
import json
import math
from pathlib import Path
import time

from sage.all import (GF, LaurentSeriesRing, PolynomialRing, QQ, ZZ,
                      Integers, matrix, vector)


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--model', default='Research/computations/neutral5_hyperelliptic_model.json')
    ap.add_argument('--hodge', default='Research/computations/neutral5_hyperelliptic_hodge.json')
    ap.add_argument('--output', default='Research/computations/returned_neutral5_w4_local_audit.json')
    args = ap.parse_args()
    start = time.monotonic()
    data = json.loads(Path(args.model).read_text())
    saved = json.loads(Path(args.hodge).read_text())
    fp = PolynomialRing(GF(5), 't')
    k = GF(625, 't', modulus=fp(data['field_modulus']))
    t = k.gen()
    pol = PolynomialRing(k, 's'); s = pol.gen()
    enc = lambda a: [int(k(a).polynomial()[i]) for i in range(4)]
    dec = lambda a: k(a)
    read_poly = lambda name: pol([dec(a) for a in data[name]])
    N, D = read_poly('numerator'), read_poly('denominator')
    d = read_poly('denominator_square_root')
    J = read_poly('elliptic_y_numerator')
    G = read_poly('hyperelliptic_polynomial')
    S5 = read_poly('elliptic_source_polynomial')
    H, mu, h0 = t*t+2, 4+4*t, 4*t+3
    q = N/D
    assert D == d*d
    assert J*J*S5 == N**3-t*N*N*D+N*D*D-t*D**3
    assert G == N*(N-D)*S5 and G.degree() == 13 and G.gcd(G.derivative()) == 1
    assert q.derivative()*d**5/J == -H*D

    # Reconstruct the companion coefficient directly in the actual pulled
    # differential frame; no Laurent engine or new producer data imported.
    f = -H*D
    PC = 2*q**3+(2*t+3)*q**2+(3*t*t+3)*q+2*t**3+4*t*t+4*t+4
    PT = pol(f*f*PC-(G*f.derivative(2)+G.derivative()*f.derivative()/2)/(2*f)
             +3*G*f.derivative()**2/(4*f*f))
    assert PT.degree() == 10
    n5 = N.leading_coefficient()
    double_factor = pol((N-t*D)/(n5*(s-t**5)))
    b2 = double_factor.sqrt()
    b2 /= b2.leading_coefficient()
    assert b2.degree() == 2 and N-t*D == n5*(s-t**5)*b2*b2
    K = d*b2*(N-h0*D)
    mustar = mu/(n5*H**4)
    assert mustar == 1+t+3*t*t+4*t**3
    AT = pol(H**4*D*(N-t*D)*(N-h0*D)**2/mu)
    assert (s-t**5)*K*K/mustar == AT
    logder = K.derivative()/K + 1/(2*(s-t**5))
    a_second_over_a = G*(logder.derivative()+logder*logder)+G.derivative()*logder/2
    assert a_second_over_a == PT

    def coeff(f, i):
        return f[i] if i >= 0 else k(0)
    plus = matrix(k, 11, 11, lambda i,j: coeff(AT*G**2, 5*(j+1)-(i+1)))
    minus = matrix(k, 4, 4, lambda i,j: coeff(AT, 5*(j+1)-(i+1)))
    full = matrix.block_diagonal([plus, minus])
    assert full == matrix(k, [[dec(x) for x in row] for row in saved['hodge_matrix']])
    assert (plus.rank(), minus.rank()) == (10,4)
    dual = vector(k, list(map(dec, saved['obstruction_dual'])))
    assert dual*plus == 0 and dual[0] == 1

    # The FULL first-extension map is F:H1(T_T)->H1(T_T^5), not Psi.
    # Target gaps are Y/s^i,1<=i<=31 and 1/s^i,1<=i<=24.
    first_odd = matrix(k, 31, 11, lambda i,j: coeff(G**2, 5*(j+1)-(i+1)))
    first_even = matrix(k, 24, 4, lambda i,j: k(i+1 == 5*(j+1)))
    first_full = matrix.block_diagonal([first_odd, first_even])
    assert (first_odd.rank(), first_even.rank(), first_full.rank()) == (11,4,15)

    reported_vector = [[1,3,1,3],[0,2,0,2],[0,2,1,4],[1,0,2,4],
        [3,3,4,3],[4,2,1,4],[4,2,4,1],[3,1,4,4],[2,3,4,4],
        [1,3,1,0],[1,0,2,1]]
    c4 = dual.dot_product(vector(k, list(map(dec, reported_vector))))
    assert c4 == 1+3*t**3
    assert c4*(2+4*t*t+4*t**3) == 1
    assert c4**5 == 3*t+2*t*t+t**3
    decomposition = [3+t, 4*t+t*t+2*t**3, 4*t+4*t*t+t**3, 3+t, k(0)]
    assert sum(decomposition) == c4
    assert (t*t+t**3)+(1+2*t+4*t*t+4*t**3) == 1+2*t

    # Independently Hensel-lift the unramified coefficient automorphism.
    wr = PolynomialRing(Integers(625), 'T')
    O = wr.quotient(wr(data['field_modulus']), 'T'); T = O.gen()
    Q = lambda a: a**4+4*a**3+a*a+4*a+3
    Qp = lambda a: 4*a**3+12*a*a+2*a+4
    sig = T**5
    for _ in range(4):
        sig -= Q(sig)/Qp(sig)
    getint = lambda a: [int(O(a).lift()[i]) for i in range(4)]
    assert Q(sig) == 0 and getint(sig) == [122,113,275,510]
    sigma25, power25 = [x%25 for x in getint(sig)], [x%25 for x in getint(T**5)]
    assert sigma25 == [22,13,0,10] and power25 == [12,13,0,15]

    # Reconstruct the FIRST affine Frobenius correction as polynomials,
    # then check the returned second marking via its entire extension
    # class.  This needs no long mixed-characteristic Laurent expansions.
    mixpol = PolynomialRing(O, 's'); sm = mixpol.gen()
    liftk = lambda a: sum(O(int(a.polynomial()[i]))*T**i for i in range(4))
    sigk = lambda a: sum(O(int(a.polynomial()[i]))*sig**i for i in range(4))
    Gmix = mixpol([liftk(a) for a in G])
    Gsig = mixpol([sigk(a) for a in G])
    branch_lift = liftk(t**5)
    for _ in range(4):
        branch_lift -= Gmix(branch_lift)/Gmix.derivative()(branch_lift)
    assert Gmix(branch_lift) == 0
    assert getint(branch_lift) == [572,573,260,140]
    Eraw = Gsig(sm**5)-Gmix**5
    Ecoeff = []
    for a in Eraw:
        cs = getint(a)
        assert all(x%5 == 0 for x in cs)
        Ecoeff.append(k([x//5%5 for x in cs]))
    Eerr = pol(Ecoeff)
    afrob = (-Eerr*(G.derivative()**5).inverse_mod(G**3)).mod(G**3)
    bfrob, erem = (Eerr+G.derivative()**5*afrob).quo_rem(2*G**3)
    assert erem == 0
    zeta, erem = (s**4+afrob.derivative()).quo_rem(G**2)
    assert erem == 0

    aa = (s-t**5)*K*K
    L = K.derivative()+K/(2*(s-t**5))
    bb = pol(G*(s-t**5)*L*L)
    common, pbez, qbez = aa.xgcd(bb)
    assert common == 1 and aa*pbez+bb*qbez == 1
    op_rat = K*pbez/(G*L)  # f_op=Y*op_rat, since D(j)=0 in char5.
    ref_rat = 2*(s**5*bfrob-afrob*G**2)/(2*G-s*G.derivative())**5
    xidata = [[0,2,2,2],[4,4,0,2],[4,4,3,2],[1,1,2,3],
        [2,1,2,3],[3,1,1,3],[4,3,1,2],[3,3,2,4],
        [3,4,4,1],[1,1,2,2],[1,4,3,2]]
    exponents = list(range(-11,10,2))
    xi_rat = sum(k(cs)*s**(6*j)*G**(-(j+1)//2)
                 for cs,j in zip(xidata,exponents))

    # Infinity expansion of Y*r(s): polynomial part is the ACTUAL
    # affine primitive; r coefficients s^-1,...,s^-31 are H1(T^5).
    vseries = LaurentSeriesRing(k, 'v', default_prec=300); vvar = vseries.gen()
    def infinity_expansion(r, precision=240):
        num, den = pol(r.numerator()), pol(r.denominator())
        result = vvar**(den.degree()-num.degree())
        result *= vseries(list(reversed(num.list())))/vseries(list(reversed(den.list())))
        return result.add_bigoh(precision)
    def ext_coords(r):
        vv = infinity_expansion(r)
        return vector(k,[vv[i] for i in range(1,32)])
    target_diff = mustar*op_rat-ref_rat-G**2*xi_rat**5
    assert ext_coords(target_diff) == 0
    target_laurent = infinity_expansion(target_diff)
    Qu = sum(target_laurent[i]*s**(-i) for i in range(target_laurent.valuation(),1))
    Qu = pol(Qu)
    abY = pol((s-t**5)*K*G*L)
    beta = (-PT*aa*pbez*qbez-abY*pbez*qbez.derivative()
            +bb*qbez*pbez+abY*qbez*pbez.derivative()
            -aa*pbez**2+PT*bb*qbez**2)
    flat_first = mustar*beta-(G*Qu.derivative()+G.derivative()*Qu/2)+zeta
    assert flat_first == 0

    # Independent theta-degree residue from the model and supplied B jets.
    # z=s^6/Y, v=1/s satisfies v=z^2 G_rev(v), and omega=-z*v^4 dv.
    ls = LaurentSeriesRing(k, 'z', default_prec=400); z = ls.gen()
    grev = pol(list(reversed(G.list())))
    v = ls(0)
    for _ in range(210):
        v = (z*z*grev(v)).add_bigoh(398)
    ss = 1/v
    ee = -z*v**4*v.derivative()
    assert ee.valuation() == 10
    qdual = sum((-dual[i]/2)*ss**i for i in range(11))
    dualform = qdual*ee
    B0, B2, B4 = list(map(dec, [[2,0,0,4],[4,0,1,2],[4,0,1,4]]))
    # Recover these low formal comparison coefficients from the entire
    # independently reconstructed first extension, not from the output.
    ww = (n5*n5*z*z*(ss-t**5)).sqrt()/(n5*z)
    aa_series = ww*K(ss)
    bb_series = aa_series.derivative()/ee
    ao = z**20*aa_series
    bo = z**30*bb_series
    qo = -sum(target_laurent[i]*v**(i-6) for i in range(32,150))/z**51
    BO_rebuilt = 1/bo+qo*ao/mustar
    rebuilt_B = [BO_rebuilt[i] for i in [0,2,4]]
    # The two choices of the local square root change the whole frame
    # by one common sign; the normal comparison is independent of it.
    bsign = rebuilt_B[0]/B0
    assert bsign in [k(1),k(-1)]
    assert rebuilt_B == [bsign*x for x in [B0,B2,B4]]
    Bsq = [B0*B0, 2*B0*B2, B2*B2+2*B0*B4]
    jet = [mustar*ee[10]**(-5)*x for x in Bsq]
    jet_scalar = sum(jet[i]*dualform[-6-2*i] for i in range(3))
    assert jet_scalar == 4+2*t+4*t*t+3*t**3
    assert jet_scalar+(1+2*t+3*t**3) == decomposition[2]
    assert [enc(dualform[i]) for i in [-10,-8,-6]] == [[0,4,1,4],[1,0,0,3],[3,0,3,2]]
    assert [enc(x) for x in jet] == [[2,3,1,3],[2,2,3,3],[4,2,4,4]]
    xi_series = sum(k(cs)*z**j for cs,j in zip(xidata,exponents))
    D2xi = ((xi_series.derivative()/ee).derivative()/ee)
    jet_marked = mustar*z**35*(z**5*D2xi/2)**5*BO_rebuilt**2
    jet_marked_scalar = (jet_marked*dualform)[-1]
    assert jet_marked_scalar == 1+2*t+3*t**3
    jet_full = mustar*z**35*(z**4/ee+z**5*D2xi/2)**5*BO_rebuilt**2
    assert (jet_full*dualform)[-1] == decomposition[2]

    # Exact symbolic iteration of the displayed 5-connection, with an
    # independent polynomial derivation; no guessed matrix coefficients.
    names = ['e%d'%i for i in range(9)]+['r%d'%i for i in range(9)]
    sym = PolynomialRing(QQ, names); vv = sym.gens()
    es, rs = vv[:9], vv[9:]
    def deriv(a):
        return sum(a.derivative(es[i])*es[i+1] + a.derivative(rs[i])*rs[i+1]
                   for i in range(8))
    conn = matrix(sym, [[0,-es[0]],[-25*rs[0]*es[0],0]])
    Kmat = matrix.identity(sym, 2)
    terms = []
    for n in range(1,8):
        Kmat = 5*Kmat.apply_map(deriv)+conn*Kmat
        terms.append(Kmat/math.factorial(n))
    expected = [conn,
        matrix(sym, [[25*rs[0]*es[0]**2/2,-5*es[1]/2],[0,25*rs[0]*es[0]**2/2]]),
        matrix(sym, [[0,-25*(es[2]+rs[0]*es[0]**3)/6],[0,0]])]
    def divisible125(a):
        return all(ZZ(c.numerator()).valuation(5)-ZZ(c.denominator()).valuation(5) >= 3
                   for c in a.coefficients())
    for n, mat in enumerate(terms):
        delta = mat-(expected[n] if n<3 else matrix.zero(sym,2))
        assert all(divisible125(x) for x in delta.list())
    for n in range(4,1001):
        assert n-1-ZZ(math.factorial(n)).valuation(5) >= 3

    out = dict(status='PASS_LOCAL_CHECKS_NOT_FULL_REPLAY',
        producer_source_imported=False,
        full_corrected_Hodge_matrices_replayed=False,
        supplied_final_vector_recomputed_from_geometry=False,
        field_modulus=data['field_modulus'],
        c4_pairing=enc(c4), c4_inverse=enc(1/c4), frobenius_c4=enc(c4**5),
        model_sha256=hashlib.sha256(Path(args.model).read_bytes()).hexdigest(),
        hodge_sha256=hashlib.sha256(Path(args.hodge).read_bytes()).hexdigest(),
        pulled_back_potential=[enc(a) for a in PT],
        double_b2=[enc(a) for a in b2], mu_star=enc(mustar),
        first_extension_dimensions=[55,15], first_extension_block_ranks=[11,4],
        first_extension_rank=int(first_full.rank()),
        first_extension_matrix=[[enc(a) for a in row] for row in first_full],
        hodge_block_ranks=[10,4],
        returned_first_marking_full_extension_checked=True,
        returned_first_marking_flat_connection_checked=True,
        first_affine_frobenius_degrees=[int(afrob.degree()),int(bfrob.degree())],
        first_affine_comparison_degree=int(Qu.degree()),
        first_affine_comparison_polynomial=[enc(a) for a in Qu],
        first_bezout_p=[enc(a) for a in pbez],
        first_bezout_q=[enc(a) for a in qbez],
        weighted_theta_degree_scalar=enc(jet_scalar),
        independently_reconstructed_marking_jet_scalar=enc(jet_marked_scalar),
        independently_reconstructed_full_jet_scalar=enc((jet_full*dualform)[-1]),
        dual_differential_jets=[enc(dualform[i]) for i in [-10,-8,-6]],
        supplied_B_jets=[enc(a) for a in [B0,B2,B4]],
        independently_reconstructed_B_jets=[enc(a) for a in rebuilt_B],
        reconstructed_B_common_sign=enc(bsign),
        weighted_theta_normal_jets=[enc(x) for x in jet],
        unramified_frobenius=getint(sig), sigma25=sigma25, fifth_power25=power25,
        hensel_lifted_double_branch=getint(branch_lift),
        symbolic_Taylor_checked_through=7,
        factorial_bounds_checked_through=1000,
        seconds=time.monotonic()-start,
        scope='Independent actual input geometry, full first-extension injectivity, returned-vector target arithmetic, and small jet/Taylor identities only. The unseen full higher computation is NOT certified.')
    Path(args.output).write_text(json.dumps(out,indent=2)+'\n')
    print('PASS actual potential, double normalization, and full Frobenius rank15')
    print('PASS entire returned first marking and exact flat comparison')
    print('PASS supplied vector pairing c4 =',enc(c4),'inverse =',enc(1/c4))
    print('PASS reconstructed B jets and full geometric jet residue =',enc((jet_full*dualform)[-1]))
    print('     theta-degree =',enc(jet_scalar),'marking =',enc(jet_marked_scalar))
    print('PASS unramified transport and symbolic Taylor matrix')
    print('NOT REPLAYED: central corrected Hodge matrices / fourth cocycle')
    print('Receipt:',args.output)


if __name__ == '__main__':
    main()
