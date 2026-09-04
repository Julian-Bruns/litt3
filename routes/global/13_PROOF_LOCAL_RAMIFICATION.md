# Local ramification results

All groups in this file act faithfully on `k[[z]]`, where
`k = \bar F_5`. The statements below are the local facts that can be
proved from the retained material. They are necessary inputs to the wild
over-orbifold analysis in
[file `11`](11_PROOF_OVER_ORBIFOLD_CLASSIFICATION.md); they do **not**
supply the missing global arithmetic elimination in that file.

## Status

Every named lemma and theorem in this file is `proved-text`. The downstream
weak and non-weak wild exclusions remain open in file `11`.

For a nonidentity automorphism `sigma`, put

`j(sigma) = v_z(sigma(z)-z)-1`,

and, for a finite `5`-group `P`, use the lower filtration

`P_i = {sigma in P : j(sigma) >= i}` (`i >= 1`).

Thus a lower break `b` means `P_b != P_{b+1}`. We write

`epsilon(P) = sum_{i >= 1} (|P_i|-1)`.

## LEM-WILD-EXCESS-IDENTITY — wild excess as a sum of breaks

**Status: `proved-text`.**

For every finite `5`-subgroup `P` of `Aut_k k[[z]]`,

`epsilon(P) = sum_{sigma != 1} j(sigma)`.

Consequently,

`epsilon(P)-(|P|-1) = sum_{sigma != 1}(j(sigma)-1)`.

Indeed, a fixed nonidentity `sigma` is counted in `|P_i|-1` exactly for
`1 <= i <= j(sigma)`. Interchanging the two finite sums proves both
identities.

## THM-LOCAL-SWAN-DIVISIBILITY — divisibility at the first break

**Status: `proved-text`.** This proves, and slightly generalizes, the
first-break-`1` statement previously recorded only as a proof sketch.

Let `P` be a nontrivial finite `5`-subgroup of `Aut_k k[[z]]`. Suppose its
first lower break is `b`, so

`P=P_1=...=P_b` and `P_{b+1}` is a proper subgroup of `P`.

Put

`q = dim_{F_5}(P/P_{b+1})`.

Then

`5^{ceil(q/2)} | epsilon(P)-b(|P|-1)`.

In particular, if the first lower break is `1`, then

`5^{ceil(q/2)} | epsilon(P)-(|P|-1)`,

where `q=dim_{F_5}(P/P_2)`.

### Proof

The first ramification quotient `A=P/P_{b+1}` is elementary abelian. Let
`A^vee=Hom(A,C^times)`, so `|A^vee|=5^q`. We use the usual Swan conductor
of a complex representation of `P`:

`Sw(V) = sum_{i>=1} (|P_i|/|P|) codim(V^{P_i})`.

Swan conductors are integers. For the regular representation, the
`P_i`-fixed subspace has dimension `|P|/|P_i|`; hence

`Sw(C[P]) = sum_{i>=1}(|P_i|-1) = epsilon(P)`.

Decompose the regular character as

`C[P] = direct_sum_chi (dim chi) chi`,

where `chi` runs over the irreducible complex representations of `P`. It
follows that

`epsilon(P)-b(|P|-1)`

`= sum_{chi != 1} (dim chi)(Sw(chi)-b dim chi)`.                 `(1)`

Every nontrivial irreducible representation that factors through `A` is a
one-dimensional character. Its Swan conductor is exactly `b`, so its term
in `(1)` is zero. It remains to group the irreducibles nontrivial on
`P_{b+1}` into orbits under twisting by `A^vee`.

For such a `chi` and `lambda in A^vee`, the restrictions of `chi` and
`chi tensor lambda` to every `P_i` with `i>b` agree. For `i<=b`, neither
irreducible has a `P`-fixed vector. Thus

`Sw(chi tensor lambda)=Sw(chi)`.

Write `dim chi=5^a` and let the stabilizer of `chi` in `A^vee` have order
`5^s`. The standard facts that irreducible degrees of a finite `5`-group
are powers of `5` and that

`5^s <= (dim chi)^2 = 5^{2a}`                              `(2)`

are enough. For completeness, `(2)` follows by choosing, for each
stabilizing `lambda`, a nonzero intertwiner
`chi -> chi tensor lambda`. Under conjugation by `P`, these intertwiners
belong to distinct character eigenspaces of `End_C(chi)`, and are therefore
linearly independent.

The total contribution of the twisting orbit of `chi` to `(1)` is

`5^{q-s} 5^a (Sw(chi)-b 5^a)`.

