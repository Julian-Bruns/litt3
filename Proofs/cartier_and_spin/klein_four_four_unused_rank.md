# Proof of the four-unused-location bound

Retain the actual word spaces and endpoint fields in
[the statement](../../Theorems/cartier_and_spin/klein_four_four_unused_rank.md).
For0<=d<=6 set
\[
W_d(C)=\{(F,T):F=2t^{22}T+F_{\rm low},\quad
\deg T\le d,\quad\deg F_{\rm low}\le15+d,\quad C\mid F\}.
\]
The established Fourier minors give dimension17+2d-deg C.
Every unused location a in mu_29 imposes the actual equation
\[
L_a(F,T)=F(a)-a^{22}T(a)=0. \tag{1}
\]
All coefficients of these spaces and functionals belong to M=F_(25^7).

## Complete rank calculation for the lower space

For deg C=14+2r,0<=r<=5, W_r(C) has dimension three.
Every two complementary mixed functionals are independent, by the
[two-location theorem](klein_four_unused_pole_constraints.md).
The complete exact enumeration finds precisely one orbit of four
functionals contained in a plane in the dual space. In a fixed primitive
29th-root coordinate zeta, it is
\[
r=2,\quad J=\{0,3,4,5,6,8,10,11,12,13,16\},\qquad
A=\{4,5,11,12\}. \tag{2}
\]
Here C has as roots all zeta^a with a outside J, and A indexes the four
unused locations. The complement and node bitmasks are81273 and6192.
No line contains five nodes. The complete totals are
\[
\begin{array}{c|r|r|r|r|r}
r&\text{normalized subsets}&\text{orbits}&\text{nodes}&\text{triple lines}&\text{four-node lines}\\
0&40116600&191280&2869200&1104&0\\
1&30421755&167367&2175771&581&0\\
2&13123110&85358&938938&183&1\\
3&3108105&24739&222651&29&0\\
4&376740&3872&27104&3&0\\
5&20475&299&1495&0&0.
\end{array}
\]
The complement sizes are15-2r. Rotation and coefficient Frobenius
preserve rank. The orbit coverage sums are the full normalized counts,
not a bounded sample of subsets.

For reproducibility, with h_j=(-1)^j e_j(J), the T-kernel has matrix
h_(9-2r+i+j), with0<=i<r-2 and0<=j<=r when r>=2. The corresponding
words are F=2C*floor(t^22*T/C). For r=0,1 include the T=0 words
C*t^l,0<=l<=1-r. At a=zeta^b multiply the mixed evaluation by J'(a):
\[
3a^{28}Q(a)-a^{22}T(a)J'(a),\qquad Q=\lfloor t^{22}T/C\rfloor.
\]
For the T=0 words this row is4a^(28+l). Normalized cross products of
every pair of three-component rows group the projective lines exactly.

## Four constraints on the upper five-dimensional space

Suppose deg C=12+2d and e<=25; hence d<=6. Choose four unused nodes.
For d=0, the T=0 subspace is C times the polynomials of degree<=3.
Its four evaluations are independent Vandermonde equations, leaving
at most a one-dimensional kernel in W_0(C).

For d>=1 suppose the four constraints have rank at most three on
W_d(C). Their common kernel has dimension at least two. For each node
a choose a nonzero kernel word with T(a)=0. Then F(a)=0 as well.
Division by t-a gives a nonzero word in W_(d-1)(C) annihilated by
the other three mixed functionals. Thus every three of the four
functionals on this lower three-dimensional space are dependent.
Every two are independent, so all four have rank two. The preceding
complete calculation forces exactly the orbit(2), with d=3.

For that exception, direct polynomial reconstruction gives rank three
on the upper five-dimensional space. Its kernel is exactly
\[
\{(a+bt)(F_*,T_*):a,b\in M\}, \tag{3}
\]
where (F_*,T_*) is the lower common-kernel word. In the field
M=F25[zeta]/(4+6zeta+23zeta^2+9zeta^3+5zeta^4+23zeta^5+8zeta^6+zeta^7),
using the standard F25 codes, normalization T_* leading coefficient1 gives
\[
\begin{aligned}
T_*={}&(0,21,8,23,10,7,7)+(7,9,5,10,12,23,18)t+t^2,\\
(F_*/T_*)(0)={}&(19,1,22,3,11,21,4),\\
((F_*/T_*)(0))^{29}={}&(7,23,0,7,24,16,8)\notin F25.
\end{aligned} \tag{4}
\]
The established endpoint field lemma says a nonzero actual ratio in M
has29th power in F25. Thus(3) is inadmissible whenever its denominator
does not vanish at the endpoint. Since T_*(0)!=0, a nonzero linear
multiple can vanish there only to order one. The actual zero-leading
character condition requires order at least two, so that boundary is
also impossible. Rotation and coefficient Frobenius preserve both
nonmembership in F25 in(4) and these vanishing orders.

Outside(2), the upper four mixed constraints have rank four. The actual
word is therefore a scalar multiple of a pair defined over M.

## The zero-leading-character boundary

The actual first-jet relations imply B_i=0 only if A_i=a_i=c_i^jet=0.
Thus F and T are both divisible by t^2. For d<=1 this contradicts
T!=0. For d>=2, division produces a minimum word in W_(d-2)(C):
\[
\deg C=12+2d=16+2(d-2).
\]
It still satisfies all four mixed equations, because their nodes are
nonzero. The complete minimum-word theorem proves that such a word
can satisfy at most one complementary mixed equation. This excludes
the boundary without assuming a nonzero constant coefficient for F.
Indeed that stronger nonvanishing claim is false: the r=3 minimum word
with complementary mask692739 has F(0)=0. It is not an actual solution
of the four unused-node constraints.

Therefore the nonexceptional actual M-line has T(0)!=0, and its first
value and derivative are both in M. The actual endpoint field lemma
allows this for at most one of the three characters. The earlier
three-unused theorem treats the cases c>=13+2d. Combining them proves
that at most one character has c>=12+2d.

Writing delta_i=14+2d_i-c_i, at least two slacks are at least three.
Hence
\[
6\le\sum_i\delta_i=2(48+j-g),
\]
which proves g<=45+j.

## Sources and focused verification

The complete enumerator is
[mixed_plane_rank.cpp](../../scripts/arithmetic/klein_four_mixed_plane_rank.cpp),
run with arguments `0 5`. The independent
[direct polynomial checker](../../scripts/arithmetic/check_klein_four_mixed_planes.py)
constructs the words by dividing each monomial t^(22+i) by C, then
solving the missing-coefficient equations. It reconstructs all retained
triple-line samples, the sole four-node exception and18 additional
word spaces,34 in total. It verifies(3), both ranks, and the exact
field obstruction(4). Complete coverage comes from the separate C++
enumeration; the independent checks are not claimed to be exhaustive.

The complete35-label replay also checks all1032 vanishing leading
characters have equal positive and negative multisets of leading labels.
It retains all2560845 endpoint-character cases and agrees with the
earlier first-jet statement. The optional
[minimum zero-value scan](../../scripts/arithmetic/klein_four_minimum_word_zero_value.cpp)
records the failed stronger shortcut just described; it is not needed
for the theorem.

Logs `mixed_plane_rank.log`, `mixed_planes_independent.json`,
`two_endpoint_paired.log`, `minimum_word_zero_value.log` and
`four_unused_profiles.json` are retained in
[the evidence directory](../../../litt3-computation-data/overnight_three_replies_20260926/).
The profile counts are necessary numerical conditions only, not curves.
