# Augmentation width bounds actual indigenous defect

Version1,2026-09-11. Fresh focused mathematical audit PASS; exact
independent actual-group-algebra checks. Not Lean verification.

Let(C,r) be an active admissible pair over bar(F5), genus at least two,
with indigenous defect one. Let T->C be an actual connected finite etale
Galois cover with finite five-group P. Put R=k[P], J=rad(R), and

    h_i=dim_k J^i/J^(i+1), width_2(P)=max_(i>=0)(h_i+h_(i+1)).

The actual linearized Hodge cokernel has a scalar presentation

    coker(Psi_T)=R/(R f), f in J^2,

and consequently

    defect(T)>=width_2(P).

No commutativity, simple-zero Fitting assumption or ordinary Jacobian
is required. Every further actual finite etale cover of T retains the
same lower bound by injective pullback of defect sections.

For q=5^a>1 the following bounds result:

| Actual Galois group | Defect lower bound |
| --- | --- |
| C_q | 2 |
| (C_q)^2 | 2q-1 |
| (C_q)^3 | (3q^2-1)/2 |
| Exponent-five Heisenberg group of order125 | 25 |

If P has the displayed Heisenberg quotient, the last lower bound applies
through that actual intermediate. This does not assert that every
nonabelian five-group has such a quotient. A quotient of the closure
group of a NON-GALOIS source is not enough unless that source actually
dominates the quotient curve.

The proof obtains f in J^2 from actual cyclic-cover specialization and
the alternating defect-bundle pairing, not from an arbitrary matrix
model. It gives a lower bound, not an exact Heisenberg defect or a
common-cover exclusion.

[Proof](../Solutions/Sol_augmentation_width_defect.md) ·
[Audit](../Research/audits/AUGMENTATION_WIDTH_DEFECT_AUDIT_2026_09_11.md).
