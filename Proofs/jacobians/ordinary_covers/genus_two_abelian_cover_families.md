# Proof: exact boundary inertia gives the Hodge degree

[Statement](../../../Theorems/jacobians/ordinary_covers/genus_two_abelian_cover_families.md).

## 1. The stable base family

Kummer theory identifies the geometric character lines of the Abel
[m]-pullback with all of J(C_t)[m]. It is connected, of degree N=m^4;
Riemann–Hurwitz gives genus N+1.

Make a finite base change B→P1, trivializing the deck group G=(Z/m)^4
and adjoining sqrt(s) at infinity, where s=1/t. Above each of the five
boundary values, the stable base fiber is irreducible, with elliptic
normalization and one nonseparating node. At t=a_i, remove the other
factors by an etale local square root. The remaining equation v²=x(x−r), r=t−a_i,
has smoothing parameter −r²/4 after replacing x by x−r/2. Thus its
node thickness is2ord_B(r). At infinity put y'=sqrt(s)y and z=1/u. Then
\[
Y^2=z(s-z)\prod_i(1-a_i z),\qquad Y=y'/u^3,
\]
has the same collision and thickness2ord_B(s). Writing b=deg(B→P1),
the total weighted node thickness is therefore δ_C=10b.

The dualizing basis du/y,u du/y extends at every finite boundary.
At infinity the basis du/y',u du/y' has wedge s^(-1) times the old
wedge; hence the latter has zero divisor exactly the pullback of infinity.
Consequently deg λ_C=b. The integral Mumford isomorphism
[Freixas i Montplet, Theorem3.10,n=0](https://www.numdam.org/article/ASENS_2009_4_42_2_335_0.pdf#page=13),
valid in characteristic p, gives κ_C=12deg λ_C−δ_C=2b, where
κ_C=(ω_(C/B))².

## 2. Exact inertia at every boundary node

The actual G-cover extends, after further finite base change, as a
balanced twisted G-cover. This uses
[Abramovich–Corti–Vistoli, §2.2, Corollary3.0.5 and Lemma2.2.1](https://arxiv.org/pdf/math/0106211#page=8),
under the assumption |G| invertible; their §4's factorial assumption
is unnecessary. Every base node is nonseparating. Their
[Proposition6.1.2](https://arxiv.org/pdf/math/0106211#page=20)
therefore gives exact inertia m, including composite and even m:
§6 works over Z[1/m].

The coarse source D is nodal. Each normalized source component covers
the elliptic normalization of its base fiber, with tame index m at
both points above the node. For component degree d, Riemann–Hurwitz
gives 2g−2=2d(1−1/m)>0. Thus every component is already stable;
no contraction changes the intersection or boundary calculation.

At a base node of thickness r the balanced local map is
x=z^m,y=w^m. There are N/m source nodes, each of thickness r/m,
so their contribution is Nr/m². Moreover dx/x=m dz/z gives
ω_(D/B)=π^*ω_(C/B). Hence
\[
\delta_D=\frac N{m^2}\delta_C=10m^2b,\qquad
\kappa_D=N\kappa_C=2m^4b,
\]
and Mumford's formula yields
\[
\deg\lambda_D=\frac{\kappa_D+\delta_D}{12}
=b\,\frac{m^2(m^2+5)}6.
\]
This exact degree replaces the older inequality deg λ_D≤m^4b.
The quotient is integral: divisibility by2 follows from parity, and
by3 from m divisible by3 or m²≡1 modulo3.

## 3. The Hasse divisor and the later seeds

On the proper nodal family, Frobenius on R¹f_*O_D has determinant a
regular section of λ_D^(p−1), nonzero if one smooth fiber is ordinary.
Its zero divisor has degree (p−1)deg λ_D. Over the preimage of U it
is the pullback of the original Hasse divisor, with ramification
multiplicities. Divide by b to obtain the stated bound on U. The
zero divisor is defined over F_q; its reduced-support polynomial,
multiplied by ∏(T−a_i), gives E and the extra four boundary factors.

The [later good-cubic ordinarity theorem](backup_small_abelian_ordinarity.md)
provides the same ordinary seed t=alpha, alpha³+alpha+1=0, for m=4
AND m=6. Its complete order-four and mixed-order-six character tests
remain necessary and retained there. No separate cubic specialization
or second halving proof is needed here. Substitution gives228 and988.

## 4. Both actual legs

For a genuine C_t-leg Galois closure W with normal five-subgroup P
and abelian quotient of exponent dividing m, W/P is dominated by
C_(m),t and is ordinary. Then
[Crew, Corollary1.8.3](https://numdam.org/item/CM_1984__52_1_31_0.pdf#page=7)
makes W ordinary. In an actual span X←Z→C_t, the same W still maps
etale to X through Z. Pullback of a nonzero Cartier-zero differential
from nonordinary X contradicts ordinarity. No simultaneous Galois
closure is presumed.
