# Extension classes as primitive polynomial kernel lines

Use `rank_two_extension_space`. The following statements hold in every
characteristic, with ell>2g.

1. For every nowhere-zero u, ker N_u=k eta_u, and eta_u!=0. Equivalently
   M_u has rank2ell+g-2 and kernel u H0(omega).
2. There is a primitive homogeneous polynomial kernel vector e(u), unique
   up to nonzero scalar, whose degree is EXACTLY2ell-2. It is nonzero at
   every point where N_u has its generic rank. In particular it does not
   lose any admissible point, including outside a chosen minor chart.
3. If D is the zero divisor of a nonzero section u of W L, the kernel
   of M_u is canonically H0(omega(D)), multiplied by u. Its generic rank
   persists for deg D<=1; rank can drop only when deg D>=2. That latter
   locus has codimension at least2 in P(A).

For the fixed genus-nine oper, apply this with W its Cartier descent
and L=O(24O). The extension class lies in P48=H1(O(-48O)). Its kernel
line is given by a64x56 matrix, in place of the136x56 pencil of
`wronskian_matrix_pencil`. Here is a scalar construction with no auxiliary
frames. Compute S_40=ker(delta^2-P on L(192O)), dimension64. For each
basis element T_j and U in S_U, expand the polynomial Wronskian uniquely:

    U delta T_j-T_j delta U = sum_l c_(j,l)(U) m_l^5,

where m_l runs through the56 monomials of L(64O). Let

    S_(i,l)=Res_O(ell_i m_l theta),       ell_i the P48 basis.

Then S is invertible, and

    Ntilde_U = (c_(j,l)(U)) (S^[5])^T                       (1)

is a64x56 matrix LINEAR in U with the same kernel as N_U on every
admissible direction. In particular rank Ntilde_U=55 there. Its primitive
polynomial kernel has degree46 in U's32 Frobenius coordinates. It may
replace N_U in the projective Frobenius-line criterion.

Status: author proof, not independently audited. The degree agrees with
the characteristic-zero extension-space literature; the proof here is
characteristic-independent. Five exact fixed-curve tests verify every
Wronskian expansion, residue pairing, rank, and equality of the two kernels.
No atlas or common-cover exclusion follows merely from the degree formula.
[Proof](../Solutions/Sol_rank_two_extension_pencil.md).
