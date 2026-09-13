# Proof: the affine branch set and its invariant

[Statement](../../Theorems/genus_two/prime_field_branch_family.md).

The branch divisor is F_p∪{a}, with infinity unbranched, so Hurwitz
gives genus (p−1)/2≥2. The hyperelliptic quotient is therefore intrinsic.
An isomorphism C_a≅C_b induces a projectivity of the branch sets.
At least p−1≥4 rational branch points have rational images; three
distinct source–image pairs force the projectivity into PGL₂(F_p).
It then preserves F_p, fixes the missing rational point infinity,
and has the form x→ux+v. Conversely this affine map carries the
branch divisors to each other, hence lifts to the quadratic covers
over k. Its stabilizer of any a∉F_p is trivial. Only the hyperelliptic
involution remains, including for quadratic parameters.

The affine group acts freely on the nonrational parameter line.
Its invariant I is complete: if I(a)=I(b), then
b^p−b=u(a^p−a) for some u∈F_p^×, whence b−ua∈F_p.
The degree-p(p−1) polynomial I has nonzero derivative off F_p,
so it also gives the finite etale quotient of the parameter line
minus F_p by this free affine action.

For q=p^e, the invariant identifies the moduli return period with
m=[F_q(I(a)):F_q], which divides d=[F_q(a):F_q]. At the first return
there is a unique affine γ with a^(q^m)=γa. It commutes with
q-Frobenius, so a^(q^(mj))=γ^j a. Freeness of the action gives
d=m ord(γ). A nonidentity translation has order p, while an affine
map with linear coefficient u≠1 is conjugate to x→ux and has order
dividing p−1. This proves the orbit formula and both bounds.

For Y_t, the coordinate x=1/(u−4) sends its five constant branch
points to F₅ and the moving point to a=1/(t−4). It preserves all
parameter field degrees. The previous conclusions now apply with p=5.
The twenty elements of F₂₅\F₅ form one free affine orbit, proving
the quadratic-parameter assertion. The remaining smooth rational
parameter t=4 has all six branch points rational; the same three-pair
argument prevents it from being isomorphic to a nonrational member.
It therefore contributes a separate one-parameter class.

The [bounded audit](../../Research/audits/PRIME_FIELD_BRANCH_FAMILY_AUDIT_2026_09_13.md)
checks the branch-set classification, quadratic boundary and Frobenius
period formula. No curve-cover construction is inferred from the
quotient of the parameter line.
