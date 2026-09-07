# Exact lazy representatives for all 28,990 opers

`oper_representatives_manifest.json` contains the 18 untwisted symmetry
representatives: `orbit_0000` through `orbit_0011`, then `invariant_0`
through `invariant_5`. The normalized representatives cover 28,935 distinct
opers; the six invariant representatives cover 55. The invariant points
have multiplicity eight, giving total scheme length 29,375. Multiplicity
does not mean extra geometric points or additional exclusions.

From the repository root under Sage:

```python
exec(open('scripts/oper_representatives.sage').read())
manifest = oper_manifest()       # no finite fields constructed
op = load_oper('orbit_0001')     # only this representative constructed
k, a, R, x = (op[n] for n in ['k', 'a', 'R', 'x'])
F, A, B, C = (op[n] for n in ['F', 'A', 'B', 'C'])
```

`load()` is also supported. `folder=` can specify the computation directory
when invoked outside the repository. The returned dictionary includes
`Fcurve` (same as `F`), `C0` (same as `C`), `c4`, `alpha`, `lambda_scale`,
the 24 `coordinates`, and `metadata`. The potential is
`A + (B + 2*x**8)*y + C*y**2` on `y**3=F`; `P` contains its three
coefficients in the basis `1,y,y**2`.

The specified embedding of F25 is the returned `a`, which satisfies
`a**2+4*a+2=0`. For normalized representatives it is evaluated from the
certificate's `zeta` polynomial at the selected separator root, so no
conjugate coefficient-field component is accidentally added. The loader
reconstructs the actual oper using `c4**3=lambda_scale`, including a cubic
extension when necessary. Available cube roots are ordered by their exact
coefficient vectors for reproducibility. The first representative explicitly
uses `alpha=4*a+2,c4=3` in the cached F25 presentation; verification compares
these against `canonical_atlas_system.json`.

`k` is either an absolute finite field or a polynomial quotient field over
one. The JSON-compatible `field_description` records every tower level,
modulus, generator name and the embedded F25 generator. Coefficient lists
are in ascending powers. `encode_element(v)` serializes an element in this
same recursive convention. It is a runtime closure and should be omitted
from pickled dictionaries. The field, its generators, and all oper
polynomials are ordinary Sage objects and can be saved normally.

All twelve normalized residue degrees are prime to three, so their field
orders satisfy `q-1=3*m` with `gcd(3,m)=1`. The loader tests
`lambda_scale**m==1`; in the split case a cube root is
`lambda_scale**inverse_mod(3,m)`. Otherwise the cubic is irreducible and
defines the explicit extension. This avoids the large temporary PARI stack
used by generic polynomial factorization at degree 7,324.

By default, loading independently checks all three original differential
numerator identities and `a10=c4**2`; `original_equations_verified=True`
is set only after these checks. `verify=False` skips this step, but does
not skip construction of the actual cubic branch. High-degree polynomial
coordinates are reduced modulo the selected factor and installed as field
coefficient vectors rather than evaluated by long Horner chains.

The manifest is obtained from the completed census, without reading the
full point-by-point list, and checks the exact orbit coverage and length.
F25 Frobenius and the actual cubic deck automorphism justify this reduction
for untwisted atlas existence. The manifest and loader themselves exclude
no oper, do not compute nontrivial torsion twists, and do not solve the
common-cover problem.

Validation on 2026-09-07 under Sage 10.9: all 18 representatives passed the
original differential identities. The first 17 took 6.42 seconds together;
the degree-7,324 representative took 122.19 seconds separately. The cached
first-oper `alpha` and `c4` comparison and exact manifest equality also
passed. These are loader checks, not atlas exclusions or full-run ETAs.
