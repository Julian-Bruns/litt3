# Audit: cored zero-form reduction and single-jump degree bound

Auditor: `/root/cored_single_jump_degree_bound_audit` (independent audit agent).
Date: 2026-09-06. Verdict: **PASS**, with the scope qualifications below.

Audited `CORED_ZERO_ONE_FORM_INTERSECTION_AND_WILD_SIGNATURE_REDUCTION.md`,
`TWO_BRANCH_SINGLE_JUMP_ORBIFOLD_ATLASES_ARE_DEGREE_BOUNDED.md`, and the
associated `TWO_BRANCH_SINGLE_JUMP_SIGNATURE_CERTIFICATE.py`.
The audited fixed-pair theorem that all pulled-back one-form spaces are
disjoint is an input; its arithmetic was not re-audited. The simultaneous
finite etale Galois envelope for cored spans is also an input; its written
construction was inspected for compatibility with this argument.

## Proof checks

- Invariant rational differentials descend across the separable Galois
  extension even in wild characteristic: the invariant subspace of
  `k(W) tensor_{k(C)} Omega_{k(C)/k}` is `Omega_{k(C)/k}`. No division by
  the group order occurs. The different formula gives precisely
  `ord_w(beta)=e ord_c(beta)+delta`; etaleness over both endpoints
  makes regular descent to them valid. Thus the intersection formula and
  `C=P1, deg D<=1` consequence are correct. For `p>=3`, a wild point
  has `delta>=e+q-2>e`, as required.
- Inertia acts freely on `G/A` since every conjugate of `A` acts freely
  on `W`. Hence `e|n` and the uniform Hurwitz formula are justified.
  The tame `42h` bound, the bounds for at least two tame points, and the
  exceptional `(wild,2,2)` divisibility obstruction are valid. In
  particular `c=sum_{i>=1}(|I_i|-1)-1` is `-1 mod (p-1)` also for mixed
  inertia. The genus-nine exception is excluded by the divisors of 16.
- A prime-to-`p` tame complement admits an eigen-uniformizer. The leading
  term of the invariant base differential has character
  `zeta^(delta+1)`, proving `t|(delta+1)`, equivalently `t|(c+1)`.
  A possible tame centralizer causes no problem: the argument never
  uses `t|(q-1)` or faithful conjugation on the wild subgroup.
- For `c=j(q-1)-1`, the integral substitution gives
  `q l=(j+1)m0+D` and `t0|(l+jD)`. Thus `l,R` are positive integers,
  `j/l=(R+1)/(R m0-D)<=D+2`, and
  `m0<=D+2l/j`. Substitution yields exactly
  `q<=D(D+2)+2D+4=(D+2)^2<=(h+2)^2`.
  Both ranges used to bound the ratio cover all positive `R`.
- The remaining finite bounds are complete. From `t0<=c+1` follows
  `m0<=q+(q+D)/(q-2)`. With integral `u=(c+1)/t0`, positivity forces
  `u m0>q`; the decreasing ratio `u/(u m0-q)` is at most `q+1`,
  proving the stated `j` bound. The divisor ranges for `t0,g0` and
  `n=(h/D)q g0 t0 m0` then cover every necessary signature.
  Here `m` is tame, so `gcd(qt,m)=gcd(t,m)` is legitimate.

## Independent numerical verification

Executed the certificate successfully: its nine reduced tuples and maximum
`n=2240` agree with the theorem. Also reconstructed the enumeration
independently by looping over `m0` first, using its individual `j` bound,
solving `t0=(c m0-D)/q`, and testing integer `g0` directly. This matches
all **24 full tuples**, with no entries for `q=25,125`. A maximizing tuple
is `(q,j,t0,m0,D,g0,n)=(5,1,4,7,1,1,2240)`. This is a numerical
possibility, not an existence certificate.

## Conclusion and scope

For jointly minimal spans, `Z=W/(A intersect B)` and
`M=[B:A intersect B]<=[G:A]=n`. Combining the signature reduction with
the verified bound proves: **every jointly minimal cored candidate for
the fixed pair with `M>2240` has exactly two branch points, one wild and
one tame, and `(q-1)` does not divide `c+1` at the wild point**.
Consequently its positive ramification filtration has more than one jump.
This uses the numerical divisibility class, which can include some
multiple-jump filtrations too; multiple jumps alone do not evade the bound.

No substantive objections or theorem corrections were found. The bound
does not assert realizability, exclude all multiple-jump cored candidates,
bound redundant source refinements, or affect coreless cases. No theorem
files were edited.
