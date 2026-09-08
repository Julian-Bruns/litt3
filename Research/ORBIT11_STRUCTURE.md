# Orbit0011 structural work —2026-09-07

The original unmarked common-cover problem is UNSOLVED. Orbit0011 has
NOT been excluded. Its atlas solver remains deferred. The structural
checks below did not change the selected14 run; a later user-authorized
algorithm deployment is recorded separately below.

## Concrete result

An explicit frame for orbit0011 is now verified over its degree7324
relative field. The construction avoids extracting c4, avoids computing
horizontal kernels, and avoids expanding all large-field atlas tensors.
It has97 equations in64 variables, arranged as two alternating32-square
N blocks,32 projected R equations, and one bilinear normalization.

The frame minor is NONZERO. Exact determinant norm in F25 is1. High-pole
row selection exposes26 constant pivots and leaves only six pivots over
the large field. The bounded check completed in128.37seconds on one
low-priority core. Its exact determinant and all row/column indices are
in the external report below. No atlas equations were solved.

Those32 output rows are uniform on EVERY acyclic oper: the monomial
coefficients at pole orders36,37,41,42,...,111,112. The horizontal indicial
equation forces a leading pole congruent to1 or2 modulo5. Vanishing of
all32 selected coefficients therefore puts U in L32, whose horizontal
space H0(W8) is zero. This proves the row projection is always an
isomorphism there; the remaining frame check concerns the Q columns.

## Transfer to orbit0008, orbit0009 and orbit0010 — checked2026-09-07

YES: all five structural reductions below apply to each of these three
deferred representatives. This is now checked against the COMPLETED
census and exact relative-field/minor calculations, not inferred from
similar-looking degrees. All three are simple noninvariant opers, so
V=W(8O) is stable, det V=omega and H0(V)=0. Acyclicity follows from the
tangent/horizontal-section identification and reducedness, as recorded in
`cohomological_bezout`; it was not assumed from a sample kernel rank.

Write a^2+4a+2=0. All degrees in this table are OVER F25.

| Representative | Intrinsic normalized degree d | Norm(lambda) | Cube character Norm(lambda)^8 | Actual chosen-branch coefficient degree | Same frame: Norm(det Ghat) |
| --- | ---: | --- | --- | ---: | --- |
| orbit_0008 | 403 | 2+3a | 3+3a, not1 | 1209 | 4+a, nonzero |
| orbit_0009 | 578 | 2+2a | 1+2a, not1 | 1734 | 2+a, nonzero |
| orbit_0010 | 718 | 3+a | 3+3a, not1 | 2154 | 3, nonzero |
| orbit_0011, comparison | 7324 | 4 | 1 | 7324 | 1, nonzero |

For EACH of0008/0009/0010, a9 is the primitive separator. Thus the
normalized degree d is intrinsic and is not lowered by this work.
Unlike0011, lambda is NOT a cube: writing the original monic-curve oper
with c4^3=lambda genuinely requires a cubic extension. The deck-graded
atlas avoids this optional representation extension and works over the
degree-d field. In F5 degrees the savings are2418->806,3468->1156 and
4308->1436. This is an exact factor-three field-degree saving, not a
measured factor-three runtime claim or an atlas exclusion.

The SAME row and column index lists used for0011 work for all three.
Each minor has26 constant pivots and six remaining pivots. Consequently
the existing universal6-square remainder also selects these frames; no
new horizontal kernel or oper-dependent row search is needed.

| Reduction | Hypotheses for EACH of0008/0009/0010; unchanged conclusion | Remaining preparation / implementation boundary |
| --- | --- | --- |
| Acyclic alternating atlas | H0(V)=0 and the same basepoint-free canonical pencil hold. The same verified I,J give97 equations in64 variables: two alternating32-square N blocks,32 R equations and normalization. | Relative fields and frame checks DONE. The fixed F25 residue operators can be reused; the factored equation evaluator still has to be connected to an elimination backend. |
| Cubic deck grading | All three have c4!=0 and lambda a unit. The same diagonal weights descend the ENTIRE N,R,normalization system; no change of the original curve formulas. | Relative moduli, cube characters and normalized frame arithmetic DONE. The later2026-09-08 cached-tensor descent is implemented and deployed on selected14 where its complete coefficient guard passes; no tensor or solve for these deferred three is thereby supplied. The inverse-free Q-frame evaluator is still not integrated. |
| Constant-kernel / Pfaffian charts | At every ACTUAL atlas the common constant kernel is a line, for all three. Exact charts with retained R apply unchanged, including normal coranks2,4,6,8,10 and the16-parameter maximum-rank cover. | Same universal chart formulas; choose/evaluate the principal Pfaffian and cofactor charts, retaining nonzero conditions. Only the positive genus-two checker is implemented, not an all-representative chart backend. Corank-two charts alone are NOT yet justified. |
| 24-square Higgs reduction | Stability and acyclicity hold for all three. The24 L32 monomials and action -Q(Uh) are unchanged. At ACTUAL N,R,normalized points, the pole111/112 charts and the scalar-block determinant c^8 cover all points. | Same fixed coefficient projections and eight-column Schur rule. The first-oper identity checker is implemented; a field-generic factored rank evaluator is not. No representative-specific rank23 assertion was checked or proved. |
| Actual liftable radical / Frobenius geometry | At any ACTUAL untwisted atlas, all three have the required rank-three Frobenius-form extension, osculating flag, stable acyclic V and 5 not dividing16. The31-dimensional liftable hyperplane, degree15 Pfaffian candidate and parabolic-Higgs interpretation apply unchanged. | No extra oper census test is needed. These are conditional geometric constructions from an actual solution, not extra structures supplied by an oper alone. Generic nonvanishing of the candidate remains unproved for all three. |

