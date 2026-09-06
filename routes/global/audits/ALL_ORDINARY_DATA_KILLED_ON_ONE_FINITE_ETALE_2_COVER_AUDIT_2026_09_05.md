# Audit: all ordinary data killed on one finite étale 2-cover

Date: 2026-09-05.
Auditor: `/root/all_ordinary_data_killed_finite_cover_audit`.
Verdict: PASS for the proposed conclusion, with the meaning of ordinary and
the source dependencies specified below. No breaking issue found.

## Scope and dependencies

I read the complete hyperelliptic-invariance/70-quartic note, the explicit
nonsquare degree-four failure note, and the inverse-character Cartier
criterion. I also inspected the deformation-data translation and the
simultaneous étale lifting source note. This audit accepts the established
quartic classification and the cited Mochizuki ordinary criterion; it does
not claim a new independent proof of every antecedent source theorem.

The conclusion being audited concerns ordinary **nilpotent unmarked
projective** indigenous bundles on the fixed curve
`X: y²=x⁵−x` over an algebraically closed field of characteristic five.
Ordinary means Mochizuki's induced-Frobenius condition, not the distinct
condition called ordinary for dormant opers.

## Exact scalar verification

Both Python blocks in
`ORDINARY_NONSQUARE_INDIGENOUS_DATUM_FAILS_ON_ETALE_DEGREE_FOUR_COVER.md`
were extracted and executed with ordinary Python 3 and their own integer
encoding of F25. No Sage or finite-field matrix backend was used. All
assertions passed, with output:

```text
{2: 28, 4: 35}
Verified: ordinary on X and T; kernel dimension one on Y.
```

This verifies the stated original 63-double search and, for the transformed
datum, its normalized equation, invertibility on X and T, the two explicit
anti-deck matrices, the rank-one singular block, and the stated kernel.
The even branch subset `{1,3t}` is proper and nonempty. Its double-cover
class is nontrivial on T and all its valuations are even. The geometric
connectedness and étaleness argument is therefore sound.

I additionally checked the square representative using the same scalar
functions. Its coefficient polynomial is

```text
f = [4,3,0,1,1] = 4(1+x+2x²)²,
H = f(u²) = [4,0,3,0,0,0,1,0,1].
```

The normalized quartic equation and the ordinary 3-by-3 determinant on X
both pass. The quadratic `1+x+2x²` has discriminant 3, and its two roots
are distinct nonbranch points. Thus the quartic has four distinct zeros
of order two on X. A separate enumeration of all invertible 2-by-2
matrices over F5 gives an orbit of 20 nonrational F25 points and ten
Frobenius-conjugate pairs, verifying the required transitivity on square
supports. The previously established normalized scalar uniqueness turns
support transitivity into tensor transitivity.

On T, `rho=du/v` has order two at each infinity and is a unit at finite
branch points. Therefore `v rho²` is nonzero and regular, including at
infinity, where its order is zero. The twisted Cartier formula gives

```text
T_(H rho⁴)(v rho²) = rho C(H du) = 0.
```

Indeed H has no nonzero coefficient in an exponent congruent to four
modulo five. Also `pi*eta=2rho`, so `pi*(eta⁴)=rho⁴`; there is no missing
scalar in H. This proves the square representative's failure on the
connected étale double T, and automorphism transport proves it for all ten.

## Completeness and the ordinary qualification

Dormant bundles have zero p-curvature, hence zero square Hasse invariant
and zero induced map on the nonzero space H¹(X,tau_X). They cannot be
ordinary in the sense used here. The cited Mochizuki Chapter II,
Proposition 3.2 excludes ordinary non-admissible bundles.

I freshly checked [Bouw–Wewers, Theorem 4.11 and Definition
4.12](https://arxiv.org/html/math/0505275v2). These identify active
nilpotent projective classes with deformation data, identify markings and
unmarked spikes in terms of the local signature, and characterize
admissibility by absence of unmarked spikes. On an unmarked admissible
curve the only signatures are 1 and 3/2. Quartic descent consequently
has orders zero and two. This supplies the converse needed to apply the
70-tensor classification to every ordinary nilpotent projective class.
The bijection and the intrinsic square Hasse invariant prevent an
additional multiplicity of projective classes over one normalized tensor.

Fresh access to Mochizuki's PDF timed out, and the local environment lacked
a PDF text extractor. Its Proposition 3.2 and ordinary criterion were
therefore checked through the existing source-checked repository notes,
not newly re-extracted from the PDF during this audit. This is a stated
audit dependency, not a detected gap in the proof.

## One common cover and a Galois 2-group

For each of the seventy tensors choose its transported witness as an
actual map to the same X. If `a* s0=s`, the witness map for s is
`a^(-1) composed with pi0`; this direction makes the equality of pulled
back tensors explicit.

The fiber product of these finite étale covers is nonempty and finite
étale over X. Any connected component W is a smooth proper connected
curve. Its projection to each witness curve is finite étale and
surjective: its image is nonempty, open and closed in that connected
curve. Nonzero regular quadratic kernel vectors remain nonzero under
these separable maps. Naturality of twisted Cartier then keeps them in
the kernel. Thus W kills all seventy data simultaneously.

Each degree-four witness is a tower of two double covers. Its monodromy
preserves the two-block partition of a four-element fiber, hence embeds
in `C2 wreath C2`, a group of order eight. Double witnesses have monodromy
C2. The simultaneous monodromy embeds in the product of these 2-groups.
The corresponding connected Galois cover therefore has a finite 2-group
as deck group, remains étale, dominates every witness, and kills every
ordinary nilpotent datum from X. No ramification is introduced by taking
this Galois closure.

## Nonbreaking presentation suggestions

State the Mochizuki meaning of ordinary at the theorem, and include the
ordinary-to-admissible converse when passing from seventy tensors to all
ordinary bundles. Give the inverse automorphism in the transported
witness formula to avoid a pullback-direction ambiguity. Keep the scope
explicit: the resulting curve may have ordinary indigenous bundles of
its own, and this theorem supplies neither a nonlifting span nor a Litt
counterexample.
