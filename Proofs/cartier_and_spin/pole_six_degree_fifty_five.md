# Extending the trace-moment certificate across triple poles

24 September 2026. This is a local continuation of the completed
[squarefree proof](squarefree_common_pole_exclusion.md), not a new
enumeration of its 787176 endpoint configurations. Those configurations
and all inconsistency witnesses have passed their independent replay.
Keep the two actual maps and their quadratic quotient throughout.

The [minimal-denominator proof](new_line_degree_six_genus_bound.md)
shows that every finite common pole has order1 or3. Order3 occurs
only at a ramified quadratic fiber. The squarefree proof excludes
quadratic ramification at a common pole of order1 by a calculation
local to that pole, so it still applies when other poles have order3.

## The trace contribution at a triple pole

Let s(Q)=xi in mu29, and set u=P9=[22]. Since 3 is invertible, choose
a formal parameter t such that x1=t^-3. Write
\[
s=\xi h(t),\quad x_2=t^{-3}V(t),\quad
h(0)=1,\quad V(0)=\lambda=\varepsilon\xi^4.
\]
Normalize V=lambda(1+sum v_j t^j). The normalized quartic and
differential identities are
\[
h^{13}\frac{t^{12}}{A_4}A(V/t^3)
=\lambda^4\frac{t^{12}}{A_4}A(t^{-3}),
\]
\[
\lambda^{17}(V-(t/3)V')^3[t^{30}P(t^{-3})]^2
=h^{48}[t^{30}P(V/t^3)]^2.
\]
At orders1,2,3, the matrix for the new normalized coefficients
(h_j,v_j) is
\[
\begin{pmatrix}3&4\\-3&3-j\end{pmatrix}.
\]
At order1 it is invertible and the inhomogeneous terms vanish,
so h1=v1=0. At order2 it has rank one, allowing the required
ramification index2; in particular v2=3h2 and h2 is nonzero.
At order3 there are no products of lower nonzero terms. The
differential equation gives
\[
-3h_3+2u(1-\lambda^{-1})=0,
\qquad h_3=4u(1-\lambda^{-1}).
\]
This is the same coefficient that appeared at order1 for a simple pole.

The trace of a function with pole order3 on a tame quadratic local
extension has pole order at most1 downstairs. By compatibility of
residues with field trace,
\[
\operatorname{Res}_Q(x_1\,ds)=3\xi h_3,
\qquad
\operatorname{Res}_Q(x_2\,ds)=3\lambda\xi h_3.
\]
For the second equality the only additional potential residue is
2xi h2 times the coefficient of t in V, which is zero. This also
works when lambda=1: both trace residues vanish, without asserting
that the original triple pole disappears.

Consequently the average quadratic traces have EXACTLY the same
formula as in the squarefree proof, now with weights
\[
w_\xi\in\{0,1,2,3\},\qquad S_j=\sum w_\xi\xi^j.
\]
Weight3 records the single ramified triple pole. The factor3 in
the residue is essential. With chi=2u, the principal parts are
\[
R_1=\chi\sum\frac{w_\xi(\xi-\varepsilon^{-1}\xi^{-3})}{s-\xi},
\quad
R_2=\chi\sum\frac{w_\xi(\varepsilon\xi^5-\xi)}{s-\xi}.
\]
No pole of order2 remains in either trace. Their endpoint polynomial
parts and the 116 possible endpoint data are unchanged. Thus the
same necessary four-moment equation, with the same coefficients and
the same 787176 cases, applies. The earlier computation exhausted
its solutions without assuming any value bound on w; the bound
{0,1,2} entered only at its FINAL Fourier comparison.

## Reusing the exhaustive moment calculation

That calculation left 42 moment vectors. Their Fourier base rows
have five distinct residues in35 cases and four in7 cases. The only
undetermined Fourier coefficient adds a common F5 scalar to the row.
A five-residue row cannot take values in {0,1,2,3}. A four-residue
row has a UNIQUE shift missing4 and therefore determines its ordinary
integer weights exactly, with no lifting ambiguity modulo five.

The retained seven rows each contain respectively4,8,10,7 entries
of weights0,1,2,3. Thus the total finite pole order is
8+20+21=49. The two endpoint poles contribute6, proving n=55.
There are25 used fibers and seven denominator roots of multiplicity2,
so the minimal denominator has degree32. Its seven ramified poles
force at least eight total quadratic branch points, hence genus>=3.
The already proved bound g<=9+(number of double roots) gives g<=16.

The zero endpoint pair is (0,58). The infinity pair is
(29+h,87+h), with h in {2,3,11,14,17,19,21}. Coefficient Frobenius
25^4 fixes the quartic root alpha and sends zeta to zeta^24;
it cycles these seven h values and permutes the weight rows
accordingly. Thus they are one arithmetic orbit. The endpoint
trace coefficient c+chi S_-2 is nonzero by the proved endpoint
independence lemma, and
\[
\varepsilon=(b+\chi S_{-6})/(c+\chi S_{-2}).
\]
The finite check verifies BOTH original trace equations and the
Frobenius conjugacy of these scalars, rather than only their
cross-multiplied necessary equation.

## Verification and limits

Run the source
[pole_six_double_weights.py](../../scripts/arithmetic/pole_six_double_weights.py)
with --archive pointing to the preserved squarefree results and
--output outside this workspace. It rechecks all30 exceptional
systems, exhausts all five shifts of all42 rows, and verifies the
seven patterns and their conjugacy. The [data and log](../../../litt3-computation-data/structural_triplet_replies_20260924/)
are under local/double_weights and logs/double_weights.log.
All checks passed. The triple-pole series and residue argument above
is a human-readable proof; it is not represented as a formal proof
assistant certificate.

The necessary weight pattern is not an actual quadratic model,
an etale correspondence, or a solution of the original unmarked
problem. The degree55 branch still requires the full two identities
and ramification profile. Recognition through degree8 follows by
the exact joint-minimal reduction as stated in the theorem.