The descended blocks stay alternating: with T=diag(c4^j_i), their
row/column change is Ahat_s=c4^(-1+2s) T A_s T, s=0,1.
Thus the pencil and Pfaffian arguments transfer after an invertible
pencil-parameter rescaling as well. The sixteen parameters may be chosen
in F25 for the DESCENDED pencil; they need not label the identical
sixteen canonical sections before the cubic base change.

The common unresolved mathematical claim is exactly the same for all
four representatives: at EVERY actual atlas, is M_s generically of
nullity1 (equivalently normal pencil corank2, or generic nonvanishing of
the restricted31-square maximal-Pfaffian section)? The full R equations
have not been proved to exclude nullity3,5,7,9. Without this claim the
all-strata charts remain exact, but the proposed smallest chart family
cannot replace them. No atlas point of these four representatives was
constructed or excluded by these preparation checks.

Historical implementation audit,2026-09-07: `build_oper_atlas.sage` provides the OLD
generic97-equation expanded-tensor construction for all18 representatives,
and `export_rooted_atlas.sage` consumes those tensors. That path still
constructs actual cube roots, horizontal kernels and field-dependent
coordinate inverses. It does NOT consume this new deck-graded/factored
presentation, the Pfaffian charts or the24-square Higgs reduction.
Proof-level transferability must not be reported as completed production
integration. Only the bounded `orbit11_q_frame.sage` helper was generalized
here, removing its unnecessary orbit0011/cube assertions; production was
not modified or restarted.

### Later algorithm integration —2026-09-08

The user subsequently authorized whole18 algorithm optimization, without
reenabling the four deferred representatives. Controller46381 now uses
`check_atlas_tensor_grading.py` and `atlas_deck_chart.py`: every one of
98304 rooted N/R coefficients must pass the diagonal character identities
before the optional cubic descent is used. All97 rooted rows, the full
coupled56-row R witness, every higher-corank stratum and the nonzero
normalization are retained. Search identities are converted back to the
original field and independently replayed from the original tensor JSON.
Actual degree1320->440 and240->80 checks and original-row certificates
pass. An intrinsic degree18 field whose saved modulus is not f(t^3)
correctly falls back to the unchanged original representation; divisibility
of a field degree by3 is NOT a descent criterion.

This implements a verified descent of EXISTING cached tensors, not yet
the low-memory factored Q-frame construction promised by the structural
formulas. It gives no completed tensor or atlas exclusion for0008--0011,
and cannot lower0011's intrinsic absolute degree14648. Pfaffian-chart
and24-square-rank methods remain proof-level reductions/test helpers,
not substitutes for the deployed all-original-row solver.

### Exact geometric obstruction left after linear elimination

This paragraph collates existing canonical records; it does not assert
a new emptiness theorem. For EACH of the18 stable untwisted V, put
E=V omega. It has h0(E)=32 and is globally generated: at every P,
H1(E(-P)) is dual to a stable negative-slope space, of slope-7.
The incidence of sections vanishing at a point has dimension at most31
inside the32-dimensional section space. Hence nowhere-zero sections
form a nonempty open, and their directions form a nonempty open in P31.
The audited `direct_wronskian_atlas` supplies a Wronskian-one complement
for every such U; all complements form an affine9-dimensional gauge.
Thus the quotient/Wronskian incidence is genuinely positive-dimensional
for every oper, including the six exceptional nonacyclic representatives.

The essential residual is two gauge-independent vectors in the56-dimensional
principal-part space:

    A_U=rho48(kappa^5 V0-U lambda^5),   B_U=rho48(eta).

