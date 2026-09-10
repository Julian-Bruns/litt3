# Cyclic25 initial geometric comparison audit

Verdict: PASS for the initial comparison, with the local oper-normalization
and repair bookkeeping spelled out below. Prose audit, not formal
verification. This does not assert later-level or full-tower descent.

Auditor: /root/audit_cyclic25_initial_comparison. Date: 2026-09-10.

Scope: Solutions/Sol_cyclic_twentyfive_initial_descent.md, especially (7), (15),
(17)--(19), using the inputs in
Research/PRO_CYCLIC25_INITIAL_TWO_DIGIT_REQUEST.md as established.
The canonical cyclic-five comparison and cyclic_power_additive_norm
are inputs, not independently re-audited here. The parent auditor
handles the attached finite algebra checks and jet recurrence replay.
No actual counterexample was found or claimed.

The parent independently reports PASS for
scripts/verify_cyclic25_jet_precision.py: K2, K3, (K5)21, substitution
of r0+p r1+p2 r2 through degree eight, and the factorial tail from
degree six. This supports the precise scalar/Taylor bounds used here.

## Geometric normalization and the previous tuple

The scalar oper presentation needs the following explanation. Locally
trivialize the determinant horizontally and take a generator l of the
ACTUAL Hodge line. Maximal Higgs implies det(l,nabla_partial l) is a
unit. Normalize l by its inverse square root, choosing the lift fixed
by the prescribed reduced generator, and set m=nabla_partial l.
The determinant is now one, so the connection matrix has diagonal
zero and lower entry one; its remaining entry is the scalar r.
This uses only unit divisions and the invertible integer 2. In
particular there is no division by 5 in restoration of oper form.

Under coordinate change the normalized generator transforms by the
square root of the coordinate derivative, and its derivative gives
the upper jet entry. The new graded identification uses the lift of
this square root at the new precision; the upper filtered entry is
retained only at the preceding precision. Thus the displayed tilde
transition is the prescribed filtered/graded morphism, rather than a
rescaling of a possibly nongluing graph. The actual square-trivial
flat line contributes its locally constant sign throughout this
construction. Its cancellation in the normal Hom line does not
discard it from the filtered bundle.

All this takes place on affine charts of compatible preceding objects,
so it does not create a Hodge line on an incompatible reference.
Taking a first variation of the unit square root, a derivative, or a
reference contraction is additive and preserves e23. Consequently the
first scalar change r1 is indeed in e23 at cochain level. Higher terms
of this normalization consist of products of first variations or
linear second variations; there are no hidden divided products.

For the displayed oper Taylor construction, a change p r1 in r first
affects the output at p3. After the final p3 division its contribution
is an augmentation-preserving additive expression in r1, hence is
zero in D. A change p2 r2 has no effect modulo p4. This explains why
freezing the previous scalar in the additive operator P does not omit
a once-divided e23 carry. The coefficient at order p3 sees only the
reference special fiber; dependence on a non-descended preceding
object contributes above the required precision.

## Integral nonlinear repairs

The proof of (7) is valid: products of e23-functions modulo25 lie in
P2+5P22. Lifting their mod5 part by e22B22,e22B23,e22B24 leaves 5P22,
whose divided reduction is e2. Faithfully flat trivialization is
legitimate here and includes pulled-back bundle coefficients.

Equation (15) follows by reduction in the free regular deck module:
the annihilator of e^r modulo5 is e^(25-r), so a divisible e^r x is
e25 y+5e^r z. Its divided reduction is in e5 for 5<=r<=24.
This argument requires the stipulated free integral modules; it does
not claim the result for arbitrary modules.

In (17), the p Q term is the quadratic contribution that must be
known integrally one digit further. The exact graph expression (12)
gives (18), since the reference lower-left entry vanishes. Ordinary
quadratic curve/displacement terms begin only in the p2 R term of
E/p. The corrected graded construction introduces no additional
division. The final Taylor terms with two changed displacement factors
must use the factorial 2!(n-2)!; retaining degree five is necessary.

First choose the integral first repair A in e23 using the stipulated
deck-linear primitive. The divided linear remainder has reduction in
e5 and therefore permits a second curve correction in e3. On the
bijective summand the inverse preserves augmentation images; on the
nil summand division by e2 lowers e5 to e3. The normal primitive can
then also be taken in e3. Separately, the mod5 quadratic remainder is
in e22 and admits a curve repair in e20 and primitive in e20.

For that separate repair, write Q=Qsharp+5Qprime modulo25 with
Qsharp in e22 and Qprime modulo5 in e2. The actual integral error
Z=delta B_quad-P(Y)+Qsharp is both divisible by5 and in e20.
Applying (15) to Z shows its divided reduction is in e5. This is the
essential new step: merely knowing Q modulo5 lies in e22 would not
have been enough. Both this divided error and Qprime vanish in D.

All remaining terms are used without further division: a first and
second variation gives e23*e3 contained in e2; three first variations
give e21; two first curve/Taylor variations give e22. A linear previous
scalar variation gives e23. Two second repairs start beyond modulo p4.
These classes vanish after projection. Reference differential maps,
Frobenius pullback and normal contractions preserve the stated images.
This accounts also for changes of local coordinate and oper frame:
their expansions use the same linear variations and products, with
only unit denominators. The constant term vanishes on the compatible
canonical reference.

## Additive elimination, residue and consequence

