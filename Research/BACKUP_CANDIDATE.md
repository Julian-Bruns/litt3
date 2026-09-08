# Backup candidate: fixed X and an ordinary genus-two partner

Updated2026-09-08, `/root/alternative_curve_candidates_max`.
Active fixed pair and all18/selected14 computation are unchanged.
The original common finite-etale-cover problem remains UNSOLVED.

Chosen partner:

    C: v^2=u(u-1)(u-2)(u-3)(u-alpha), alpha^3+alpha+1=0 overF125.

This minimizes the complete Hermitian atlas search among the checked
alternatives: oper scheme length5,81 cubic torsion lines,8 variables and
13 equations per oper/twist. The original genus-nine X is retained.
The cost tradeoff is explicit: every common-orbifold branch fiber, or
ASSUMED clump image, on X has size divisible by8. Thus its W3/small-clump
theorems do not reach those supports. No counterexample probability is
assigned to the candidate.

## Current outcome —2026-09-08,04:15 CEST

**All five Hermitian atlas systems are empty:405/405 oper/twist pairs,
twenty original-row chart identities.** The geometric bridge has a fresh
Astra-medium major audit PASS with no material objections. See the
[canonical theorem](../Theorems/Thm_backup_hermitian_atlas_exclusion.md)
and [proof/certificate map](../Solutions/Sol_backup_hermitian_atlas_exclusion.md).
Do not repeat the completed census, tensor construction or atlas search.

Root completed the three final chart certificates by an exact length-eight
necessary algebra and a polynomial Frobenius unit transfer back to the
original equations. Final two constructions took23.77/23.92s, each onONE
core; factored lifts2.45s, independent replays2–3s including negative
mutations. Generic multivariate replay was the avoidable cost. All large
data remain outside Git in the external backup directory.

Both large Hermitian cored profiles are now excluded. The existing
[Hessian quotient identity](../Theorems/Thm_hermitian_monodromy_genus_sieve.md)
also excludes the tame row(n;signature)=(24;3,3,4): any such atlas
C->[H/M216] would compose with[H/M216]->[H/PGU3(5)] to contradict the new
theorem. Two further tame exclusions, (16;2,4,8) and(36;2,3,9), follow
from the new [radical quadratic obstruction](../Theorems/Thm_radical_quadratic_atlas_obstruction.md).
The first uses the existing J[4] Bol tests; the second uses four exact
minor tests covering all400 nontrivial cubic oper/twist pairs, generated
and replayed in2.37s each onONE core. Both are AUTHOR proofs, not new audits.
Thus **17/24 tame and9/12 small-wild rows are excluded**;
seven tame and three small-wild remain. The Hessian corollary uses the
existing author-prose Hessian presentation, not a new audit of that input.

All research agents are stopped. At mostONE CPU core TOTAL overnight.
The original problem remains UNSOLVED; neither the active pair nor its
main selected14 data was changed. Every assertion below concerns the
backup or a stated conditional span, not arbitrary etale commensurability.

## Arithmetic and portability

`backup_genus_two_prepare.sage` checks squarefreeness, genus2, unique O,
pole semigroup<2,5>, div(du/v)=2O and Hasse--Witt determinant3(alpha+1)^4.
Counts over F125 and F15625 are118 and15926. The Weil polynomial is

    P(T)=T^4-8T^3+182T^2-1000T+15625.

It is irreducible. Its root-ratio resultant has no cyclotomic factor
except(T-1)^4: this proves absolute simplicity, not just simplicity over
F125. Hence Hom(JX,JC)=0 by simplicity and the different dimensions9,2.
Every uniform Cartier eigenform has simple zeros: the only possible
double-zero forms are the six Weierstrass forms; all six eigen determinants
are nonzero. Ordinarity separately excludes Cartier-zero forms.

The branch points are all F125-rational. P(1)=14800 and P(-1)=16816
both have2-adic valuation4. Thus pi-I=2U and pi+I=2(I+U), with both
quotients2-adic units, and pi^2-I=4 times a unit. The author-prose
`low_pencil_torsion_rigidity` theorem, specialized to the hyperelliptic
pencil and r=1, puts W1[2^infinity] in the4-torsion. Since
L(4O)=<1,u,u^2>, no nonbranch point has order4; these are exactly the
six Weierstrass classes. This use of the NEW general rigidity theorem
does not inherit the independent audit of its older cubic special case.

For any ASSUMED clump, rX=8rC. Thus W1(C,O), the new simple-zero
Cartier test on C, and its mixed-prime-support refinement are usable
on clumps with rC=1, even though rX=8 is outside the fixed-X W3 theorem.
No clump is asserted to exist.

There is one further concrete coreless exclusion. Under the new
author-prose `fixed_x_nonzero_cartier_profiles` theorem, a primitive
shared tensor with NONZERO Cartier image has (d,e)=(2,1),(2,4),(4,2)
or(4,8). The double-weight cases have C-support a single point P:
div(s_C)=2dP, so2d[P-O]=0. The W1 two-primary classification makes P
Weierstrass; hence s_C is a scalar d-th power of a one-form with double
zero at P. The endpoint-root Cartier test makes that form a Cartier
eigenform, contradicting the six exact checks. Thus the two
double-weight profiles(2,4),(4,8) are excluded. The C-support-four
profiles, Cartier-zero branch, and possibility of no shared generator
remain. This conclusion retains both actual finite-etale legs and the
explicit nonzero-Cartier hypothesis; its new theorem dependencies have
not yet had an independent audit.

