# Proof: second-Cartier recognition, finite packets, and stabilizer descent

Version2,3 October2026. Both the recurrence argument and the geometric sharpening passed [independent whole review](../../Research/audits/ACTUAL_SPIN_CARTIER_RECURRENCE_RANK_BOUND_AUDIT_2026_10_03.md). [Statement](../../Theorems/cartier_and_spin/actual_spin_cartier_recurrence_rank_bound.md).

## Fixed input and recognition from C²θ

The accepted [theta comparison proof](new_line_comparison_normal_form.md) records the following exact F₂₅ data. Write F₂₅=F₅[a]/(a²−a−3), and encode c₀+c₁a by [c₀+5c₁]. Put D=C² and φ_j=D^jθ. In ascending polynomial coefficients,
\[
\begin{aligned}
\phi_1&=(13,8,12,20,19,20)\theta,\\
\phi_2&=(6,0,12,12,16,11)\theta,\\
\phi_3&=(0,2,11,12,17,2)\theta,\\
\phi_4&=[13]\phi_1+[24]\phi_2+[10]\phi_3.
\end{aligned}
\]
The first three forms are independent, and all three recurrence coefficients are nonzero. Let q₅=(10,11,24,0,0,1), q₄=(6,23,14,0,1). Their products with θ belong to the span of φ₁,φ₂,φ₃, by the same recorded input. The new short Bezout identity is
\[
(5,22,13,17)q_5+(14,22,19,17,13)q_4=1.
\]
Products and addition in this identity are polynomial operations over the encoded F₂₅. Direct multiplication verifies it; a novel Euclidean check took 0.1 seconds and did not replay the older Cartier certificate.

Consequently the three polynomial coefficients of φ₁,φ₂,φ₃ have no common finite zero. Since some has degree five, their homogenizations also have no common zero at infinity. They give a basepoint-free map P¹→P² pulling back O(1) to O(5). Its image is not a line, by their independence. The extension degree therefore divides five and cannot be five, since that would give a line image. It is ONE. Thus their ratios recover the entire x-field.

Suppose two actual pullbacks satisfy h₂*φ₁=c h₁*φ₁. Cartier naturality gives h₂*φ_j=c^(25^{−(j−1)})h₁*φ_j for j=1,2,3,4. Compare the two pulled recurrence identities. Independence and the three nonzero coefficients give c^(25^{−3})=c=c^(25^{−1})=c^(25^{−2}), hence c²⁵=c. The three φ_j therefore have the same proportionality scalar. Their ratios recover x, so h₂*x=h₁*x. Their first polynomial coefficient then gives h₂*θ=c h₁*θ. The accepted theta recognition yields h₂=γh₁ with γ∈Aut(X)=C₃. In particular their actual embedded X-fields coincide.

## The actual sixteen-power image

Let I=span_k{u¹⁶:u∈W}⊂H⁰(T,ωT). Characteristic five and the base-five expansion 16=1+3·5 identify the universal pure-power span with
\[
\mathcal H=W\otimes\operatorname{Sym}^3(W^{(5)}).
\]
Indeed (Σλ_j e_j)¹⁶=(Σλ_j e_j)(Σλ_j⁵e_j⁵)³. The relevant coefficient monomials λ_i·∏λ_j^(5β_j), Σβ_j=3, are all distinct: reducing their exponents modulo five recovers the unique i, and then recovers β. The cubic multinomial coefficients are nonzero because 3! is invertible. Over the infinite field k these monomials span all coefficients of the indicated tensor functor. Multiplication into H⁰(T,L¹⁶) may have a kernel; only its actual image I is used. In particular dim I≤n_r. No assertion about all Sym¹⁶W or all canonical sections is needed.

Let Θ=span_k{θ_i}, with θ_i=h_i*θ=u_i¹⁶. Then Θ⊂I. Put
\[
P=C^2\Theta+C^4\Theta+C^6\Theta.
\]
Absolute Cartier is semilinear, so each displayed image has dimension at most dim Θ≤n_r. Therefore p₀=dim P≤3n_r. The pulled recurrence makes DP⊂P. Its nonzero constant coefficient [13] expresses C²θ_i in DP, while the other two sets of generators already lie in DP. Hence DP=P, and D is a bijective 25^(−1)-semilinear operator on P.

