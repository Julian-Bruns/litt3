# A finite quadratic certificate controls every abelian 5-group cover

Version1,2026-09-10. Focused medium audit PASS,
/root/audit_p_cover_witt_repair. Audited prose and finite arithmetic,
not Lean verification. Use the specified higher-Hodge operator Psi
and obstruction epsilon, with relative-Frobenius twists retained.

## General quotient mechanism

Let T->C be an actual connected finite etale Galois cover of smooth
projective curves of genus at least two over bar(F5), with finite
5-group P. Pull back a specified admissible active connection and its
previous-flow data. For any normal H in P, put S=T/H. Then

    coker(Psi_S) = k[P/H] tensor_(k[P]) coker(Psi_T).

This is an isomorphism of actual deck-group modules after linearizing
Frobenius. It follows from freeness of negative tangent cohomology and
the H-norm identification, not exactness of invariants on arbitrary
modules or division by a cover degree.

## All abelian covers of the explicit pair

Let (C,r) be the genus-two/F625 pair of
[explicit_genus_two_witt_obstruction](Thm_explicit_genus_two_witt_obstruction.md).
For EVERY actual connected finite etale Galois cover h:T->C with
nontrivial abelian5-group, write

    G = Z/(5^a) x Z/(5^b),   a>=b>=0, a>=1.

These exhaust the possible abelian groups, since C has p-rank two.
The exact source defect is

    dim coker(Psi_T) = 2*5^a-1  if a=b,
                      2*5^b    if a>b.

In particular EVERY cyclic5-power cover has defect exactly two.
One degree25 calculation proves the formula for all abelian degrees:
its scalar Schur relation has a nondegenerate quadratic part with
no zero tangent direction in P1(F5). Quotient compatibility and the
formal node determine all further colengths. No higher-degree cover
enumeration is needed.

## More general vanishing, without a defect formula

For EVERY nontrivial connected finite etale cover h:T->C whose
Galois closure has a5-group as Galois group, including non-Galois h,

    epsilon(T,h*r)=0.

Nevertheless NO W3 source lift on which the original Hodge line lifts
can extend the original map T2->C2 to any marked C3. Repairing this
one source necessarily loses the original C-leg. For the abelian
covers the displayed defect is always positive, so they remain
indigenous-nonordinary as well.

No second endpoint or actual common-cover counterexample is supplied.
No main or backup common-cover case is excluded by this theorem.

[Proof and exact evidence](../Solutions/Sol_abelian_p_defect_node.md) ·
[Scoped audit](../Research/audits/ABELIAN_P_DEFECT_NODE_AUDIT_2026_09_10.md).
