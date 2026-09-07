# The extension projection is not a hidden Frobenius map

2026-09-07. Exact computation for the first saved genus-nine oper only.
No atlas, valid quotient, or common-cover exclusion follows.

Let N(U) be the full64x56 extension pencil and R(U) the full56x56
retraction. On the admissible open, normalize its unique kernel vector c by

    N(U)c=0,   w(U)c=1,   w(U)=U^T Iproj R(U)/2.

The audited radial identity identifies this normalization with Wronskian1.
Thus c=e(U)/Delta(U), homogeneous of degree-2. Let Aout be a rank24
annihilator of Bc^[5]. The FIFTH POWER on the fixed embedding Bc is
essential: c is an extension coordinate in E^[5], not E. The weak
atlas condition is Aout c=0, before imposing the remaining retraction.

The script differentiates the exact kernel and normalization equations:

    N dc_i=-N_i c,
    w dc_i=-(e_i^T Iproj R+U^T Iproj R_i)c/2.

This is one augmented65x56 linear solve with32 right-hand sides, over
F5[a]/(a^2+4a+2). It checks every equation and dc(U)=-2c.

At the saved F25 point the extension map has projective differential
rank31, while psi=Aout c has affine differential rank24 and projective
differential rank23. A nonzero24x24 minor, its columns, the point, the
normalized extension, and exact source hashes are saved. Reproduce with

    sage scripts/extension_projection_differential.sage

These exact ranks imply that this rational affine projection is dominant
and generically smooth, and the corresponding projective rational map
to P23 is dominant and generically separable. In particular its ratios
are NOT all fifth powers; no common scalar rescaling can make them so.
This is a proved limitation of that particular simplification, not a
claim based on how frequently random samples succeed.

Crucially, the point is NOT on psi=0. Generic smoothness says nothing
about whether that special fiber is nonempty, smooth, or entirely on
the discarded boundary. Nor does it solve the remaining Frobenius
fixed-point equations on that fiber. The larger atlas problem persists.

Evidence: [exact result](computations/extension_projection_differential.json).
