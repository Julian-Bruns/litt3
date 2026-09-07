# Proof: local Cartier and low two-primary torsion leave two ratios

[Statement](../Theorems/Thm_fixed_x_nonzero_cartier_profiles.md).
Author /root,2026-09-07; no independent audit yet.

By `canonical_intersection`, the primitive shared tensor has a uniform
divisor eS, whose reduced images satisfy e deg(D_X)=16d. The
`cartier_generator` theorem gives d|4 when its Cartier image is nonzero,
and e+d is nonzero modulo5. The case d=1 is excluded by
`fixed_x_orbifold_bound`, which excludes a shared one-form for every
coreless span involving X. Thus d=2 or4.

Both d and e are powers of two: e divides16d. Write e/d=2^j. Since
e>=1 and d<=4, and deg(D_X)>=1, one has -2<=j<=4. The local Cartier
condition is 2^j+1!=0 modulo5; it eliminates j=-2 and j=2.

For j=0 both tensors have zero multiplicity exactly d. The
`shared_tensor_core` theorem forces a core, contrary to hypothesis.

For j=3, D_X is reduced of degree2. Put alpha=[D_X-2O], using the
fixed canonical divisor16O. Since div(s_X)=8dD_X,

       8d alpha=0.

This is genuinely pure two-primary torsion. The audited `two_primary_w3`
theorem makes alpha zero. But L(2O)=k on X, so D_X=2O, impossible
for a reduced degree-two divisor.

For j=4, D_X=P and 16d[P-O]=0. The same two-primary theorem gives P=O.
Hence s_X is a scalar multiple of theta^d, where theta=dx/y^2 and
div(theta)=16O. The one-endpoint root rule in `cartier_generator`
makes theta a nonzero-eigenvalue Cartier form. Such forms have only
simple zeros by `fixed_x_cartier_eigenforms`, contradicting div(theta).

The only remaining values are j=-1 and j=1. Substituting into
e deg(D_X)=16d and e deg(D_Y)=d(2g(Y)-2) gives exactly the two rows.
Both pullbacks and their common multiplicity remain in this argument;
no root is taken on Y and no simultaneous Galois refinement is presumed.
