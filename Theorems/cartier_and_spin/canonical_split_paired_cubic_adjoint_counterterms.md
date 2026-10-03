# Both actual split cubics have the same integral adjoint error bundle

Version1, 3 October2026. [Fresh independent whole audit PASS](../../Research/audits/CANONICAL_SPLIT_PAIRED_CUBIC_ADJOINT_COUNTERTERMS_AUDIT_2026_10_03.md), with no required corrections. No computation is used.

Let k be algebraically closed of characteristic5. Retain the fixed genus-nine endpoint X:y³=P(x), with P monic squarefree of degree10, its unique infinity O, θ=dx/y² of divisor16O, and q₀(x)=(x+1)²+d, d≠0. Let h₁,h₂:C₀→X be TWO actual finite étale maps of the same degree r from the SAME smooth projective curve. Their reduced infinity divisors H₁,H₂ are disjoint. Retain the actual split index-one hypotheses
\[
k(C₀)=k(t,x₁,x₂),\quad q₀(x₂)=t⁶q₀(x₁),\quad
\operatorname{div}(t)=H₁-H₂,\quad θ₁=κt^{16}θ₂,
\quad κ\in k^\times.
\]
Here xᵢ,yᵢ,θᵢ are the actual pullbacks, including BOTH cubic identities yᵢ³=P(xᵢ).

On the actual conic surface S:u²−v²=d(t⁶−1), with u=x₂+1,v=t³(x₁+1), let C be the integral image of C₀ and ν:C₀→C its normalization. Write D=D₊+D₋ for the disjoint boundary sections, F₀,F∞ for the indicated base fibers, F for their linear class, and L=D+3F. The actual differential supplies the effective conductor-adjoint R=C−6L, with section ρ and ν*R=Δ, the conductor divisor. It supplies BOTH sections
\[
a,b\in H⁰(S,O_S(3D+10F_\infty+R)),\qquad
a|C=\rho y₂,\quad b|C=t^{10}\rho y₁.
\]
The comparisons use compatible rational representatives of these line-bundle sections, with the canonical boundary section trivializing D|C. Let Q be a compatible defining section of C, and define
\[
\mathcal D(t)=v,\quad \mathcal D(u)=0,\quad
\mathcal D(v)=-3dt⁵,
\]
\[
E(t)=-tu,\quad E(u)=-3(v²+dt⁶),\quad E(v)=-3uv.
\]
There are nonzero constants λ₂,λ₁ with λ₁=−κλ₂ such that
\[
\mathcal DQ=\lambda₂a²/\rho,\qquad EQ=\lambda₁b²/\rho
\quad\text{on the actual }C.
\]
For γᵢ=3/λᵢ, so γ₁=−κ⁻¹γ₂, there are GLOBAL regular sections
\[
\varepsilon₁,\varepsilon₂\in H⁰(S,O_S(C-8L))
\]
satisfying the paired integral identities
\[
a³-P(u-1)\rho³
=\gamma₂Q(\rho\mathcal Da-a\mathcal D\rho)+Q²\varepsilon₂,
\]
\[
b³-t^{30}P(v/t³-1)\rho³
=\gamma₁Q(\rho Eb-bE\rho)+Q²\varepsilon₁.
\]
Both identities are identities of global sections of10D+30F∞+3R. The Wronskians are global sections of4D+12F∞+2R. In particular the transverse infinity component of E introduces no extra fiber pole: the relative weight10 is zero under differentiation in characteristic5.

The following consequences hold.

1. If r≤15, BOTH errors vanish. This conclusion needs no generic-fiber interpolation.
2. If r=16, a nonzero error is possible only when C is LINEARLY8L. In that class the errors are scalars. The equality class has six blowup coefficients all8, C²=384,pₐ(C)=177,g(C₀)=129,δ=48,R=2L and degΔ=96. If C is not linearly8L, both whole identities still hold without errors.
3. In any degree a nonzero error forces δ≥3r, where δ=pₐ(C)−g(C₀). At r=17, the effective divisor of a nonzero error is either a nonboundary section disjoint from D±, with no vertical component, or one boundary section plus components of the six reducible fibers meeting that same boundary, with total boundary intersection3. It contains no smooth whole fiber.
4. Whenever both errors vanish, let Z be a multiplicity-one irreducible component of R, neither a boundary section nor F₀ or F∞. If a|Z and b|Z are nonzero at its generic point, then the induced coordinate differentials on its normalization are nonzero and
\[
\frac{dx₂}{dx₁}=κ^{-1}(t²a/b)²\quad\text{in }k(Z).
\]
The same conclusion applies to a horizontal component, in particular. A component of R of multiplicity at least2 away from the boundary and F∞ necessarily has a and b identically zero there. Components where either extension vanishes remain outside the derivative-square cancellation.

All sections and residues are supplied by the two ACTUAL cubic endpoint maps on their SAME source. The component Z is auxiliary, and no map Z→X is asserted. These necessary identities do not exclude the remaining split degree-fifteen source, higher degrees, common infinity, nonsplit comparisons or the unmarked common-cover problem.

[Proof](../../Proofs/cartier_and_spin/canonical_split_paired_cubic_adjoint_counterterms.md). [Exploratory conductor geometry](../../Research/notes/oct03_ten_hour/split_second_cubic_conductor_gauss.md).
