# Proof: eliminating the remaining small Frobenius functions by genus-two interpolation

Version1,3 October2026. [Statement](../../Theorems/cartier_and_spin/large_wild_small_packet_residue_interpolation.md). Pending independent review. Use the preceding bounded incidence and ordinary/tame pole bounds. No arithmetic calculation or certificate is needed. Both endpoint maps stay on the original T.

## The pole-eleven function and its fourteen jets

The bounded primitive construction gives Π∈L(59P) with dΠ=\(\mathcal R\)F³σ. Since d(K0−Π)=0 and both have pole≤59P, K0−Π=U⁵ with U∈L(11P). The compact global value and fifth-coefficient equations for Q=K0−λ⁻⁵W⁵ give exactly the targets aR,bR in the statement. The fifth coefficient of U⁵ is [U]R,1⁵; no ordinary fifth derivative is being substituted for a Hasse coefficient.

The evaluation map
\[
L(11P)\longrightarrow\bigoplus_{R\in A}k[t]/(t^2)
\]
has zero kernel: a nonzero function of pole degree≤11 cannot vanish on2A of degree14. Riemann–Roch gives dimL(11P)=10, so the cokernel has dimension FOUR.

Because A∼7P and divσ=2P, all meromorphic differentials with poles≤2A and zero≥11P are exactly
\[
\frac{h\sigma}{F^2},\qquad h\in L(5P)=\langle1,z,z^2,y\rangle.
\]
Their residues against a proposed jet u0+u1t at R are fR(h(R)u1+[h]R,1u0), since the linear coefficient of σ/dF vanishes. The residue theorem makes each total residue zero for every actual U∈L(11P): the product U hσ/F² is regular at P and has no other pole beyond A.

These FOUR functionals on the fourteen-dimensional jet space are independent. If one differential annihilates every independently prescribed value and derivative, its two polar coefficients at each R vanish, so h vanishes to order≥2 on A. A nonzero h∈L(5P) cannot have fourteen zeros. Therefore their common kernel has dimension TEN and equals the image of the evaluation map. This proves sufficiency as well as necessity, without relying on an unproved interpolation assertion. Unique fifth roots turn the prescribed aR,bR into u0,u1; raising each residue equation to the fifth power gives exactly the displayed four equations.

For h=1,z the contribution of the W terms vanishes separately: W hσ/F² is regular at P because W∈L(13P), while h has pole≤2 and σ/F² has zero16P. For h=z²,y, possible residues at P retain the top W data. No independence or nontriviality on the family parameter is inferred merely from these four jet-space functionals.

## The pole-eight function and its seven values

The evaluation map L(8P)→k^A has kernel L(8P−A)=F·L(P)=⟨F⟩. Since dimL(8P)=7, its image has dimension SIX and its cokernel has dimension ONE. The differential σ/F has simple poles at A and zero9P at P. The residue theorem therefore imposes exactly
\[
\sum_{R\in A}f_R K_2(R)=0.
\]
The functional is nonzero, so it suffices by the dimension count. Raising to the fifth power and substituting the prescribed K2-values gives
\[
\sum_{R\in A}f_R^5\left(\frac{\mathcal R(R)}{\lambda}-H_1(R)\right)=0.
\]
The corrected leading relation is \(\mathcal R(R)\)fR⁵=4c/λ⁵ at each of the seven points. Thus the first sum is7·4c/λ⁶=3c/λ⁶ in characteristic FIVE, proving the stated compatibility equation. The kernel gives the ambiguity K2→K2+aF.

The distinguished-wild case has only five unramified wild points and permits U∈L(19P); this evaluation map is not injective and the preceding four-obstruction count does not survive. No assertion about that case, global carrier existence, or the common-cover decision is made here.