By the standard Lang fixed-basis lemma for a bijective semilinear operator over an algebraically closed field, choose a D-fixed basis of P. In that basis a vector ψ satisfies
\[
D^3\psi=[13]\psi+[24]D\psi+[10]D^2\psi
\]
if and only if every coordinate z satisfies
\[
[13]z^{25^3}+[24]z^{25^2}+[10]z^{25}-z=0.
\]
This polynomial has degree 25³ and derivative −1, so it has exactly 25³ roots. Its roots form an F₂₅-vector space, since its coefficients lie in F₂₅. The entire vector solution set therefore has exactly 25^(3p₀) elements. Its nonzero vectors meet at most (25^(3p₀)−1)/24 distinct k-lines: every line containing a solution contains all twenty-four nonzero F₂₅ multiples of that solution.

Every ψ_i=C²θ_i is nonzero and satisfies the displayed recurrence. Recognition from the first part shows that proportional ψ_i imply proportional θ_i, hence identical section lines ku_i. Conversely proportional section lines give proportional ψ_i. Thus the m distinct original section lines inject into those finitely many solution lines, giving
\[
m\le\frac{25^{3p_0}-1}{24}\le B_r.
\]
The recurrence is not treated as a k-linear operator polynomial. Its coordinate equation is semilinear, and this distinction is essential.

## Geometric sharpening in only r variables

The birational plane map from the first section has an explicit degree-eight homogeneous inverse. Write p_j for the polynomial coefficient of φ_j. For three independent variables R₁,R₂,R₃, take the first subresultant in X of the two degree-five polynomials R₁p₂(X)−R₂p₁(X) and R₁p₃(X)−R₃p₁(X). Its linear polynomial has the form B(R)X−A(R), where A,B are homogeneous of degree eight: each coefficient is a determinant of size eight with entries linear in R. On the generic point R=(p₁(x),p₂(x),p₃(x)), these polynomials have gcd X−x because the plane map is birational and basepoint free. Thus B is nonzero there and x=A(R)/B(R). No projective normality of the actual spin image is used.

Fix a basis e₁,…,e_r of W and a nonzero rational differential frame ρ on T. Introduce AFFINE parameters t₁,…,t_r and put
\[
s(t)=\sum_{j=1}^r t_j^{25^3}e_j,\qquad
\Xi(t)=s(t)^{16},\qquad R_j(t)=C^{2j}\Xi(t)/\rho\quad(j=1,2,3).
\]
Cartier acts only on the T-variable; the displayed expression denotes its coefficientwise semilinear extension on each specialized form. These are polynomial expressions in the parameters with rational T-coefficients. Indeed replacing each original coefficient λ_j by t_j^(25³) clears the inverse powers through C⁶. Their total parameter degrees satisfy
\[
\deg_t\Xi\le250000,\qquad
\deg_t R_1\le10000,\quad \deg_tR_2\le400,\quad \deg_tR_3\le16.
\]
This follows by expanding the actual pure sixteen-power monomials and applying Cartier to their fixed canonical forms, not to a variable frame as though it were constant.

Set A=A(R(t)), B=B(R(t)), f=Ξ/ρ, and δ=(B dA−A dB)/ρ. The derivatives here are actual rational derivatives on T. Put F_hom(A,B)=B¹⁰F(A/B). The relevant parameter-degree bounds are
\[
\deg_t A,\deg_tB\le80000,\qquad
\deg_t\delta\le160000,\qquad \deg_t f\le250000.
\]
Consider the rational-function identity on T
\[
\delta^3B^{14}=F_{\rm hom}(A,B)^2f^3.\tag{*}
\]
Both sides are polynomials in the r parameters, with coefficients in k(T). The left side has parameter degree at most 3·160000+14·80000=1600000, while the right side has degree at most 20·80000+3·250000=2350000. Expanding in a basis of the finite k-span of their rational-function coefficients gives finitely many ordinary polynomial equations, each of degree at most 2350000. This coefficient expansion needs no field-of-definition or divisor-size bound on T.

