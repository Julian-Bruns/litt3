# Galois covers adding no spin sections have cyclic p-part

Let k be algebraically closed of odd characteristic p, and let q:T->C
be a connected finite etale Galois cover of smooth projective curves
of genus at least2, with group G. Let A be a spin line on C. Suppose

    r=h0(C,A)>0,  H0(C,A) -> H0(T,q^*A) is an isomorphism.

Then G has a characteristic normal subgroup N of order prime to p
such that G/N is cyclic of p-power order. Equivalently G has a normal
p-complement and cyclic Sylow p-subgroups. This is only a necessary
condition, not a sufficiency assertion for a geometric cover.

More precisely, for EVERY subgroup H<=G,

    dim_Fp Hom(H,Fp) = 0 if p does not divide |H|,
                     = 1 if p divides |H|.

If p divides |G|, there is a UNIQUE degree-p subcover U->C inside T,
and its pullback on H1(C,A) is the zero map. In particular every inherited
spin-Cartier section h in K(C,A) acquires a global regular primitive on U.
If p does not divide |G|, existence of such a primitive on T already
implies existence on C.

Thus a cover with a noncyclic Sylow p-subgroup, or a group divisible by p
having no cyclic p-quotient, MUST add spin sections whenever A is effective.
No ordinarity, degree bound, or birationality of a spin series is assumed.

Application: the discarded Galois maps T_n->S_n in
spin_probe_common_cover_reduction satisfy these hypotheses. Their
p-monodromy is therefore cyclic after removing a normal prime-to-p part.
This does not restrict the entire Galois closure group over X or Y to
that class and does not exclude the original common cover.

Version1,2026-09-08. Fresh medium audit PASS by
/root/audit_spin_neutral_group,2026-09-08; no objections or revisions.
Not Lean verified.
[Audit record](../../Research/audits/SPIN_SECTION_NEUTRAL_GALOIS_GROUPS_AUDIT_2026_09_08.md).
[Proof](../../Proofs/cartier_and_spin/spin_section_neutral_galois_groups.md).
