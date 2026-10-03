# Proof: actual weighted parity and the binary Cartier gate

Version2,3 October2026. [Independent whole review PASS, including the new differential derivation](../../Research/audits/CANONICAL_WILD_DEGREE_140_ORDINARY_REDUCTION_AUDIT_2026_10_03.md). [Statement](../../Theorems/cartier_and_spin/canonical_wild_degree_140_ordinary_spin_reduction.md).

## The full ordinary profile forces the differential relation

The two invariant weight140 sections F̃²⁰ and G̃⁷ have different zeros and coarse divisor degree one. Their ratio is therefore a coordinate on the ACTUAL rational quotient B=Γ/G. Pulling back gives β=G⁷/F²⁰ on Y. The weight7 canonical generator has order23·7−20⌊23·7/20⌋=1 at the wild orbit and order zero at the tame orbit. The weight20 generator has order6·20−7⌊6·20/7⌋=1 at the tame orbit and order zero at the wild orbit. The actual maps φ and q are unramified over these orbits. Thus F has seven simple zeros at the wild fiber and G has twenty simple zeros at the tame fiber; they have disjoint supports. Their exact poles are7P and20P.

The canonical different is supported only on qP. Since the distinguished Γ stabilizer is ordinary, β has ramification index two at P and no further ordinary ramification. At a wild zero R of F the ACTUAL separating map β has index20 and different23, so ord_R(dβ)=23−40=−17. Characteristic five gives
\[
d\beta=2G^6F^{-20}dG.
\]
Consequently ord_R(dG)=3. At a tame zero of G the index7 gives ord(dβ)=6, hence ord(dG)=0. Away from these fibers and P both F and G are units and β is unramified, giving ord(dG)=0. At P its index two gives ord_P(dβ)=1; the exact generator poles give ord_P(dG)=1−140+120=−19. Therefore
\[
\operatorname{div}(dG)=3\sum_{F(R)=0}R-19P.
\]
These orders exhaust the canonical degree: 7·3−19=2. For σ with divσ=2P, F³σ has precisely this divisor. The quotient dG/(F³σ) is thus a nonzero constant c. This derivation uses the full ACTUAL ordinary carrier profile; neither a Cartier gate alone nor a cone profile supplies it.

## The canonical invariant spaces through weight140

On the rational coarse quotient, a canonical weight-j section has divisor degree
\[
d_j=-2j+\lfloor23j/20\rfloor+\lfloor6j/7\rfloor
=\lfloor3j/20\rfloor-\lceil j/7\rceil.
\]
This formula retains the actual wild different, rather than treating inertia20 as a tame root point. For every integer j≥0 write j=7a+20b with 0≤b<7 and a an integer. Then d_j=⌊a/20⌋. For 0≤j<140 one has −20<a<20; thus h⁰=max(0,d_j+1) is one exactly when a≥0, and zero otherwise. The nonzero section is the corresponding product of the weight7 and weight20 generators. At j=140 the two independent sections are their twentieth and seventh powers. They vanish at the two distinct coarse branch values: the weight7 generator is supported on the wild orbit, the weight20 generator on the tame orbit. Equivalently, the canonical140 coarse divisor has degree one, and these two sections have different zeros.

Consequently the invariant spaces through weight140 have the exact monomial description F̃^aG̃^b, 7a+20b=j. Distinct monomials first have the same weight at140, where they are F̃²⁰ and G̃⁷. This is the portion of the canonical ring used below; no assertion that its invariant generators generate k(Γ) is made.

## The actual characteristic identity on Y

Choose a rational N-frame v on Γ, and write a=s/φ*v for the canonical different section s. The primitive coefficient has degree140 over Γ. Its monic characteristic/minimal polynomial has intrinsic invariant coefficient sections e_j∈H⁰(Γ,N^j)^G. Divide its pulled identity by a¹⁴⁰. Using φ*N≅O_T(qP), the quantities φ*e_j/s^j are genuine Y-functions with poles at most jP. If F=φ*F̃/s⁷ and G=φ*G̃/s²⁰, the resulting ACTUAL source identity is
\[
1+\sum_{j=1}^{140}Q_j(F,G)=0,
\]
where Q_j is a constant polynomial homogeneous for weights7,20. For j<140 it has at most one monomial; Q₁₄₀ is a linear combination of F²⁰,G⁷. Signs of the characteristic coefficients can be absorbed into Q_j. Faithful pullback identifies these polynomials with the corresponding intrinsic Γ coefficient sections. This uses the given actual primitive coefficient, not an arbitrary spectral polynomial.

