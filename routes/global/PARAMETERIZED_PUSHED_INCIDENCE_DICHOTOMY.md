# Parameterized incidence and hyperelliptic pushdown splitting

Version 2, 2026-09-08. AUTHOR proof, not independently audited.
Consolidates the general incidence argument and the old degree-nine
specialization. The splitting theorem now allows EVERY degree-zero line
bundle, not just prime-to-characteristic torsion. The target genera≥2
are explicit, as required by the simple-Jacobian/Riemann--Hurwitz step.
An old specialization called the degree-nine map to P¹ etale: only its
map to X is etale; the P¹ maps have the branched profiles below. The
positive-characteristic Castelnuovo application now proves the required
non-strangeness instead of leaving that source condition implicit.

All curves are smooth projective connected over an algebraically closed
field of odd characteristic p. The characteristic-five degree-nine
example is AUXILIARY, not the project's fixed genus-(9,25) pair.

## 1. The actual joint image and its basepoint-free degree test

Suppose V→C→X and a:V→Y are ACTUAL finite etale maps, with
deg(V/C)=r, deg(C/X)=deg(a)=M, and g(X),g(Y)≥2. Write c:C→X,
f=c∘(V→C), and assume ONLY

\[
                         f_*a^*=0\quad\text{in }\operatorname{Hom}(J(Y),J(X)).         \tag{1}
\]

Hom(J(Y),J(X))=0 is sufficient, not necessary. Let Γ be the reduced
joint image in X×Y, G its normalization, and e=deg(V/G). Then

\[
 e\mid M,\quad n=M/e,\quad
 G\to X,\ G\to Y\text{ etale of degrees }rn,n,
\]
\[
 \mathcal O(\Gamma)=N\boxtimes R,\qquad
 \deg N=n,\quad\deg R=rn,\qquad N,R\text{ basepoint-free}. \tag{2}
\]

Indeed e divides both rM and M. Intermediate maps of the original etale
curve maps are etale by additivity and nonnegativity of the different.
The cycle f_*a^* is e times the action of Γ; Hom between abelian varieties
is torsion-free, so that action is zero. The product Picard description
then gives the exterior product, with degrees from intersections with
fibers. A base point would force a whole vertical or horizontal fiber
into the integral Γ, impossible.

In particular gon(X)≤n. If X is hyperelliptic, a basepoint-free bundle
of degree n≤g(X) must be a power of its hyperelliptic pencil, so n is
even. For a separable pencil of degree≤g(X), not factoring through the
degree-two map would make the two maps generate k(X), contradicting
Castelnuovo--Severi g(X)≤n−1. Thus it factors, and its bundle is a
hyperelliptic power. If the complete system is inseparable, first
remove its Frobenius power, apply the same argument on the twist of X,
and pull the hyperelliptic power back. Thus all e with M/e odd≤g(X) are excluded;
if these are all proper divisors, V→Γ is birational.

## 2. The divisor family: birational, rational, or a Frobenius image

A defining section s∈H^0(N)⊗H^0(R) never vanishes identically at any
y, since Γ has no horizontal component. It gives a nonconstant family

\[
 \zeta:Y\to\mathbf P H^0(X,N),\qquad
 \zeta^*\mathcal O(1)=R.
\]

For the normalized image B_ζ, put d=deg(Y/B_ζ) and
ℓ=deg O_(B_ζ)(1), so dℓ=rn. If J(Y) is absolutely simple, precisely
the following alternatives remain:

- d=1;
- B_ζ=P¹;
- g(B_ζ)=g(Y), with separable degree one and d a positive power of p.

For positive-genus B_ζ, pullback has positive-dimensional image in J(Y);
simplicity makes it surjective, hence g(B_ζ)≥g(Y). Factor the curve map
through relative Frobenius and apply Riemann--Hurwitz to the separable
factor. Since g(Y)≥2, this forces equality of genera and separable
degree one. It proves the alternatives. In particular p∤rn rules out
the nontrivial Frobenius alternative.

In the rational alternative let ψ:Y→P¹ have degree d. The universal
incidence descends to an integral Γ_0⊂X×P¹ of class N⊠O(ℓ).
Its pullback is Γ SCHEME-THEORETICALLY. Faithful flatness makes Γ_0
integral, since Γ is. If Z is its normalization, then

