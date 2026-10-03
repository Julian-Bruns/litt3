# Proof: the wild lifting obstruction is detected by two actual residues

Version1,3 October2026. Whole root review, including the final wild-fiber clause, [PASS](../../Research/audits/PERFECT_SIX_RADICAL_EMBEDDING_AUDIT_2026_10_03.md); see the [statement](../../Theorems/cartier_and_spin/canonical_ten_perfect_six_radical_embedding.md). No program or coefficient certificate is used.

We work on the ACTUAL quotient stack S=[Γ/G]. Write f:Y=[T/G]→S for the map induced by φ. This is an actual representable finite map of degreeTEN. Its wild completions are unramified as Γ-maps: the entire different of φ is the distinct ordinary divisor q*P₀. On Y the wild coarse fiber consists of TWO distinct points R₊,R₋. The original X-map remains on T; no further X-atlas is used in this argument.

The retained different transport gives f*ω_Γ≅O_Y(P₀), with its canonical section represented upstairs by s. Also φ*ω_Γ²≅ω_T. Choose a nonzero holomorphic differential η on Y with divisor TWO P₀. Since s² and q*η have the SAME divisor TWO R as sections of ω_T, properness and connectedness give
\[
q^*\eta=c s^2,\qquad c\in k^\times.
\tag{1}
\]
This uses the accepted native different comparison, not a new eighth-root or scalar character repair.

## The relevant local wild cohomology is one-dimensional

At a fixed Γ wild point the completed extension is weakC₅. Choose an Artin–Schreier coordinate u with σu=u+ONE and a simple pole, and set t=ONE/u. Its invariant differential is du=−dt/t². Thus the regular local module ω_Γ^m, in its invariant rational frame du^m, is t^{2m}k[[t]]. We need m=ONE,TWO only.

For l=TWO orFOUR, additive Hilbert90 for the local fraction field K identifies
\[
H^1(C_5,t^l k[[t]])
\simeq (K/t^l k[[t]])^{C_5}/\operatorname{image}(K^{C_5}).
\]
Here u⁵−u is invariant. A principal part modulo t^l is a finite Laurent polynomial in u. Subtract an invariant polynomial in u⁵−u and write its positive-pole part as a sum of terms (u⁵−u)^n u^j with ONE≤j≤FOUR. For the largest such pole order FIVE n+j, its σ−ONE difference has nonzero leading pole order FIVE n+j−ONE; no lower term cancels it. It therefore cannot define an invariant principal part modulo t^l. Thus all positive-pole terms vanish modulo invariant principal parts.

The constant term is also invariant. For l=TWO the remaining possible class is t, whose difference begins in t². For l=FOUR the differences of t andt² begin respectively in nonzero orders TWO andTHREE, so their coefficients must vanish; the remaining class is t³, whose difference begins in orderFOUR. Neither t nor t³ is the principal part of an invariant local function, whose nonconstant valuations are multiples ofFIVE. Hence both local H¹ spaces have dimensionONE, represented by
\[
\xi_m=t^{2m-1}du^m,\qquad m=1,2.
\tag{2}
\]

The tame point has no positive-degree local group cohomology, since TWO is invertible. The coarse invariant line π_*ω_Γ^m has degree
\[
\lfloor m/2\rfloor-\lceil2m/5\rceil=-1\ (m=1),\quad0\ (m=2).
\]
Its H¹ on P¹ is ZERO in both cases. The degree-one Leray sequence therefore identifies H¹(S,ω_Γ^m) with the preceding ONE-dimensional wild local group cohomology. Equivalently, the class is represented by the invariant principal part(2) along the full wild orbit. This description also fixes its pullback principal parts on Y. No tameness of C₅ or exactness of taking arbitrary G-invariants is assumed.

## Actual pullback to Y detects this class in both degrees

At R₊ andR₋ identify the local Γ chart with the completed Y chart through the ORIGINAL étale source. In the regular canonical frame dt write s=a_±dt, with a_± a unit. The genuine identification φ*ω_Γ²≅ω_T sends dt² to dt/a_±: multiplication of a pulled Γ differential by s must agree with its natural differential pullback. Equation(1) therefore reads q*η=c a_±dt in these charts.

Pulling the principal part ξ_m to the line O_Y(mP₀), whose canonical section is s^m, gives the local rational function ξ_m/s^m. Serre duality tests its boundary against η, which vanishes at leastmP₀ for both m=ONE,TWO. The two local residues of (ξ_m/s^m)η are:
\[
-c,-c\quad(m=1),\qquad c/a_+,c/a_-\quad(m=2).
\tag{3}
\]
Indeed ξ₁=t du=−dt/t, while ξ₂=t³du²=dt²/t. Substituting the preceding frame comparisons gives(3) directly; the SAME constant c occurs at both actual points by(1).

For m=ONE their sum is−TWO c≠ZERO. For m=TWO it is c(a₊⁻¹+a₋⁻¹), also nonzero. To justify this last input with its actual frame: at the wild point the primitive degreeTEN polynomial has two distinct nonzero fifth-power roots. Its coefficient e₅ is nonzero there, so the two actual different values satisfy a₊+a₋≠ZERO. Thus a₊⁻¹+a₋⁻¹≠ZERO. This is exactly the retained nonzero sum of the TWO trace weights in the actual J₅⊕J₃ fiber construction.