## Pure odd F forces an actual even minimal polynomial

Suppose F=yB₁. Its cubic times σ is ΦB₁³dz, invariant under the hyperelliptic involution ι. The relation dG=cF³σ therefore gives d(ι*G−G)=0. The odd part of G is a fifth power as a rational function. Its fifth root has pole at most4P and is odd. But every function in L(4P) is an invariant quadratic polynomial in z; there is no nonzero odd fifth root. Hence G is invariant.

Apply ι to the actual source identity and subtract it. Since F changes sign and G does not, the odd-weight part vanishes. Every odd weight is below140. Its unique possible monomial has exact pole jP: the ordinary distinguished profile gives pole7 for F and20 for G. Distinct odd weights therefore have distinct poles and cannot cancel. Each odd Q_j is zero as a polynomial, so every corresponding odd intrinsic coefficient e_j vanishes on Γ. Weight140 contributes only even terms.

The primitive degree140 minimal polynomial over Γ is thus EVEN. Sending a to−a gives an ACTUAL involution of k(T) fixing Γ, hence of its smooth projective normalization. For an original infinity section, the exact different identity reads φ*ξ_i=aθ_i for a rational differential ξ_i on Γ and the ACTUAL pulled theta form θ_i. The involution fixes the left side and negates a, so it sends θ_i to−θ_i. The accepted [actual theta recognition](../../Theorems/cartier_and_spin/new_line_comparison_normal_form.md) would identify this with an automorphism of X acting on θ by−1. Aut(X)=C₃ has only cube-root scalars, a contradiction. Both original endpoint maps have remained on T throughout.

The involution is derived from the even primitive polynomial AFTER proving coefficient vanishing. It is not inferred by assuming that the invariant generators generate Γ. Exact ordinary pole orders are essential; the argument has not been extended to a distinguished cone.

## The exceptional A₁+yB₁ Cartier gate

For F=A+yB one has
\[
F^3\sigma=(3A^2B+\Phi B^3)dz
+(A^3+3A\Phi B^2)\sigma.
\]
If deg A≤1 and deg B=1, the first polynomial has degree at most8. Its Cartier vanishing says that the z⁴ coefficient of ΦB³ is zero, since deg A²B≤3. The second condition consists of coefficients z⁴,z⁹,z¹⁴ of (A³+3AΦB²)Φ²; its z¹⁹ coefficient is automatically zero. The z¹⁴ row is LINEAR in A, since deg A³Φ²≤13.

Normalize B=z−r and put C_B(r)=[z⁴]Φ(z)(z−r)³. Write L₀(r)=[z¹⁴]Φ³B² and L₁(r)=[z¹³]Φ³B². The highest odd row is L₀a₀+L₁a₁=0. When this row is nonzero, use A=uA_* with A_*=(L₁,−L₀). The two remaining equations are
\[
u^3P_j(r)+uQ_j(r)=0,\qquad j=4,9,
\]
where P_j=[z^j]A_*³Φ² and Q_j=3[z^j]A_*Φ³B². For u≠0 their necessary compatibility is P₄Q₉−P₉Q₄=0. These formulas are valid over the full algebraic closure and retain multiple B-roots.

The tiny NEW [exact source](../../scripts/genus_two/oct03_wild140_exceptional_cartier_gate.py) uses only the six already recorded transformed BACKUP quintics as input. It computes polynomial gcds in F₁₂₅[r], not a point census. Its [receipt](../../../litt3-computation-data/oct03_wild140_exceptional_cartier_gate/backup_gate.json) records all cubic, linear, residual and compatibility polynomials. The computation took0.1 seconds, one core. The focused extension recording the surviving root took0.2 seconds; no older torsion or carrier result was replayed.

At all six origins gcd(C_B,L₀,L₁)=1, so no B-root has a zero linear row. The compatibility gcd is1 at P=∞,0,1,2,3. At P=α the transformed quintic is Φ=(0,64,33,88,15,1), and
\[
\operatorname{monic}C_B=(84,58,86,1)=(r-[108])^3.
\]
At its unique geometric root r=[108], A_*=(2,12). ALL four residual values P₄,P₉,Q₄,Q₉ are zero. Thus every u satisfies the Cartier gate there. This gives exactly the displayed necessary family; u=0 has already been excluded by the actual pure-odd argument. No finite count of nonzero u, carrier existence, or exclusion of this remaining family is asserted.
