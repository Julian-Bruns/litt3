# Finite over-orbifolds of `S`

This file separates the proved geometric bookkeeping from the two wild
exclusions that are still unsupported in this checkout. Throughout,
`k=\bar F_5` and

`S=P^1_k(31,31,31)`.

The full over-orbifold classification is **not proved here**.

## DEF-FINITE-OVER-ORBIFOLD — convention

**Status: definition.**

An orbifold curve here means a smooth proper connected Deligne–Mumford curve
with trivial generic stabilizer. A finite over-orbifold of `S` is an
orbifold curve `O` together with a representable finite étale map

`f:S -> O`.

The trivial-generic-stabilizer condition is essential. Without it, one can
introduce a generic gerbe: the map

`S -> S x B C_5`

given by the trivial `C_5`-torsor is representable finite étale, while the
target has wild generic inertia. The local formulas and the claimed wild
classification are therefore false without the convention above.
“Tame” means that every geometric stabilizer of `O` has order prime to `5`.

An over-orbifold is not the same thing as an arbitrary correspondence
`C ⇉ S`; the missing bridge is isolated in
[file `10`](10_PROOF_SELF_CORRESPONDENCE.md).

## LEM-FIBER-DIFFERENT-BOOKKEEPING

**Status: `proved-text`.**

Let `d` be the degree of `f`. For a geometric point `y` of `O`, let

- `I_y` be its stabilizer and `N_y=|I_y|`;
- `delta_y` be the different exponent of the faithful local action of
  `I_y` on `k[[t]]`;
- `m_y` be the number of ordinary points of `S` over `y`; and
- `n_y` be the number of the three `mu_31`-points of `S` over `y`.

Then

`d=N_y(m_y+n_y/31)`,                                      `(1)`

and the contribution of the fiber over `y` to the different of the induced
coarse map is

`D_y=m_y delta_y+n_y(delta_y-30)/31`.                     `(2)`

Moreover, the coarse curve of `O` is `P^1` and

`sum_y D_y=2d-2`.                                         `(3)`

### Proof

At a point `x` over `y`, representable étaleness injects the source
stabilizer `I_x` into `I_y`. The contribution of `x` to the stack-theoretic
fiber degree is `N_y/|I_x|`. The only possibilities on `S` are
`|I_x|=1` and `|I_x|=31`, which gives `(1)`.

For an ordinary point, the local coarse extension is the quotient by
`I_y`, so its different exponent is `delta_y`. At a stacky point the image
of `mu_31` is a tame subgroup of `I_y`. In the tower of local fields, the
different exponent for this order-`31` subgroup is `30`; transitivity of the
different gives the remaining exponent `(delta_y-30)/31`. This proves `(2)`
and also shows that the displayed quotient is an integer.

The induced coarse map `P^1 -> O_coarse` is finite and generically separable.
Hence `O_coarse` has genus zero. Applying Riemann–Hurwitz to this coarse map
now gives `(3)`.

## LEM-ATMOST-ONE-WILD — at most one wild target point

**Status: `proved-text`.**

Every finite over-orbifold `S -> O` has at most one point whose stabilizer
order is divisible by `5`.

### Proof

Fix a wild point `y`. Write its inertia group as

`I_y=P ⋊ C_T`,

where `P` is the wild Sylow group, `Q=|P|>=5`, and `T` is prime to `5`.
Put `N=QT` and let `epsilon(P)` be the wild excess defined in
[file `13`](13_PROOF_LOCAL_RAMIFICATION.md).
The local different formula is

`delta_y=N-1+epsilon(P)`.

Indeed, the lower inertia groups are `I_0=I_y` and `I_i=P_i` for `i>=1`,
so this is the defining sum for the different exponent.

Substituting this into `(1)` and `(2)` gives the useful exact identity

`D_y-d=m_y(epsilon(P)-1)+(n_y/31)(epsilon(P)-31)`.          `(4)`

