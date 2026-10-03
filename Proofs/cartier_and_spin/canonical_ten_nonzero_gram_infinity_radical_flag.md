# Proof: the source infinity expansion and a five-term cyclotomic relation

Version1, 3 October2026. Whole root focused review [PASS](../../Research/audits/OCT03_PAIR_AND_SOURCE_FLAG_AUDIT_2026_10_03.md); see the [statement](../../Theorems/cartier_and_spin/canonical_ten_nonzero_gram_infinity_radical_flag.md). No computation is used.

Let z be the indicated wild point. The map φ is étale there, and its ten sheets split into two C₅ orbits. In a COMMON regular canonical frame dt on Γ write the canonical different section s=aⱼdt on each sheet. Its fiber values are a₊ and a₋ on the two orbits. These are nonzero and distinct.

The accepted primitive normal form gives, in any common compatible frame,
\[
a_+^5+a_-^5=(2b/c)t_5,\qquad a_+^5a_-^5=t_5^2/c,\qquad b^2=2c.
\]
Thus, for r=a₊/a₋,
\[
r^5+r^{-5}=4b^2/c-2=1.
\]
Frobenius injectivity gives r+r⁻¹=ONE. Hence r²−r+ONE=ZERO, r³=−ONE and r⁶=ONE. In particular a₊⁶=a₋⁶, whereas a₊²≠a₋².

Choose a local frame m of M and write sᵢ=αt+O(t²). Its zero is simple, since its pullback is the reduced ORIGINAL infinity divisor and φ is étale. Write m¹⁶=κdt² under the retained identification M¹⁶≅ωΓ², with κ(z)≠0. The native transport φωΓ²≅ωT sends dt² to dt/aⱼ: multiplication by the different section must recover natural differential pullback.

At the ORIGINAL infinity choose a uniformizer w. There are nonzero constants Cₓ,Cθ with x=Cₓw⁻³+lower pole terms and θ=Cθw¹⁶dw+higher terms. On the j-th sheet étaleness of the ORIGINAL X-map gives w=Aⱼt+O(t²), Aⱼ≠0. The equality uᵢ¹⁶=hᵢ*θ then gives
\[
A_j^{17}=\frac{\kappa\alpha^{16}}{C_\theta a_j}.
\tag{1}
\]
The coefficient of bᵢ=q₀(xᵢ)uᵢ⁶ in the common frame m⁶ at t=ZERO is Bⱼ=Cq Aⱼ⁻⁶α⁶, with the SAME nonzero source constant Cq for all sheets. Taking seventeenth powers and using(1) yields
\[
B_j^{17}=C a_j^6,\qquad C\ne0
\tag{2}
\]
with C independent of j. Since a₊⁶=a₋⁶, all TEN values Bⱼ have the SAME nonzero seventeenth power.

Let X₊,X₋ be the sums of the five values on the respective orbits. The retained weighted trace condition is X₊/a₊+X₋/a₋=ZERO. The exact radical embedding adds X₊+X₋=ZERO in the rankSIX [s] alternative and in rankFOUR, and a₊X₊+a₋X₋=ZERO in the rankSIX [s²] alternative. The first system is invertible since a₊≠a₋, and the second since a₊²≠a₋². Therefore X₊=X₋=ZERO in ALL stated alternatives.

Here is the elementary cyclotomic step, with its characteristic-five scope explicit. FIVE is of multiplicative order SIXTEEN modulo SEVENTEEN: 5²=8, 5⁴=13 and 5⁸=−ONE modulo SEVENTEEN. Thus the seventeenth cyclotomic polynomial is irreducible over F₅. If FIVE nonzero elements with the same seventeenth power have sum ZERO, divide by one chosen seventeenth root and express the others as powers of a primitive root ζ. Their sum gives a polynomial P(ζ)=ZERO, degree at mostSIXTEEN, whose F₅ coefficients are the five multiplicities moduloFIVE. Consequently P is a scalar multiple of Φ₁₇. But P(ONE)=FIVE=ZERO, whereas Φ₁₇(ONE)=SEVENTEEN=TWO. The scalar is thereforeZERO. All multiplicities are divisible byFIVE, so the FIVE elements coincide.

Apply this to each orbit using(2) and X₊=X₋=ZERO. The original row vector is constant on each original regular C₅ block, hence lies in their two-dimensional socle. Modulo the original unit, that socle maps precisely to the long J₅ socle. By the final clause of the accepted radical-line embedding theorem this is the fiber of BOTH rankSIX alternatives [s] and[s²]. The accepted rankFOUR power plane contains that same long socle, since it contains each saturated canonical power line. The assertion follows in every stated case.

The argument uses the original source expansion, not a generic row label. It does not constrain the labels whose infinity section does not vanish at z; no global spanning or exclusion is inferred.
