"""Read-only exact trace tests on the already computed D10 benchmarks.

Run with sage -python. This changes normalization via actual pullback of a
quadratic differential; it does not rerun or independently certify the W4
geometric computation. All source files are hashed in the receipt.
"""
import argparse
import hashlib
import json
from pathlib import Path

from sage.all import GF, PolynomialRing


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("directory", type=Path)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    p = PolynomialRing(GF(5), "t0")
    t0 = p.gen()
    k = GF(625, "t", modulus=t0**4 + 4*t0**3 + t0**2 + 4*t0 + 3)
    t = k.gen()
    r = PolynomialRing(k, "s")
    s = r.gen()
    hashes = {}

    def read(path):
        raw = path.read_bytes()
        hashes[str(path.relative_to(args.directory))] = hashlib.sha256(raw).hexdigest()
        return json.loads(raw)

    def elt(v):
        return sum(k(c)*t**i for i, c in enumerate(v))

    def poly(v):
        return r([elt(c) for c in v])

    def rat(v):
        return poly(v["numerator"]) / poly(v["denominator"])

    def out(v):
        return [int(v[i]) for i in range(4)]

    mu = 4 + 4*t
    rows = []
    for model_path in sorted((args.directory / "models").glob("pair_*.json")):
        label = model_path.stem
        result_path = args.directory / "census" / label / "genus6_fourth_result.json"
        if not result_path.is_file():
            continue
        data = read(model_path)
        result = read(result_path)
        q = poly(data["numerator"]) / poly(data["denominator"])
        f = rat(data["eta_multiplier"])
        # phi_C=Q(u)*eta^2, h*eta=f(s)*omega. The Serre pairing with
        # (Y/s^i)*omega^-1 is -2 times the coefficient of s^(i-1).
        pulled = (q*q + (t+3)*q + 2*t*t + 4)*f*f
        assert pulled.denominator() == 1
        pulled = r(pulled)
        assert pulled.degree() <= 10
        trace_row = [-2*pulled[i] for i in range(11)]
        dual = [elt(c) for c in data["obstruction_dual"]]
        scale = next(trace_row[i]/dual[i] for i in range(11) if dual[i])
        assert all(trace_row[i] == scale*dual[i] for i in range(11))
        rho = [elt(v) for v in result["rho4_vector"]]
        value = sum(a*b for a, b in zip(trace_row, rho))
        assert value == scale*elt(result["c4"])
        row = {"label": label, "trace_scale": out(scale), "trace_value": out(value),
               "ratio_to_base_epsilon": out(mu*value),
               "equals_three_times_base": value == 3/mu}
        rows.append(row)
        print(label, "ratio", out(mu*value), flush=True)
    assert len(rows) == 14
    receipt = {"scope": "Exact normalization/trace of saved geometric W4 results, not a new full replay or general trace theorem",
               "hypothesis_test": "Tr_h epsilon_T = 3 epsilon_C",
               "all_pass": all(x["equals_three_times_base"] for x in rows),
               "rows": rows, "input_sha256": hashes}
    if args.output:
        args.output.write_text(json.dumps(receipt, indent=2) + "\n")


if __name__ == "__main__":
    main()
