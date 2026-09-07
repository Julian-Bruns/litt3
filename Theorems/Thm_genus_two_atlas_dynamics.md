# Complete small atlas scheme: a Frobenius map and33 simple solutions

Use the actual genus-two atlas oper on C:v^2=t^6+3 in
`hermitian_genus_two_test`, with the audited coordinates in
[the intrinsic tensor note](../Research/GENUS_TWO_INTRINSIC_TENSOR.md).
Fix tau=O and the specified j0. Write a^2+4a+2=0 over F25.

The entire normalized intrinsic atlas scheme has33 distinct geometric
points, each of multiplicity1. There are15 F25-rational points and six
closed points of degree3 over F25. No other geometric solutions occur.
Its11 projective extension directions are the fixed points of the
purely inseparable-degree-five, separable-degree-two morphism

    [x:y] -> [Q1(x^5,y^5):Q2(x^5,y^5)],
    Q1(X,Y)=aX^2-2XY+Y^2,
    Q2(X,Y)=(a+1)X^2+(-a+2)XY+2aY^2.

The coordinate phi(z)=((a+1)z+3a+4)/(z+a+4) conjugates this morphism
to w->w^10. Thus the directions correspond explicitly to0,infinity,
and the nine roots of w^9=1. Each has three normalized lifts.

The [lossless export](../Research/computations/genus_two_intrinsic_solutions.json)
and proof give all33 solutions by two one-variable root choices and
explicit coordinate formulas. The calculation checks all original13
equations in the full33-dimensional solution algebra. It does not rely
on the unfinished general solver certificate.

Status: independent completion audit PASS,2026-09-07,
`/root/genus_two_dynamics_completion_audit`; no material objections.
The underlying intrinsic coefficient implementation also passed a
separate audit. [Completion audit metadata](../Research/audits/GENUS_TWO_ATLAS_DYNAMICS_AUDIT_2026_09_07.md)
is reference-only. These are
normalized solutions for one fixed oper and j0, not a claim of33
pairwise nonisomorphic unmarked curves or covers. This excludes no
common cover for the fixed genus-nine/genus-twenty-five pair.
[Proof](../Solutions/Sol_genus_two_atlas_dynamics.md).
