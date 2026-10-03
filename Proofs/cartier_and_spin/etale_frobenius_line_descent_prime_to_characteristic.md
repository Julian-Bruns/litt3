# Proof: the original étale spin power removes the invisible p-torsion

Version1,3 October2026. Pending independent whole review; see the [exact statement](../../Theorems/cartier_and_spin/etale_frobenius_line_descent_prime_to_characteristic.md).

## Two elementary Picard facts for an actual étale map

For a finite étale map a of degree r, the kernel of a* on line-bundle classes is finite torsion: norm gives B^r=O whenever a*B=O. Its k-point torsion is prime to p. To see the latter, pass only for this Picard argument to the étale Galois closure of a. A line trivialized there is given by a genuine character of its finite deck group into k×. This character has order prime to p, since k× has no nontrivial p-power torsion. Therefore a* is injective on the p-primary torsion in Pic(k). This auxiliary one-map closure is not used to change the original common-source fields.

Consequently if a*B is finite prime-to-p torsion, then B is itself finite prime-to-p torsion: the norm first makes B torsion, and injectivity excludes its p-primary component. Also, multiplication by p on Pic0(k) is surjective over the algebraically closed field. A line W has a Frobenius root precisely when its degree is divisible by p; the set of roots is a torsor under the p-torsion k-points.

## Choose and calibrate the target root

Put ε=P^m⊗ω_C⁻¹. The actual first hypothesis and étaleness of f imply f*ε=O. Thus ε is finite prime-to-p torsion. Because ρ is étale, ω_C=ρ*ω_D, and the second hypothesis gives
\[
F_C^*\epsilon=\rho^*(W^m\otimes\omega_D^{-p}).
\tag{1}
\]
The left side is finite prime-to-p torsion. The preceding Picard facts imply that B=W^m⊗ω_D^(-p) is finite prime-to-p torsion on D.

Choose any Q₀ with F_D*Q₀=W, which exists by the degree hypothesis. Then
\[
F_D^*(Q_0^m\otimes\omega_D^{-1})=B.
\]
Hence Q₀^m⊗ω_D⁻¹ is finite torsion whose p-primary component has exponent at most p. Since m is prime to p, adjust Q₀ by a p-torsion line so that Q^m⊗ω_D⁻¹ has no p-primary component. This adjustment leaves F_D*Q=W unchanged.

Now δ=P⊗ρ*Q⁻¹ has F_C*δ=O, so δ is p-torsion. But
\[
\delta^m=\epsilon\otimes\rho^*(Q^m\otimes\omega_D^{-1})^{-1}
\]
is prime-to-p torsion. It is also p-torsion, hence trivial. Since m is prime to p, δ itself is trivial. This proves the actual line descent P=ρ*Q and the stated finite prime-to-p canonical discrepancy.

## The actual rank-three row application

Use the retained [projective Grassmann descent](canonical_ten_rank_three_projective_row_descent.md). Its étale row has n=g(D)−ONE, en=N, degM=THREE n/FOUR and degE_D=n/FOUR. In particular FOUR divides n. The actual source cover f:T→C satisfies f*P=L², so f*P⁸=L¹⁶=ω_T. The original adjoint row gives
\[
F_C^*P=\omega_C\otimes\rho^*M^{-1}
=\rho^*(\omega_D\otimes M^{-1}).
\]
Put W=ω_D⊗M⁻¹. Its degree is FIVE n/FOUR, divisible byFIVE. All hypotheses of the lemma hold, with m=EIGHT.

The resulting actual Q satisfies F_D*Q=W and pulls back to P. Thus K_D=Q⊗E_D pulls back exactly to q_C*K, including the quotient presentation. The adjunction
\[
F_D^*K_D=F_D^*Q\otimes F_D^*E_D
\longrightarrow(\omega_D\otimes M^{-1})\otimes M=\omega_D
\]
pulls back to the original adjunction of q_C*K. Any constant mismatch between the chosen line identifications is removed by rescaling one of them; the algebraically closed field supplies the required fifth root. Frobenius adjunction therefore gives an actual inclusion K_D→B_D, since injectivity can be tested after the finite étale surjective pullback. It retains precisely the original integral lattice; its quotient is not asserted locally free when the original K was unsaturated.

Its degree is THREE degQ+degE_D=THREE n/FOUR+n/FOUR=n. The exact quotient Q⊗V→K_D survives. Only Q⁸ω_D⁻¹ being finite prime-to-FIVE torsion is proved; a native determinant identification or trivial discrepancy requires another argument. No original X-map on D is supplied by this descent.
