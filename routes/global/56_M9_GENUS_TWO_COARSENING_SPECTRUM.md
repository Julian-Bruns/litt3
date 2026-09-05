# The genus-two full-span coarsening has a finite involution spectrum

## Status and purpose

**Status: proved.**  **Audit: PASS** -- `/root/audit_m9_genus2_spectrum`,
2026-09-04.  No breaking objection; one optional local-intersection
clarification is recorded.  [Audit record](audits/56_M9_GENUS_TWO_COARSENING_SPECTRUM_AUDIT.md).

Assume the degree-nine, full coefficient-span situation of files 47 and
53.  Thus

\[
 q:C\longrightarrow B,
 \qquad g(C)=19,
 \qquad c:C\longrightarrow X
 \tag{56.1}
\]

are respectively a double cover and a finite etale map of degree nine,
where

\[
 X:\quad v^2=x^7-x+1,
\]

and let \(\delta\) be the involution of \(C/B\).  File 53 settles the two
rows with \(g(B)=1\).  This note treats the remaining two rows, in which
\(g(B)=2\).

There is a clean dichotomy.  Either \(\delta\) lies over the hyperelliptic
involution of \(X\), just as in file 53, or its action compressed to
\(J(X)\) belongs to a short explicit integral list.  In the second case
\(J(B)\) is forced to be isogenous to the product of two of the three
fixed elliptic factors of \(J(X)\).  This does not yet eliminate the
genus-two rows, but replaces an arbitrary involution by finite spectral
data.

## 1. Statement

Put

\[
 u=c_*\delta^*c^*\in\operatorname{End}(J(X)).
 \tag{56.2}
\]

File 53 proves

\[
 \operatorname{End}^0(J(X))
 \simeq
 \mathbf Q(\sqrt{-11})\times
 \mathbf Q(\sqrt{-19})\times
 \mathbf Q(i),
 \tag{56.3}
\]

with Rosati-fixed subalgebra \(\mathbf Q^3\), and also proves
\(\operatorname{Aut}(X)=\{1,\iota_X\}\).

### Theorem 56.1

Suppose \(g(B)=2\).  Exactly one of the following alternatives holds.

1. One has
   \[
                  c\delta=\iota_Xc.                 \tag{56.4}
   \]
   Then there is a degree-nine map
   \[
                  r:B\longrightarrow\mathbf P^1_x  \tag{56.5}
   \]
   for which \(C\) is the normalization of
   \(B\times_{\mathbf P^1_x}X\).  The map \(r\) is unramified away from
   the eight branch values of \(X\to\mathbf P^1_x\), and its indices over
   those values are one or two.  Writing the eight fiber profiles as
   \(1^{a_s}2^{b_s}\), one has
   \[
     a_s+2b_s=9,\qquad \sum_s a_s=32,
     \qquad\sum_s b_s=20.                            \tag{56.6}
   \]

2. The reduced image of \((c,c\delta):C\to X\times X\) is not the graph
   of \(\iota_X\).  The endomorphism \(u\) has integral coordinates
   \[
                         (\lambda_1,\lambda_2,\lambda_3)\in\mathbf Z^3
   \tag{56.7}
   \]
   in (56.3).  Let \(e\) be the generic degree from \(C\) to that reduced
   image.  Then \(e\in\{1,3\}\), exactly one \(\lambda_i\) equals \(-9\),
   and, after moving that coordinate to the first position, the complete
   list is as follows:

   \[
   \begin{array}{c|c}
   e& (\lambda_1,\lambda_2,\lambda_3)\\ \hline
   1&(-9,a,-a),\quad |a|\le3,\\
    &(-9,a,1-a),\quad a\in\{-2,-1,0,1,2,3\},\\
    &(-9,a,2-a),\quad a\in\{-1,0,1,2,3\};\\[1mm]
   3&(-9,0,0),\quad(-9,-3,3),\quad(-9,3,-3).
   \end{array}                                      \tag{56.8}
   \]

   Permuting the coordinates in this table is allowed, since the position
   of the \(-9\) records which elliptic factor is killed.

   Moreover the homomorphism
   \[
                 h=q_*c^*:J(X)\longrightarrow J(B) \tag{56.9}
   \]
   is surjective.  Its Rosati square has coordinates
   \[
                 h^\dagger h=(9+\lambda_1,
                    9+\lambda_2,9+\lambda_3),        \tag{56.10}
   \]
   exactly two of which are positive.  Consequently \(J(B)\) is isogenous
   to the product of the two elliptic factors of \(J(X)\) corresponding to
   those positive coordinates.

## 2. Positivity and fixed points

### Lemma 56.2

The coordinates \(\lambda_i\) are integers in \([-9,9]\).  At least one
of them is \(-9\).  If the second alternative of Theorem 56.1 holds, then

\[
                -9\le \lambda_1+\lambda_2+\lambda_3\le-7.
\tag{56.11}
\]

#### Proof

The involution \(\delta^*\) is Rosati self-adjoint, so the same is true of
\(u\).  Equations (56.2)--(56.3) therefore put \(u\) in \(\mathbf Q^3\).
Its three rational coordinates are algebraic integers because \(u\) is an
actual endomorphism; hence they are integers.  The identities

\[
 9\operatorname{id}\mathbin\pm u
       =c_*(1\mathbin\pm\delta^*)c^*                 \tag{56.12}
\]

make both sides Rosati-positive semidefinite, and give
\(-9\le\lambda_i\le9\).

For \(h\) in (56.9), the double-cover identity gives