One ALWAYS has B_U!=0. A projective direction supports an atlas precisely
when A_U is a NONZERO multiple of B_U; then exactly three scales work.
The five existing first-oper controls have rank[A_U B_U]=2. They do not
show this rank is2 everywhere. A uniform no-proportionality theorem on
the admissible P31 open would directly exclude the untwisted atlas branch;
no such theorem has been proved for even one whole representative.

The unnormalized N-incidence has a different, explicitly invalid boundary.
`inverse_cup_atlas_system` exhibits a24-dimensional family for EVERY
oper: choose P in X, a section vanishing on4P (P23), and the Q-third-jet
functional supported on4P in P(J). Its cup rank is at most23; normalization
removes it. On admissible directions the raw64x56 determinant pencil has
rank55 and a single extension-kernel line. Full R asks that this line be
preserved semilinearly, and not killed. It is not implied by that rank.

In the ACYCLIC swapped-pencil presentation, the actual common constant
kernel is one-dimensional, but normal coranks2,4,6,8,10 remain possible.
The equivalent24-square Higgs nullities are1,3,5,7,9. At rooted chart j,
q=31-j parameters b remain and the linear matrix H_j has size(65+j)x32;
its rank is32 at every actual point. One must still impose all q graph
equations b_h=s_h^5 and c=v.s!=0. No bounded pure-b elimination has been
proved to give a finite algebra on all charts. Actual genus-two atlases
give genuine weak N-plus-normalization scaling families on which full R
cuts the scale by t^3=1. Full Jacobian rank, extra Higgs-kernel dimensions
and the invalid boundary are distinct facts, not interchangeable.

Shared metadata/theorems give SU dimension32, S40 dimension64 and Q rank32
across18; h0(V)=0 on12 noninvariant representatives and3 on6 invariant
ones. The latter need three additional directions beyond the two canonical
pencil copies. No uniform vanishing invariant was inferred from timings
or finite sample ranks. All original cored/coreless gaps remain.

Exact external reports, in the directory listed below, are
`orbit_0008_relative_field.json`, `orbit_0009_relative_field.json`,
`orbit_0010_relative_field.json` and their corresponding
`orbit_0008_q_frame_high_minor.json`, `orbit_0009_q_frame_high_minor.json`,
`orbit_0010_q_frame_high_minor.json`. They retain exact coefficients and
source hashes. Relative-field checks took2.00,2.06,2.11seconds; the
same-frame checks took3.12,4.22,5.32seconds, sequentially on one
low-priority core, excluding Sage startup. No atlas tensor was exported.

## Mathematical mechanisms

`acyclic_alternating_atlas` (registered author proof; no independent audit):
for V of rank two with det V=omega and H0(V)=0,
any basepoint-free canonical pencil gives

    H0(V omega^2)=s0 H0(V omega) direct-sum s1 H0(V omega).

This is characteristic-independent. On the fixed curve use s1/s0=x^2*y;
then S40=S_U direct-sum (x^2*y)^5 S_U. The extension pencil is a pair of
alternating matrices. In the scalar Q frame, all97 equations can be
written using fixed residue operators over F25 and Q coefficients of
original-oper degree at most6. No inverse of the chosen minor is used.
The general nonacyclic version keeps136 N rows and therefore has169
equations, not the97-equation two-copy presentation. The55 h0(V)=3
opers must retain their missing three auxiliary directions.

The17 binary Pfaffian coefficients give explicit pure-b polynomial
consequences. Fifth roots give necessary degree16 equations in b. Their
finiteness or sufficiency is NOT proved; the pencil can have a varying
kernel, and the known weak-incidence boundary remains.

`oper_deck_graded_atlas` (registered author proof; no independent audit)
checks the ACTUAL local scalar equations under

    c4 -> zeta*c4, U -> sigma(U), eta -> zeta*sigma(eta),
    sigma(x,y)=(x,zeta*y).

The N,R and Wronskian normalizations are all preserved. Weighted frame
coordinates then descend to the normalized field by c4^3=lambda, with
the original fixed-curve residue operators. No monic-curve formula is
silently reused on a nonmonic cubic twist.

## Exact elimination of the common constant kernel

New author-prose record `alternating_constant_kernel_elimination`
(registration coordinated with root) retains the full R equations while
eliminating all32 v variables on explicit charts. At every actual atlas,
the common kernel of A0,A1 is a line, by the audited swapped cup-product
assertion. Write beta=G^T b, kappa=2, and C for the ACTUAL projected R
matrix. The equations are A0v=A1v=0, Cv=beta, beta^T v=kappa.

For A=A0+t A1 of corank2, put P=PfaffAdj(A), u=P A1 e_j and
h=beta^T u. On h!=0 the exact equations on b alone are

    Pf(A)=0,       A1u=0,       kappa C u=h beta.

