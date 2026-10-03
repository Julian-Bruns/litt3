# Proof: a single ordinary conductor section cannot be the sole missing original cubic factor

Version1, 3 October2026. Fresh independent [whole source audit](../../Research/notes/oct03_ten_hour/split_single_ordinary_section_cubic_gap_exclusion_audit.md): **PASS**, no corrections. Canonical extraction is frozen for focused fidelity review. The proof concerns original cubic extensions of TWO ACTUAL étale X maps on their SAME smooth source. Auxiliary critical curves are not endpoint sources and their auxiliary X maps are not claimed étale.

## 1. Exact source and the negated conclusion

Let k be algebraically closed of characteristic5. Keep the fixed smooth genus-nine X:y³=P(x), P monic squarefree degree10, unique infinity O and θ=dx/y² with divθ=16O. Let q₀(x)=(x+1)²+d,d≠0, whose roots avoid P. Retain TWO actual finite étale maps of equal degree r∈{16,17,18,19,20} from the SAME smooth projective connected C₀, their actual functions, reduced disjoint infinity divisors Hᵢ, and
\[
k(C₀)=k(t,x₁,x₂),\quad q₀(x₂)=t⁶q₀(x₁),\quad
\operatorname{div}(t)=H₁-H₂,\quad θ₁=κt^{16}θ₂.
\tag{1}
\]
The actual conic image C is normalized by C₀ on
\[
u²-v²=d(t⁶-1),\quad u=x₂+1,\quad v=t³(x₁+1).
\]
Use its smooth projective conic surface S, boundary D=D₊+D₋, fiber F, L=D+3F, and SAME effective exact conductor-adjoint
\[
R=C-6L,\quad RF=r-12,\quad RD_±=0,\quad ν^*R=Δ.
\]
Let ρ define R and a be the ORIGINAL extension of ρy₂, in 3D+10F∞+R. Keep the GENERAL own error ε₂∈H⁰(C−8L); no vanishing is assumed initially.

Suppose R has NO F∞ component. Suppose N⊂R is a smooth multiplicity-ONE section disjoint from BOTH D±, ordinary on F∞, and
\[
R-N\mid a,\qquad N\nmid a.
\tag{2}
\]
All multiplicities in R−N are retained, including any boundary or finite vertical components. We prove that(2) is IMPOSSIBLE. No statement is made here about an auxiliary section at infinity, a nonsection residual pole, multiplicity>1 of N, or R containing F∞.

The first-leg version swaps the ACTUAL endpoints and replaces F∞ by F₀ and a by a₁=b/t¹⁰. It retains the SAME conductor and original y₁. Thus in a four-section conductor with no vertical part, one original extension cannot share exactly the other three components while remaining active only on an ordinary-at-its-pole-end section.

## 2. Own error vanishes and the exact residual differential exists

Write H=R−N, a=σ_H A,ρ=σ_Hσ_N in compatible local frames. The general identity
\[
a³-P(u-1)ρ³=γQ(ρ\mathcal Da-a\mathcal Dρ)+Q²ε₂
\tag{3}
\]
uses γ≠0 and Q defining the integral actual C. The cubic numerator is divisible by3H and the Wronskian by2H, since the derivative of the common factor cancels. C and R share no component. Hence 2H divides ε₂. The residual error bundle is
\[
C-8L-2H=4L-C+2N,
\qquad (4L-C+2N)F=10-r<0.
\]
It has no nonzero section, so ε₂=0. This argument handles the complete common factor and does not use only horizontal factors.

Put h=a/ρ. It is a meromorphic section of3D+10F∞ whose ONLY additional divisor pole is N, with order exactly one at its generic point. Consequently \mathcal Dh has the global pole bound4D+12F∞+2N: a first-order derivation raises a simple divisor pole by at most one, and the established relative-weight10 cancellation in characteristic5 gives the infinity exponent12. Formula(3), after division byρ³, becomes
\[
h³-P(u-1)=γQG,\qquad G=\mathcal Dh/ρ.
\tag{4}
\]
There is no hidden H denominator in G. Indeed dividing the zero-error identity by σ_H² gives H times the residual cubic on the left and Q times (σ_N\mathcal DA−A\mathcal Dσ_N) on the right. Since Q and H share no component, the latter Wronskian is divisible by the COMPLETE H. After this cancellation G has possible divisor pole3N in its natural bundle4D+12F∞−R. Equation(4) shows its pole at generic N is EXACTLY three: Q is a unit there, h³ has pole3 and P is regular. Thus clearing those poles produces a nonzero global section with an effective ZERO divisor Z_G in the class
\[
4D+12F∞-R+3N,
\qquad Z_GF=23-r\in\{3,4,5,6,7\},\quad Z_GD_±=0.
\tag{5}
\]
This zero divisor does NOT contain N; its generic cleared coefficient there is a unit. It is important to use the exact pole, rather than inserting an artificial zero component by an oversized pole allowance.

