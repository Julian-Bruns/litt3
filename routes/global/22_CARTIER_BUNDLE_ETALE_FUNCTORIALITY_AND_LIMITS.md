# The Cartier bundle under finite étale covers

Status: author proved-text for the base-change, bundle, cyclic-cover
and explicit Cartier calculations below. The limitations concern the
listed coarse invariants, not the full bundle or theta divisor.

Let k be perfect of characteristic p>2, C/k smooth projective
geometrically connected, and F_C:C→C^(1) its relative Frobenius. Define

    0 → O_(C^(1)) → F_C,*O_C → B_C → 0.                       (1)

Keep the Frobenius twist: even over Fbar_5 there is no canonical
k-isomorphism C≅C^(1).

## 1. Theorem1: exact étale pullback

For finite étale f:D→C, with h=f^(1), there is a canonical isomorphism

    B_D ≅ h^*B_C,                                             (2)

compatible with (1) and composition. Indeed,
D≅C×_(C^(1))D^(1), since relative Frobenius of an étale morphism is
an isomorphism. Flat base change identifies h^*F_C,*O_C with F_D,*O_D
and the pulled-back unit with the unit for D. Taking cokernels proves
(2), with compatibility inherited from these canonical maps.

In particular, BOTH actual finite étale maps f:Z→X and g:Z→Y from
the SAME smooth projective source give

    (f^(1))^*B_X ≅ B_Z ≅ (g^(1))^*B_Y.                       (3)

No separable-map substitute or simultaneous Galois closure is used.

## 2. Proposition2: bundle invariants and Frobenius filtration

Put s=g(C)−1>0 and ω1=ω_(C^(1)). Then B_C has rank p−1,
Euler characteristic0, degree(p−1)s and slope s. It is geometrically
stable, has a canonical perfect alternating pairing into ω1, and

    det B_C ≅ ω1^((p−1)/2).

Its Frobenius pullback has HN line quotients ω_C^i, 1≤i≤p−1, in
decreasing order of i. These constructions commute with étale pullback.

Proof. Finite pushforward preserves cohomology, so (1) gives χ(B_C)=0;
Riemann–Roch gives the rank and degree. The Raynaud pairing is

    (ā,b̄) ↦ Cartier(a db).

It is well-defined modulo pth powers and alternating because Cartier
kills exact forms. In a local basis t,…,t^(p−1), its matrix has
invertible anti-diagonal entries j at i+j=p and no other entries,
proving perfection. Taking the rth wedge of the alternating form,
r=(p−1)/2<p, yields det B_C≅ω1^r because r! is invertible.
Geometric stability is Joshi's theorem (also Tong's direct proof).
Formation of B commutes with perfect-field extensions by flat base
change. Hence every finite étale pullback is again stable by (2).

For the Frobenius filtration let V=F_C^*F_C,*O_C and let I be its
evaluation ideal. Frobenius is flat, and evaluation splits the unit
O_C→V; its quotient F_C^*B_C is thus canonically I. Étale-locally,

    V=O_C[α]/(α^p),   I=(α),
    0=I^p ⊂ I^(p−1) ⊂ ⋯ ⊂ I,   I^i/I^(i+1)=ω_C^i.          (4)

These line quotients have strictly decreasing degrees2is, so (4) is
the HN filtration. In characteristic five this gives rank4, determinant
ω1² and Frobenius slopes8s,6s,4s,2s. Under a degree-d étale cover,
ω_D=f^*ω_C, ω_(D^(1))=h^*ω1 and g(D)−1=ds, as required.

If a degree-s line bundle L on C^(1) is used to normalize B_C,
the degree-zero bundle B_C⊗L^(-1) has Frobenius slopes(2i−p)s.
It is therefore not strongly semistable, hence not essentially finite
or associated to a finite étale monodromy representation.

Do not confuse the two connections: the canonical connection on V
does NOT preserve I; its map I/I²→ω_C is an isomorphism. Its quotient
V/O_C=F_C^*B_C does inherit a zero-p-curvature connection, since the
unit is horizontal. Identification with I in (4) is an identification
of bundles, not a restriction of the connection on V. Zero p-curvature
does not by itself mean finite étale monodromy.

## 3. Proposition3: cohomology and the theta divisor in cyclic covers

The long exact sequence of (1) gives

    h⁰(B_C)=dim ker(F:H¹(C^(1),O)→H¹(C,O))=a(C),

also the dimension of the Cartier kernel on H⁰(C,ω_C).
Raynaud's theta divisor is
Θ_(B_C)={L∈Pic⁰(C^(1)):h⁰(B_C⊗L)>0}.

