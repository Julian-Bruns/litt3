# The abelian part of the explicit genus-nine endomorphism field

## Status

**Proved; exact three-prime certificate included; self-check complete.**

This note sharpens the endomorphism-field input for the genus-nine curve
\(X\) of file 76_EXPLICIT_BRANCH_RATIONAL_R3_REDESIGN.md. Files 76 and
79 already prove

\[
 \operatorname {End}^0_{\overline{\mathbf F}_5}J(X)
       =K=\mathbf Q(\pi),\qquad [K:\mathbf Q]=18,
\]

and \(\mathbf Q(\pi^n)=K\) for every \(n\geq1\). Nothing from those
absolute-simplicity calculations is recomputed here.

### Theorem

For this field,

\[
 K\cap\mathbf Q^{\rm ab}=\mathbf Q(\zeta _3),
 \qquad
 a_0=[K\cap\mathbf Q^{\rm ab}:\mathbf Q]=2.             \tag{1}
\]

## 1. Short discriminant proof

The cubic deck transformation of \(X\) induces a nonidentity element of
order three in

\[
              \operatorname {End}^0J(X)=K.
\]

Indeed, its invariant differential space comes from
\(X/C_3\simeq\mathbf P^1\) and is zero. Since \(K\) is a field, the
endomorphism satisfies \(T^2+T+1=0\), and therefore

\[
                         \mathbf Q(\zeta _3)\subset K.  \tag{2}
\]

File 76 gives the exact field discriminant

\[
 \operatorname {disc}K=
 -3^{11}29^2 10589^2 16451926081^2 24415659240899^2.   \tag{3}
\]

Put \(E=K\cap\mathbf Q^{\rm ab}\). It is an abelian Galois extension of
\(\mathbf Q\), it contains \(\mathbf Q(\zeta _3)\), and its degree divides
18. If it were larger than this quadratic field, its abelian Galois group,
of order \(6\) or \(18\), would have a quotient of order three. Thus
\(E\), and hence \(K\), would contain a cyclic cubic field \(C\).

The discriminant tower formula for \(K/C\) says

\[
 \operatorname {disc}(C)^6\mid\operatorname {disc}(K).  \tag{4}
\]

Equation (3) forces every prime other than \(3\) to have valuation zero
in \(\operatorname {disc}(C)\), and forces its 3-adic valuation to be at
most one. Hence \(|\operatorname {disc}(C)|\mid3\). But a cyclic cubic
field is totally real and has square discriminant (equivalently, its
Galois group lies in \(A_3\)). Its discriminant would therefore be one,
which is impossible for a nontrivial number field by Minkowski's theorem.
This contradiction proves

\[
                         E=\mathbf Q(\zeta _3),
\]

and establishes the theorem. \(\square\)

## 2. Independent strengthening: the real trace field has closure \(S_9\)

Complex conjugation on the Weil field sends \(\pi\) to \(25/\pi\). Put

\[
 \theta=\pi+25/\pi,\qquad K^+=\mathbf Q(\theta).
\]

The real trace polynomial recorded in file 79 is

\[
\begin{aligned}
Q_X(U)={}&U^9-2U^8-254U^7+457U^6+21826U^5-29834U^4\\
         &-703917U^3+354810U^2+6210225U+6613875.        \tag{5}
\end{aligned}
\]

It satisfies

\[
                         P_X(T)=T^9Q_X(T+25/T),         \tag{6}
\]

so \(K^+\) has degree nine. Exact square-free factorizations at three
good primes have degrees

\[
\begin{array}{c|c}
 \ell&\text{factor degrees of }Q_X\bmod\ell\\ \hline
 2&(9)\\
 107&(8,1)\\
 11&(7,2).
\end{array}                                             \tag{7}
\]

Let \(G\leq S_9\) be the Galois group of \(Q_X\). The first row makes
\(G\) transitive. The second supplies an eight-cycle with one fixed
point and forces primitivity. Indeed, the only possible nontrivial
block system in degree nine has three blocks of size three. The block
containing the fixed point would be invariant, so its other two points
would form a nonempty proper invariant subset of the eight-cycle.

The final row supplies an element of cycle type \((7)(2)\); its seventh
power is a transposition. A primitive permutation group containing a
transposition is the full symmetric group: the graph whose edges are
the conjugates of that transposition is connected, and its edge
transpositions generate \(S_9\). Therefore

\[
                         G=S_9.                         \tag{8}
\]

The subgroup fixing one root is \(S_8\), a maximal and nonnormal subgroup
of \(S_9\). Galois correspondence consequently shows that \(K^+\) has
no intermediate field strictly between \(\mathbf Q\) and \(K^+\), and
that \(K^+/\mathbf Q\) is not Galois.

## 3. A second derivation of the upper bound

The field \(K\) is a CM field with maximal real subfield \(K^+\). If
\(E\subset K\) is abelian over \(\mathbf Q\), then
\(E\cap K^+\) is an intermediate field of \(K^+/\mathbf Q\). It cannot
equal \(K^+\), since every subfield of the abelian Galois extension
\(E/\mathbf Q\) is Galois. Hence

\[
 E\cap K^+=\mathbf Q,\qquad
 [E:\mathbf Q]=[EK^+:K^+]\leq[K:K^+]=2.                \tag{9}
\]

Together with (2), this independently recovers (1). The \(S_9\)
calculation is not needed for the shorter discriminant proof, but records
the stronger useful fact that the real trace field is primitive and
non-Galois.

## Consequence for the packet constants

Whenever file 95 or 96 is applied with the geometric endomorphism field
of this genus-nine \(J(X)\), its abelian-intersection constant is exactly

\[
                              a_0=2,
\]

not merely an unspecified divisor of \(18\). This does not alter the
separate sharper value \(a_0=1\) proved in file 98 for the genus-25
Jacobian.
