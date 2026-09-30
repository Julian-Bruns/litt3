"""Scoped audit of the prose-only September 14 fixed-line increment return.

Reconstructs characteristic-five primary data and checks conditional field
arithmetic. It does NOT evaluate the canonical-reference coefficients or
construct a mixed-characteristic fifth numerator.
"""
import argparse
import contextlib
import hashlib
import io
import json
import pickle
import subprocess
import sys
import zipfile
from pathlib import Path

from audit_w4_existence_polynomial import add, inv, mul, neg, power


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("engine", type=Path,
                        help="Previously audited replay_family directory")
    parser.add_argument("output", type=Path)
    parser.add_argument("--primary-packet", type=Path,
                        help="Preserved nu39 packet directory, with source/")
    args = parser.parse_args()
    sys.path.insert(0, str(args.engine.resolve()))
    import primary
    import schur

    # This pickle is the locally regenerated, previously audited data, not
    # an unreviewed serialized attachment. Recheck all primary entries now.
    with (args.engine / "schur.pkl").open("rb") as stream:
        data = pickle.load(stream)
    with contextlib.redirect_stdout(io.StringIO()):
        fresh = primary.compute()
    for key in ("MC", "PU", "PO", "chis", "FU", "A"):
        assert fresh[key] == data[key], key

    mono_index = schur.MONIDX
    ell100 = [row[mono_index[(1, 0, 0)]] for row in data["ell"]]
    assert ell100 == [0, 85, 85, 48, 0, 0]
    assert [row[0] for row in data["ell"]] == [1, 0, 0, 0, 0, 0]

    source = []
    for row in data["a"]:
        transported = schur.pmul(row, data["nus"][39])
        terms = {}
        for exponent, coefficient in zip(schur.MONS, transported):
            if not coefficient:
                continue
            # Original-deck inverse coefficient Frobenius, THEN act on Top.
            coefficient = mul(power(coefficient, 25),
                              power(3, 3 * exponent[0] + exponent[2]))
            for degree in exponent:
                for j in range(degree):
                    coefficient = mul(coefficient, 4 - j)
            terms[tuple(4 - j for j in exponent)] = coefficient
        source.append(terms)
    assert source == [{(1, 0, 0): 2}, {(0, 0, 0): 45},
                      {(0, 0, 0): 59}, {(0, 0, 0): 94}, {}, {}]
    assert power(5, 25) == 44 and power(44, 5) == 5

    # Whole first primitive, reconstructed with the earlier Laurent engine.
    n0 = {(1, -1): 1}
    constant_primary = primary.lmul(fresh["A"], primary.lfrob(n0))
    normal0, S_U, S_O = primary.project(constant_primary)
    assert normal0 == [0] * 6
    assert S_U == {(1, 0): 119, (1, 1): 36, (1, 2): 83, (1, 3): 36}
    assert S_O == {(1, -2): 36}
    assert fresh["FU"][0] == {(2, 0): 2, (2, 1): 35}
    T = primary.lscale(primary.lmul(fresh["FU"][0], constant_primary), 4)
    for coefficient, normal_index in ((112, 1), (11, 2), (36, 3)):
        monomial = {primary.NM[normal_index]: 1}
        T = primary.ladd(T, primary.lscale(primary.lmul(
            fresh["A"], primary.lfrob(monomial)), coefficient))
    correction = primary.lscale(primary.lmul(fresh["chis"][0], S_O), 4)
    normal, R_U, R_O = primary.project(primary.ladd(T, correction))
    assert normal == [0] * 6
    assert R_U == {(3, h): value for h, value in enumerate(
        (59, 99, 97, 70, 38, 82, 88, 104, 86, 37))}
    assert R_O == {(3, h - 12): value for h, value in enumerate(
        (99, 113, 117, 81, 46, 39, 5, 28, 14))}
    # In W_U coordinates, W_O=W_U-chi. Both coefficients of the
    # whole normal identity vanish, not merely its cohomology projection.
    assert primary.lsub(primary.lsub(primary.lscale(constant_primary, 4),
                                    primary.lscale(S_U, 4)),
                        primary.lscale(S_O, 4)) == {}
    assert primary.ladd(primary.lsub(primary.lsub(T, R_U), R_O),
                        correction) == {}
    assert all(h >= 0 for _, h in S_U.keys() | R_U.keys())
    assert all(h <= primary.BOUND[component]
               for component, h in S_O.keys() | R_O.keys())

    packet_receipt = None
    if args.primary_packet:
        packet = args.primary_packet.resolve()
        archive = packet / "nu39_primary_reconstruction.zip"
        source_path = packet / "source" / "primary.py"
        replay = subprocess.run([sys.executable, str(source_path)],
                                check=True, capture_output=True, text=True)
        assert replay.stdout == (packet / "source" / "verification.txt").read_text()
        with zipfile.ZipFile(archive) as archive_file:
            unpacked = sum(member.file_size for member in archive_file.infolist())
        packet_receipt = {
            "archive": str(archive), "compressed_bytes": archive.stat().st_size,
            "uncompressed_bytes": unpacked,
            "archive_sha256": hashlib.sha256(archive.read_bytes()).hexdigest(),
            "source_sha256": hashlib.sha256(source_path.read_bytes()).hexdigest(),
            "replayed_stdout_matches_receipt": True,
            "independent_earlier_engine_reconstruction_agrees": True,
            "scope": "Actual source and whole first repair only; no W4 or W5 reconstruction",
        }

    # These are implications of the reported alpha,beta,omega, NOT an
    # independent computation of those actual reference values.
    b12, b15, b16 = add(34, 64), add(6, 111), add(15, 100)
    b11 = add(103, neg(mul(34, b12)))
    p = add(add(55, 90), 124)
    matrix = [add(x, y) for x, y in ((64, 67), (81, 68),
                                    (2, 38), (8, 67))]
    a, b, c, d = matrix
    assert add(mul(a, d), neg(mul(b, c))) == 58
    ell1 = mul(add(mul(c, 17), neg(mul(d, 57))), inv(58))
    ell2 = mul(add(mul(b, 57), neg(mul(a, 17))), inv(58))
    conditional = dict(b11=b11, b12=b12, b15=b15, b16=b16,
                       p=p, ell1=ell1, ell2=ell2)
    assert list(conditional.values()) == [122, 93, 117, 115, 119, 74, 58]
    assert add(57, add(mul(a, ell1), mul(c, ell2))) == 0
    assert add(17, add(mul(b, ell1), mul(d, ell2))) == 0

    # Consistency of the printed E4(B0) and regular-free difference.
    reported = {(1, 1, 1): 9, (1, 2, 0): 66, (3, 0, 0): 24,
                (1, 3, 1): 46, (1, 4, 0): 115, (3, 1, 1): 59,
                (3, 2, 0): 77, (3, 3, 1): 34, (3, 4, 0): 16}
    difference = {(1, 1, 1): 21, (1, 2, 0): 89, (3, 0, 0): 6,
                  (1, 3, 1): 120, (3, 1, 1): 85, (3, 2, 0): 31}
    total = {e: add(reported.get(e, 0), difference.get(e, 0))
             for e in reported.keys() | difference.keys()}
    assert all(not value for e, value in total.items() if sum(e) < 5)
    degree5 = ((0, 4, 1), (1, 3, 1), (1, 4, 0), (2, 2, 1),
               (2, 3, 0), (3, 1, 1), (3, 2, 0), (4, 1, 0))
    assert [total.get(e, 0) for e in degree5] == [0, 16, 115, 0, 0, 19, 108, 0]

    # Verify R0 after clearing A^2, using D=v*d/du and v^2=F.
    def du(poly):
        assert all(component == 0 for component, _ in poly)
        return {(0, degree - 1): mul(value, degree % 5)
                for (_, degree), value in poly.items() if degree % 5}

    A = fresh["A"]
    F = primary.lmul(primary.R, primary.S)
    Ap = du(A)
    D2A = primary.ladd(primary.lmul(F, du(Ap)),
                      primary.lscale(primary.lmul(du(F), Ap), 3))
    R0 = {(0, 3): 2, (0, 2): 20, (0, 1): 19, (0, 0): 21}
    numerator = primary.ladd(primary.lscale(primary.lmul(D2A, A), 3),
                            primary.lmul(F, primary.lmul(Ap, Ap)))
    assert numerator == primary.lmul(R0, primary.lmul(A, A))

    hashes = {name: hashlib.sha256((args.engine / name).read_bytes()).hexdigest()
              for name in ("field.py", "primary.py", "schur.py", "schur.pkl")}
    result = {
        "result": "PASS_scoped_not_fifth_obstruction",
        "source": "User-pasted increment return plus subsequent nu39-primary-only packet",
        "engine": str(args.engine.resolve()), "engine_sha256": hashes,
        "fresh_primary_and_whole_primitive_reconstruction": True,
        "schur_row_100": ell100,
        "n_nu39": "2*(kappa/u)*W1 + [45]*v/u + [59]*v/u^2 + [94]*v/u^3",
        "inverse_frobenius_of_t": 44,
        "special_fibre_oper_potential_verified": True,
        "whole_first_hodge_repair_verified": True,
        "nu39_primary_packet": packet_receipt,
        "conditional_seed_coefficients": conditional,
        "printed_reference_extraction_arithmetic_consistent": True,
        "nil_scalar_rank": 82, "full_primary_rank": 707,
        "unverified_reference_claims": {"alpha": 1, "beta": 0,
                                        "omega1": 57, "omega2": 17},
        "actual_reference_reconstructed_in_this_audit": False,
        "actual_fifth_numerator_or_increment_computed": False,
    }
    args.output.write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps({key: result[key] for key in (
        "result", "conditional_seed_coefficients", "schur_row_100",
        "nil_scalar_rank", "full_primary_rank")}, indent=2))


if __name__ == "__main__":
    main()
