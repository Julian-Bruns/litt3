# Proof: the fourth root cancels the projective Frobenius discrepancy

[Statement](../../Theorems/deformations/ordinary_oper_bt_effectivity.md).
The full-group argument is the user's returned response to
[the effectivity request](../../Research/requests/bt_cartier_effectivity_2026_09_20/02_oper_bt1_effectivity.md).
The final classification and the extension to all genera are the
local continuation. No independent audit is claimed.

## Integral effectivity

Mochizuki's canonical-lifting theorem supplies a smooth proper formal
curve $\mathfrak C/W(k)$ and an integral projective indigenous bundle
$\mathcal P$ reducing to $r$, with a horizontal identification
\[
\operatorname{RF}(\mathcal P)\simeq\mathcal P.
\tag{1}
\]
Here RF is renormalized crystalline Frobenius. This is the actual
canonical ordinary object, not an arbitrary lift of a connection.
See [Mochizuki, III Theorem3.2 and Corollaries3.3--3.4](https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Theory%20of%20Ordinary%20p-adic%20Curves.pdf).
The theorem is valid for every genus at least two. The computation
below has no further genus-two step.

The specified special-fiber determinant-trivial lift of $\mathcal P$
lifts through all the nilpotent thickenings: the central kernel of
$\mathrm{SL}_2\to\mathrm{PGL}_2$ is etale $\mu_2$, and its etale
cohomology is unchanged under these thickenings. Connection and
filtration lift as well. Denote the resulting rank-two flat bundle
by $\mathcal E$, with Hodge line $\mathcal L$. Its connection is
topologically quasi-nilpotent since its reduced curvature is nilpotent.
It defines a locally free crystal $\mathcal D$.

Evaluate $\Phi_{\rm cris}^*\mathcal D$ on $\mathfrak C$, calling the
result $\mathcal A$. Its reduction has its canonical Cartier
connection. Define the elementary lattice
\[
\mathcal M=\{a\in\mathcal A:a\bmod5\in F_{\rm abs}^*L\}.
\tag{2}
\]
This construction is on the five-torsion-free formal lift. In an
adapted local frame it has basis $e_1^\Phi,5e_2^\Phi$. It is
connection-stable. Equation(1) gives a flat line $\mathcal Q$ and
a horizontal isomorphism
\[
\mathcal M\simeq\mathcal E\otimes\mathcal Q.
\tag{3}
\]
The determinant lattice is $5\det\mathcal A$; dividing this displayed
factor gives a horizontal determinant trivialization. Thus
$\mathcal Q^2=\mathcal O$.

Reduction of (2) gives
\[
0\longrightarrow F_{\rm abs}^*(E/L)
\longrightarrow\mathcal M/5\mathcal M
\longrightarrow F_{\rm abs}^*L\longrightarrow0.
\tag{4}
\]
By (3), the middle connection is $E\otimes Q$, where $Q=\mathcal Q/5$.
The left-hand line is Cartier-flat. It equals $I\otimes Q$: it lies
in the curvature kernel, and both are saturated lines. The
nowhere-zero curvature hypothesis makes that kernel a line everywhere.
Consequently
\[
L^{-5}=I\otimes Q,\qquad Q=\kappa^{-1}=\kappa.
\tag{5}
\]

Lift the chosen prime-to-five torsion line $N$ etale-theoretically to
$\mathcal N$ on $\mathfrak C$. Retain the compatible trivializations
$\mathcal N^4=\mathcal Q$, $\mathcal N^8=\mathcal O$. Its crystalline
Frobenius pullback is horizontally $\mathcal N^5$. Therefore, for
$\mathcal D'=\mathcal D\otimes\mathcal N$, its lattice (2) is
\[
\mathcal M'=\mathcal M\otimes\Phi_{
\rm cris}^*\mathcal N
\simeq\mathcal E\otimes\mathcal Q\otimes\mathcal N^5
\simeq\mathcal E\otimes\mathcal N^9
\simeq\mathcal E\otimes\mathcal N.
\tag{6}
\]
Fix a horizontal isomorphism $\Theta:\mathcal M'\to\mathcal D'$.
Let $\iota:\mathcal M'\hookrightarrow\Phi_{\rm cris}^*\mathcal D'$
be inclusion and let $m_5$ be multiplication by five into $\mathcal M'$.
Then
\[
F=\Theta m_5,\qquad V=\iota\Theta^{-1},\qquad FV=VF=5.
\tag{7}
\]
These are maps of crystals, not just maps on the special fiber.

For an adapted frame, put $u=\Theta(e_1^\Phi)$,
$v=\Theta(5e_2^\Phi)$. These form a basis, and
\[
F(e_1^\Phi)=5u,\quad F(e_2^\Phi)=v,
\qquad V(u)=e_1^\Phi,\quad V(v)=5e_2^\Phi.
\tag{8}
\]
The local window has $P=Re_1\oplus Re_2$,
$Q_R=Re_1\oplus5Re_2$, and $F_1(e_1)=u$, $F_1(5e_2)=v$.
Changes of Frobenius lift use the comparisons of the same crystal.

