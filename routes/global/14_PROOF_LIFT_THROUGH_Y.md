# The cyclic curve and the atlas of `S`

## LEM-GENUS-Y

**Status: `proved-text`.**

Let `k=\bar F_5`, and let `Y` denote the smooth projective curve with
function field

`k(Y)=k(x,y)` with `y^31=x(x-1)`.

Then:

1. `Y` has genus `15`.
2. The finite étale group `mu_31` (equivalently over `k`, the constant
   cyclic group `C_31`) acts faithfully by `y |-> zeta y` for
   `zeta in mu_31(k)`, and the coarse quotient is the `x`-line.
3. The quotient stack `[Y/mu_31]` is the orbifold
   `S=P^1_k(31,31,31)`.
4. The quotient map `Y -> S` is a representable finite étale
   `mu_31`-torsor of degree `31`.

Here the displayed affine equation is shorthand for the smooth projective
model; no assertion is made about a naive projective plane closure.

### Proof

Because `31` is prime to `5`, the Kummer extension `k(Y)/k(x)` is separable
of degree `31`. The valuations of `x(x-1)` at `0`, `1`, and `infinity` are
respectively `1`, `1`, and `-2`; each is coprime to `31`. These are exactly
the three branch points, and each has ramification index `31`.
Riemann–Hurwitz gives

`2g(Y)-2 = 31(-2)+3(31-1)=28`,

so `g(Y)=15`.

The action by `mu_31` has coarse quotient `P^1_x`. Its only nontrivial
stabilizers occur at the unique points over `0`, `1`, and `infinity`, where
the full group fixes the point. Since the action is tame, the quotient stack
is therefore the root-stack orbifold `P^1_k(31,31,31)`.

For any action of a finite étale group `G` on a scheme `V`, the canonical
map `V -> [V/G]` is a representable `G`-torsor. Here `G=mu_31` is finite
étale, so this torsor is finite étale. This does not contradict the
ramification of the coarse map `Y -> P^1_x`: the stack structure records
exactly that ramification.

This lemma supplies the curve/stack identification used in
[file `10`](10_PROOF_SELF_CORRESPONDENCE.md); it does not depend on a prior
assertion of that same identification.
