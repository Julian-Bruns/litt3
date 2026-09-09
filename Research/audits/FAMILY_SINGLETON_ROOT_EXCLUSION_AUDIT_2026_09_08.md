# Family singleton root exclusion — bounded geometric audit

- Verdict: PASS (prose proof; not Lean verification).
- Auditor: /root/audit_family_singleton_medium, fresh bounded medium audit.
- Date: 2026-09-08.
- Target: [family_singleton_root_exclusion v1](../../Theorems/Thm_family_singleton_root_exclusion.md), with its [proof](../../Solutions/Sol_family_singleton_root_exclusion.md).
- Scope: geometric argument and immediate prerequisite sections: whole-family Raynaud support, connectedness, forced points, and actual prime-to-five root correspondence. The twelve exact polynomial identities were inspected as certificate statements and accepted with the root's independent exact PASS replay; no computation was repeated.

No blocking objection found. Relative Cartier sends eta to
(c4+c9*z)eta1 and u*eta to (c3+c8*z)eta1: these are the pullbacks
under V with the displayed Frobenius-twisted target coordinates, without
coefficient fifth roots. Evaluation at z=t gives the required tangent
line (1,t), so no matrix-transpose correction is needed.

At the two nonzero kernel points the distinct abscissas make the
degree-two Abel coordinates formally invertible. Moving the branch
point changes S and P only to order delta squared. The displayed
restriction and w-derivative identities therefore give exactly
q in (delta squared, delta*xi squared, xi fourth). Tangency makes the
two distinguished pullbacks vanish to order at least four. Global
support equality extends across every removed boundary because its
irreducible curves contain zero, where neither divisor vanishes.

The connected degree-25 torsor and polarized degree calculation give
total quadric degree 160. The distinct forced points contribute
132 + 20 + 8 = 160, so all bounds are equalities and there is no
remaining zero. This uses no Raynaud multiplicity identification.
Every required nonzero factor follows from t^5-t != 0, including
the branch separation t != t^5; the argument holds at every stated
specialization.

Non-breaking clarification: the prerequisite theorem states its
root equivalence over the algebraic closure of a finite field, whereas
this theorem allows any algebraically closed field. Its actual proof
works unchanged for the prime-to-five torsion points used here: V is
an isomorphism on prime-to-five torsion, and the Cartier eigenspace
identification is on an actual etale torsor. Section 6 should state
this field-independent extension explicitly; it never requires every
Jacobian point to be torsion.

The verdict excludes singleton Cartier-zero profiles only. It does
not exclude larger clumps, establish clump existence, or solve the
same-source two-map common-cover problem.
