# Proof: tame branch orders create a genuine etale twisted tangent

[Statement](../Theorems/Thm_radical_quadratic_atlas_obstruction.md).
Author /root,2026-09-08. Numerical coefficients below are in char5;
valuation exponents are ordinary rational/integer numbers.

## 1. The torsion line and the actual cover

On C form the rational 2N-differential

    Q=f^(Na)(f-1)^(Nb)(df)^(2N).

Tameness and the stipulated complete branch profiles give

    div(Q)=N E, E=m0 D0+m1 D1+minf Dinf.

There are no other zeros or poles: outside those fibers f is etale.
Thus chi=O(E)omega^(-2) has its Nth power trivialized by Q. Its
prime-to5 Kummer torsor pi:T->C is finite etale, possibly disconnected.
On it Q has a tautological quadratic root q, with div(q)=pi^*E. It is
regular and nonzero on every component. Equivalently q is the regular
quadratic with the finite character chi on C. Keeping the full torsor
avoids a mistaken full-degree connectedness assertion.

Over a separable radical field on P1, write w=t^a(t-1)^b. Then
w''/w=r. The inverse construction for quadratic differentials in char5
says that q=q_z(dz)^2 determines the rational projective connection
q_z''/q_z. Indeed under t=t(z), q_z=t'^2 q_t, and differentiating twice
gives the Schwarzian transformation r_z=t'^2 r_t-{t,z}/2. Therefore
q defines the pullback of the SAME rational r on C. Scalar deck
multiplication of q does not change it, so it descends to r_C.

Dormancy r''-3r^2=0 is preserved by separable coordinate pullback,
hence holds rationally on T and C. At a zero of q of order m, write
q_z=z^m u with u a unit. The double-pole coefficient of q_z''/q_z is
m(m-1), zero by the hypothesis on m. A remaining nonzero simple pole
c/z would give the nonzero term2c/z^3 in r_C''-3r_C^2, whereas the
square term has order at most2. Thus that pole cannot occur either.
The connection is regular everywhere, including infinity. Its defining
identity q_z''-r_C q_z=0 is exactly a nonzero twisted dormant tangent.
The coordinate covariance is also proved directly in
[tangent_bundle_cyclic_refinements](Sol_tangent_bundle_cyclic_refinements.md),Section1.

This argument only imposes conditions on an ACTUAL tame map. When
used for a common orbifold obtained from two etale legs, neither leg
has been discarded or presumed Galois.

## 2. The two signatures

For(2,4,8), choose(a,b)=(-1,-5/4). The three orders are(0,1,0),
and r=2/t^2 with r''=3r^2. Hence chi^4=O and div(q)=pi^*D1.

For(2,3,9), choose(a,b)=(-1,-4/3). The orders are(0,0,1), and

    r=2/[t^2(t-1)^2],       r''=3r^2.

Here chi^3=O and div(q)=pi^*Dinf. On a genus-two source the zero
divisor has degree4, giving the indicated map degrees16 and36.
No existence of these maps is inferred from their numerical profiles.

## 3. Complete cubic Bol calculation on the backup

The audited backup atlas construction already fixes complete joint
Frobenius representatives for all five dormant opers and81 cubic
characters. We reuse only their fields, oper parameters and torsion
divisors, NOT any claimed implication from atlas emptiness to a tangent.
For a nontrivial class write L=O(D-2O), D=(U,v-V), and h=v-A, where
div(h)=3D-6O, A mod U=V and A^2-F=A3^2 U^3. On z^3=h,

    q=z*f*(du/v)^2,       f in <1,u,(v+V)/U>.

This is the COMPLETE character space: div(z)=D-2O and
div((du/v)^2)=4O, so f ranges over L(D+2O), of dimension3 by
Riemann--Roch. The three displayed functions have the required poles
and are independent. They remain valid at O and at both sheets over U;
U is squarefree and coprime to F in the complete cubic census.

Use rational pairs a(u)+v b(u), with v^2=F and v'=F'/(2v). Set

    ell=h'/(3h)-F'/F.

After dividing out z/F, Bol_r(q) has coefficient

    f''+2ell f'+(ell'+ell^2-r)f.

Clearing its common denominator gives a matrix with three columns.
[The checker](../scripts/backup_genus_two_cubic_tangents.sage) reconstructs
it exactly for the four nontrivial joint representatives. It checks the
original oper equation, actual divisor/norm identities and exact torsion
Frobenius periods8,24,24,24. The oper period is5 and coprime to these,
so their joint sizes40,120,120,120 exhaust400 pairs. Each matrix has a
saved invertible3x3 minor, including an explicit inverse determinant.

[Certificate](../Research/computations/backup_genus_two_cubic_tangents.json).
Construction2.368 seconds onONE core. The --verify mode reconstructs
all coefficients and checks the saved minors WITHOUT rank, roots,
kernel or Groebner calculations. The trivial character's five kernels
already vanish by the complete reduced dormant census.

The J[4] assertion uses the previous complete16 two-torsion and240
exact-order-four tests recorded in
[the backup proof packet](../Research/BACKUP_CANDIDATE.md), including
the independent21.41-second replay of all1,200 order-four cases.
Their geometric character-basis proof is the same finite-valuation
argument; their audit status is AUTHOR, not inherited from the separate
Hermitian-atlas audit. No new large computation is needed.
