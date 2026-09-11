# Actual Heisenberg cover and defect audit

Auditor: `/root/audit_actual_heisenberg_defect`.
Date: 2026-09-11.
Verdict: PASS for the stated scope. No mathematical correction.

Scope: Sections 1--4 of `Research/HEISENBERG_DEFECT_PLAYGROUND.md`,
specifically the global construction and classification of the 155 actual
exponent-five Heisenberg covers of each fixed bad double, the complete
negative Čech model, the six-generator rank method, and the degree-125
cover at case 0 / plane 0 / central choice 0. Section 5 and subsequent
Frobenius orbit reductions are outside this audit. Other executed cover
ranks are also outside its numerical scope.

This is a mathematical prose and exact-computation audit, not Lean
verification. The original unmarked common-cover problem remains open.

## 1. Actual projective connected covers

The biquadratic model is the actual étale double of the original genus-two
curve. Its two radicands are coprime and squarefree. The finite coordinate
algebra has the four character components `1,kappa,ell,v`; it is already
normal. Removing the two points at infinity or the fibre of `u=0` gives
two affine opens of the smooth projective double, covering it. Their
intersection is the finite Laurent algebra used in the calculation.

For the stated UT3 multiplication, left multiplication by
`(-chi1,-chi2,kappa0)` gives exactly the overlap transformation in the
note. Direct substitution into all three Artin--Schreier equations gives

    f3,O = f3,U + kappa0^5-kappa0 - chi1^5*f2,U + f1,O*chi2.

Thus the displayed sign and both cross terms are correct. The exact
Laurent split makes the right sides regular on the respective affine
opens. The degree-125 algebras are free with the indicated 125 monomials,
and the triangular Jacobian has diagonal `-1`. The invertible overlap
transformation glues a finite étale H-torsor over the projective double.
It is therefore smooth and projective as well.

The two chosen AS classes are independent. Consequently the quotient by
the center is connected. For a subgroup of H surjecting onto H/Z, two
elements with independent quotient images have nonzero commutator; it
contains Z and hence all of H. Applied to the geometric monodromy image,
this proves connectedness, not merely connectedness of an intermediate.
Étale Hurwitz gives genus `1+125(3-1)=251`.

The Lang equation on H1(O) is an affine equation for the additive map
`v -> M v^[5]-v`. Its homogeneous kernel is the three-dimensional F5 AS
space. It is surjective over the algebraic closure. Since this kernel is
already rational over F_(5^12), Frobenius of that field translates any
solution by an element of order dividing five. Every such equation with
right side in F_(5^12) therefore has a solution in F_(5^60). This justifies
the producer's finite field choice for the general construction.

## 2. Exactly 155 unmarked H-covers of a fixed double

There are 31 planes in the three-dimensional geometric AS character
space. Fix one plane and an ordered quotient-character basis. Any two
lifts to H differ by a central F5 character. An automorphism of H acting
trivially on H/Z necessarily fixes Z, since the commutator determines
its action there, and it changes the central coordinate by an arbitrary
linear form in the two quotient coordinates. Its effect on the lift
character is exactly the chosen plane.

Hence the lift classes form an affine copy of
`H1_et(D,F5)/plane`, containing five elements. Adding `j*chi3` to the
central overlap primitive represents these five distinct classes.
Changing the chosen quotient basis does not further identify them: an
automorphism relating two lifts with the same fixed independent quotient
characters must induce the identity on H/Z. Thus the count is 31 times
five for covers up to D-isomorphism, not just for a rigidly marked variant.

The independently checked AS bases and all recorded planes support the
inputs to this classification; a full 155-cover Hodge census is not
needed for the classification and is not claimed here.

## 3. Complete tangent Čech space and actual Hodge multiplier

At either infinity, the pole orders of the four components are
`0,deg(R),deg(S),5`, while `eta=du/v` has zero order two. A tangent
coefficient therefore needs pole order at most `-2`. Rounding integral
u-exponents gives precisely the four tangent cutoffs `-1,-2,-3,-4`
for both degree patterns `(1,4)` and `(2,3)`. For O they are
`0,-1,-2,-3`. The prime-to-five character decomposition rules out a
missing regular section obtained by cancellations between components
at the two infinity points.

The surviving classes are exactly the stated three O classes and six
tangent classes. The torsor overlap is triangular with respect to
`i+j+2l`; replacing `w3` by its cross term strictly lowers the weight,
and all reductions by the three monic equations do so too. Its graded
pushforward tangent bundles are copies of T_D. Since they have H0=0
and H2=0, each successive graded piece contributes its full six H1
classes with no relation lost at a boundary. Thus the 750 classes are a
complete basis, and descending Laurent elimination is exact. There is
no formal-series truncation or unchecked negative-degree cutoff.

The pre-cohomology map `b -> A*b^5` is the established actual multiplier
of the active datum, transported by the actual étale map. For the audited
case the replay also reconstructs `R=u(u-3)` and
`A=[u^4](S0*(u-alpha)^2)*S0`, with
`S0=u(u-1)(u-2)(u-3)`, directly from source index 4 and twist index 7.
This agrees with the saved input coefficient by coefficient. Raising
the nested quadratic coefficients to the fifth power in the independent
replay retains their Frobenius, rather than fixing coefficient-field
elements artificially. The quartic A has pole order at most eight at
infinity, while a fifth power of a regular tangent coefficient has zero
order at least ten. Thus the displayed map also preserves the exact
regular tangent lattice; affine regularity follows from polynomial A.