They reconstruct v=kappa u/h. The denominator h is itself a bordered
Pfaffian. The Pfaffian and common-kernel conditions have fifth roots of
degrees16 and17 in b. The R equations keep their mixed Frobenius form.
This has at most65 scalar equations and an essential nonzero condition;
it is not merely the earlier necessary binary-Pfaffian test.

A direct vector-bundle argument on P1 bounds the normal corank c of an
alternating m-square pencil with exactly one common constant kernel:
m>=3c-2. For m=32 the only possibilities are2,4,6,8,10. Any16 distinct
F25 pencil parameters cover a maximum-rank member. Pfaffian Schur
reduction leaves at most10 kernel coordinates; exact maximal cofactors
of size at most9 reconstruct the same normalized v on all higher strata.
The large number of minor charts is not a proven runtime improvement.

An exact positive-control test changes the FULL saved genus-two N tensor
by an invertible constant row matrix into two alternating4-square blocks.
All33 independently known normalized atlas points are reconstructed by
the corank-two formula. All33 normalized weak rescalings that retain N
but fail R are rejected by the displayed R equations. A varying-kernel
example and a sharp abstract32-square corank10 example are also checked.
The latter is NOT a geometric oper and does not preclude a better bound
from the geometric origin of the pencil.

## Geometric radical formula — completed next bounded step

New author-prose `canonical_divisor_pencil_radical` identifies the radical
without imposing a generic-rank assumption. Put E=V omega. For the
actual nowhere-zero u, push its extension out along a canonical section s
to obtain E_s. If D_s=div(s), including multiplicities, then

    rad(A_s) = Hom(E,E_s)
             = ker[H0(End(E) omega) -> H0((E omega)|D_s)],

where the map evaluates phi(u). Thus genus9 corank2 is EXACTLY rank31
of a32 by33 evaluation map. This rank31 assertion is NOT proved.
Nor has a geometric higher-corank atlas been constructed here.

For the canonical map f the proof also gives

    f_*E=O^32,
    f_*End(E)=O + O(-1)^31 + O(-2)^31 + O(-3).

These splitting types alone are not a proof of independence of the
evaluation conditions for the actual u. The missing information is
precisely that evaluation rank. In the existing tensor the exact
cohomological interface is H=ker[A0 A1], of dimension33, followed by
(x,y)|->y-tx for s=s0+t s1. The positive genus-two test verifies its
rank3 and radical dimension2 for all26 F25 pencil parameters at ALL33
actual normalized points, still retaining the R-sensitive controls.

## A geometric test family — bounded task completed

`hyperelliptic_modification_pencil_rank` proves normal corank2 for every
nowhere-zero section and every basepoint-free canonical pencil in an
explicit stable acyclic hyperelliptic family, in every genus>=4. The
bundles come from four positive modifications of a line-bundle square
at two COMPLETE hyperelliptic fibers. Determinant omega, acyclicity and
stability are proved, not inferred from numerical ranks.

The mechanism works over k(x): the two hyperelliptic components of u
must be independent; the Higgs matrix has only one residue parameter;
after reduction modulo a generic canonical divisor, three trace-free
constant-matrix constraints leave exactly two radical dimensions.

The genus-four member gives an actual nowhere-zero section with SINGLE-
member corank6 but normal corank2. A full24 by13 evaluation matrix and
geometric nonvanishing tests are saved. This is not a dormant oper or an
atlas. An eight-modification extension of the small test was also bounded
at10000 samples; it found no higher normal corank, which is not a proof.
Do not keep searching these auxiliary modifications: root has redirected
the next task to the actual oper and R constraints below.

## Exact evidence

`atlas_liftable_radical` is the next actual-atlas geometric record
(author proof, registration coordinated with root). For the ACTUAL
rank-three Frobenius-form extension O->E3->V, the R-selected hyperplane
ker(lambda_alpha) in H0(V omega) is exactly the space of sections that
lift to H0(E3 omega). It is31-dimensional in genus9. The extra kernel
of M_s is canonically the radical of A_s restricted to this hyperplane.

Every trace-free V-Higgs field lifts uniquely to a trace-free E3-Higgs
field killing e, by acyclicity. Its M_s condition is exactly preservation
of the actual osculating flag along D_s plus a K/O eigenvalue that
restricts from a GLOBAL canonical form. These fields are NOT automatically
infinitesimal Frobenius isometries or atlas tangent vectors.

