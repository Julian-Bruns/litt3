# Strongly semistable coefficients generate the Cartier bundle by trace

Version6, 1 October2026. Let $k=\overline{\mathbf F}_5$ and retain two
actual finite étale maps from the same smooth projective connected source,
\[
X\xleftarrow h Z\xrightarrow gY,\qquad g(X)>1,\qquad g(Y)=2.
\]
Assume the span is coreless, singleton clumps are excluded, and
$h^*H^0(X,\omega_X)\cap g^*H^0(Y,\omega_Y)=0$. All Cartier identifications
are the actual common ones $B_Z=h^{(1)*}B_X=g^{(1)*}B_Y$.

Let $V_X$ be a strongly semistable vector bundle with a nonzero morphism
$V_X\to B_X$, and suppose its normalized slope satisfies
\[
\mu=\frac{\mu(V_X)}{g(X)-1}>-\frac25.
\]
Write $I_X$ for its actual image. For a coherent subsheaf $M\subset B_Z$
define complete unsaturated transport by
\[
T_h(M)=h^{(1)*}\operatorname{im}
\bigl(\operatorname{Tr}_h:h^{(1)}_*M\longrightarrow B_X\bigr),
\]
and similarly $T_g$. The trace is the actual finite étale trace under the
common identification; no covering degree is inverted. For a saturated
subbundle set $\mathcal T_h(A)=\operatorname{Sat}_{B_Z}T_h(A)$, and
similarly for $g$. Saturation commutes with finite étale pullback.

Put $A_0=h^{(1)*}\operatorname{Sat}_{B_X}I_X$ and
\[
A_1=\mathcal T_g(A_0),\qquad A_2=\mathcal T_h(A_1),\qquad
A_3=\mathcal T_g(A_2).
\]
Every step strictly increases rank until rank four, and $A_3=B_Z$.
No proper common saturated Cartier subbundle contains the seed image.

For the actual unsaturated images put
\[
M_0=h^{(1)*}I_X,\quad M_1=T_g(M_0),\quad
M_2=T_h(M_1),\quad M_3=T_g(M_2)=g^{(1)*}J_0.
\]
Continue by whole rounds
\[
g^{(1)*}J_{i+1}=T_gT_h(g^{(1)*}J_i).
\]
Then
\[
J_i\subseteq J_{i+1},\qquad
0\le\operatorname{length}(B_Y/J_i)\le5,\qquad J_5=B_Y.
\]
Thus at most three generic transports and five further integral cycles
fill the actual Cartier bundle. Generators are strongly semistable
coefficients; they are not asserted to be étale-trivial.

## Improved slope range for a seed with small adjunction support

The same conclusion holds with the slope condition replaced by
\[
\mu>-\frac45,\qquad
\bigl|\operatorname{Supp}D_{\mathrm{seed}}\bigr|<4(g(X)-1),
\]
where the actual first Frobenius adjunction image of the original map
$V_X\to B_X$ is $\omega_X(-D_{\mathrm{seed}})$.
Here the cardinality refers to the reduced support; divisor
multiplicities are retained in the actual image. In this version the
defect bound is seven and $J_7=B_Y$: three generic transports and at most
seven integral cycles suffice. The original seed image is retained in
every transport, so its adjunction support controls the final lattice.

For the fixed endpoint, the maps
$\mathcal O(-rO)\to\lambda_X\to B_X$ with $2\le r\le6$ satisfy this
improved version: their adjunction zero support is the thirteen-point
$R_X$, and their normalized slopes are $-r/8>-4/5$.
This does not assert the support bound for arbitrary negative coefficients.

## Stable-lattice input

On such a span, a common full-rank integral lattice $J\subset B$ with
degree zero on $Y$ and reduced determinant defect a four-point clump has
a compatible common line quotient of $F_Y^*J_Y$ of degree at most $-2$.
This assertion is independent of the seed. Its proof retains arbitrary
colength-one hyperplanes, the actual common Frobenius flag, and compatible
pushouts of common line extensions.

## The seed exists without distinguished endpoint arithmetic

For every characteristic-five curve $X$ of genus at least four and
every point $P$, Riemann--Roch gives a nonzero map
$\mathcal O_{X^{(1)}}(-P)\to B_X$, since
\[
\chi(B_X)=0,\qquad
\chi(B_X\otimes\mathcal O(P))=4.
\]
This line has normalized slope $-1/(g(X)-1)>-2/5$, so on every span
satisfying the theorem's explicit hypotheses it already generates
the entire integral Cartier bundle by the stated bounded transports.
Full trace generation therefore does not encode the special arithmetic
of the distinguished line or provide an admissible object.

## The distinguished line on the fixed endpoint

For the fixed genus-nine curve, the saturated
$\lambda_X=\mathcal O_{X^{(1)}}(-2O)\subset B_X$ has normalized slope
$-1/4$, so it satisfies the theorem. The required coreless, singleton,
and shared-form exclusions hold for the two selected candidate pairs.

For this distinguished seed, the actual image after just the first three
unsaturated transports already has full adjunction:
\[
\operatorname{im}(F_Y^*J_0\to\omega_Y)=\omega_Y.
\]
If $E_Y\subset F_{Y*}\mathcal O_Y$ is the inverse image of $J_0$ under
$F_{Y*}\mathcal O_Y\to B_Y$, then
\[
\sum_{m=0}^4\operatorname{im}
\bigl(E_Y^{\otimes m}\to F_{Y*}\mathcal O_Y\bigr)
=F_{Y*}\mathcal O_Y.
\]
Thus powers through four generate the whole height-one Frobenius algebra
at this earlier stage. This is a sheaf-algebra assertion, not a separable
cover or an étale-trivial coefficient construction.

There is also a connected finite étale refinement $Z'\to Z$ and four
actual finite étale maps $h_i:Z'\to X$ whose distinguished lines are
generically independent in $B_{Z'}$. They arise from the three physical
fiber steps $g,h,g$. The same $Z'$ retains an actual finite étale map to
$Y$. This is a finite path construction, not a presumed simultaneous
Galois closure.

Full trace generation does not produce an admissible order-five line,
finite spectral closure, or an unmarked common-cover decision.

[Proof](../../Proofs/cartier_and_spin/lambda_cartier_transport_generation.md).
