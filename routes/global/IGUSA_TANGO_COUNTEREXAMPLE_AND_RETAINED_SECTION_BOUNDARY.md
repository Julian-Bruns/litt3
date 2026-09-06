# The Igusa counterexample and the information a Tango line forgets

Date: 2026-09-05. Author: /root, analyzing the user-supplied Pro construction.
Status: counterexample accepted after independent checks. Subsequently
the [additive construction](CORELESS_PROJECTIVE_ETALE_SINGLETON_TANGO_COUNTEREXAMPLE.md)
also disproved the universal shared Cartier-zero repair. Litt Problem 3
remains open.

Audit verdicts: **PASS**, /root/igusa_global_geometry_audit, 2026-09-05
([global record](audits/IGUSA_11_CORRESPONDENCE_GLOBAL_AUDIT_2026_09_05.md));
**PASS**, /root/igusa_kummer_differential_audit, 2026-09-05
([differential record](audits/IGUSA_KUMMER_DIFFERENTIAL_AUDIT_2026_09_05.md)).
Clarifications: use the geometric generic endomorphism ring, finite-index
monodromy after descent, inverse level transport on reversed edges, and
the coherently polarized Kodaira–Spencer map. No breaking objection.
Open those records only to investigate a doubt or these clarifications.

## What is disproved

An actual coreless finite etale projective correspondence CAN preserve
a Tango structure, equivalently an everywhere-transverse horizontal
Borel in a dormant Miura oper. In characteristic five there are

\[
 I\longleftarrow^f Z\longrightarrow^g I,
 \quad g(I)=41,\quad g(Z)=481,\quad\deg f=\deg g=12,
\]

with a separating rational function q satisfying

\[
 \eta=d\log q\ne0,\quad \operatorname{div}(\eta)=5S,
 \quad \operatorname{div}(q)=5E,\quad
 f^*q=u^5g^*q,
 \tag{1}
\]

where S is reduced and E is an integral divisor of degree zero.
Thus div(dq)=5(E+S), and the exact differential lines agree after
pullback. Nevertheless the two actual endpoint fields intersect in k.

## Construction and proof