The intrinsic candidate for the extra kernel line is
PfaffAdj(A_s) lambda_alpha. It is nonzero exactly at corank2, and is
liftable but NOT the common radical vector u. Equivalently it is the
maximal-Pfaffian section of the odd31-square restricted form, of
canonical-pencil degree15. Its GENERIC nonvanishing at every actual
atlas is still unproved. A natural different construction, wedging the
unique canonical covector lifts sigma_s0,sigma_s1 in E3^vee omega,
does give a nonzero liftable section; it is NOT in the common radical.
Thus the rank-three lift alone is not the missing rank argument.
The actual Frobenius form additionally gives F^(2*)E3=E3 omega^8,
so E3 is strongly semistable (stable in genus9). In any basepoint-free
canonical pencil a general dual lift sigma_s is nowhere zero; its
kernel F_s is an ACTUAL degree-zero rank-two bundle with H0(F_s)=0.
No stability of F_s or identification ker M_s=End(F_s) is proved.
This is a possible genuine atlas-family input, not an unrelated
modification search or a substitute for the retained R condition.

`dormant_higgs_rank_reduction` is a new bounded author-proof record
(registration coordinated with root). It separates three scopes.
For ANY stable V with det V=omega and any nowhere-zero u, including
nonacyclic dormant V, quotienting scalar Higgs fields gives a square
3(g-1) rank test with corank(A_s)=1+nullity. For ACYCLIC dormant V,
the24 fixed monomials in L32 give all trace-free Higgs fields through
L=delta^2-P, and their action is the exact identity

    2(Lh)delta U-delta(Lh)U = -Q(Uh).

For ACTUAL fixed-curve atlas points, all R equations and normalization
force the two pole111/112 charts. On either chart eight scalar-Higgs
columns have triangular determinant equal to the leading U coefficient
to the eighth power. Their Schur quotient is24-square. Any nonzero
22-minor forces corank2, by parity; higher normal corank requires all
22-minors to vanish. The analogous test at16 pencil parameters is exact.
No argument proves that R avoids this determinantal locus. All R
equations remain. This is not an expanded-elimination speedup claim.

External directory:
`/Users/julian/Documents/litt3-computation-data/orbit11-structure/`.

- `relative_field.json`: existing exact field presentation; degree7324,
  a9 primitive, Norm(lambda)=4, cubic character1. Lambda is a cube, so
  removing a cubic auxiliary root does NOT reduce this field degree.
- `first_alternating_verification.json`: complete saved first-oper tensor
  comparison. The two-copy basis and every alternating coefficient verify;
 1.06seconds. Both block matrices attain rank32 in exact samples. These
  sample ranks say nothing about orbit0011's atlas existence.
- `q_frame_high_minor.json`: completed orbit0011 minor check, determinant
  norm1, deck weight6,26 constant and6 nonconstant pivots,128.37seconds.
  Original relative-data and first-Q hashes are included.
- `q_frame_symbolic.json`: UNIVERSAL polynomial check of the same minor.
  The26 constant pivots persist before imposing dormant equations. The
  remaining matrix is6 by6 with entries of degree at most9, and
  det Ghat=-det H. Complete in0.35seconds; all entries are saved.
- `q_frame_minor.json`: superseded LOW-pole row selection, bounded after
 180seconds without completing. This is not a zero determinant result.
- `constant_kernel_genus_two_check.json`: complete exact33-point positive
  check and33-point R-sensitive negative control; bordered Pfaffian and
  determinant identities, varying-kernel example, and sharp abstract
  corank10 Schur reconstruction. The canonical-divisor rank formula is
  verified at all26 F25 pencil members of each positive point. Complete
  in0.33seconds excluding Sage startup; both input hashes are recorded.
- `geometric_corank_genus_four.json`: determinant-correct four-modification
  family, acyclicity determinant3, complete cohomology products, and a
  nowhere-zero corank6 single-member witness with normal corank2. A
  bounded10000-section test takes2.91seconds; the theorem is a separate
  parameterized proof, not an extrapolation from those samples.
- `geometric_corank_genus_four_eight_mods.json`: auxiliary stable acyclic
  eight-modification test,10000 samples in2.65seconds, no higher NORMAL
  corank found. General rank question not settled. No further searches
  of this auxiliary family are planned.
- `dormant_higgs_rank_check.json`: all768 fixed first-oper product
  identities and output pole/horizontality bounds checked,10.49seconds.
  Five saved nowhere-zero sections, including both pole111/112 strata,
  have small-matrix rank23. ALL FIVE FAIL R and are NON-atlas controls.
  The separate genus-two positive report now also checks the3-square
  scalar-Higgs quotient at all26 parameters for all33 actual points,
  with its R-sensitive controls retained;0.37seconds.
  Its latest extension also verifies the intrinsic extra Pfaffian line
  and distinguishes it from the common kernel at all33x26 positive
  tests; the entire updated report takes0.45seconds.