If `n_y=0`, then `m_y>0` and
`epsilon(P)>=Q-1>=4`, so `(4)` is positive.

Suppose `n_y>0`. The injected source inertia supplies an order-`31` subgroup
of the tame quotient. Let `b` be the first lower break of `P`. If `31|b`,
then

`epsilon(P)>=b(Q-1)>=31*4=124`.

If `31` does not divide `b`, the tame-character lemma in file `13`, applied
to the order-`31` subgroup on `P/P_{b+1}`, shows that its `F_5`-dimension is
a positive multiple of

`ord_31(5)=3`.

Thus `Q>=5^3=125`, and again
`epsilon(P)>=b(Q-1)>=124`. In either case `(4)` is positive. Therefore every
wild point contributes strictly more than `d` to the total different. Every
other local different contribution is nonnegative. Two wild points would
therefore make the left side of `(3)` exceed `2d`, contradicting `(3)`.

## PROP-WEAK-WILD-EXCLUSION

**Status: `open`.**

The desired statement is:

> There is no finite over-orbifold `S -> O` whose wild inertia has
> `P_2=1`.

What is proved locally is the following. In the weakly ramified case the
first break is `1`, `P` is elementary abelian of order `Q=5^q`, and

`delta_y=QT+Q-2` and `T | Q-1`.                            `(5)`

Indeed, `P=P_1` and `P_2=1`, while the first lower quotient
`P_1/P_2` is elementary abelian. The different formula follows from
`epsilon(P)=Q-1`; the divisibility follows from the tame-character lemma in
file `13` with first break `1`.

The previous version of this file then asserted, without displaying the
canonical equation or its case analysis, that `(5)` forces exactly one
additional tame stacky point and leads to contradictions for `Q=5,25` and
for `Q>=125`. Those calculations are not present in this repository and
cannot be refereed or reconstructed from the summary sentence. Accordingly,
the exclusion itself is not a proved proposition here.

## PROP-NONWEAK-WILD-EXCLUSION

**Status: `open`.**

The desired statement is:

> There is no finite over-orbifold `S -> O` whose wild inertia has
> `P_2 != 1`.

File `13` now proves the Swan divisibility, tame-character divisibility,
summation-by-parts identity, and exact leading-commutator constraint that a
valid elimination may use. The remaining argument in the old text consisted
only of an undefined list of variables and a claim that later arithmetic
tables eliminate all cases. The cited files
`COMP-LOCAL-ARITHMETIC-CHECKS` and `ALG-LOCAL-SEARCH`, and any executable
certificates for them, are absent. No finite table or handwritten
elimination survives here. This claim must therefore remain open.

In particular, the commutator result in file `13` cannot be replaced by an
unqualified assertion that all breaks share one residue modulo `5`.

## THM-OVER-ORBIFOLD-TAME — conditional assembly

**Status: `conditional-proof`; not an established theorem.**

The precise useful conclusion would be:

> For every finite over-orbifold `f:S -> O`, the target is tame and there is
> a representable finite étale map `h:O -> S_0` with
> `h f` 2-isomorphic to `pi_0:S -> S_0`.

This conclusion follows if all three of the following inputs are supplied:

1. `PROP-WEAK-WILD-EXCLUSION`;
2. `PROP-NONWEAK-WILD-EXCLUSION`; and
3. a characteristic-`5` tame overgroup theorem that gives the displayed
   factorization through `S_0`, not merely the complex discrete
   commensurator statement.

The first two inputs eliminate the only possible wild point. The third then
classifies the remaining tame over-orbifold. Input 3 is not proved by
[file `12`](12_PROOF_PROFINITE_ORBIFOLD_GROUP.md): that file records an
unverified complex Fuchsian theorem and explains the additional
specialization issue.

Even this conditional over-orbifold theorem does not by itself treat an
arbitrary self-correspondence. Constructing a suitable common finite
over-orbifold remains the separate open gate in file `10`.
