#!/usr/bin/env sage-python
"""Extract an actual repaired W3 displacement for the first neutral cover.

The reference obstruction is the audited genus-two C3 obstruction,
converted exactly from z=u^2/v to the Laurent-u Cech basis.  This script
solves the primary equation only; it is input preparation for W4.
"""
import argparse
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix, vector


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", required=True)
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    data = json.loads(Path(args.input).read_text())
    source = data["covers"][0]
    assert source["pair"] == [0, 1]
    P = PolynomialRing(GF(5), "a")
    k = GF(5 ** (len(data["field_modulus"])-1), "a", modulus=P(data["field_modulus"]))
    a = k.gen(); n = int(k.degree())
    decode = lambda cc: sum(k(c)*a**j for j, c in enumerate(cc))
    encode = lambda c: [int(k(c).polynomial()[j]) for j in range(n)]
    t = decode(data["parameter"])
    lam = decode(source["AS_scale"])
    assert lam**4 * (t**2+2) == 1
    rho_z = vector(k, [1+4*t+2*t**2, 1+t+t**3, t+2*t**2+2*t**3])
    # v/u = z^-3+(t+1)z^-1-(t+1)z+O(z^3), v/u^2=z^-1,
    # v/u^3=z+O(z^3).  O(z^3) is an infinity-regular tangent term.
    rho = vector(k, [rho_z[0], rho_z[1]-(t+1)*rho_z[0],
                     rho_z[2]+(t+1)*rho_z[0]])
    weights = vector(k, [3*(2*t**2+4), 3*(t+3), 3])
    assert weights.dot_product(rho) == 1/(4+4*t)
    psi = matrix(k, [[decode(v) for v in row] for row in source["hodge_matrix"]],
                 implementation="generic", sparse=False)
    assert weights * psi[:3, :3] == 0
    target = vector(k, list(rho)+[0]*27)
    columns = [j for j in source["quotient_basis"] if j < 18]
    small = psi.matrix_from_columns(columns)
    transported = small.solve_right(target)
    displacement = vector(k, 30)
    for j, value in zip(columns, transported):
        displacement[j] = value**(5**(n-1))
    assert psi*vector(k, [c**5 for c in displacement]) == target
    base_kernel = psi[:3, :3].right_kernel().basis()[0]
    base_kernel = vector(k, [c**(5**(n-1)) for c in base_kernel])
    assert psi[:3, :3]*vector(k, [c**5 for c in base_kernel]) == 0
    assert weights.dot_product(base_kernel) == 0
    kernel = vector(k, list(base_kernel)+[0]*27)
    assert psi*vector(k, [c**5 for c in kernel]) == 0
    assert base_kernel == vector(k, [1, 4, 4+t+3*t**2])
    top_scale = 2+2*t+4*t**3
    assert displacement[12:15] == lam**2*top_scale*base_kernel
    assert displacement[10] == (t+2)*lam**3
    assert displacement[0] == 4+4*t+t**3
    assert displacement[1] == 1+3*t**3
    # Hyperelliptic involution of the quotient: kappa->-kappa,
    # ell,w fixed, and eta=du/v changes sign.
    component_signs = [1, 1, 1, -1, 1, -1]
    hyp = [component_signs[j%6] for j in range(30)]
    assert all(not displacement[j] for j in range(30) if hyp[j] != 1)
    assert all(not kernel[j] for j in range(30) if hyp[j] != 1)
    assert sum(hyp[j] == 1 for j in source["quotient_basis"]) == 11
    # Express coefficients over F625 using 1,lambda,lambda^2,lambda^3.
    powers = [t**i*lam**j for j in range(4) for i in range(4)]
    coordinates = matrix(GF(5), [encode(x) for x in powers]).transpose()
    assert coordinates.rank() == 16
    human = []
    for j, value in enumerate(displacement):
        if value:
            coords = coordinates.solve_right(vector(GF(5), encode(value)))
            human.append(dict(column=j, w_power=j//6, base_index=j%6,
                              coefficients_t_lambda=[int(c) for c in coords]))
    output = dict(status="PASS", field_modulus=data["field_modulus"],
                  parameter=data["parameter"], AS_scale=source["AS_scale"],
                  rho_u=[encode(c) for c in rho],
                  particular_displacement=[encode(c) for c in displacement],
                  kernel_generator=[encode(c) for c in kernel],
                  sparse_displacement=human,
                  hyperelliptic_deformation_dimension=11,
                  scope="Actual primary repaired T3 family T3*=reference+xi, then T3(b)=T3*+b*h*ker(Psi_C). No W4 obstruction computed.")
    Path(args.output).write_text(json.dumps(output, indent=2)+"\n")
    print("rho_u =", rho)
    print("base kernel =", base_kernel)
    print(json.dumps(human, indent=2))
    print("PASS primary repair and hyperelliptic invariance")


if __name__ == "__main__":
    main()
