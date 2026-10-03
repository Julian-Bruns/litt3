# Proof: the sign quotient doubles the coarse indices and can twist the eighth root

Version3,3 October2026. [Statement](../../Theorems/cartier_and_spin/canonical_degree_ten_squared_target_double_profile.md). Focused independent review pending. No computation is used.

The free target involution centralizes G0 and acts nontrivially on B, fixing precisely its two branch values. Choose β10 with tame valueZERO and wild valueINFINITY. Its sign quotient is β20=β10². Since π is étale, every completion of Γ0→Γ2 is an unramified copy. At the wild value, the tower Γ0→B→B2 multiplies its indexFIVE byTWO and gives different
\[
8+5\cdot1=13.
\]
At the tame value its index is2·2=FOUR, with cyclic tame inertia. These are exactly the completions of Γ2/B2 under the faithful G0 action. Its area is−2+13/10+3/4=1/20, so Hurwitz gives g(Γ2)−ONE=|G0|/40. The equivariant tower E→Γ0→Γ2 has degreeTWENTY, and its only different remains q_E*P because π is étale.

On Y the original degree-TEN map has branch fibers ∞:(5,5),0:(2⁵),1:(2,1⁸). Squaring its coarse coordinate doubles the first two indices and is étale atONE. Over the new valueONE, the old valueONE contributes(2,1⁸), while the old valueMINUS ONE was unramified and contributesTEN more singleton sheets. Thus the branch ledger is exactly the one stated. Its total different is2·13+5·3+1=42, equal to2g(Y)−2+2·20; no other branch point is introduced.

By the squared-series construction Q0=π*Q2 and φ2*Q2=F. The accepted exact distinguished theta gives M8=ωΓ on the original carrier. Its descent along the free H quotient gives Q04=ωΓ0, since Q0 descends M² and the original eighth-power identity is genuinely linearized. Together with étaleness of π this gives
\[
\pi^*(Q_2^4\omega_{\Gamma_2}^{-1})\simeq\mathcal O.
\]
The kernel of pullback on Picard groups for this connected étale double consists exactly of O and its defining character line R. Hence S=Q24ωΓ2^-1 is one of those two lines. Squaring kills S and gives Q28=ωΓ2². Thus N8=ωΓ2 exactly, and the canonical different formula gives φ2*N8≅O_E(q_E*P). The accepted eighth-power identity is essential; the weaker original sixteenth-power identity alone would leave a twist in N8 itself.

These are genuine linearized identities. The original eight-spin coefficient identification supplies the projective Q2 action; its fourth power is genuinely linearized by the actual determinant transport, and its eighth power is genuine as well. If two ordinary-identical G0-linearized lines differed, they would differ by a constant character G0→k×. The no-prime-to-FIVE-quotient hypothesis excludes such a nontrivial character. Thus no unrecorded linearization twist remains beyond the stated S.

For the invariant generator let t2 be the original weight-TWO generator on Γ0. Its normalized Y function is z=t2/s², with s the original canonical different section. Since δβ10=−β10 and β10=t5²/t2⁵, the canonical action of δ on t2 is MINUS ONE. Therefore t2² descends to the weight-FOUR power N8⁴=ωΓ2⁴; its pullback has the original normalization z². The two different sections on E have the SAME divisor q_E*P and the line identification induced through Γ0, so their ratio is a nonzero constant. This proves that the new weight-FOUR function is a scalar times z².

The old primitive different section descends through H: its transported divisor q*P and canonical linearized line are H-invariant. In a rational frame pulled from Γ0 its coefficient a belongs to E. Changing the old frame on Γ only multiplies it by a Γ-function, so Γ(a)=T still holds. Since the base change EΓ=T has the same degreeTEN, Γ0(a)=E. Now choose its frame on Γ2 instead; this only multiplies a by a Γ0-function and preserves that equality. The normal ET-double Γ0/Γ2 gives
\[
[E:\Gamma_2(a)]\in\{1,2\}.
\]
If the degree wereTWO, E/Γ2(a) would be the actual quadratic base change of Γ0/Γ2, giving a nontrivial deck of E→Γ2. The accepted sign-target comparison proves Aut(E/Γ2)=ONE. Hence Γ2(a)=E and the new different coefficient is primitive of degreeTWENTY.

It remains to take its exact polynomial norm. The original primitive degree-TEN polynomial is
\[
p(\lambda)=\lambda^{10}-A t_5\lambda^5-Bt_2^4\lambda^2+(t_5^2-t_2^5)/c.
\]
The canonical invariant degree formula on Γ2 is floor(3j/10)−ceil(j/4). At j=FIVE it is−ONE, so there is no invariant canonical section of that weight. Since δ commutes with G0, it acts on the one-dimensional old weight-FIVE section space by a sign. The positive sign would descend the nonzero t5 to that impossible section; consequently δt5=−t5. We already know δt2=−t2. Thus t4,t7,t10 descend, and their exact normalized functions are the ones stated.

With U=λ10−B t4²λ²+t10/c, the two polynomials are U−A t5λ5−t2^5/c and U+A t5λ5+t2^5/c. Their product is exactly
\[
U^2-A^2t_{10}\lambda^{10}-(2A/c)t_7t_4^2\lambda^5-t_4^5/c^2.
\]
Its degreeTWENTY and the coefficient primitivity just proved identify it with the actual minimal polynomial. Since b,c,t7,t4 are nonzero, the odd λFIVE coefficient is nonzero. No even-polynomial exclusion applies to this square alternative.

Finally degF=2d0 and degφ2=TWENTY, so degQ2=d0/TEN is an integer. This proves the stated divisibility condition. An eighth root need not have a common sixteenth root; those original section roots have not been supplied by this polynomial argument. Moreover, the accepted [small wild exclusion](../../Theorems/cartier_and_spin/canonical_small_wild_spin_carrier_exclusion.md) explicitly requires the normalized weight-FOUR function to be NONSQUARE in this profile. Here it is z². Thus even an additional common-root construction would not satisfy that theorem's nonsquare premise. The exact square extraction recovers Γ0, so no degree-TWENTY nonexistence follows.
