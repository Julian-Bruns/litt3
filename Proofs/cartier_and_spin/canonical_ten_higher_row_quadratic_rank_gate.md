# Proof: even fiber rank and the small invariant determinant divisor

Version3,3 October2026. The Version2 reduction and local deletions passed [review](../../Research/audits/RANK_THREE_SOCLE_AND_ORTHOGONAL_ROW_AUDIT_2026_10_03.md); the final rankSIX/lossONE elimination passed [independent whole review](../../Research/audits/TWO_ORBIT_QUADRATIC_COMPLEMENT_OBSTRUCTION_AUDIT_2026_10_03.md). See the [exact statement](../../Theorems/cartier_and_spin/canonical_ten_higher_row_quadratic_rank_gate.md). No computation is used.

The source is the actual row quotient U, all of whose composition factors have dimension at leastEIGHT. Its paired action and the value line S are retained. No irreducibility of U, independence of its values over k(Γ), or equality with a bundle fiber is assumed.

## The covariant and its tame parity

The row lies in F=M²𝔅₈, which has the perfect S-valued pairing obtained from the R-valued pairing on 𝔅₈. The quadratic covariant factors through U: a row vector killed in projection is a pulled target section, and weighted linear vanishing makes it orthogonal to every row vector. Thus the actual weighted quadratic traces are precisely this induced pairing. Its generic rank is at mostEIGHT.

The coefficient base divisor is G-invariant, while every coefficient is a section of S of degree N/TWENTY. The smallest actual G-orbit on Γ has size N/FIVE. Therefore a nonzero covariant has NO coefficient base point.

At a tame point, the paired coefficient module has opposite eigenvalues of a common scalar, while the S-fiber scalar is the NEGATIVE of the square of that scalar. This follows directly from original row sections of M⁶ and S=M¹²ω⁻¹: the canonical cotangent character is−ONE. Equivariance therefore permits only cross terms between the opposite eigenspaces. Its matrix has EVEN rank at every tame point. This uses no bound on either eigenspace dimension.

If its generic rank r were odd, every r-by-r minor would vanish at all N/TWO tame points. Such a minor is a section of S^r of degree rN/TWENTY<N/TWO, since r≤EIGHT. All these minors would vanish identically, contradicting the generic rank. Thus any nonzero generic rank is TWO,FOUR,SIX orEIGHT.

## Rank TWO is impossible in every constant-module dimension

Suppose the generic rank is TWO. The rank-drop locus is invariant. A nonzero TWO-by-TWO minor has degree N/TEN, smaller than every actual orbit, so the rank never drops. The form has rankTWO EVERYWHERE and factors as two distinct linear forms.

Ordering these projective factor lines gives an ACTUAL étale double cover of Γ. G acts canonically on the ordered factors, using its projective action on U; scalar lift choices disappear. Every inertia fixes each factor: at tame points they lie in opposite eigenspaces, and wild C₅ cannot act nontrivially on a two-element set. Therefore its coarse quotient is an étale double cover of Γ/G=P¹, which is split. Original G has no C₂ quotient, so it preserves each component. Hence there are TWO G-equivariant projective factor maps on Γ.

Let their pulled O(ONE) lines be L₁,L₂. There is no base point, so L₁L₂=S, both degrees are nonnegative and their degree sum is N/TWENTY. Both factor lines have the same projective scalar cocycle; L₁L₂⁻¹ therefore has a genuine G-action. At tame points its fiber character is−ONE.

An invariant rational section by Hilbert90 then has odd order at the tame orbit. Its degree has the form
\[
N\left(m+\frac l5+\frac{2j+1}{2}\right)
=\frac N{10}(10m+2l+10j+5),
\]
which has absolute value at leastN/TEN. But |degL₁−degL₂|≤N/TWENTY. Contradiction. This is the factor-order/invariant-degree argument with its rankTWO hypothesis established; it uses neither dimensionFOUR nor a ONE-plus-THREE coefficient involution.

## Normalize the radical and count the determinant zeros

