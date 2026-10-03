# Proof: equal residues and equal second jets double every paired factor

Version1,3 October2026. Whole scoped review PASS; see the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_conjugate_ordinary_double_factor.md). The original source and both actual maps are retained. [Independent audit](../../Research/audits/ACTUAL_Q0_TENSOR_ONE_TRIPLE_INFINITY_AUDIT_2026_10_03.md).

Center and scale both original fixed copies as in the exact jet lemmas, retaining their independent first sign ε, p²=ν,ρ and K=ερ−ONE. At each ordinary shared pole with local parameter z−a, the exact first jet fixes the x1 residue
\[
l_1=aKp/(3\rho).
\]
It is nonzero and is the SAME on BOTH sheets of a conjugate pair. The leading ratio then gives the same x2 residue on both sheets. Since Y has opposite nonzero values there, the odd residues must vanish: b(a)=c(a)=ZERO. Thus h=gcd(b,c) has positive multiplicity t there. This step explicitly retains the zero odd-residue boundary instead of dividing by it.

The exact odd q0 identity gives A2c=A1b. Write b=hb0,c=hc0 with b0,c0 coprime. Then A1=c0L,A2=b0L for a polynomial L. At the conjugate pole, the nonzero EVEN residues imply c0(a),b0(a),L(a) are nonzero, and their ratio satisfies
\[
\alpha=b_0(a)/c_0(a)=\rho/a,\qquad \alpha^2=a.
\]
The latter follows from a³=ρ², the calibrated pole coordinate.

Put M0=zc0²−b0². The exact even q0 identity is
\[
M_0(h^2\Phi-zL^2)=z(z^3-1)J^2.
\]
At a, the second factor has value−aL(a)²≠ZERO. Consequently M0 has order TWO there, or THREE when a³=ONE. In particular M0′(a)=ZERO. Differentiating M0 gives
\[
\left.(b_0/c_0)'\right|_a=1/(2\alpha).
\]
For G0=z²c0−ρb0, direct differentiation now gives
\[
G_0(a)=0,\qquad G_0'(a)=\frac32a c_0(a)\ne0.
\]
Indeed the c0′ terms cancel because ρ α=a², while 2a−ρ/(TWO α)=THREE a/TWO. Thus G0 has EXACT order ONE at a, including the cube/pole coincidence case.

The odd part of the regular finite-part function ξ=x2−ρx1 is
\[
\xi_{\mathrm{odd}}=hG_0Y/(z^2J).
\]
It has EXACT order t at a: Y,z are units and J has order ONE. The exact first jet gives the same finite ξ value on both conjugate sheets. The exact second jet gives the same derivative there, because both copies' B coefficients are global constants and the original residues l1 are equal. Those two equalities force ξodd(a)=ξodd′(a)=ZERO. Therefore t≥TWO. This is a consequence of the actual tensor; it is not an assumption about h or a local completion.

## The global degree obstruction

Put the triple infinity poles at ZERO,infinity and use deg Φ=TWO g+ONE. Exact odd pole bounds give deg b,c≤q+ONE−g. They remain valid at g=ZERO, where B=k(√z) and Φ can be normalized to z. Both odd polynomials are nonzero by their ACTUAL poles: each xi has an odd-order triple pole at its own Weierstrass Ri, which a pure even function of z cannot supply. Independently, at a single ordinary pole cancellation on the other sheet forces both odd residues nonzero. At a paired coordinate the calibrated nonzero leading ratios on BOTH sheets forbid a pure-even map paired with a pure-odd map, since those ratios would have opposite signs. If both odd parts vanished, the joint x-field would have even index in B, also contradicting the accepted index ONE or THREE. No claim that a vanishing even part makes a map constant is needed.

Each of the v conjugate-pair coordinates contributes at least TWO to deg h, so deg h≥TWO v. The residual M0 has degree at most TWO(q+ONE−g−TWO v)+ONE. It is nonzero: zc0²=b0² contradicts valuation parity at ZERO for nonzero b0,c0.

At each conjugate-pair coordinate M0 has order at least TWO, as above. At each of the q−v single-pole coordinates, cancellation of the opposite sheet forces M0 to vanish at least ONCE. Indeed h is nonzero there, since the required odd residue is nonzero. These are distinct coordinates, so
\[
\deg M_0\ge2v+(q-v)=q+v=u.
\]
Combining the two degree bounds yields q+THREE−TWO g≥FIVE v. All extra common zeros or higher cube-coincidence orders only strengthen the obstruction. No pole coincidence or polynomial degree drop has been discarded.
