# Proof: the last special-fiber digit appears in coordinate degree twelve

[Statement](../../Theorems/deformations/versal_bt3_transport_jet.md).
User-returned Pro proof,21 September2026. The cocycle and finite-field
consequences are local continuations. Bounded normalization checks
are in [the verifier](../../scripts/deformations/verify_bt_obstruction_transport.py).
The verifier is not an effectivity proof or a full replay of infinite
formal deformation theory. No independent audit is claimed.

## Connection and actual coordinate pullback

Write the integral connection as $d+\widehat\Gamma dt$, with entries
$\widehat a,\widehat b,\widehat c,-\widehat a$. Frobenius
horizontality gives the convergent recursion
\[
\widehat c=t^4\sigma(\widehat b),\quad
\widehat a=t^5\sigma(\widehat b)-5t^4\sigma(\widehat a),\quad
\widehat b=-1-t\widehat a+5t^5\sigma(\widehat a)
+25t^4\sigma(\widehat c).
\]
Thus $\widehat\Gamma=-E_{12}+O(t^4)$. Its reduction has upper
right entry $b$, with $b+t^6b^5=-1$.

For the coefficientwise Teichmuller lift $f$ of $\varphi$, put
$\delta=\sigma(f)-f^5\in5t^6\mathfrak S$. Modulo125 the actual
crystalline pullback is
\[
\mathcal T_f=I+\delta\widehat\Gamma(f^5)
+\tfrac12\delta^2(\widehat\Gamma'+\widehat\Gamma^2)(f^5),
\quad F_\varphi=F(f)\mathcal T_f,\quad
V_\varphi=\mathcal T_f^{-1}V(f),\quad
\widehat\Gamma_\varphi=f'\widehat\Gamma(f).
\tag{3}
\]
All higher Taylor terms vanish at this precision, including their
factorial denominators. The actual comparison matrix modulo25 obeys
\[
F\sigma(U)=UF_\varphi,\qquad
U'+\widehat\Gamma U=U\widehat\Gamma_\varphi.
\]

## The last special-fiber parameter

Lift $U$ integrally with determinant one and preserving the window
filtration. Transport the pulled-back datum to obtain
$F^*=F+25X$, $\widehat\Gamma^*=\widehat\Gamma+25Z$ modulo125.
The determinant and horizontal equations give
\[
X_{12}=tX_{22},\qquad X'+\Gamma X+Z\overline F=0.
\]
Since $(t,1)^t$ is horizontal, its second-column relation says
$X_{22}'=0$, hence $X_{22}\in k[[t^5]]$. Put
$\rho=X_{22}^{1/5}\in R$. A gauge $I+25K$ removes that column
using $K_{12}=\rho$; a diagonal gauge solving $s+s^5=r$ removes
the lower-left entry. The resulting error is $jE_{11}$, with
$j(0)=X_{11}(0)+X_{22}(0)^{1/5}$. Horizontality gives a fifth
power, not a constant or a Frobenius-fixed series.
The calibrated actual-window difference is
\[
\Delta=w^5-w+2j/t,\quad w\in R,
\qquad a_2=2(X_{11}(0)+X_{22}(0)^{1/5}).
\tag{4}
\]
It follows also by normalizing the ordinary unit-root basis
$(t,1)^t,(0,t^{-1})^t$ and solving $x-x^5=j/t$.

At zero the two original Frobenius matrices equal
$S=\left(\begin{smallmatrix}0&5\\1&0\end{smallmatrix}\right)$.
Solving their ACTUAL level-two comparison and determinant gives
\[
U(0)=\begin{pmatrix}1+5[\xi]&5[\gamma^5]\\
[\gamma]+5[\zeta]&1+5[\xi^5]\end{pmatrix}\pmod{25},
\quad\gamma,\xi\in\mathbf F_{25},\quad
\xi+\xi^5=\gamma^6,\quad\zeta\in k.
\]
Writing $(U_{12}/5)(0)=[\gamma^5]+5[q]$ at the next precision,
one gets $X_{11}(0)=q-\zeta^5$ and $X_{22}(0)=\zeta-q^5$.
Formula (4) is independent of that lift and becomes
\[
a_2=2(\zeta^{1/5}-\zeta^5).
\tag{5}
\]

## Recovering that parameter from the coordinate jet

Set $C=(A-A^{-5})/t$, $\beta=U_{12}/5\pmod5$, and
$D=(\sigma(f)-f^5)/5\pmod5$. Horizontality to coordinate degree two
gives $[t^2]\beta=\xi\gamma-\zeta$. The lower-right Frobenius
equation, INCLUDING (3), gives
\[
\beta^5=C+D A^5 b(\varphi^5).
\]
Its degree-ten coefficient is
\[
(\xi\gamma-\zeta)^5=u_{11}-[t^{10}]D.
\tag{6}
\]
The reduced level-one horizontal equation is
$\varphi'b(\varphi)=A^{-2}b(t)$, $\varphi=tA^4$. Through degree
five it says $A^6-t(A^6)'=1\pmod{t^6}$, hence
\[
\varphi=t-\gamma t^2+\gamma^2t^3-\gamma^3t^4
+\gamma^4t^5+\gamma^5t^6+O(t^7).
\]
The DIVIDED Taylor term in (6) is nonzero:
$[t^{10}]D=-2\gamma^5$. Thus
\[
\zeta^5=(\xi^5-2)\gamma^5-u_{11}.
\]
The first term lies in $\mathbf F_{25}$ and cancels when applying
$x\mapsto x^{1/25}-x$. Substitution in (5) gives exactly (1).
The fourth-root recursion proves the upper jet bound twelve.

## Effective sharpness examples

For $z\in k$ put $j=z^{1/5}-z^5$, and replace $t$ by
$t+25[j]$ in the full effective window. On its closed fiber there
is a determinant-one FULL isomorphism with the original supersingular
group reducing modulo25 to
$\left(\begin{smallmatrix}1&0\\5[z]&1\end{smallmatrix}\right)$.
One constructs it by the Witt recursions, with $h_0=25[j]$,
\[
a-\sigma^2(a)=h_0c,\qquad
c-\sigma^2(c)=\frac{\sigma(h_0)}5\sigma^2(a),
\qquad
U_z=\begin{pmatrix}a&5\sigma^{-1}(c)\\c&\sigma(a)\end{pmatrix}.
\]
The initial compatibility is $z-z^{25}=j^5$. Successive additive
Witt equations are solvable over $k$; the determinant is normalized
by a scalar square root with fixed reduction. Classical Dieudonne
theory over the perfect field turns this into an actual special-fiber
group isomorphism.

The original $G$ is a universal equicharacteristic deformation of
that group: the deformation ring is one-dimensional and its
Kodaira--Spencer coefficient is the unit $b(0)=-1$. Universality
therefore identifies the new full group with $\varphi_z^*G$ for an
actual coordinate $\varphi_z$, retaining the special-fiber isomorphism.
This can be constructed successively on $k[t]/t^n$ by matching the
Hodge line. Reducing to level two gives the required marked $\eta_2$.

Here $\gamma=\xi=0$ and $\zeta=z$. The reduced horizontal equation
allows a first nonzero coordinate term only in degrees congruent to
two modulo five. The degree-five coefficient of the Frobenius equation
eliminates degree seven, and (6) gives $u_{11}=-z^5$. Consequently
$\varphi_z=t+z^5t^{12}+O(t^{13})$. The calibrated effective window
has pole $2j$, proving (2) and sharpness. For $z^3+z+1=0$, exact
field arithmetic gives the value in the statement.

Finally, functoriality and additivity of ACTUAL marked differences
make $\Delta$ a coordinate-pullback cocycle. Strict pullback leaves
the polar coefficient unchanged, so $a_2$ is additive under
composition. The map $z\mapsto z^{1/5}-z^5$ is onto the algebraic
closure, proving surjectivity. Formula (1) over a finite field is a
multiple of $1-\operatorname{Frob}^{-2}$, whose image is contained
in the kernel of trace to its fixed field. These last facts require
no additional effectivity or field-of-definition assertion.
