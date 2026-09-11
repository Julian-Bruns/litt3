# Neutral dihedral towers: unbounded finite repair with fixed defect

2026-09-11. New author argument awaiting a bounded independent audit.
Not yet a canonical proved theorem. This extends the ACTUAL fourteen
neutral covers of explicit_non_galois_neutral_five, not an abstract norm
module. It does not construct either leg of the fixed common-cover pair.

## Proposed theorem

Fix any of the fourteen quadratic resolvents D→C in that theorem,
excluding its canonical double R=u-t. The fixed C has defect1 and
nonzero obstruction epsilon_C to extending its specified canonical C2.
Write E:ell²=S for the ordinary elliptic quotient of D, with an origin
at a hyperelliptic branch point. For a>=0, put q=5^a and take the
iterated etale Verschiebung isogeny E_a→E. Set

    W_a=D x_E E_a,       T_a=W_a/<tau>,       T_0=C,

where tau is the lift of the original free double involution, using
[-1] on E_a. Then:

1. W_a→C is an actual D_(2q) Galois cover; W_a→D is cyclic q,
   T_a→C is degree q, and T_(a+1)→T_a is degree5. The genera are
   g(W_a)=2q+1 and g(T_a)=q+1. For a>=1, T_a→C is non-Galois.

2. For every a>=1 the ACTUAL defects are d(W_a)=2,d(T_a)=1.
   The semilinear Fitting types are

       W_a: bijective dimension4q, nilpotent blocks q-1,q+1;
       T_a: bijective dimension2q-1, nilpotent block q+1.

   In particular all maps T_(a+1)→T_a are defect-neutral, although
   their cyclic closures have growing genus and constant defect2.

3. For every a>=0, the pulled-back canonical T_(a,2) has SOME
   compatible extension through W_(a+2). These are extensions on
   DIFFERENT finite source curves as a varies. No such compatible
   extension for a>=1 can extend the ORIGINAL T_(a,2)→C2 even to
   a compatible C3.

4. A full compatible marked Witt tower exists on T_a, a>=1, if and
   only if one exists on T_1. This is only an equivalence of existence;
   neither existence nor nonexistence is asserted. The implication
   from T_a to T_1 preserves the original quotient marking.

Thus defect1 alone does not bound the length of source-only finite
repairs as the source degree varies. The unbounded finite repairs
do not supply a full tower on one fixed curve.

## Established inputs, not new assumptions

- explicit_non_galois_neutral_five: all fourteen q=5 cases, actual
  D10 geometry, d_D=1, cyclic cokernel k[e]/e², and semilinear
  Fitting types C:(1;2), D:(4;2), W_1:(20;4,6), T_1:(9;6).
  The nilpotent two-dimensional part on D comes entirely from C and
  is tau-positive; its tau-negative tangent part is bijective.
- etale_p_witt_obstruction: negative tangent cohomology over an actual
  p-group Galois cover is free over the deck ring; reduction by a
  normal subgroup recovers the lower Hodge operator through the
  equivariant norm identification of invariants and coinvariants.
- neutral_degree_five_obstruction_structure: on any actual neutral
  degree5 cover, pullback on the primary Hodge cokernel is ZERO,
  with all previous tuple data retained. A next upper primary lift
  can therefore be repaired when a lower next obstruction is present.
- neutral_galois_witt_descent: every GIVEN full compatible upper
  tower descends uniquely along a neutral GALOIS map. For cyclic5,
  the one-extra-digit finite version holds for every defect.
- explicit_genus_two_witt_obstruction: epsilon_C=1/(4+4t)!=0;
  etale pullback on negative tangent H1 is injective in every degree.
- ordinary_dihedral_spin_growth, proof Section2: the same elliptic
  Verschiebung/base-change construction gives actual connected
  dihedral towers. Here use the ordinary E of the selected resolvent,
  not necessarily the particular elliptic equation in that theorem.

## Actual geometry of the tower

E is ordinary, so the iterated Verschiebung E_a→E is etale with
geometric cyclic kernel C_q. The degree-two extension D→E is ramified
and linearly disjoint from this odd-degree extension. Thus W_a is a
smooth connected curve, and W_a→D is the actual pulled-back cyclic
etale cover. The original involution of D acts by [-1] on E. Using
[-1] on E_a lifts it to an involution tau on W_a. It remains free
because its image on D is free. It conjugates cyclic translations by
inversion and gives 2q actual automorphisms over C, the full degree.
Quotienting gives T_a. Choose the isogenies compatibly, so all maps
W_(a+1)→W_a and the resulting T_(a+1)→T_a are actual etale maps.
The genera follow from etale Hurwitz. These choices identify the
q=5 stage with the already audited cover (the anti-invariant etale
F5 direction is unique).

## Why the closure defect is exactly2 at every level

Put R_q=k[e]/e^q, e=sigma-1, with compatible cyclic generators.
The tangent cohomology V_a=H1(W_a,T_(W_a)) is free of rank6 over
R_q. The linearized actual Psi_a is an R_q-linear map on free
rank6 lattices, retaining its coefficient-Frobenius twist.

Quotient by e^5 recovers Psi_(W_1). More explicitly, if the kernel
of C_q→C_5 is K, its norm identifies K-coinvariants and K-invariants
of each free module, and etale naturality identifies the latter with
the actual lower Hodge map. This proves the quotient assertion; it
is not assumed from equality of two numerical defects.

