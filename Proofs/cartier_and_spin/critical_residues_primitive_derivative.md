# Preparation with the actual derivative degree

30 September2026, version2.
[Statement](../../Theorems/cartier_and_spin/critical_residues_primitive_derivative.md).
This is the complete local transfer argument. The actual derivative
degree replaces a prime-to-characteristic cluster-size condition.

Prepare F=UP and F'=VQ. Here U,V are units of R[[W]], and P,Q are
monic distinguished polynomials of degrees m,n respectively. If n=0,
take Q=1. The hypotheses that both reductions are nonzero justify both
preparations, even if the characteristic divides m. Since phi is a
unit, Omega=J/(PQ) dW for J in R[[W]]. Division by the distinguished
polynomial PQ gives a remainder J0 in R[W] of degree less than m+n.
The discarded regular power series contributes no residue inside the
disc. The sum of all residues of J0/(PQ) dW equals the coefficient
of W^(m+n-1) in J0, hence lies in R. This holds also at multiple poles:
the residue theorem does not require simple critical roots.

At each simple source root rho, coefficient differentiation of
F(rho)=0 gives delta F(rho)=-F'(rho)delta rho. Therefore
\[
\operatorname{Res}_{W=\rho}\Omega
=-f(\rho)(\delta\rho)^2/\phi(\rho)\in R.
\]
The source and critical roots are disjoint over the fraction field,
since the source polynomial has distinct roots. Subtracting the sum
of these integral source residues from the total residue proves the
claim. At a simple critical root c, F''(c)=phi(c)S''(c), and
\[
\Lambda-\lambda=-F/\phi^2,\qquad
\delta\Lambda=-(\phi\delta F-2F\delta\phi)/\phi^3.
\]
Its residue is therefore
\[
-\frac{f(c)(\phi\delta F-2F\delta\phi)^2(c)}
 {\phi(c)^3F(c)F''(c)}
=\frac{f(c)(\delta\Lambda(c))^2}
 {S''(c)(\Lambda(c)-\lambda)}.
\]
At multiple critical roots the original formal residue is retained.
All critical roots in the disc are included; none is discarded because
its multiplicity differs from m-1. The calculation may be done over a
splitting extension of Frac(R); the summed residue descends to R.

If the characteristic does not divide m, differentiating the leading
term of bar F gives n=m-1. Thus the tame-cluster specialization and
its actual-source application are corollaries, not separate inputs.
In the degree140 application, finite nonzero actual critical fibres
have unit phi, split source clusters of size two or three and a
generically separable critical quadratic. Substituting S''=-2 eta
gives, up to a nonzero constant, the integral critical trace of
f(delta_0 Lambda)^2/(eta(Lambda-lambda)). Multiplication by the
regular base form omega_0 has zero residue, proving actual-scale
vanishing. This local statement does not supply the separate global
polynomiality or pole-degree bound of divided traces. A short source
coordinate with pole four is not an affine-regular multiplier; the
original regular coordinate has pole seventeen.

This identifies the genuine local obstruction to transfer: derivative
content, not the numerical cluster size. In a larger admissible-degree
family, primitivity of the derivative can replace a classification of
all tame cluster sizes for this step. Endpoint poles, derivative-content
components and global trace degree bounds still require separate work.
No numerical replay or finite search is used here.
