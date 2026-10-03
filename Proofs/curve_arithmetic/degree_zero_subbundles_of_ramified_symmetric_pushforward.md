# Proof: constant normal-closure evaluations and actual inertia triviality

Version1,3 October2026. Independent whole review [PASS](../../Research/audits/DEGREE_ZERO_SYMMETRIC_PUSHFORWARD_AND_FOUR_RADICAL_AUDIT_2026_10_03.md).

Let π:Z→C be the smooth projective normalization in the ACTUAL normal closure. Each of the n embeddings of k(T) in k(Z) defines a regular map Z→T over C and hence an evaluation map π*(f_*O_T)→O_Z. The combined map to O_Z^n is generically an isomorphism. Its restriction to π*H is therefore generically injective and is sheaf-injective.

The line det(π*H) has degree ZERO. Some maximal minor of that evaluation map is a nonzero regular section of its inverse. On a proper smooth connected curve, a nonzero section of a degree-ZERO line has no zeros. Thus the corresponding minor is everywhere invertible. Every other minor divided by it is a global regular function, hence a constant. The Plücker coordinates are constant, so the image is W⊗O_Z for a fixed k-subspace W⊂k^n. The invertible minor also identifies π*H with that constant image integrally.

Deck transformations of π permute the n evaluations. Since H is pulled from C, W is S_n-invariant. More is true at every inertia point. For g fixing a point z∈Z, the canonical action on the fiber of π*H at z is the IDENTITY: its fiber is the fixed vector space H_{π(z)} and scalar residue action is trivial over the algebraically closed field. Equivariance of the injective evaluation fiber therefore makes the permutation action of that inertia element on W the identity.

In particular some transposition acts trivially on W. Because W is S_n-invariant, all conjugate transpositions act trivially. They generate S_n, so W is pointwise fixed by S_n. In the degree-n permutation representation the fixed subspace is exactly the diagonal unit line. Hence rank H=ONE and its generic field image is the constants. The generic line of H equals the unit line O_C⊂f_*O_T. Both are saturated, so they agree integrally. This proves the statement without averaging by the monodromy-group order.