\[
                h^\dagger h=9\operatorname{id}+u.   \tag{56.13}
\]

The action of \(h\) on first cohomology has rank at most
\(2\dim J(B)=4\).  Every nonzero coordinate \(9+\lambda_i\) contributes
rank two, so at least one coordinate must vanish.  Thus some
\(\lambda_i=-9\).

Let

\[
                 Z=(c,c\delta)_*[C].                 \tag{56.14}
\]

The double cover \(q\) has 32 ramification points.  Each is fixed by
\(\delta\), and contributes one to the pullback of the diagonal because
\(q\) is tamely ramified there and \(c\) is etale.  If
\(S=\sum_i\lambda_i\), the correspondence intersection formula gives

\[
              32\le Z\cdot\Delta_X=18-2S,            \tag{56.15}
\]

so \(S\le-7\).  In the second alternative the support of \(Z\) is not
the graph of \(\iota_X\), so that graph meets \(Z\) properly.  Its
nonnegative intersection gives

\[
              0\le Z\cdot\operatorname{Graph}(\iota_X)
                   =18+2S.                           \tag{56.16}
\]

Thus \(S\ge-9\), proving (56.11). \(\square\)

## 3. Adjunction leaves only the displayed list

### Lemma 56.3

In the second alternative, let \(\Gamma\) be the reduced image of
\((c,c\delta)\) and let \(e=\deg(C/\Gamma)\).  Then

\[
 e\in\{1,3\},\qquad e\mid\lambda_i\ \text{for every }i,
 \qquad
 \sum_i\lambda_i^2\le81+18e.                        \tag{56.17}
\]

#### Proof

Both projections of \(Z\) have degree nine, so \(e\mid9\).  After
normalizing \(\Gamma\), both factors in either projection
\(C\to\widetilde\Gamma\to X\) are etale: the different is effective and
additive in this tower, while the composite \(c\) is etale.  Therefore

\[
                  g(\widetilde\Gamma)=1+18/e.        \tag{56.18}
\]

The cycle identity \(Z=e\Gamma\) says that \(\Gamma\) induces the actual
endomorphism \(u/e\).  Its coordinates \(\lambda_i/e\) are rational
algebraic integers, so \(e\mid\lambda_i\).

Put \(Q=\sum_i\lambda_i^2\).  The reduced curve \(\Gamma\) has bidegree
\((9/e,9/e)\), and its correspondence endomorphism is \(u/e\).  The
standard intersection formula and adjunction on \(X\times X\) give

\[
 p_a(\Gamma)
   =1+\frac{81-Q}{e^2}+\frac{36}{e}.                 \tag{56.19}
\]

Since the delta invariant
\(p_a(\Gamma)-g(\widetilde\Gamma)\) is nonnegative, (56.18)--(56.19)
give \(Q\le81+18e\).

It remains to exclude \(e=9\).  In that case both normalized projections
have degree one, so \(\Gamma\) is the graph of an automorphism of \(X\).
File 53 proves that this automorphism is either the identity or
\(\iota_X\).  The latter is excluded by the second alternative; the former
would give \((\lambda_1,\lambda_2,\lambda_3)=(9,9,9)\), contradicting
(56.11).  Hence \(e\in\{1,3\}\). \(\square\)

#### Proof of Theorem 56.1

If the support of \(Z\) is the graph of \(\iota_X\), then
\(c\delta=\iota_Xc\).  The function \(x\circ c\) descends to \(B\), and
the same normalized-pullback calculation as in Theorem 53.3 gives
(56.5) and the stated local profiles.  The 32 fixed points of \(\delta\)
are precisely the index-one points over the eight branch values.  Finally,
Riemann--Hurwitz for a degree-nine map from a genus-two curve gives total
different 20.  This proves (56.6).

Now assume the second alternative.  Move one coordinate \(-9\), supplied
by Lemma 56.2, to the first position, and write the other two as \(a,b\).
Equations (56.11) and (56.17) say

\[
 a+b\in\{0,1,2\},\qquad a^2+b^2\le18e,\qquad e\mid a,b.
\tag{56.20}
\]

For \(e=1\), direct completion of the square gives respectively

\[
 (a,b)=(a,-a),\ |a|\le3;
\]

\[
 (a,b)=(a,1-a),\ a\in\{-2,-1,0,1,2,3\};
\]

and

\[
 (a,b)=(a,2-a),\ a\in\{-1,0,1,2,3\}.
\]

For \(e=3\), divisibility forces \(a+b=0\), and
\(a^2+b^2\le54\) leaves \(a\in\{-3,0,3\}\).  This is exactly (56.8).
In particular neither \(a\) nor \(b\) is \(-9\), so exactly one
coordinate in (56.7) is \(-9\).  Formula (56.13) now has exactly two
positive coordinates.  Hence \(h\) has four-dimensional image on first
cohomology, so its image is all of the abelian surface \(J(B)\).  The two
nonzero restrictions come from two pairwise nonisogenous elliptic factors
in (56.3); their product maps isogenously onto \(J(B)\).  This proves the
last assertion and the theorem. \(\square\)

## 4. Remaining target

The two genus-two rows of Theorem 47.3 are now reduced to two concrete
possibilities.  In the hyperelliptic case one must compare the degree-nine
pullback (56.5) with the simultaneous \(C_{14}\)- or \(D_{14}\)-closure.
In the non-hyperelliptic case one must decide whether a genus-two Jacobian
with one of the finitely many polarized spectra (56.8) can occur as the
quotient of this particular etale degree-nine cover of \(X\).  Neither
compatibility assertion is proved here.