Let f:D→C be a connected split cyclic étale cover of degree n prime
to p. For h=f^(1), choose the order-n bundle η with
h_*O_(D^(1))=⊕_(i=0)^(n−1)η^(-i). For every L∈Pic⁰(C^(1)) and q,

    H^q(D^(1),B_D⊗h^*L)
      ≅ ⊕_(i=0)^(n−1) H^q(C^(1),B_C⊗L⊗η^(-i)).            (5)

In particular h⁰(B_D)=∑_i h⁰(B_C⊗η^(-i)). Scheme-theoretically,

    (h^*)^*Θ_(B_D)
      =∑_(i=0)^(n−1) {L:L⊗η^(-i)∈Θ_(B_C)}.                 (6)

Proof. Apply (2), the projection formula and the displayed splitting
of h_*O. Finite pushforward has no higher direct images, giving (5).
In the Jacobian family, determinant of cohomology sends this direct
sum to the tensor product of the determinant lines, with the product
of their canonical sections. Their zero divisors add, including
multiplicity, proving (6).

Thus neither cohomology nor the theta divisor simply pulls back
unchanged. This is a genuine cover phenomenon: Raynaud's ordinarity
Theorem2 supplies every genus≥2 curve with a finite étale Galois cover
of solvable prime-to-p group that is not ordinary, even if the base is
ordinary. Madore's Theorem4.1 gives the earlier generic-curve construction.

## 4. Explicit ordinary/nonordinary comparison over Fbar_5

Take X:v²=x⁷−x+1 and Y:y³¹=x(x−1). The first polynomial is square-free:
a common root with2x⁶−1 would give x=2, contradicting2x⁶=1. Hence X
has genus3. On dx/v,x dx/v,x² dx/v its Cartier–Manin matrix is

    (c_(5i−j)) = [0 0 1; 0 3 2; 1 0 0],   det=2,
    where (x⁷−x+1)²=∑ c_m x^m.

Thus X is ordinary, with a(X)=0 and p-rank3.

For genus15 Y, the regular basis is ω_b=dx/y^b, 16≤b≤30:
its valuations over0,1,∞ are30−b,30−b,2b−32. Choose b′∈{1,…,30},
q∈{0,…,4} with5b′=b+31q. Then

    Cartier(ω_b)=y^(-b′) Cartier((x(x−1))^q dx).

Only the x⁴ coefficient contributes; it is nonzero precisely for
q=2,3,4, with values1,3,1. The nonzero arrows are

    16→28, 17→22 (scalar3), 18→16,
    21→29, 22→23 (scalar3), 23→17,
    26→30, 27→24 (scalar3), 28→18.

The other six basis vectors map to zero. Cartier rank is9, so a(Y)=6.
The persistent cycles(16,28,18) and(17,22,23) give stable rank6,
hence p-rank6. Degrees of B_X and B_Y are respectively8 and56.

For an actual common étale source Z of degrees d_X,d_Y,
Riemann–Hurwitz forces d_X=7d_Y. Consequently8d_X=56d_Y; the four
Frobenius-HN quotient degrees4i d_X and28i d_Y agree, and both
determinants become ω_(Z^(1))². The differing base a-numbers and
ordinarity cannot supply a cover obstruction by Section3.

## 5. Exact limitation

Ranks, degrees, slopes, determinants, stability and the Frobenius HN
polygon are universal after the necessary degree scaling. The
degree-zero normalization does not yield finite monodromy; a-number,
ordinarity and p-rank alone are not preserved under arbitrary étale
covers. Nor does the theta class or naive theta pullback separate
commensurability.

The full theta divisor still contains curve-specific data. Using it
would require an invariant compatible with the torsion-translate sums
(6) and with nonabelian covers; none is supplied here.
The stronger [full-tensor](../../Theorems/Thm_all_tensor_cartier_hn.md)
and [symmetric-power](../../Theorems/Thm_all_symmetric_cartier_hn.md)
HN theorems likewise do not exclude a common cover.

## Primary references

- [Raynaud, Sections des fibrés vectoriels sur une courbe, §4.1 (1982)](https://numdam.org/articles/10.24033/bsmf.1955/).
- [Joshi, Stability and locally exact differentials on a curve (2004)](https://www.numdam.org/articles/10.1016/j.crma.2004.02.019/).
- [Sun, Stability of direct images under Frobenius morphism, Lemma2.1](https://arxiv.org/abs/math/0608043).
- [Tong, Diviseur theta et formes différentielles, §§1.2,1.4](https://arxiv.org/abs/0712.2046).
- [Raynaud, Revêtements des courbes en caractéristique p>0 et ordinarité, Theorem2 (2000)](https://www.cambridge.org/core/journals/compositio-mathematica/article/revetements-des-courbes-en-caracteristique-p0-et-ordinarite/16AB72912D3CE32BFC5D012B1025A8E4).
- [Madore, Theta divisors and the Frobenius morphism, Theorem4.1 (2000)](https://alexjbest.github.io/buntes/courbes-semi-stables.pdf#page=284).
