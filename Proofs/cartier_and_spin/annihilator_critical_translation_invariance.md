# Proof of additive invariance and its exact boundary

Original proof1 October2026; Version2 scalar-scope clarification3 October2026.
[Statement](../../Theorems/cartier_and_spin/annihilator_critical_translation_invariance.md).
This conceptual result originates in Section5.2 of the returned
[reciprocal report](../../../litt3-computation-data/oct01_pro_replies/reciprocal_trace_profile_10_3/reciprocal_trace_profile_10_3/REPORT.md).
The parent and source agent reviewed its implication directly; no
computation or replay of the supplied scripts was needed.

Trace-dual interpolation for the ten distinct generic roots $W_i$
of the separable, not necessarily monic $F$ gives
\[
\operatorname{Tr}(J(W)/F'(W))=0\qquad(\deg J\le8).
\]
Indeed the interpolation formula has summands
$J(W_i)F(T)/(F'(W_i)(T-W_i))$. Comparing coefficients of $T^9$
gives $v\operatorname{Tr}(J(W)/F'(W))=0$, where $v\ne0$ is
the leading coefficient of $F$. This is an identity over $K$;
it does not require $v$ to be a unit at each finite point.

Using $F'=\phi D$ and $U(W)=uD(W)$, it follows that
\[
\operatorname{Tr}(W^j/\phi)=0\ (0\le j\le5),\qquad
\operatorname{Tr}(uW^j/\phi)=0\ (0\le j\le3).
\]
The first identity proves invariance of $\rho$. Since ten is zero
in characteristic five, $\operatorname{Tr}1=0$ proves invariance
of $m_5$. Expanding $(u-z)^2$ and applying the two identities
proves invariance of the three quadratic traces. The defining
formula for $Q$ uses only these traces and the unchanged $F,D$,
so $Q$ is unchanged.

Expanding $(U-zD)^2$ gives the stated quotient identity. Also
$U_z\equiv U\pmod D$. The root-product formula for the formal
degree-three/five resultant therefore leaves
$\operatorname{Res}_{3,5}(D,U_z)$ unchanged, including lower
actual numerator degree. Equivalently, the resultant is a
polynomial identity in coefficients, so the conclusion extends
to repeated roots of $D$; a root discriminant is unnecessary.
The other two critical resultants are unchanged directly.
Their existing parity expressions are consequently unchanged.

At every selected finite point, the original actual divisor has
$\operatorname{ord}u=2$. Subtracting a nonzero constant scalar
$z\in k^\times$ makes $u-z$
a unit there. This loses the prescribed double zero and the
associated endpoint jets. Thus the invariance concerns a formal
coefficient package on the fixed actual extension, not a family
of admissible sources. It proves neither a trace-zero witness nor
an impossibility of such a witness under the full hypotheses.
Every nonzero constant is a unit in the actual local ring through the
original structure morphism; no arbitrary nonzero rational function has
this property. The generic $K(z)$ identities and this actual constant-scalar
local conclusion are separate scopes.

The literal actual-source aggregate is kernel checked in
`Solutions.CartierAndSpin.AnnihilatorCriticalTranslationSource`.
It constructs the primitive power basis and the independent rational
extension, keeps the original smooth Scheme and its closed stalks, and
derives the five trace invariants, critical quadratic and formal resultants,
the transformed identity and the loss of every selected double zero.
Focused evidence is in
[the345-declaration trust audit](../../../litt3-computation-data/formalization-20261003/verification/20261003T055358Z/report.json).