Take the indefinite quaternion algebra over Q of discriminant 6,
maximal order, and fine tame level V1(7). Its characteristic-five
curve C is smooth projective connected. Put
H=X^D(V1(7) intersect V0(11)). The two universal false-degree-11
isogeny maps H to C are finite etale of degree 12. These global
moduli facts, including connectedness at extra prime-power levels,
follow from [Buzzard, Theorem 2.1, Corollary 2.3 and Propositions
2.4–2.5](https://www.ma.imperial.ac.uk/~buzzard/maths/research/papers/shimura.pdf).

Fix a selfadjoint rank-one idempotent at 5 and the resulting principally
polarized height-two p-divisible factor G. Let I to C be the full
Drinfeld-generator Igusa curve for ker V, including supersingular
points. It has degree four and total tame ramification four there.
Transport of the generator by the 11-isogeny gives both full Cartesian
identities

\[
 Z=H\times_{a,C}I\simeq H\times_{b,C}I.
\]

The maps to I are consequently etale everywhere. A supersingular
fiber of Z to H has one underlying point. Finiteness and flatness
imply every component dominates H, so Z is connected.

The level-one signature is (0;2,2,3,3), with orbifold canonical degree
1/3; the torsion-free projective level index is 24. Hence g(C)=5.
Buzzard's Proposition 5.1 and Theorem 5.2 give a Hodge section sigma
with simple zero divisor S, of degree 16. The actual polarized
Kodaira–Spencer isomorphism and ramification yield

\[
 \operatorname{div}(d\pi\,\mathrm{KS}(\sigma^2))=2S+3S=5S.
\]

At the ordinary generic point the Igusa generator frames ker V,
and polarization frames ker F as mu_5. The inverse image of the
generator under Frobenius is therefore a genuine mu_5 torsor over
k(I), defining [q] in k(I)^*/k(I)^{*5}. No formal parameter is being
asserted to be a global rational function. In an ordinary completion
its class is the Serre–Tate extension parameter modulo fifth powers.
[Katz, Main Theorem 3.7.1](https://web.math.princeton.edu/~nmk/old/serretatelocmod.pdf)
identifies its logarithmic differential with the displayed polarized
Kodaira–Spencer form. Injectivity of completion on rational
differentials proves the global equality eta=dlog q. For the torsor
description see also [Ulmer, Lemma 5.2](https://dlulmer.github.io/research/papers/1991.pdf).

Regularity of dlog q makes every valuation of q divisible by five:
its residue at a point is that valuation modulo five. This proves
div(q)=5E and div(dq)=5(E+S). The 11-isogeny acts as identity on the
framed etale quotient and as [11]=[1] on mu_5, by its polarized
pairing. Thus the two torsor classes agree, proving (1). The genus
calculations are 2g(I)-2=4*8+3*16=80 and 2g(Z)-2=12*80=960.

For corelessness of H, the geometric generic O_D-linear endomorphism
ring is Z. Indeed connected V1(11^m) level covers force Morita
monodromy modulo 11^m to have size at least 120*11^(2m-2). A
nonscalar geometric endomorphism would centralize a finite-index
subgroup, whereas its determinant-one centralizer has size O(11^m),
a contradiction. Scalar endomorphisms are integers by the integral
characteristic polynomial and faithfulness on the Tate module.
The 12*11^(n-1) cyclic false-degree-11^n quotients consequently have
distinct targets at fixed n: an isomorphism of two targets would
give a scalar rational endomorphism and equal kernels. Even-length
isogeny chains give unbounded sets of vertices in the actual
bipartite correspondence graph. On reversed edges use the inverse
map on level-7 torsion, not unadjusted dual transport. A common
nonconstant function would confine these vertices to finite fibers.
This proves a*k(C) intersect b*k(C)=k.

The following general fact transfers corelessness to I.

**Full Cartesian field lemma.** Suppose A0,B0 are subfields of L
with A0 intersect B0=k, and A/A0, B/B0 are finite extensions inside
K satisfying A tensor_(A0) L=K=B tensor_(B0) L, as fields.
Then A intersect B=k if k is algebraically closed.

For z in the intersection, the characteristic polynomial of
multiplication by z on K/L is obtained by base change from A/A0
and from B/B0. Its coefficients lie in A0 intersect B0=k. Thus z
is algebraic over k and belongs to k. Apply this to the two complete
connected Igusa fiber products. No arbitrary-component version of
this assertion is being used.

## The lost distinction, and a theorem that does survive

The two forms in (1) have opposite Cartier behavior:

\[
 C(\eta)=\eta,\quad f^*\eta=g^*\eta;
 \qquad C(dq)=0,\quad f^*dq=u^5g^*dq.
 \tag{2}
\]

The first form is genuinely shared. The second has only its
k(Z)^5-line shared. Replacing an actual section by its Tango line
forgets precisely this distinction.

**General incompatibility.** On any coreless etale span with a
shared nonzero Cartier-fixed regular form eta, every shared
d-pluriform is c eta^d: its ratio with eta^d is a common rational
function. If p does not divide d and rd=pn+1, then

\[
 C_n((c\eta^d)^r)=c^{r/p}\eta^{n+1}\ne0.
\]

Thus this span has NO nonzero shared Cartier-zero pluriform in any
weight prime to p. This excludes an entire structural type, not
only this Igusa curve, equal endpoints, genus, or degree.

More precisely, the audited [zero/one/p-minus-one classification](COMPATIBLE_TANGO_STRUCTURES_SINGLETON_OR_QUARTET.md)
shows that this example preserves exactly four Tango structures.
Their connections are

\[
 \nabla_c(r\eta)=(dr+c r\eta)\otimes\eta,
 \qquad c\in\mathbf F_5^*.
\]

Their rational horizontal frames q^(-c) eta are exact. The missing
fifth connection makes eta horizontal and is not Tango. If a
coreless span has a positive canonical intersection and at least
one compatible Tango structure, the shared Cartier-zero branch
is instead exactly the singleton case.

The [separable-domination theorem](CORELESS_CARTIER_TYPE_UNDER_SEPARABLE_DOMINATION.md)
makes this distinction stable: finite separable covers or quotients
between actual coreless etale spans with positive canonical
intersection cannot change Cartier-nonzero type to Cartier-zero
type. Scalar logarithmic witnesses with factors in F_p^* and
compositions with matching intermediate witnesses obey the same
constraint. Arbitrary base change need not preserve corelessness;
arbitrary unrelated correspondences need not have matching witnesses.

## Consequence for the investigation

The [audited tame reduction](CORE_PRESERVING_TAME_REDUCTION_TO_TRANSVERSE_DORMANT_MIURA_DATA.md)
retains a genuinely shared Cartier-zero pluriform as well as the
Tango structure. It therefore lands in the singleton case, which
this counterexample cannot realize, even after the modifications
covered by the preceding theorem. The reduction itself survives.

The subsequent adversarial search constructed a
[coreless projective etale singleton](CORELESS_PROJECTIVE_ETALE_SINGLETON_TANGO_COUNTEREXAMPLE.md)
with an actual shared exact form whose zero divisor is divisible by
five. Thus even that stronger universal nonexistence statement is
false. The classification and stability boundary above survive;
neither is a counterexample to Litt. Future obstructions must retain
additional information about the actual candidate curves.
