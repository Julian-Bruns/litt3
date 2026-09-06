# Coreless clump existence: primary-source boundary, 5 September 2026

Status: bounded literature review by `/root/coreless_clump_recent_sources`;
no new theorem. No resolution of Krishnamoorthy's Question 9.7 was located,
including under ordinary endpoint Jacobians, a genus-two endpoint,
`Hom(JX,JY)=0`, or prescribed endpoint-Jacobian Newton polygons.
This records a search result, not a proof that no such result exists.

## The exact open input and the finite group scheme

In Krishnamoorthy, *Correspondences without a core*, ANT 12 (2018),
1173--1214, Question 9.7 concerns **projective** curves with **both** maps
finite etale. It asks for a clump, equivalently an invariant
pluricanonical form. Proposition 8.2 bounds each invariant-section space
by one. Lemma 8.9 makes

\[
 P=\ker\bigl(J_X\times J_Y\xrightarrow{f^*-g^*}J_Z\bigr)
\]

a finite group scheme when there is no core. Corollary 8.10 makes positive
invariant line bundles rationally proportional to the canonical pair.
These prove uniqueness of a clump (Theorem 9.6), not its existence.

For \(G=P[p]\), Corollary 8.17 gives a sufficient condition for an
invariant **one-form**: the map
\(T_eJ_X[p]\to T_eG^D\) must be nonzero. Question 8.18 asks whether an
invariant one-form forces \(P^D\) nonreduced. Finiteness alone supplies
neither a nonzero tangent map nor a pluricanonical section.

[Published primary PDF, Sections 8--9](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf).

## A later positive theorem with an actual invariant form

Krishnamoorthy--Sheng, *Periodicity of Hitchin's uniformizing Higgs
bundles*, IMRN 2024(11), 9440--9468,
[DOI](https://doi.org/10.1093/imrn/rnae042), treats good reductions of
**Hodge-type Shimura curves**. In
[arXiv:2011.03272v2](https://arxiv.org/pdf/2011.03272v2), Theorem 1.9,
Corollary 3.23, Proposition 3.25 and Corollary 3.26 give

\[
 HW\in H^0\!\left(M_0,K_{M_0}^{(p^r-1)/2}\right),\qquad
 HW\ne0,\qquad
 \#\operatorname{div}(HW)=(p^r-1)(g(M_0)-1),
\]

where \(r=[F_{\mathfrak p}:\mathbf Q_p]\). The prime is odd,
unramified in the totally real field, and avoids the quaternion
discriminant, with good integral level. The divisor is reduced and its
preimage is the unique clump for the chosen prime-to-\(p\) Hecke
correspondence.

Proof inputs: periodicity with respect to the distinguished Shimura
\(W_2\)-lifting; compatibility of inverse Cartier with finite etale
pullback; Honda--Tate nonvanishing; a display calculation for simple
zeros; and the one-clump theorem. Nonempty Newton jumping follows from
quasi-affineness of Ekedahl--Oort strata and properness of the nonconstant
moduli curve.

These Newton polygons describe fibers of the **universal abelian
scheme**, not \(J(M_0)\); they impose no stated endpoint-Jacobian
restriction.

## Other directly relevant subsequent work

Bellaiche, *On self-correspondences on curves*, ANT 17 (2023),
1867--1899, [DOI](https://doi.org/10.2140/ant.2023.17.1867),
[arXiv primary text](https://arxiv.org/pdf/2004.09689), Proposition 2.3.1
(preprint numbering), proves at most one nonempty finite equiramified
complete set for a non-finitary self-correspondence over an algebraic
extension of a finite field. It is a uniqueness refinement. Its proof
uses torsion of degree-zero divisor classes and roots of unity over
finite fields; it does not produce the first finite complete set.

Krishnamoorthy, *Rank 2 local systems, Barsotti--Tate groups, and Shimura
curves*, ANT 16 (2022), 231--259,
[DOI](https://doi.org/10.2140/ant.2022.16.231),
[arXiv:1711.04797v2](https://arxiv.org/pdf/1711.04797v2),
Corollary 10.8 (preprint numbering), treats a coreless etale
**self-correspondence** already equipped with a height-two,
dimension-one Barsotti--Tate group \(\mathcal G\), everywhere versally
deformed and satisfying \(f^*\mathcal G\simeq g^*\mathcal G\).
Xia's unique lifting theorem synchronizes the two lifts, and
characteristic-zero arithmeticity then applies. Theorem 10.11 constructs
this input under further invariant rank-two local-system and trace-field
hypotheses. Ordinary Jacobians alone do not supply these hypotheses.

## Recency check and limits

The search included exact-title and Question 9.7 / Question 8.18 searches,
clump and invariant-pluricanonical terminology, the directly citing
self-correspondence and periodic-Higgs papers, and date-restricted
searches for 5 June--5 September 2026. No new relevant result was found in
that interval. The author's
[publication list, revised July 2026](https://notnotraju.github.io/math_research/math_research.html)
lists no clump-existence resolution. Search indexing can lag.

The affine common-cover theorem, correspondences with a ramified second
leg, and ambient moduli-space Newton data do not fill the stated
projective two-etale-leg gap.
