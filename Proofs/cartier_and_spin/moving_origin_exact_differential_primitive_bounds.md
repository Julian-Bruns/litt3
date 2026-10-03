# Proof: the four exact directions and their two primitive boundaries

Version1,3 October2026. Whole scoped review [PASS](../../Research/audits/Q0_DEGREE_SIX_NONREAL_AND_JET_BUDGET_AUDIT_2026_10_03.md); see the [exact statement](../../Theorems/cartier_and_spin/moving_origin_exact_differential_primitive_bounds.md). No arithmetic program is used.

At P the orders of z,y,dz and σ are −TWO,−FIVE,−THREE andTWO. Riemann–Roch gives h0(ω(5P))=SIX. Its following SIX displayed forms have distinct orders and therefore are a basis:
\[
\sigma,\quad z\sigma,\quad z^2\sigma,\quad z^3\sigma,\quad dz,\quad z\,dz.
\]
Their orders are TWO,ZERO,−TWO,−FOUR,−THREE,−FIVE respectively.

Write Φ=z⁵+c₄z⁴+c₀. Since σ=y⁻⁵ Φ²dz, the rational Cartier rule gives
\[
C(z^j\sigma)=y^{-1}C(z^j\Phi^2dz).
\]
For a polynomial differential it keeps precisely exponents FOUR moduloFIVE, takes coefficient fifth roots and replaces exponent FIVE m+FOUR by m. The polynomial identity
\[
\Phi^2=z^{10}+2c_4z^9+c_4^2z^8+2c_0z^5+2c_4c_0z^4+c_0^2
\]
therefore gives
\[
C(\sigma)=\bigl((2c_4c_0)^{1/5}+(2c_4)^{1/5}z\bigr)\sigma,
\qquad C(z\sigma)=c_4^{2/5}z\sigma,
\qquad C(z^2\sigma)=C(z^3\sigma)=0.
\]
Also C(dz)=C(z dz)=ZERO because these are derivatives of z and z²/TWO. The first TWO images are independent because c₄c₀≠ZERO. Thus the exact kernel is precisely the stated FOUR-dimensional span. Rational Cartier's kernel equals rational exact differentials; no bounded primitive conclusion is built into that fact.

Twisting the actual exact-differential sequence by O(P^(1)) gives
\[
0\longrightarrow B_Y(P^{(1)})\longrightarrow F_*\omega_Y(5P)
\xrightarrow{C}\omega_{Y^{(1)}}(P^{(1)})\longrightarrow0.
\]
Its global kernel is exactly the displayed space. The corresponding local primitive sequence is
\[
0\longrightarrow O_{Y^{(1)}}\longrightarrow F_*O_Y(4P)
\xrightarrow{d}B_Y(P^{(1)})\longrightarrow0.
\]
Locally at P the derivative primitives t⁻ONE,…,t⁻FOUR supply all four principal exact directions; the kernel consists of fifth powers that are regular there. Hence its global connecting map can land in H¹(O), rather than produce a primitive in L(4P). In the present case h0 B(P)=FOUR and dL(4P) has dimensionTWO, so the missing TWO directions are exactly a nonzero global obstruction. Ordinary Y does not remove this twisted obstruction.

The hyperelliptic pole semigroup, or direct examination of invariant and anti-invariant functions, gives
\[
L(4P)=\langle1,z,z^2\rangle_k,
\qquad L(5P)=\langle1,z,z^2,y\rangle_k.
\]
Differentiating y²=Φ in characteristicFIVE gives
\[
dy=\frac{\Phi'}{2y}\,dz=2c_4z^3\sigma.
\]
The derivative images are consequently exactly those in the statement. Their displayed nonzero generators are independent, as already seen from their differential orders. Thus z²σ is not in dL(5P). It is nevertheless rationally exact by the earlier Cartier calculation. Any rational primitive must exceed the asserted global bound, either at P or elsewhere.

The hypothesis S=P is not derived by this calculation. In particular the two extra exact directions cannot be silently discarded in a conditional scalar-annihilator or identity-row argument.
