# Audit: Frobenius equivariance does not force families preservation

**Verdict:** **PASS.** No breaking mathematical objection found.

**Auditor and date:** `/root/x_elliptic_quotient_maps`, 2026-09-04.

## Checks performed

- The generalized families-preserving condition used in the note agrees
  with Definition 2.7 of Minamide--Sawada--Tsujimura: for every closed
  procyclic \(I\subseteq H\), its image must be \(G\)-conjugate to \(I\).
  The relevant source is
  [arXiv:2608.01417](https://arxiv.org/abs/2608.01417).
- The closed-subgroup space of a profinite group is compact Hausdorff, and
  both an isomorphism-induced map and the conjugation action are continuous.
  Given a convergent net of subgroups satisfying the conjugacy condition,
  compactness of \(G\) supplies a convergent subnet of conjugators. This
  proves Lemma 64.1 as a statement relative to the subspace of procyclic
  subgroups; it does not require that subspace itself to be asserted compact.
- The finitely many stacky inertia classes give a finite union of compact
  conjugacy orbits. Every member is finite of order dividing 31. An open
  triangle-stack subgroup contains a torsion-free smooth-curve subgroup and
  hence an infinite procyclic subgroup, for example one detected in an
  \(\ell\)-adic abelian quotient. The inertia union is therefore a proper
  closed subset and is not dense.
- For a closed point \(t\) of a smooth proper curve over \(\mathbf F_q\),
  etaleness removes geometric inertia, so
  \(D_t\simeq\operatorname{Gal}(\overline{\mathbf F}_q/
  \mathbf F_{q^{\deg t}})\simeq\widehat{\mathbf Z}\). Its map to the
  arithmetic constant-field group is multiplication by \(\deg t\), hence
  injective. Thus
  \(D_t\cap\pi_1(T_{\overline{\mathbf F}_q})=1\), and Chebotarev
  decomposition groups do not supply the geometric procyclic subgroups in
  the families condition.
- The prime-to-five genus-two surface group surjects onto \(S_3\): sending
  the two \(a\)-generators to a transposition and a three-cycle and the
  \(b\)-generators to identity satisfies the surface relation and generates
  \(S_3\). The resulting connected etale Galois cover and its full finite
  group action descend after a finite extension of constants.
- For \(A=\langle(12)\rangle\), \(\gamma=(123)\),
  \(X=C/A\), \(u:C\to X\), and \(v=u\gamma\), both maps are genuinely
  algebraic finite etale maps of degree two over the chosen finite field.
  Riemann--Hurwitz gives \(g(C)=7\) and \(g(X)=4\).
- With compatible basepoints and paths, the two covers define the same
  arithmetic open subgroup \(U\), and
  \(\widetilde\alpha=u_*\gamma_*u_*^{-1}\). Since the full \(S_3\)-action
  is defined over the finite field, \(\gamma_*\) induces identity on the
  constant-field quotient. Hence \(\widetilde\alpha\) is an exact
  arithmetic automorphism over \(\Gamma_{k_0}\). On the geometric kernel
  this says precisely that its outer class commutes with Frobenius; a
  representative-level equality retains the expected inner path ambiguity.
- Geometrically, if \(P=\pi_1(B)\) and \(R=\pi_1(C)\), then
  \(R\triangleleft P\), \(P/R\simeq S_3\), and the subgroup
  \(G=\pi_1(X)\) satisfies \(G/R\simeq A\). The deck action on
  \(V=H_1^{\mathrm{et}}(C,\mathbf Z_{31})\) is therefore exactly the
  finite quotient action needed after inner conjugations by \(R\) vanish.
- The action of \(\operatorname{Aut}(C)\) on
  \(H^1_{\mathrm{et}}(C,\mathbf Q_{31})\) is faithful: if a nonidentity
  automorphism acted trivially, its graph would have intersection
  \(2-2g(C)<0\) with the diagonal, impossible for two distinct effective
  curves. Every deck transformation also fixes the nonzero pullback of
  \(H^1(B,\mathbf Q_{31})\), whose injectivity follows because
  trace after pullback is multiplication by six. Consequently no
  nonidentity element of \(S_3\) acts as a scalar.
- Both \(\gamma\) and \(a^{-1}\gamma\) are nonidentity. Their actions have
  order dividing six, and \(\mu_6\subset\mathbf Q_{31}\), so they are
  diagonalizable and their projective eigenvectors form a finite union of
  proper rational linear subspaces. A primitive lattice vector \(w\)
  exists outside this union and lifts to some \(h\in R\).
- For \(I=\overline{\langle h\rangle}\), an assumed equality
  \(\alpha(I)=gIg^{-1}\) descends in the \(31\)-adic abelianization to
  \[
  \mathbf Z_{31}\rho(\gamma)w
    =\mathbf Z_{31}\rho(\bar g)w,\qquad \bar g\in\{1,a\}.
  \]
  The vectors are primitive, so equality forces \(w\) to be a projective
  eigenvector of \(\rho(\bar g^{-1}\gamma)\), contradicting its choice.
  This proves ambient nonconjugacy for a genuine closed procyclic subgroup.
  Inner changes caused by basepoints disappear in the abelianization, and
  independent ambient conjugations do not change the yes/no families
  property.
- The newly added Corollary 64.3 is also valid. The cofinal pro-\(31\)
  quotient argument of file 52 applies with fewer complications to the full
  geometric fundamental group of a smooth proper curve, so a
  families-preserving isomorphism between its open subgroups is ambient
  inner. If \(\sigma_*^{-1}\alpha\) were families preserving, that inner
  factor can be absorbed into the path representative of \(\sigma_*\).
  Preservation of \(R\) then lifts \(\sigma\) to an automorphism
  \(\widetilde\sigma\) of \(C\). Its outer action equals that of \(\gamma\);
  faithfulness of the automorphism action on \(H^1\) forces
  \(\widetilde\sigma=\gamma\). The resulting equality
  \(u\gamma=\sigma u\) would identify the deck groups
  \(\gamma^{-1}A\gamma\) and \(A\), contradicting
  \(\gamma\notin N_{S_3}(A)\).

## Non-breaking suggestions and objections

- “Automatically controlled” in the inertia paragraph should be read as
  “explicitly supplied by the correspondence.” Algebraicity identifies the
  two images of each source stabilizer, but it does not by itself prove that
  target inertia at two different stacky points is \(G\)-conjugate. The
  asserted nondensity is correct either way.
- It would help to state that compatible source and target paths have been
  chosen when writing the literal equality
  \(v_*(\Pi_C)=u_*(\Pi_C)\). Other choices give conjugate open subgroups and
  independent inner factors, under which failure of families preservation
  is invariant.
- When relating \(G/R=A\) to the deck action on \(V\), a sentence fixing
  the standard quotient/deck-action convention would remove a possible
  left-versus-right notation question. The proof itself uses one convention
  consistently, and any inner discrepancy disappears on \(V\).
- Equation (64.3) relies on the curve being proper and the covers etale. For
  an affine curve or an orbifold point an inertia kernel would be present;
  the note correctly states the claim only for a smooth proper curve.
- Corollary 64.3 invokes the smooth-curve specialization of file 52 rather
  than restating it. A short standalone lemma would make the stronger
  normalized claim independently readable, but the cited cofinal-quotient
  proof does specialize exactly as asserted.

**Audited revision SHA-256:**
`b6705e19a24b679a69b233953c1a0d3b39b8b27b2053e32187478cbf84a662ec`.
