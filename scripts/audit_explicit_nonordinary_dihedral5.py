#!/usr/bin/env sage-python
"""Independent finite-Laurent-quotient audit of the fifteen D10 examples.

No import of the producer or CurveAlgebra. Infinity boundary columns are
formed in a finite monomial window, row-reduced globally, and used as one
quotient projection. All 30-by-30 matrix entries are compared with the
certificate, in addition to ranks and the two actual AS charts.
"""
import argparse
from itertools import combinations
import hashlib
import json
from math import comb
from pathlib import Path
import time

from sage.all import GF, PolynomialRing, matrix, vector


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("certificate")
    parser.add_argument("--output", required=True)
    parser.add_argument("--lower-bound", type=int, default=-20)
    parser.add_argument("--fitting-reference", default="Research/computations/explicit_nonordinary_dihedral5_fitting.json")
    args = parser.parse_args()
    started = time.monotonic()
    raw = Path(args.certificate).read_bytes()
    data = json.loads(raw)
    fitting_raw = Path(args.fitting_reference).read_bytes()
    fitting_reference = {tuple(row["pair"]):row for row in json.loads(fitting_raw)["rows"]}
    prime = PolynomialRing(GF(5), "z")
    modulus = prime(data["field_modulus"])
    assert modulus.degree() == 16 and modulus.is_irreducible()
    k = GF(5**16, name="a", modulus=modulus)
    decode = lambda cs: k(prime(cs))
    encode = lambda value: [int(k(value).polynomial()[i]) for i in range(16)]
    t = decode(data["parameter"])
    assert t**4 + 4*t**3 + t**2 + 4*t + 3 == 0 and t**625 == t
    assert t**5 != t and t**25 != t
    ring = PolynomialRing(k, "u")
    u = ring.gen()
    F = u*(u-1)*(u-2)*(u-3)*(u-t)
    A = (u-t)*(u-(4*t+3))**2/(4+4*t)
    assert (4+4*t)*(3+4*t+4*t**2+3*t**3) == 1
    small_decode = lambda cs: sum((k(c)*t**i for i,c in enumerate(cs)), k.zero())
    small_poly = lambda cs: ring([small_decode(c) for c in cs])
    branch = [k(0), k(1), k(2), k(3), t, None]
    # component numbers are bits for kappa and ell.
    gaps = [(3,-1), (3,-2), (3,-3), (2,-1), (1,-1), (2,-2)]
    low = args.lower_bound
    assert low <= -20
    results = []
    seen = set()

    def fitting(operator):
        # Independently multiply the successively twisted matrices on the
        # right. The producer instead left-multiplies a twisted accumulated
        # product. This audit applies the operation to the newly reconstructed
        # geometric matrix, not merely to the saved entries.
        product = matrix.identity(k, operator.nrows())
        factor = operator
        ranks = [operator.nrows()]
        for _ in range(operator.nrows()+1):
            product = product*factor
            factor = factor.apply_map(lambda coefficient:coefficient**5)
            ranks.append(int(product.rank()))
            if ranks[-1]==ranks[-2]:
                break
        assert ranks[-1]==ranks[-2]
        drops = [ranks[j]-ranks[j+1] for j in range(len(ranks)-1)]
        blocks = {str(j+1):drops[j]-drops[j+1] for j in range(len(drops)-1)
                  if drops[j]!=drops[j+1]}
        return {"iterate_ranks":ranks,"nilpotent_blocks":blocks,
                "nilpotent_dimension":operator.nrows()-ranks[-1],
                "bijective_dimension":ranks[-1]}

    for saved in data["covers"]:
        pair = tuple(saved["pair"])
        assert pair in set(combinations(range(6),2)) and pair not in seen
        seen.add(pair)
        R = ring.one()
        for index in pair:
            if branch[index] is not None:
                R *= u-branch[index]
        S, rem = F.quo_rem(R)
        assert rem == 0 and R.is_squarefree() and S.is_squarefree() and R.gcd(S)==1
        assert R == small_poly(saved["R"]) and A == small_poly(saved["A"])
        poles = [0, R.degree(), S.degree(), 5]
        bounds = [(-2-pole)//2 for pole in poles]
        assert bounds == [-1,-2,-3,-4]
        actual_gaps = [(comp,e) for comp in range(4) for e in range(bounds[comp]+1,0)]
        assert set(actual_gaps)==set(gaps) and len(actual_gaps)==6
        H = (S**2)[4]
        lam = decode(saved["AS_scale"])
        assert H and H == decode(saved["elliptic_Hasse"]) and H*lam**4 == 1
        square = S**2
        fu = ring([lam**5*square[i] for i in range(5,square.degree()+1)])
        fo = {i-5: -lam**5*square[i] for i in range(4) if square[i]}
        # Full actual-chart equality: chi^5-chi = fU-fO.
        expected = [dict() for _ in range(4)]
        expected[2] = {-1: lam}
        actual = [{int(e): decode(co) for e,co in part.items()} for part in saved["shift"]]
        assert actual == expected
        expected[2] = {int(e): co for e,co in fu.dict().items() if co}
        actual = [{int(e): decode(co) for e,co in part.items()} for part in saved["affine_rhs"]]
        assert actual == expected
        expected[2] = fo
        actual = [{int(e): decode(co) for e,co in part.items()} for part in saved["infinity_rhs"]]
        assert actual == expected
        assert all(2*e+S.degree()<=0 for e in fo)

        # Finite cochain window: exponent >= low+j in w-degree j.
        # Multiplication by chi^(j-l) keeps this inequality at w-degree l.
        coh = [(j,comp,e) for j in range(5) for comp,e in gaps]
        allcoords = [(j,comp,e) for j in range(5) for comp in range(4)
                     for e in range(low+j,0)]
        boundarycoords = sorted(set(allcoords)-set(coh), key=lambda a: (-a[0],a[1],a[2]))
        coords = boundarycoords+coh
        position = {key:i for i,key in enumerate(coords)}
        boundary_count = len(boundarycoords)
        assert len(coords)-boundary_count==30

        def add_poly(result, power, comp, shift, poly):
            for exponent,coefficient in poly.dict().items():
                exponent = int(exponent)+shift
                if exponent>=0 or not coefficient:
                    continue # actual affine coboundary
                key = (power,comp,exponent)
                assert key in position, (pair,key,low)
                index = position[key]
                value = result.get(index,k.zero())+coefficient
                if value:
                    result[index]=value
                else:
                    result.pop(index,None)

        # Boundary vector of kappa^a ell^b u^e (w-chi)^j.
        relations = []
        for j,comp,e in boundarycoords:
            assert e<=bounds[comp]
            aa,bb = comp&1, (comp>>1)&1
            row = {}
            for power in range(j+1):
                r = j-power
                target = aa+2*((bb+r)%2)
                polynomial = k(comb(j,power))*(-lam)**r*S**((bb+r)//2)
                add_poly(row,power,target,e-r,polynomial)
            assert row.get(position[(j,comp,e)])==1
            relations.append(row)

        # Global RREF of the entire infinity-boundary matrix. The pivot
        # block is upper unitriangular in this ordering. This is not the
        # producer's per-coefficient descending Cech split.
        rref = []
        for pivot,row in enumerate(relations):
            assert min(row)==pivot
            rref.append(dict(row))
        for pivot in range(boundary_count-1,-1,-1):
            row = rref[pivot]
            for other in sorted(i for i in row if pivot<i<boundary_count):
                coefficient = row.pop(other,k.zero())
                if coefficient:
                    for index,value in rref[other].items():
                        if index==other:
                            continue
                        entry = row.get(index,k.zero())-coefficient*value
                        if entry:
                            row[index]=entry
                        else:
                            row.pop(index,None)
            assert set(i for i in row if i<boundary_count)=={pivot}

        def project(row):
            answer = vector(k,[0]*30)
            for index,coefficient in row.items():
                if index>=boundary_count:
                    answer[index-boundary_count]+=coefficient
                else:
                    for target,value in rref[index].items():
                        if target>=boundary_count:
                            answer[target-boundary_count]-=coefficient*value
            return answer

        assert all(not project(row) for row in relations)
        assert matrix(k,[project({boundary_count+i:k.one()}) for i in range(30)])==1
        columns = []
        for j,comp,e in coh:
            aa,bb = comp&1,(comp>>1)&1
            row = {}
            # Actual Frobenius in the AS algebra: w^5=w+ell*fu.
            for power in range(j+1):
                r = j-power
                target = aa+2*((bb+r)%2)
                polynomial = (k(comb(j,power))*A*R**(2*aa)*S**(2*bb+(bb+r)//2)*fu**r)
                add_poly(row,power,target,5*e,polynomial)
            columns.append(project(row))
        psi = matrix(k,columns).transpose()
        saved_matrix = matrix(k,[[decode(co) for co in row] for row in saved["hodge_matrix"]])
        assert psi == saved_matrix
        signs = [(-1)**((comp&1)+((comp>>1)&1)+j) for j,comp,e in coh]
        invariant = [i for i,s in enumerate(signs) if s==1]
        assert len(invariant)==15 and invariant==saved["quotient_basis"]
        tau = matrix.diagonal(k,signs)
        sigma = matrix(k,30,30,lambda i,j:
                       k(comb(j//6,i//6)) if i%6==j%6 and i//6<=j//6 else k.zero())
        assert sigma**5==1 and tau**2==1 and tau*sigma*tau==sigma**4
        assert psi*tau==tau*psi and psi*sigma==sigma*psi
        double = psi[:6,:6]
        base = double[:3,:3]
        assert base.rank()==2
        quotient = psi.matrix_from_rows_and_columns(invariant,invariant)
        anti = [i for i in range(30) if i not in invariant]
        fitting_data = {"base":fitting(base),"double":fitting(double),
                        "closure":fitting(psi),"quotient":fitting(quotient),
                        "antiquotient":fitting(psi.matrix_from_rows_and_columns(anti,anti))}
        assert fitting_data=={key:fitting_reference[pair][key] for key in fitting_data}
        defects = (6-double.rank(),30-psi.rank(),15-quotient.rank())
        assert defects==tuple(saved[key] for key in ["double_defect","closure_defect","degree5_defect"])

        # A nonzero base obstruction-cokernel class, chosen without any
        # higher-Witt formula, spans the same line as the inherited epsilon.
        rep = next(vector(k,[int(i==j) for i in range(3)]) for j in range(3)
                   if vector(k,[int(i==j) for i in range(3)]) not in base.column_space())
        pulled = vector(k,list(rep)+[0]*27)
        pulled_t = vector(k,[pulled[i] for i in invariant])
        killed_w = psi.augment(matrix(k,pulled).transpose()).rank()==psi.rank()
        killed_t = quotient.augment(matrix(k,pulled_t).transpose()).rank()==quotient.rank()
        assert killed_w==killed_t
        assert killed_t
        nil = sigma-matrix.identity(k,30)
        image_dimensions = [int(psi.augment(nil**j).rank()-psi.rank()) for j in range(6)]
        assert image_dimensions[0]==defects[1] and image_dimensions[-1]==0
        at_least = [image_dimensions[j]-image_dimensions[j+1] for j in range(5)]+[0]
        smith_lengths = [j for j in range(1,6) for _ in range(at_least[j-1]-at_least[j])]
        assert sum(smith_lengths)==defects[1]
        if pair!=(4,5):
            assert defects==(1,2,1) and killed_t
        else:
            assert defects==(2,8,4)
        encoded = [[encode(value) for value in row] for row in psi.rows()]
        results.append({"pair":list(pair),"double_defect":int(defects[0]),
                        "closure_defect":int(defects[1]),"degree5_defect":int(defects[2]),
                        "cochain_dimension":len(coords),"boundary_rank":boundary_count,
                        "quotient_dimension":30,"invariant_dimension":15,
                        "all_900_entries_match":True,"base_cokernel_pullback_zero":bool(killed_t),
                        "cyclic_cokernel_smith_lengths":smith_lengths,
                        "semilinear_fitting":fitting_data,
                        "matrix_sha256":hashlib.sha256(json.dumps(encoded,separators=(",",":")).encode()).hexdigest()})
        print(json.dumps(results[-1]),flush=True)
    assert seen==set(combinations(range(6),2))
    result={"status":"PASS independent finite Laurent-quotient audit",
            "certificate_sha256":hashlib.sha256(raw).hexdigest(),"lower_bound":low,
            "fitting_reference_sha256":hashlib.sha256(fitting_raw).hexdigest(),
            "field_degree":16,"covers":results,"seconds":time.monotonic()-started,
            "scope":"Actual two-chart AS identities and all cohomology entries/ranks. Higher-Witt conclusion uses the separately audited base obstruction and naturality."}
    Path(args.output).write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps({key:result[key] for key in ["status","seconds"]}),flush=True)


if __name__=="__main__":
    main()
