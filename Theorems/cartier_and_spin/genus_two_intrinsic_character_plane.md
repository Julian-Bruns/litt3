# The intrinsic character plane and its finite-local complement

Version3,2 October2026. Author exact derivation and verification;
[focused root mathematical review](../../Research/audits/INTRINSIC_CHARACTER_COMPLEMENT_AUDIT_2026_10_02.md) PASS.
Let $Y:V^2=(x^4-1)(x-S)$ over $\overline{\mathbf F}_5$, with
$S(S^4-1)\ne0$, and let $F:Y\to C=Y^{(1)}$.
Write $\eta_0=dx/V$, $s^2=-S$, and use
$h=h_s$, $\ell=h^2$, $Q_O=2\ell(sx^2-V)$ and $Q_x=\ell/(2s)$
from the [universal character theorem](actual_two_map_twisted_cartier_characters.md).
Put $R_s=F(P_s)$ and $A=O_C(4R_s-4O_C)$.

The two maps $A\to B_Y$ represented by $[Q_O],[Q_x]$ give a
saturated plane $N\simeq A\oplus A$, with no saturation defect.
It has degree zero and determinant $A^2$. Its restricted symplectic
pairing has EXACT divisor $2R_s$ as a section of
$\omega_C\otimes A^{-2}$; in particular N is generically nonisotropic.

The symplectic complement $E=N^\perp$ has degree zero, determinant
$A^2$, and
\[
\boxed{F^*E\simeq O_Y^2.}
\]
More precisely it is the unique nonsplit extension, up to isomorphism,
\[
\boxed{0\longrightarrow A^3\longrightarrow E
\longrightarrow A^4\longrightarrow0.}
\]
Its nonzero class lies in the one-dimensional $H^1(C,A^{-1})$ and is
killed by Frobenius. Thus E is a nontrivial finite-local coefficient
of height one, not a split sum of its characters. Its extension remains
nonsplit after every finite etale pullback.

Both $F^*N$ and $F^*E$ evaluate everywhere onto $\omega_Y$ with
kernel $\omega_Y^{-1}$, and both second-fundamental divisors are the
reduced sum of all SIX Weierstrass points. The generically isomorphic
map $N\oplus E\to B_Y$ has cokernel of length four, supported at R_s;
its determinant divisor is $4R_s$.

There is a universal torsion relation
$5(P_s-O_Y)\sim O_Y-W_S$, where $W_S=(S,0)$ is the moving
Weierstrass point. For a double-zero eta, the isotropic span of its
A embedding and the canonical A-cubed embedding has degree zero
and is exactly $A\oplus A^3$ for FIVE of the six choices. For the
moving choice $\eta\in k^*(x-S)\eta_0$, its saturation has degree
one and defect exactly R_s. No full plane census is claimed.

For an ACTUAL same-source span in the universal character theorem,
write $P=h^{(1)*}P_X$ on $T^{(1)}$, with $\deg h=n$ and
$\deg q=8n$. The shared canonical line $q^{(1)*}A$ lies in
$q^{(1)*}N$ and P. The second character embedding $[q^*\ell]$
NEVER lies in P: its fourth p-basis coefficient with respect to any
of the six original $q^*Q_\eta$ is nonzero, whereas P consists of
a linear and a cubic class in that p-basis.

The saturated intersection $K=P\cap q^{(1)*}E$ has rank one.
Generically $P=q^{(1)*}A\oplus K$. There is an effective projection
loss divisor $\tau\le2q^{(1)*}R_s$ with
$\deg K=7n-\deg\tau$. The line K cannot be $q^{(1)*}A^3$.
Its nonzero map to $q^{(1)*}A^4$ has a NONEMPTY effective zero
divisor D. With $H=h^{(1)*}O_{X^{(1)}}$,
\[
\boxed{\tau-D\sim7H,\quad
\deg D=\deg\tau-7n>0,\quad -9n\le\deg K<0.}
\]
The loss at each qR_s point is zero, one or two; no uniform exact
value is asserted. For the original admissible selected divisor
$E_{sel}$, effective G and reduced
$\Delta=h^*R_X-E_{sel}=q^*W_\eta$, projection loss is EXACTLY two
at every point of $q^*P_s\cap E_{sel}$ (transported to $T^{(1)}$).

In the MOVING-BRANCH eta chart, at least7n of the8n points over R_s
have loss two, so $\deg\tau\ge14n$ and $\deg K\le-7n$.
Let B be the reduced divisor of all loss-zero and loss-one points.
Then $\deg B\le n$, and the ORIGINAL G contains B. More precisely,
\[
\boxed{D=G+\tau-q^{(1)*}R_s}
\]
as exact divisors, not merely divisor classes.

For every one of the six eta charts the intrinsic degree-one plane
$\Pi_\eta=\operatorname{Sat}([Q_\eta],[Q_\eta^2/2])$ has canonical
line $A_\eta$. The quotient pairing of P with $q^{(1)*}\Pi_\eta$
has zero divisor EXACTLY the original G, including multiplicities.
In the original source normal form its rational pairing is
\[
\langle[\phi],[Q^2/2]\rangle=2(A_0/B_0)dQ^{(1)},\qquad
Q=q^*Q_\eta,\quad B_0=Q+a_0^5.
\]
After the two rational quotient-section divisors are accounted for,
the resulting divisor is G with no extra translation-dependent term.
The contact corollaries of Versions2 and3 are author checked;
the linked root review
covers the complement and projection statements of Version1.
All statements preserve the original maps and
the selected source zeros. They do not produce a compatible common
finite coefficient or solve the unmarked common-cover problem.

[Proof and exact jet verification](../../Proofs/cartier_and_spin/genus_two_intrinsic_character_plane.md).