\[
 Z\to X\text{ is etale of degree }\ell,\quad
 \varphi:Z\to\mathbf P^1\text{ has degree }n,             \tag{3}
\]
\[
 G=\operatorname{Norm}(Z\times_{\mathbf P^1}Y),\qquad
 G\to Z,\ G\to Y\text{ are etale of degrees }d,n.
\]

The composite G→Z→X is the original etale normalization leg in (2);
its intermediate different divisors vanish. The degree identities
follow from dℓ=rn. This is the FULL integral normalized fiber product,
not a selected component with a guessed product degree.

In fact both ψ and φ are separable: the generic fiber-product algebra
is a field of full degree, and its extensions over k(Z),k(Y) are
separable by the two etale maps. A full-degree field base change cannot
remove inseparability. When Y is hyperelliptic, any odd d must therefore
exceed g(Y), again by the hyperelliptic degree-two map and
Castelnuovo--Severi. No map in (3) to P¹ is claimed etale.

## 3. Complete common local ramification, not just equal indices

For each b∈P¹, all completed local extensions at ALL points of both
φ- and ψ-fibers are isomorphic over k((t_b)). To prove this, choose
arbitrary z,y over b and a point of the normalized full fiber product
over (z,y). Its complete field is a compositum of the two local fields.
It is unramified over both by (3); their residue field is algebraically
closed, so each such unramified extension is trivial. Both local
extensions are therefore isomorphic. Arbitrariness gives one common
type for the entire two fibers.

Hence there are integers q_b≥1, Δ_b≥q_b−1 with

\[
 q_b\mid\gcd(n,d),\quad
 \varphi^{-1}(b):q_b^{\,n/q_b},\quad
 \psi^{-1}(b):q_b^{\,d/q_b},
\]
\[
 \frac{\deg\operatorname{Diff}\varphi}{n}
    =\sum_b\frac{\Delta_b}{q_b}
    =\frac{\deg\operatorname{Diff}\psi}{d}.               \tag{4}
\]

Their branch supports coincide; Δ_b is the common different exponent.
In the tame case Δ_b=q_b−1. Riemann--Hurwitz yields

\[
 \frac{g(Z)-1}{n}=\frac{g(Y)-1}{d},\qquad
 d\ell(g(X)-1)=n(g(Y)-1).
\]

These are consistency conditions, not a contradiction: the original
etale diamond already gives g(Y)−1=r(g(X)−1) and dℓ=rn.

## 4. The hyperelliptic norm family and its square values

If Y is hyperelliptic with quotient t:Y→P¹ and involution ι, multiplication
of the sections s_y gives an invariant projective morphism, hence

\[
 \bar\zeta:\mathbf P^1\to\mathbf P H^0(X,N^2),\qquad
 \bar\zeta(t(y))=[s_y s_{\iota y}],\qquad
 \deg\bar\zeta^*\mathcal O(1)=rn.                        \tag{5}
\]

There is no zero product on an integral curve. Its hyperplane pullback
to Y is R⊗ι^*R of degree 2rn, proving the degree. At every one of the
2g(Y)+2 hyperelliptic branch parameters, the value is [s_y²].
The relevant square locus is the multiplication-projected Veronese
{[u²]:u∈H^0(N),u≠0} inside P H^0(N²), not the full Veronese coordinate
space P Sym²H^0(N). The square VALUES need not be distinct.
If rn is odd, ζ cannot factor through t, by degree parity.

## 5. General hyperelliptic pushdown, without a torsion hypothesis

This part also holds over any field of odd characteristic, for smooth
projective GEOMETRICALLY connected curves. Let π:X_0→P¹ be hyperelliptic
of genus h≥2, c_0:C_0→X_0 finite etale of degree M, b=πc_0, and
δ ANY actual degree-zero line bundle on C_0. Write

\[
 b_*\delta=\bigoplus_{j=0}^{h+1}\mathcal O(-j)^{m_j(\delta)},
 \qquad H_j(\delta)=h^0(C_0,b^*\mathcal O(j)\otimes\delta).
\]

This splitting always exists with NO summands outside the stated
interval. Put H_(-1)=H_(-2)=0 and ε=1 if δ is trivial, otherwise zero.
Its exact multiplicities satisfy

