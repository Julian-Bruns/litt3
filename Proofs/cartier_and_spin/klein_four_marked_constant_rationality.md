# Proof of marked constant-character rationality

Use version2 of [the statement](../../Theorems/cartier_and_spin/klein_four_marked_constant_rationality.md).
The constant-character bound already gives c<=13. Normalize T=1.

## Fourteen mixed interpolation conditions

Choose14-c unused nodes and augment C to a monic degree14 polynomial D.
Put Q=floor(t^22/D), p=1/D(0), alpha=D'(0)/D(0), gamma=D_13 and
L_a=a^22*D/((t-a)D'(a)). Retain every binary marking w_a of its roots.
The word has the form
\[
F=2DQ+\sum_a w_a L_a+D(b_0+b_1t).
\]
The first and opposite actual jets are linked by an invertible affine
map over M. Its opposite first-coordinate coefficient of the initial
derivative is p!=0. Thus the already proved endpoint-plane rigidity
excludes every non-affine first jet, just as for the unmarked degree14
case. The interpolation term changes only the affine constants, not
that argument.

Suppose first r is outside M, so its forced affine jet has target
(lambda,nu,tau,upsilon). Write
\[
k=p(\lambda-\alpha),\qquad
l_0=p\nu-2Q_1,\qquad S_j=\sum_a w_a a^j/D'(a).
\]
The actual opposite pair satisfies
\[
r_\infty=kr+l,\quad l=l_0+S_{20},\qquad
s_\infty=pr-2Q_0+S_{21}+\gamma r_\infty. \tag{A}
\]
If k!=0, its target (lambda',nu',tau',upsilon') must obey
\[
(\lambda'-\gamma)(\lambda-\alpha)=1,\quad
l=(\tau'-k\tau)/2,\quad
\upsilon'=k^2\upsilon-k\tau l-l^2. \tag{B}
\]
The remaining equations are
\[
S_{20}=l-l_0,\qquad
S_{21}=\nu'-(\gamma-\lambda')l+2Q_0. \tag{C}
\]
The complete degree14 subset scan already covers40116600 normalized
subsets and191280 orbits. Allowing the safe3364-target closure at each
end, its8859 pairs satisfying the first equation in(B) reduce to six
after the last two equations, without imposing a marking. They are
\[
\begin{array}{r|r|r}
J\text{ complement mask}&\text{first target}&\text{second target}\\
10431279&401&332\\
10431279&402&331\\
10431291&401&332\\
10431291&402&331\\
13948155&1720&42\\
13948155&1721&41.
\end{array}
\]
For every row, the fourteen marking columns in(C), viewed over F5,
have rank14, and the target raises the rank to15. Explicit linear
functionals certify these six exclusions, even for arbitrary F5 weights.

There are only two k=0 cases: J mask24569963 and first target1315
or1316. A nonzero r_infinity in M would force its derivative into M,
contrary to(A), whose coefficient p of the nonrational r is nonzero.
Thus the only possible boundary is l=0. The fourteen columns of S_20
form an F5 basis of M, so l=0 has unique F5 marking weights. In
ascending exponent order of the fourteen D-roots they are respectively
\[
(3,4,3,3,3,4,3,3,4,4,3,4,4,4),\qquad
(4,3,4,4,4,3,4,4,3,3,4,3,3,3).
\]
Neither is a binary marking. This excludes both boundaries. An initial
r=0 with nonrational derivative is covered by reversing the endpoints:
the opposite first coordinate is then nonrational, and reversing back
would be one of the excluded k=0 cases.

The only remaining first jets belong to M. Since their two coordinates
determine b_0,b_1 affinely over M, the entire normalized word belongs
to M. The endpoint field lemma permits this for at most one character.
This proves the version2 threshold14.

The optional fourth argument of
[two_endpoint_constant.cpp](../../scripts/arithmetic/klein_four_two_endpoint_constant.cpp)
records all six nonzero-k and both zero-k candidates without requiring
the old zero-marking intercept equations. Its full replay retains the
previous8859-pair counts. The
[degree14 marking constructor](../../scripts/arithmetic/klein_four_degree14_markings.py)
checks the ranks and all binary markings. The
[independent checker](../../scripts/arithmetic/check_klein_four_degree14_markings.py)
constructs every L_a directly as a product of thirteen linear factors,
verifies every interpolation value, and records the six annihilating
functionals and the two unique nonbinary weight vectors. All8 cases
pass. Logs/data have prefixes `degree14_marked_candidates` and
`degree14_markings` in the evidence directory linked below.

## The degree-fifteen special case

This independently proved stronger F5-weight exclusion is retained:
Choose15-c unused nodes and let D be their product with C. Thus D is
monic of degree15 with distinct roots in mu29. The actual normalized
word satisfies
\[
F=2t^{22}+F_{\rm low},\quad\deg F_{\rm low}\le15,
\qquad F(a)=w_a a^{22}\quad(D(a)=0), \tag{1}
\]
where w_a is0 at a C-root and1 at a chosen unused node. Retaining every
binary marking is a safe enlargement of the actual problem.

Let Q=floor(t^22/D), G=2DQ, and let
\[
L_a(t)=\frac{a^{22}D(t)}{(t-a)D'(a)},\qquad
F_0=G+\sum_{D(a)=0}w_a L_a.
\]
Every solution of(1) is F=F_0+bD. The actual endpoint formulas are
r=F(0), s=F'(0), r_infinity=F_15, s_infinity=F_14. Put
\[
\lambda=D_1/D_0,\quad\gamma=D_{14},\quad k=D_0^{-1}.
\]
Then
\[
s=\lambda r+\nu,\qquad
r_\infty=kr+l,\qquad s_\infty=\gamma r_\infty+\nu_\infty,
\tag{2}
\]
with
\[
\begin{aligned}
\nu&=G_1-\lambda G_0-D_0\sum_a w_a a^{20}/D'(a),\\
l&=G_{15}-kG_0+\sum_a w_a a^{21}/D'(a),\\
\nu_\infty&=G_{14}-\gamma G_{15}+\sum_a w_a a^{22}/D'(a).
\end{aligned} \tag{3}
\]
These are identities in M for the actual marking. The expression for
F shows that r in M would already make the entire word M-valued.
It remains to exclude r outside M.

### Reduction to the complete nonrational jet list

Because s is affine in r, the established complete endpoint enumeration
makes r quadratic over M. Write its target data as
\[
s=\lambda r+\nu,\qquad r^2=\tau r+\upsilon.
\]
The nonzero k in(2) keeps r_infinity outside M. Its target must have
\[
\lambda'=\gamma,\quad
\tau'=k\tau+2l,\quad
\upsilon'=k^2\upsilon-k\tau l-l^2. \tag{4}
\]
Normalize the first endpoint to the established142 nonrational targets.
The second is allowed the complete3364-target closure under common phase
and coefficient Frobenius. This deliberately permits extra second-end
conjugates; proving emptiness in the larger list is sufficient.

For J the14 complementary roots of D, lambda=sum_(a in J) a^-1.
The preceding complete subset-sum certificate has exactly45 pairs of
first target and J with this lambda. It searches all14-element subsets,
not merely normalized orbit representatives. Under a change of common
phase the parameter rotation and the weight in(1) change compatibly:
F_new(t)=xi^-22 F(xi*t) still has exactly the zero/mixed weights0,1.
Coefficient Frobenius preserves the same equations. Thus the
normalization to142 first targets loses no marked case.

Matching gamma to the opposite slope gives47 target pairs. For each,
the trace equation forces l=(tau'-k*tau)/2. Substituting this into the
last equation in(4) leaves exactly two possibilities:
\[
\begin{array}{c|c|r}
\text{first target}&\text{second target in the closure}&J\text{ bitmask}\\
0&314&261461378\\
0&314&275409532.
\end{array} \tag{5}
\]
All other pairs fail independently of the marking weights.

### The final two cases fail a ground-field linear test

For either row in(5), equations(3) prescribe a vector in M^3 as a sum
of fifteen selected vectors
\[
\left(a^{20}/D'(a),\ a^{21}/D'(a),\ a^{22}/D'(a)\right).
\tag{6}
\]
Expand M over F5 using the fixed F25 basis1,beta and the seven powers
of zeta. The fifteen vectors in(6) have rank15 over F5. Adding the
required target gives rank16 in both cases. Hence no marking exists,
even if every w_a is allowed any value in F5.

An independent certificate reconstructs each L_a by multiplying its
fourteen linear factors and dividing by their value at a; it does not
use the derivative-weight formula(6). It then records the effects of
these Lagrange polynomials on the three expressions in(2). For each
of the two resulting42-coordinate systems it constructs an explicit
F5-linear functional annihilating all15 columns and taking value1 on
the target. This verifies the exclusion directly, without relying on
the subset-sum implementation.

Thus r outside M is impossible. For r in M, F=F_0+bD has b in M,
so all coefficients of F, and its first jet, lie in M. The actual
endpoint field lemma permits this for at most one character. The
r=0 boundary creates no omitted nonrational case: it already forces
b and F into M, and hence s in M as well.

### Reproduction and evidence for the degree-fifteen special case

[constant_marked_pencils.py](../../scripts/arithmetic/klein_four_constant_marked_pencils.py)
uses the previously certified142/3364 target files and45 exhaustive
slope hits. It checks all47 opposite-slope pairs, the quadratic
compatibility, and every binary marking via a7+8 subset-sum split.
It also records the ground-field ranks. All markings fail.
[check_constant_markings.py](../../scripts/arithmetic/check_klein_four_constant_markings.py)
performs the independent polynomial reconstruction and retains the
two explicit annihilating functionals. Both commands take the evidence
directory as their single argument.

The exact outputs `constant_marked_pencils.json/.log` and
`constant_markings_independent.json` are in
[the evidence directory](../../../litt3-computation-data/overnight_three_replies_20260926/).
The construction uses integer derivatives reduced modulo5, separately
from the F25 coefficient codes; a development version with unreduced
integer derivative multipliers was corrected before the retained run.
No bounded point search or model-field restriction is used.
