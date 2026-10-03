# A free Levi forces an exact restricted half-class and kernel cohomology

Version1, 3 October2026. The
[actual parity audit](../../../Research/notes/oct03_ten_hour/eight_module_actual_free_levi_halfclass_parity_audit.md)
and [kernel-cohomology audit](../../../Research/notes/oct03_ten_hour/eight_module_actual_kernel_cohomology_dichotomy_audit.md)
are **PASS**. Fresh [canonical fidelity audit](../../../Research/notes/oct03_ten_hour/eight_module_free_levi_halfclass_canonical_fidelity_audit.md): **PASS**; original audit snapshots are preserved.

Retain the ACTUAL \(D,Q,H,W,P\), SAME-action \(P^4=\omega_D\),
and calibrated primitive-eight tame lift of the
[natural-root flag theorem](actual_psl_eight_root_frobenius_flags_and_wild_constraints.md).
Specify wild type \(J_5\oplus J_3\) or \(J_4\oplus J_4\).
Embed \(S=SL_7(\mathbf F_5)\subset Q\) by
\(A\mapsto[\operatorname{diag}(A,1)]\).

1. The subgroup \(S\) acts FREE on \(D\). On the actual étale
   quotient \(Z=D/S\), the specified lift \(S\subset H\) makes
   \(P\) descend genuinely to \(\bar P\), with
\[
\boxed{\bar P^4=\omega_Z,\qquad
       \deg\bar P=12207\cdot5^6\text{ ODD},\qquad
       g(Z)\equiv3\pmod4.}
\]

2. Retain ANY actual finite étale \(N\)-quotient
   \(\pi:\Gamma\to D\) coming from
   \(1\to N\to G\to Q\to1\), and an ACTUAL \(G\)-invariant line
   \(M\) with the specified SAME-action \(M^2=\pi^*P\).
   Put \(\widetilde S=G^{-1}(S)\) and
   \(\beta=\operatorname{ob}_G(M)\).
   The group \(\widetilde S\) acts freely on \(\Gamma\), with quotient
   \(Z\), and
\[
\boxed{\operatorname{res}_{\widetilde S}\beta
       \text{ has EXACT order TWO}.}
\]
   No split, abelian or two-group hypothesis on \(N\) is required.

3. Write \(N^\vee=\operatorname{Hom}(N,k^\times)\), with its
   well-defined conjugation action of \(S\). There is an exact
   actual-kernel restriction:
\[
\boxed{\operatorname{res}_N\beta\ne0
       \quad\hbox{or}\quad H^1(S,N^\vee)[2]\ne0.}
\]
   In the first alternative the restricted class has order TWO.
   If it is zero, the restricted half-class injects as an exact-order-two
   class in the displayed first cohomology group.
   Here \([2]\) denotes two-torsion of COHOMOLOGY; no replacement
   by \(H^1(S,N^\vee[2])\) is asserted.
   For elementary abelian two-kernel \(N\), the alternatives are a
   nonzero \(S\)-invariant alternating form on \(N\), or
   \(H^1(S,N^*)\ne0\). No form on the original module \(W\) follows.

4. For ANY underlying actual square root \(R^2=P\) on \(D\), put
\[
U=\langle gR-R:g\in Q\rangle_{\mathbf F_2}
       \subset\operatorname{Pic}^0(D)[2],\qquad
\delta_g=gR-R.
\]
   No such \(R\) is \(S\)-invariant as a line class, and
\[
\boxed{\operatorname{res}_S^Q[\delta]\ne0
       \text{ in }H^1(S,U).}
\]
   This strengthens mere nonvanishing of global root-orbit cohomology.
   In the actual canonical Kummer construction with \(N=U^*\) and
   \(M=\pi^*R\), the first alternative of assertion3 is zero by
   natural deck linearization, and the second is compulsory.
   Identifying this \(U\) with an arbitrary original kernel requires
   additional proof.

These are necessary ACTUAL curve/Picard/source restrictions.
They do not assert that the registered abstract extension fails them,
construct either surviving weak curve sector, or infer source or
endpoint descent. An original-source application retains its exact
kernel quotient and line comparison. BOTH original finite étale maps
stay on their SAME original \(T\).

[Proof](../../../Proofs/quotient_geometry/local_actions/actual_psl_eight_free_levi_half_class_and_kernel_cohomology.md).