G is nonzero: if it were zero, h³=P(u−1) in k(S), contrary to the valuation10 at either boundary of the monic degree-ten coefficient (a cube has valuations divisible3).

## 3. The zero divisor has no boundary or vertical components

Near a generic boundary use a regular R-frame, w a boundary parameter, and compatible C-frame with relative factor w⁻⁶. The actual C is disjoint from that boundary, so the local defining coefficient of Q is a unit. The meromorphic h has boundary pole at most3, whereas P(u−1) has EXACT pole10. Their difference in(4) therefore has exact pole10 and nonzero monic leading coefficient. In the G bundle4D+12F∞−R this is a NONZERO boundary coefficient. Since N is boundary-disjoint, adding3N changes no boundary valuation. Thus neither D± is a component of Z_G.

Equation(5) then implies Z_G is disjoint from BOTH boundaries: each remaining component has nonnegative intersection with them. Every vertical irreducible component of S meets one of the boundary sections, and each whole smooth fiber meets both. Therefore Z_G has NO vertical component either. It is a nonempty effective horizontal divisor, of total fiber degree between3 and7.

## 4. The actual infinity identities exclude auxiliary zeros

Set s=t⁻¹,U=s³u,V=s³v. The infinity conic is U²−V²=d. Its two auxiliary points P± have U=0,V=±√(−d). The ACTUAL étale x₂ poles have order3 and the ACTUAL t poles are simple, so C avoids both auxiliary points; its regular defining coefficient q∞ there is a unit. R has no F∞ component by hypothesis.

Use regular compatible local R,C frames at an auxiliary point, so
\[
ρ=e_Rρ₀,\quad Q=e_Rs^{-18}q₀,\quad
h=s^{-10}h₀,\quad G=e_R^{-1}s^{-12}g₀.
\]
The derivative of s⁻¹⁰ is zero. The scaled field Δ=s²\mathcal D restricts to
\[
δ=-3Uz\partial_z,
\quad z=U+V,\quad U=(z+d/z)/2,
\]
and in the U coordinate at either auxiliary point it is U times a unit times∂U. Equations(4) restrict EXACTLY to
\[
h∞³-U^{10}=γq∞g∞,
\qquad δh∞=ρ∞g∞.
\tag{6}
\]
No unspecified weight correction is dropped: the relative weight10 derivative is zero, and there is no Q derivative in(6).

The established actual auxiliary forcing gives ρ∞ a zero of order m≥1 at each P±. For completeness it follows already from(6) if one supposes ρ∞ is a unit: h∞ is regular there because N is ordinary; a nonzero value makes the left side a unit while δh∞ vanishes, a zero of order1,2,3 gives derivative order n versus3n, and a zero of order≥4 forces derivative order10, impossible for U times a unit∂U in characteristic5. Thus a unit ρ∞ cannot occur.

The rational h∞ has poles of order at most3 at EACH boundary point of the infinity conic, and at most1 at the ONE ordinary point N∩F∞. There are no others. Hence δh∞ has total polar degree at most
\[
4+4+2=10.
\tag{7}
\]
The derivative is nonzero, since otherwise(6) would force h∞³=U¹⁰ as a rational function, impossible at U=0.

Suppose h∞ has a zero of order n>0 at an auxiliary point. For n1,2,3 the Euler derivative has order n, while(6) requires order m+3n>n. For n≥4, h∞³−U¹⁰ has order EXACTLY10, so(6) requires δh∞ a zero of order m+10≥11. That contradicts(7). Thus h∞ is a UNIT at BOTH auxiliary points. Formula(6) now makes g∞ a UNIT at both as well. In particular Z_G avoids BOTH auxiliary points on F∞.

## 5. Every possible critical component contradicts the fixed endpoint genus