\[
\begin{aligned}
 m_j(\delta)&=H_j(\delta)-2H_{j-1}(\delta)+H_{j-2}(\delta),\\
 m_j(\delta^{-1})&=m_{h+1-j}(\delta),\\
 m_0=m_{h+1}&=\epsilon,\qquad
 \sum m_j=2M,\qquad\sum j m_j=M(h+1).
\end{aligned}                                                   \tag{6}
\]

For h=2, this specializes to

\[
 b_*\delta=\mathcal O^\epsilon
       \oplus\mathcal O(-1)^{M-\epsilon}
       \oplus\mathcal O(-2)^{M-\epsilon}
       \oplus\mathcal O(-3)^\epsilon.                    \tag{7}
\]

For h=3 and n_0=H_1(δ), the original five-step formula is

\[
 \boxed{b_*\delta=
 \mathcal O^\epsilon\oplus\mathcal O(-1)^{n_0-2\epsilon}
 \oplus\mathcal O(-2)^{2M-2n_0+2\epsilon}
 \oplus\mathcal O(-3)^{n_0-2\epsilon}
 \oplus\mathcal O(-4)^\epsilon.}                         \tag{8}
\]

Proof. E=(c_0)_*δ has degree zero by etale Riemann--Hurwitz. On an
actual finite etale Galois closure of THIS SINGLE leg, its pullback
splits into the conjugate pullbacks of δ, all degree-zero lines.
Their direct sum is semistable, so E is semistable; no torsion
trivialization is needed. Any positive summand of π_*E would by
adjunction map a positive-degree line π^*O(a) to E, impossible.