Let K be the kernel of the actual symmetric bundle map U⊗O→U*⊗S. It is saturated: its quotient is the torsion-free image of a map to a vector bundle, hence locally free on Γ. Put Q_r=(U⊗O)/K. It is globally generated of rankr. The bilinear form descends to a regular generically nondegenerate map Q_r→Q_r*⊗S. Its determinant divisor D is effective and G-invariant.

Locally choose a surjective matrix P for U⊗O→Q_r and a matrix B for the descended form. The original symmetric matrix is PᵗBP. Some r-minor of P is a unit at each point, so the common divisor of all r-minors of PᵗBP is EXACTLY div(detB). In particular D is the genuine rank-drop divisor, not a chosen minor's possibly larger zero divisor.

An individual r-minor has degree rN/TWENTY≤TWO N/FIVE. It cannot vanish on a full tame orbit N/TWO or a full ordinary orbit N. Thus D is supported only on the wild orbit. Write D=k times that orbit. Taking degrees in detB gives
\[
kN/5=rN/20-2\deg Q_r,
\]
so degQ_r=(r−FOUR k)N/FORTY. Global generation gives degQ_r≥ZERO and therefore k≤floor(r/FOUR).

For r=FOUR, k=ONE would make Q₄ globally generated of degreeZERO, hence Q₄≅O⁴: four generically independent generating sections have a nowhere-zero determinant and form a global frame. Its actual G-action is projective with the same scalar cocycle as U. The quotient map then gives a FOUR-dimensional constant projective-module quotient of U. This contradicts its composition-factor bound. Therefore k=ZERO and the form is perfect everywhere. Taking its determinant gives
\[
(\det Q_4)^2=S^4=M^{48}\omega_\Gamma^{-4}=\omega_\Gamma^2.
\]
The ordinary TWO-torsion difference line is retained; no unsupported native fourth-power action is inferred.

For r=EIGHT,k=ONE, the normalized Gram determinant has orderONE at each wild point. The [corank-one Gram obstruction](../quotient_geometry/local_actions/wild_orthogonal_gram_simple_defect_obstruction.md) applies with target F₀=J₅⊕J₃ and rules this out. Explicitly the Gram fiber would have rankSEVEN, forcing the actual row image to be a nondegenerate invariant hyperplane of F₀. Its orthogonal complement would be a ONE-dimensional direct summand, absent from J₅⊕J₃. This argument does not assume that a smaller-rank perfect Gram quotient injects into F.

For r=EIGHT,k=TWO the same degreeZERO argument gives Q₈=O⁸ and an actual EIGHT-dimensional quotient W. Generic rankEIGHT of the Gram form forces the actual row map to F, also rankEIGHT, to be generically surjective. Its generic radical is precisely the row kernel; equality extends as saturated kernels. Thus W actually maps to F with full generic rankEIGHT. Its composition factors all have dimension at leastEIGHT, so W is irreducible. The [full-rank EIGHT-factor local exclusion, Version2](canonical_ten_full_rank_eight_factor_local_gate.md) contradicts the simple wild determinant of that actual map.

Only k=ZERO remains for r=EIGHT. Equality of the saturated Gram and row kernels factors the actual row map through Q₈→F. Both perfect forms agree under this map. Hence it is invertible at EVERY point and identifies Q₈ with F. The ACTUAL row therefore globally generates F. No constant EIGHT-dimensional module is inferred from that global generation.

The Version2 determinant reduction above left rankSIX,k=ONE. Its exact raw-image analysis is recorded separately in Version4 of the [saturated span theorem](canonical_ten_perfect_gram_raw_span_constraints.md); that proof uses only the preceding Version2 reduction. The [quadratic-complement sequel](canonical_ten_single_wild_six_gram_exclusion.md) then excludes that entire case. This order of inputs matters: the saturation argument does not assume its later exclusion.

RankZERO, rankFOUR with k=ZERO, rankSIX with k=ZERO, and this globally generated rankEIGHT target remain open. Neither the rank bound on a varying Gram matrix nor the rank of Q_r bounds dimU. In the smaller-rank cases its row image may have a radical; ΔJ₅⊕ΔJ₃ in J₅⊕J₃ has nondegenerate quotient rankFOUR and is a concrete caution against the unsupported direct-summand argument.
