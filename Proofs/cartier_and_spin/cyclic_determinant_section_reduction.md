# Proof by the three determinant divisors

Use the hypotheses in
[the statement](../../Theorems/cartier_and_spin/cyclic_determinant_section_reduction.md).
Write pi:C->P1 for the quotient. Since pi is totally ramified of
degree three at the fixed point O, a fiber over pi(O) is3O.
For every line bundle M of degree m, the divisor norm gives
\[
M\otimes\gamma^*M\otimes\gamma^{2*}M
\simeq\pi^*\operatorname{Nm}_\pi M\simeq O_C(3mO).
\]
This follows directly by summing the three conjugate divisors;
fixed points are counted with their full ramification multiplicity.

## Invariant degree-zero classes come from ramification points

Let \(R_1,\ldots,R_{r-1},O\) be the ramification points. Every
gamma-invariant line bundle admits a gamma-linearization: the third
power of an initially chosen lift is a scalar, which can be removed
by taking its cube root. Hilbert90 then gives an invariant rational
section, whose divisor is invariant. Nonfixed orbits are fibers of
pi and hence linearly equivalent to3O. A degree-zero invariant
class is therefore a sum of \(R_i-O\), and
\(3(R_i-O)=0\).

Put pi(O) at infinity and write the function field as
\(k(C)=k(x,y)\), where
\(y^3=\prod_i(x-b_i)^{m_i}\), \(m_i\in\{1,2\}\).
Multiplying the Kummer generator by a rational function removes
all exponents divisible by three. Its divisor gives the additional
relation
\[
\sum_i m_i(R_i-O)=0.
\]
Reduce all coefficients modulo three and use this relation to set
the final coefficient to zero. Thus at most \(3^{r-2}\) explicit
divisors exhaust the geometric invariant Pic0 classes. No
field-of-definition bound or assertion that the representatives
are distinct is needed. For the fixed \(y^3=P(x)\), degree10,
this gives \(s_i\in\{0,1,2\}\), \(s_{10}=0\), hence19683
representatives.

## An isotypic section space forces invariant line classes

Suppose a saturated nonnegative-degree line M in E is not preserved
as an embedded line by gamma. Its orbit has three distinct generic
lines. Put M_i=gamma^{i*}M with their induced embeddings.
For {i,j,k}={0,1,2}, let D_i be the effective divisor of the nonzero
wedge map M_j tensor M_k -> det E. Thus
\[
M_jM_k\simeq\det E(-D_i),\quad\deg D_i=\delta-2m,
\quad M_i(\delta O)\simeq O_C(D_i+3mO).
\]
Because m>=0, the last effective divisor gives a section s_i of
E(delta O) with zero divisor exactly D_i+3mO. Saturation of M_i
ensures that its inclusion contributes no further zeros.

Every nonzero section of an isotypic C3-space is an eigenvector.
Its saturated image M_i(delta O) is therefore preserved by gamma,
contradicting the three distinct embedded conjugates. The zero
section-space case contradicts the existence of s_i directly.

Now a nonzero map from a degree-zero line into E saturates to a line
M of degree m>=0. Its class is invariant by what was just proved.
The invariant degree-zero line M(-mO) still maps nontrivially into E.
Vanishing for invariant degree-zero twists therefore rules out every
such map. No semistability or reducedness of the wedge divisors is used.

## The norm criterion for every nonnegative line

Let M have degree m>=0 and three distinct embedded conjugates.
Use the same wedge divisors D_i. The norm relation above gives
\(M_i\otimes\det E\simeq O_C(D_i+3mO)\). Choose the corresponding
section \(s=s_0\) of \(E\otimes\det E\), and use its actual
conjugates. Their zero divisors are \(D_i+3mO\); scalar choices
of the norm isomorphism change only constants.

The orbit product has scalar zero divisor
\(D_0+D_1+D_2+9mO\). Over a local DVR, the product of primitive
binary forms stays primitive after reduction to the residue field,
so these scalar orders add exactly. The wedge
\(s\wedge\gamma(s)\) has zero divisor
\(D_0+D_1+D_2+6mO\): its two section zeros and the opposite
saturated-line wedge divisor all contribute. Division therefore gives
\[
s\,\gamma(s)\,\gamma^2(s)=(s\wedge\gamma(s))G,\qquad
G\in H^0(C,\operatorname{Sym}^3E).
\]
For this specially chosen s, G has scalar zero divisor exactly3mO.
No prior exclusion of positive lines is used.

Conversely, suppose this identity holds for nonzero s and nonzero
wedge. Let Z be the scalar zero divisor of s. The norm has scalar
zero divisor \(Z+\gamma Z+\gamma^2Z\), of degree3deg Z.
The wedge is a nonzero section of \((\det E)^3\), so its divisor
has degree3delta. Regularity of G implies deg Z>=delta.
Saturating s yields
\[
O_C(Z)\otimes(\det E)^{-1}\subset E
\]
of degree \(m=\deg Z-\delta\ge0\). Its generic orbit has size three
because the wedge is nonzero. For an arbitrary solution G need not
be supported at O; its scalar zero divisor has degree3m.

Thus the norm identity is equivalent to a nonnegative-degree
saturated line with three distinct embedded conjugates. If E has
no positive line, the resulting degree is zero, giving the earlier
degree-zero criterion as a corollary. All multiplicities and infinity
are retained, and no auxiliary separability assumption is made.

The norm criterion concerns actual embedded lines in a bundle on C.
It does not supply a finite coefficient bundle, another endpoint map,
or an everywhere-etale common source.