Integral Cech sections give an additive deck-equivariant linear
operator. Eliminating the five bijective blocks is legitimate for
additive maps: their reductions are invertible, and lifting the
inverse through a nilpotent 5-adic ideal uses a finite geometric
series. This requires no common coefficient semilinearity. The
elimination and its inverse preserve augmentation images. The scalar
nil block therefore reduces to e2 Phi and has the form used in (19).

After the preceding nonlinear cancellations, the normal graph
orientation delta S-P(X) gives precisely the negative divided
linear class in (19). The integral relation and the supplied additive
algebra computation then give residue (0,-d5) for the positive linear
part, hence Theta=(0,d5). Coefficient Frobenius acts once on the initial
coefficient; the inverse Frobenius used to choose the second repair
does not act again on that residue. All additional terms in the
second repair are in e3. Independence of the free fourth digit is
also consistent with its once-divided e23 carry lying in e5, as
already established in the request.

Thus the audited initial conclusion is Theta_t(d,b)=d5 e with the
specified normalized source and target bases. Over the algebraically
closed field its zero set is d=0. The established pullback
h*(e_C)=e24 then recovers the GIVEN third truncation along the original
degree25 cover. No claim about descent of the fourth/fifth truncation
or of a full tower follows from this audit alone.

No step of this new comparison uses the explicit parameter t, the
elliptic construction, or the dihedral involution after the stipulated
actual cyclic25 cover, normalized simple-defect operator, compatible
reference tower and integral cochain inputs are supplied. The current
family therefore needs no additional specialization exclusion. An
extension to other families would have to establish those same inputs;
this observation alone is not a generalization of the theorem.

## Primary evidence and citation correction

[LSZ, Lemmas 4.7 and 4.10, Proposition 4.11](https://arxiv.org/html/1311.6424v4)
supplies the actual tilde connection and the morphism combining the
preceding filtered map with the prescribed new graded map.
[LSYZ, lifting construction and Taylor formula](https://arxiv.org/html/1404.0538v2)
supplies the output gluing and Hodge obstruction setup. In the linked
HTML v2 the relevant material is Section 6, around (6.0.1), not
Section 5. This is a citation-numbering correction, not a mathematical
objection. The filtration and residue arguments above are the new
comparison; neither source is represented as proving that residue.

## Separate bounded scope-extension audit

Verdict: PASS, 2026-09-10, same auditor. This paragraph audits only
the extension of the INITIAL comparison to an arbitrary actual
connected cyclic25 finite etale cover h:T→C with g(C)>=2, retaining
an active admissible full tuple and its flat twist. Assume a compatible
reference C5^0 and its actual lifted cover are GIVEN, Psi_C has
bijective dimension 3g(C)-4 and one zero line, and defect(T)=2.
No existence of such a reference is deduced or silently assumed.

Put r=3g(C)-3 and P=C25. Negativity gives H0(T,T_T)=0. Cartan--Leray
then identifies H1(C,T_C) with H1(T,T_T)^P. Since the latter space
has dimension r whereas H1(T,T_T) has dimension 25r, the cyclic
indecomposable-module classification forces it to be free of rank r
over k[e]/e25: each indecomposable contributes one invariant dimension
and has length at most25. Equivalently, the same spectral sequence
shows all positive group cohomology of this H1 module vanishes. The
maximal Higgs identification identifies the negative normal line with
the tangent line, so the same conclusion holds for its H1.

Deck-equivariant semilinear Fitting summands are direct summands of a
free module over the local ring k[e]/e25, hence are free. Cartan--Leray
and naturality of the actual Psi identify the invariant operator with
Psi_C, including the relative coefficient Frobenius. Thus the nilpotent
summand has rank one and the bijective summand rank r-1. More precisely,
one should identify the base operator on invariants FIRST; multiplication
by the norm identifies augmentation coinvariants with invariants for a
free module and then transports that operator to the quotient. No
unjustified identification of invariants and coinvariants is needed.

On the rank-one nil block, defect two means that the scalar multiplying
coefficient Frobenius has e-adic order exactly two. It is e2 u(e) with
u a unit; separate source/target basis normalization gives e2 Phi.
Pullback identifies the base zero line with the invariant line of this
nil block, namely k e24. Its class in the target cokernel is zero since
e24 lies in e2. The bijective summands contribute no cokernel. This
establishes both h*(ker Psi_C)=k e24 and the zero cokernel pullback.

On the actual reference W3 covers the tangent/normal H1 lattices are
free over W3(k), of rank25r, by negativity and cohomology/base change.
Lift the r regular-module generators modulo5. Nakayama gives a
surjection W3(k)[P]^r onto each lattice; equality of W3(k)-ranks makes
it an isomorphism. For the pulled-back two-affine Cech complex, H0=0
makes its differential injective and free H1 lets the quotient map
split deck-linearly. Applying the inverse differential to the boundary
projection produces the required integral deck-linear primitive.
It preserves every augmentation image. This uses no extra projectivity
claim for the affine-section modules.

Consequently these hypotheses supply exactly the module, normal-line,
reference and cochain inputs of the initial calculation above, for
arbitrary r. The integral function filtration holds for any actual
cyclic25 torsor. The calculation therefore proves only the stated
initial consequence: a compatible W5 above the fixed marking forces
the GIVEN W3 truncation to descend along the original h. Neither a
later-level comparison nor full-tower descent is within this extension.
No explicit t-family equation or involution is used.
