# Proof: Frobenius-bijective kernel vectors give actual Artin–Schreier factors

Version1,3 October2026. Whole root review [PASS](../../Research/audits/RANK_THREE_SOCLE_AND_ORTHOGONAL_ROW_AUDIT_2026_10_03.md); see the [statement](../../Theorems/curve_arithmetic/separable_curve_coherent_pullback_and_cyclic_etale_factors.md).

The established [finite separable-map Frobenius argument](../jacobians/etale_frobenius_degree_gap.md), §ONE, proves that ker(f*:H¹(O_C)→H¹(O_T)) has bijective Frobenius. Indeed its intersection with kerF is zero: regular Cartier-killed forms representing kerF remain regular and nonzero after separable pullback, and the connecting map is natural. Frobenius preserves the pullback kernel; finite dimensionality then gives bijectivity. Ramification is allowed.

A nonzero finite-dimensional bijective semilinear Frobenius space over algebraically closed k has a nonzero fixed vector. Explicitly, in dimension r>ZERO write F(v)=A v^[p] with A invertible. The fixed-point equations are v_i^p−(A⁻¹v)_i=ZERO. Their mutually coprime leading monomials v_i^p give a quotient algebra of dimension p^r, with standard monomials of exponent belowp in each variable. Its Jacobian is the invertible constant matrix−A⁻¹, so it is finite étale and has p^r distinct k-points. Besides ZERO there is a nonzero fixed vector. Let v≠ZERO be such a vector in this actual pullback kernel.

Artin–Schreier gives the étale-sheaf exact sequence
\[
0\longrightarrow\mathbf F_p\longrightarrow O_C
\xrightarrow{F-1}O_C\longrightarrow0.
\]
On global constants F−ONE is surjective because k is algebraically closed. Thus H¹_et(C,F_p) injects into H¹(C,O_C), with image precisely its Frobenius-fixed vectors. The vector v defines a nonzero étale C_p-torsor C′→C. It is connected because p is prime and the torsor is nontrivial. Its pullback to T is trivial: its coherent class is zero there, and the same Artin–Schreier injection applies on T. An actual section of this pulled torsor gives an actual factorization T→C′→C.

Conversely, a connected étale C_p-cover through which f factors has a nonzero class in H¹_et(C,F_p), hence a nonzero coherent class. Its pullback is zero. This proves the first equivalence without an assumption on the degree of f.

Since T and C are proper and connected, their global regular functions are k, and the unit map H⁰(O_C)→H⁰(f_*O_T) is an isomorphism. Finite-map cohomology and the exact sequence
\[
0\longrightarrow O_C\longrightarrow f_*O_T
\longrightarrow f_*O_T/O_C\longrightarrow0
\]
identify H⁰(f_*O_T/O_C) with the coherent pullback kernel. This gives the second equivalence.

For a primitive extension of degree different from p, a connected degree-p factor would be a proper intermediate field unless its total degree were p. Hence no such factor exists. In the retained primitive degreeTEN carrier, p=FIVE and the required vanishing follows.

Finally E° contains the primitive unit line because the retained weighted self-trace of the unit vanishes. The quotient E°/O_Γ is a subbundle of φ_*O_T/O_Γ, so its global sections also vanish. This is a statement about the actual target Γ and its actual primitive map. It supplies no injectivity for H¹ of a twisted line and no descent of a boundary class originally defined on Y.
