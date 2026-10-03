# Proof: the exact noncyclic contact-eight branch fiber

Version2,2 October2026. Computation-free scoped argument; the whole branch-fiber argument and focused unconditional-norm extension passed review. [Statement](../../Theorems/cartier_and_spin/contact_eight_noncyclic_branch_fiber.md).

## Saturation of the radical zero bound

Use the actual one-leg Galois source $q:T\to Y$ of degree $8d$, actual conjugate maps $h_i:T\to X$ of degree $d$, and $E=q^*J$. The line quotient $Q_i=E/(E\cap h_i^*U)$ has degree $3d$ when contact is $8d$. Its actual dual radical map
\[
\ell_i=h_i^*O_X(-3O)\longrightarrow Q_i^*\otimes\omega_T
\]
has zero divisor $Z_i$ of degree $16d$. Let $a(Q')$ be the maximum local Smith exponent of $J\subset B_Y$. Primitive source and target generators in Smith frames bound each zero order by $a(Q')$. Thus $16d\le8d\sum a(Q')$.

The total defect length is three. If any local defect is noncyclic, $\sum a(Q')\le2$, so equality holds everywhere in this estimate. Hence $\sum a(Q')=2$, and every point of every actual defect fiber has radical zero order exactly its local maximum. The only noncyclic shapes with this maximum sum are $(1,1)$ plus a distinct simple point, and $(2,1)$ at one point. The shape $(1,1,1)$ has maximum sum one and is impossible.

For ANY Smith shape the exact sequence
\[
0\to h_i^*U/(E\cap h_i^*U)\to B_T/E\to B_T/(E+h_i^*U)\to0
\]
identifies the last length with the zero order of $Q_i\to B_T/h_i^*U$, equivalently the radical zero order. Therefore local contact is total Smith length minus radical zero order. At the noncyclic point $Q$ it is exactly ONE in both shapes. In the $(1,1)$-plus-simple shape it is zero at the simple point. This holds for every actual map $h_i$ and every point of the relevant $q$ fiber.

## Infinity cannot occur alongside the forced branch sheets

Since $I_i\subset E\cap h_i^*U$, source contact is a quotient of $h_i^*U/I_i$. Ordinary finite sheets have no source loss, so contact one forces each sheet over $Q$ to lie at a finite branch or infinity. The actual reduced infinity divisor $h_i^{-1}(O)$ has degree $d$, while $q^{-1}(Q)$ has degree $8d$, so a finite branch sheet exists.

At $Q$, in either noncyclic shape, the fiber image of $E\to B_T$ has dimension TWO. A finite branch original-net image also has dimension two and has primitive orders one and four: it contains the intrinsic order-four line $F_4$, and its other generator has nonzero order-one coefficient. Thus it equals the two-dimensional image of $E$.

The intrinsic filtration by primitive order is independent of formal parameter choice. The branch plane meets the subspace of primitive order at least two exactly in $F_4$. An infinity original-net fiber image is a line of primitive order exactly two, by the accepted original orders $(2,8,11)$. This line is not $F_4$, and cannot be contained in the branch plane. But every original-net image must be contained in the image of $E$. Therefore an infinity sheet cannot occur over $Q$.

Every one of the $8d$ actual points of $q^{-1}(Q)$ is consequently a finite branch point for $h_i$, proving the reduced divisor inclusion $q^*Q\le h_i^*R$. Étaleness of both maps makes both divisors reduced. Since $\deg h_i^*R=10d$, the difference $D_i$ is effective of degree $2d$.

No generic full-rank radical-orbit hypothesis is used. In particular the contact-seven full-span proof cannot simply be reused at contact eight, where rank three is numerically possible.

## Unconditional actual norm constraints

The fixed cubic curve has $R\sim10O$ and $\omega_X\sim16O$. Put $F_0=\omega_Y(-2Q)$, of degree zero. The actual étale canonical identities give
\[
2D_i\sim20h_i^*O-2q^*Q\sim4h_i^*O+q^*F_0.
\]
The accepted [fixed arithmetic](../../Theorems/curve_arithmetic/fixed_pair_arithmetic.md) makes J(X) geometrically simple of dimension nine. Any homomorphism from the two-dimensional J(Y) has image an abelian subvariety of dimension at most two, and hence is zero. In particular $\operatorname{Nm}_{h_i}\circ q^*=0$ on J(Y), regardless of simplicity of J(Y). Push the displayed divisor identity along the ACTUAL finite map $h_i$ to obtain $2F_i\sim4dO$, where $F_i=(h_i)_*D_i$ has degree $2d$ and is supported on $R$. Each finite branch point satisfies $3(r-O)\sim0$, from the divisor of $x-x(r)$. Thus $F_i-2dO$ is also three-torsion. Its being both two-torsion and three-torsion gives $F_i\sim2dO$.

Write $F_i=\sum k_r r$. Reducedness and actual degree $d$ give $0\le k_r\le d$ and $\sum k_r=2d$. Choose a function with divisor $F_i-2dO$. The cubic automorphism fixes every point in its divisor, so its quotient with its translate has zero divisor and is constant. The function is a cubic eigenfunction $y^j f(x)$, $j\in\{0,1,2\}$. Its branch valuations are therefore all congruent to $j$ modulo three. As there are ten branch points, $\sum k_r\equiv10j\equiv j\pmod3$, so $j\equiv2d\pmod3$ and all $k_r\equiv2d\pmod3$.

For any $Q'$, the class $\operatorname{Nm}_{h_i}q^*O(Q')$ is independent of $Q'$ because differences map through that same zero Jacobian homomorphism. At Q, $h_{i*}q^*Q=dR-F_i\sim8dO$, fixing the common class. Hence $\operatorname{Nm}_{h_i}q^*O(Q')=O_X(8dO)$ for EVERY target point. Only Q is asserted to have its actual fiber concentrated at finite branches.

These constraints leave feasible distributions at larger degrees (for example $d=5$, all ten $k_r=1$). They do not prove $Q$ Weierstrass, produce an actual second saturation clump, or decide common-cover existence. A global contradiction from the residual degree-two divisor remains open.