Reproduction scripts:
`scripts/acyclic_alternating_atlas.sage`,
`scripts/orbit11_q_frame.sage`, `scripts/oper_relative_field.sage`,
`scripts/alternating_kernel_genus_two_check.sage`,
`scripts/geometric_corank_genus_four.sage`,
`scripts/dormant_higgs_rank_check.sage`.

The first development call to the ordinary Sage quotient constructor
repeated a costly irreducibility test already supplied by the completed
census. That own process was stopped. Direct construction from the
certified field avoids this repetition. No production process was stopped.
A generic Sage22-square Pfaffian call in an optional test strengthening
was likewise stopped after it proved unnecessarily expensive. The test
now uses that example's checked two-square block decomposition and is
again sub-second; only the agent's own process was stopped.

## Actual cyclic-pullback robustness check —2026-09-07

The bounded test does NOT produce a higher-NORMAL-corank atlas. It does
prove that order-two characters cannot cause one, checks two explicit
cyclic cubic covers with actual atlas pullbacks, and rules out identifying
the Hom bundle with the Cartier bundle. Some of the checked ACTUAL
genus-four atlases have single-member corank4 but normal corank2.
Thus a POINTWISE nullity-one claim is false; the generic claim survives
these tests and is still unresolved for arbitrary higher-order characters.

### Exact character obstruction, with the actual atlas retained

Read the audited `acyclic_atlas_towers` and its proof. Let C be its
genus-two curve, V the actual stable acyclic bundle, E=V omega, and u
an ACTUAL atlas direction. For a connected cyclic etale cover pi of
degree N prime to5, write pi_*O=direct-sum chi over its character line
bundles. Assume EVERY H0(V chi) is zero. Then pi^*V is acyclic; its
stability follows from the pulled-back oper, not from an invalid general
stable-pullback assertion. The Frobenius form and full atlas extension
pull back, so all R equations remain satisfied. In particular this
construction does not merely solve a weak N incidence.

