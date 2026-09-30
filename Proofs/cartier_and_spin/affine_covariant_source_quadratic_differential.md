# The affine correction is forced by one weighted residue

30 September2026.
[Statement](../../Theorems/cartier_and_spin/affine_covariant_source_quadratic_differential.md).
This is a symbolic continuation of the
[translation-invariant energies](split_source_energy_translation_invariance.md).
It requires no finite enumeration or numerical certificate.

Choose any nonzero derivation delta of K and extend it to the finite
separable algebra B. Write
\[
T_k=\operatorname{Tr}(w^k/\phi),\qquad
E_2=\operatorname{Tr}((\delta w)^2/\phi).
\]
The residue formula from the translation theorem gives T0=T1=T2=0:
for k<=2, the rational differential W^k*(dS/dW)/F dW has numerator
degree at most p-1, no residue at infinity, and no finite poles besides
the simple source roots. Likewise
\[
\operatorname{Tr}(w^2/\phi^2)=2\gamma/\tau.
\]
Indeed use W^2*(dS/dW)/(F*phi) dW. Its residue at infinity is zero.
At the unique geometric zero c of phi, its polar part is
W^2*(dS/dW)/(tau*(W-c)^p) dW. Its residue is the leading coefficient
(p-2)*gamma/tau=-2*gamma/tau. The sum of the source residues is the
opposite value. No inverse of gamma or of a critical discriminant
appears.

Differentiating T2=0 and using delta(phi(w))=delta(q) gives
\[
\operatorname{Tr}(w\delta w/\phi)=\gamma\delta q/\tau.
\]
The translation theorem already gives
Tr(delta(w)/phi)=0. Together these identities contain all cross terms
needed for an affine change.

Set w'=a w+b and phi'(w')=a^p phi(w). Expansion of
delta(w')=a delta(w)+(delta a)w+delta b gives
\[
E'_2=a^{2-p}E_2+
2a^{1-p}(\delta a)\gamma\delta q/\tau.
\]
All other terms vanish by T0=T1=T2=0 and the vanishing first energy.
On the other hand the transformed leading coefficient is gamma'=a^2
gamma, including when gamma=0, while delta(q')=a^p delta(q). Therefore
\[
\frac{\delta q'\delta\gamma'}{\tau'}=
a^{2-p}\frac{\delta q\delta\gamma}{\tau}
+2a^{1-p}(\delta a)\gamma\delta q/\tau.
\]
Subtracting proves the covariance. Multiplication by the square of the
one-form dual to delta expresses it intrinsically as the quadratic
differential in the statement, so the result does not depend on delta.

Local integrality under the stated unit hypotheses follows directly
from the split source expression and the correction term. If tau has
zeros, if source roots cease to be integral in the chosen frame, or if
phi has nonunit values, those poles must still be accounted for. In
particular one cannot infer a global negative-degree vanishing merely
by choosing a short source coordinate at infinity. The formula supplies
the precise change of frame for such an analysis, not that missing
regularity statement.
