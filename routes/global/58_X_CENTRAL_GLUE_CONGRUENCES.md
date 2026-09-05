# Central gluing congruences for the three elliptic factors of `J(X)`

## Status and purpose

**Status: proved; independent audit pending.**

Let

\[
 X:\quad v^2=x^7-x+1
\]

over \(k=\overline{\mathbf F}_5\).  File 53 proves that

\[
 \operatorname{End}^0(J(X))
 =K_1\times K_2\times K_3,
\tag{58.1}
\]

where the three factors have Frobenius traces

\[
             t_1=3,\qquad t_2=-1,\qquad t_3=-4.
\tag{58.2}
\]

The main result below determines enough of the *integral gluing* between
these rational factors to finish the genus-two case left open in file 56.
If an integral Rosati-fixed endomorphism has rational-factor coordinates
\((\lambda _1,\lambda _2,\lambda _3)\), then

\[
 \lambda _1\equiv\lambda _2\pmod4,\qquad
 \lambda _1\equiv\lambda _3\pmod7,\qquad
 \lambda _2\equiv\lambda _3\pmod3.                 \tag{58.3}
\]

These three congruences exclude every non-hyperelliptic spectrum in
Theorem 56.1.  Consequently all four full-span, degree-nine coarsening
profiles of file 47 are normalized pullbacks of the hyperelliptic double
cover of \(X\).

The exact finite computations used below are reproduced by
[`58_X_CENTRAL_GLUE_CERTIFICATE.sage`](58_X_CENTRAL_GLUE_CERTIFICATE.sage).

## 1. A two-factor lattice lemma

We first record the elementary local fact which turns a nonsplit reduction
of Frobenius into a congruence between scalar coordinates.

### Lemma 58.1 (cyclic collision forces scalar congruence)

Let \(R\) be a complete discrete valuation ring with uniformizer \(\ell\),
fraction field \(L\), and residue field \(k_0\).  Let \(V_1,V_2\) be
two-dimensional \(L\)-spaces carrying an operator \(F\).  Suppose:

1. the characteristic polynomials \(P_1,P_2\in R[T]\) of \(F\) on the
   two summands reduce to the same separable irreducible quadratic
   \(q\in k_0[T]\);
2. after the unramified quadratic extension which splits \(q\),
   corresponding roots of \(P_1,P_2\) differ by an element of valuation
   exactly \(a\geq1\);
3. \(M\subset V_1\oplus V_2\) is an \(F\)-stable lattice and
   \(M/\ell M\), as a \(k_0[F]\)-module, is cyclic with characteristic
   polynomial \(q^2\).

If an \(R\)-linear endomorphism of \(M\) acts on \(V_i\) as the scalar
\(b_i\in R\), then

\[
                         b_1\equiv b_2\pmod{\ell^a}. \tag{58.4}
\]

#### Proof

Pass to the unramified quadratic extension of \(R\).  The two roots of
\(q\) are distinct, so Hensel idempotents split \(M\) into two conjugate
rank-two lattices.  Consider the summand belonging to one root.  After
rescaling bases on its two rational eigenlines, every lattice projecting
onto both coordinate lattices has the form

\[
 R'e_1+R'\ell^{-r}(e_1+u e_2),\qquad u\in R'^\times,quad 0\leq r\leq a.
\tag{58.5}
\]

The bound \(r\leq a\) is exactly the condition that this lattice be stable
under \(F\).  In the displayed basis, the off-diagonal entry of \(F\) is
a unit times

\[
                 \frac{\alpha _1-\alpha _2}{\ell^r}, \tag{58.6}
\]

where \(\alpha_i\) are the corresponding roots.  Thus reduction modulo
\(\ell\) is nonsplit precisely when \(r=a\).  Assumption 3 says that it
is nonsplit: over the residue splitting field, the cyclic module
\(k_0[T]/(q^2)\) gives one Jordan block at each root.  Hence \(r=a\).

The scalar pair \((b_1,b_2)\) preserves (58.5) only if

\[
                    (b_1-b_2)/\ell^r\in R'.
\]

Since the extension is unramified and \(r=a\), this is (58.4). \(\square\)

## 2. The three collisions in the Tate lattice of `J(X)`

Write

\[
 P_i(T)=T^2-t_iT+5.
\tag{58.7}
\]

The trace differences are

\[
 t_1-t_2=4,qquad t_1-t_3=7,qquad t_2-t_3=3.        \tag{58.8}
\]

Modulo respectively \(2,7,3\), the colliding quadratic factors are

\[
\begin{array}{c|c|c|c}
\ell&\text{pair}&q(T)&a=v_\ell(t_i-t_j)\\ \hline
2&(1,2)&T^2+T+1&2\\
7&(1,3)&T^2+4T+5&1\\
3&(2,3)&T^2+T+2&1.
\end{array}                                           \tag{58.9}
\]