For the pulled-back canonical pencil, set H_s=Hom(E,E_s), where E_s
is the actual pushout along s. Exact flat base change and the projection
formula give

    rad(A'_s) = direct-sum_chi H0(C,H_s chi).

The trivial character has dimension2 at EVERY nonzero canonical s:
its alternating4-square pencil has common kernel dimension1, so no
member can be zero and all members have rank2. For nontrivial chi put

    Delta_chi(s): H0(E chi) -> H1(E^vee omega chi)
                  = H0(E chi^-1)^vee.

This is a4-square linear pencil with kernel H0(H_s chi). Both spaces
have dimension4 by stability and Riemann--Roch. Its COMMON constant
right and left kernels vanish. Indeed the canonical-pencil direct sum
holds for V chi and V chi^-1. The stacked connecting map consequently
has kernel H0(End(E) chi), from

    0 -> E^vee chi -> End(E) chi -> E chi ->0.

A nonzero Hom(E,E chi) would be an isomorphism, by stability, forcing
chi^2=O by determinants. For a nontrivial two-torsion chi this is still
impossible: the unique HN line omega^8 in F^*E would have to be isomorphic
to omega^8 chi^5=omega^8 chi. Thus H0(End(E) chi)=0 for every nontrivial
character. This argument uses the actual dormant normalization of V.

Here is a small restriction stronger than merely naming a theta locus.
If a4-square linear pencil with no constant left/right kernel has
generic nullity c>0, write its right and left kernel bundles on P1 as
direct-sums O(-a_i), O(-b_i). All a_i,b_i>=1. Degree additivity for
O^4->O(1)^4, including the nonnegative torsion length r of its cokernel,
gives

    4 = sum a_i + sum b_i + c + r >=3c.

Therefore a positive generic summand here has dimension EXACTLY1.
Its two minimal indices are(1,1), with r=1, or(1,2)/(2,1), with r=0.
For chi^2=O the same determinant pairing makes Delta_chi alternating;
its generic nullity is even, hence must be zero. This rules out an
extra generic radical for EVERY acyclic actual double cover, and more
generally for an acyclic elementary-abelian two-cover of this genus-two
atlas. It does NOT cover characters of order4 or8.

For a higher-order character the remaining exact obstruction is

    det Delta_chi(X s0+Y s1) identically zero.

There are just five degree-four binary coefficients. The inverse
character has the transpose pencil, hence the same nullity. A nonzero
summand would therefore add TWO to the upstairs normal corank while
retaining the actual atlas. The unproved issue is whether the common
zero locus of these five coefficients contains a nontrivial torsion
character whose ENTIRE cyclic subgroup avoids the V-section locus.
Acyclicity of V alone does not identify or remove that locus.

### Two genuinely geometric cubic tests, not torsion enumeration

On C:v^2=t^6+3 choose d^2=3 and let P_+=(0,d), P_-=(0,-d).
Let infinity_+,infinity_- be distinguished by v/t^3 approaching+1,-1.
The two covers are the smooth normalizations obtained by adjoining

    zeta^3=h0=(v-d)/t^3,
    zeta^3=h1=(v-d)(v-t^3)/t^3.

Their divisors are3(P_+-P_-) and
3(P_++infinity_+-P_--infinity_-), respectively. Each displayed degree-zero
divisor is nonprincipal: the first would give a degree-one function;
the second compares two distinct, noncanonical effective divisors of
degree2 on a genus-two curve. Each therefore has exact order3. Kummer
theory gives connected finite ETALE cubic maps, and both sources have
genus4. Composing either cover with an actual automorphism of C gives
the same test for the original chosen atlas; alternatively pull back
the corresponding actual automorphism-translated atlas. Both actual
finite etale legs furnished by the Hermitian atlas survive base change.

The scalar differential is delta=v*d/dt, and the five actual oper
potentials in this differential frame are

    P=3t^4+b0+b1*t+b2*t^2,
    (b0,b1,b2)=(0,+1,0),(0,-1,0),(-c^2,0,c), c^3=2.

For the zeta^j character, j=+1,-1, use
delta_j=delta+j*d/t for h0, and
delta_j=delta+j*(d/t+4t^2) for h1. These follow by differentiating
the ACTUAL Kummer equations; no unramified character is guessed.

For h0 the coefficient space of omega^n in this character has basis

    t,...,t^n;   (v+jd),t(v+jd),...,t^(n-3)(v+jd);
    (v+jd)/t,                                  n>=2.

For h1 its basis is

    t,...,t^(n-1);   H,tH,...,t^(n-2)H;   H/t,
    H=v+j*t^3+jd.                              n>=1.

The pole/vanishing requirements at the four named points verify these
bases directly; each has the correct Riemann--Roch dimension2n-1.
Kernels of delta_j^2-P at n=2,7,12 calculate H0(V chi), H0(E chi),
H0(E omega chi), with the harmless permutation chi->chi^5 of the two
nontrivial characters. In every acyclic case their dimensions are0,4,8.

The three n=2 basis elements give all trace-free Higgs fields by Lh;
their action on the pulled-back actual U is -Q(Uh), checked as an exact
function identity. The fourth Higgs direction is the fifth power of
the unique twisted canonical section, times U. Combining these four
columns with the four columns (1+r*t)^5 H0(E chi) gives an8-square
rank test after projection to the verified8-dimensional target. The
script verifies that every column lies in this same target. Its rank
defect is h0(H_s chi). A nonzero determinant at one r proves generic
vanishing. Five distinct r in F5 also suffice to certify identical
vanishing if it occurred, since the determinant degree in r^5 is<=4.

`scripts/cyclic_genus_two_radical_check.sage` verifies ALL33 original
normalized base points against the full13 equations, transports their
11 projective directions through actual curve automorphisms, and tests
the two characters separately. The exact outcomes are:

| Cover | Acyclic actual oper classes | Tested projective atlas directions | Generic extra summand |
| --- | --- | ---: | --- |
| h0 | Three classes(-c^2,0,c); the other two each have h0(V chi)=1 for both characters | 33 | None |
| h1 | All five actual classes | 55 | None |

Thus all88 acyclic tests have upstairs NORMAL corank2. These are counts
of checked cover/oper/direction combinations, not a claim of88 distinct
curves. Fourteen tested individual pencil members have character ranks
7,7 instead of8,8: their actual upstairs SINGLE corank is4. The saved
witness uses h1 and the original oper(0,1,0), retains the normalized
base p,b point and actual automorphism, and records U and the canonical
section. It disproves only the pointwise strengthening, not generic
nullity1. No arbitrary-bundle or R-failing point is used here.

The external report is `cyclic_genus_two_radical_check.json` in the
orbit11-structure directory. The complete check takes about6seconds
on one low-priority core. No large torsion census or atlas tensor was
built. Initial helper-development errors were a Sage integer argument,
constant coercion and JSON integer encoding; all occurred before a
completed report and are fixed in the successful reproduction script.

### The Hom bundle is NOT the Cartier bundle

There is a genuine obstruction to an isomorphism, not just absence of
a known construction. In fact the following argument works in ANY genus
g>=2 in characteristic5 for this dormant normalization. Put n=g-1.
Then H_s has rank4, degree4n, just as B_C=F_*O/O. The latter is stable
by Joshi, *Stability and locally exact differentials on a curve*,
Theorem1.1 ([primary source](https://www.numdam.org/articles/10.1016/j.crma.2004.02.019/));
its Frobenius pullback contains the diagonal-ideal line omega^4, of
degree8n, as in the audited `all_tensor_cartier_hn` proof.

If E_s is unstable, a line of degree>4n in it gives the rank-two
subbundle E^vee tensor that line inside H_s, of slope>n. Hence H_s
is unstable and cannot be B_C. If E_s is semistable, its canonical
Cartier connection gives mu_max(F^*E_s)<=21n: a destabilizing line
cannot be horizontal (it would descend and destabilize E_s), and its
nonzero second fundamental map gives2 deg(line)<=40n+2n.

The dormant oper supplies the ACTUAL HN sequence

    0 -> omega^8 -> F^*E -> omega^7 ->0.

Dualizing and tensoring by F^*E_s bounds

    mu_max(F^*H_s)<=21n-14n=7n.

This contradicts the degree8n line in F^*B_C. Thus H_s is NEVER
isomorphic to B_C in this setting, even up to a degree-zero line twist.
Their theta loci are not compared by this argument; any relationship
between those loci would require a separate proof. In particular the
Raynaud bad-character locus cannot be substituted for the five exact
determinant coefficients above.

Bounded conclusion: no counterexample to GENERIC nullity1 was found,
and none can come from an order-two character. The two explicit cubic
tests preserve generic nullity1 and furnish actual single-member jumps.
The remaining higher-order character obstruction is explicit but not
proved empty. Do not turn this result into a claim about all cyclic
covers, all actual atlases, or orbit0011 itself.

## Next bounded action / limitations

Latest bounded task COMPLETED: actual cyclic-pullback robustness is
recorded above, with two exact cubic tests, the order-two vanishing
argument and the Cartier-bundle nonisomorphism. The earlier all-four
transferability table and exact field/frame checks remain valid.
Await root's next bounded assignment. The unresolved
structural direction remains ACTUAL OPER/ATLAS GEOMETRY: determine
whether Cartier descent plus the retained R equations forces normal
corank2, or bounds the higher-normal-corank solution locus enough to
reduce any of0008/0009/0010/0011. Distinguish an assertion for ALL dormant V from one
valid only at ACTUAL normalized atlas points. Do not keep searching the
unrelated modification families. No production restart or large-field tensor.

The26-pivot symbolic check, exact all-strata constant-kernel elimination,
geometric radical formula and hyperelliptic family mechanism are complete.
The actual missing rank31 assertion remains unproved. Its scalar bridge
is now proved and exactly checked: twisted_bol_complex already identifies
the trace-free Higgs space with ker Q; acyclicity makes it L(L32); its
action is exactly -Q(Uh). The new24-square quotient is a fully specified
rank test, not yet a vanishing theorem for the higher-normal-corank locus.
The unresolved next implication is whether the actual R fixed points
can meet that locus, or a global geometric mechanism forces rank23 at
some canonical divisor. The actual rank-three interpretation is now
proved: the extra vectors are precisely the parabolic-Higgs fields
described above, or the liftable radical directions. The canonical
Pfaffian candidate vanishes exactly when at least three such fields
exist, and its generic nonvanishing remains the SAME unresolved issue.
Full Jacobian rank does NOT supply this: its proof uses only the common
constant kernel line and allows all five normal coranks. Imposing a
Frobenius-isometry condition on arbitrary Higgs fields would also be
invalid. No more unrelated modification searches are planned.

The outstanding exclusion step remains a genuine atlas obstruction or a
solver preserving the factored coefficient representation. No speedup of
large-field elimination has been measured; do not infer one from the
small frame-selection test. The full97-equation expanded tensor was not
built, since the new representation intentionally retains compositions.
The current proof records are `Theorems/Thm_acyclic_alternating_atlas.md`,
`Solutions/Sol_acyclic_alternating_atlas.md`,
`Theorems/Thm_oper_deck_graded_atlas.md`, and
`Solutions/Sol_oper_deck_graded_atlas.md`,
`Theorems/Thm_alternating_constant_kernel_elimination.md`, and
`Solutions/Sol_alternating_constant_kernel_elimination.md`,
`Theorems/Thm_canonical_divisor_pencil_radical.md`, and
`Solutions/Sol_canonical_divisor_pencil_radical.md`,
`Theorems/Thm_hyperelliptic_modification_pencil_rank.md`, and
`Solutions/Sol_hyperelliptic_modification_pencil_rank.md`, and
`Theorems/Thm_dormant_higgs_rank_reduction.md`, and
`Solutions/Sol_dormant_higgs_rank_reduction.md`, and
`Theorems/Thm_atlas_liftable_radical.md`, and
`Solutions/Sol_atlas_liftable_radical.md`.
No independent audit is claimed.

There is no demonstrated large-field elimination speedup, no new unit
certificate, and no whole-oper exclusion. The result removes unnecessary
preparation operations and provides a structured exact input for later
work; it does not resolve the original two-leg common-cover problem.
