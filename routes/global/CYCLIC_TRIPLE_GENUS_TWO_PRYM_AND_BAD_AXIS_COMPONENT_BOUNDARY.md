# Cyclic triple covers of genus two: Prym and bad-axis component bounds

Date: 2026-09-05. Proposal: `/root`.
Algebraic proof and source comparison: `/root/canonical_trace_algebra`.
Status: author-checked necessary conditions; no independent audit and no
novelty claim. This does not prove restricted-theta properness for every
character, or eliminate isolated bad fibers.

Let k=Fbar_5 and let q:U -> Y be an actual connected etale cyclic cover
of degree three, where Y is an ordinary genus-two curve. Write sigma
for a generator, J=J(U), A=q^*J(Y), P=(ker Nm_q)^0 and Q=J/A.
Then g(U)=4 and A,P,Q are abelian surfaces. Whenever Raynaud's divisor
is used below, all Jacobians, inclusions and automorphisms are on the
scalar Frobenius twists. Suppressing that superscript does not mean
pulling a polarization back by a degree-five isogeny.

## 1. Exact algebraic Prym decomposition and polarizations

The restrictions L_A,L_P of the principal Jacobian polarization both
have type (1,3). There is an elliptic curve E and an isomorphism

\[
 P\simeq E^2,
 \qquad
 L_P\leftrightarrow H=
 \begin{pmatrix}2&-1\\-1&2\end{pmatrix},
 \qquad
 \sigma_P\leftrightarrow S=
 \begin{pmatrix}0&-1\\1&-1\end{pmatrix}.                    \tag{1.1}
\]

These are actual isomorphisms of abelian varieties; the polarization
on E^2 is not the product principal polarization.

Here is a proof using algebraic maps in characteristic five. The
hyperelliptic involution of Y inverts the defining three-torsion
line, so it lifts to an automorphism j of U conjugating sigma to its
inverse. Its square belongs to C_3 and is invariant under this
conjugation, hence j^2=1. Above each of the six Weierstrass points it
fixes exactly one point of the three-element fiber, and there are no
other fixed points. The degree-two quotient r:U -> E=U/<j> therefore
has six ramification points; Riemann--Hurwitz gives g(E)=1.

Pullback i=r^*:E -> J is injective. Indeed, its kernel is killed by
two; a nontrivial kernel character would factor the degree-two map r
through an etale double cover of E, contradicting its ramification.
Since j acts trivially on i(E) and as -1 on J(Y), Nm_q i=0. Its
connected image is therefore in P. Consider

\[
 \Phi:E^2\longrightarrow P,\qquad (x,y)\longmapsto i(x)+\sigma i(y).
\]

With adjoints for the principal Jacobian polarizations, i^dagger i=2.
Put b=i^dagger sigma i. The identities j i=i and j sigma=sigma^{-1}j
give b=b^dagger. On P, 1+sigma+sigma^2=0, so 2+b+b^dagger=0.
Thus b=-1 and the pulled-back polarization is H in (1.1). Its degree
is 9; in particular Phi is an isogeny onto P.

For completeness, q^*:J(Y) -> A has kernel the cyclic group generated
by the defining line, of order three. Pullback of L_A is three times
the principal polarization of J(Y). Taking degrees of polarization
isogenies gives deg(lambda_(L_A))=3^4/3^2=9, hence type (1,3).
Complementarity in the principally polarized J identifies the kernels
of the two restricted polarizations with A cap P. Thus L_P also has
degree 9 and type (1,3). Since
deg(lambda_(Phi^*L_P))=(deg Phi)^2 deg(lambda_(L_P)), Phi has degree
one and is an isomorphism. The relation sigma^2 i=-i-sigma i gives S.

The principal polarization identifies Q with P^vee. Under the
product principal identification (E^2)^vee=E^2, the quotient map
restricted to P and a dual polarization on Q are

