# Homogeneous-character vanishing forces a characteristic-power factor

ID: `character_homogeneous_polynomial_factorization`. Version1,2 October2026.
Author proof; [independent focused review](../../Research/audits/HOMOGENEOUS_CHARACTER_FACTORIZATION_AUDIT_2026_10_02.md) PASS. This is an algebraic
factorization criterion, not an unmarked common-cover exclusion.

Let K be the function field of a smooth connected projective curve over
an algebraically closed field k of characteristic p. Let V be a k-vector
subspace of K containing1, and eta,beta rational differentials on K.
Assume
\[
\{g\in V:dg=0\}=k,\qquad
\{g\in V:dg=j\,beta\,g\}=0\quad(1\le j<p).
\]
Let F(Z) be monic of degree N, with coefficients in V, satisfying
\[
dF+(eta+beta Z)F_Z-N\,beta F=0.
\]
Write N=ap+s with0<=s<p. Then
\[
\boxed{F(Z)=R(Z)P(Z^p),\qquad R\in K[Z]\text{ monic of degree }s,
\quad P\in k[Z]\text{ monic of degree }a.}
\]
Consequently an irreducible separable such polynomial has N<p.

For an ACTUAL connected finite etale cover q:S->C, suppose chi generates
k(S)/K, dchi=qeta+chi*qbeta and its pole divisor is pG. The coefficients
of its actual minimal polynomial lie in V=L_C(pq_*G). If that V satisfies
the two stated vanishing conditions, the conclusion bounds deg(q)<p.
This retains the actual cover and pole divisor; it does not assert those
vanishings for general G. In the selected genus-two character sector,
the audited primitive-degree-eight theorem supplies them when degG=1.

[Proof](../../Proofs/shared_tensors/character_homogeneous_polynomial_factorization.md).