All three displayed quadratics are irreducible and separable.  For a
simple root, the implicit derivative of a root of
\(T^2-tT+5\) with respect to \(t\) is a unit.  Therefore the corresponding
lifted roots differ with exactly the valuations in the last column of
(58.9), as required in Lemma 58.1.

### Proposition 58.2 (the integral scalar order)

Let \(s\in\operatorname{End}_k(J(X))\) be Rosati-fixed, and write its
coordinates in (58.1) as

\[
                         s=(\lambda _1,\lambda _2,\lambda _3).
\]

If the coordinates are rational, then they are integers and satisfy
(58.3).

#### Proof

Rational coordinates of an integral endomorphism are rational algebraic
integers, hence integers.  It remains to verify the cyclic-reduction
hypothesis in Lemma 58.1 for the three rows of (58.9).

There is no hidden field-of-definition assumption here.  Equation (58.1)
is a product of commutative fields, so every *geometric* endomorphism of
\(J(X)\) commutes with the \(5\)-Frobenius \(F\) of the displayed
\(\mathbf F _5\)-model.  Consequently it preserves every \(F\)-primary
summand of every Tate lattice.  We may therefore use this one fixed
Frobenius to test the integral lattice even if the correspondence which
produced \(s\) was initially written over a finite extension.  Enlarging
that field changes neither the geometric Tate lattice nor the congruences
in its multiplier ring.

The exact Sylow subgroup calculations are

\[
\begin{array}{c|c|c}
(n,\ell)&J(X)(\mathbf F_{5^n})[\ell^\infty]
 &\dim_{\mathbf F_\ell}J(X)(\mathbf F_{5^n})[\ell]\\ \hline
(3,2)&C_2\times C_{16}\times C_{16}&3\\
(8,3)&C_3\times C_9\times C_9\times C_9&4\\
(48,7)&C_7\times C_7\times C_{49}\times C_{49}&4.
\end{array}                                           \tag{58.10}
\]

These are finite, exact Jacobian computations.  The group order is first
computed independently from

\[
 \#J(X)(\mathbf F_{5^n})
   =\left|\operatorname{Res}\bigl(P_X(T),T^n-1\bigr)\right|. \tag{58.11}
\]

The certificate then generates an \(\ell\)-primary subgroup of that full
order using exact Mumford-divisor arithmetic.  Thus randomness is used
only to find generators, not to certify either the order or the invariant
factors.

For \(\ell=2\), the roots of \(q=T^2+T+1\) have order three.  The
\(q^2\)-primary four-dimensional module contributes either two fixed
dimensions (if cyclic) or four (if split).  Since the *entire* fixed
space has dimension only three by the first row of (58.10), the latter is
impossible.  It is consequently the cyclic module
\(\mathbf F_2[T]/(q^2)\), rather than the split module
\(\mathbf F_2[T]/(q)\oplus\mathbf F_2[T]/(q)\).

For \(\ell=3\), the roots of \(q=T^2+T+2\) have order eight.  The
noncolliding first factor splits with roots \(1,-1\) modulo three and
contributes two fixed dimensions to \(F^8\).  The second row of (58.10)
leaves only two fixed dimensions for the four-dimensional \(q^2\)-primary
module, so it too is cyclic.

For \(\ell=7\), the roots of \(q=T^2+4T+5\) have order forty-eight.  The
noncolliding second factor has roots \(1,5\) modulo seven, and hence
contributes two fixed dimensions to \(F^{48}\).  The last row of (58.10)
again leaves two, rather than four, dimensions for the colliding pair.
That pair is cyclic as well.

Apply Lemma 58.1 to the three rows of (58.9).  It gives respectively

\[
 \lambda _1\equiv\lambda _2\pmod4,\qquad
 \lambda _1\equiv\lambda _3\pmod7,\qquad
 \lambda _2\equiv\lambda _3\pmod3,
\]

which proves the proposition. \(\square\)

### Corollary 58.3 (exact elliptic quotient degrees)

In trace order \((3,-1,-4)\), the least degrees of nonconstant maps from
\(X\) to elliptic curves in the three geometric isogeny classes are

\[
                              28,\qquad12,\qquad21.   \tag{58.12}
\]

More precisely, if \(e_i\in\operatorname{End}^0(J(X))\) denotes the
rational projector onto the \(i\)-th factor, then the primitive integral
norm endomorphisms are

\[
                         28e_1,\qquad12e_2,\qquad21e_3. \tag{58.13}
\]

#### Proof

Let \(F\) and \(V\) be Frobenius and Verschiebung and put
\(S=F+V\).  On the three factors, \(S\) acts respectively as
\(3,-1,-4\).  Lagrange interpolation therefore gives the integral
endomorphisms

