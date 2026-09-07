# Cyclic cubic low Abel torsion — independent audit

- Verdict: PASS, with the hypothesis clarifications below.
- Auditor: `/root/audit_cubic_torsion`, fresh bounded independent agent.
- Date: 2026-09-07, 20:08 CEST.
- Scope: version 1 of [the statement](../../Theorems/Thm_cyclic_cubic_low_abel_torsion.md),
  its [proof](../../Solutions/Sol_cyclic_cubic_low_abel_torsion.md), and
  [the short certificate](../../scripts/check_cubic_low_abel_torsion.sage).
- Verification: independent mathematical prose audit, source-proof check,
  and exact Sage certificate rerun; not formal proof verification.
- Blocking objections: none under the intended arithmetic meaning of
  an F_q-defined cyclic cover, including its deck generator.

The low-degree uniqueness argument is valid, including repeated points.
After taking the second difference, finite divisor orbits imply
semisimplicity over Q. The remaining rho-invariant difference has zero
coefficients at every ramification point. A nonzero positive part must
therefore contain a full unramified cubic fiber. The degree-three boundary
forces both effective divisors to be full fibers and hence the zero
Jacobian class. No reduced-support hypothesis is needed.

The ramification subgroup is the full kernel of lambda. Sending x(O) to
infinity, the eigenfunction argument shows that the only relation modulo
3 among the n-1 finite branch classes is the nonzero Kummer valuation
vector. Their span has dimension n-2=g. The relation lambda^2=-3rho gives
an etale kernel of size 3^g, so there is no missing kernel component.
Uniqueness then proves the stated count of degree-three branch classes.

The integral calculation uses the actual Tate module correctly. It is
free of rank g over Z_3[zeta_3]. Since the residue degree is one,
v_3(det_Z3) equals v_lambda(det_R), giving exactly a and b as written.
The unit Bezout identity between U and V bounds the inverse of UV by
lambda^max(a,b); adding the denominator exponents would be unnecessary.
No integral companion model or invertibility of the first Frobenius term
is assumed.

[Boxall--Grant, Proposition 2.3(iii) and its proof](https://boxall.pages.math.cnrs.fr/pages-web-mathematiques-de-john-boxall/wwwMaths/SingularFinal.pdf)
apply to the Jacobian over the finite field: a nonfixed three-primary
point has a power-conjugate differing by nonzero rational 3-torsion.
That power fixes the difference, producing the prohibited second
difference. The proof does not require arbitrary W_r points to be almost
rational, or require the subgroup of three-primary points to lie in W_r.

The certificate rerun passed: branch degrees [1,1,4,4], D=4, determinant
valuations 10 and 30, a=1, b=2, field degree 12, lambda exponent 5, integer
annihilator 27, and 276 order-dividing-three classes. The Weil polynomial
is an inherited arithmetic input; this bounded audit did not recompute it.

Nonblocking wording clarifications: rho must itself be F_q-defined (or
the Frobenius used must commute with rho); a merely geometrically cyclic
map over F_q is insufficient for the integral argument. The phrase
"powers of Frobenius" in part 1 means powers fixing the ramification
points individually, as its preceding hypothesis requires. The divisor
action is the linear extension of a permutation of geometric points.
These conditions hold for rho and the powers pi^(3D m) actually used.

No absence of orders 9 or 27 and no common-cover exclusion is established.
Any later application must still retain both actual finite etale maps
from the same smooth projective source.

Audited statement SHA256:
`7de9b9ac618dc962c76358333cdae623df0cc09fd1d2a7231fb6df26ef39fc7f`.
Audited proof SHA256:
`ff4082fbeff2bf370bc13f50e28b0c57d122bf4b66d9ec4d17684bab19cb4484`.
