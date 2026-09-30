# Small local certificate for the fixed genus-nine endomorphism field.
# Run with Sage; write the generated receipt outside litt3.
import argparse
import json
from pathlib import Path

parser = argparse.ArgumentParser()
parser.add_argument("--output", required=True)
args = parser.parse_args()

R.<z> = PolynomialRing(GF(5))
k.<a> = GF(25, modulus=z^2+4*z+2)
S.<x> = PolynomialRing(k)
codes = [11,22,18,5,19,20,15,16,9,22,1]
F = S([k(c % 5)+k(c//5)*a for c in codes])
assert F.degree() == 10 and gcd(F,F.derivative()) == 1
F3 = F^3
co = lambda f,i: f[i] if i >= 0 else k(0)
A = matrix(k,6,3,lambda j,i: co(F3,5*j+4-i)^5)
B = matrix(k,3,6,lambda i,j: co(F,5*i+4-j)^5)
frob = lambda M: M.apply_map(lambda c:c^5)
C = block_matrix(k,[[zero_matrix(k,3,3),B],[A,zero_matrix(k,6,6)]])
C2 = C*frob(C)
expected_A = [[1,19,21],[24,11,6],[1,20,10],[13,17,13],[24,14,23],[18,7,22]]
expected_B = [[12,21,11,6,18,0],[6,20,14,13,9,12],[0,0,0,0,1,6]]
code = lambda c: int(int(c.polynomial()[0])+5*int(c.polynomial()[1]))
encode = lambda M: [[code(c) for c in row] for row in M.rows()]
assert encode(A)==expected_A and encode(B)==expected_B
assert A.rank()==B.rank()==3 and C.rank()==C2.rank()==6
assert (B*frob(A)).det()==3*a
cp = C2.charpoly()
T = cp.parent().gen()
assert cp == T^3*(T+1)^2*(T^4+T^3+3*T^2+3)
phi = z^4+z^3+3*z^2+3
rem = power_mod(z,25,phi)-z
assert rem % phi == z^3+2*z+1
assert 2*z^2*phi+(3*z^3+3*z^2+3*z+1)*(z^3+2*z+1)==1
assert phi.is_irreducible()
data = {
    "field": "F5[a]/(a^2+4a+2); code c0+5*c1 = c0+c1*a",
    "source_coefficients_ascending": [int(c) for c in codes],
    "cartier_A": encode(A), "cartier_B": encode(B),
    "rank_C": int(C.rank()), "stable_rank_C": int(C2.rank()),
    "det_B_A5_code": code((B*frob(A)).det()),
    "charpoly_C2": str(cp),
    "unit_quartic_mod5": str(phi),
    "unit_quartic_irreducible": True,
    "frobenius_polynomial_mod5": "T^12*(T+1)^2*(T^4+T^3+3*T^2+3)",
    "scope": "Cartier/local arithmetic only; geometric simplicity is an established separate input."
}
out = Path(args.output).resolve()
if Path.cwd().resolve() in out.parents:
    raise ValueError("The receipt must be outside the litt3 workspace")
out.parent.mkdir(parents=True,exist_ok=True)
out.write_text(json.dumps(data,indent=2)+"\n")
print("PASS: exact Cartier blocks, stable rank6, simple unit quartic of degree4")
print(out)