\[
 \psi:P\longrightarrow Q,\quad \psi=H,\quad \deg\psi=9,
 \qquad
 L_Q\leftrightarrow H^\#=
 \begin{pmatrix}2&1\\1&2\end{pmatrix}.
                                                               \tag{1.2}
\]

In particular,

\[
 L_P^2=L_Q^2=6,
 \qquad \psi^*L_Q\equiv3L_P,
 \qquad
 \sigma_Q\leftrightarrow R=S^{-T}=
 \begin{pmatrix}-1&-1\\1&0\end{pmatrix}.                    \tag{1.3}
\]

The finite etale group A cap P=ker psi has order nine and is C_3^2.
No ordinarity assumption on E or P was used in this section.

## 2. Positive-dimensional bad fibers produce divisor components

Let Theta_U be Raynaud's effective divisor on J(U^(1)), of numerical
class 4 times the principal polarization. Define the closed subset

\[
 \mathcal B=\{z\in Q:\pi^{-1}(z)\subset\Theta_U\},
 \qquad \pi:J\longrightarrow Q.                            \tag{2.1}
\]

Closedness follows because the complement is the open image
pi(J minus Theta_U) under the smooth morphism pi. Moreover 0 is not
in B: projection formula and etale functoriality of B_U express the
restriction to A as the sum of the three translates of Theta_Y by
the defining cyclic characters. A finite union of proper theta
divisors cannot cover J(Y). This proves only the zero fiber is good.

The restriction Theta_U|P is a proper effective divisor: J/P is
isogenous to the ordinary J(Y), so the ordinary-complement/Dirac
criterion applies. Its numerical class is 4L_P. The criterion and
its precise Frobenius conventions are recorded in
[the sufficient-conditions note](RESTRICTED_RAYNAUD_THETA_SUFFICIENT_CONDITIONS_AND_STABILITY_BOUNDARY.md).

If D is an irreducible curve component of B, pi^{-1}(D) is an
irreducible divisor of J: pi is smooth with geometrically connected
abelian fibers. Hence it is an actual component of Theta_U. The
divisor Theta_U is invariant under sigma and inversion, by curve
functoriality and Raynaud-theta symmetry. Let O(D) be the set of
distinct curves in the orbit under <sigma_Q,-1>, and put k=|O(D)|.
If pi^{-1}(D) occurs with multiplicity m, all its orbit members have
the same multiplicity, and restriction to P gives

