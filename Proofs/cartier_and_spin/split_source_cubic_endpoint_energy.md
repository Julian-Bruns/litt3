# The five-root cluster determines the entire double pole

30 September2026.
[Statement](../../Theorems/cartier_and_spin/split_source_cubic_endpoint_energy.md).
Version2. This argument is formal and uses no parameter enumeration.
The endpoint part is now stated in arbitrary degree; its degree-ten
trace-zero affine covariance is retained as a separate specialization.

## The small cluster has exactly five roots

Write the first coefficients of H as e+cW+bW^2+gamma W^3+....
Suppose first that e(0)=0. The reduction of F is then divisible by
W^6, so at least six split integral roots have positive valuation.
Its constant coefficient would consequently have valuation at least
six, since the leading coefficient is a unit. But
\[
F(0)=qe+\tau
\]
has valuation exactly three, a contradiction. Therefore e0=e(0) is
nonzero. Exactly five roots reduce to zero and all other roots are
units. The first five have the form
\[
w_i=r a_i+r^2 b_i+O(r^3),\qquad 1\le i\le5.
\]
The valuation of their product forces the coefficients of r^3 and
r^4 in F(0) to vanish. In particular
\[
e_0q_3+\tau_3=0.
\]

Let P be the monic degree-five factor with these five roots and put
U=F/P. Thus U belongs to R[W], U(0,0)=e0, and U is a unit as a formal
series in W,r. The split roots give ord_r([W^j]P)>=5-j. It follows
that the coefficient of W in F has order at least four. This
coefficient is qc, so c(0)=0.

Write c=c1 r+O(r^2), and replace W by rV. The polynomial
r^{-5}F(rV,r) is integral, since P(rV,r) is divisible by r^5. Its
constant term in r has the form
\[
e_0V^5+q_3b(0)V^2+q_3c_1V+h_5.
\]
There are no V^4 or V^3 terms. Its coefficient of r has V^3
coefficient q3 gamma(0) and V^4 coefficient zero.

Since bar U(W)=bar H(W), its coefficient of W is zero. Hence
U(rV,r), modulo r^2,
is independent of V and has constant term e0. Dividing by U shows
that the monic polynomial
\[
r^{-5}P(rV,r)=\prod_{i=1}^5(V-a_i-rb_i-\cdots)
\]
has zero V^4,V^3 coefficients modulo r, and its V^3 coefficient
modulo r^2 is r q3 gamma(0)/e0. Newton's second identity, which
does not divide by five, therefore gives
\[
\sum_i a_i^2=0,\qquad
\sum_i a_i b_i=-q_3\gamma(0)/e_0.
\]
These identities also hold when some or all of the a_i coincide.

## Subtracting the double pole

The unit roots contribute regular terms to the source energy,
because phi(w) is then a unit. At the small roots,
\[
\phi(w_i)=q_3r^3+q_4r^4+O(r^5),\quad
dw_i=(a_i+2b_i r+O(r^2))\,dr.
\]
The possible r^{-3} term in the sum vanishes by sum a_i^2=0.
The coefficient of r^{-2}(dr)^2 is
\[
\frac4{q_3}\sum_i a_i b_i
=-4\gamma(0)/e_0=\gamma(0)/e_0.
\]
On the other hand the r^{-2} coefficient of
gamma dq d tau/tau^2 is
\[
9\gamma(0)q_3/\tau_3
=-9\gamma(0)/e_0=\gamma(0)/e_0.
\]
Their difference has at most a simple pole. The remaining term
dq d gamma/tau also has at most a simple pole, since dq has order
two and d gamma is regular. This proves the claimed local bound.

If gamma is instead read from H mod phi, its difference from the
W^3 coefficient of H is divisible by q. Its order is at least three
and the order of its differential is at least two. The resulting
change in both correction terms is regular, so the pole bound is
unchanged. Terms of degree four or higher in H do not enter either
of the two coefficient jets used above.

## Affine covariance in the degree-ten trace-zero specialization

The first two terms already transform by a^{-3}, by the
[affine source-energy theorem](affine_covariant_source_quadratic_differential.md).
For W'=aW+d, the transformed coefficients satisfy
\[
q'=a^5q-d^5,\quad \gamma'=a^2\gamma,
\quad \tau'=a^{10}\tau.
\]
Characteristic five gives dq'=a^5dq and d tau'=a^{10}d tau.
Consequently gamma' dq' d tau'/(tau')^2 is a^{-3} times the
original third term. This proves the full covariance without an
inverse of gamma or any assumption that it is nonzero.

For the fixed degree-ten source families, the ordinary t-endpoints
have q-q(0) and tau of exact order three. Whenever the chosen regular
source frame is integral and its leading coefficient is a unit, this
lemma replaces separate primitive/content endpoint treatments for
the corrected energy. A marked leading-coefficient zero, infinity,
and the global section calculation still need their own analysis.
