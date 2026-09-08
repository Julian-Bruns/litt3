# Maximal Tango connections: counts, saturated lines and p-group descent

Version 2, 2026-09-08. Consolidates the original rank-one descent proof,
the characteristic-five connection equation and the saturated-line count.
Original authors: /root and /root/gluing_cohomology_rigidity (2026-09-05).
The [positive-rank descent audit](audits/115_POSITIVE_RANK_PRESERVING_TANGO_DESCENT_AUDIT.md)
is PASS, /root/x_elliptic_quotient_maps, 2026-09-05, for its required
rank-one count/descent inputs; it is NOT a whole-note audit. The sharper
all-rank count, explicit local model and examples retain AUTHOR evidence.

Let k be algebraically closed of odd characteristic p, C a smooth projective
connected curve, γ(C) its p-rank, and F_C:C→C^(1) relative Frobenius.

## 1. Embedded roots and the connection dictionary

Write B_C^1=ker(Car:F_C*ω_C→ω_(C^(1))). A maximal Tango structure is an
EMBEDDED line L⊂B_C^1 whose adjoint F_C^*L→ω_C is an isomorphism.
Denote the set by Tan(C). This means deg L=(2g(C)−2)/p exactly, not a
floor-rounded maximum. Equivalently it is the rational differential line
of ξ≠0 with Car(ξ)=0 and div(ξ)=pD, modulo multiplication by K^p×,
where K=k(C). In particular Tan(C)≠∅ implies p|(g(C)−1).

For any Frobenius root F_C^*L≅ω_C, adjunction gives
Hom(L,F_C*ω_C)=H^0(O_C)=k. Thus each root class supports at most ONE
embedded Tango line. Root classes, when nonempty, form a torsor under

\[
 K_C=\ker(F_C^*:J(C^{(1)})(k)\to J(C)(k))
          \simeq(\mathbf Z/p)^{\gamma(C)}.                \tag{1}
\]

This is the geometric Verschiebung kernel, not the kernel of the
oppositely directed relative Frobenius. Hence |Tan(C)|≤p^γ(C), including
≤1 when γ(C)=0. Cartier descent identifies these roots with regular
zero-p-curvature connections on ω_C; a scalar choice of root isomorphism
does not alter the connection. The root lies in B_C^1 exactly when its
rational horizontal differentials are Cartier-zero. This generic condition
is sufficient for the bundle map into the Cartier quotient to vanish.

Write V_C={β∈H^0(C,ω_C):Car(β)=β}, of F_p-dimension γ(C).
The set D(C) of regular zero-p-curvature connections, when nonempty, is
an affine torsor under V_C. Indeed for a separating x and D=d/dx,
D^p=0 on K, and the connection ∇(dx)=a dx⊗dx has p-curvature
a^p+D^(p−1)a. Differences b dx between zero-curvature connections obey

\[
 b^p+D^{p-1}b=0
 \quad\Longleftrightarrow\quad \operatorname{Car}(b\,dx)=b\,dx,
\]

using Car(u dx)=(-D^(p−1)u)^(1/p)dx. Conversely this equation makes
addition preserve zero curvature. See also the
[Miura/Tango source dictionary](https://arxiv.org/abs/1709.04241).

## 2. The scalar equation and the original rank-one count

For a horizontal ξ=u dx, Du=−au. Set P_0(a)=1 and
P_(j+1)(a)=DP_j(a)−aP_j(a). Then D^ju=P_j(a)u, so among dormant
connections the Tango condition is exactly P_(p−1)(a)=0.

For β=b dx≠0 in V_C, regard P_j(a+Tb) as a polynomial in T with DT=0.
Its degree is j and leading coefficient (−b)^j: differentiation does
not increase T-degree, while multiplication by −(a+Tb) supplies the top
term. Thus any affine F_p-line in direction β has at most p−1 Tango
points. When γ(C)=1 it is the ENTIRE dormant-connection space, giving

\[
 \boxed{|\operatorname{Tan}(C)|\le p-1.}                  \tag{2}
\]

This is the original polynomial proof used by the descent audit,
independent of the stronger equality classification in Section 4.

At p=5 the recurrence gives the reusable formulas

\[
 P_4(a)=a^4-a^2a'+3(a')^2+4aa''-a''',\qquad
 P_5(a)=-a^5-a''''=P_4'(a)-aP_4(a).                      \tag{3}
\]

Thus P_4=0 automatically implies dormancy; the converse is false.
For coordinates t,u with q=dt/du, the connection law is
a_u=q a_t−q'/q, with the prime on q meaning d/du. The order-four
differential-operator identity

