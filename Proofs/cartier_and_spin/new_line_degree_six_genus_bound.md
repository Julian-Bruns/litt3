# Extending the boundary obstruction to higher covering degrees

24 September 2026. This is a local continuation of the completed
[two-end model exclusion](degree_six_tensor_exclusion.md), using its
already verified constant- and linear-ratio certificates. No new
enumeration or assumption about a simultaneous Galois closure is used.

## The actual common-pole denominator

Write \(\rho:T\to S\) for the simultaneous cyclic degree-three quotient.
The comparison s belongs to k(S) and has degree two there. On T it
has simple zeros and poles, so both \(\rho\) and \(s:S\to\mathbf P^1\)
are unramified over zero and infinity. Thus
\(S:w^2=B(s)\) has a monic squarefree even-degree model, with
\(\deg B=2g+2\) and \(B(0)\ne0\).

Let \(D_i=h_i^*O\), and \(E=\min(D_1,D_2)\). Their coefficients are
one because both h_i are etale. The normal form gives
\[
\operatorname{div}(s)=D_2-D_1,\qquad
\deg E=n-6.
\]
At every point of E it also gives
\(s^{29}=\kappa^{18}\) and \(\operatorname{ord}(s-s(P))\ge2\).

The finite common poles of the two functions x_i on S occur at the
same points. At such a point Q, let e be the ramification index of
\(\rho\). Since x has pole order three at O on X, the common pole
order of x_1,x_2 at Q is \(m_Q=3/e\), hence one or three. The number
of points of E above Q is also \(3/e=m_Q\). Consequently
\[
\sum_Q m_Q=n-6.
\]
Let \(\epsilon_Q\in\{1,2\}\) be the ramification index of the
degree-two s-map. If \(m_Q=3\), then e=1. The just stated order bound
forces \(\epsilon_Q=2\). If \(m_Q=1\), either index is allowed.

For each finite common pole value a, set
\[
k_a=\max_{Q:\,s(Q)=a}\left\lceil\frac{m_Q}{\epsilon_Q}\right\rceil,
\qquad D(s)=\prod_a(s-a)^{k_a}.
\]
This is exactly the minimal polynomial denominator which clears
both functions away from zero and infinity. Each k_a is one or two.
If it is two, the unique point above a is ramified for the s-map,
has common pole order three, and contributes three to \(\deg E\).
If it is one, the contribution to \(\deg E\) is at least one
(and can be two if both unramified points are common poles).

There are at most29 values a. If t is their number and u the number
with exponent two, then
\[
r=\deg D=t+u,\qquad n-6\ge t+2u=2r-t.
\]
Also \(r\le\sum_Qm_Q=n-6\), \(t\le29\), and \(r\le2t\le58\).
These prove all the asserted upper bounds for r. In particular the
argument retains ramified common poles and common poles on both
quadratic sheets; it does not count a polynomial denominator as an
arbitrary chosen divisor.

## Pole spaces and the improved genus bound

Multiplication by D clears all finite common poles of x_1. Its only
remaining poles are at the two infinity points, each of order at
most r+3. Similarly \(s^3Dx_2\) is regular away from infinity and
has the same bound there. The affine algebra is
\(k[s]\oplus k[s]w\). Projection to the two eigenspaces of the
quadratic involution therefore gives
\[
Dx_1=a+bw,\qquad s^3Dx_2=c+dw,
\]
with the degree bounds in the statement. Neither b nor d is zero:
each x_i together with s generates k(S), by the established normal
form. Hence \(m=r+2-g\ge0\).

Suppose \(g>r\), so \(m\le1\). The endpoint-nonvanishing argument
in the two-end proof still applies. D is a unit at zero; the difference
of the two x_1 expansions is \(2bw/D\). If the two leading
\(s^3x_2\) values were equal, the verified boundary jets would agree
through order two, forcing \(s^3\mid b\), impossible for deg b<=1.
At infinity, use the reversed polynomials
\[
r^m d(1/r),\qquad r^{\deg D}D(1/r),
\]
where the latter is a unit at zero because D is monic. The same
argument shows that the leading infinity difference for x_1 is
nonzero and that b has degree exactly m.

Thus the four nonzero-endpoint boundary choices are exactly among
those in the completed certificate. The ratio of the two branch
differences is
\[
\frac{\Delta(s^3x_2)}{\Delta x_1}=\frac d b.
\]
The common D and w cancel. When m=0 the ratio is constant and is
excluded by the complete constant-ratio certificate. When m=1 it
is a ratio of linear polynomials, with denominator of degree one
and numerator nonzero at zero, and is excluded by the complete
Mobius certificate, including repeated root choices. Those
certificates used only the two endpoint jets and the rational
degree of this ratio; they did not use D=1 elsewhere.

This contradicts g>r. Therefore g<=r, completing the proof.
The genus-zero quadratic-ratio certificate is NOT extended here:
with D nonconstant, w/D is no longer the square root of a monic
quadratic polynomial. Its global jet identities cannot simply be
reused. The remaining higher-degree models are still open.
