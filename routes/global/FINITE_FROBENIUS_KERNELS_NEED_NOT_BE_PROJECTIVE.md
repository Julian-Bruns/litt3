# Finite Frobenius kernels need not be projective

**Status:** author proof, 2026-09-05. Author: `/root/x_elliptic_quotient_maps`.

This note is a boundary and replacement for the projectivity theorem for the
*stable* Frobenius-nilpotent part in
`PROJECTIVE_FROBENIUS_DEFECT_AND_NONGALOIS_QUOTIENT_TESTS.md`.  All covers
below are actual connected finite etale covers of smooth projective curves;
no simultaneous Galois closure is asserted.

## 1. Exact finite-depth descent, without projectivity

Let `k` be algebraically closed of characteristic `p`, let

\[
                         W\longrightarrow Y
\]

be a connected finite etale Galois cover with group `G`, and set

\[
 V=H^1(W,\mathcal O_W),\qquad K_r(W)=\ker(F^r:V\to V)\quad(r\geq1).
\]

For every subgroup `H<=G`, pullback induces a natural isomorphism

\[
 \boxed{\quad
 \ker\!\left(F^r:H^1(W/H,\mathcal O)\to H^1(W/H,\mathcal O)\right)
       \simeq K_r(W)^H .\quad}                                      \tag{1}
\]

Indeed, coherent Cartan--Leray gives the Frobenius-compatible sequence

\[
 0\to H^1(H,k)\to H^1(W/H,\mathcal O)\to V^H
       \to H^2(H,k)\to0.                                           \tag{2}
\]

Frobenius is bijective on both group-cohomology terms.  Restricting the
middle arrow to `F^r`-kernels is injective.  Conversely, if
`c in ker(F^r|V^H)`, its image in `H^2(H,k)` is zero, so it lifts to `b` in
`H^1(W/H,O)`.  Now `F^r b` lies in `H^1(H,k)`; bijectivity there supplies a
unique correction `a in H^1(H,k)` with `F^r a=F^r b`.  Then `b-a` is the
required `F^r`-killed lift.  Finally
`ker(F^r|V^H)=ker(F^r|V)^H`, proving (1).

Thus, if

\[
                      d_r(C):=\dim_k\ker(F^r|H^1(C,\mathcal O_C)),
\]

then the exact non-Galois formula at depth `r` is

\[
 d_r(W/H)=\dim_k K_r(W)^H
          =\dim_k\operatorname{Hom}_{kG}(k[G/H],K_r(W)).             \tag{3}
\]

For `r=1`, `d_1(C)` is the `a`-number of the Jacobian: this follows from
Serre duality between Frobenius on `H^1(O_C)` and Cartier on
`H^0(Omega^1_C)`.

## 2. Actual etale counterexample to finite-depth projectivity

The modules `K_r(W)` are **not** projective in general, already for `r=1`
and `G=C_p`.

Cais--Ulmer, Example 8.10 of
[p-torsion for unramified Artin--Schreier covers of curves](https://arxiv.org/abs/2307.16346),
gives actual unramified `C_5`-covers `W -> Y` in characteristic `5` with
`g(Y)=3`, `f_Y=2`, and respectively

\[
                         a(W)=2,4,5.
\]

Take the example with `a(W)=2`.  Cartier--Frobenius duality gives

\[
                         \dim_k K_1(W)=2.
\]

Every projective module over
`kC_5 = k[delta]/(delta^5)` is free, hence has dimension divisible by `5`.
Consequently `K_1(W)` is not projective.  (The displayed Artin--Schreier
equation header in Example 8.10 has a harmless `z^3-z` typographical error;
the prose and the construction specify the unramified `Z/5Z`-cover.)

For comparison, Deuring--Shafarevich gives `f_W=6` and etale
Riemann--Hurwitz gives `g_W=11`, so the stable nilpotent part has dimension
`g_W-f_W=5` and is free of rank one over `kC_5`, exactly as the stable
projectivity theorem predicts.  Projectivity appears only after the finite
Frobenius kernels have grown to the stable kernel.

It follows in particular that the projective-cover/Jordan--Holder formula
for the stable defect cannot be refined by simply replacing the stable
nilpotent module with `K_r(W)`.  Formula (3) remains exact, but its value can
depend on extension data in the nonprojective `kG`-module `K_r(W)`, not only
on its composition-factor multiplicities.

## 3. The stronger structure that really does survive

For an actual unramified `C_p`-cover `W -> Y`, Cais--Ulmer Proposition 8.1
proves that the full local-local Dieudonne module

\[
                       M=H^1_{dR}(W)_{ll}
\]

is free over `kC_p` of rank `2(g_Y-f_Y)`.  Moreover

\[
 \operatorname{im}F=\ker V,\qquad \operatorname{im}V=\ker F
\]

inside `M` are free `kC_p`-modules of rank `g_Y-f_Y`.  Their Theorem 1.2
also gives the full augmentation-ideal filtration: its successive
Dieudonne-module quotients are copies of `H^1_{dR}(Y)_{ll}`.  This is much
richer than stable coherent defect, but it does **not** make
`ker(F^r|H^1(W,O_W))` projective; the `a=2` example above demonstrates the
distinction between the de Rham `BT_1` kernels and the coherent Hodge
quotient.

For a general finite Galois etale cover with group `G`, this result applies
subgroupwise: for every order-`p` subgroup `P<=G`, the actual cover
`W -> W/P` is an unramified `C_p`-cover, so the preceding freeness and
augmentation-filtration statements hold after restriction to `P`.  One
must not promote this to projectivity over `kG` without controlling higher
elementary-abelian subgroups and the Hodge filtration.

The usable finite-depth replacement is therefore exactly (1)--(3): all
depths descend to actual non-Galois intermediate curves by invariants, while
only the eventual stable kernel is projective and admits the simple modular
multiplicity formula.
