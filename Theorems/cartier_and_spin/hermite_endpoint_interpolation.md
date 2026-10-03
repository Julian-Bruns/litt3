# Sparse interpolation and two-endpoint rigidity

Version 1, 30 September 2026. These algebraic tools isolate the reusable
content of the former pole-twelve V4 interpolation chain. They do not
assume, construct or decide a common cover. Every application must prove
the stated interpolation, local-jet and degree hypotheses for its own
actual functions; no pole-twenty-four application is asserted.

## Complementary Fourier spaces

Let k contain all Nth roots of unity, with char(k) not dividing N,
and let Omega=mu_N. For I subset Z/N, let C_I be the evaluation code
of span_k{t^i:i in I}, using representatives 0<=i<N. Its orthogonal
code for the ordinary pairing on k^N is C_J, where
\[
J=(\mathbf Z/N)\setminus(-I).
\]
If every maximal minor of a generator matrix for C_J is nonzero,
the same holds for C_I. Hence a nonzero polynomial supported on I
has at most |I|-1 zeros in Omega. This holds over arbitrary coefficient
extensions of k, not just for coefficients in a finite field.

The preserved exact Fourier certificate in the proof implies, in
characteristic five, that every nonzero word in
\[
S_r=\langle1,t,\ldots,t^{15+r},t^{22},\ldots,t^{22+r}\rangle,
\qquad 0\le r\le6,
\]
has at most 16+2r distinct zeros in mu29.

## Cross differences retain denominator boundaries

Let a,d>=0. Compare pairs (f,T),(hat f,hat T) with T,hat T nonzero,
deg f,deg hat f<=a+d and deg T,deg hat T<=d. Put
F=P T+f and hat F=P hat T+hat f for a fixed polynomial P.
Suppose both pairs satisfy F=hat F=0 on a finite set C, and
F(x)=b_x T(x), hat F(x)=b_x hat T(x) on a disjoint finite set U.
Both sets avoid zero. Define
\[
H=f\widehat T-\widehat fT=F\widehat T-\widehat FT.
\]
Assume H vanishes to order ell_0 at zero, and to order ell_inf at
infinity when measured as a section of O(a+2d), namely using
t^-(a+2d)H in the parameter 1/t. Then
\[
|C|+|U|+\ell_0+\ell_\infty>a+2d
\quad\Longrightarrow\quad F/T=\widehat F/\widehat T.
\]
Finite-node conditions require no division by T. At an endpoint with
unit denominators, equality of quotient jets supplies the required
cross-difference order. At a zero denominator, that order must instead
be established from the actual numerator/denominator vanishings.

## Coupled differences and absolute lifting

Over any field L of characteristic different from two, if a set A
subset L^3 satisfies q(r-s)=0 for every pair r,s in A, where
q(x)=x_1x_2+x_1x_3+x_2x_3, then A lies in an affine L-line or is a
singleton. This is a function-field statement when L=k(t), not a
one-dimensional parameter space over k. An application must establish
the pairwise identity, including every denominator boundary.

Suppose two polynomial pairs with the preceding degree bounds have
the same quotient f/T and the same absolute jets of orders ell_0,ell_inf
at the two ends, measured as sections of O(a+d) and O(d). Fix the same
normalized reduced section pair in O(a+r) and O(r), with no common
zero including infinity, when comparing their common-factor lifts.
If the lifts differ, their reduced denominator degree satisfies
\[
r\le d-\ell_0-\ell_\infty.
\]
At every finite zero of F where T is nonzero, the reduced sparse word
P T_0+f_0 also vanishes. Thus any proved zero bound for that reduced
word excludes different lifts when the retained zero count exceeds it.
This conclusion requires the entire frames and absolute jets to be
fixed; quotient jets alone do not determine common polynomial factors.

[Proof and retained Fourier input](../../Proofs/cartier_and_spin/hermite_endpoint_interpolation.md).
