# Audit: square-label collisions and the spectral conductor budget

**Verdict:** **PASS.**  No breaking mathematical objection found.

**Auditor and date:** `/root/audit_square_labels`, 2026-09-04.

## Checks performed

- For eight equal labels, the common bundle
  \(A=\mathcal O_C(D_\infty)\otimes\epsilon_0\) has degree \(M\) and
  square \(L\).  The eight canonical sections of \(A\) square (up to
  scalars) to the eight evaluated norm sections.  Since the coefficient
  curve has pullback hyperplane bundle \(\mathcal O_{\mathbf P^1}(7)\),
  a hyperplane through those eight distinct parameter values would have
  eight zeros.  Thus they span \(W\), giving \(W\subseteq
  \operatorname{im}(\operatorname{Sym}^2H^0(A)\to H^0(L))\).
- This inclusion transfers base-point-freeness from \(W\) to \(A\) and
  factors the coefficient morphism through the complete \(A\)-map by
  quadrics.  The induced intermediate function fields give
  \(e_A\mid e\); pulling back the hyperplane bundle from the normalized
  image gives \(M=e_A\deg A_A\), hence \(e_A\mid M\).
- In the \(M=9\), full-span case, file 47 gives \(e=2\), so the two
  divisibilities force \(e_A=1\).  Dimension eight of \(W\) forces
  \(h^0(A)\geq4\).  The resulting birational nondegenerate degree-nine
  curve has ambient dimension at least three, where Castelnuovo's largest
  possible genus is \(\pi(9,3)=12\), contradicting \(g(C)=19\).  The
  at-most-seven fiber count, five-label conclusion, and rank-at-least-three
  conclusion follow correctly.
- The spectral image is an integral Cartier curve of bidegree \((7,2M)\).
  Its self-intersection is \(28M\), its canonical intersection is
  \(24M\), and adjunction gives \(p_a=26M+1\).  Since \(g(V)=14M+1\),
  its total delta invariant is \(12M\).
- Etale-local splitting over \(C\) expresses the spectral image as seven
  smooth graph branches.  On each normalized branch the conductor exponent
  is the sum of pairwise graph-contact orders, so the conductor is exactly
  \(\sum_{j=1}^6E_j^t\).  Pullback of the diagonal gives
  \(\deg E_j^t=2M+2M=4M\), hence conductor degree \(24M=2\delta\).
  Multiple root collisions cause overlapping supports but do not alter this
  ordered-pair formula.
- At a hyperelliptic branch value, every participating graph has local
  contact order at least two with any other participating graph: each has
  \(t-\alpha\) of order two.  The ordered conductor count therefore gives
  the stated \(2n_{\alpha,x}(n_{\alpha,x}-1)\) contribution, and the two
  reducedness inequalities follow with the displayed constants.

**Non-breaking presentation suggestion:** In Theorem 55.3, a brief
reference to the standard plane-curve fact that the pullback conductor on a
smooth graph branch is the sum of its contacts with the other branches would
make the local equality especially self-contained.  The citation to the
already-audited Proposition 45.3 is mathematically sufficient.

**Audited revision before audit-metadata insertion (SHA-256):**
`aab4dbfa174f6997eaf73588cc993d35ac35a2c727552b44e6b5268f0bee535d`.
