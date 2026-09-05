# Ordinary pair factors for every even partition of the seventh-root branch set

**Status:** exact scalar-arithmetic computation, 2026-09-05; not independently
audited. This is an auxiliary input, not a statement about the fixed pair in
file 76. No corelessness or good-reduction assertion is made.

Let \(k=\overline{\mathbf F}_5\), and let \(\zeta\) be a primitive seventh
root of unity. Then **every one of the 210 unordered partitions** of

\[
                         \{1,\zeta,\ldots,\zeta^6,\infty\}
\]

into blocks of sizes \(2,2,4\) has the following property: all three
hyperelliptic curves branched over unions of two blocks are ordinary.
Their genera are \(1,2,2\).

A simple explicit choice is

\[
 \boxed{B_1=\{1,\zeta\},\quad
 B_2=\{\zeta^2,\zeta^3\},\quad
 B_3=\{\zeta^4,\zeta^5,\zeta^6,\infty\}.}
\]

The complete deterministic
[certificate](SEVENTH_ROOT_BRANCH_PARTITIONS_ORDINARY_PAIR_FACTORS_CERTIFICATE.py)
uses only scalar finite-field arithmetic and determinants of size one
or two. Run it with `sage -python`. It checks 98 distinct pair-union
curves, covering all 210 partitions; no point counting is needed.

## Exact field, equations and determinants

Use the explicit field

\[
 \mathbf F_{5^6}=\mathbf F_5[\zeta]/
 (1+\zeta+\zeta^2+\zeta^3+\zeta^4+\zeta^5+\zeta^6).
\]

Its defining polynomial is irreducible, as verified by the certificate.
For any branch subset S of size \(2g+2\), write

\[
 C_S:\quad y^2=f_S(t),\qquad
 f_S(t)=\prod_{\zeta^i\in S}(t-\zeta^i).
\]

If infinity is in S, it is omitted from the product; then
\(\deg f_S=2g+1\), giving precisely the intended branch point at
infinity. Otherwise \(\deg f_S=2g+2\). Every displayed polynomial is
squarefree.

The coefficient matrix for Cartier, before entrywise fifth roots, is

\[
                 H_{ij}=[t^{5i-j}]f_S(t)^2,
                   \qquad1\le i,j\le g.
\]

The actual Cartier matrix has entries \(H_{ij}^{1/5}\); its determinant
is nonzero exactly when \(\det H\ne0\). This distinction is retained
because the coefficients are not generally in \(\mathbf F_5\).

For the selected partition, reduced in the basis
\(1,\zeta,\ldots,\zeta^5\), the three determinants are

\[
\begin{aligned}
 d_{12}&=4\zeta^5+\zeta^4+2\zeta^3+2\zeta^2+\zeta+4,\\
 d_{13}&=4\zeta^5+\zeta^4+\zeta+4,\\
 d_{23}&=3\zeta^5+4\zeta^4+3\zeta^3+4\zeta+4.
\end{aligned}
\]

All are nonzero; hence all three factors are ordinary. The certificate
also prints their explicit defining polynomials and matrices and checks
every other partition.

## Consequence for the existing three-block construction

This paragraph uses the construction of file 110, not a new assertion
about an arithmetic triangle group. Set

\[
 F_1=(t-1)(t-\zeta),\quad
 F_2=(t-\zeta^2)(t-\zeta^3),\quad
 F_3=(t-\zeta^4)(t-\zeta^5)(t-\zeta^6).
\]

Their product is \(t^7-1\). The connected multiquadratic cover obtained
by adjoining all three square roots has the quotient
\(Y:y^2=t^7-1\) by the even-sign subgroup, and a genus-five quotient
\(X_{\rm aux}\) by the simultaneous three-sign flip. Both quotient
maps are étale: at each finite branch point inertia flips one square
root, and at infinity it flips only the third, since only \(F_3\) has
odd degree. This accounts explicitly for infinity instead of incorrectly
treating the three polynomials as even-degree polynomials.

File 110 gives

\[
 J(X_{\rm aux})\sim J(C_{12})\times J(C_{13})\times J(C_{23}),
\]

so this computation proves that \(X_{\rm aux}\) is ordinary. Using the
supersingularity of \(Y\) stipulated in the task, ordinary/supersingular
slope disjointness then yields \(\operatorname{Hom}(J(X_{\rm aux}),J(Y))=0\).
This note does not reprove that separate supersingularity input and does
not infer corelessness, arithmetic good reduction, or any claim about
the fixed genus-nine/genus-twenty-five pair.