Restrict to the open locus where f,B,δ,F_hom are nonzero as rational functions on T. Put x=A/B and z=dx/Ξ=δ/(B²f). Identity (*) is exactly z³=F(x)² there. Consequently
\[
y=z^2/F(x),\qquad y^3=F(x),\qquad y^2=z,\qquad dx/y^2=\Xi.
\]
Thus EVERY good solution reconstructs an ACTUAL separating map h:T→X with h*θ=Ξ. Nonzero dx makes x and the map separating. The rational map extends uniquely to the smooth projective curves. Riemann–Hurwitz gives 16 deg L=16 deg h+deg Different_h, so deg h≤deg L. Such maps form a FINITE set: the bounded-degree Hom scheme is of finite type, and its tangent space at h is H⁰(T,h*TX)=0, since deg TX=−16. The same standard rigidity applies if some bounded-degree maps are inseparable, though those are outside the chosen good locus.

For each fixed pulled theta form, there are at most sixteen sections s with s¹⁶ equal to it. Any two have ratio a sixteenth root of unity in the rational function field of the connected curve, hence differ by a constant root of unity. The parameter substitution λ=t^(25³) is bijective on k-points. Therefore the good solution set of (*) is FINITE. It is an open subset of its polynomial zero locus, so every good solution is an isolated point of that zero locus. The affine isolated-point Bézout bound gives at most 2350000^r good points, even if bad positive-dimensional components occur elsewhere.

Every original normalized u_i gives a good point: its three Cartier forms reconstruct its actual x-coordinate, B is generically nonzero, and its actual x-map is separating. Distinct section lines give distinct chosen parameter points. Hence m≤2350000^r. This argument also proves the additional assertion for arbitrary actual separating maps whose fixed theta forms have sixteen-power roots in W. It assumes neither a recurrence for arbitrary s nor a span/closure identity for the original orbit.

## Actual stabilizer-kernel quotient

Let S⊂G stabilize one original section line ku₀. Such an element sends the actual θ₀ to a scalar multiple of itself, so theta recognition gives a unique automorphism γ_g∈Aut(X)=C₃ with h₀g=γ_g h₀. These automorphisms give a homomorphism from S to C₃ (up to the harmless opposite-action convention). Let S₀ be its kernel and b=|S/S₀|∈{1,3}. Then S₀ fixes the ACTUAL X-map, while S₀⊂G also fixes the actual Y-map.

The free action of G on T makes the quotient Z=T/S₀ smooth, connected and finite étale under T. Both original endpoint maps factor through Z, and their lower maps are finite étale by the actual towers. Orbit-stabilizer gives |G|=m|S|=mb|S₀|. Since |G|=8d,
\[
\deg(Z/X)=d/|S_0|=bm/8,\qquad
\deg(Z/Y)=|G|/|S_0|=bm.
\]
These are actual field quotients, with no simultaneous closure assumed. Substituting the two preceding m bounds proves the stated fixed-rank replacement bound.

## Packet decomposition and its limit

For completeness, the recurrence also supplies a canonical exact/stable decomposition for each original theta. Put A=[13], B=[24], E=[10] and
\[
\tau=A^{-1}(\phi_3-B\phi_1-E\phi_2),\qquad \eta=\theta-\tau.
\]
Then Dτ=φ₁=Dθ. The accepted fixed-X stable-rank calculation gives ker C²=ker C, so Cη=0. The degree-five coefficient of τ is [21], hence η≠0. The G-orbit of the τ_i lies in a finite Cartier-bijective packet: taking its C-translates gives the span of the pulled fixed six-dimensional stable Cartier space. That space is basepoint free by the accepted fixed-X first-jet separation theorem. A C-fixed basis identifies the resulting G representation with one over F₅, and its actual torsor descent supplies a finite coefficient on Y surjecting onto ωY. The exact η_i give the usual separate finite coefficient map to B_Y.

Neither finite Y-packet is shown stable under X-side monodromy, and the recurrence does not supply a return operator on W. The bound above uses only the fixed-rank sixteen-power image and the actual stabilizer quotient. An unbounded sequence of spin ranks remains possible under this theorem.
