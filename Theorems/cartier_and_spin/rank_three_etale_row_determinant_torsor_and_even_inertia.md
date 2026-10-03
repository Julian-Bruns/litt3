# The native rank-three determinant supplies a genuine even-inertia character

Version1,3 October2026. Whole scoped review [PASS](../../Research/audits/RANK_THREE_SCALAR_TARGET_AND_TAME_IDENTITY_AUDIT_2026_10_03.md). It uses a specified native determinant torsor, not an arbitrary coefficient refinement.

Let C→Y be an actual finite étale R-Galois cover of either selected genus-two endpoint, and let ρ:C→D be a finite étale R-equivariant map with R faithful on D. Put e=degρ, N=|R| and n=g(D)−ONE=N/e. Require an actual R-stable Cartier lattice K_D⊂B_D of rankTHREE and degree n, whose pullback is q_C*K for an original bundle K on Y. All native R-actions on K_D and detK_D are retained. Such data are supplied by [the étale scalar descent](etale_frobenius_line_descent_prime_to_characteristic.md). Keep BOTH original endpoint maps upstairs on T above C.

Every target stabilizer order divides e, and their least common multiple is EXACTLY e, by the genuine degree-n determinant. If e>ONE, then D/R=P¹ and e is even. If target ramification is wild, there is precisely ONE wild value and ONE additional tame value.

For e>ONE the native R-linearized degree-ZERO line
\[
\Lambda=(\det K_D)^2\otimes\omega_D^{-1}
\]
is finite PRIME-TO-FIVE torsion. Let b be its exact order and D′→D its connected cyclic trivializer. Choose an actual connected component C′ of C×_D D′ and write b′=deg(C′→C). Then C′ is an actual G′-Galois étale cover of the SAME Y, G′ acts faithfully on D′, and
\[
C'=Y D',\qquad e'=\deg(C'\to D')=e b'/b.
\]
The native determinant comparison on D′ gives a finite prime-to-FIVE character χ:G′→k× whose TWO-primary part detects every even target stabilizer faithfully. If e′>ONE, its image has exact order e′₂. If χ₂ is trivial, e′=ONE.

This restores the determinant-character/even-inertia step without assuming a rankFOUR constant-module splitting or Q⁴=detK_D. It does not bound wild inertia depth or imply e′=ONE in every case. The actual torsor may require the étale source refinement T′=T D′; both original endpoint maps remain finite étale on that SAME source. No original X-map on C′ or D′ is asserted.

[Proof](../../Proofs/cartier_and_spin/rank_three_etale_row_determinant_torsor_and_even_inertia.md).
