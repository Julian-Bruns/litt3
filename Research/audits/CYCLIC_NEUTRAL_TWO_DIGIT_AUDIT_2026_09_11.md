# Neutral cyclic-five two-digit descent — focused audit

Date: 2026-09-11. Auditor: `/root/audit_cyclic_neutral_two_digit`.

Verdict: **PASS for the proposed cyclic-five theorem and its neutral
Galois full-tower consequence, with the exact full-tuple hypotheses.**

This is a fresh prose audit of
[the integrated proof](../../Solutions/Sol_neutral_galois_witt_descent.md), not formal
verification. The finite checker is supplementary algebraic evidence.
No coefficient correction is required. The proof does not establish
primitive/non-Galois (N5), nor the original unmarked common-cover problem.

Audited SHA-256:

- Original audited draft, now integrated in `Solutions/Sol_neutral_galois_witt_descent.md`:
  `1bda74180cc2ae131721f90d65f183e1f6291039fd67ed315c0e8f1a19064200`.
- `scripts/check_cyclic_neutral_two_digit.py`:
  `8792f80502100515737b1ae3d2779a3bbbaad6bb5b081e7fe0e6d2db2dfd2fce`.

## Scope and inherited inputs inspected

The input is an ACTUAL connected finite etale cyclic-five map, with
equal upper/lower active-admissible nilpotent defect. The full previous
weight-one periodic tuple, its prescribed graded identification, and
its actual square-trivial flat line remain part of compatibility.
For a compatible original marked map through W_n, the conclusion
recovers its GIVEN W_(n+1) source from a GIVEN compatible W_(n+2)
extension. It does not descend the latter at its full finite precision.

I inspected the statements and relevant proofs of
`neutral_degree_five_obstruction_structure`,
`cyclic_power_early_descent`, `cyclic125_bootstrap`, and
`defect_preserving_etale_descent`, together with the obstruction
definition. The concrete new concern justified inspecting the earlier
uniform-comparison audit: its theorem had a rank-one e^2 block and a
compatible initial reference, neither of which may simply be imported
into this theorem. The checks below address precisely their replacement.

