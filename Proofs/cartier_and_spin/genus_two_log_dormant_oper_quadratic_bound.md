# Proof: the scalar restricted-derivative equation and its quadratic bound

Version1,3 October2026. [Statement](../../Theorems/cartier_and_spin/genus_two_log_dormant_oper_quadratic_bound.md). Pending independent review. Use the genuine log-oper lattice, radius, injectivity and primary finiteness input in [the preceding theorem](genus_two_cartier_cubic_log_dormant_oper.md). No numerical calculation is needed.

## The intrinsic restricted-derivative coefficient

In characteristic FIVE the fifth iterate of a field derivation is again a derivation. The space of k-derivations of k(Y) is one-dimensional over k(Y), so ∂⁵=H∂ for a unique rational H. Commutation of ∂ and ∂⁵ gives (∂H)∂=0, hence ∂H=0. The kernel of ∂ is k(Y)⁵, so H lies in that field. No guessed Cartier normalization of H is required.

## Exact dormancy in the companion normal form

The scalar horizontal equation is ∂²F=EF. In its rank-two differential module reduce ∂⁵F repeatedly using this equation. Straight symbolic differentiation gives
\[
\partial^5F=(4E\partial E+\partial^3E)F
+(E^2+3\partial^2E)\partial F.
\]
Thus the central restricted operator ∂⁵−H∂ has remainder
\[
(4E\partial E+\partial^3E)
+(E^2+3\partial^2E-H)\partial
\]
modulo the scalar companion equation. The two companion generators are independent, so zero p-curvature is equivalent to both remainder coefficients vanishing. If E²+3∂²E=H, then ∂²E=3E²+2H; differentiating and using ∂H=0 gives ∂³E=E∂E, so the first coefficient automatically vanishes. Conversely its second coefficient is indispensable. This proves the single displayed identity is equivalent to generic dormancy. The actual logarithmic connection extends across P, so generic zero p-curvature is zero everywhere.

For clarity, this calculation applies to every E∈L(5P), not only to coefficients already supplied with a horizontal solution F. The restricted operator is central because its commutator with any rational function is ∂⁵(f)−H∂(f)=0, and its commutator with ∂ is zero. Killing the companion generator therefore kills the entire differential module. Passing between the scalar companion module and the projective connection preserves the zero p-curvature assertion; its trace is zero generically, and TWO is invertible, so projective zero p-curvature cannot retain a nonzero scalar p-curvature.

## The effective bound controls E alone

The space L(5P) is four-dimensional, with basis1,z,z²,y. Since ∂ and H are fixed, ∂²E is linear in its four coefficients, E² is quadratic and H is constant with respect to those parameters. Clearing fixed rational denominators and comparing the invariant/y sectors therefore gives an affine scheme defined by degree≤2 equations in FOUR variables.

Every point of this scheme is a genuine dormant logarithmic PGL2-oper of the fixed radius. The primary pointed finiteness theorem, together with the coefficient injectivity proved previously, makes this scheme zero-dimensional: a positive-dimensional finite-type scheme over k would have infinitely many geometric points. The affine isolated-point Bézout bound for equations of degree≤2 in four variables is2⁴=16, giving the asserted bound on distinct E. No reducedness, generic count or rank-uniform common-source conclusion is needed.

The horizontal solution space of each fixed dormant system can still contain a pencil. The bound therefore supplies a finite oper coefficient search for the actual large-wild reduction; it does not substitute an oper for either original étale endpoint map or prove a carrier exclusion.
