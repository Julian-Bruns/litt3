# Split-source critical residues need no tame cluster-size assumption

Version2,30 September2026. Let R=k[[r]], with a k-derivation delta
preserving R. In R[[W]] let
\[
F=\lambda\phi^2+\phi S+\tau,\qquad
\partial_W\phi=\partial_W\tau=0,\qquad \phi\in R[[W]]^\times,
\]
where lambda belongs to k. Assume both F and F'=partial_W F have
nonzero reductions in k[[W]]. Write m=ord_W(bar F)>0 and
n=ord_W(overline{F'}), allowing n=0. Assume the m source roots in
the formal disc are distinct elements of rR.

For f in R[[W]], form
\[
\Omega=-\frac{f(\phi\delta F-2F\delta\phi)^2}
                  {\phi^3FF'}\,dW.
\]
The sum of all its critical-point residues in that disc is in R.
The critical roots may have higher multiplicity; their actual formal
residues, rather than a formula with a vanishing second derivative,
are used in that case. If they are generically simple, the sum is
\[
\sum_{c:S'(c)=0}
\frac{f(c)(\delta\Lambda(c))^2}
     {S''(c)(\Lambda(c)-\lambda)},\qquad
\Lambda=-(\phi S+\tau)/\phi^2.
\]
No condition that the characteristic is prime to m is needed.
When that condition does hold, n=m-1. The sum includes every
critical root in the disc, equivalently its base-field residue trace.
Coefficient differentiation of Lambda agrees with differentiation
of its critical value because partial_W Lambda=0 there.

Multiplying the integral sum by any regular base one-form gives
zero residue. For an actual finite etale source over an algebraically
closed residue field, its completed local algebra supplies the split
integral source roots; no simultaneous
Galois closure of two maps is presumed. In the degree140 family
S''=-2 eta. At its finite nonzero actual critical fibres the source
clusters have size two or three, phi is a unit and the critical
quadratic is generically separable. The displayed formula gives
actual-scale vanishing of the inverse-eta trace, including critical
collisions, for every multiplier integral in the source chart.

The nonzero reduction of F' is substantive. The statement does not
remove vertical derivative-content loci where every coefficient of
F' vanishes modulo r. It supplies local integrality, not a global
pole bound or another family exclusion.

[Proof](../../Proofs/cartier_and_spin/critical_residues_primitive_derivative.md).