## Complete five-oper algebra

With eta=du/v and O the unique infinity, div(eta)=2O and the semigroup
is<2,5>. The complete regular projective-connection chart is

    r_eta+(2u^3+b0+b1u+b2u^2)/F,
    r_eta=F''/(4F)-3(F')^2/(16F^2).

The added cubic term cancels the sole double pole at O; hyperelliptic
parity rules out a simple pole. Differences are all three global
quadratic differentials. In the eta frame the scalar equation is
delta^2 f=P f with delta=v*d/du and P=2u^3+b0+b1u+b2u^2.
Dormancy is checked in the separating coordinate by r''-3r^2=0.
The cleared coefficient ideal has reduced length5. Its separator is

    z^5+(alpha+1)z^4+(2alpha^2-2)z^3-2alpha^2 z^2
      +(-2alpha^2+alpha+1)z+(2alpha^2+2alpha-2).

It is irreducible over F125. The saved coefficient formulas recover
b0,b1 from z=b2. Every original curvature equation vanishes in the
full length-five algebra; the original Jacobian minors generate1 there.

### Ten dormant secants: exact genus-three marked curves

Let z_i=z^(125^i), i=0,...,4, in the degree-five separator field above.
Write r_i-r_j=A_ij(u)(du)^2/v^2. ALL ten polynomials are specified by

    A_ij(u)=(z_i-z_j)[u^2+(z_i+z_j+2alpha+2)u
       +2(z_i^2+z_i*z_j+z_j^2)
       -(2alpha+2)(z_i+z_j)-(2alpha^2-2alpha+1)], i<j.

Every A_ij has degree2, nonzero discriminant and gcd(A_ij,F)=1,
checked in the exact field F125[z]/(separator). Thus none of the ten
pairs is a degenerate or branch-intersecting exception. The known
F125-Frobenius/unordered-pair symmetries give TWO orbits of size5,
represented by(0,1) and(0,2). Reversing a pair sends A to-A;
w->2w identifies the curves below and multiplies their marked eta by2.
This is not a classification under every possible genus-three isomorphism.

For each A, the connected spectral curve D has equations

    v^2=F(u),       b^2=2A(u),
    E_A: w^2=2A(u)F(u),       D -> E_A: w=bv.

The two square classes have disjoint nonempty branch loci over P1, so
D is connected. The degree-seven squarefree equation makes E_A smooth
of genus3. On E_A, valuations of2A are2 at its two A-branch points,
-4 at infinity, and0 elsewhere. Therefore adjoining b is an ACTUAL
etale double cover; D has genus5. Its other double map D->C is
RAMIFIED at the four points over the two roots of A, and must not be
mistaken for an etale leg to C or for a common source with fixed X.

Set P=2AF and c_m=[u^m]P^2. In the basis du/w,u du/w,u^2 du/w,

    H=[[c4,c3,c2],[c9,c8,c7],[c14,c13,c12]],
    Cartier(x)=H^(1/5) x^(1/5).

`backup_genus_two_secant_curves.sage` saves the exact H AND actual
inverse-Frobenius-semilinear Cartier matrix for all ten pairs, along
with their nonzero determinants and inverses. For M=H^(1/5), all
three ranks of M, M sigma(M), M sigma(M) sigma^2(M) are(3,3,3),
where sigma is inverse fifth-power Frobenius. Thus ALL ten E_A have
p-rank3, not merely a nonzero Cartier-fixed subspace.

The marked differential is eta=2A du/w. Its divisor is twice each of
the two A-branch points. The exact identity H*(2A)=(2A)^[5] proves
Cartier(eta)=eta, and direct extraction of the coefficients u^(5j+4)
of(2A)P^2 independently checks that same identity. The original dormancy
equations of all five opers are rechecked before the packet is generated.
The computation took0.60s, with no point count or new oper solve.
The portable file `Research/computations/backup_genus_two_secant_curves.json`
freezes every A, both field moduli, all matrices, determinants, threefold
Cartier ranks and eta coefficients. These are author exact endpoint
certificates and spectral-cover geometry, not a proof that compatible
opers exist on an actual common etale source.

## Complete125-nilpotent endpoint census

On the SAME three-parameter regular chart put E=r''-3r^2 and
Delta=-E'^2-3E(E''+3rE). Clearing denominators expresses the horizontal
10-differential as exactly three coefficient equations, with leading
monomials-b0^5,-b1^5,-b2^5. Their125 standard monomials prove the exact
scheme length without a genericity assumption.

`backup_genus_two_nilpotents.sage` constructs90 distinct exact solutions
in disjoint squarefree finite algebras. It substitutes them into ALL
original equations and checks that the determinant Jacobian is nonzero
at precisely85 active points. The remaining five are the dormant orbit.
At a dormant point all three determinant equations have no linear term,
so their local complete-intersection length is at least8. Thus
5*8+85=125 proves completeness, dormant multiplicity8, and no missed
nilpotent solutions. Construction took2.96s after replacing an unnecessary
global separator by small b2-fibers.

The independent `backup_genus_two_nilpotents_verify.sage` uses no radical
or Groebner solver: it rebuilds the original determinant, replays the
disjoint squarefree solution formulas and Jacobians, and directly checks
C_3(s^4)=s for s=E(du)^4/3. In the eta frame s=G(u)eta^4, this is the
polynomial identity

    [u^(5j+4)](G^4 F^2)=G_j^5,       j=0,...,4.

All85 active quartics have four double zeros, checked by factorization.
This is also forced by their degree8 and zero orders0/2mod5: no partition
of8 involving a5 or7 is possible. Their quadratic-root2-torsion classes
are recorded:10 trivial, and exactly5 for each of the15 nontrivial
classes. The10 trivial-root points agree numerically with the ten
unordered pairs of distinct dormant opers; no identification is needed
for completeness. All active determinant points are simple ON C.
Every quartic is G(u)eta^4, so all85 are fixed by the hyperelliptic
involution; each of their2-torsion root classes is also fixed.

The `nilpotent_scalar_model` and `cartier_dormant_secants` dictionaries
are new author proofs, not independently audited here. This census
does NOT prove that any endpoint connections have equal pullbacks,
that a common connection exists, or that an etale pullback is ordinary.

## Complete cubic torsion and genuinely twisted bundles

For a nonzero cubic torsion line L=O(D-2O), every D has degree2.
Write its Mumford representation (U,V), with U monic quadratic.
The norm equation A^2-F=cU^3 (A cubic,c its leading coefficient squared)
gives div(v-A)=3D-6O. It retains double roots of U.
Indeed a nonzero3-class cannot lie in W1 because L(3O)=<1,u>; its
unique degree-two representative avoids O. Any function of divisor
3D-6O lies in L(6O), has a nonzero v coefficient and a cubic polynomial
part. At a Weierstrass point v-A has a simple zero, so D avoids these
points. This proves completeness of the norm parameterization.

Normalize B=A/a3 and lambda=a3^-2. The exact ideal
B^2-lambda F=U^3, saturated by lambda, has reduced length40.
The separator lambda has factor degrees4,12,12,12. All original equations
and their Jacobian determinant are checked in the full quotient algebra.
Adjoining a3^2=1/lambda gives exactly80 distinct3-classes, with Frobenius
orbits8,24,24,24. This also agrees with P mod3=(T^2+2T+2)^2 and
v3#J(F125^8)=2, v3#J(F125^24)=8. The construction includes repeated U;
the exact final discriminant gcd proves that none occurs for this C.
Consequently W1(C,O)[6] also consists exactly of the six Weierstrass classes:
otherwise2[P-O] would be a nonzero3-class represented by2P.

Two further exact tests are in `backup_genus_two_small_torsion.sage`.
First, W1[9]={0}. At a nonbranch point(t,w), write
v(t+h)/w=sum c_i h^i. An element A4(u)+B2(u)v of L(9O) can vanish
to order9 only if the4x3 matrix(c_(n-j)), n=5..8,j=0..2, loses rank.
Its four maximal-minor numerators have degrees60,63,67,66; explicit
polynomial multipliers give their sum equal to1. Branch points have
order2 and are handled separately. Second, translate the complete
40-point norm algebra by each of the15 nonzero rational2-classes.
Exact polynomial division computes each reduced quadratic U; all15
discriminants are units, with saved Bezout identities. Together with
the zero translate and L(4O), this proves W1[12] is exactly the six
Weierstrass classes, including every mixed6/12 possibility.

For the translation calculation, choose E as a product of one or two
branch linear factors. The code constructs W with W=B mod U and W=0
mod E. The remaining quadratic is(F-W^2/lambda)/(UE), made monic.
The divisor of v-a3W proves the addition formula directly; its remaining
zeros represent the negative of the sum and have the same u-polynomial.
No primary projection of a W1 class is presumed to remain in W1.

The inverse of T^24-1 modulo P has3-adic denominator exponent2.
Together with v3 det(pi^24-I)=8 on a rank-four Tate module this gives
pi^24-I=9 times a3-adic unit, without a companion-matrix assumption.
At2, pi^2-I=4 times a unit gives pi^24-I=16 times a unit by the
binomial expansion. The author-prose general rigidity theorem therefore
implies W1[3^infinity]={0}, and mixed{2,3}-torsion in W1 is killed144
and lies over F125^24. The mixed classes are not thereby excluded.

Since5 is coprime to8 and24, all405 oper/twist pairs have precisely five
F125-Frobenius representatives, with absolute coefficient-field degrees
15,120,360,360,360. No PGU twist has been discarded.

The affine modules of L and L^-1 have k[u]-bases

    I(D): 1,(v+V)/U;        I(-D): U,v-V.

These supply finite Cech reductions at O for the twisted bundles.
If V0 is the untwisted normalized rank-two bundle, parameterize
V=V0 tensor L and M=omega^2 tensor L^2. The atlas character is tau=L^2.
For h=v-A with div(h)=3D-6O, the twisted j0 is h*j0_base; hence its
dual-Frobenius term is -h^-1*j0_base^-1*alpha^[5]. These formulas still
require independent mathematical audit; their full local-frame,
cohomology-dimension, coboundary and perfect-pairing tests have passed
for all five representatives, at both saved precisions.

At O use q=u^2/v, the twisted transition q^2 G, and the affine
I(-D) reducers Uu^i,(v-V)u^i. Their unremoved exponents are -3,-2,-1,0
and the bounded positive tail, not the untwisted gap set{-3,-1}.
This is an actual divisor-ideal computation, not reused trivial coefficients.

## Complete applicable common-orbifold sieve

For an ACTUAL common effective orbifold, simplicity of JX and genus(C)<9
force coarse P1. Put N=deg(X/S), n=deg(C/S). Canonical degrees give
N=8n, so8 divides N. These are atlas degrees, NOT joint-image component
degrees. Every inertia order divides n; reduced X branch fibers have
size at least8. The numerical census is24 tame rows with N<=672,12
small wild rows with N<=2240, and the two large wild rows below.

For each tame row, the saved data includes E=lcm(e_i), A=2E/n and
the actual fiber torsion bounds A e_i[D_i-(n/e_i)O]=0. **Fourteen of24
tame rows are now author-excluded**, by the following five mechanisms
and the complete(4,4,4) secant test recorded below.
This is not an independently audited full cored theorem.

The extra exact Hasse-jet script `backup_genus_two_one_point_orders.sage`
proves W1[N] is precisely the six Weierstrass classes for
N=8,16,18,24,36. Each certificate uses only two maximal minors; their
polynomial multipliers sum to a power of F, as in the canonical
`superelliptic_single_point_torsion_test`. The largest case36 took14.7s.
No ordinary-derivative Wronskian is used in characteristic5.

Aut(C)=C2: a Mobius map preserving the six hyperelliptic branch points
sends at least four of the five F5-points into F5, hence is over F5.
It fixes the unique non-F5 branch point alpha; a nonidentity Mobius
fixed point has degree at most2, contradicting degree(alpha)=3.

1. **Two totally ramified Weierstrass fibers.** This excludes
   (n,signature)=(3,(3,3,3,3)), (4,(2,2,4,4)), (6,(3,6,6)),
   and (8,(2,8,8)). The respective singleton torsion bounds are6,8,12,16.
   If f has divisor n(P-Q) at distinct Weierstrass points, n must be
   even. Writing div(h)=2(P-Q), uniqueness gives f=c*h^(n/2).
   For n>2 the nontrivial cyclic deck group on the h-line preserves
   the hyperelliptic branch set: uniform inertia in a fiber of f
   forces every unramified h-line orbit to be either wholly branched
   or wholly unbranched, and0,infinity are fixed. This contradicts
   Aut(C)=C2. The odd n3 case already contradicts order(P-Q)=2.

2. **Double-transposition monodromy.** For n4 and signature(2,2,2,2,2),
   every inertia permutation lies in V4. The quotient of monodromy by
   its intersection with V4 gives an unramified cover of P1, hence is
   trivial. Transitivity forces the full group V4, so C would have
   a degree-four Galois quotient, again contradicting Aut(C)=C2.

3. **One Weierstrass fiber forces an elliptic map.** This excludes
   (n,signature)=(6,(2,2,2,6)), (9,(3,3,9)), (12,(2,4,12)), and
   (18,(2,3,18)). Their singleton torsion bounds are12,18,24,36.
   Here is one uniform proof, retaining the actual atlas f. Write
   n=3m, move its totally ramified Weierstrass fiber P to infinity,
   and choose eta with div(eta)=2P. The finite inertia lists are
   (m;e_i)=(2;2,2,2),(3;3,3),(4;2,4),(6;2,3). Set

       H=df/eta,
       y=H^(m-1)/product_i(f-a_i)^(m-1-m/e_i).

   Tameness gives div(H)=sum_i(e_i-1)D_i-(n+3)P. Consequently
   div(y)=sum_i D_i-3sP, where s=sum_i m/e_i. Thus, after scaling y,

       y^m=product_i(f-a_i)^(m/e_i).

   The corresponding connected Kummer curve over the target line
   has genus1: its inertia is the finite list e_i together with m
   at infinity. The displayed functions give an ACTUAL separable
   degree-three map C to this elliptic curve, impossible for its
   absolutely simple Jacobian. This constructed auxiliary map is
   used only for contradiction; it never replaces either etale leg
   of the original assumed common span.

4. **Prym branch translations force an extra automorphism.** This
   excludes(n,signature)=(8,(2,2,2,4)). Suppose the actual tame map
   f:C->P1 exists, and take the elliptic double E->P1 branched at its
   four branch values. The normalized pullback D->C is etale: every
   inertia index of f is even. It is connected, since otherwise f
   factors through E, contrary to Hom(JC,E)=0. Thus D has genus3.

   Every connected etale double of a genus-two curve is hyperelliptic
   and has a complementary elliptic quotient E'. Indeed its nonzero
   two-torsion class is represented by two of the six hyperelliptic
   branch points. Write the branch polynomial as A2*B4. Then D is
   the actual biquadratic curve obtained by adjoining sqrt(A2) and
   sqrt(B4), with quotients C, the genus-zero sqrt(A2) curve, and the
   elliptic sqrt(B4) curve E'. Write iota for its central hyperelliptic
   involution, tau for the D->E' involution, and sigma=iota*tau for
   the original free D->C involution.

   The induced h:D->E has degree8 and has exactly four simple
   ramification points, all over the single point of E above the
   order-four branch value. On JD, iota acts by-1. Since
   1-tau=1+sigma factors through JC and Hom(JC,E)=0, h induces a
   tau-invariant Jacobian homomorphism. Hence h∘tau-h is constant;
   tau has four fixed points, so the constant is zero. Therefore
   h=phi∘(D->E') for a degree-four map phi:E'->E. After choosing
   origins, phi is an isogeny; it is etale since5 does not divide4.
   Its one fiber containing the four branch points is exactly their
   reduced branch divisor B on E'.

   The following lifting step is reusable. An elliptic double cover
   has data(M,section of M^2) with div(section)=B and deg(M)=2.
   If a nonzero t in E'[2] preserves B, then translation by t also
   preserves M: on Pic^2(E'), its difference is the class-2t=0.
   After rescaling the line-bundle isomorphism by a square root,
   translation lifts to an automorphism rho of D. It commutes with
   tau and with the central iota, hence descends through sigma to C.
   This descended automorphism is neither the identity nor C's
   hyperelliptic involution: their lifts lie in{1,sigma,iota,tau},
   whose actions on E' are identity or an elliptic inversion, not
   a nonzero translation. This contradicts Aut(C)=C2.

   Here such t exists because ker(phi) has order4 and contains a
   nonzero two-torsion point, and its translations preserve the fiber
   B. Connectedness, the elliptic factorization and preservation of
   the square-root line are all necessary parts of this argument.
   It applies to any genus-two C with no elliptic Jacobian factor
   and no automorphisms besides its hyperelliptic involution. This
   is an author proof, not yet an independent audit of the full packet.

5. **Ordinary cyclic covers cannot dominate a supersingular elliptic
   curve.** The complete calculations below prove that EVERY connected
   cyclic etale cover of C of degree1,2,3 or6 is ordinary. Therefore no
   actual tame map C->P1 can have three chosen branch indices respectively
   divisible by(3,3,3), or by(2,3,6), in some ordering. This excludes
   THREE further rows:(12;(3,3,6)),(12;(2,6,6)),(24;(2,3,12)).

   Here are the actual maps and connected-component hypotheses. The
   elliptic curve E:y^2=x^3+1 is supersingular: the coefficient of x^4
   in(x^3+1)^2 is zero, so its nonzero regular dx/y has Cartier image0.
   Its cyclic degree-three quotient has branch indices(3,3,3); its
   cyclic degree-six quotient t=x^3 has indices3,2,6 at0,-1,infinity.
   Move these branch values to the specified three values of f.
   Normalize C times_(P1) E and take ANY connected component D.
   The divisibility of the actual tame ramification indices makes
   D->C etale by the local tame base-change calculation. Its Galois
   group is a subgroup of the indicated cyclic group, hence its degree
   is1,3 in the first case and1,2,3 or6 in the second. No full-degree
   connectedness is assumed: all possible component degrees were tested.

   The other projection D->E is an ACTUAL nonconstant separable map.
   It pulls dx/y back to a nonzero regular Cartier-zero differential
   on ordinary D, contradiction. Equivalently, an ordinary Jacobian
   cannot have a supersingular elliptic quotient. This uses only the
   finite cyclic-cover census, not preservation of ordinarity under
   arbitrary etale covers, and not a simultaneous Galois closure of
   the original two legs. The new corollary is author prose resting on
   the explicit cyclic-cover certificates and their pending audit.

For wild signatures, the fixed-X theorem permits at most one wild
branch. A sole wild branch would make the pullback of dz a nonzero
regular exact form on ordinary C. With at least three tame branches,
n<4 contradicts5|n. With two tame branches, (2,2) would give
2=(n/e)(delta-e), impossible since delta-e=3 mod4; every other pair
gives n<12 and forces the already excluded(2,2). Thus there is one
wild and one tame branch. Also1<delta/e<2, since otherwise n<=4.
The full fixed-X two-branch proof gives q=5 in the small case. Writing
e=5t and lower break j, retain5 not dividing j, t|4j and
delta-e=4j-1. The exact finite enumeration yields:

| N | n | wild e | delta | other tame d | lower break j |
|---:|---:|---:|---:|---:|---:|
|80|10|10|17|2|2|
|160|20|5|8|2|1|
|160|20|20|27|4|2|
|320|40|10|13|4|1|
|320|40|20|31|2|3|
|320|40|40|47|8|2|
|480|60|30|41|3|3|
|640|80|20|23|8|1|
|960|120|20|27|3|2|
|960|120|60|71|6|3|
|1920|240|40|47|6|2|
|2240|280|20|23|7|1|

Three singleton-wild rows are author-excluded:
(n,e,delta,d)=(10,10,17,2),(20,20,27,4),(40,40,47,8).
Put their wild point P over infinity and their tame value at a.
The canonical identity is

    K_C=(delta-2n)P+(d-1)D_t,       dD_t~nP.

Multiplying by d and using Hurwitz gives dK_C~2dP. Thus
2d[P-O]=0, with2d=4,8,16, and P is Weierstrass by the exact tests.
Choose eta with div(eta)=2P and H=df/eta. Then

    div(H)=(d-1)D_t-n(d-1)P/d,
    z=(f-a)/H,       z^d=c(f-a).

Differentiation gives eta=c' dz, a nonzero regular exact one-form.
This contradicts the checked ordinarity of C. The argument uses the
actual wild different, not a tame approximation to wild inertia.

The same mechanism excludes THREE two-point wild rows
(n,e,delta,d)=(40,20,31,2),(60,30,41,3),(120,60,71,6).
Here dK_C~dD_w, so chi=O(D_w) tensor omega^-1 is killed by d.
On its ACTUAL connected cyclic etale torsor of degree ord(chi), or C
itself if trivial, choose eta with divisor the pullback of D_w.
Hurwitz gives delta-e-e/d=1. The identical H,z construction again
makes eta nonzero regular exact. All relevant cyclic covers are
ordinary by the following COMPLETE finite tests, not by ordinary
base-change or a general ordinarity assertion.

All fifteen connected etale double covers are ordinary: for each pair
of its six branch points, write F=A B and adjoin sqrt(A),sqrt(B).
The other quotients have genera0 and1; their pullbacks give a
power-of-two-degree Jacobian isogeny. All15 elliptic quotients y^2=B
have nonzero coefficient[u^4](B^2), checked by
`backup_genus_two_double_covers.sage`. Infinity is included among the
six branch points.

For each of the40 connected cubic covers put h=v-A and z^3=h, so
div(h)=3D-6O. Besides the two forms from C, the two one-dimensional
character spaces are generated by z*eta and U*eta/z. Since deg(A)<=3,
Cartier(A du)=0. Both Cartier arrows are nonzero exactly when

    gamma=[u^14]((F+A^2)F^2)

is nonzero. In the full length40 torsion algebra the code checks ALL
three Cartier coefficients equal gamma*(s^5,r^5,1), and gives an
explicit Bezout inverse for gamma. Thus every cubic cover is ordinary.

For each of the15 nonzero2-classes translate this same full40-point
algebra; these give ALL600 connected exact-order6 cyclic covers.
Using w=v/a3, E and W from the checked torsion-addition formula, set

    h6=lambda^-2*(w-W)^6*(w+B)^2/(U^6 E^3).

Exact division gives h6=A6(u)+w B3(u), with degrees6 and<=3 and
norm(h6)=c*Unew^6 for a unit c. Its divisor is6Dnew-12O.
For z^6=h6 the two primitive-character forms are z*eta,Unew*eta/z.
Their Cartier arrows are nonzero iff[u^14](A6 F^2) is nonzero; the
term B3 du again has Cartier zero. The code checks the full coefficient
identity and a Bezout inverse in EACH of the15 length40 algebras.
The other character spaces are the already ordinary degree2 and3
quotients. All600 covers pass, in18.46s including preparation, with
certificates in `backup_genus_two_cyclic_covers.json`.
This finite cyclic-cover Cartier argument is author prose/computation
and awaits its coherent audit. It excludes six of12 small-wild rows.

A seventh row, (n,e,delta,d)=(20,5,8,2), is excluded by the reduced
dormant scheme. Here s=(df)^2/(f-a) is a regular quadratic whose
divisor is the reduced four-point wild fiber. On the separable auxiliary
radical z^2=f-a it equals4(dz)^2, so C_1(s^3)=0 by Cartier's product
rule and C(dz)=0. The author `cartier_dormant_secants` theorem then
gives a nonzero tangent at a regular dormant oper on C, contradicting
its COMPLETE reduced five-point oper scheme. This uses scheme
reducedness, not just the number of geometric opers. The radical is
only used to prove a differential identity; it is not asserted etale
and never replaces either actual etale leg.

The eighth row, (n,e,delta,d)=(40,10,13,4), has
sigma=(df)^4/(f-a)^3 with divisor2D_w. Its quadratic root q is a
section of omega^2 tensor chi, with chi=O(D_w)omega^-2 killed by2.
On the ACTUAL etale chi-torsor q has four simple zeros and C_1(q^3)=0:
the identity is checked on the further separable radical t^4=f-a,
where q is a nonzero constant times(dt)^2. The connection q''/q
is unchanged when deck transformations multiply q by a constant, so
it descends to a regular dormant oper on C. Thus q would lie in its
chi-twisted Bol kernel.

`backup_genus_two_twisted_tangents.sage` checks ALL16 two-torsion twists
at ALL5 base opers in the irreducible length5 oper field. For a class
represented by a product E of one or two branch factors, z^2=E
trivializes it on its etale double cover. A complete basis is
z*(1,u,v/E)*eta^2, by finite valuations, the pole bound at O and
Riemann--Roch. The operator D_u^2-r splits into a two-column rational
block and a one-column v block. All16 three-column matrices have full
rank, with explicit invertible minors and Bezout identities, in1.21s.
This is an author twisted-basis/gluing argument, not an independent
audit or a silent extension of the cubic-twist complex.

The ninth row, (n,e,delta,d)=(80,20,23,8), is excluded by the analogous
COMPLETE order-four twisted-kernel calculation. Now
sigma=(df)^8/(f-a)^7 has divisor4D_w. Its quadratic root q on the
actual etale torsor for chi=O(D_w)omega^-2, with chi^4=O, has four
simple zeros. On t^8=f-a it is a constant times(dt)^2, so again
C_1(q^3)=0. The descended regular dormant connection q''/q would
have a nonzero chi-twisted Bol kernel, contrary to the following test.

For each of the15 nonzero classes gamma=O(D_E-jO) in J[2], take E
as a product of j=1 or2 finite branch factors. To parameterize halves
L=O(D-2O) of gamma, normalize h=C+v/E, with C=c0+c1*u, and impose

    C^2 E-F/E=Q^2,
    Q=q0+q1*u+2*u^2 (j=1),
    Q=q0+q1*u+c1*u^2 (j=2).

The four remaining coefficients are quadratic equations in four
variables. Each system has16 explicit distinct nonsingular solutions
over F125^2. They give U=Q/lead(Q), V=-CE mod U, with U squarefree
and coprime to F. The norm identity and valuations give
div(h)=2D-D_E-(4-j)O. Thus these are actual halves of gamma;
their distinct reduced Mumford divisors prove distinctness. Sixteen
such halves exhaust the prime-to-five degree16 fiber of multiplication
by2. The15 fibers give ALL240 exact-order-four classes, without a
genericity or finite-field point-count inference.

Put h4=C^2 E+F/E+2Cv. Its norm is Q^4 and its divisor is4D-8O.
On the actual etale torsor z^4=h4 a complete character basis of
regular quadratic differentials is

    z*(1,u,(v+V)/U)*eta^2.

This follows from L(D+2O), which has dimension3, and direct finite
and infinite valuations. For ell=h4'/(4h4)-F'/F, application of
D_u^2-r to a coefficient z*f/F reduces exactly to
f''+2ell*f'+(ell'+ell^2-r)f. Writing each image as A(u)+vB(u)
and clearing denominators gives a three-column coefficient matrix.
All240 matrices have certified invertible3x3 minors. The five base
opers remain one Frobenius orbit over F125^2, so this tests every
one of the1,200 exact-order-four cases. Together with the80 earlier
cases it proves all1,280 kernels for J[4] vanish. Construction took
15.13s; the frozen field models, actual torsion points, minors and
inverses are in `backup_genus_two_four_torsion.json`. Its independent
no-solver identity replay passed in21.41s; the verification receipt
records SHA256 `30572418c5741732b08fd7e4c003748bfebeebb073653999e54428c590eaf3ff`.
The divisor/twisted-basis argument still needs a coherent mathematical
audit; none of these statements asserts preservation on arbitrary
etale covers or the existence of a common connection.

The large rows are(N,n,e,delta,d)=(112000,14000,1000,1143,7)
and(336000,42000,3000,3143,21), both with q125, lower breaks1,6
and positive lower groups125,5. The COMPLETE audited proofs of
`completed_local_orbifold_rigidity` and
`hermitian_atlas_extension_criterion` identify their ACTUAL stacks as
[H/PSU_3(5)] and[H/PGU_3(5)], respectively, and identify the PSU lift
with tau=O. The whole untwisted C calculation excludes
the first large row by the completed backup construction's fresh audit.
This uses no A18 assumption. The full-PGU row is excluded by the completed and audited
all-character theorem linked at the top; no remaining atlas computation
is needed on C.

Current cored remainder:7 tame and3 small-wild; both large profiles are excluded.
The tame rows are exactly(n;signature)=(2;2,2,2,2,2,2),
(6;2,2,3,3),(12;3,4,4),(12;2,2,2,3),
(24;2,4,6),(48;2,3,8),(84;2,3,7).
The first is realized by C's own hyperelliptic pencil, so no condition
on C alone can exclude that row; the actual X leg is essential.
The small-wild rows are exactly(n,e,delta,d)=(120,20,27,3),
(240,40,47,6),(280,20,23,7). Their natural roots have weights3 or7;
the preceding regular quadratic/dormant argument does not apply.
This bounded list is neither a realization list nor a full exclusion;
arbitrary coreless spans are separate.

The eleventh tame exclusion is n=8 with signature(4,4,4). For this
profile, Hurwitz gives4K_C~4D_i for each reduced degree-two branch
fiber. Each nonzero J[4] class has its unique effective degree-two
representative; the255 functions h_D with div(h_D)=4D-8O are already
explicit in H0(8O). Three such fibers require three collinear sections.
The trivial class is exceptional: its entire canonical pencil contributes
the rational normal quartic{(a+bu)^4}, not just one section. The new
`backup_genus_two_tame444.sage` tests all32,385 secants among
the255 isolated points AND their intersections with this entire quartic.
Repeated or intersecting branch fibers are rejected. Two canonical
fibers cannot occur: their ratio forces f=c*h^4 through the hyperelliptic
pencil and produces incompatible order-two ramification at its six
Weierstrass points. Thus the test omits no Abel-fiber boundary.
The complete exact calculation took2.53s: all32,385 projective secant
lines are DISTINCT, so no three isolated sections are collinear, and
none meets the full canonical fourth-power quartic at a reduced divisor.
Of the pairs,28,560 have independent v-components,3,720 have rank one,
and105 are both polynomial; all three strata were retained. In fact
there are no finite canonical intersections even before disjointness
filtering. These results exclude the necessary three-fiber pencil.
The coefficient certificate is
`Research/computations/backup_genus_two_tame444.json`; this is author
exact algebra with a written divisor dictionary, not an independent
audit or a common-cover exclusion.

## Reproduction, solver and remaining work

Small, portable inputs/certificates:

* `scripts/backup_genus_two_prepare.sage` and
  `Research/computations/backup_genus_two_preparation.json`.
  `backup_genus_two_secant_curves.sage` and its same-stem JSON give
  all ten dormant-pair A polynomials, the actual spectral-to-genus-three
  etale double legs, and the complete Cartier-fixed marked packet.
* `scripts/backup_genus_two_torsion.sage` and
  `Research/computations/backup_genus_two_torsion.json`.
* `scripts/backup_genus_two_small_torsion.sage` and its same-stem JSON
  provide the one-point9 and12 certificates and Frobenius inverse identity.
* `scripts/backup_genus_two_nilpotents.sage`, its independent `_verify.sage`
  checker, and the same-stem JSON/verification receipt give the complete
  length125 nilpotent census and all85 active quartic profiles.
  `backup_genus_two_twisted_tangents.sage` and its same-stem JSON give
  all80 order-at-most2 twisted-kernel rank certificates.
  `backup_genus_two_four_torsion.sage`, its `_verify.sage` checker and
  same-stem JSON give the240 exact-order4 points and1,200 additional
  rank-minor certificates. Its `_verification.json` receipt records
  the passed no-solver replay and exact input hash.
  `backup_genus_two_tame444.sage` and its same-stem JSON record the
  complete255-point/secant/canonical-pencil exclusion for(8;4,4,4).
* `scripts/backup_genus_two_one_point_orders.sage` provides the additional
  one-point8,16,18,24,36 polynomial identities; full outputs stay outside
  the repo. `backup_genus_two_double_covers.sage` and its same-stem JSON
  check all15 actual connected etale double covers.
  `backup_genus_two_cyclic_covers.sage --include-six` and its same-stem
  JSON check all40 cyclic3 and600 cyclic6 covers, including all translates.
* `scripts/backup_genus_two_field_models.sage` and the corresponding
  field-model JSON freeze all coefficient fields before concurrent jobs.
* `scripts/backup_genus_two_tensor.sage` and
  `scripts/backup_genus_two_finish.py` generate/check the full tensor.
  Finite local expansions are saved as coefficient lists: native PARI
  Laurent-series pickles are not used. The final stage checkpoints every
  coefficient block and every completed coboundary test.
* `scripts/backup_genus_two_solve.sage` solves all four disjoint
  first-nonzero-b charts using native Singular. With b_j=1 and earlier
  b_i=0 it keeps all12 incidence rows and z*ell=1. A chart solution
  reconstructs all normalized solutions by t^3=ell and
  (p,b)->(t^-4 p,t b). Thus no normalization or boundary chart is omitted.
* `scripts/backup_genus_two_verify.sage` independently reconstructs the
  original chart rows from the hashed tensor and checks the explicit
  unit identities, without running a Groebner solver. All17 completed
  chart certificates have passed this replay; the small
  receipt is `Research/computations/backup_genus_two_atlas_verification.json`.
  Its `--tensor-directory` option permits relocated data while retaining
  exact tensor hashes.

All large tensors/certificates are local-only in
`/Users/julian/Documents/litt3-computation-data/backup-genus-two/`.
The canonical proof above identifies the complete twenty-chart evidence.
The live compact receipt is
`Research/computations/backup_genus_two_completion_status.json`.
No solver is running or scheduled to restart.

To replay a final factored chart, with i=1,2,3, use a SINGLE sequential job:

    sage scripts/backup_genus_two_factored_verify.sage \
      --tensor /Users/julian/Documents/litt3-computation-data/backup-genus-two/tensor_twist1_p500.json \
      --certificate /Users/julian/Documents/litt3-computation-data/backup-genus-two/factored_unit_twist1_chart0.json \
      --output Research/computations/backup_genus_two_factored_replay_twist1.json \
      --negative-tests

Change all three twist1 names together for another final chart. This
replays exact original-row identities, not the eliminated necessary system.
The finite-algebra generator and its source cache are discovery evidence;
they need not run again to check the final proof.

Positive control retained: the generic builder on the actual Hermitian
quotient v²=t⁶+3 recovers a first-chart length11 and33 normalized atlas
points; the other three charts are empty. Files
`tensor_positive_control.json` and `positive_control_chart0..3.json`
remain external. This is additional consistency evidence, not a proof
substituting for the audited geometric bridge.

The retired solver-history paragraphs were removed after preserving
their only live lesson: truncated Hilbert counts alone did not certify
finiteness; exact borders and original-row polynomial identities do.
No computation data or proof certificates were deleted.
