# Proof: Igusa–Hecke correspondences and logarithmic forms

[Statement](../../Theorems/examples/igusa_hecke_correspondences.md).

The construction is a quantitative instance of Krishnamoorthy,
[*Correspondences without a Core*, Remark3.18 and Example8.5](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf).
Those passages give the Igusa/coreless mechanism; the zero orders,
specific genera, and jointly minimal prime-power family below are
additional deductions. We use Buzzard's X^D_1(N), I^D_1(N), V_1, V_0,
Hodge bundle omega, canonical section a, and supersingular divisor ss.
In Krishnamoorthy's notation, the Hasse invariant is
H∈H⁰(C,Omega_C^((p−1)/2)); the partial curve P below is precisely the
cyclic root cover of H in his published Example8.5.

## 1. Compact moduli and the canonical form

Take D/Q indefinite of discriminant6, maximal order O_D, tame level
V_1(7), and the canonical polarization with a selfadjoint rank-one
idempotent at p. Let C=X^D_1(7)_k and I=I^D_1(7)_k.

The required compact geometry is supplied by Buzzard,
[*Integral models of certain Shimura curves*](https://www.ma.imperial.ac.uk/~buzzard/maths/research/papers/shimura.pdf):
Theorem2.1, Corollary2.3, and Propositions2.4–2.5 give smooth projective
geometrically connected fine curves and étale tame level changes.
Definition4.8, Proposition4.9 and its following discussion give the
whole Igusa cover, of degree p−1 and total tame ramification at ss.
Proposition5.1 and Theorem5.2 give omega_C²≅Omega_C,
|ss|=(p−1)(g(C)−1), and a∈H⁰(I,omega_I) with divisor ss_I.

All cited level conditions hold: the level is maximal at2,3, its
determinant is unrestricted, it lies in V_1(7), and p divides neither
6 nor7. The level-one signature is (0;2,2,3,3), by
[Voight's Table4.1](https://jvoight.github.io/shim-tables/shimbound-tables.pdf).
Its orbifold canonical degree is1/3. The effective projective index
of V_1(7) is |SL_2(F_7)|/(2·7)=24, so 2g(C)−2=8.
Thus |ss|=4(p−1).

Use the actual polarized Kodaira–Spencer map and differential pullback
to define eta=KS(a²) on I. Its divisor is

    div(eta)=2 ss_I+(p−2)ss_I=p ss_I.                  (1)

This form is logarithmic, with a global function-field witness.
At the ordinary generic point the Igusa generator frames ker(V) of
the height-two factor G; polarization identifies ker(F) with mu_p.
The inverse image of that generator under F is a mu_p-torsor, defining
[q]∈k(I)^*/k(I)^{*p}. This is the group-scheme extension construction
of [Ulmer, *p-descent in characteristic p*, Lemma5.2 and (5.1)](https://dlulmer.github.io/research/papers/1991.pdf#page=18),
applied to G[p]. In an ordinary completion q represents the
Serre–Tate parameter modulo p-th powers. [Katz, *Serre–Tate local
moduli*, Main Theorem3.7.1, p166](https://web.math.princeton.edu/~nmk/old/serretatelocmod.pdf#page=29)
identifies dlog(q) with KS(a²). Injectivity on rational differentials
gives eta=dlog(q) globally. No formal parameter is asserted to be a
global rational function.

Consequently Cartier(eta)=eta. The residue of dlog(q) at a point is
its valuation modulo p; regularity gives div(q)=pE and
div(dq)=p(E+ss_I). In Buzzard's construction a diamond c multiplies
a by c, so it multiplies eta by c².

## 2. The sign quotient

Let P=I/{±1}. The invariant eta descends to alpha. At a supersingular
point the tame degree-two quotient gives

    p=2 ord(alpha)+1.

It is étale elsewhere, so div(alpha)=((p−1)/2)ss_P. Cartier commutes
with separable pullback and is tested injectively upstairs. Finally,

    2g(I)−2=(p−1)·8+(p−2)·4(p−1)=4p(p−1),
    2g(P)−2=((p−1)/2)·8+((p−3)/2)·4(p−1)=2(p−1)^2.

## 3. Both actual étale legs at every Hecke power

Fix ell≡1 mod p, ell∤42, and let H_n be the curve of tame level
V_1(7)∩V_0(ell^n). Its source and target maps a_n,b_n to C classify
cyclic false-degree-ell^n isogenies with transported level7. By
Buzzard's cited level-change results both maps are étale of degree

    d_n=#P¹(Z/ell^n Z)=(ell+1)ell^(n−1).

For the target map, duality is an automorphism of this isogeny moduli
problem; its square is an invertible diamond operation on level7.

The isogeny identifies the entire p-divisible groups, including the
Drinfeld-generator schemes over supersingular points. For T=I or P
this gives both full Cartesian identities

    Z_(T,n)=H_n×_(a_n,C)T ≅ H_n×_(b_n,C)T.             (2)

These schemes are smooth, since their maps to T are étale. They are
connected: the finite flat map to H_n has a one-point totally ramified
supersingular fiber, while every smooth component must dominate H_n.
Thus (2) gives two actual finite étale maps of connected projective curves.

On the framed p-torsion extension the polarized isogeny multiplier is
its false degree ell^n, equal to1 in F_p. It therefore preserves [q],
so f^*q=u^p g^*q and f^*eta=g^*eta. Quotienting by sign preserves the
equality for alpha. Étale Riemann–Hurwitz gives the stated source genera.

## 4. Joint minimality and absence of a core

At the geometric generic point of C, End_(O_D)(A)=Z. Here is the
monodromy argument needed for this particular assertion. Connected
extra V_1(ell^m)-level covers make the Morita Tate monodromy transitive
on primitive vectors, hence its order modulo ell^m is at least
(ell²−1)ell^(2m−2). A geometric endomorphism descends over a finite
extension and thus centralizes a subgroup of bounded index in this
SL_2 monodromy. A fixed nonscalar matrix has determinant-one centralizer
of order O(ell^m): after removing a scalar and a fixed ell-power, its
centralizer is a rank-two quadratic algebra with one-dimensional
norm-one group. The growth rates contradict each other. Scalar Tate
actions are rational by the rational characteristic polynomial, and
integral rational-scalar endomorphisms are integers.

Two cyclic isogenies of the same false degree with O_D-isomorphic
targets therefore have the same kernel: their ratio is a rational
scalar, of equal-degree norm1, hence ±1. The sign cannot preserve a
fixed level7 generator. Thus H_n→C×C is generically injective, as is
Z_(T,n)→T×T by (2). Each joint map is generically separable because
either projection is étale. This proves joint minimality.

Fix n. Quotients of a geometric generic object by the
(ell+1)ell^(mn−1) distinct cyclic ell^(mn)-kernels have distinct
underlying targets. For arbitrarily large even m, break each isogeny
into m blocks of false degree ell^n and read them alternately across
the bipartite H_n graph. On a reversed block psi, give the next
level7 label by (psi^t)^(-1)=ell^(−n)psi. These are actual graph paths
with distinct endpoints. A common nonconstant rational function would
put all of them in one finite fiber, a contradiction. Hence the two
C fields in k(H_n) intersect in k.

Corelessness passes through (2) by a short field argument. If L=k(H_n),
K=k(Z_(T,n)), and A,B are the two T fields, the characteristic polynomial
of multiplication by z∈A∩B on K/L is obtained by scalar extension from
each of the two base-field extensions. Its coefficients belong to both
C fields, hence to k. Thus z is algebraic over k and lies in k.
The complete connected Cartesian products are essential here.

## 5. The retained Cartier consequence

For either shared form beta=eta or alpha, a matched pluriform divided
by beta to the same weight is a common rational function. Corelessness
makes it constant, so the matched canonical ring is k[beta]. If a weight
d is prime to p and rd=pn+1, then twisted Cartier gives

    C_n((c beta^d)^r)=c^(r/p) beta^(n+1) != 0   (c!=0).

On the full curve I, the p-divisible zero orders additionally make
the p−1 connections
nabla_c(r eta)=(dr+c r eta)⊗eta, c∈F_p^*, regular and dormant:
their horizontal frames q^(−c)eta=−c^(−1)d(q^(−c)) are exact.
This recovers the logarithmic case of the compatible-Tango classification.
