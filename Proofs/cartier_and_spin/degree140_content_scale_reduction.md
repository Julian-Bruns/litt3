# Proof: local parity splits the scale condition completely

[Statement](../../Theorems/cartier_and_spin/degree140_content_scale_reduction.md).
Use the scaled unbarred source near an endpoint, with tau=t(x):
\[
f_{\mu}=(W^5+\tau^3M)
(2aW^3+3bW^2+cW+d)+\mu(W^5+\tau^3M)^2+q^3\tau^3z_c^{10}.
\]
It has critical quadratic aW^2+bW+c. Write
\[
\mathscr D=\operatorname{Res}_{(10,2)}(f_\mu,aW^2+bW+c)/\tau^5.
\]
Its norm differs
from the actual residual by a factor invertible at the endpoint;
that factor cannot change the first nonzero tau order.

## The selected sheet: two explicit linear factors

At the selected positive-content point B=b(p) is nonzero. The critical
quadratic has a unique small root W=omega*tau+omega2*tau^2+...,
with omega=-c1/B and
\[
\omega_2=-(b_1\omega+A\omega^2+c_2)/B.
\]
On that root the cubic becomes aW^3+2bW^2+d. Since
M d+q^3z_c^10=tau^2 ell, its fifth coefficient is
ell0+D omega^5+2mB omega^2. This vanishes exactly on the content
incidence. The next coefficient is
\[
[\tau^6]f_\mu(W(\tau))=m^2\mu+\kappa.
\]
Expanding first with omega2 free gives
ell1+d1 omega^5+2(m1B+mb1)omega^2+4mB omega omega2+mA omega^3.
Substitution gives the displayed kappa, with coefficients reduced
in characteristic five. The
[symbolic verifier](../../scripts/arithmetic/endpoint_content_scale_identity.py)
checks both universal coefficients and the large-root factor below
exactly, with independent indeterminates, not sampled local data.

Put L_p(mu)=B^5mu-A^3B^3-A^5D. If A is nonzero, the other critical
root at tau=0 is -B/A. Its resultant contribution is B^5 L_p:
indeed A^10 f_mu(-B/A)=B^5 L_p at tau=0. Consequently, on the
content incidence,
\[
[\tau]\mathscr D_p(\mu)
=B^5 L_p(\mu)(m^2\mu+\kappa).                 \tag{1}
\]
The calculation also holds at A=0. The large root is then projective
infinity. More algebraically, localize the universal jet ring at B,m
and eliminate ell0 by the linear content equation. This is a domain,
and(1) has only powers of B as denominators. The identity established
on A nonzero therefore holds on this entire ring, including A=0.
In particular the
coefficient of mu^2 in(1) is B^10 m^2, a unit. No extra quadratic
extension is required for the scales on this selected sheet.

## Norm parity brings in the other two large roots

The completed two-sheet exclusion says that each other sheet p_j has
content zero. The universal fifth resultant coefficient gives
\[
\mathscr D_{p_j}(\mu)=J_{p_j}L_{p_j}(\mu)
\quad\text{at }\tau=0,
\]
where J is its small-root content numerator, nonzero on these two
sheets at a possible square. This identity is polynomial and still
holds if B_j=0. In that event the previously excluded simultaneous
a_j=b_j=0 incidence and the unit D_j imply
L_pj=-A_j^5D_j is a nonzero constant; it has no scale root.

All three x-sheets are unramified above r, so the norm is their product
in k[[tau]][mu]. Exactly one factor has fixed content tau. Its first
coefficient is, up to a nonzero ratio scalar,
\[
(m^2\mu+\kappa)\prod_{j=0}^2L_{p_j}(\mu).
\tag{2}
\]
Because r is a fixed simple factor, a square specialization must make
this coefficient zero: its multiplicity at r has to be at least two.
The factors in(2) give precisely the four rational scales in the
statement. The nonzero scalar factors B^5,J_p1,J_p2 and the normalization
unit do not affect that conclusion. Repeated factors or coincidences
of scales are retained.

This uses local even multiplicity only as a necessary consequence of
the FULL square condition. It does not replace that condition with
discriminant vanishing or assert a square at any of the rational scales.

The coefficient check was executed with SymPy1.14.0 using
`/var/tmp/sage-10.9-current/venv/bin/python -B
scripts/arithmetic/endpoint_content_scale_identity.py`; all three
identities passed. Its [concise output](../../../litt3-computation-data/two_sheet_quintic_replies_20260927/endpoint_content_scale_identity.log)
is retained. It checks these algebraic identities only; the norm-parity
and complete-branch coverage arguments are the proof above.
