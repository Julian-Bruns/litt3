# Completed-local global package: major independent audit

Verdict: **PASS (prose audit).**

Auditor: `/root/completed_local_global_major_audit`.
Date: 2026-09-06.

Scope: `Theorems/Thm_completed_local_orbifold_rigidity.md` and
`Solutions/Sol_completed_local_orbifold_rigidity.md`, all seven proof
sections. No breaking objection or required mathematical correction was
found. This is not formal verification and does not solve Litt3.

The statements of `hermitian_local_normality` and
`finite_jet_local_normality` were read and their separately audited
conclusions accepted as dependencies. Their old audit bodies were not
opened. The effective-orbifold definition and the statement of
`fixed_x_two_branch_bound` were also checked. The latter supplies the
full lower filtration for the two large alternatives; the application
does not recover a local action merely from inertia and different.

## 1. Completed extensions and normalized groupoids

A Galois closure in the finite-etale category over an actual stack atlas
is legitimate here. Its connected covering scheme remains finite etale
over the original smooth projective scheme atlas. Over algebraically
closed residue fields, completion of such a cover at a chosen point is
an isomorphism. A quotient presentation therefore identifies each atlas
completion over the coarse field with a Galois inertia extension.
This also verifies independence of the point in a coarse fiber and of
the atlas.

For two connected atlases with matching fixed-base completed extensions,
every generic field factor of their coarse fiber product dominates both
atlases. Normalization thus gives finite surjections on every component.
Locally the common Galois field satisfies
`L tensor_K L = product_(Gal(L/K)) L`. Normalizing the corresponding
complete local rings leaves copies of the same DVR. Normalization and
completion commute in this setting of excellent curves. Consequently
both projections are unramified, hence finite etale, including at the
wild points. This step retains actual maps from a single smooth
projective component.

For the resulting common atlas D, each `R_i=D x_(S_i) D` is a scheme
finite etale over D and hence normal. The map to `D x_B D` is finite and
generically identifies the full separable relation: effectiveness gives
trivial generic stabilizer. The source has no components supported over
closed points because it is finite etale over D. Thus each R_i is exactly
the normalization of the reduction of the same coarse fiber product.
Their identification preserves source and target. The identity, inverse,
and composition laws agree generically and hence everywhere: the domains
of these comparisons are reduced and the targets separated. This
recovers the stack, rather than merely its coarse curve or its cover
category. Neither non-effective gerbes nor undevelopable branch data
are inadvertently included.

## 2. Scalar alignment and Hermitian signatures

The accepted fixed-target local theorem gives the series `a F_t` with
the stated residual root-of-unity ambiguity. With wild value zero and
tame value infinity, a global coordinate scaling supplies precisely the
remaining scalar freedom. It preserves the two branch locations; the
tame extension remains unique up to fixed-base isomorphism. Hence
uniqueness over k follows from the completed-data result. The argument
does not claim uniqueness over an already rigidly identified coarse
coordinate without aligning its scalar.

The primary source was read directly:
[Montanucci–Zini, Section 2](https://arxiv.org/pdf/1804.03398), printed
pages 2–3. It supports the PGU rational-point stabilizer of order
`q^3(q^2-1)` and its PSU intersection of index `gcd(3,q+1)`.
For q=5 the orders, orbit length 126, and complements 8 and 24 agree
with the proof. The explicit Sylow-five action fixes no affine point
for any nonidentity element; Sylow conjugacy excludes further wild
orbits. Its rational invariant gives the rational coarse quotient.

The local different sums are `1143=999+124+5*4` and
`3143=2999+124+5*4`. Substitution in Riemann–Hurwitz gives total tame
defects 6/7 and 20/21. Since each tame short orbit contributes at least
1/2, exactly one occurs, with order 7 or 21. Thus actual Hermitian
quotients realize both relevant completed-local types. Subgroup
inclusion induces the asserted degree-three finite etale stack map.

## 3. The genus-two quotient

The displayed matrices preserve the Fermat Hermitian form and have
determinant one. They commute projectively, and generate an independent
pair of elements of order three, so A lies in PSU and has order nine.
The three r-functions are fixed by the diagonal element and cyclically
permuted by S; both a and b are invariant.

The cubic discriminant is indeed `-a^6/4+5a^3-27`, reducing to
`a^6+3` in characteristic five. This squarefree sextic defines a smooth
genus-two double cover. The 18 intersections with the coordinate lines
are distinct simple poles of a with no numerator cancellation. Thus
`[k(H):k(a)]=18`, and the invariant double-cover field has index nine
in k(H). This degree is prime to five, so the map is separable.
Riemann–Hurwitz gives zero total different, proving that H to Q' is
etale, independently verifying freeness of A.

The norm-circle Mobius transformation correctly sends all six points
of `P^1(F_5)` to `a^6=2`: its ratio has norm one and the scalar beta has
norm two. This identifies the hyperelliptic branch sets, hence their
double covers over algebraically closed k. Q is therefore an actual
scheme atlas of both quotient stacks.

## 4. The genus-five bi-etale example and scope

The three Kummer classes are independent. The six branch points have
inertia the individual sign changes, including infinity, whose inertia
changes u_1 alone. Riemann–Hurwitz gives genus five. The even-sign
subgroup of order four and the simultaneous-sign subgroup of order two
both intersect every inertia group trivially. Their respective
quotients therefore give actual etale maps of degrees four and two.

For the second quotient, the projective ratios of the u_i satisfy the
stated smooth diagonal quartic. Writing `v=u_2/u_1`, `w=u_3/u_1`
recovers `t=2/(w^2-v^2)`, so those ratios generate the fixed field of
the simultaneous sign change. This verifies the claimed quotient
identification, not just a map into the quartic. Over k the quartic is
isomorphic to the Fermat quartic.

The three elliptic character factors have nonzero Hasse coefficients
3, 2, 3. Their decomposition gives ordinarity of F. The four
Cartier–Manin entries for Q all vanish, giving superspeciality.
Combining common covers uses finite-etale fiber products over Q, so
both endpoint maps still come from the same smooth projective curve.

No conclusion is drawn that the fixed genus-nine X is an atlas, that
every curve commensurable with Q is an atlas, or that the small cored
and coreless cases have been excluded. These limits are correctly
preserved in both statement and proof.
