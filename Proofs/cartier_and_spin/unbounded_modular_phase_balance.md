# Two regular-form traces and five small determinants

Use the actual same-source [normal form](new_line_comparison_normal_form.md):
\[
A(v)=\epsilon^4t^{-13}A(u),\qquad
\theta_2=\eta t^{16}\theta_1,\qquad \eta^3=\epsilon^{-17}.
\]
No simultaneous quotient or Galois closure is assumed.

## The two-jets follow directly from the normal form

Use B=F25=F5(beta), beta2=beta+3, with [a+5b]=a+b beta, and
\[
P=(11,22,18,5,19,20,15,16,9,22,1),\quad A=(1,21,14,22,13).
\]
Let E=B(alpha)=F_(5^8), with
alpha4+[7]alpha3+[6]alpha2+[2]alpha+[5]=0, and alpha_i=alpha^(25^i).
Let K=B(xi)=F_(5^14), xi of order29, and zeta=[11].
The degrees4 and7 make E and K linearly disjoint over B.

At a simple zero of t above u=alpha write
u=alpha+a t+b t2+..., v=epsilon(B0 t^-3+C0 t^-2+...).
Comparison of the first two coefficients of A, then the leading
and next coefficients of the cubed differential identity, gives
\[
B_0^{29}=\frac{3A'(\alpha)^3P(\alpha)^2}{[13]^3},\qquad
a=\frac{[13]B_0^4}{A'(\alpha)},\qquad
\frac{C_0}{B_0}
=a\left(\frac{P'(\alpha)}{P(\alpha)}
+\frac{A''(\alpha)}{4A'(\alpha)}\right),
\]
\[
b=a^2\left(\frac{4P'(\alpha)}{P(\alpha)}
+\frac{A''(\alpha)}{2A'(\alpha)}\right).
\]
All denominators are nonzero at the four roots of A. Lower terms
of A(v) and P(v) start in relative order three, so none enters
these two-jets. The comparison scalar cancels.

Since29 is coprime to5^8-1, choose the canonical B_i in E by the
inverse29 power. A phase xi^j gives the germ
u=alpha_i+a_i xi^(4j)t+b_i xi^(8j)t2+O(t3).
This holds on all three cubic sheets; the resonant free coefficient
occurs later. Endpoint interchange gives the same normalization.

Choose rho0^3=P(alpha0) and rho_i=rho0^(25^i). Then
r_i=rho_i/rho0=P(alpha0)^((25^i-1)/3) lies in E. No assumption
places rho0 itself in E or K.

## Field separation gives modular balance without an anchor

For the actual integer counts m_(i,s,j), put
S_(i,s)(r)=sum_j m_(i,s,j)xi^(rj) and
T_(i,k)(r)=sum_s zeta^(-ks)S_(i,s)(r), k=1,2.
These sums lie in K regardless of their cardinalities.

The forms dx/y and dx/y2 are regular. Their traces through the
separating map t:T->P1 are regular and therefore zero. Regularity
of differential trace follows from the inverse different even at
wild ramification. At the simple t-zero branches, trace is the
sum of the actual germs. Its first two coefficients, after removing
rho0^-k, give
\[
\sum_i u_{ki}T_{i,k}(4)=0,\qquad
\sum_i v_{ki}T_{i,k}(8)=0,
\]
\[
u_{ki}=a_i r_i^{-k},\qquad
v_{ki}=a_i^2r_i^{-k}
\left(2b_i/a_i^2-\frac{kP'(\alpha_i)}{3P(\alpha_i)}\right).
\]
Write each four-column array in the E/B basis1,alpha,alpha2,alpha3.
Their exact determinants are
\[
\det U_1=[23],\quad\det V_1=[15],\quad
\det U_2=[16],\quad\det V_2=[4].
\]
Thus all four arrays are invertible over B, hence over K by linear
disjointness. Every T_(i,k)(4) and T_(i,k)(8) vanishes. Inverting the
cubic Fourier transform gives equality of the two moments across
all three sheets at each root.

For two sheets put D(Z)=sum_j(m_(i,s,j)-m_(i,s',j))Z^j in F5[Z].
Its degree is at most28 and it vanishes at xi4 and xi8. Their two
disjoint5-Frobenius orbits have length14 and exhaust all nontrivial
29th roots, so D is a constant multiple of Phi29. This proves the
constant-difference assertion. Polynomial norms give equal sheet
cardinalities, hence D(1)=0. Since Phi29(1)=29=4 in F5, D=0.
If each count is at most four, this already gives integer equality.

## One norm coefficient lifts the larger integer range

Remove the common residues in{0,...,4} from each phase count.
At root i the remaining counts are five times equal-cardinality
block multisets of size b_i. On the opposite endpoint their leading
pole-residue polynomial is G(W)^5 J(W3); the balanced residues
give J(W3). The full norm polynomial also has the leading factor
W^(n-3m). Its index-five coefficient is minus the fifth power of
the sum of G's roots. That coefficient lies in L(5O)=span(1,x),
so its pole term of order five vanishes.

A block at root i, sheet s, phase xi^j has leading residue, up to
one common nonzero scalar,
\[
w_i\zeta^{2s}\xi^{-10j},\qquad
w_i=\frac{2A'(\alpha_i)}{[13]}B_i^{-10}r_i^2.
\]
The four w_i, expanded in the same E/B basis, have determinant[12].
Linear disjointness therefore separates the index-five equation
root by root. If b_i<=3, the short first-moment rigidity below
makes the three block multisets identical. Their original counts
then agree as integers. The condition m_i<=19 implies b_i<=3;
no bound on their sum is used.

## The retained short Fourier rigidity

The complete length-three test enumerates4495 phase multisets and
all20,205,025 pairs for the first two sheets. Exactly4495 triples
satisfy the first cubic Fourier relation, all balanced. Shorter
cardinalities follow by adding the same phase to all three sheets.
For length four, the complete1,293,121,600-pair test proves that
the first and doubled-phase relations together force equality.

The [relative-F25 producer](../../scripts/arithmetic/cubic_fourier_phase_multisets.cpp)
and [independent absolute-F5 verifier](../../scripts/arithmetic/verify_cubic_fourier_phase_absolute.cpp)
encode every field coordinate injectively, so equality never rests
on hash collisions. Their original complete replays agree. Evidence
is cubic_fourier_three.log, cubic_fourier_four_two_moments.log,
cubic_fourier_three_absolute.log and cubic_fourier_four_absolute.log
in [the phase directory](../../../litt3-computation-data/prime_field_phases_20260927/).
The unsuccessful one-moment length-four shortcut is recorded in
[the failed-route index](../../Research/FAILED_ROUTES.md).

## Focused evidence and scope

The [small determinant constructor](../../scripts/arithmetic/rootwise_trace_field_separation_20260929.py)
now derives both jets from P,A and reconstructs all five matrices.
Its narrowed execution passes; all retained trace fields match the
original rootwise_trace_field_separation_v2.json, and its residue
matrix matches differentiated_endpoint_phases_v2.json exactly.
The new receipt is
[five_endpoint_determinants.json](../../../litt3-computation-data/endpoint_phase_hindsight_draft/five_endpoint_determinants.json).
The old small-phase anchor, two-label search and derivative-minor
producer are subsumed and deleted completely; their original sources
and receipts remain in
[the external provenance](../../../litt3-computation-data/endpoint_phase_before_hindsight/).

The modular proof needs no phase enumeration. The larger integer
lift retains the necessary three-phase certificate; the separate
stronger four-phase statement retains its own certificate. Neither
norm invariance in arbitrary degree nor a common-cover solution follows.
