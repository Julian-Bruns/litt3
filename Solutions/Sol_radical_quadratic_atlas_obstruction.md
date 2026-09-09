# Proof: tame branch orders create a genuine etale twisted tangent

[Statement](../Theorems/Thm_radical_quadratic_atlas_obstruction.md).
Author /root, version2,2026-09-09. Numerical coefficients below are in char5;
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

## 4. An exact scalar alternative for the active (2,4,6) case

An actual uniform tame map of this type has degree24 by Hurwitz.
The intrinsic tensor

    s=2(df)^4/[f^2(f-1)^3]

has divisor2Dinf: at the three fibers the orders are respectively
4(2-1)-2*2=0, 4(4-1)-3*4=0, and -4(6+1)+5*6=2.
Writing s=A eta^4 gives(A), with f in H0(O(6Dinf)). Riemann--Roch
gives dimension24+1-2=23, with no assumption that infinity on a chosen
hyperelliptic model is outside Dinf.

Conversely impose(A) and the exact pole divisor6D. It makes df nonzero,
since its right side is nonzero. At a zero of f of order e, away from
D, it gives4 ord(df)=2e. If5 divides e, ord(df)>=e, impossible.
Otherwise ord(df)=e-1 and e=2. At a zero of f-1 the same argument
gives e=4. At a point outside these fibers and D it gives ord(df)=0.
At D the stipulated pole order6 is prime to5. Thus every ramification
point and its actual local index is accounted for; no wild or extra
branch point is hidden in the scalar test.

For r0=3/[t^2(t-1)], direct rational differentiation gives

    E(r0)=1/[t^2(t-1)^3],       N(r0)=0.

The same identities have been replayed in GF(5)(t). Locally choose a
uniformizer with f=z^e (after moving a branch value to zero); tameness
permits this choice. At the index2 point the leading coefficient of
r0 is2 and e^2*2+(e^2-1)/4=0. At the index4 and index6 points r0
has only a simple pole in the respective base uniformizer, and
(e^2-1)/4=0 in characteristic5. All remaining terms pull back regularly.
The projective transformation rule therefore gives a regular connection
on C. Its nonzero normalized curvature is s, so it is active nilpotent.
The complete85-point backup list is recorded in BACKUP_CANDIDATE; its
branch-pair formulas are proved in
[genus_two_active_critical_quartics](Sol_genus_two_active_critical_quartics.md).

Finally normalize a connected component of z^4=A. The functions
t=f, w=delta(f)/z satisfy the displayed elliptic equation, and
dt/w=z eta. To see the elliptic curve explicitly, put

    x=w^2/[t(t-1)],      y=2w/x.

Then x^2=3(t-1), y^2=x^3+3x, and dt/w=3dx/y. The latter cubic is
smooth; its Cartier coefficient is [x^4](x^3+3x)^2=1, so it is ordinary.
Since div(s)=2D, each fourth-root component has degree h=2 or4 over C,
with tame index2 at each point of D and no other ramification. Hurwitz
gives g(B)=2h+1. Degree comparison over P1 gives deg(B/E)=24h/4=6h.
This is a ramified auxiliary cover of C; its possible elliptic factors
are not controlled merely by simplicity of J(C).
