"""Small-field actual maximal elementary-abelian cover and W3 repair space.

Run with sage -python. The nonsplit additive equations keep all coefficients
in F625. This computes primary data only, not a fourth obstruction.
"""
import argparse
import ast
import hashlib
import itertools
import json
import time
from pathlib import Path

from sage.all import *


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--precision", type=int, default=220)
    ap.add_argument("--output", type=Path)
    ap.add_argument("--cyclic-input", type=Path, default=Path(__file__).resolve().parents[3]/"Research/computations/cyclic5_small_field_fourth_inputs.json")
    args = ap.parse_args()
    started = time.monotonic()
    helper = (Path(__file__).resolve().parents[3] / 'scripts/deformations/cyclic/cyclic5_witt_obstruction.sage')
    definitions = [n for n in ast.parse(helper.read_text()).body
                   if isinstance(n, ast.FunctionDef) and n.name in ("setup", "laurent_coefficient")]
    assert len(definitions) == 2
    exec(compile(ast.Module(body=definitions, type_ignores=[]), str(helper), "exec"), globals())
    p = PolynomialRing(GF(5), "t0"); t0 = p.gen()
    k = GF(625, "t", modulus=t0**4+4*t0**3+t0**2+4*t0+3); t = k.gen()
    pr, u, F, ls, z, uf, vf, reduce0 = setup(k, t, args.precision)
    enc = lambda c: [int(k(c).polynomial()[i]) for i in range(4)]
    encv = lambda v: [enc(c) for c in v]
    encm = lambda a: [encv(row) for row in a]
    chi = [z**-3, z**-1]
    # Column j of H1(O)-Frobenius contains the coefficients of chi_j^5.
    fm = matrix(k, 2, 2, lambda i, j: laurent_coefficient(reduce0(chi[j]**5)[0], [-3,-1][i]))
    hh = fm.transpose()
    assert hh.det()
    qs, tails = [], []
    rat = pr.fraction_field()
    rational_chi = [rat(F/u**6), rat(1/u**2)]  # chi_i = v * rational_chi_i
    for j in range(2):
        rem = chi[j]**5 - sum(hh[j,i]*chi[i] for i in range(2))
        q = pr(0)
        for ex in range(int(rem.valuation()), 1):
            c = laurent_coefficient(rem, ex)
            if c:
                assert ex <= -5 and ex % 2 == 1
                power = (-ex-5)//2
                q += c*u**power
                rem -= c*vf*uf**power
        assert rem.valuation() >= 1
        tail = F**2*rational_chi[j]**5 - sum(hh[j,i]*rational_chi[i] for i in range(2)) - q
        assert tail.numerator().degree() - tail.denominator().degree() <= -3
        assert (vf*tail(uf)-rem).valuation() > 15
        qs.append(q); tails.append(tail)
    rhs = [vf*q(uf) for q in qs]
    indices = list(itertools.product(range(5), repeat=2))
    positions = {ab:i for i,ab in enumerate(indices)}
    descending = sorted(indices, key=lambda ab:(sum(ab),ab), reverse=True)
    orders = [-3,-1,1]
    translations = {ab:[(positions[i,j], binomial(ab[0],i)*binomial(ab[1],j)
                          *(-chi[0])**(ab[0]-i)*(-chi[1])**(ab[1]-j))
                        for i in range(ab[0]+1) for j in range(ab[1]+1) if (i,j)!=ab]
                    for ab in indices}

    def reduce_vector(values):
        values = list(values)
        for ab in descending:
            pos = positions[ab]
            rem, _ = reduce0(values[pos])
            assert rem.precision_absolute() > 3*sum(ab)+2
            canonical = sum(laurent_coefficient(rem, ex)*z**ex for ex in orders)
            tail = rem-canonical
            assert tail.valuation() >= 2
            for dest, multiplier in translations[ab]:
                values[dest] -= multiplier*tail
            values[pos] = canonical
        return vector(k, [laurent_coefficient(values[pos],ex) for pos in range(25) for ex in orders])

    def multiply(a, b):
        result = {}
        for ij, c in a.items():
            for kl, d in b.items():
                ab = (ij[0]+kl[0],ij[1]+kl[1])
                result[ab] = result.get(ab,ls(0))+c*d
        while any(max(ab)>=5 for ab in result):
            ab = max((ab for ab in result if max(ab)>=5), key=lambda x:(sum(x),x))
            c = result.pop(ab)
            if not c: continue
            j = 0 if ab[0]>=5 else 1
            base = (ab[0]-5*(j==0),ab[1]-5*(j==1))
            result[base] = result.get(base,ls(0))+c*rhs[j]
            for ell in range(2):
                dest = (base[0]+(ell==0),base[1]+(ell==1))
                result[dest] = result.get(dest,ls(0))+c*hh[j,ell]
        return {ab:c for ab,c in result.items() if c}

    frob = [{(0,0):rhs[j],(1,0):ls(hh[j,0]),(0,1):ls(hh[j,1])} for j in range(2)]
    powers = [[{(0,0):ls(1)}] for j in range(2)]
    for j in range(2):
        for exponent in range(1,5):
            powers[j].append(multiply(powers[j][-1],frob[j]))
    aC = (uf-t)*(uf-(4*t+3))**2/(4+4*t)
    cols = []
    for aa,bb in indices:
        image = multiply(powers[0][aa],powers[1][bb])
        for ex in orders:
            cols.append(reduce_vector([aC*z**(5*ex)*image.get(ab,ls(0)) for ab in indices]))
    psi = matrix(k, cols).transpose()
    assert psi.rank() == 66
    rho = vector(k, [1+4*t+2*t*t,1+t+t**3,t+2*t*t+2*t**3]+[0]*72)
    small = [3*positions[ab]+i for ab in indices if sum(ab)<=2 for i in range(3)]
    small_solution = psi.matrix_from_columns(small).solve_right(rho)
    repair5 = vector(k,75)
    for i,c in zip(small,small_solution): repair5[i]=c
    repair = repair5.apply_map(lambda c:c**125)
    kernels = matrix(k,[row.apply_map(lambda c:c**125) for row in psi.right_kernel().basis()])
    assert kernels.nrows()==9 and kernels.rank()==9
    assert psi*repair.apply_map(lambda c:c**5)==rho
    assert psi*kernels.apply_map(lambda c:c**5).transpose()==0
    assert all(c==0 or sum(indices[i//3])<=4 for row in kernels for i,c in enumerate(row))
    kernel_filtration = []
    for degree in range(9):
        selected = [3*positions[ab]+i for ab in indices if sum(ab)<=degree for i in range(3)]
        kernel_filtration.append(len(selected)-psi.matrix_from_columns(selected).rank())
    # Adapt coordinates to the known cyclic plane and then total AS degree.
    # This gives two new directions at each degree1,2,3,4, in addition to
    # the pulled-back base kernel. The origin is the audited cyclic repair.
    cyclic_bytes=args.cyclic_input.read_bytes()
    cyclic=json.loads(cyclic_bytes)
    decode=lambda v:sum(k(c)*t**i for i,c in enumerate(v))
    embed=matrix(k,75,15)
    for j in range(5):
        for i in range(j+1):
            for ex in range(3):
                embed[3*positions[i,j-i]+ex,3*j+ex]=binomial(j,i)*t**(j-i)
    psi5=matrix(k,[[decode(c) for c in row] for row in cyclic["hodge_matrix"]])
    assert psi*embed.apply_map(lambda c:c**5)==embed*psi5
    repair=embed*vector(k,[decode(c) for c in cyclic["primary_repair"]])
    assert psi*repair.apply_map(lambda c:c**5)==rho
    adapted=[embed*vector(k,[decode(c) for c in cyclic[name]]) for name in ["kernel_b","kernel_d"]]
    degrees=[0,1]
    for degree in range(1,5):
        selected=[3*positions[ab]+i for ab in indices if sum(ab)<=degree for i in range(3)]
        for row in psi.matrix_from_columns(selected).right_kernel().basis():
            candidate=vector(k,75)
            for i,c in zip(selected,row):candidate[i]=c**125
            if matrix(k,adapted+[candidate]).rank()>len(adapted):
                adapted.append(candidate);degrees.append(degree)
    kernels=matrix(k,adapted)
    assert degrees==[0,1,1,2,2,3,3,4,4]
    assert kernels.rank()==9 and psi*kernels.apply_map(lambda c:c**5).transpose()==0
    # Ordinary function trace is the constant Jacobian det(H) times the
    # coefficient of w1^4*w2^4; it is zero on all other reduced monomials.
    trace = matrix(k,3,75,lambda i,j:hh.det() if j==72+i else 0)
    base = psi[:3,:3]
    assert trace*psi == base*trace.apply_map(lambda c:c**5)
    dualC = vector(k,[3*t*t+t+1,3*t+4,3])
    dualrows = [dualC*trace]
    assert dualrows[0] != 0 and dualrows[0]*psi == 0
    for row in psi.left_kernel().basis():
        if matrix(k,dualrows+[row]).rank()>len(dualrows): dualrows.append(row)
    assert len(dualrows)==9
    # Recover the old cyclic quotient exactly: w=w1+t*w2.
    H=3*t*t+t+3
    assert vector(k,[1,t**5])*hh == H*vector(k,[1,t])
    q_old=qs[0]+t**5*qs[1]
    expected=pr([t*t+4*t+2,3*t*t+3*t+3,3*t*t+4*t+1,t*t+4*t+3,3*t+3,1])
    assert q_old==expected
    result={"status":"PASS actual rank25 cover and complete primary repair space; W4 not computed",
            "precision":args.precision,"coefficient_modulus":[3,4,1,4,1],
            "coefficient_basis":["1","t","t^2","t^3"],"source_genus":26,
            "H1_O_frobenius":encm(fm),"additive_matrix":encm(hh),
            "equations":"w_i^5-sum_j additive_matrix[i][j]*w_j=v*Q_i(u)",
            "shifts_z_exponents":[-3,-1],"affine_Q_coefficients":[encv(q) for q in qs],
            "regular_tails":[{"numerator":encv(q.numerator()),"denominator":encv(q.denominator())} for q in tails],
            "basis_indices":[[int(i),int(j),ex] for i,j in indices for ex in orders],
            "basis_convention":"z^ex*w1^i*w2^j*eta^-1; lexicographic(i,j), ex=-3,-1,1",
            "hodge_matrix":encm(psi),"hodge_convention":"Psi(v)=M*v^[5]",
            "base_reference_rho":encv(rho),"primary_repair":encv(repair),
            "kernel_basis":encm(kernels),"kernel_dimension_by_total_AS_degree":[int(x) for x in kernel_filtration],
            "kernel_basis_total_AS_degrees":degrees,
            "plane_origin":"Pullback of the supplied audited cyclic T3(0,0)",
            "embedded_cyclic_plane":"x2=...=x8=0; x0=b and x1=d",
            "obstruction_dual_rows":encm(matrix(k,dualrows)),"trace_matrix":encm(trace),
            "trace_top_monomial":enc(hh.det()),"old_cyclic_quotient":"w=w1+t*w2",
            "fourth_locus_unknown":True,"seconds":time.monotonic()-started,
            "source_sha256":hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            "helper_sha256":hashlib.sha256(helper.read_bytes()).hexdigest()}
    result["cyclic_input_sha256"]=hashlib.sha256(cyclic_bytes).hexdigest()
    if args.output: args.output.write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps({key:result[key] for key in ["status","additive_matrix","affine_Q_coefficients","kernel_dimension_by_total_AS_degree","seconds"]},indent=2))


if __name__ == "__main__":
    main()
