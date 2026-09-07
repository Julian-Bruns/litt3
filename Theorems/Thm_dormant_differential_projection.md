# The third-order projection and a uniform 32-dimensional atlas space

Fix ANY geometric dormant oper on the genus-nine curve of
`scalar_hermitian_data`. Put L_r=delta^2-P, and let W be its rank-two
Cartier descent, with trivial determinant. Define

    Q_r=delta^3+P delta+3(delta P),

where the last term is multiplication, not composition. Then:

1. On k(C), Q_r L_r=L_r Q_r=0, ker Q_r=im L_r, and
   im Q_r=ker L_r. Kernels here are over k(C)^5.
2. With the absolute Frobenius module convention a.f=a^5 f, there is
   an exact complex of vector bundles

       0 -> W(8O) -> F_*O(32O) --L_r--> F_*O(64O)
         --Q_r--> W(24O) -> 0.                              (1)

   Its twist by O((n-8)O) is exact for every integer n. In particular,
   the global scalar map Q_r:L64 -> S_U is surjective, with
   24-dimensional kernel, for EVERY oper, not just a general one.
3. In E=P48, with the residue pairing against L64, the space

       J_r=Ann(ker(Q_r:L64->S_U))                           (2)

   has dimension32. Equivalently it is the scalar image of the injective
   cohomology map H1(W(-8O))->H1(F_*O(-48O)). It consists exactly of
   classes admitting rational horizontal representatives.
4. For the complete tensor pencils Ntilde and R, not merely their
   decomposable points,

       R(ker Ntilde) subset J_r.                            (3)

   Thus EVERY solution of the atlas equations belongs to this fixed
   32-dimensional eta-space. The old136-row and new64-row N tensors
   differ by a FIXED injective linear comparison, so (3) applies to
   either implementation and to every stage of the coupled linear sieve.

No assumption h0(W(8O))=0 is needed. In general im(L_r:L32->L64)
can be smaller than ker Q_r; their dimension difference is h0(W(8O)).
Neither (2) nor (3) asserts an atlas exclusion or equality with the entire
stable sieve space for every oper.

Status: proved; the exact-complex and full-tensor derivations passed a
bounded independent prose audit. Auditor: cohomological_ode_comparison_audit,
2026-09-07. Verdict PASS; no remaining objections. Explicit absolute
Frobenius coefficient conventions are essential.
[Audit metadata/reference](../Research/audits/COHOMOLOGICAL_ODE_COMPARISON_2026_09_07.md).
[Proof](../Solutions/Sol_dormant_differential_projection.md).
