# Igusa Kummer differential audit — 2026-09-05

Auditor: /root/igusa_kummer_differential_audit. Date: 2026-09-05.

## Verdict and scope

**PASS for the Kummer/differential mechanism, with the normalization made explicit below.** Given the stated compact fine quaternionic moduli curve in characteristic 5, its selfadjoint Morita factor, and the transported-generator Hecke correspondence, there is a global function-field class `[q] in k(I)^*/k(I)^{*5}` with

```
eta = dlog(q) != 0,
div(eta) = 5 S,
div(q) = 5 E,
div(dq) = 5(E + S),
f*eta = g*eta,
f*q = u^5 g*q for some u in k(Z)^*.
```

Here `S` is the reduced supersingular divisor and `E` is an integral degree-zero divisor. In particular, `eta` is **Cartier-fixed**, whereas `dq` is Cartier-zero. These must not be conflated. As requested, this audit does not pursue the strategic consequences of a shared Cartier-fixed form for a purported coreless correspondence with additional shared Cartier-zero pluriforms.

This audit does not independently certify genus 5 of the particular tame-level base, degree 12 and connectedness of a selected Hecke component, or corelessness. It verifies the mechanism conditional on those separately checkable geometric inputs. If `g(C)=5`, the mechanism itself yields `deg(S)=16`, `g(I)=41`, and `deg(E+S)=16`.

## Primary-source anchors

