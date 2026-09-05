# Hyperelliptic étale covers have arbitrary abelian factors

**Status:** classical-theorem consequence and explicit Honda--Tate calculation,
2026-09-05. Prepared by `/root/gluing_cohomology_rigidity`, with the decisive
Bogomolov--Tschinkel reference identified by `/root`; not independently audited.

This records a precise boundary for the
[projective Frobenius-defect comparison](PROJECTIVE_FROBENIUS_DEFECT_AND_NONGALOIS_QUOTIENT_TESTS.md).
It specializes the one-sided domination result already recorded in
[97, §4](97_GALOIS_TO_NONGALOIS_PASSAGE_IN_COMMON_COVER_RESULTS.md) and
[98, §4](98_FULL_SIGNED_FROBENIUS_GROUP_AND_SHARP_PACKET_RANGE.md).
It is not a new universality theorem and is not a bi-étale construction.

## 1. Every prescribed abelian factor occurs

Let `k=Fbar_p`, with `p>=5`, and let `Y/k` be any smooth projective
hyperelliptic curve of genus at least two. For every abelian variety `A/k`
there is a connected finite **Galois étale** cover `W -> Y` such that

\[
                         J_W\sim A\times B
\]

for some abelian variety `B/k`. No ordinarity assumption on `Y` is needed.

Indeed, [Bogomolov--Tschinkel, *Unramified correspondences*,
Theorem 1.7 and Corollary 2.5](https://math.nyu.edu/~tschinke/papers/yuri/02ram/ram5.pdf)
assert that every such `Y` has a finite étale cover dominating any prescribed
projective curve `T`. The hypothesis is `p>=5`, not `p>5`; the source is
arbitrary hyperelliptic, not just their auxiliary genus-two curve.
The theorem is on p. 2 of this author PDF, with its characteristic-p proof
in §2, pp. 3--4. That proof was checked for the present application.

Choose a smooth projective curve `T` with a surjective homomorphism
`J_T -> A`. The existence of `T` is the generating-curve theorem;
[Milne, *Jacobian Varieties*, Theorem 10.1](https://www.jmilne.org/math/xnotes/JVs.pdf)
gives a proof over any infinite field, hence over `k`. Now take
`Z -> Y` finite étale and `h:Z -> T` surjective as above. The norm map
`h_*:J_Z -> J_T` is surjective: `h_*h^*=[deg h]`. This identity is valid
even if `h` is inseparable, and multiplication by a nonzero integer is
an isogeny in characteristic `p`. Thus `J_Z -> A` is surjective.

Take the Galois closure `W -> Y` of the actual finite étale cover
`Z -> Y`. It is again finite étale, and the map `W -> Z` preserves the
surjection `J_W -> J_Z -> A`. Poincaré complete reducibility gives the
displayed isogeny. All varieties and maps descend to some finite extension
of the original finite field of definition, but that extension is not fixed.

In particular this holds for **every ordinary genus-two curve over
`Fbar_5`**, and for any prescribed absolutely simple nonordinary `A`.
It also holds simultaneously for any finite collection, with prescribed
multiplicities, by applying the assertion to their product.

## 2. Explicit factors with every denominator at least three

For every integer `b>=3`, set

\[
                  P_b(T)=T^{2b}+5T^b+5^b\in\mathbf Z[T].
\]

There is an abelian variety `A_b/F_5` of dimension `b` with Frobenius
polynomial `P_b`, and

\[
          \operatorname{NP}(A_b)
              =(1/b)^b\oplus(1-1/b)^b.                 \tag{1}
\]

Here superscripts denote slope multiplicities.

To verify existence, the polynomial is monic and 5-symmetric. On setting
`U=T^b`, the two roots of `U^2+5U+5^b` are complex conjugate with absolute
value `5^(b/2)`, since `25-4*5^b<0`. Hence every complex root of `P_b`
has absolute value `sqrt(5)`. The general Honda--Tate polynomial criterion
has no extra local multiplicity obstruction over a prime field: see
[van Bommel--Costa--Li--Poonen--Smith, *Abelian varieties of prescribed
order over finite fields*, §2, Remark 2.3](https://math.mit.edu/~poonen/papers/allorders.pdf),
p. 5 of the author PDF. Thus `P_b` is realized in dimension `b`.

Its 5-adic coefficient polygon has vertices

\[
                         (0,b),\quad(b,1),\quad(2b,0).
\]

The negatives of its segment slopes give (1). The variety `A_b` is
geometrically simple: the slope multiset of a nonzero abelian isogeny
factor is symmetric under `lambda -> 1-lambda`; for an isocrystal, the
multiplicity of a reduced slope with denominator `b` is divisible by `b`.
Such a factor must therefore contain at least `b` copies of each of the
two slopes in (1), and already has dimension at least `b`.

Consequently, for every fixed ordinary genus-two `Y/Fbar_5` and every
`b>=3`, some finite Galois étale cover of `Y` has `A_b` as an isogeny
factor. In particular the denominator-three example is

\[
                  P_3(T)=T^6+5T^3+125,
\]

with slopes `1/3,1/3,1/3,2/3,2/3,2/3`. This is an existence theorem for
the cover of each fixed `Y`, not an explicit equation or a degree bound
for that cover. The factor dimensions and slope denominators are
unbounded as the cover varies.

## 3. Exact boundary for the current module route

Thus no condition on an ordinary genus-two `Y/Fbar_5` can exclude a
prescribed abelian isogeny factor from **all** its finite étale covers.
Nor can such a condition bound all nonordinary slope denominators or
all dimensions of geometrically simple nonordinary factors.

This does not invalidate subgroup-sensitive tests on a specified cover
`W -> Y` and its actual quotients. The construction supplies no subgroup
`H<=Gal(W/Y)` for which `W/H` is the prescribed target curve `X`, and
does not make the map to `X` étale. Even the stronger choice `T=X`
provides only `W -> Y` étale and `W -> X` surjective, potentially ramified.
An étale refinement does not remove that ramification.

There is also no conflict with generic ordinarity for bounded monodromy
classes. The Galois group, degree, and finite field of definition here
are uncontrolled. The assertion is pointwise over `Fbar_p`; it is not
an assertion about the geometric generic point of a positive-dimensional
moduli space. In particular, no nonempty open subset over `Fbar_5` can
exclude a fixed `A` for **all groups at once** at all its geometric
closed points, although separate bounded-group open exclusions remain
possible.