The last factor is an integer. If `a >= ceil(q/2)`, the factor `5^a`
already gives the required divisibility. Otherwise `(2)` gives

`q-s+a >= q-2a+a = q-a >= ceil(q/2)`.

Every orbit contribution is therefore divisible by `5^{ceil(q/2)}`, which
proves the theorem.

The standard representation-theoretic inputs used here are precisely:
additivity and integrality of Swan conductors, the displayed filtration
formula for the Swan conductor, the regular-character decomposition, and
the fact that irreducible degrees of a finite `p`-group are powers of `p`.
We also use the standard ramification fact that the first nonzero lower
quotient is elementary abelian. No classification of finite subgroups of
`Aut_k k[[z]]` is being assumed.

### Scope

This is a divisibility for the sum of the breaks. It gives no congruence
for an individual break, and it does not say that a formal break sequence is
realized by a finite subgroup of `Aut_k k[[z]]`.

## LEM-TAME-CHARACTER-GRADED — the tame action on a lower quotient

**Status: `proved-text`.**

Let

`I = P ⋊ C_T` be a finite subgroup of `Aut_k k[[z]]`,

where `P` is its wild `5`-Sylow subgroup and `T` is prime to `5`. Choose a
generator `tau` of `C_T` and a parameter in which

`tau(z)=zeta z`,

with `zeta` a primitive `T`-th root of unity. If `P_b/P_{b+1}` is nonzero,
then

`ord_{T/gcd(T,b)}(5) | dim_{F_5}(P_b/P_{b+1})`.              `(3)`

Here the multiplicative order modulo `1` is understood to be `1`.

To see this, write an element of exact break `b` as

`sigma(z)=z+a z^{b+1}+O(z^{b+2})`.

The leading-coefficient map embeds `P_b/P_{b+1}` into the additive group of
`k`. Direct substitution gives

`tau sigma tau^{-1}(z)=z+a zeta^{-b}z^{b+1}+O(z^{b+2})`.

Thus the image is an `F_5`-subspace stable under multiplication by
`zeta^{-b}`, hence a vector space over `F_5(zeta^b)`. The degree of this
field over `F_5` is the order in `(3)`. Replacing `zeta^{-b}` by
`zeta^b` changes no dimension statement.

Equivalently, if `q_b=dim_{F_5}(P_b/P_{b+1})`, then

`T | b(5^{q_b}-1)`.                                          `(4)`

This is a necessary condition only.

## LEM-LEADING-COMMUTATOR — exact lower-break commutator

**Status: `proved-text`.** This replaces the former vague “same-residue
Lie obstruction.”

Suppose `sigma` and `tau` have exact lower breaks `r` and `s`, with leading
coefficients `a` and `c`:

`sigma(z)=z+a z^{r+1}+O(z^{r+2})`,

`tau(z)=z+c z^{s+1}+O(z^{s+2})`.

If `5` does not divide `s-r`, then their commutator has exact break `r+s`.
Indeed, its first nonzero term is

`(s-r)ac z^{r+s+1}`

up to the choice of commutator convention. In particular,
`P_{r+s}/P_{r+s+1}` is nonzero.

This exact statement can rule out a proposed filtration when it has pieces
at `r` and `s` but no piece at `r+s`. It does **not**, by itself, imply that
all breaks of an arbitrary finite local group have one residue modulo `5`.
Any use of such a blanket “common residue” rule needs an additional maximal-
break or vanishing argument.

## LEM-SUMMATION-BY-PARTS-TAME — tame divisibility of the excess

**Status: `proved-text`.**

Let `b_1<...<b_r` be all lower breaks. Set

`q_i=dim_{F_5}(P_{b_i}/P_{b_i+1})`

and

`d_i=log_5 |P_{b_i+1}|=sum_{j>i}q_j`.

Counting elements according to their exact break gives

`epsilon(P)`

`= sum_i b_i(|P_{b_i}|-|P_{b_i+1}|)`

`= sum_i b_i 5^{d_i}(5^{q_i}-1)`.                            `(5)`

If `P` is normalized by the tame cyclic group `C_T` above, `(4)` says that
every summand in `(5)` is divisible by `T`. Therefore

`T | epsilon(P)`.

## What remains open downstream

The results above justify the local divisibility filters used in file `11`.
They do not prove `PROP-NONWEAK-WILD-EXCLUSION`: the retained repository has
neither the claimed finite arithmetic table nor the cited
`COMP-LOCAL-ARITHMETIC-CHECKS`/`ALG-LOCAL-SEARCH` sources. In particular,
the exact commutator lemma must not be silently strengthened to manufacture
that missing elimination.
