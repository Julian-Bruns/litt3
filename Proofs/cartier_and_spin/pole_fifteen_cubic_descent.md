# Proof: missing local coefficients force cubic descent at pole fifteen

[Statement](../../Theorems/cartier_and_spin/pole_fifteen_cubic_descent.md).
The [received report](../../../litt3-computation-data/critical_descent_replies_20260927/extracted/pole15/pole15_cubic_descent/REPORT.md)
and its [foundations](../../../litt3-computation-data/critical_descent_replies_20260927/extracted/pole15/pole15_cubic_descent/FOUNDATIONS.md)
give full local derivations. This proof records the complete chain and
the reusable rigidity argument. A focused independent audit passed.

## Actual comparison equations and coefficient spaces

Write M=k(T), N=k(x1,x2), n=deg h_i, and N0=n-15. Normalize
the comparison parameter by t=z/c0 so that
\[
A(x_2)=\epsilon^4t^{-13}A(x_1),\qquad
\theta_2=\eta t^{16}\theta_1,\qquad \eta^3=\epsilon^{-17}.
\tag{1}
\]
The established field reduction gives [M:N] in{1,3}, t,y2/y1 in N,
and M=K_i(t). Supported norms of pole fifteen are degree-five
polynomials in x, with multiplicities summing to five at the four
roots of A. Neither norm composition is identified with the other.

The j-th elementary symmetric coefficient of the etale branches
of t has pole order at most min(j,15) at O. The basis of L(15O)
is 1,x,x^2,x^3,x^4,x^5,y,xy. Consequently the two actual equations,
with Z=t or t^-1, are
\[
F_i(X,Y,Z)=Z^n+\sum_{r=0}^5B_{ir}(Z)X^r
             +Y(H_{i0}(Z)+XH_{i1}(Z)),
\tag{2}
\]
where deg B_ir<=n-3r for r>0, deg B_i0<n,
deg H_i0<=n-10 and deg H_i1<=n-13. Cubic descent is equivalent
to vanishing of either character pair, and then both vanish.
Assume index one for a contradiction. Thus M=k(x_i,Z),
[M:k(Z)]=15, and both character pairs are nonzero.

## The later integer phase theorem applies directly

At each A-root the actual polynomial norm gives equal sheet
cardinalities m_alpha, with sum m_alpha=5. The later
[unbounded phase theorem](unbounded_modular_phase_balance.md)
therefore balances every phase as an INTEGER multiplicity on the
three sheets, on both actual legs. Its two-jet field separation
proves equality modulo five; its index-five norm coefficient
removes any fivefold discrepancy. Here each root has at most
one fivefold block. This includes the concentrated norm and
arbitrary repeated phases, without a size-five multiset search.

Their equal leading germs imply
\[
\deg H_{i0}\le n-11,\quad \deg H_{i1}\le n-14,
\quad\operatorname{ord}_0(H_{i0}+\alpha H_{i1})\ge m+1,
\quad\operatorname{ord}_0H_{i1}\ge m,
\tag{3}
\]
at an occupied root of multiplicity m. These are full multiplicities,
not their residues modulo five.

## Resonance improves both ends of the character bounds

In the local (t,V-b) ring, (1) defines U=x1 uniquely by
\[
A(U)=\epsilon^{-4}(A_4tV^4+A_3t^4V^3+A_2t^7V^2+A_1t^{10}V+A_0t^{13}).
\]
Thus U=alpha+t a(V)+O(t^2), a=A4 epsilon^-4 V^4/A'(alpha),
with a'(b)!=0. Choose analytic units Y^3=P(U),
W^3=t^30P(t^-3V). The differential equation becomes
\[
tV'=g(t,V)=\frac{3VY^2+\eta W^2U_t}{Y^2-\eta W^2U_V/t}.
\tag{4}
\]
At(0,b) its denominator is3Y^2, and g(0,b)=0,g_V(0,b)=2.
Differences of distinct solutions therefore have order2 modulo5,
hence at least two; the corresponding U-differences have order
at least three. Different phases have U-difference order one.

For a phase of multiplicity r among m branches on a sheet,
comparison with the other sheet gives
\[
\operatorname{ord}_0(H_{i0}+x_iH_{i1})\ge m+2r.
\tag{5}
\]
These are the actual reduced branch ideals of the two endpoint
models. The implicit coordinate changes match their branches,
and joint minimality and index one make them distinct. Abstract
equations with merely matching leading terms would not suffice.

In the opposite chart the affine character is
t^(n-10)H20(t^-1)+V t^(n-13)H21(t^-1), with values of order>=2r.
If either coefficient started in order one, its nonzero affine
initial form would vanish at every phase. Distinct A-labels have
distinct b^29, so all five branches would have one phase. For
the least difference order D>=2 among the fifteen distinct
three-sheet branches, subtraction of two character values would
then give 1+D>=5D, impossible. Exchanging endpoints yields
\[
\deg H_{i0}\le N0+3,\quad\deg H_{i1}\le N0,
\quad\operatorname{ord}_0H_{i0},\operatorname{ord}_0H_{i1}\ge3.
\tag{6}
\]
For the zero-order assertion, an affine initial form of degree<3
would vanish at every occupied A-root. Two roots are impossible;
one root has multiplicity five and is already handled by(3).

