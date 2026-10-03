# Proof: the forbidden weak A5 quotient

Version1. [Statement](../../Theorems/cartier_and_spin/canonical_degree_ten_no_a5_quotient.md). The complete scoped argument passed [root whole review](../../Research/audits/CANONICAL_TEN_AFFINE_AND_NORMAL_ABELLAN_AUDIT_2026_10_03.md). Both original endpoint maps remain unchanged upstairs.

## Every quotient of order greater than five retains both inertia groups

Let Q be ANY quotient of G, with |Q|>5, and let Γ_Q be the actual quotient target. Each original inertia group has PRIME order, so its image is either injective or trivial. If the wild inertia disappears, Γ_Q/P¹ is tame with at most ONE branch value. Hurwitz rules out a nontrivial such cover: with its only possible inertia TWO the right side is −3|Q|/2, and without any branch it is −2|Q|.

If the tame inertia disappears while the wild one remains, its actual completed extension is unchanged and Hurwitz gives
\[
2g(\Gamma_Q)-2=|Q|(-2+8/5)=-2|Q|/5.
\]
Since FIVE divides |Q|, the right side can be at least −2 only when |Q|=5, excluded here. Therefore BOTH inertia groups inject into Q. The kernel meets every point stabilizer trivially, so it acts freely on Γ and Γ→Γ_Q is ACTUALLY étale. Hurwitz gives
\[
2g(\Gamma_Q)-2=|Q|/10,
\qquad g(\Gamma_Q)=|Q|/20+1.
\]
Every prime-to-FIVE quotient of Q would be one of G. The accepted [no-prime-five quotient theorem](canonical_degree_ten_prime_to_five_quotients.md) rules it out. The two original source maps are retained upstairs; no map from Γ_Q to X is inferred.

## An actual A5 quotient has genus four

Suppose G surjects onto A₅, and take the ACTUAL quotient curve Ω of Γ. The preceding argument makes Γ→Ω étale and retains both completed local types.

Hurwitz now gives
\[
2g(\Omega)-2=60(-2+8/5+1/2)=6,
\qquad g(\Omega)=4.
\]
The same calculation starts the more general stated A₅-cover exclusion directly.

## Its Sylow-five quotient forces a hyperelliptic pencil

There are SIX Sylow-five subgroups in A₅. The wild fiber has TWELVE points, and each of its stabilizers is one such subgroup. Each Sylow-five subgroup therefore fixes exactly TWO points; transitivity and conjugacy give the equality, and there are no other fixed points because all other inertia has order TWO orONE. Its two local different exponents are EIGHT. For a fixed Sylow subgroup P₅, the quotient Z=Ω/P₅ satisfies
\[
6=5(2g(Z)-2)+2\cdot8,
\]
so Z=P¹.

The degree-FIVE cyclic cover Ω→Z is Artin–Schreier. After putting its two branch points at zero and infinity, conductor ONE at each gives a reduced equation
\[
u^5-u=ax+b/x,\qquad a,b\ne0.
\]
Here the standard Artin–Schreier reduction can be made GLOBALLY because Z=P¹: subtract fifth-power differences successively from the polynomial part and each principal part, leaving only simple poles; a constant is killed over the algebraically closed field. This argument does not assume such global reduction on a positive-genus quotient.

Viewed as a quadratic in x, the equation gives
\[
v^2=(u^5-u)^2-4ab,
\qquad v=2ax-(u^5-u).
\]
The right side has degree TEN and TEN simple roots: at a root u⁵−u is nonzero, and its derivative is −2(u⁵−u), hence a unit. Its pole at infinity has even order TEN, so infinity is unramified. Thus Ω is hyperelliptic of genus FOUR, with precisely TEN distinct branch points on P¹_u.

## A5 cannot preserve ten reduced points on a projective line

The hyperelliptic involution is unique and central in Aut(Ω). Therefore A₅ acts on the hyperelliptic pencil. Its kernel is contained in the order-TWO hyperelliptic deck group, and simplicity of A₅ makes the kernel trivial. We obtain a faithful A₅⊂PGL₂(k) preserving the TEN branch points.

For a finite subgroup of PGL₂ fixing a point, put that point at infinity. Its elements are affine maps x↦cx+d. The kernel of the multiplier map is a group of translations and has exponent FIVE. Hence any point stabilizer of order prime to FIVE is CYCLIC. The orbit lengths at most TEN that divide |A₅|=60 are1,2,3,4,5,6,10. LengthONE is impossible because A₅ is not a finite affine group (the affine group is solvable). Lengths TWO,THREE,FOUR contradict simplicity: the corresponding faithful permutation representation would embed a group of orderSIXTY in S₂,S₃,S₄. LengthFIVE would require a prime-to-FIVE cyclic stabilizer of orderTWELVE; lengthTEN would require one of orderSIX. A₅ has no element of either order, so neither is possible.

Only orbit lengthSIX is possible within a set of sizeTEN. A union of such orbits cannot have TEN elements. This contradicts the invariant reduced branch set and excludes Ω. Thus the actual source G has no A₅ quotient. No claim about an A₆ quotient is made.
