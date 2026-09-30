#!/usr/bin/env sage -python
"""Independent exact checks and mutual incidence of the five theta planes.

The original evidence is read externally. New output, if requested, is
written outside litt3. This script uses Sage, not the supplied field code.
"""

from itertools import combinations
from pathlib import Path
import argparse
import json

from sage.all import GF, PolynomialRing, matrix


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--data", type=Path, default=Path(__file__).resolve().parents[2].parent /
        "litt3-computation-data/focused_pro_returns_20260916/"
        "theta_package/dormant_theta_divisors/data.json")
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    data = json.loads(args.data.read_text())
    K = GF(5**15, "beta")
    pol = PolynomialRing(K, "u")
    u = pol.gen()
    alpha = (u**3 + u + 1).roots()[0][0]

    def base(code):
        return K(code % 5) + (code // 5 % 5) * alpha + (code // 25) * alpha**2

    psi = sum(base(c) * u**i for i, c in enumerate(data["psi"]))
    tau = psi.roots()[0][0]

    def value(codes, t=tau):
        return sum(base(c) * t**i for i, c in enumerate(codes))

    f = u * (u - 1) * (u - 2) * (u - 3) * (u - alpha)
    a0, a1, a2, a3, a4 = [f[i] for i in range(5)]
    W = tau**2 + 3 * a4 * tau + 3 * a3
    V = -a2 + (a4 + 2 * tau) * W
    H = 2 * u**3 + tau * u**2 + W * u + V
    even = [sum(value(c) * u**i for i, c in enumerate(row)) for row in data["even"]]
    odd = [sum(value(c) * u**i for i, c in enumerate(row)) for row in data["odd"]]
    for p in even:
        assert f*p.derivative(2)-2*f.derivative()*p.derivative()-H*p == 0
    for q in odd:
        assert f*q.derivative(2)-f.derivative()*q.derivative()+(3*f.derivative(2)-H)*q == 0
    assert even[0]*even[1].derivative()-even[0].derivative()*even[1] == 3*f**2
    assert odd[0]*odd[1].derivative()-odd[0].derivative()*odd[1] == 2*f
    A = [value(row) for row in data["A"]]
    N = [[sum(value(c)*u**i for i,c in enumerate(row)) for row in rows] for rows in data["N"]]
    for i,j in [(0,0),(0,1),(1,0),(1,1)]:
        rhs = 2*f*(even[i]*odd[j].derivative()-even[i].derivative()*odd[j])+f.derivative()*even[i]*odd[j]
        assert N[i][j](u**5) == rhs

    c = [a**5 for a in f.list()]
    R = PolynomialRing(K, names=("x0","x1","x2","x3"))
    x0,x1,x2,x3 = R.gens()
    delta = x1**2 - 4*x0*x2
    polar = c[1]*x1*x0**2 + 2*c[2]*x2*x0**2 + c[3]*x1*x2*x0 + 2*c[4]*x2**2*x0 + x1*x2**2
    constant = (c[1]**2*x0**4 - 2*c[1]*c[3]*x2*x0**3 - 4*c[1]*c[4]*x1*x2*x0**2
                - 4*c[1]*x1**2*x2*x0 + (2*c[1]-4*c[2]*c[4]+c[3]**2)*x2**2*x0**2
                - 4*c[2]*x1*x2**2*x0 - 2*c[3]*x2**3*x0 + x2**4)
    kummer = delta*x3**2 - 2*polar*x3 + constant
    planes = [list(a**(125**j) for a in A)+[K.one()] for j in range(5)]
    assert len({tuple(row) for row in planes}) == 5
    out = {"independent_section_and_wronskian_checks": True, "pairs": [], "triples": [], "four_plane_ranks": []}
    plane_ring = PolynomialRing(K,names=("a","b","c"))
    aa,bb,cc = plane_ring.gens()
    plane_quartic = kummer(aa,bb,cc,-A[0]*aa-A[1]*bb-A[2]*cc)
    fourth = plane_quartic**4
    holomorphic_indices = [(2,1,1),(1,2,1),(1,1,2)]
    hasse_witt = matrix(K,3,3,lambda i,j: fourth.monomial_coefficient(
        aa**(5*holomorphic_indices[i][0]-holomorphic_indices[j][0]) *
        bb**(5*holomorphic_indices[i][1]-holomorphic_indices[j][1]) *
        cc**(5*holomorphic_indices[i][2]-holomorphic_indices[j][2])))
    out["plane_quartic_hasse_witt_rank"] = int(hasse_witt.rank())
    out["plane_quartic_hasse_witt_invertible"] = bool(hasse_witt.det())
    for indices in combinations(range(5),4):
        rank = matrix(K,[planes[i] for i in indices]).rank()
        out["four_plane_ranks"].append({"planes":list(indices),"rank":int(rank)})
    for indices in combinations(range(5),3):
        mat = matrix(K,[planes[i] for i in indices])
        assert mat.rank()==3
        pt = mat.right_kernel().basis()[0]
        lies_on_surface = not kummer(*pt)
        out["triples"].append({"planes":list(indices),"point_on_kummer":bool(lies_on_surface)})
    binary = PolynomialRing(K,names=("s","t"))
    s,t = binary.gens()
    univariate = PolynomialRing(K,"z")
    z = univariate.gen()
    for indices in combinations(range(5),2):
        mat = matrix(K,[planes[i] for i in indices])
        assert mat.rank()==2
        v,w = mat.right_kernel().basis()
        quartic = kummer(*(v[i]*s+w[i]*t for i in range(4)))
        assert quartic.total_degree()==4
        dehom = univariate(quartic(s=z,t=1))
        infinity_mult = 4-dehom.degree()
        squarefree = dehom.gcd(dehom.derivative()).degree()==0 and infinity_mult<=1
        factors = [(int(h.degree()),int(e)) for h,e in dehom.factor()]
        lift_split = None
        if factors == [(4,1)] and infinity_mult == 0:
            residue = K.extension(dehom.monic(), "rho")
            rho = residue.gen()
            coords = [residue(v[i])*rho+residue(w[i]) for i in range(4)]
            assert coords[0]
            _,ss,pp,kk = [a/coords[0] for a in coords]
            slope_square = kk + c[2] + c[3]*ss + c[4]*ss**2 + ss**3-ss*pp
            assert slope_square
            character = slope_square**((5**60-1)//2)
            assert character in (1,-1)
            lift_split = bool(character == 1)
        out["pairs"].append({"planes":list(indices),"squarefree":bool(squarefree),
                             "affine_factors":factors,"infinity_multiplicity":int(infinity_mult),
                             "jacobian_double_splits_over_quartic_field":lift_split})
    print(json.dumps(out,indent=2))
    if args.output:
        workspace = Path(__file__).resolve().parents[2]
        target = args.output.resolve()
        assert not target.is_relative_to(workspace), "Write artifacts outside litt3"
        target.parent.mkdir(parents=True,exist_ok=True)
        target.write_text(json.dumps(out,indent=2)+"\n")


if __name__ == "__main__":
    main()