Take an irreducible component Z of Z_G, of multiplicity μ, and let K_Z be the function field of its normalization. Put f=ZF>0. Section3 gives no boundary intersection; Section4 gives no auxiliary infinity intersection. Thus u has poles of EXACT order3 times each infinity intersection multiplicity and no other poles on Z. Therefore
\[
\deg(u|Z)=3f.
\tag{8}
\]
This is positive. The conic coordinates give K_Z=k(t,u,v), so [K_Z:k(t,u)]≤2.

Z is not N, not a component of C (its degree is≤7<r), and not a boundary or vertical component. The logarithmic derivative of(4) gives
\[
\frac{\mathcal DG}{G}
=\frac{3ρh²}{γQ}-\frac{\mathcal DQ}{Q}.
\tag{9}
\]
The right side is regular at generic Z: h has poles only at N, Q is a unit generically on Z, and ρ is regular there in the common frame. Frame changes alter only regular terms. If5 does not divide μ, the pole term μ\mathcal Dz/z on the left forces \mathcal Dz divisible by z. Hence Z is \mathcal D-invariant. The induced derivation is nonzero because \mathcal Dt=v is nonzero generically; v cannot vanish identically on an invariant horizontal curve since \mathcal Dv=−3dt⁵. Its constants on a one-variable function field over perfect k are K_Z⁵. Thus u is a fifth power.

Since μf≤Z_GF≤7, (8) and fifth-power divisibility force f=5, deg u=15 and μ=1. Extract u=ξ⁵,degξ=3. Along Z equation(4) gives h³=P(u−1), and therefore h=η⁵ with
\[
η³=P^{(1/5)}(ξ-1).
\tag{10}
\]
Here coefficients are inverse-Frobenius transformed; this is an AUXILIARY map to the Frobenius twist of fixed X. Its degree is ONE because ξ has degree3 and the endpoint trigonal function has degree3. Thus the normalization of Z has genus9. Inseparability is not hidden: degreeξ3<5 makes ξ separating, and a higher fifth-root extraction is impossible because deg u15 is not divisible25.

On the other hand J=k(t,ξ) contains u. The extension K_Z/J divides2 by the conic relation and divides degξ3, hence is ONE. Also t is separating because the invariant derivation takes t to the nonzero v. The two generating separating functions t,ξ have degrees5 and3. Castelnuovo gives
\[
g(Z)\le(5-1)(3-1)=8,
\]
contradicting genus9.

If5 divides μ, the same bound μf≤7 forces μ=5,f=1. The normalization is P¹ by its degree-one t map. Equation h³=P(u−1) and deg u=3 give a degree-one map to fixed genus-nine X, again impossible. This case needs no invariance claim. No multiplicity or inseparable auxiliary map is discarded.

Thus every possible component of the NONEMPTY divisor Z_G is impossible. This proves the exclusion(2) and the stated full-factor conclusion.

## 6. Consequences and limits

For actual r16–19 packets, sharing R−N therefore forces sharing N too, and the accepted full individual factor exclusion eliminates that alternative. At r20 it forces the ENTIRE original factor, whose degree-twenty boundary remains separate and OPEN. The exact first-leg swap gives the analogous assertion when N is ordinary on F₀ and R has no F₀ component.

The argument can close complementary separated activity patterns ONLY after their genuine source/component hypotheses have been supplied. It does not assert that all conductor divisors have such a unique missing section, force general errors to vanish, exclude arbitrary multi-component residual poles, or promote an auxiliary curve to an étale endpoint leg. The original unmarked common-cover problem remains UNSOLVED.

## 7. Frozen evidence and audit provenance

The independently reviewed source is [the single ordinary section note](../../Research/notes/oct03_ten_hour/split_single_ordinary_section_cubic_gap_exclusion.md), SHA256 `5a319d3f8a7313099f36208f1ab381241484be4e578d780c183dcb297566e6f5`. Its fresh whole receipt has SHA256 `fa699527211b3eac2bb11bbd85cecc2edee04922065c99066d2b1b7ef6e432d2`. The audit checked COMPLETE common-factor and error cancellation, exact pole clearing without artificial N zeros, boundary and vertical exclusion, both auxiliary infinity frames and polar degree10, multiplicity-sensitive logarithmic invariance, fifth-root extraction, conic field generation and the genus-nine contradiction. No computation was performed or replayed. The original source and receipt remain unchanged; canonical scope is the precise one-section gap stated here.