Modulo e there are five invertible source/target directions, since
d_D=1. Eliminate them over the local ring R_q. The remaining scalar
relation f_q reduces modulo e^5 to a unit times e², by the q=5
Smith calculation. Therefore f_q is itself e² times a unit in R_q.
Its cokernel has length2, proving d(W_a)=2 for EVERY a>=1.

## The full semilinear Fitting type

This argument uses Fitting decompositions, not a confusion between
Smith length and semilinear nilpotence.

Introduce the anti-invariant parameter

    v=sigma-sigma^(-1)=2e+O(e²).

It is a uniformizer of R_q and tau(v)=-v; coefficient Frobenius
fixes the abstract v. Since Psi is semilinear over the automorphism
that Frobenius-transports coefficients and fixes the group basis,
its eventual kernel and image are R_q-submodules, and its Fitting
direct sum is R_q-linear. Direct summands of a free module over
the local ring R_q are free. Reduction modulo v gives exactly the
base Fitting decomposition (invertibility/nilpotence commute with
this reduction). Hence the bijective summand has rank4 over R_q,
and the nilpotent summand has rank2.

The latter reduces on D to its two-dimensional tau-positive part.
Average lifts of a residue basis under tau, dividing only by2.
They remain a free R_q-basis and are fixed by tau. In this basis
the nilpotent operator is M(v)Phi, where every entry of M is an
EVEN polynomial in v. Its constant coefficient is the actual
two-step nilpotent base operator. Consequently

    M(v) M(v)^[5] = v² U(v),

where the Frobenius transport fixes v. The matrix U is invertible:
the nilpotent M has Smith factors1,v², because its mod-v rank is1
and its cokernel length is2. Its determinant has v-order2, so the
product determinant has v-order4, forcing det(U) a unit. This also
holds for q=5; the coefficient of v^4 is still visible. Therefore

    rank_k Psi_nil^(2j) = 2 max(q-2j,0),
    rank_k Psi_nil^(2j+1)
       = max(q-2j,0)+max(q-2j-2,0).

These are exactly the ranks of nilpotent blocks q-1 and q+1.

For tau-positive vectors write w=v². They form a free rank2 module
over k[w]/w^((q+1)/2). The induced M(w) has Smith factors1,w,
and Psi²=w*U(w)*Phi². Its ranks therefore decrease by1 at every
iterate, so this part is one block of length q+1. The negative
part similarly has one block q-1. Taking tau invariants is exact
because2 is invertible. It identifies the positive operator with
Psi_(T_a), hence d(T_a)=1. Its tangent dimension is3q, leaving
bijective dimension2q-1. No arbitrary equivariant matrix has been
identified with the actual map: freeness, the actual q=5 Smith
length, the actual base Fitting type and the actual involution
give all the hypotheses of this argument.

## Arbitrarily long FINITE source-only repairs

The following is an induction on a, not a limit on one fixed source.
For a=0 the canonical C2 is compatible. Suppose T_(a-1) has a
compatible W_(a+1) lift. Lift its ORIGINAL etale map from T_a over
that truncation. Choose any smooth next curve extension of the
lower curve, and lift the cover over it. Naturality makes its
next primary obstruction class the pullback of the lower class.
Both special-fiber defects are1, so the actual degree5 neutrality
theorem makes this class zero upstairs. Vary the upper curve digit
by a preimage under Psi to kill the representative. The prescribed
Hodge line then lifts uniquely, with its grading and flat twist.
This gives a compatible T_a through W_(a+2).

The last repair can abandon the map at its newest digit, which is
allowed here and must not be suppressed. All earlier truncations
still retain the original map. In particular the W2 marking is
always the original pullback from C2.

If any compatible third truncation also extended T_a→C over some
C3, the unquotiented normal obstruction would satisfy

    0=rho_(T_a)=h_a^*rho_C.

Injectivity of this individual etale pullback on negative H1 would
give rho_C=0, contradicting epsilon_C!=0. Thus the construction
does not repair the map to C, even though it repairs the source
to arbitrarily high finite precision as a grows.

## Why the full-tower question still lives on T_1

If T_1 has a full compatible tower, lift the original etale map
T_a→T_1 throughout it; this gives a full tower on T_a.

Conversely, suppose T_a has a full tower. Lift the ORIGINAL double
W_a→T_a throughout it, with its deck involution tau. The actual map
W_a→W_1 is cyclic and neutral, since both defects are2. The neutral
Galois full-tower theorem uniquely descends this GIVEN W_a tower
along that map to W_1. The involution tau normalizes its cyclic
deck subgroup. Applying tau gives another descent of the same
marked upper tower; uniqueness supplies its descended action on
W_1. Its order-two relation holds by the same uniqueness, and it
is free because its special-fiber action is free. Quotienting by
that action gives the compatible full tower on the ORIGINAL
T_1=W_1/<tau>. The flat tuple descends as well, by its unique
specified graded and Hodge identifications.

This step must use the descended involution just constructed. A
generic prime-to-two cover does not by itself force existence of
that action on an arbitrary lower tower.

## What needs independent checking

Audit the cyclic coinvariant specialization at all q, the free
semilinear Fitting decomposition and even-parameter matrix argument,
the exact finite-level induction with its changing sources, and the
original-marking descent of tau in the full-tower equivalence.
Do not infer a full-tower counterexample or an actual common span.

If correct, this explains why fixed-defect finite repair tests can
last arbitrarily long across different covers, and makes the scalar
fourth-obstruction test on the fixed T_1 more informative. If a
conclusion fails, retain the valid earlier pieces with exact scope.
