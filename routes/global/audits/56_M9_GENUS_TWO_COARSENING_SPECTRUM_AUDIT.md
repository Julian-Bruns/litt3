# Audit: genus-two degree-nine coarsening spectrum

**Verdict:** **PASS.**  No breaking mathematical objection found.

**Auditor and date:** `/root/audit_m9_genus2_spectrum`, 2026-09-04.

## Checks performed

- By the CM-factor decomposition from file 53, Rosati self-adjointness puts
  $u=c_*\delta^*c^*$ in $\mathbf Q^3$.  Its rational coordinates are
  algebraic integers, hence integers.  The positive semidefinite identities
  $9\pm u=c_*(1\pm\delta^*)c^*$ give $-9\leq\lambda_i\leq9$.
- For $h=q_*c^*$, the identity $h^\dagger h=9+u$ and
  $\dim H^1(B)=4$ show that at least one coordinate is $-9$.  The 32
  tame fixed points of the double-cover involution contribute transversely
  to $Z\cdot\Delta_X=18-2\sum_i\lambda_i$, while proper intersection
  with the hyperelliptic graph gives $18+2\sum_i\lambda_i\geq0$.
  Thus, in the non-hyperelliptic case,
  $-9\leq\sum_i\lambda_i\leq-7$, exactly as claimed.
- If $Z=e\Gamma$, the two factorizations of the etale map $c$ through
  the normalization of $\Gamma$ are etale.  Consequently
  $e\mid9$, $g(\widetilde\Gamma)=1+18/e$, and the actual
  correspondence $u/e$ forces $e\mid\lambda_i$.  The intersection and
  adjunction calculation gives
  $p_a(\Gamma)=1+(81-\sum_i\lambda_i^2)/e^2+36/e$, so
  $\sum_i\lambda_i^2\leq81+18e$.  The case $e=9$ is a graph and is
  excluded by the automorphism computation of file 53; hence $e=1$ or
  $3$.
- With the killed coordinate first, the preceding bounds reduce to
  $a+b\in\{0,1,2\}$, $a^2+b^2\leq18e$, and $e\mid a,b$.
  Direct integral enumeration yields precisely the three $e=1$ families
  and the three $e=3$ triples displayed in (56.8).  In every listed case
  the other two coordinates exceed $-9$, so $h$ has cohomological rank
  four.  It is therefore surjective onto $J(B)$, and its two nonzero,
  pairwise nonisogenous elliptic-factor restrictions give the stated
  isogeny type.
- In the hyperelliptic-graph case, $x\circ c$ descends through $q$ to
  a degree-nine $r:B\to\mathbf P^1$.  Normalizing the pullback of the
  tame double cover shows that etaleness of $c$ permits no ramification
  away from the eight branch values and only indices one or two above them.
  The 32 index-one points are precisely the fixed points of $\delta$;
  degree in the eight fibers gives $\sum a_s=32$ and
  $\sum b_s=20$, agreeing with Riemann--Hurwitz for the genus-two,
  degree-nine map.

**Non-breaking presentation suggestion:** In Lemma 56.2, explicitly name
the local diagonal-coordinate calculation (or the projection formula) after
the fixed-point count.  This would make clear that the lower bound on
$Z\cdot\Delta_X$ remains valid when image branches coincide.

**Audited revision before audit-metadata insertion (SHA-256):**
`43ff991243e224129fd5706b3b11770009f1ff5aa2a9a278477e2137bce28d64`.