\[
 D_u^4\circ q=q^5D_t^4
\]

gives P_4(a_u)=q^4P_4(a_t). This identity can be checked on the p-basis
1,t,…,t^4; operators of order<5 are determined there, so it also holds
on differential modules. In particular covariance does NOT assume that
an arbitrary connection already has a rational horizontal section.
Consequently P_4(a_t)(dt)^4 is a global regular quartic for EVERY regular
connection, and (3) defines a degree-at-most-four polynomial map on their
affine space under H^0(ω_C). Local solutions alone do not supply the
required affine coordinate transitions or a global Tango structure.

A regular connection with P_4=0 has, by Cartier descent, a rational
horizontal ξ with div ξ=5D, and the Cartier formula gives Car ξ=0.
Conversely ξ=fdt with div ξ=5D defines a=−f'/f: writing f=t^(5m)v
with v a unit proves regularity a=−v'/v, and Car ξ=0 proves P_4=0.
Thus (3) recovers exactly the embedded-root dictionary. More generally,
a line bundle M has a regular connection exactly when p|deg M. Necessity
follows from the residue theorem applied in a rational frame: the sum
of the required residues is deg M, which must vanish in k. Conversely,
surjectivity of F_C^*:Pic^0(C^(1))→Pic^0(C) supplies a root F_C^*L≅M
when its degree is divisible by p; Cartier descent even gives a dormant
connection. For M=ω_C,p=5 the criterion is 5|(2g−2), not Tango existence.

For practical difference tests, the exact expansion, grouped compactly, is

