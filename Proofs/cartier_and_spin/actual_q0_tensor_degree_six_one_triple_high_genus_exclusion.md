# Proof: three calibrated poles forbid every higher hyperelliptic genus

Version1,3 October2026. Whole scoped review PASS; see the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_degree_six_one_triple_high_genus_exclusion.md). This is conceptual and retains the original source. [Independent audit](../../Research/audits/ACTUAL_Q0_TENSOR_ONE_TRIPLE_INFINITY_AUDIT_2026_10_03.md).

## The actual joint field and complete pole bounds

The accepted cubic coarse reduction gives B=Bx(z), with index ONE or THREE over Bx=k(x1,x2). If that index were THREE at d=SIX, each separating xi:Bx→P¹ would have degree TWO. Its local indices divide the actual B→P¹ indices ONE or THREE. Since its degree is TWO, all its indices would be ONE. A nontrivial étale degree-TWO cover of P¹ is impossible by Hurwitz. Thus B=Bx, including the degree-divisible-by-THREE situation; this field equality is not presumed from coprimeness.

Let R1,R2 be the respective triple infinity poles and Q1,Q2,Q3 the common simple poles. The q0 cube identity gives div(z)=TWO R1−TWO R2. These poles are distinct, since otherwise z would be constant and the q0 quadratic relation would make the joint x-degree at most TWO. Thus z has degree TWO. Assume g(B)≥THREE. It is the hyperelliptic coordinate with R1 at ZERO and R2 at infinity, both Weierstrass. Write Y²=Φ(z) with squarefree degree2g+ONE polynomial Φ, and with a simple ZERO at z=ZERO.

Center BOTH original x-coordinates identically so q0=xi²+D, D≠ZERO. This affine translation does not change P9, which is nonzero. The exact leading and first-jet lemmas give the SAME ratio ρ and finite part ξ0 at every Qi, with z(Qi)³=ρ². They also make the z-ramification status uniform: all Qi are ordinary if ρ≠ONE, or all are Weierstrass if ρ=ONE.

Let J be the product of their DISTINCT z-coordinate factors and put q=deg J. The actual even/odd pole bounds give
\[
x_1=A_1/(zJ)+bY/(z^2J),\qquad
x_2=A_2/J+cY/J,
\]
with deg Ai≤q+ONE and deg b,c≤q+ONE−g. These follow directly from maximum even pole TWO and odd pole THREE at Ri, and simple poles at the Qi. At a shared coordinate with BOTH conjugate Qi, only ONE J-factor is used. No polynomial degree bound treats three points as three distinct coordinates without checking this.

## Ordinary poles, including a conjugate pair

If an ordinary conjugate pair has coordinate a, the remaining point has a different coordinate d, so q=TWO. For g≥THREE the odd b,c are constants or zero. At the lone point over d, cancellation of its conjugate pole forces b,c nonzero. Equality of the two actual residue ratios over a gives a²c=ρb. Cancellation at d gives d²c=ρb. Hence a²=d²; calibration also gives a³=d³, so a=d, a contradiction. If the degree bound kills the odd terms entirely, both xi lie in k(z), contradicting B=Bx. Three ordinary points cannot lie over a single degree-TWO fiber. This covers every repeated-coordinate configuration.

Suppose instead that all THREE ordinary coordinates are distinct. Then J=z³−ρ² and q=THREE. For g≥THREE, deg b,c≤ONE. At each canceled conjugate pole, the odd q0 identity A2c=A1b and the calibrated leading residue imply zb−ρc=ZERO. Its degree is at most TWO, so it vanishes identically. Nonzero b,c therefore have c=kz,b=kρ, with k≠ZERO; a higher genus would kill the necessary linear c and is impossible. Absorb k into Y and write A1=zL,A2=ρL, deg L≤THREE. The SAME xi are
\[
x_1=L/J+\rho Y/(z^2J),\qquad
x_2=\rho L/J+zY/J.
\]
Their exact even q0 identity gives
\[
\Phi=z[L^2+D(z^3-1)J],\qquad \xi=x_2-\rho x_1=Y/z^2.
\]
At an actual pole with z=a, the noncanceled sheet has Y=ρL/a. Hence ξ(a)=L(a)/ρ. The exact first jet fixes ξ(a)=ξ0 at ALL THREE coordinates, so L=λJ+ρξ0. Therefore Φ is z times a polynomial in z³. The genuine automorphism z↦ωz,Y↦ω²Y, with ω³=ONE,ω≠ONE, fixes BOTH displayed xi. It is nontrivial on B, contradicting B=Bx. The contradiction uses an actual smooth function-field automorphism, not an assumed lift to the original source.

## Three Weierstrass poles

Here ρ=ONE and their coordinates are exactly the THREE cube roots of unity. Put J=z³−ONE and Φ=zJH, with H squarefree, nonconstant and disjoint from J; deg H=TWO g−THREE. Each even part has no pole at a Qi, since its possible pole would have even order TWO while the actual pole has order ONE. Thus
\[
x_1=A/z+bY/(z^2J),\qquad x_2=B+cY/J,
\]
with A,B linear or constant. The actual odd simple-pole coefficients b,c are nonzero at EVERY root of J. Calibration gives b(a)=a²c(a) there, and the odd q0 identity gives Bc=Ab.

If both A and B are ZERO, the even q0 identity gives
\[
H(zc^2-b^2)=DJ^2,
\]
impossible because H is nonconstant and disjoint from J. If exactly one of A,B is ZERO, the odd identity kills a required odd pole coefficient. If the two nonzero linear polynomials are proportional, then c/b is constant, whereas calibration makes it a−TWO at THREE distinct coordinates, again impossible.

The remaining A,B are coprime. Hence b=hB,c=hA for a polynomial h, and h is nonzero at every root of J. Put M=zA²−B². Calibration gives M(a)=ZERO at all THREE roots, so M=μJ with μ≠ZERO. M cannot be identically ZERO: zA²=B² contradicts valuation parity at ZERO for nonzero A,B. The exact even q0 identity now is
\[
(h^2H-J)M=DJ^2,
\]
so h²H=(ONE+D/μ)J. At a root of J its left side is nonzero and its right side vanishes, a contradiction. This sign follows the centered convention q0=xi²+D. No finite branch-value Sidon counting is used.

All g≥THREE possibilities have been excluded. The conclusion is only the stated low-genus restriction in the ONE-triple-pole cubic-index-THREE stratum. Both original actual X-maps and any original Y-map remain on the SAME original source; neither descends by assertion to B.
