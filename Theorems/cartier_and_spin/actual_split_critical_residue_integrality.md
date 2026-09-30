# Critical residue integrality from an actual split source

Version1,30 September2026. Let R=k[[r]] in characteristic p, let
delta be a k-derivation preserving R, and extend delta to coefficients
with delta(W)=0. Fix lambda in k. In a formal W-neighbourhood suppose
\[
F=\lambda\phi^2+\phi S+\tau,\qquad
\partial_W\phi=\partial_W\tau=0,\qquad \phi\in R[[W]]^\times.
\]
Assume the reduction of F has a zero of multiplicity m at W=0,
with p not dividing m. Suppose its m roots in this formal cluster are
distinct elements of rR, and its m-1 critical roots are generically
distinct. Put Lambda=-(phi*S+tau)/phi^2. Then for every f in R[[W]],
\[
\sum_{c:\,S'(c)=0,\ c\text{ in the cluster}}
\frac{f(c)(\delta\Lambda(c))^2}
     {S''(c)(\Lambda(c)-\lambda)}\ \in R.
\]
The sum includes all conjugate critical roots, equivalently the trace
of the critical algebra over Frac(R). Here delta(Lambda) is coefficient
differentiation; it agrees with the induced differentiation of the
critical value because partial_W(Lambda)=0 on the critical locus.

Consequently, multiplying the displayed sum by any regular base
differential has zero residue at r=0. For an actual finite etale source,
the required split integral source roots are supplied by its completed
local algebra. This assertion does not presume a simultaneous Galois
closure of two maps.

In the degree140 family S''=-2*eta. This gives a uniform proof of the
actual-scale vanishing of its inverse-eta traces, including all critical
collisions, and allows every multiplier integral on the local source.
It asserts no global pole-degree bound for a new multiplier.

[Proof](../../Proofs/cartier_and_spin/actual_split_critical_residue_integrality.md).