* [Buzzard, *Integral models of certain Shimura curves*](https://www.ma.imperial.ac.uk/~buzzard/maths/research/papers/shimura.pdf), §1: canonical principal polarization after fixing the positive involution; transpose isogeny composed with the isogeny is multiplication by its false degree. §4, Definition 4.8 and Proposition 4.9 plus the following paragraphs: the quaternionic Igusa moduli problem, regularity, connectedness, and ramification. Proposition 5.1 gives the canonical-sheaf formula; Theorem 5.2 gives the canonical Hodge section with precisely simple supersingular zeros. The proof of Proposition 5.1 explicitly discusses choosing a selfadjoint idempotent for odd characteristic and cites Diamond–Taylor, Lemmas 6–7.
* [Ulmer, *p-descent in characteristic p*](https://dlulmer.github.io/research/papers/1991.pdf), §3 constructs the canonical invariant differential from a generator of `ker V`. **Lemma 5.2**, not §3, identifies the extension group. The paragraph immediately after Lemma 5.2 identifies the Kummer class with the Frobenius-descent image of that generator. §7 and Corollary 7.7 identify the logarithmic extension differential with the canonical modular differential in the elliptic case. The [2019 correction](https://dlulmer.github.io/research/papers/1991-correction.pdf) concerns Proposition 3.3 on a constant curve's Verschiebung Selmer group and a bibliographic typo; it does not affect these assertions.
* [Katz, *Serre–Tate local moduli*](https://web.math.princeton.edu/~nmk/old/serretatelocmod.pdf), **Main Theorem 3.7.1, printed p.166**, is the needed compatibility between polarized Kodaira–Spencer and `dlog` of the Serre–Tate pairing. Its applicability to the rank-one direct summand supplies the quaternionic version; a modular-curve q-expansion assertion alone would not do so.

Ulmer's author-hosted PDF and correction were downloaded and their relevant text inspected with macOS PDFKit, since the web reader failed on these two URLs. The Buzzard and Katz passages were inspected through the web reader/search extraction.

## 1. Polarization and the Morita factor

Fix the positive involution `*` and its canonical principal polarization `lambda_A` uniformly in the moduli problem. Choose once and for all an integral rank-one idempotent

```
e in O_D tensor Z_5,  e^2=e,  e*=e.
```

Write `G=e A[5^infinity]`, using either consistent convention for `e` versus `1-e`. The decomposition into `e` and `1-e` factors is orthogonal: the Rosati relation gives

```
<e x,(1-e)y> = <x,e(1-e)y> = 0.
```

The perfect polarization on the direct sum therefore restricts to a perfect alternating duality on each factor. Thus the restriction on `G` is principal, not merely an isogeny needing an unspecified degree correction. The factor has height 2 and dimension 1. This is a statement about a p-divisible direct summand; it does not assert an elliptic abelian subscheme of `A`.

Existence of a selfadjoint rank-one idempotent at this odd good prime is compatible with the integral orthogonal involution on `M_2(Z_5)`: choose a primitive vector of unit norm for its unimodular symmetric rank-two form and project orthogonally onto its span. Such a vector exists in odd residue characteristic. It is essential to retain this choice when defining the Hodge line, polarization, and Hecke maps.

## 2. One Igusa generator defines a global Kummer class

Let `F=k(I)` and write `Fr` for relative Frobenius of `G`. Over this ordinary generic point,

```
0 -> ker Fr -> G[5] --Fr--> ker V -> 0.
```

The Igusa point `P` gives `Z/5 -> ker V`, `1 -> P`. Cartier duality with the fixed principal polarization gives an isomorphism

```
chi_P : ker Fr -> mu_5.
```

The fiber `Fr^{-1}(P)` is a torsor under `ker Fr`; pushing its action through `chi_P` gives an actual `mu_5` torsor over `Spec(F)`. Its class is `[q] in H^1_fppf(F,mu_5)=F^*/F^{*5}`. This construction takes place over `F` itself. Neither choosing rational lifts of `P` to `G[5]` nor passing to an infinite Igusa tower is required.

For completeness, the extension classification used here is valid in the abelian category of fppf sheaves. Apply `Hom(-,mu_5)` to

```
0 -> Z --5--> Z -> Z/5 -> 0.
```

Since `mu_5(F)` is trivial for a field of characteristic 5 and multiplication by 5 kills `H^1(F,mu_5)`, the resulting exact sequence gives

```
Ext^1_F(Z/5,mu_5) = H^1(F,mu_5).
```

The map sends an extension to the boundary of `1`, precisely the torsor constructed above. The actual `G[5]` is finite flat and killed by 5, so there is no representability or exponent issue hidden in the use of the larger sheaf category. One can also avoid Ext entirely by using the explicit torsor construction.

Terminology correction: the Igusa generator and polarization **frame the two ends** of the connected–étale exact sequence. They do not split the middle group. In this construction its nonsplit class will be nonzero.

## 3. The section and its differential

Define `sigma` by requiring its restriction to `ker Fr` to be `chi_P^*(dT/T)`. Invariant differentials on a height-one Frobenius kernel agree with those on its smooth formal group, so this requirement determines the invariant differential of `G`. On the Igusa moduli scheme the definition extends functorially, including at supersingular points; its value there is zero because the Drinfeld generator specializes to the origin.

With the canonical polarized Kodaira–Spencer map of this same factor, define

```
eta = d pi (KS_G(sigma tensor sigma)).
```

The isomorphism `KS_G: omega_G^2 -> Omega_C^1` must mean this actual polarized map, not an arbitrarily rescaled abstract line-bundle isomorphism. Pullback and the differential of `pi` then give a regular form on `I`.

The simple-zero theorem for `sigma` and tame ramification index 4 give

```
div(sigma^2)=2S,  Ram(pi)=3S,
div(eta)=2S+3S=5S.
```

There are no cusps on this compact quaternionic curve. Both `sigma` and `KS_G` are nonzero and `pi` is separable, so `eta != 0`.

If the base genus is 5, `deg(omega_G)=4`. A degree-four Igusa pullback has Hodge degree 16, so the simple zero divisor `S` has degree 16. Riemann–Hurwitz gives `2g(I)-2=4*8+3*16=80`, as also follows from `div(eta)=5S`.

## 4. Why dlog of the global class equals eta

This is the important globalization step. Choose an ordinary geometric closed point `x` of `I` and work over its completed local ring `R=k[[t]]`. The chosen generator modulo 5 lifts to a basis of the étale Tate module over this strictly henselian formal neighborhood; use polarization for the dual basis. The formal extension is then described by a Serre–Tate coordinate `Q` in `1+tR`. Its 5-torsion extension has Kummer class `[Q]`, hence the restriction of the globally constructed `[q]` is `[Q]` in `k((t))^*/k((t))^{*5}`.

Katz's compatibility, restricted to the polarized rank-one factor and reduced modulo 5, gives

```
KS_G(sigma^2) = dlog(Q)
```

after pulling the family to this formal neighborhood. Thus `eta=dlog(q)` after completion. The map from rational differentials of the smooth curve into continuous differentials over `k((t))` is injective, so the equality already holds in `Omega^1_{F/k}`. Because `eta` is globally regular, the rational logarithmic differential extends to that regular form on all of `I`.

Lifting the mod-5 basis is an auxiliary local proof device, not additional global level structure. A different lift changes the relevant coordinate by a unit exponent congruent to 1 modulo 5; its mod-5 logarithmic differential is unchanged. Inverting the chosen convention for Cartier duality simultaneously changes the Kummer and polarized-KS sign convention. With coherent conventions the equality is literal. An arbitrary scalar rescaling of an abstract KS isomorphism must not be claimed to preserve literal Cartier-fixedness; use the canonical map above, or define the final normalized form directly as `dlog(q)`.

## 5. Hecke functoriality, including supersingular points

Let `alpha:G_A -> G_B` be the map of factors induced by an isogeny of false degree `ell=11`, and set `P_B=alpha^(5)(P_A)`. Because 11 is prime to 5, `alpha` is an isomorphism on all 5-power torsion. On the framed étale quotient it acts as the identity. Compatibility of the polarization pairing with `alpha^t alpha=[ell]` gives

```
chi_{P_B}(alpha x) = chi_{P_A}(x)^ell.
```

It therefore acts as `[ell]` on the framed multiplicative subgroup. Since `ell=1` in `F_5`, both ends of the framed 5-torsion extensions are identified by the identity. Consequently their classes in `H^1(k(Z),mu_5)` are equal. Representatives satisfy `f*q=u^5 g*q`; taking logarithmic differentials gives `f*eta=g*eta`.

For general `ell` prime to 5 the same calculation gives a scalar `ell` relation, with direction depending on which leg is called `f`. Here that ambiguity disappears because `ell=1 mod 5`. One must use the false degree 11, not the degree 121 of the abelian-surface isogeny.

Transport of a Drinfeld generator is functorial for the torsion-group isomorphism even at a supersingular point. Hence the Igusa-enhanced Hecke scheme is the base change of the Hecke moduli scheme along either leg, using the generator-transport isomorphism. Thus étaleness of the original legs persists across the supersingular locus. Finally, equality of the pulled-back regular forms on a dense ordinary open implies equality everywhere on each smooth connected component; no extension of an ordinary connected–étale decomposition over supersingular points is being asserted.

## 6. Divisors and Cartier

For any representative `q in F^*`, at a closed point with parameter `t` write `q=t^m v` with `v` a unit. The residue of `dlog(q)` is the image of the integer `m` in `k`. Since `dlog(q)=eta` is regular, `5` divides every such `m`. Therefore `div(q)=5E` for an integral divisor `E`, automatically of degree zero. Since `dq=q eta`,

```
div(dq)=div(q)+div(eta)=5(E+S).
```

Also `dq != 0`, since `eta != 0`. Replacing `q` by `q v^5` changes `E` by the principal divisor `div(v)` and leaves `eta` unchanged. In particular, `E+S` has degree 16 in the proposed numerical example, but need not be an effective divisor in that particular representative.

The two Cartier conclusions are immediate and different:

```
Cartier(eta)=eta,       Cartier(dq)=0.
```

Thus the proposed mechanism does produce a nonzero shared logarithmic regular differential. Any argument invoking this construction must preserve that fact explicitly.
