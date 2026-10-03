# Exact supported-root obstructions and sharp residue thresholds

Version3,3 October2026. Use the fixed curve X, infinity O, twelve
marked points Z and group Gamma from the
[exact marked relation theorem](marked_divisor_relation_lattice.md).
Its exponent is m, prime to five, and the least noninvariant
effective supported pole is B=1,617,894.

Let U be the group of nonzero rational functions with divisor
supported on Z union{O}, modulo k*. For d>=1, let U_(d) consist
of those with every valuation divisible by d. There is a canonical
exact root-obstruction description
\[
U_{(d)}/U^d\simeq\Gamma[d]
\simeq(\mathbf Z/\gcd(d,3))^2
 \oplus\mathbf Z/\gcd(d,39)\oplus\mathbf Z/\gcd(d,m).
\]
A function g with div(g)=dD is a dth power exactly when [D]=0.
Thus EVERY supported such g has a root precisely when gcd(d,m)=1.
This works also for d divisible by the characteristic; the group
is the marked subgroup, not the full Jacobian.

Suppose gcd(d,m)=1 and g is regular away from O with zeros in Z.
If its three sheet multiplicities at each root alpha_i agree
modulo d, let e_i in{0,...,d-1} be their common residues. Then
\[
g=c\prod_i(x-\alpha_i)^{e_i}h^d,\qquad
\operatorname{pole}_O(h)
=\frac{\operatorname{pole}_O(g)-3\sum_i e_i}{d},
\]
with h regular away from O and all finite zeros in Z.
For THESE residues the exact first noninvariant pole is
\[
dB+3\sum_i e_i.
\]
The uniform invariant range is pole_O(g)<=dB-1, and is sharp.

For d=5 this recovers the prior threshold8,089,469 and
noninvariant example at8,089,470; at height a it gives the sharp
zero-residue threshold5^a B directly. These require TOTAL sheet
multiplicities congruent modulo d. Actual modular phase constraints
alone need not supply it. No signed-support threshold or actual
norm realization is inferred.
[Proof](../../Proofs/cartier_and_spin/marked_support_five_saturation.md).
