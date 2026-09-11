# Audit: dormant decoration for the primitive degree84 survivors

- Verdict: PASS for the new multiplier, regular dormant decoration,
  and exclusion of the THREE primitive survivors, under the stated
  existing finite-census and complete dormant-scheme inputs.
- Auditor: `/root/audit_triangle237_dormant_decoration`, fresh bounded agent.
- Date: 2026-09-10.
- Target: [root argument](../../Solutions/Sol_triangle237_dormant_orbit_obstruction.md).
- Scope: prose and exact algebra audit; not Lean verification or a
  degree84-wide/common-cover exclusion.

## Proof checks

The multiplier uses the orbit of the normalized COVER class. If a
Frobenius power returns the cover, it returns its source moduli point,
so its exponent is a multiple of s. The displayed F_(p^s) model then
identifies both sources with C, and the cover isomorphism is a geometric
automorphism of C. Functoriality and trivial automorphism action force
the corresponding power of Frob_(p^s) to fix the decoration. A single
h-cycle therefore forces sh to divide every positive return exponent.
No descent of the cover's field of moduli is required.

The base potential has zero full rank-two p-curvature. Its transformation
is the projective-connection rule of the canonical conventions. More
explicitly, for u=f' and S=-u''/(2u)+3u'^2/(4u^2), characteristic five
gives

    E(u^2 R(f)+S)=u^4 E(R)(f),   E(R)=R''-3R^2.

This uses D^5 f=0 for a separating-coordinate derivation, which holds
on the separable function field. Thus the construction is dormant on
the generic point before local regularity is considered.

At each branch point, a tame index e permits an actual completed
uniformizer z with the base uniformizer equal to z^e. The double-pole
coefficient is 2e^2+(e^2-1)/4, zero for e=2,3,7. The possible simple
pole contributes order e-2, which is nonnegative. Inversion at infinity
has zero Schwarzian and gives the same base double-pole coefficient.
The COMPLETE uniform fibers ensure that there are no index-one points
over the three poles. Elsewhere the map is etale. Consequently this is
a global regular projective connection and a genuine dormant oper class.

The assignment is defined over F5 and respects coefficient conjugation
and pullback by source isomorphisms. The three distinct branch indices
fix the normalized target labels, so the simultaneous-conjugacy cover
equivalence used in the census introduces no further target quotient.
An isomorphism of covers yields equality of the induced projective
connections after source pullback. One must retain the oper reduction;
an arbitrary isomorphism of the underlying unfiltered flat bundles is
not the equivalence relation used here.

On a genus-two hyperelliptic curve, the three quadratics eta^2,u eta^2,
u^2 eta^2 form a basis and are all fixed by the hyperelliptic involution.
Its affine action on the torsor of regular projective connections is
therefore a translation. Squaring the involution gives twice that
translation, so it vanishes in characteristic five. With the accepted
Aut(C_alpha)=C2 input, every geometric automorphism fixes all five
dormant points. No choice of theta characteristic alters this statement
about intrinsic projective connections.

The accepted moduli period3 and dormant period5 therefore force at
least15 distinct cover classes. Primitivity is preserved by coefficient
conjugation, as are the existing source exclusions. The one-cover tame
specialization input preserves the permutation action and its block
systems. Hence every conjugate of a proposed primitive cover lies in
the bucket of only three classes46,55,90. This is the required
contradiction; neither identification with PSL2(F83) nor simultaneous
lifting of two maps is used.

## Actual independent checks

One short Sage invocation completed in1.50seconds and verified:

- the displayed rational expression for r0, E(r0)=0, and zero full
  fifth iterate of the companion connection;
- the universal Schwarzian covariance identity above in a rational
  jet ring with D^5 f=0;
- regularity for all nine combinations of the three branch charts and
  indices2,3,7: the exact pullback valuations are0,1,5 respectively;
- irreducibility and squarefreeness of the quoted dormant separator
  over the specified F125 model.

The complete five-point dormant scheme, the branch-set moduli and
automorphism inputs, and the previously replayed155-class census were
read in the relevant canonical records/proofs and accepted as inputs.
The huge character sum and all42 monodromy-order computations were not
repeated. Existing audit bodies and unrelated cyclic-descent arguments
were not opened.

## Objections and limits

No blocking mathematical objection. For the abstract multiplier,
explicitly require the cover to be over bar(F_p), or assume its
Frobenius orbit finite: defining C over a finite field alone does not
make arbitrary cover coefficients algebraic. The application is already
over bar(F5), so this clarification does not change its conclusion.

For citation precision, `Sol_tangent_bundle_cyclic_refinements.md`
Section1 directly checks Bol covariance. The full p-curvature formula
and intrinsic E(dt)^4 are in `Sol_nilpotent_scalar_model.md` Section1;
the independent identity above also supplies the needed covariance.

The42 hyperelliptic-factor classes remain unexcluded. Their total size
need not be divisible by15, and their common group order supplies no
further partition. The original common-cover problem remains unsolved.