## Common infinity and the missing fourth coefficient

At O put q=x^3/y. Then x=q^-3 times a unit in k[[q^3]],
y=q^-10 times such a unit. Set mathscrF_i=q^15F_i. Its q^0,q^2,q^5
coefficients are B_i5,H_i1,H_i0+P9 H_i1; its q and q^4 coefficients
are ZERO. The fifth power x^5 contributes no intervening terms.

Let l_c be the number of common-infinity points with t-value c.
Then c^29=1 and
\[
B_{15}(t)=C_1\prod_c(t-c)^{l_c},\qquad
B_{25}(Z)=C_2\prod_c(Z-c^{-1})^{l_c},\quad \sum l_c=N0.
\tag{7}
\]
Actual etaleness factors each local equation into
prod(Z-Z_P(q)) times a unit, with Z_P(q)=c+O(q^2).
Its q^j coefficient is divisible by (Z-c)^max(l_c-floor(j/2),0).
Thus R_i=H_i1/B_i5 has at most simple finite poles and
S_i=H_i0/B_i5 at most double poles, all at the relevant c.
By(6), R_i is bounded at infinity and has order>=3 at zero.

Write A=q^-12 Psi(q^3), theta=q^16 phi(q^3)dq, phi(0)=2.
The two actual maps define q2=q Rcal(q^3,t), with
\[
Rcal^{12}=\epsilon^{-4}t^{13}
  \frac{\Psi(q^3Rcal^3)}{\Psi(q^3)}.
\]
The leading factor r satisfies r^12=epsilon^-4 c^13,
r^17=eta c^16 and is unique. The theta identity gives a SINGLE
analytic equation qt'=G(q^3,t) shared by all actual branches at c,
where
\[
G(0,c+h)=2h+4h^2/c+O(h^3).
\tag{8}
\]
For completeness, Rcal_0'=4Rcal_0/t and
G(0,t)=4t(eta t^16/Rcal_0^17-1); logarithmic differentiation
of the quotient gives(8).

The derivation D=q partial_q+G(q^3,Z)partial_Z preserves every
actual reduced branch ideal. Consequently D mathscrF/mathscrF
is regular in k[[q,Z-c]]. Writing
mathscrF/B=1+q^2R+q^3U+0q^4+O(q^5), its q^2 and q^4 coefficients
are respectively
\[
2R+G_0R',\qquad -R(2R+G_0R').
\tag{9}
\]
The omitted term GB'/B has only q-degrees divisible by three.
No characteristic-zero logarithm at degree five is used. If
R=A/(Z-c)+B0+O(Z-c), regularity of the second expression and(8)
force B0=2A/c.

The invertible actual coordinate change(q,t)->(qRcal(q^3,t),t^-1)
identifies the two reduced local equations up to a unit. Comparing
q^2 determines reciprocal residues. Put delta=eta epsilon^6,
lambda=delta^-2. Since r=delta^-1 c^-11 and c^29=1,
r^2=lambda c^7. Therefore
\[
R_1(t)-\lambda t^7R_2(t^{-1})=a t^3+b t^4.
\tag{10}
\]
There are no other finite poles, the order at zero is>=3 and
the growth at infinity is<=4. The
[reciprocal finite-part lemma](reciprocal_finite_part_rigidity.md)
now proves H11=H21=0 for arbitrary geometric a,b and all l_c.

## The fifth coefficient finishes the argument

With H_i1=0, the normalized equation is
1+q^3U+q^5S_i+O(q^6). Its tangent quotient's q^5 coefficient is
G0 S_i', since 5S_i=0. At a pole of order d=1 or2 its leading
term is -2dA(Z-c)^-d, which is nonzero. Thus S_i has no finite
pole. By(6), S_i=gamma_i Z^3.

Some occupied A-root has multiplicity m>=2 since five norm zeros
are distributed over four roots. Equation(5) then requires order
at least m+2r>=4, while gamma_i Z^3B_i5 has order exactly three
if gamma_i!=0. Hence H_i0=0 on both legs, contradicting index one.

Nothing in this proof uses n<=218. That inequality already follows
from fifteen parameter sheets and29 common values of multiplicity
at least two. The quotient-degree-five problem is separate from this
descent argument and is now closed by
[the complete pole15 exclusion](pole_fifteen_complete_exclusion.md).

## Scope and evidence

The [original audit](../../Research/audits/CRITICAL_DESCENT_REPLIES_2026_09_27.md)
checks actual factor transport, resonance, all scalar cases of the
reciprocal lemma and the q^5 step. The later phase theorem replaces
the finite phase input; the rest of this all-degree proof is unchanged.
Original evidence and sources remain in
[external provenance](../../../litt3-computation-data/archive_cleanup_20260930/older_phase_before_hindsight/).
