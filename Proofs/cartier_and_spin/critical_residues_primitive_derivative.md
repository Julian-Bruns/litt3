# Preparation with the actual derivative degree

30 September2026.
[Statement](../../Theorems/cartier_and_spin/critical_residues_primitive_derivative.md).
Only one step of the earlier source-root argument needs modification.
The assumption that the cluster size m is a unit was used to identify
the Weierstrass degree of F' as m-1. Its actual degree is sufficient.

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
claim. Computing the residue at a simple critical root gives the
displayed divided-critical-value expression exactly as in the earlier
lemma. All critical roots in the disc are retained; none is discarded
because its multiplicity differs from m-1.

This identifies the genuine local obstruction to transfer: derivative
content, not the numerical cluster size. In a larger admissible-degree
family, primitivity of the derivative can replace a classification of
all tame cluster sizes for this step. Endpoint poles, derivative-content
components and global trace degree bounds still require separate work.
No numerical replay or finite search is used here.
