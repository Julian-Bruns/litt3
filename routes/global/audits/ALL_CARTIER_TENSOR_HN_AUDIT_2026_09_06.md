# All Cartier tensor-power HN polygons: independent audit

Date: 2026-09-06. Auditor: `/root/all_cartier_tensor_hn_major_audit`.

Verdict: **PASS; no breaking objection found.** Read the complete
`Solutions/Sol_all_tensor_cartier_hn.md` and the theorem
and proof of its differential-operator-model dependency. This is a
structural negative boundary for full-tensor HN invariants, not a
solution to Litt3.

The scalar trace splitting is valid because rank(B)=p-1 is invertible.
The Raynaud pairing gives B tensor B = omega1 tensor End(B), and the
projection formula then gives the actual direct sum (5), with exactly
I=F^*B and the stated twist. There is no replacement of a nonsplit
extension by its associated graded in this step.

The filtration of Q by order has higher weights -j as subbundles.
Likewise, F^*B identifies with the augmentation ideal of
O_C tensor_(O_C1) O_C, whose powers have quotients omega_C^i,
1<=i<=p-1. Consequently both filtrations have the same direction.
Local simultaneous adapted bases establish that their total tensor
filtration is by subbundles and has, at each weight k, a direct sum of
copies of omega_C^k. In particular, different tuples of the same total
weight do not introduce an unaccounted extension in this graded piece.

Finite Frobenius pushforward is exact; its pushforwards of these line
bundles are stable by [Sun, Theorem 2.2](https://arxiv.org/pdf/math/0611360).
The computed slopes increase strictly with k, so the descending-weight
filtration is HN. Taking the merged HN filtration of the two direct
summands, including equal-slope mergers, proves the recurrence.

The extremal weights and slope formulas are correct. At n=2, the
scalar component ties both extremes precisely for p=3. At n=3 its
slope 3 lies strictly between the extremes even for p=3. For n>=4,
the first-summand extremes lie strictly inside the second-summand
extremes, with normalized margin 2-4/p at each end. Thus no p=3
boundary case is omitted. Mixed tensors reduce to pure tensors by
B^dual = B tensor omega1^(-1), and normalization by g-1 gives the
claimed finite-etale invariance.

Independent exact-integer checks of the recurrence for
p=3,5,7,11,13,17,19,23 and 2<=n<=30 verified rank (p-1)^n, normalized
mean slope n, both extrema, and symmetry about slope n. These checks
support, but do not replace, the filtration argument.

Nonbreaking suggestions:

- Cite explicitly the standard semistability/stability theorem for B
  when introducing H_1=(p-1)z^p; the induction uses this base case.
- Explain the identification F^*B with the augmentation ideal using
  multiplication and its left-factor unit section. This makes the
  direction of the diagonal-ideal filtration immediately checkable.
- In the symmetric-power caution, mention the Frobenius twist
  identification when passing from relative F^*B to F_abs^*B on C1.
  The stated destabilizing-line degree is correct.