\[
 m\sum_{D'\in O(D)}\psi^*D'\ \le\ \Theta_U|P.
\]

Writing d=L_Q.D, intersection with L_P and (1.3) yield

\[
 L_P.\psi^*D=\tfrac13\psi^*L_Q.\psi^*D=3d,
 \qquad \boxed{mkd\le8}.                                   \tag{2.2}
\]

This is a component inequality, not a bound obtained by counting
points of the two-dimensional theta restriction. Multiple component
orbits must share the same total budget: sum m_j k_j d_j <= 8.

## 3. Curves of small degree and arbitrary endomorphism rings

An irreducible curve D in Q has d>=2. If it is not an elliptic
translate, then D^2>=2, and Hodge index gives

\[
 6D^2\le d^2,\qquad
 p_a(D)=1+D^2/2\le1+\lfloor d^2/12\rfloor.                \tag{3.1}
\]

To verify the elliptic bound without any integer-slope assumption,
write L_Q as the sum of the two coordinate elliptic curves and the
anti-diagonal. On an arbitrary elliptic subgroup T of E^2, its degree
is the sum of the degrees of the three homomorphisms x,y,x+y:T -> E,
where a zero map contributes zero. If one is zero, T is one of these
three coordinate directions and the other two are isomorphisms, so
the sum is two. Otherwise all three degrees are positive. Thus d>=2;
equality singles out precisely these three directions. Translation
does not affect this calculation. For nonelliptic D, (3.1) implies
d>=4. There are no rational curves in an abelian variety.

If sigma_Q D=D, one gets an additional divisibility independent of
CM or supersingularity. Under the product principal polarization,
write the Neron--Severi class as the Rosati-Hermitian matrix

\[
 M=\begin{pmatrix}a&b\\b^\dagger&e\end{pmatrix},
 \quad a,e\in\mathbf Z,\quad b\in\operatorname{End}(E).
\]

The equation R^T M R=M says e=a and b+b^dagger=a. Consequently

\[
                  d=L_Q.D=4a-(b+b^\dagger)=3a.              \tag{3.2}
\]

All endomorphisms are allowed here, including quaternionic ones.
In particular the sigma-invariant numerical classes are not assumed
to have rank one. Over Fbar_5 the heuristic End(E)=Z is unavailable.

If an elliptic translate is sigma-stable, its underlying elliptic
subgroup is sigma-stable. The restriction of sigma to that subgroup
is a nontrivial order-three automorphism: sigma-1 on Q is an isogeny,
so cannot kill a positive-dimensional subgroup. An elliptic curve
with such an automorphism in characteristic five has j=0 and is
supersingular. The latter also follows directly from its model
y^2=x^3+c: the coefficient of x^4 in (x^3+c)^2 is zero. Since it is
isogenous to E, E and P must then be supersingular.

## 4. The remaining component possibilities

Since <sigma_Q,-1> is cyclic of order six, k is 1,2,3 or6.
Equations (2.2), (3.1), and (3.2) give the following necessary table.
It does not assert existence of any listed Raynaud component.

| Orbit size k | Necessary curve type and degree d | Multiplicity bound |
| --- | --- | --- |
| 6 | Impossible | — |
| 3 | Symmetric elliptic translates, d=2 | m=1 |
| 2 | sigma-stable elliptic translates, d=3; P supersingular | m=1 |
| 1 | d=3, elliptic; P supersingular | m<=2 |
| 1 | d=6, with p_a(D)<=4; if elliptic then P supersingular | m=1 |

For k=3 the stabilizer is inversion; for k=2 it is C_3. For k=1
the curve is stable under both. Every curve in the table avoids zero,
because 0 is not in B. In particular, when P is ordinary only the
k=3 row and the nonelliptic d=6 portion of the k=1 row survive these
tests. The total orbit budget in (2.2) must also be imposed.

The surviving numerical cases are not empty merely as configurations
of divisors with these symmetries. For example, for nonzero a in E[2],
the three elliptic curves x=a, y=a, x+y=a form a symmetric sigma-orbit,
avoid zero, and have total class L_Q and total d-degree six. This is
only a configuration on Q, not an assertion that their inverse images
are components of the actual Theta_U. Additional Cartier/Dirac
conditions could eliminate configurations admitted by this table.

## 5. Source comparison and exact endpoint

The decomposition is classical: Lange--Ortega,
[*Prym varieties of etale covers of hyperelliptic curves*](https://arxiv.org/pdf/1601.04082),
Section 2, Theorem 2.1(a), records the isomorphism (x,y) -> x+sigma(y)
in odd degree, attributing the original prime-degree case to Ries
and the generalization to Ortega. Its displayed polarization type
specializes to (1,3). Agostini,
[*On the Prym map for cyclic covers of genus two curves*](https://arxiv.org/pdf/2001.06264),
equation (2.2), gives the same type. The algebraic norm proof in
Section 1 above verifies the degree-three assertion directly in
characteristic five rather than assuming an analytic argument
transfers. Raynaud's class and symmetry are also recorded in
[Tong, Corollaries 1.2.3.2 and 1.2.3.4](https://arxiv.org/pdf/0712.2046).

The conclusion is a bounded classification of possible positive-
dimensional bad-fiber components. An isolated point of B has an
A-fiber of codimension two in J; it need not create a divisor
component of Theta_U, so the orbit table does not apply to it. Even
proving B finite would not prove B empty or eliminate every bad
character. No theta-properness theorem for all covers is claimed.

All covers and quotients in the setup are actual. This is a
parameterized theta boundary, not a new fixed-pair exclusion: the
older packet theorem already handles the relevant bounded-index-
three monodromy class for the original file-76 target.
