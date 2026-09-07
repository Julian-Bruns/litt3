# Jet detection forces the universal Frobenius-extension tensor to be onto

Let C be a smooth projective curve over an algebraically closed field
of characteristic p>0, V a vector bundle, M a line bundle, and fix an
isomorphism j:K~=(F_C^*V)^vee tensor M. Put

    A=H0(V^vee M), B=H1(V^vee), H=H1(V^vee K).

For alpha in B, let D(alpha) in H1(K M^-1) be its dual Frobenius
extension class, using j. The coefficient tensor is

    T:A tensor B^[p] -> H,       (s,alpha^[p]) -> s^*D(alpha).

Here the Frobenius twist makes the displayed tensor k-linear. Suppose
the evaluation map H0(V^vee M)->(V^vee M)|_(pP) is onto for every
P in a dense open of C. Then T is surjective.

In the characteristic-five intrinsic atlas setup, V is stable of slope
g-1 and V^vee M~=V tensor omega. Consequently the hypothesis holds
whenever g-1>=5. Thus in every allowed genus g>=6, for EVERY normalized
rank-two candidate and EVERY cubic torsion choice, the intrinsic tensor
has full output rank12(g-1). It has no nonzero constant left annihilator.

This is a structural limitation of the small-test linear reduction, not
an atlas exclusion. In particular the genus-two constant-annihilator
mechanism cannot be extended to genus nine. No unperformed basis
comparison with the old scalar N/R implementation is asserted.

Independent audit PASS, `/root/cartier_jet_and_atlas_towers_audit`,
2026-09-07; no substantive objections.
[Audit metadata](../Research/audits/CARTIER_JETS_AND_ACYCLIC_TOWERS_AUDIT_2026_09_07.md)
is reference-only.
[Proof](../Solutions/Sol_cartier_jet_tensor_surjectivity.md).
