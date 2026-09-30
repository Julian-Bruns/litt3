# Proof: an exact kernel Wronskian

[Statement](../../Theorems/cartier_and_spin/fixed_x_kernel_wronskian.md).
Write $a^2=a+3$ over $\mathbf F_5$, and encode $a_0+a_1a$
as $a_0+5a_1$. Put $\theta=dx/y^2$. The
[small Cartier calculation](cartier_petri_excess_one.md) gives a
basis $q_j(x)\theta$ of the Cartier kernel with ascending
coefficient vectors
\[
q_0=(24,2,1),\qquad q_1=(5,16,0,1),\qquad
q_2=(5,20,0,0,8,1).
\]
Use Hasse derivatives of orders0,1,2 in $x$, and set
$W=\det(q_j,D_xq_j,D_x^{(2)}q_j)$, with these three derivative
orders indexing the rows. Exact arithmetic gives
\[
W=(3,1,13,11,8,17,9,3).
\]
In particular the determinant is nonzero, so the lexicographically
minimal independent order sequence is already $(0,1,2)$.
The script supplies Bézout identities for
$\gcd(W,W')=\gcd(W,F)=1$, and also for
$\gcd(q_0,q_1)=1$.

In the coordinate $x$, the one-form coefficients are $q_j/y^2$.
The Hasse Leibniz rule and triangularity of the first three jets
give the global Wronskian tensor
\[
w_V=y^{-6}W(x)(dx)^6=F(x)^2W(x)\theta^6.
\]
At each simple cubic branch point, $F$ has order three on $X$,
while $\theta$ and $W$ are units. The order is therefore six.
The seven distinct roots of $W$ are disjoint from the cubic
branch set, and each has three distinct preimages on $X$; the
order at all twenty-one points is one.

At infinity, $x$ has pole order three, $F$ pole order thirty,
and $\theta$ zero order sixteen. Since $W$ has degree seven,
\[
\operatorname{ord}_O(w_V)=96-60-21=15.
\]
The total degree is $60+21+15=96=6(2g(X)-2)$, as required.
The nonzero multiplicity residues modulo five are at precisely
the ten branch points and twenty-one Wronskian points.

For an actual span to genus two, write $n=\deg f$, so
$\deg g=8n$. Étaleness gives $31n$ distinct points in
$f^{-1}(T_V)$. A nonempty finite $g$-saturated set must have
cardinality divisible by $8n$. Since $8\nmid31$, saturation
is impossible. This argument needs neither corelessness nor
ordinariness.

Reproduce the exact polynomial calculations using
[the standard-library script](../../scripts/arithmetic/fixed_x_kernel_wronskian.py).
The generated Bézout receipt is stored outside the prose workspace at
[fixed_x_kernel_wronskian.json](../../../litt3-computation-data/finite_transport_20260920/fixed_x_kernel_wronskian.json).