I also checked the input category and filtered/graded gluing against
[LSZ, Theorem 4.1 and Lemma 4.10](https://arxiv.org/html/1311.6424v4),
and the first normal derivative against
[LSYZ, Theorem 6.2](https://arxiv.org/html/1404.0538v2).
Those sources supply the higher construction and its derivative, not
the new descent theorem on their own.

## 1. Smith blocks: left-right equivalence is sufficient

For the actual cyclic map, the regular tangent and normal lattices and
their integral negative Cech sections are supplied by the newly audited
neutral-degree-five structure theorem. This uses an arbitrary genuine
DESCENDED smooth reference; it does not require a compatible next lower
periodic extension. The scalar H0(omega^2) is their regular dual.

Neutrality identifies every upper defect section with a pullback.
Equivalently, the entire kernel of the linearized Hodge operator is
annihilated by e=sigma-1. Over R=k[e]/(e^5), a Smith entry e^j has
kernel e^(5-j)R. Multiplication by e kills this kernel exactly when
j=1; for 2<=j<=5 it does not. Hence all nonunit Smith entries are e,
and there are exactly d of them. The other entries are units.

Independent source and target bases therefore give

    Psi = diag(I_(r-d), e I_d) Phi.

No semilinear conjugacy or assertion about iterated Psi is used. The
elimination requires only an invertible selected source-to-target unit
block, not an invariant Fitting subspace of an endomorphism. Independent
left-right bases supply exactly that. They lift integrally and preserve
the deck action. Their restrictions to invariants give independent
lower source/target coordinates: the unit blocks give the lower image,
and the e blocks give the lower kernel and cokernel coordinates.
Thus using the word "unit" rather than an iterated-ordinary decomposition
is mathematically important, and the proposed proof does so.

## 2. The two-digit geometric comparison does extend to this scope

Let m=n-1. The output under comparison is defined modulo 5^(m+2),
and its normal displacement starts at 5^m. The curve displacement is
5^(m+1)x. The latter ideal is square-zero in the given W_(n+2) curve
for every n>=2, including n=2. Thus its combined two-digit curve
coordinate is an actual deformation coordinate; no separately chosen
second repair replaces the given curve digit.

Extend the existing lower curve smoothly and extend its preceding
GLOBAL filtered oper. The vanishing H1(omega^2)=0 constructs the latter
without solving periodicity. Its graded Higgs identification extends
through the maximal Higgs isomorphism; the flat two-torsion line is
retained. Consequently the new graded object together with this genuine
preceding filtered object is a legitimate higher inverse-Cartier input.
An unglued collection of output Hodge graphs is never used as that input.

The regular cotangent, scalar, and normal modules give the same integral
equivariant coordinates, frames, and Cech contractions as in the global
input-oper comparison. Their construction precedes any use of the
special e^2 block. Replacing that block by d independent e blocks changes
only which cohomology variables are left unimposed. The unit block,
normal-boundary block, and projected global-scalar block still have
invertible additive reductions. Their ordered integral inverses are
equivariant, including coefficient inverse Frobenius in its proper order.

The normalized weight estimate is also independent of block type or
rank. Corrected tilde gluing and

    K_j = diag(5,1) 5^j L_j diag(5,1)^(-1)

give integral ordered Taylor presentations with the full factorial
coefficient. Expanding the extra-five curve variable before the
Frobenius division gives valuation at least m(s-1) at displacement
degree s. Consequently modulo W_2 only degree two can survive beyond
the additive part, and it survives only at m=1. This conclusion includes
factorial-divisible Taylor terms, rather than dropping them.

At this precision there is an additional simplification: the first
changed genuine preceding scalar is 5^m R, and every scalar-dependent
inverse-Cartier output term gains 25. Its feedback is therefore zero
modulo 5^(m+2). The scalar equation remains necessary to identify the
preceding global input with the appropriate reduction of the actual
output; its invertible identity block is not removed. This verifies
explicitly that an unknown non-descended first scalar digit cannot
silently enter the fixed coefficients of the two-digit operator.

After eliminating boundary graphs, global scalars, and unit cohomology,
the actual remaining equation consequently has the asserted form

    Lx = N eta + 1_(n=2) 5 Q(bar x),
    L mod 5 = e Phi,

on d regular blocks. Translation by a nonzero constant auxiliary
solution preserves the weights; its new linear terms are retained in
L. The remaining quadratic map admits an equivariant bi-additive
polarization, since 2 is a unit. Mixed coefficient Frobenius operations
remain additive in this sense and commute with the abstract deck action.

### Why the incompatible n=2 constant is genuinely lower geometry

This is the new use not supplied by the statement of the old initial
theorem. At n=2 the original H1 is already the prescribed compatible
special-fiber object. A global auxiliary H2 lifting it need not solve
periodicity. It nevertheless supplies the preceding object for the
higher transform producing H3. Local output graphs, projected scalar
equations, and boundary equations are therefore defined off the nil
zero locus as in the genuine global-input chart.

At x=0 their auxiliary solution is unique and equivariant, hence
invariant. Fixed marked curve deformations have unique lifted deck
maps, by negative tangent H0; uniqueness forces their group relations,
and freeness on the special fiber preserves a free action. Taking its
quotient gives an ACTUAL lower curve deformation. The fixed global
oper and its grading descend with it. Restricting the chosen equivariant
Cech sections to invariants gives the lower cochain sections, not an
unrelated quotient representation.

The first normal residual at this point is thus precisely the usual
lower next Hodge obstruction, after its unit/image correction. The
invariant target lattice is N O^d and the coefficient embedding
eta -> N eta is injective. Hence its remaining constant has the form
N eta with eta mod 5 equal to that actual lower cokernel obstruction.
This identification occurs BEFORE taking the upper obstruction cokernel.
It is valid at n=2 without a compatible C3 reference. If the final nil
equation vanishes, the local output graphs glue; their scalar discrepancy
is then global, so the projected scalar equality becomes actual previous
flow compatibility. Conversely the given compatible upper tuple satisfies
these equations. This is enough for the proposed necessity argument.

## 3. Quadratic augmentation and the norm digit

After one coefficient transport y=Phi(x), reduction of the equation gives

    e bar y = e^4 bar eta,
    bar y = e^3 bar eta + e^4 b.

In the regular-function realization, e^3R=ker(e^2)=P1. For any
equivariant bi-additive B, translation of each argument in ker(e^2)
is affine in the integer translating parameter. Its output is therefore
quadratic in that parameter, so e^3 B=0. In a regular target block,
ker(e^3)=e^2R. This proves Q(bar y) in e^2R^d even with mixed coefficient
transports and cross-block products. It is not the false rule that
products multiply augmentation powers.

Write A=L Phi^-1=eI+5M. Only the reduction of M is needed: division
of A-eI by five canonically gives an additive deck-equivariant map
between reduced modules. One may choose an integral lift, but neither
its uniqueness nor additional coefficient-linearity is required.
Since M commutes with e, it preserves the augmentation ideal. Therefore
bar y in e^3R^d makes aug M(bar y)=0. Likewise aug Q(bar y)=0.

Applying augmentation to the integral equation uses aug(e y)=0 and
aug(N eta)=5 eta. It follows that 5 eta=0 modulo 25, hence

    eta mod 5 = 0,        bar y = e^4 b.

The sole divided step is in the free coefficient module after
augmentation. No assertion that division by five preserves an
augmentation image is made. The quadratic repair cannot change this
norm coordinate. There is one coefficient Frobenius in the leading
source equation, not a new fifth power after the integral division.

## 4. Recovery, uniqueness, and the Galois consequence

Vanishing of the actual lower obstruction makes the invariantly
corrected lower reference compatible. The given leading upper
displacement is now in ker Psi_T and is deck-invariant. Neutrality
identifies it uniquely with a lower kernel digit. Changing the lower
reference by this digit and lifting the ORIGINAL finite etale cover
recovers the GIVEN T_(n+1), with its marking. Naturality and negative
normal H0 identify the specified upper Hodge line; maximal Higgs
graded automorphisms are scalar, and the actual flat two-torsion line
has its prescribed unique infinitesimal lift.

Iteration requires the already GIVEN upper tower, not existence of a
new one. Injectivity of tangent pullback and uniqueness of marked maps
make the lower truncations and maps compatible. The inherited ample
canonical/Grothendieck-existence argument then algebraizes them.

For a defect-neutral Galois cover Z->C, defects on every intermediate
quotient equal the endpoint value by injectivity of defect sections.
A subnormal series of a Sylow-five subgroup gives actual cyclic-five
successive quotient maps. Apply the result to the given tower along
those original maps. The last map Z/P->C has prime-to-five degree and
is still neutral, so the established prime-to-five theorem applies
without requiring P normal in G. No simultaneous Galois closure is
being assumed. In an application with another original source map,
the given upper tower and that map remain unchanged.

This does not settle neutral primitive degree-five maps: their
individual Galois closure can add defects, and its entire kernel need
not be deck-invariant. The returned S5 norm model consequently lies
outside the Smith-e argument, exactly as stated in the proposed proof.

## Checks executed and limitations

The supplied checker replayed successfully: 625 mixed-operator samples
and 3125 equivariant shifted-product tests. I additionally tested 300
rank-three regular-block operators with arbitrary noncommuting
coefficient matrices over W_2(F25), coefficient Frobenius, and arbitrary
second input digits. Each divided augmentation residual was -eta.
These checks cover algebra only; the geometric argument is Sections 2
and 4 above. No geometric counterexample search, geometric existence
claim, or arbitrary non-Galois descent is certified by the tests.
