# Complete-section fields commute with normal closure

Let f:Z->C be a finite separable map of smooth projective connected curves
over an algebraically closed field. Let A be a line bundle on C, and let
T->C be the normal closure of k(Z)/k(C), with its specified embedding.
Write q:T->C. Suppose ratios of sections of f^*A generate k(Z).

Then ratios of sections of q^*A generate k(T). If f^*A is globally
generated, so is q^*A. No degree, genus, or characteristic restriction
is needed, and neither projective normality nor a smooth section image
is assumed.

More generally, if T->C is Galois and the ratio field S of the complete
space H0(T,q^*A) contains k(C), then S/k(C) is Galois. Its kernel in
Gal(T/C) is the kernel of the projective action on the section space.

Application: whenever an endpoint-preserving complete-spin quotient
has been constructed, starting from that actual common source EVERY
subsequent alternating normal closure is again spin-birational and
base-point-free. Its Galois group over the endpoint used in that step
acts faithfully on the projectivized complete spin space. Both actual
etale legs and the original common section remain present. There is
no subsequent section-field kernel to remove in this restarted tower.
This does not give a simultaneous finite Galois closure or nonexistence.

Version1,2026-09-08. Author proof; elementary field argument, not audited
or Lean verified.
[Proof](../Solutions/Sol_normal_closure_section_field.md).
