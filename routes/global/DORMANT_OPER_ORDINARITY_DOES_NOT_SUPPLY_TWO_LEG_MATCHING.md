# Dormant matching, automatic rank-four reductions and ordinarity boundaries

Version 2, 2026-09-08. Consolidated author/source check, not an independent
audit. Retains the explicit symmetric-cube normalization proof. Corrects
version 1's conflation of ordinary DORMANT opers with Mochizuki's ordinary
ACTIVE nilpotent indigenous bundles; matching dormant opers alone does not
satisfy his canonical-lifting hypotheses. The original problem is UNSOLVED.

## 1. Matching is extra structure on the same source

For ACTUAL finite etale maps f:Z→X, g:Z→Y of smooth projective hyperbolic
curves in characteristic five, put DOp_n(C)=dormant projective rank-n
oper classes on C. The condition for a common dormant oper is

\[
 f^*DOp_2(X)\cap g^*DOp_2(Y)\ne\varnothing
       \quad\hbox{inside }DOp_2(Z).                       \tag{1}
\]

The maps here retain the SAME Z. Separate endpoint existence, separate
ordinary choices, or even ordinary pullback of EVERY endpoint choice does
not imply (1). Two finite nonempty subsets need not meet.

A general genus-two curve has five distinct ordinary dormant rank-two
opers, while every genus-two fiber has scheme length (5³−5)/24=5.
This follows from finite flatness, the ordinary etale locus and the
degree formula in [Wakabayashi, Theorem 3.3 and Corollary 5.4](https://ems.press/content/serial-article-files/41233);
the required inequality is 5>2(2−1). The five-element count is an endpoint
count, not an upper bound for DOp_2(Z) on a higher-genus common source.
Thus it gives no pigeonhole argument. Genuine rank-two uniqueness upstairs,
TOGETHER with ordinary chosen pullbacks, would be additional information.

For canonical Witt lifting the relevant object is instead a specified
ordinary active nilpotent indigenous PAIR. The exact compatible-marking,
ordinary-pullback and same-source hypotheses, and the one-leg proof, are in
[the canonical lifting theorem, Section 2](33_MOCHIZUKI_CANONICAL_LIFTING_LIMIT.md).
Uniqueness identifies lifts of the SAME pair, not unspecified bundles on
the same underlying curve. Ordinary dormant opers are not eligible merely
because the word “ordinary” occurs: the two loci are disjoint in the
nilpotent moduli ([Wakabayashi, Remark 2.1.6](https://arxiv.org/pdf/1602.07061)).
Nor do [canonical diagonal liftings](https://arxiv.org/abs/2209.08528) of
selected dormant structures select a common rank-two reduction or identify
two independently constructed curve lifts.

## 2. Rank four is automatic, even with a specified theta normalization

[Hoshi, Proposition 1.4, Remark 1.4.2 and Theorem 2.1](https://www.kurims.kyoto-u.ac.jp/~yuichiro/rims1822revised.pdf)
supply the Cartier rank-(p−1) oper, rank-two dormant existence on EVERY
smooth projective curve of genus≥2, and uniqueness in rank p−1 up to
dormant line twist. At p=5 the map Sym³:DOp_2(C)→DOp_4(C) is therefore
constant. Its five distinct generic genus-two inputs prove noninjectivity.
Functoriality makes the rank-four pullbacks equal automatically; it cannot
recover (1). The independent rank-n/rank-(p−n) duality endpoint is also in
[Wakabayashi, Corollary 4.3.3 and Theorem 6.2.2](https://www.ms.u-tokyo.ac.jp/journal/jms240301.pdf);
a separate counting bound is not a uniqueness hypothesis.

The stronger bundle statement retains the line twist explicitly.
Let C/k have genus≥2, k=bar(F5), F:C→C^(1), L²≅ω_(C^(1)), and
E=B_C^1⊗L^(−1). Then for some rank-two Q on C^(1) with det Q≅O,

\[
 E\simeq\operatorname{Sym}^3Q.                            \tag{2}
\]

The isomorphism can be symplectic; after F-pullback it respects the
canonical zero-p-curvature connection AND the oper filtration.

Proof of normalization. Set θ=F^*L⊗ω_C^(−2), so θ²≅ω_C. The lowest
quotient of F^*E is ω_C⊗F^*L^(−1)=θ^(−3). Choose a dormant SL₂-oper U
with oper subline θ: twist any initial choice by the required two-torsion
line with its dormant connection. Its symmetric cube has the same lowest
quotient and remains an oper because the Kodaira–Spencer multipliers
1,2,3 are invertible. Hoshi's uniqueness gives

\[
 F^*E\simeq\operatorname{Sym}^3U\otimes(N,\nabla_N).
\]

The lowest quotient forces N≅O. Both determinant connections are trivial,
so (N,∇_N)^4 is trivial. Writing ∇_N=d+η gives 4η=0, hence η=0.
Cartier descent now gives (2) with Q=U^∇ and trivial determinant.
The alternating Cartier pairing on E and the symmetric-cube pairing
differ by a scalar because E is stable; rescale the isomorphism over k.
The needed stability/pairing input is retained in the
[Cartier tensor proof](../../Solutions/Sol_all_tensor_cartier_hn.md).
This is the original author twist-removal argument, not a new audited result.

Thus even an untwisted symplectic rank-four reduction is universal in
this setting. Its existence on both endpoints cannot serve as a new
common-cover test or choose compatible rank-two reductions.

## 3. Fixed-degree preservation is not arbitrary-cover preservation

[Wakabayashi, Definition 2.1.2, Theorem B and Section 5](https://arxiv.org/pdf/1602.07061)
treats a specified oper and its pullback. Upstairs ordinarity implies
downstairs ordinarity. Conversely, for n=2 and p=5, the precise generic
assertion fixes d prime to 5 FIRST: there is a dense open U_d in curve
moduli on which EVERY dormant rank-two oper stays ordinary on EVERY
cyclic etale cover of degree dividing d (Definition 5.1.1/Lemma 5.1.2).

This is ∀d ∃U_d, not one asserted finite-type open working for all degrees,
nor membership of a specified bar(F5)-curve in their infinite intersection.
It neither descends an arbitrary upstairs oper nor compares two legs.

The new [tangent_bundle_cyclic_refinements](../../Theorems/Thm_tangent_bundle_cyclic_refinements.md)
is AUTHOR PROSE. It gives controlled good cyclic choices under its stated
theta hypotheses, but also prime-avoiding cyclic towers making every
defect in a finite endpoint pool grow when the endpoint Jacobians are
simple over bar(F5). Both actual legs survive above any prescribed common
source. Degrees in these bad towers need not be prime; refined sources
need not be jointly minimal. This does not refute the fixed-d theorem or
an ordinary-MINIMAL-source assertion. It still supplies no matching datum.

## 4. Jacobian ordinarity and oper ordinarity remain separate

Maximal p-rank of J(C) is not the definition of ordinary dormant oper:
the latter is etaleness at the chosen point of dormant-oper moduli.
Dormant existence alone does not assert an ordinary point; a length-five
genus-two fiber need not be reduced merely from its length.

[Lange--Pauly, Theorem 2, Proposition 3.1 and Section 8](https://arxiv.org/pdf/math/0309456)
give, for every classically ordinary genus-two curve in odd characteristic,
a zero-dimensional local-complete-intersection Frobenius-destabilized base
locus of length 2p(p²−1)/3, or 80 at p=5. The sixteen theta-characteristic
blocks are isomorphic and have length five. Reducedness is stated for a
GENERAL curve, not every ordinary curve. The counting proof cited in
Section 1 separately chooses classical ordinarity and avoidance of the
nonordinary dormant locus. No universal implication between these two
conditions is imported here; a bounded literature check is not a proof
that no stronger theorem or counterexample exists.

The [exact common-connection spectrum](../../Theorems/Thm_coreless_connection_spectrum.md)
now limits possible compatible structures, with author-only evidence.
Its empty alternative is not a cover exclusion. Conversely the separate
[audited coreless Mumford construction](DORMANT_OPER_CORELESS_MUMFORD_CONSTRUCTION.md)
DOES provide actual coreless bi-etale examples with a shared dormant oper,
including specialization to bar(F5); it identifies none of our fixed
endpoints and asserts no ordinary shared-source property.
The [audited finite-pool destruction example](FINITE_ETALE_COVER_DESTROYS_ALL_ORDINARY_INDIGENOUS_DATA_ON_ONE_CURVE.md)
has a distinct nonsimple-Jacobian scope and is retained independently.
Neither these positive examples nor this boundary note resolve (1) for
the project's chosen pair.