One has ω_(C_0)=b^*O(h−1). Finite-flat duality
([Stacks, Section 49.15](https://stacks.math.columbia.edu/tag/0DWM)) gives

\[
 b_*\delta^{-1}=(b_*\delta)^\vee\otimes O(-h-1).
\]

Applying the upper bound also to δ^-1 gives the lower bound −h−1
and the reflection in (6). A degree-zero line has a global section
exactly when trivial, giving the endpoints. Rank and Riemann--Roch
give the two sums. Finally H_j=∑m_i max(j−i+1,0), so its second
differences give (6). At h=2 the two remaining multiplicities follow
from rank and degree. At h=3, Riemann--Roch at the middle twist gives
H_1(δ)=H_1(δ^-1), since b^*O(1)δ has degree g(C_0)−1.
Thus m_1=m_3=n_0−2ε and rank gives m_2, proving (8).
For larger h no unwarranted symmetry m_j(δ)=m_(h+1−j)(δ) is asserted.
Over a nonclosed field, prove semistability after algebraic closure;
the splitting on P¹ and cohomology base change give the same formulas.

## 6. Exact degree-nine specialization and remaining coefficient freedom

Take the older auxiliary curves in characteristic five,

\[
 X:v^2=x^7-x+1,\qquad Y:z^2=1-t^{31},\qquad
 (r,M,g(X),g(Y))=(7,9,3,15),
\]

and assume the etale diamond, (1), and absolute simplicity of J(Y).
The [older Jacobian argument](40_JACOBIAN_NORM_OBSTRUCTION_FOR_THE_SEVEN_DIAMOND.md)
supplies the zero action in that construction; it is the ONLY Jacobian
hypothesis needed for birationality of V→Γ. Section 1 excludes e=3,9
through degrees 3,1 on X, hence e=1. Thus N has degree nine, R has
degree63, |N|=P^6 and |N²|=P^15 by Riemann--Roch.

The degree63 norm family (5) has square values at the32 parameters
μ_31∪{∞}. Its original degree-nine divisor at y is f_*a^*(y).
These facts use the actual incidence family, not merely divisibility.

If ζ is nonbirational, dℓ=63 and hyperellipticity exclude d=3,7,9.
The only possibilities and their FORCED tame profiles are:

| (d,ℓ) | Z→P¹ | Y→P¹ | Linear span dimension of ζ |
|---|---|---|---:|
| (21,3) | 3³ at five values | 3⁷ at five values | 3 or4 |
| (63,1) | 3³,9,9 | 3²¹,9⁷,9⁷ | 2 |

In the first row Z→X is etale of degree three and g(Z)=7; in the
second Z=X. For the first, common index divides gcd(9,21)=3, and
the degree-nine different has degree30, giving five contributions six.
For the second, its different degree22 forces 6A+8B=22, whose unique
nonnegative solution is A=1,B=2. The corresponding Y totals are70
and154. All indices are prime to five, so no wild contribution is
hidden. The span dimensions follow from birational degree-three
subsystems on P¹ (dimensions3 or4) or |O(1)|. In particular span
dimension≥5 forces birational ζ. Neither row is excluded by these counts.

The coefficient-map consequence needs ADDITIONAL data from
[the normed-pencil construction](44_NORMED_HYPERELLIPTIC_BRANCH_PENCIL.md):
a degree18 line L=b^*O(1)δ on C, b=πc, and a basepoint-free
birational subsystem W⊂H^0(C,L). That construction gives δ∈J(C)[14];
this is not inferred from the abstract diamond alone, and (8) no
longer needs its torsion condition.

Writing w=dim W, n_0=h^0(L), one has 3≤w≤n_0≤7. Here g(C)=19.
For the upper bound, suppose ρ=n_0−1≥7. Its degree18 birational
image is NOT strange (a curve whose smooth tangent lines all pass
through one point). Otherwise choose coordinates (1,x,y_2,…,y_ρ) with
dy_i=0 and dx≠0. The ρ independent functions 1,y_2,…,y_ρ are fifth
powers; their fifth roots lie in H^0(O_C(⌊D/5⌋)) for the degree18
hyperplane divisor D. That space has dimension≤⌊18/5⌋+1=4, impossible.
Thus the positive-characteristic non-strange Castelnuovo bound applies
([Voloch, p104](https://ems.press/content/serial-article-files/44668)):
g(C)≤π_0(18,7)=16, decreasing further with ρ, a contradiction.
No smoothness of the complete-series IMAGE was presumed.
With M=9, (8) gives

\[
\begin{cases}
 O(-1)^{n_0}\oplus O(-2)^{18-2n_0}\oplus O(-3)^{n_0},
                                                  &\delta\ne0,\\
 O\oplus O(-1)^{n_0-2}\oplus O(-2)^{20-2n_0}
       \oplus O(-3)^{n_0-2}\oplus O(-4),             &\delta=0.
\end{cases}
\]

At w=7 necessarily n_0=7, giving multiplicities (7,4,7) or
(1,5,6,5,1). The incomplete subsystem W and its multiplication maps
remain genuine extra geometry, not determined by the splitting.

## 7. Exact conductor and why total defect cannot exclude the diamond

For ANY primitive actual bi-etale joint image D⊂X_0×Y_0 whose
correspondence action is zero, with normalization G_0 and leg degrees
d_X,d_Y, the exterior-product class and adjunction give

\[
 D^2=2d_Xd_Y,\quad
 p_a(D)=1+d_Xd_Y+2(g(G_0)-1),\quad
 \delta(D)=d_Xd_Y+g(G_0)-1.                            \tag{9}
\]

The conductor has degree2δ. The normal line of the parametrization
is T_(G_0), since both tangent maps are isomorphisms, so
D²=deg T_(G_0)+2δ. This needs only ZERO ACTION, not vanishing of
the entire Hom group. The more general nonzero-action formulas and
ordered collision divisor are in the
[joint-image conductor criterion](100_JOINT_IMAGE_CONDUCTOR_CRITERION_FOR_BIETALE_COVERS.md).

In (2), g(G)−1=rn(g(X)−1); hence

\[
 \delta(\Gamma)=rn(n+g(X)-1),\qquad
 \deg\mathfrak C_\Gamma=2rn(n+g(X)-1).
\]

This quadratic growth is the EXACT required self-incidence, not an
upper-bound contradiction. Locally y=x and y=x+x^q have both coordinate
projections etale at zero and intersection algebra k[[x]]/(x^q), for
every q≥2. Thus etaleness alone puts no cap on local concentration.

Remaining inputs must restrict the actual pencil profiles, the square
family/subsystem, or how labels consume this conductor. Total
ramification, discriminant degree, Hodge index or normalization defect
alone does not exclude either actual etale leg or the diamond.