The residue pairing shows that
\[
H^1(S,\omega_\Gamma^m)\longrightarrow H^1(Y,O_Y(mP_0))
\]
is nonzero, hence injective, for m=ONE,TWO. This is a native equivariant lifting calculation. It is not injectivity of an arbitrary twisted H¹ pullback, and it is independent of the separate coherent H¹(O) primitive-factor theorem.

## The invariant quotient sections are the canonical powers only

On S tensor the actual unit sequence by ω_Γ^m:
\[
0\longrightarrow\omega_\Gamma^m\longrightarrow E\otimes\omega_\Gamma^m
\longrightarrow(E/O_\Gamma)\otimes\omega_\Gamma^m\longrightarrow0.
\]
The cohomology map after H⁰ of the quotient is precisely the injective map just proved. Therefore EVERY invariant quotient section lifts to an invariant section of Eω_Γ^m. Such invariant sections are exactly H⁰(Y,O_Y(mP₀)).

For m=ONE that space is k times the canonical section, represented upstairs by s, while H⁰(S,ω_Γ)=ZERO. Thus the invariant quotient space is k[s]. For m=TWO the genus-two Weierstrass pole space has dimensionTWO, generated by s² and the pulled invariant generator t₂ of ω_Γ². The source H⁰(S,ω_Γ²)=k t₂ removes precisely the latter. Hence the invariant quotient space is k[s²].

The weighted unit-orthogonal quotient is a subbundle of E/O. Both canonical powers lie in it: weighted traces of s ands² are respectively Tr(ONE)=TEN=ZERO and Tr(s)=ZERO. Their self-pairings are Tr(s) andTr(s³), bothZERO by the accepted vanishing of coefficients e₁,e₂,e₃. Thus the same ONE-dimensional spaces are the required native Hom spaces into E°/O.

For completeness these nonzero canonical maps are saturated. At the different fiber s has a nonzero linear nilpotent part on its ramified sheet, and s² is zero there but nonzero on the remaining sheets, so neither is constant modulo the unit. At the wild fiber the TWO values a₊,a₋ are distinct and have nonzero sum, so their first and second powers remain distinct. At every other fiber e₈≠ZERO. If all first powers were constant, the degreeTEN norm would be (X−λ)¹⁰ and have e₈=ZERO. If all second powers were constant, the roots would be ±λ; e₁=ZERO forces each sign multiplicity divisible byFIVE, so again the norm is a fifth power of a quadratic or the tenth power of a linear polynomial and has e₈=ZERO. These contradictions show that the canonical power classes never vanish in the quotient fiber.

## Apply the classification to the actual perfect Gram radical

The accepted [raw-span theorem, Version4](canonical_ten_perfect_gram_raw_span_constraints.md) identifies the radical untwist A⊗M⁻⁶ with ω_Γ⁻¹ orω_Γ⁻² as a NATIVE G-line inside E°/O. The corresponding embedding is therefore [s] or[s²] up to a nonzero constant, not merely an abstract line isomorphism.

Its coisotropic orthogonal is the ACTUAL globally generated raw image. Pairing an original adjoint section b_i with [s^m] gives Tr(b_i s^{m−ONE}) in any compatible rational canonical frame. The power line is orthogonal to the original unit, so this condition is independent of the chosen lift modulo that unit. Thus the two alternatives give exactly Tr(b_i)=ZERO orTr(s b_i)=ZERO, respectively.

## The power radical belongs to the long wild block

Retain the actual wild fiber construction, before removing the unit. It is TWO regular C₅ blocks, whose orthogonal block decomposition is R₀h⊥R₀k with R₀=k[C₅] and Δ=σ−ONE. The unit is Δ⁴h. Its orthogonal quotient is
\[
(\Delta R_0h/\Delta^4R_0h)\ \perp\ R_0k,
\]
of types J₃ andJ₅ respectively. The nonzero sum of trace weights makes both indicated blocks nondegenerate, as in the accepted actual fiber proof.

Every canonical power s^m is constant on each of the TWO original C₅-orbits, so its fiber belongs to the original socle span(Δ⁴h,Δ⁴k). Modulo the unit it is therefore in the long-block socle kΔ⁴k. It is nonzero there: the TWO first powers differ, and the TWO second powers differ because their values are distinct with nonzero sum. It cannot belong to the short J₃ socle, whose lift is Δ³h rather than an original socle vector.

Orthogonal reduction along this long socle line replaces J₅ by J₃. Its orthogonal hyperplane before quotient has long block ΔR₀k of lengthFOUR and retains the short J₃. Thus the raw fiber is J₄⊕J₃ and the perfect quotient is J₃⊕J₃.

Finally a module J₅⊕J₂⊕J₁ cannot surject onto J₄⊕J₃: applying Δ² to a surjection would give a surjection from the CYCLIC module J₃ onto J₂⊕J₁, which needs TWO generators. This is impossible. It is the claimed specified-source exclusion, not a statement about all larger constant modules.

This finishes the embedding classification. No incompatibility with all original q₀ sections has yet been deduced; the original TWO finite étale endpoint maps remain unchanged on T.