\[
\begin{aligned}
 P_4(a+v)-P_4(a)={}&(a+v)^4-a^4
 -\bigl((a+v)^2(a'+v')-a^2a'\bigr)\\
 &+3\bigl(2a'v'+(v')^2\bigr)
 +4\bigl(av''+va''+vv''\bigr)-v''' .                     \tag{4}
\end{aligned}
\]

It has weight four because v_u=qv_t. If P_4(a)=0, its vanishing is
equivalent to a+v being Tango and implies v''''+v^5=0.
For ξ=t^jdt, P_4(−j/t)=j(j−1)(j−2)(j−3)t^(−4): Cartier vanishes
for j≠4 mod5, but regularity across zero requires j=0 mod5.
For the unit ξ=(1+ct)dt, a=−c/(1+ct) is regular and P_4(a)=0.
These local checks are not projective existence claims.

## 3. Descent through an etale p-group

For an actual connected Galois etale p-group cover f:D→C, if either
γ(C)=1 or γ(D)=1, then both have rank one and

\[
 \operatorname{Tan}(C)\xrightarrow{\sim}\operatorname{Tan}(D).
                                                               \tag{5}
\]

Deuring--Shafarevich gives γ(D)−1=|P|(γ(C)−1). The action of P on
Tan(D) has p-power orbit sizes; (2) makes each orbit a singleton.
Because these are EMBEDDED lines in B_D^1=f^(1)*B_C^1, invariance
restricts the ambient canonical P-linearization and its cocycle.
Faithfully flat descent therefore supplies an actual line L_C⊂B_C^1,
not just an invariant isomorphism class. Its adjoint is an isomorphism
after faithfully flat pullback and hence before it. Conversely etale
pullback preserves maximality, and faithful flatness gives uniqueness.
No averaging or division by |P| occurs.

For any finite Galois etale D→X with γ(D)=1, take a Sylow p-subgroup
P and B=D/P. Equation (5) descends every Tango structure to B.
Since g(B)−1=[G:P](g(X)−1) and [G:P] is prime to p, one gets

\[
 p\nmid(g(X)-1)\quad\Longrightarrow\quad\operatorname{Tan}(D)=\varnothing.
                                                               \tag{6}
\]

No descent from B further to X is asserted; P need not be normal.

## 4. Saturated affine lines and the sharper all-rank bound

These are the retained AUTHOR results beyond the audited rank-one input.
Fix β≠0 in V_C and a line ℓ=∇_0+F_pβ in D(C).
The logarithmic Cartier criterion gives β=dh/h with h∈K× not a pth
power. Equivalently apply generic Cartier descent to d−β. Since
K=K^p(h), every nonzero horizontal differential for ∇_0 has a unique form

\[
 \xi=\sum_{j=0}^{p-1}c_j^p h^j\,dh.                      \tag{7}
\]

A horizontal differential at parameter t is h^(−t)ξ. Cartier selects
only index j=p−1 when t=0, giving c_(p−1)dh; for 1≤t≤p−1 it selects
j=t−1, giving c_(t−1)dh/h. Therefore the EXACT number of Tango points
on ℓ is the number of zero coefficients c_j in (7).

Let ∇_β be the unique rational canonical connection with β horizontal.
It is regular exactly when div β is coefficientwise divisible by p:
if β=x^e v dx, its coefficient is −e/x−v'/v. When regular it is
dormant but not Tango, because Car β=β≠0. Moreover,

\[
 \#(\ell\cap\operatorname{Tan}(C))=p-1
 \ \Longleftrightarrow\
 \nabla_\beta\text{ regular and }\ell=\nabla_\beta+\mathbf F_p\beta.
                                                               \tag{8}
\]

Indeed p−1 zeros in (7) leave one monomial c_j^p h^jdh. At the sole
missing parameter t=j+1 mod p, multiplying by h^(−t) turns it into a
pth-power multiple of β, so that connection is ∇_β. Conversely, when
∇_β is regular, h^(−t)β=−t^(−1)d(h^(−t)) is exact for every t≠0.
Thus for a fixed direction at most ONE parallel line is saturated.

For γ(C)=f>0, partition the p^f dormant connections into p^(f−1)
parallel lines. Equation (8) gives

\[
 \boxed{|\operatorname{Tan}(C)|\le(p-2)p^{f-1}+1.}         \tag{9}
\]

If some β∈V_C\{0} has divisor not divisible by p, no parallel line is
saturated, and the bound improves to (p−2)p^(f−1). At f=1, equality
in (2) occurs exactly when a nonzero Cartier-fixed differential has
p-divisible divisor; F_p× rescaling does not change the condition.
At p=5, (9) is 3·5^(f−1)+1, not a rank-independent bound.

## 5. Distinct structures and genuine geometric scope

An ordinary elliptic curve E has exactly p−1 maximal Tango lines.
Its p Frobenius roots of O_E each give one adjoint line. Every nontrivial
root has no map to ω_(E^(1))=O, so lies in B_E^1; the trivial root does
not, since Cartier is nonzero on the invariant differential.

Choose a line bundle A on E of degree a≥1 and a reduced divisor in
|A^(p+1)|. The connected tame cyclic (p+1)-cover h:D→E is totally
ramified there. With R_red its reduced ramification divisor,

\[
 R_h=pR_{\rm red},\qquad g(D)=1+\frac{p(p+1)a}{2}.
\]

Every elliptic maximal line L gives, by exact differential pullback,
the saturated maximal line h^(1)*L⊗O_(D^(1))(R_red^(1)).
They remain distinct: the norm of a pullback multiplies p-torsion
by p+1, which is invertible on it. At p=5,a=1 this is a genus16 curve
with at least four Tango structures, with NO asserted p-rank or ordinarity
upstairs. The map is ramified and is not a counterexample to (5).

[Hoshi, Theorem 3 and Remark 10](https://www.kurims.kyoto-u.ac.jp/preprint/file/RIMS1917.pdf)
also constructs a regular logarithmic differential with p-divisible
divisor in every genus 1+pn; (8) gives its saturated line. No p-rank is
specified by that construction. For n=1,p=5, start with an ordinary
elliptic curve and div(f_E)=5P−5O for P of exact order5. Normalizing
w^6=f_E gives genus6, total tame ramification over P,O, and
div(dlog w)=5P_D+5O_D. It has at least four Tango structures, not
necessarily ONLY four. The distinct [exact ten-structure example](HOSHI_GENUS6_EXACT_TANGO_COUNT.md)
shows why the p-rank-one hypothesis in (2) cannot simply be dropped.

The optional rank-one genus-nine source y²=x^19+x^14+1 is certified in
[its arithmetic note](P_RANK_ONE_GENUS9_ALTERNATIVE_SOURCE.md). Since 5∤8,
all its etale 5-group covers have genus 1+8·5^a, rank one and no maximal
Tango structure. Equation (6) applies to every rank-one Galois etale cover
of it. This curve is NOT the fixed genus-nine X, whose rank is six.

The [rank-preserving non-Galois descent theorem](115_POSITIVE_RANK_PRESERVING_TANGO_DESCENT.md)
extends (5) under its explicit positive equal-rank hypothesis. An arbitrary
cover can increase rank, and its Galois closure can increase it further.
Neither (9) nor the local equation controls that growth, supplies a
shared invariant, or excludes a common cover of the project's fixed pair.
