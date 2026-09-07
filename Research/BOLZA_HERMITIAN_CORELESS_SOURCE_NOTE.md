# Bolza reduction supplies a concrete positive route

2026-09-07. Bounded primary-source note by
`/root/hermitian_coreless_sources`. Research inference for main-agent
review, not a promoted theorem or a claim that Litt3 is solved.

## Exact primary arithmetic input

Katz–Katz–Schein–Vishne, *Bolza quaternion order and asymptotics of
systoles along congruence subgroups*,
[author PDF](https://u.math.biu.ac.il/~scheinm/text61.pdf),
[arXiv record](https://arxiv.org/abs/1405.5454):

- Section 4 identifies the Bolza curve with `B: y^2=x^5-x`.
- Theorem 1.4 identifies the projective norm-one group of its maximal
  quaternion order with `Delta(3,3,4)`.
- Corollary 10.4 gives the Bolza surface group Gamma as a normal
  subgroup of index24 in that triangle group.
- Theorem 1.5 places Gamma between principal congruence subgroups
  of levels2 and sqrt(2).
- Propositions 5.3 and 5.5 identify the quaternion algebra over
  `F=Q(sqrt(2))` as split at the positive real embedding and every
  finite place except `(sqrt(2))`.

These facts concern the uniformizing group of the genus-two curve
itself, not quaternionic multiplication on a genus-two Jacobian
parametrized by some other Shimura curve.

## Elementary identification of the required characteristic-five curve

Work over `k=Fbar_5`. Choose `a^6=2`, `r^2=2`, and `b^2=-r`.
For `C: v^2=t^6+3`, put

    s=t/a,  x=r(s+1)/(s-1),  y=b*v/(s-1)^3.

Then `r^5=-r`, `v^2=2(s^6-1)`, and

    x^5-x = -2r(s^6-1)/(s-1)^6 = y^2.

The inverse Mobius transformation shows this is a function-field
isomorphism, hence an isomorphism of smooth projective curves.
The Bolza model has good reduction at5: the roots of `x^5-x` are
simple. Its Cartier–Manin matrix is zero because coefficients of
degrees4,3,9,8 in `(x^5-x)^2=x^10-2x^6+x^2` vanish. No uniqueness
classification of superspecial genus-two curves is needed.

## How the actual coreless two-leg construction follows

This is a proposed application of the mechanism already written in
`routes/global/CORELESS_HOM_ZERO_CORRESPONDENCE_IN_CHARACTERISTIC_FIVE.md`,
Sections3–6; it needs review in the new setting before promotion.

Take either prime lambda over7 in F. Its residue field is F7 and
the quaternion algebra splits there. Strong approximation for the
norm-one group (Voight, *Quaternion algebras*,
[Main Theorem28.5.3](https://link.springer.com/chapter/10.1007/978-3-030-56694-4_28))
gives a rational norm-one commensuration g, integral away from lambda,
congruent to1 modulo2 at the dyadic place, with lambda-adic trace of
negative valuation. Thus g is loxodromic on the local tree. The dyadic
condition preserves Gamma's local level. For any n, the intersection
of Gamma with `g^n Gamma g^-n` contains the kernel of reduction of
Gamma modulo a sufficiently high power lambda^m. Its normal-core
quotient therefore has order dividing

    |SL2(O_F/lambda^m)| = 336 * 7^(3(m-1)),

which is prime to5. The same statement holds on the conjugate side.
The intersection gives two actual finite etale maps from the same
compact surface to B. For sufficiently large n the generated group
is nondiscrete: Gamma has only finitely many discrete overgroups,
whereas its conjugates by g^n are distinct (its normalizer is bounded
lambda-adically). A common meromorphic function would be invariant
under this nondiscrete group and hence constant. This gives corelessness.

Both prime-to5 normal closures allow extension of the two covers over
the good-reduction Bolza model after finite extension of the DVR,
using [Stacks Theorem58.30.3](https://stacks.math.columbia.edu/tag/0BUQ).
Uniqueness of the stable source model identifies the two extensions
by their generic-fiber identity. This is precisely the step that
retains both maps on one smooth projective source.

[Krishnamoorthy, *Correspondences without a core*, Lemma4.10,
printed p.1188](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf)
preserves corelessness in this smooth proper finite etale family with
geometrically integral fibers and hyperbolic source. Therefore this
mechanism yields a coreless self-correspondence on C, subject to the
main agent checking the displayed arithmetic application. No paper
located here states this particular characteristic-five example verbatim.

## Hermitian transfer: do not assume arbitrary Cartesian preservation

Arbitrary finite etale endpoint extensions do not preserve corelessness
on every component. For a coreless `X <- Z -> Y`, base change both
endpoints to Z itself. The double Cartesian product has a component
on which both new maps to Z are identities, hence has a core.

Instead, lift the GIVEN Galois degree9 etale cover `H -> C` along the
Bolza good-reduction model. Proper smooth lifting of finite etale
covers gives a characteristic-zero cover with surface group
`Gamma_H normal in Gamma`, index9. Apply the high-power construction
directly to Gamma_H. The finite-group normal-core argument in the
existing note's Section4 applies to this prime-to5 index9 subgroup
and its conjugate; both leg closures still have order prime to5.
The same finite-overgroup and same-source specialization arguments
then give a self-correspondence with special endpoint the original H.
This avoids any claim that arbitrary Cartesian extension preserves
corelessness and requires no simultaneous Galois closure.

The search therefore found a concrete positive mechanism, rather
than evidence for an exclusion on superspecial curves. Review the
arithmetic/spreading steps before recording a canonical theorem.