\[
\begin{aligned}
 (S+1)(S+4)&=28e_1,\\
 -(S-3)(S+4)&=12e_2,\\
 (S-3)(S+1)&=21e_3.                                  \tag{58.14}
\end{aligned}
\]

Conversely, if \(ne_i\) is integral, Proposition 58.2 says that \(n\)
is divisible by both \(4,7\) for \(i=1\), by both \(4,3\) for \(i=2\),
and by both \(7,3\) for \(i=3\).  Thus the three endomorphisms in
(58.14) are the primitive integral multiples of the projectors.

For completeness, the standard norm construction gives the asserted
maps directly.  The connected image \(E_i=\operatorname{im}(d_i e_i)\)
is an elliptic subvariety of the principally polarized Jacobian, where
\((d_1,d_2,d_3)=(28,12,21)\).  The endomorphism \(d_i e_i\) is symmetric,
has square \(d_i(d_i e_i)\), and is primitive.  Hence it is the norm
endomorphism of \(E_i\); the restriction of the principal polarization to
\(E_i\) is \([d_i]\).  Composing the Abel--Jacobi map of \(X\) with the
polarized projection to \(E_i\) gives a map

\[
                              f_i:X\longrightarrow E_i
\]

of degree \(d_i\), and \(f_i^*f_{i*}=d_i e_i\).

If \(f:X\to E\) is any map to an elliptic curve in the \(i\)-th isogeny
class, then \(f^*f_*\) has coordinates \(\deg(f)e_i\).  Proposition 58.2
forces \(d_i\mid\deg(f)\).  Thus the displayed degrees are minimal.
\(\square\)

## 3. Elimination of the non-hyperelliptic genus-two spectra

Retain the degree-nine full-span coarsening

\[
 q:C\longrightarrow B,qquad c:C\longrightarrow X,qquad g(B)=2
\]

from files 47 and 56, and let \(\delta\) be the involution of \(C/B\).

### Theorem 58.4 (the genus-two coarsening is hyperelliptic)

One has

\[
                         c\delta=\iota_Xc.            \tag{58.15}
\]

Consequently there is a degree-nine map

\[
                         B\longrightarrow\mathbf P^1_x
\]

such that \(C\) is the normalization of
\(B\times_{\mathbf P^1_x}X\), with the ramification profiles stated in
alternative 1 of Theorem 56.1.

#### Proof

Suppose (58.15) were false.  Theorem 56.1 applies to the integral
Rosati-fixed endomorphism

\[
                       u=c_*\delta^*c^*.
\]

Write its three coordinates in trace order \((3,-1,-4)\) as
\((\lambda _1,\lambda _2,\lambda _3)\).  Proposition 58.2 imposes all
three congruences (58.3).

The finite list (56.8) is now empty.  Here is an exhaustive check without
relying on a search.  When \(e=1\), write the two coordinates other than
the unique \(-9\) as \(a,b\).  Theorem 56.1 gives
\(a+b\in\{0,1,2\}\) and \(a^2+b^2\leq18\), so
\(-3\leq a,b\leq3\).  If the first coordinate is \(-9\), the congruences
modulo four and seven force the other two to be \(3,-2\).  If the second
coordinate is \(-9\), they force the two live coordinates to be equal to
one another and congruent to \(3\) modulo four; neither possible value has
sum \(0,1\), or \(2\).  If the third coordinate is \(-9\), they force the
first two coordinates to be \(-2,2\).  Hence the first two congruences
leave precisely

\[
                    (-9,3,-2),\qquad(-2,2,-9).        \tag{58.16}
\]

Neither satisfies \(\lambda _2\equiv\lambda _3\pmod3\).  This check is
also reproduced at the end of the certificate.  When \(e=3\), the two
live coordinates are \((a,-a)\) with \(a\in\{-3,0,3\}\).  The same three
positions for \(-9\) show immediately that no ordered triple satisfies
even the congruences modulo four and seven.

Thus alternative 2 of Theorem 56.1 is impossible.  Alternative 1 is
exactly (58.15) and gives all the asserted consequences. \(\square\)

### Corollary 58.5

In every one of the four numerical rows (47.15), the coefficient
involution on \(C\) lies over the hyperelliptic involution of \(X\).

#### Proof

The two genus-one rows are Theorem 53.3.  The two genus-two rows are
Theorem 58.4. \(\square\)

## 4. What this does and does not finish

The arbitrary involution left by file 47 has now disappeared: in the
entire \(M=9\), full-span branch, both hyperelliptic double covers descend
through the same order-two symmetry on the common curve.  The remaining
question is the compatibility of the two resulting degree-nine maps and
the simultaneous \(C_{14}\)- or \(D_{14}\)-closure.  This note does not
yet exclude those hyperelliptic pullback configurations.
