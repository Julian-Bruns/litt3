# Proof: a trace-dual annihilator excludes every trace-zero profile

1 October2026. This integrates the completed audited Pro report.
Its substantive prior inputs are the actual support/polynomial reduction,
the exhaustive eleven infinity profiles, and the subsequently established
[uniform annihilator trace lemma](admissible_annihilator_trace_vanishing.md).
The original audited
[report](../../../litt3-computation-data/october01_audited_replies/trace_zero_source/trace_zero_audited/REPORT.md),
[input statement](../../../litt3-computation-data/october01_audited_replies/trace_zero_source/trace_zero_audited/INPUT.md),
[three exact certificates](../../../litt3-computation-data/october01_audited_replies/trace_zero_source/trace_zero_audited/data/certificates.json),
and [audit](../../../litt3-computation-data/october01_audited_replies/trace_zero_source/trace_zero_audited/AUDIT.md)
are retained. Their successful executed checks are recorded in that
archive; this integration does not replay them.

## The hypothetical annihilator

If the degree-zero divisor10H-2E has a section, choose u with
div(u)=2E-10H. Put chi=u/phi, so div(chi)=5G-E.
The torsion condition supplies exactly such a section because
5T-div(phi)=2E-10H. In the short frame write
\[
W=b+L_0/y,\quad q_s=(Q-L_0^5)/y^5,\quad
F_s(Z)=v(Z^5+q_s)^2+(Z^5+q_s)(\gamma Z^3+\eta Z^2+\zeta Z+\xi)+t^3,
\]
where t is the monic cubic of the three selected roots of A,
gamma=N2/y^2 and D=3gamma Z^2+2eta Z+zeta.
Set m_j=Tr_{k(S)/k(X)}(chi W^j). Actual etaleness splits every
completed base disk; traces sum the branches without division by ten.

At O, q_s has exact pole seven. On each of the five small branches,
W has pole at most one, E has multiplicity one and G is absent.
Hence u has pole8 and chi pole1. On a large branch of pole a>=2,
E is absent, G has multiplicity a-2, u has pole10 and chi has
order5(a-2). Therefore
\[
\operatorname{pole}_O m_j\le
\max\bigl(j+1,\max_{a\text{ large}}((j-5)a+10)\bigr).
\]
These bounds remain valid under cancellations.

## Four vanishing traces

Apply the uniform lemma directly to this actual source and its
annihilator. It gives
\[
m_0=m_1=m_2=m_3=0,\qquad m_4\in\langle1,x,x^2\rangle.
\]
In particular m4 has pole at most six. This step is independent of
the three selected roots of A and does not require arithmetic over
their splitting field. The fixed congruence calculation underlying
the uniform lemma takes place over the original F25.

## Trace-dual interpolation

For the ten conjugate roots Wi and conjugates chi_i define
\[
U(Z)=\sum_i\chi_i\frac{F_s(Z)}{Z-W_i}.
\]
This is a polynomial over k(X). Expanding at Z=infinity and using
the four vanishings gives degree U<=5. Its top coefficients are
\[
A_5=vm_4,\quad A_4=vm_5,\quad
A_3=vm_6+\gamma m_4,\quad
A_2=vm_7+\gamma m_5+\eta m_4.
\]
Since Fs'=(Z^5+q_s)D, evaluation gives
\[
U(W)=\chi F_s'(W)=uD(W).
\]
This is a multiplicative identity, never division by the critical
derivative. Repeated critical values and zero critical discriminants
are retained.

## Infinity contradiction

The two exhaustive profiles have v pole0 or3 and large poles
(6,6,4,2,2) or(5,5,3,2,2). The unique maximally polar products
in the W^8 and W^7 coefficients give exact gamma pole12 or13
and eta pole16. The W coefficient is q_s zeta; every nine-root
product has pole at most24 after multiplying by v. Hence zeta
has pole at most17. The bounds above on m5,m6,m7 give
\[
\begin{array}{c|rrrr}
&A_2&A_3&A_4&A_5\\\hline
\text{constant}&22&18&10&6\\
\text{linear}&23&19&13&9
\end{array}
\]
for coefficient pole bounds.

The two remaining coefficient bounds follow directly from
U(Z)=sum_i chi_i v product_{j!=i}(Z-W_j). Write d for the
pole of v; the sum of the five large branch poles is20-d.
For a coefficient A_j with j<=4, a small-i summand has pole
at most
\[
d+(20-d)+(4-j)+1=25-j.
\]
A large-i summand, whose omitted branch has pole a>=2, has
pole at most
\[
d+(20-d-a)+(5-j)+10-5a=35-6a-j\le23-j.
\]
Every chosen root product is bounded by taking all available large
poles and then small poles of at most one. Thus A0 has pole at
most25 and A1 at most24, without an assumption on the residual
roots or their distinctness. Cancellations only improve these bounds.

On either pole-two branch, the term2eta W has exact pole18;
3gamma W^2 and zeta have strictly smaller poles. Thus uD has
exact pole28. But each term of U(W) has pole at most
\[
\begin{array}{c|rrrrrr}
&A_0&A_1W&A_2W^2&A_3W^3&A_4W^4&A_5W^5\\\hline
\text{constant}&25&26&26&24&18&16\\
\text{linear}&25&26&27&25&21&19
\end{array}
\]
so their sum cannot have pole28. This contradiction proves the
claimed section vanishing and excludes actual torsion sources.

The fixed base-field congruences of the uniform trace lemma and the
supplied exhaustive profiles are the only finite arithmetic inputs.
The original tower-field certificates remain as provenance but are
no longer needed in this shortened proof. Large square-tail
searches and historical parameter-locus scans are absent from this
proof. The nonzero-first-moment sector and arbitrary-degree admissible
sources require further work; unmarked common-cover extraction is
not supplied.
