# Common Cartier subbundles and their graded zero divisors

Version4,20September2026. Let $k$ be algebraically closed of odd
characteristic $p$, and let $X\xleftarrow f Z\xrightarrow gY$ be
an actual coreless finite étale span of smooth projective connected
hyperbolic curves. Write $B_C=F_{C*}\mathcal O_C/\mathcal O_{C^{(1)}}$,
identified with locally exact differentials. Suppose saturated
subbundles $U_X\subset B_X$, $U_Y\subset B_Y$ of rank $r$ have
the SAME pullback subbundle inside $B_Z$.

There are canonically induced effective divisor pairs
$D_{i,X},D_{i,Y}$, $1\le i\le r$, such that
\[
f^*D_{i,X}=g^*D_{i,Y},\qquad
0\le D_{1,C}\le D_{2,C}\le\cdots\le D_{r,C}.
\]
The induced filtration of the dormant connection $F_C^*U_C$ has
rank-one graded pieces
\[
\operatorname{gr}_i(F_C^*U_C)=\omega_C^i(-D_{i,C}),
\qquad 1\le i\le r,
\]
and its adjacent connection maps have zero divisors
$D_{i,C}-D_{i-1,C}$ for $i\ge2$. In particular
\[
p\deg U_C=r(r+1)(g(C)-1)-\sum_{i=1}^r\deg D_{i,C}.
\]
No strong semistability of $U_C$ is assumed.

There is also a sharp local bound. At any point $x$, there are
distinct integers $0\le e_1<\cdots<e_r\le p-2$ such that
\[
\operatorname{ord}_x D_{i,C}=e_i-i+1.
\]
In particular every coefficient of every $D_i$ is at most
$p-1-r$. These are ordinary jet orders below $p$, so no
classical-order assumption on an arbitrary global linear series
is being made.

## Consequences for a clumpless span

If there is no clump, every $D_{i,C}$ is zero. If in addition
$p\nmid g(Y)-1$, there is NO proper nonzero common saturated
subbundle of $B$. Thus the common Cartier bundle is irreducible
in this precise two-map sense. This does not assert that $B_Y$
has no subbundles on its own.

More generally, if a clump exists with reduced endpoint divisors
$S_X,S_Y$ and $R=\deg S_Y$, then
\[
D_{i,C}=\lambda_i S_C,\qquad
0\le\lambda_1\le\cdots\le\lambda_r,
\]
with the SAME integers on both endpoints, and
\[
p\deg U_Y=r(r+1)(g(Y)-1)-R\sum_i\lambda_i.
\]

## Every proper case in characteristic five

Suppose $p=5$, $g(Y)=2$, and singleton clumps are excluded.
If $U$ is proper, a clump necessarily exists and
\[
D_{i,C}=(4-r)S_C\quad(1\le i\le r),\qquad
5\deg U_Y=r(r+1)-r(4-r)R.
\]
Thus $F_C^*U_C$ is a genuine dormant rank-$r$ oper with graded
lines $\omega_C^i(-(4-r)S_C)$. The possible degrees are
\[
\begin{array}{c|ccc}
r&1&2&3\\\hline
\deg U_Y&(2-3R)/5&(6-4R)/5&(12-3R)/5.
\end{array}
\]
The bundle $U_C$ remains stable after EVERY finite étale pullback.
For $r\ge2$ it is not strongly semistable. In every rank above,
\[
H^0(C',U_C|_{C'})=0.
\]
In particular the only nonnegative proper case is $r=3$, $R=4$,
with degree zero and graded defects all equal to $S$.
Its symplectic annihilator $A_C=U_C^\perp\subset B_C$ has
degree $-2(g(C)-1)$, and the adjoint line map satisfies
\[
F_C^*A_C\simeq\omega_C(-3S_C).
\]
The isomorphism here identifies the actual image of
$F_C^*A_C\to\omega_C$, not its saturation.

## The unique possible line for either candidate pair

For either selected pair, suppose a clump exists, with size
$R=4,9,14,\ldots$ on $Y$. There is a UNIQUE compatible line
bundle pair $A$ on the Frobenius-twisted span with
\[
F_C^*A_C\simeq\omega_C(-3S_C).
\]
Adjunction of the canonical inclusion in $\omega_C$ gives an
actual common map $A\to F_*\omega$. Its Cartier image in
$\omega^{(1)}$ is either zero or nonzero, with the following
complete alternatives.

- If $R>4$, the image is zero and $A$ is a saturated common line
  subbundle of $B$.
- If $R=4$, put $\tau_C=\mathcal O_C(S_C)\omega_C^{-2}$,
  retaining its common identification. If $\tau^2\simeq\mathcal O$
  as a common line, the Cartier image is nonzero and $B$ has NO
  common line subbundle. Otherwise $A$ is a saturated common line
  subbundle of $B$.

Whenever a common saturated line in $B$ exists, it is exactly this
$A$. Its degree on $Y^{(1)}$ is $(2-3R)/5$. In particular a
four-point clump with $\tau^2\ne\mathcal O$ actually produces
the rank-three degree-zero subbundle $A^\perp$ described above.
This last assertion uses the established all-two-torsion Bol
vanishing on the two selected genus-two endpoints. The graded
divisor theorem itself has no such endpoint hypothesis.

## In the line case the entire common flag exists

Whenever this common line $A$ exists, there is a UNIQUE common
Lagrangian rank-two subbundle $U_2\subset B$, and
\[
0\subset A\subset U_2\subset A^\perp\subset B
\]
is the full list of proper nonzero common saturated subbundles.
Thus these subbundles are totally ordered, not merely bounded
in degree. Their four successive quotient degrees on $Y^{(1)}$
are
\[
\frac{2-3R}{5},\quad \frac{4-R}{5},\quad
\frac{6+R}{5},\quad \frac{8+3R}{5}.
\]
The rank-two construction uses the actual primitive exterior square
$\Lambda^2B\otimes\omega^{-1}=\mathcal O\oplus F_*\omega^{-2}$.
A unique common line in its second summand is forced to have
zero Plücker quadratic, and hence determines $U_2$.

## The four-point two-torsion branch

Suppose $R=4$ and $\tau^2=\mathcal O$ as a common line.
There are no common subbundles of ranks one or three, and the
rank-two classification is as follows.

- If $\tau\ne\mathcal O$, there is NO proper nonzero common
  saturated subbundle of $B$.
- If $\tau=\mathcal O$, there are EXACTLY TWO proper nonzero
  common saturated subbundles $U_+,U_-$, both of rank two and
  degree $-2(g(C)-1)$ on endpoint $C^{(1)}$. They are mutual
  symplectic orthogonal complements. Their restricted pairings
  are generically nondegenerate and vanish simply at $S^{(1)}$.
  They coincide as two-planes over every point of $S^{(1)}$ and
  are transverse elsewhere. The cokernel of
  $U_+\oplus U_-\hookrightarrow B$ is a rank-two vector bundle
  on the reduced divisor $S^{(1)}$.

Thus, for the selected pairs, this completes the proper common
subbundle classification in EVERY clump case. In terms of the
primitive canonical zero multiplicity, the two alternatives here
are respectively $e=2$ and $e=1$. Irreducibility of the common
Cartier bundle therefore does not by itself distinguish no clump
from the four-point multiplicity-two clump.

Both selected candidate pairs satisfy the singleton exclusion.
This constructs and classifies subbundles CONDITIONAL on a clump;
it does not construct a clump or exclude either remaining common-cover
case. Author proof with focused local filtration, finite-duality
pairing, and degree checks.
[Proof](../../Proofs/cartier_and_spin/common_cartier_subbundles.md).