## 4. Six actual free generators and complete rank recovery

Summing the top monomial `w1^4*w2^4*w3^4` first over the central
translations, then over h and g, gives `(-1)^3=-1`, as an identity
before cohomology. The h cross term causes no residue after the first
sum has removed w3. The six norms are consequently the negatives of
the six pulled-back base tangent classes.

The inherited negative-cohomology theorem `etale_p_witt_obstruction`
applies to this actual connected étale cover: tangent H1 is a free
rank-six k[H]-module, and norm identifies coinvariants with invariants.
The six top classes therefore give a basis of the coinvariants, and
Nakayama proves they are a free k[H]-basis. This addresses the source
basis itself, not just the span of the six computed output vectors.

The deck transformations are actual automorphisms fixing A. Thus
`Psi(g*v)=g*Psi(v)` for the semilinear map. On linearization, coefficient
Frobenius twists the source coefficients while fixing the abstract group
elements; applying the target deck representation to the six images is
therefore correct. The ordered augmentation monomials used by the
producer form a basis by their triangular binomial expansion in the
ordered actual group basis. They need not commute. All 750 orbit
vectors span the complete image, so no source matrix inverse is needed.

## 5. Independent computational evidence

Independent implementation:
`scripts/audit_actual_heisenberg_defect.py`.
It imports neither producer module. Its base algebra is a nested pair
of Sage quadratic quotient rings, its torsor multiplication accumulates
ordinary polynomial terms before reduction, and its rank construction
uses all actual group elements `g^a h^b c^d` followed by PARI dense
finite-field rank. These differ from the producer's four-component
XOR multiplication, incremental monomial reductions, augmentation
orbit vectors, and sparse greatest-pivot elimination.

The independent full matrix rank is 713, recovered in 6.43 seconds.
The nested algebra also verifies the scalar Lang identity, all three
defining equations after the complete overlap substitution, regularity
on both opens, and the exact norm `-1`.

All six top Hodge columns 744--749 match coefficient for coefficient.
Seventeen independently reconstructed h-deck columns also match:
`0,24,108,300,500,738,739,740,741,742,743,744,745,746,747,748,749`.
These include all top and all next-highest-weight columns. The producer's
remaining deck columns were code-reviewed; this audit does not relabel
the 17-column independent replay as a separate replay of all 750 deck
columns. The complete independent rank calculation does use all 750
stored deck columns, and the producer's separate full group-relation
check is valid on every basis vector.

For each of the twelve bad doubles, the independent nested algebra
also reconstructs H1(O) Frobenius, verifies the three supplied fixed
classes and their independence, and checks all 31 distinct planes and
the five complementary central choices. This gives 12 checked AS bases
and 372 checked planes.

The main independent replay took 327.38 seconds on one CPU. Its receipt
is `Research/computations/actual_heisenberg_defect_audit_20260911.json`,
SHA-256
`482dad6674b339edad4dd90677bd5701ccb44fee360d91089e4f85316a458094`.
The short postcheck additionally verifies independence of the two saved
actual cover characters and records the hashes of every raw curve/AS
input; it reruns the independent rank, chart, norm, deck spotchecks, and
all-plane checks in 23.86 seconds. Its receipt is
`Research/computations/actual_heisenberg_defect_audit_postcheck_20260911.json`,
SHA-256
`50cc6b9dd4057af2389ea9c88b10aa8dc5b0eea8d7fc85b59145dadfb1a4dff0`.

Exact producer evidence checked:

| File | SHA-256 |
| --- | --- |
| `scripts/backup_heisenberg_defect.py` | `ae3166a720728fe3284a7e04f3d3fb5b289136f69e41e78cb5b3ed8d8909aa4b` |
| `scripts/rank_heisenberg_free_columns.py` | `49159a5118253de168ccb0e4bc01a54951c9c332ce020079efd4b4f8c5d86120` |
| `heisenberg125_pilot_high.json` | `d2fe3183b287e48f035c1fbbb31d401033bc8a8d03efcc04fff202436c46547e` |
| `heisenberg125_deck_full_case0_plane0.json` | `723b952cd00c4911414633b809e846f805b0f2de77c925093066826e47dc113b` |
| `heisenberg125_rank_case0_plane0.json` | `f48760373f59a8a3db4b102976f661da1925a36625c69abfdca643052177ba7a` |

The JSON files in this table are in `Research/computations/`. The
auditor script SHA-256 is
`9659239f82751aa96391417c648ad8d99ff656fe60831dbfe91fa725277d6d6b`.
The numerical replay uses the original degree-60 coefficient field.
The later degree-12 option and further cover cases are not numerical
claims of this audit.

## 6. Limits

The numerical conclusion here concerns precisely one actual cover.
It does not say that every Heisenberg cover has defect 37. The canonical
`augmentation_width_defect` supplies the separate universal lower bound
25. Neither fact forces an arbitrary common source to dominate one of
these covers. No simultaneous Galois closure, non-Galois quotient
argument, higher-Witt repair, or common-cover exclusion is inferred.

Minor wording clarification recommended to the author: the 155-class
count is over the algebraic closure, as in the project conventions.
The receipt fields are fields of definition, not an additional count of
arithmetic twists over F125. This does not change the result's scope.