The locally free Dieudonne crystal (7) is effective by
[de Jong, Theorem4.1.1](https://www.numdam.org/item/PMIHES_1995__82__5_0.pdf).
The smooth-curve hypothesis meets his smoothness/finite-p-basis
conditions. Full faithfulness gives the unique overlap comparisons
between the local groups; faithfulness gives their cocycle. Finite
flat descent at every truncation glues a full group $G/C$.
This uses essential surjectivity for the integral crystal, not an
assertion that arbitrary special-fiber $F,V$ matrices are effective.

Formula(8) and (4)--(5) identify the Hodge line and reduced arrows:
\[
\ker\bar F=\operatorname{im}\bar V=F_{\rm abs}^*(L\otimes N),
\qquad \operatorname{im}\bar F=\ker\bar V=I\otimes N.
\tag{9}
\]
Frobenius is faithfully flat, so the Hodge line is exactly $L\otimes N$.
The group has height two, dimension one and the prescribed maximal
Kodaira--Spencer map. Its determinant line is $\mathcal N^2$, not
the trivial line. Its determinant Frobenius is five times the finite
character arrow, up to a horizontal constant unit; the permitted
scalar normalization removes this unit. Alternatively normalize the
determinant character by the rank-one etale twist trivial modulo five.

## Comparing two BT1 realizations of the same projective oper

This comparison does not require indigenous ordinariness, once one
actual realization exists. Let $H_0,H_1$ be two actual realizations
on a proper connected curve, with evaluations $E_0,E_1$. An
identification of their projective connections gives a flat line $D$
and $E_1=E_0\otimes D$. Both determinant connections have finite
order dividing four, so $D^8$ is horizontally trivial and $D$ has
zero curvature. The unique maximal-degree Hodge lines and the
curvature-kernel lines therefore also differ by $D$. From the two Frobenius
isomorphisms between quotient and curvature-kernel lines one obtains
\[
F_{\rm abs}^*D\simeq D
\quad\text{horizontally},\qquad D^4\simeq\mathcal O_C.
\tag{10}
\]
Thus $D$ is a flat order-dividing-four line. Such lines, with their
Frobenius descent, are exactly rank-one etale $\mathbf F_5$-local
systems. The tensor action on the contravariant crystal can reverse
the character; this involution does not change the torsor or count.
Twist $H_0$ so that its flat bundle is $E_1$.

The remaining Frobenius and Verschiebung maps differ by constants
$a,b\in k^\times$: they are isomorphisms of the same global lines,
and global units on the proper curve are constants. We prove $ab=1$.
Over a finite separable extension of the ordinary function field,
take Kummer constituent frames for $H_0$. They give
\[
F_0=\begin{pmatrix}1&0\\0&0\end{pmatrix},\quad
V_0=\begin{pmatrix}0&0\\0&1\end{pmatrix},\quad
\nabla e=0,\quad\nabla f=e\,\Omega,
\qquad C(\Omega)=\Omega\ne0.
\tag{11}
\]
Here $\Omega=d\log q$; nonvanishing is the Kodaira--Spencer condition.
For the other group choose constants $s,t\in k^\times$ with
$s^4=a^{-1}$ and $t^4=b$. The frame $e'=se$, $f'=tf$ normalizes
its two arrows, and its connection form is $(t/s)\Omega$. Since
this too comes from an ACTUAL ordinary BT1, it is logarithmic and
Cartier-fixed. Semilinearity and (11) give $t/s\in\mathbf F_5^\times$.
Hence
\[
ab=(t/s)^4=1.
\tag{12}
\]
A common scalar change of frame now identifies both arrows and the
connection. Full faithfulness for existing finite flat groups gives
an actual isomorphism. This is why two independent scalar choices
in candidate $F,V$ do not survive as group parameters.

There is no nontrivial self-twist. An isomorphism
$H\otimes D\simeq H$ preserves the maximal Hodge line, so
$L_H\otimes D\simeq L_H$, whence $D$ is the trivial line. Its
flat order-four structure is then trivial too: four is invertible
and every global unit is constant. This proves the torsor (1).
Since $\operatorname{Pic}(C)[4]\simeq(\mathbf Z/4)^{2g}$, its
cardinality is $4^{2g}$.

## Exhaustion of higher groups and endpoint count

Lift every rank-one $\mathbf F_5$-character by its Teichmuller
$\mathbf Z_5$-character. Twisting the full group constructed above
realizes every BT1 in the torsor. Each such group therefore has a
normalized reference at every finite level. Apply
[Cartier rigidity](versal_bt_cartier_rigidity.md) successively: any
other normalized extension of the fixed preceding level is marked
isomorphic to the reference. The marked determinant-preserving
isomorphisms are unique by
[generic scalar rigidity](versal_bt_display_descent.md), so the
isomorphisms agree under truncation and give a unique full tower.

Every actual everywhere-versal group induces an admissible active
projective oper, as proved in the Cartier-rigidity theorem. On the
two selected genus-two curves all85 such opers are ordinary. Each
has256 realizations by the torsor just proved. Different opers cannot
yield isomorphic groups over the fixed base curve. Multiplication
gives21,760; it is a deduction from the existing geometric count,
not a new numerical census.
