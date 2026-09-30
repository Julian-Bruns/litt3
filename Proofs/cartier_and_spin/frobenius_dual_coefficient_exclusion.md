# A nonzero mixed tensor forced by a small-rank pairing

This proves the [Frobenius-dual exclusion](../../Theorems/cartier_and_spin/frobenius_dual_coefficient_exclusion.md).
Use the [all-twist mixed-tensor vanishing](../../Theorems/cartier_and_spin/mixed_frobenius_tensor_twist_vanishing.md).

Let q:R->K be a surjection, deg R=0, and suppose F*R=R^vee tensor T,
with deg T=0. Consider
\[
K^\vee\otimes T\xrightarrow{q^\vee\otimes1}
R^\vee\otimes T\simeq F^*R\xrightarrow{F^*q}F^*K.
\]
A nonzero composition is a section of K tensor F*K tensor T^-1,
contradicting that vanishing.

Write N=ker(q), so deg N=-1. If the composition were zero, the
injective first map would factor through F*N. For rank R=3 this
would inject a rank-two bundle into a line. For rank R=4 it would
give a generically injective map between rank-two bundles of degrees
-1 and -5. Its determinant would be a nonzero section of a line
of degree -4, which is impossible. Thus the composition cannot
vanish in either case, proving the assertion for arbitrary R.

For an irreducible finite coefficient of rank at least three, the
established image argument makes any nonzero map to K surjective.
Briefly its torsion-free image is a quotient of a semistable
degree-zero bundle, so has nonnegative degree. A rank-one image
contradicts the degree-zero-line vanishing for K. A degree-zero
rank-two image becomes a globally generated degree-zero bundle on
an etale trivializing cover, hence trivial there; the corresponding
constant quotient of finite representations contradicts irreducibility.
Thus the image has degree one and equals K. This argument does not
use semisimplicity of the full finite monodromy category.

For rank two, a nonzero map is generically an isomorphism by the
same rank-one exclusion. Both maps in the displayed composition
are then generically isomorphisms, so their composition is nonzero.
This handles rank two without requiring a surjection onto K.

Finally the [tame rank-three theorem](../../Theorems/cartier_and_spin/tame_rank_three_second_projective_return.md)
shows that any surviving irreducible prime-to-five source has Hessian
projective image and precisely the pairing F*R=R^vee tensor T, with
T a finite character. The result just proved excludes it. No scalar
character, determinant, line kernel or target K has been normalized
away. This closes the tame rank-three source problem independently
of the normalized strict-second-return atlas.

The rank-four argument uses degrees as well as dimensions. It does
not extend as stated to rank five: then F*N has rank three and may
contain a degree-minus-one rank-two subbundle. Nor does the theorem
extract a coefficient from a bare two-map common cover.
