# Audit: section-neutral Galois spin covers

Verdict: PASS.
Auditor: /root/audit_spin_neutral_group, fresh bounded independent audit.
Date: 2026-09-08.
Scope: version1 of [spin_section_neutral_galois_groups](../../Theorems/Thm_spin_section_neutral_galois_groups.md)
and its [proof](../../Solutions/Sol_spin_section_neutral_galois_groups.md).
This is a prose audit, not formal verification. No computation was used.

The following substantive steps check out:

- Etaleness identifies the dual complementary canonical line with the
  pulled-back spin. Serre-dual trace on the entire section space is
  multiplication by the degree, since every section is pulled back.
  Thus pullback on H1 is zero when p divides the degree and invertible
  otherwise; both spaces have dimension r.
- Additive A-torsor descent identifies the kernel with H1(G,E), where
  E is the full upstairs section space. Its canonical deck action is
  trivial, so this is Hom(G,E_add), of k-dimension
  r times dim_Fp Hom(G,Fp). This argument does not average by the degree.
- Every intermediate curve retains the same section space and a genuine
  spin. Applying the argument to T -> T/H establishes the rank claim
  for every subgroup H, not merely normal subgroups.
- The unique kernel of a nonzero homomorphism to Fp is characteristic.
  Iterating within these characteristic subgroups produces a
  characteristic prime-to-p subgroup N. The p-group G/N has Frattini
  quotient of rank one, hence is cyclic, as the proof also shows directly.
- The uniqueness of the degree-p intermediate cover includes potentially
  nonnormal subgroups: if [G:H]=p, normality of N gives
  [N:N intersect H]=[NH:H] dividing p. Since |N| is prime to p, this
  index is one. Thus H contains N and is the inverse image of the unique
  index-p subgroup of the cyclic quotient.
- Primitive boundaries live on the Frobenius twist. Applying the same
  H1 conclusion to the twisted cover and spin is legitimate over the
  algebraically closed, hence perfect, base field. Naturality of the
  primitive exact sequence gives the claimed vanishing or injectivity.
- For the stated application, the previously audited probe theorem
  supplies actual endpoint containment and section descent. A finite
  Galois extension remains Galois over any intermediate field, so the
  discarded T_n -> S_n maps have the required Galois property. This says
  nothing analogous about the entire closure group over an endpoint.

Objections: none. No statement changes or proof repairs are required.
The prior probe and eight-step theorems were used as audited inputs and
were not re-audited. The original common-cover problem remains unsolved.
