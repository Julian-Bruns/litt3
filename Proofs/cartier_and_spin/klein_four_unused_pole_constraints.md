# Proof of independence at unused pole locations

Use the [statement](../../Theorems/cartier_and_spin/klein_four_unused_pole_constraints.md)
and the Hermite notation already established for the actual two maps.
Put M=F_(25^7), Omega=mu_29, and D=(t^29-1)/E. The word pair satisfies
\[
F=t^{22}T-\epsilon DU,\qquad C\mid F.
\]
Thus every a in Omega outside the common pole support imposes
\[
L_a(F,T):=F(a)-a^{22}T(a)=0. \tag{1}
\]
This uses the actual identity, rather than just the vanishing of F on C.

## The three-dimensional boundary

Suppose c=14+2d. For0<=d<=6, the space W of words F in S_d vanishing
on C has dimension three over M. The high coefficient block is 2t^22*T,
so T is determined by F. For d=7,c=28, use pairs instead: deg F<=29,
deg T<=7, deg(F-2t^22*T)<=22 and C|F. These also form a
three-dimensional space; T(0) is the extra free coefficient. There is
no boundary with d>=8 since c<=29.

For d=0, the kernel of T in W is C times the space of polynomials of
degree at most one. Hence L_a,L_b are independent for distinct a,b
outside C, by evaluation of a linear polynomial at two points.

For1<=d<=7, fix a outside C. The subspace
\[
\ker L_a\cap\ker(T(a))
\]
consists exactly of multiples of the pair (t-a)(G,H), where (G,H)
is the unique minimum word in S_(d-1) vanishing on C, with high block
2t^22*H. Indeed F(a)=T(a)=0 permits division by t-a, and the
lower block degree decreases by one. The MDS bound gives a
one-dimensional space after division. The statement includes d=7,
where S_6 is the full space of polynomials of degree at most28.
It also shows that L_a is nonzero on W: otherwise its intersection
with one additional linear kernel would have dimension at least two.

If L_a,L_b were dependent, apply L_b to (t-a)(G,H), and L_a to
(t-b)(G,H). Since a!=b, this would require both
\[
G(a)=a^{22}H(a),\qquad G(b)=b^{22}H(b). \tag{2}
\]
The following complete minimum-word calculation excludes(2).

## Exact minimum-word node calculation

For r=d-1 in0..5, let J be the complementary roots, of size13-2r,
and h_k=(-1)^k e_k(J). The previously established cofactor construction
gives the unique H=sum h'_l t^l from
\[
\sum_{l=0}^r h'_l h_{7-2r+i+l}=0\quad(0\le i<r),
\qquad G=2C\lfloor t^{22}H/C\rfloor.
\]
At b in J, C(b)=29b^28/J'(b), with J also denoting its monic
root polynomial. Thus G(b)=b^22*H(b) is tested exactly by
\[
2\cdot29b^{28}Q(b)-b^{22}H(b)J'(b)=0,
\quad Q=\lfloor t^{22}H/C\rfloor. \tag{3}
\]
The exhaustive rotation/Frobenius orbit counts are
\[
\begin{array}{c|r|r|r|r}
r&\text{normalized subsets}&\text{orbits}&\text{node tests}&\text{matches}\\
0&30421755&167367&2175771&31\\
1&13123110&85358&938938&12\\
2&3108105&24739&222651&3\\
3&376740&3872&27104&2\\
4&20475&299&1495&0\\
5&378&10&30&0.
\end{array}
\]
Every matched word occurs exactly once. No word has two matching
nodes. Orbit sizes sum to each full normalized count; the condition
in(3) is preserved by rotation and coefficient Frobenius. For r=6,
the complement J has only one point, so two matches are impossible
without any computation. This proves independence of L_a,L_b.

The source is
[minimum_word_missing_nodes.cpp](../../scripts/arithmetic/klein_four_minimum_word_missing_nodes.cpp).
It reuses the already checked field and minimum-word routines.
[The independent verifier](../../scripts/arithmetic/check_klein_four_missing_nodes.py)
reconstructs all48 exceptional words from direct polynomial coefficient
matrices, rather than from the complementary Hankel matrix. It checks
each actual node value and uniqueness of the matching node. All checks
passed. The assertion that no single-node matches exist would be false;
only the at-most-one assertion is used.

## The endpoint denominator cannot vanish

The complete forced-label calculation also gives
\[
B_i=0\quad\Longrightarrow\quad A_i=a_i=c_i^{\rm jet}=0. \tag{4}
\]
Here a_i and c_i^jet are the first coefficients of u_i and t^3*v_i
at0; c_i^jet is not the pole-count integer. All804837 normalized
character-label tests were retained, including leading-label collisions.
Among345 zero B_i cases every value in(4) vanishes.

In the actual local frames, (4) makes U_i and T_i divisible by t^2,
and hence also F_i. For d=0,1 this already makes T_i=0, impossible.
For2<=d<=7, division by t^2 gives an S_(d-2) word with14+2d
specified roots, above its maximum12+2d. Thus it is zero; its high
block would again make T_i=0. Therefore B_i!=0 on this boundary.

The source and evaluator are
[zero_endpoint_derivative.py](../../scripts/arithmetic/klein_four_zero_endpoint_derivative.py)
with --include-individual-jets and
[zero_endpoint_derivative.cpp](../../scripts/arithmetic/klein_four_zero_endpoint_derivative.cpp).
This extends the previous exact numerator test only at its345 zero
denominators. The independent log verifier checks all expected counts.

## Consequence for the three actual characters

When e<=27 there are two distinct unused nodes outside E, hence outside
C_i. Their independent equations cut W down to a line defined over M.
Every nonzero actual boundary pair is therefore a scalar multiple of
an M-rational pair. As B_i!=0, its endpoint value and derivative
\[
r_i=(F_i/T_i)(0),\qquad s_i=(F_i/T_i)'(0)
\]
both belong to M. The established forced-label field lemma permits
this for at most one of the three characters. Thus at most one has
c_i=14+2d_i.

If all three c_i are even, each of the other two characters saves an
integer from h_i<=17+c_i/2. Summing gives g<=46+j. If two c_i
are odd, their two half-integer savings already give g<=47+j.
These are the only parities because sum c_i=2j. This proves the
statement, retaining both actual maps throughout.

Exact logs and the48 independent reconstructions are retained with
prefixes minimum_word_missing_nodes, missing_nodes_independent and
zero_endpoint_individual_jets in
[the external evidence directory](../../../litt3-computation-data/overnight_three_replies_20260926/).
No finite-field bound on a hypothetical curve, and no simultaneous
Galois closure of an arbitrary span, has been assumed.
