# Proof: the pole is the last supersingular automorphism obstruction

[Statement](../../Theorems/deformations/versal_bt_fiber_obstruction.md).
Author continuation of the returned sharp BT3 calculation,
21 September2026. Use the established actual all-level window
calibration, local prolongation/universal deformation and normalized
comparison theorems. No assertion about an arbitrary $F,V$ matrix
being effective is needed.

## 1. Both supersingular arrows impose the finite-field condition

On the closed fiber the linearized Frobenius and Verschiebung
matrices are BOTH
$S=\left(\begin{smallmatrix}0&5\\1&0\end{smallmatrix}\right)$.
Write an automorphism matrix over $W_N(k)$ as
$U=\left(\begin{smallmatrix}a&b\\c&d\end{smallmatrix}\right)$.
The two equations are
\[
US=S\sigma(U),\qquad \sigma(U)S=SU.
\]
Together they say
\[
b=5\sigma(c),\quad d=\sigma(a),\quad
\sigma^2(a)=a,\quad 5(\sigma^2(c)-c)=0.
\tag{5}
\]
Using only the first equation would lose the EXACT condition on
$a$. Classical Dieudonne theory over the perfect field applies to
the existing truncated groups and their morphisms.

Thus $a\in W_N(\mathbf F_{25})$, while
$c\bmod5^{N-1}\in W_{N-1}(\mathbf F_{25})$. Determinant one
and the graded normalization impose
\[
a\sigma(a)-5c\sigma(c)=1,\qquad a\bmod5=1.
\tag{6}
\]
Choose $c_0\in W_N(\mathbf F_{25})$ with the same reduction
modulo $5^{N-1}$ as $c$, and write
$c-c_0=5^{N-1}[z]$. Replacing $c$ by $c_0$ does not change
(6). The matrix
$g=\left(\begin{smallmatrix}a&5\sigma(c_0)\\c_0&\sigma(a)\end{smallmatrix}\right)$
therefore satisfies (5)--(6).

This $g$ lifts to a FULL determinant-one automorphism. Lift $c_0$
to $W(\mathbf F_{25})$. The required norm of a lift of $a$ is
$1+5c_0\sigma(c_0)\in\mathbf Z_5^\times$. The norm on units
congruent to one modulo $5^N$ is onto the corresponding principal
units of $\mathbf Z_5$: digit by digit its linearization is the
surjective trace $\mathbf F_{25}\to\mathbf F_5$. Correcting any
lift of $a$ by those units gives the exact norm without changing
its given truncation. The resulting matrix is a full Dieudonne
automorphism.

Since $a\bmod5=1$, direct multiplication gives
$Ug^{-1}=I+5^{N-1}[z]E_{21}$. Changing $c_0$ changes $z$ by
an element of $\mathbf F_{25}$, and those are exactly the factors
of this form that lift. The same equations at level $N+1$ show
that the image of truncation is precisely this full-liftable
subgroup.

The final lower unipotent factors commute with $g$ modulo $5^N$.
For $N>1$ this follows by reducing $g$ modulo five, where it is
lower unipotent; for $N=1$ both factors are already lower
unipotent. Their parameters add. Thus the quotient is the additive
group $k/\mathbf F_{25}$. The map
$z\mapsto2(z^{1/5}-z^5)$ is onto $k$ with kernel exactly
$\mathbf F_{25}$, proving (2).

For the count, $c_0$ has $25^N$ choices. At each fixed $c_0$,
the norm equation for $a$ with $a\bmod5=1$ has $5^{N-1}$
solutions. Hence the cardinality is $5^{3N-1}$.

## 2. Remove the liftable part by an actual full symmetry

A full normalized automorphism of $G_0$ acts on its universal
equicharacteristic deformation. This supplies an ACTUAL strict
coordinate symmetry and a full comparison of $G$ with its
pullback. Strictness follows from the identity on the two Hodge
graded lines and the Kodaira--Spencer isomorphism.

The next-level difference of such a full symmetry is zero. The
actual difference invariant is a pullback cocycle, and a strict
coordinate change preserves the coefficient of $t^{-1}$. Thus
composition with this full symmetry does not change $a_N$.
We can remove the factor $g$ of (1) and assume the closed
comparison is $I+5^{N-1}[z]E_{21}$.

Lift that comparison integrally with determinant one and preserving
the window filtration. Its value at zero can be chosen to be
\[
\widetilde U(0)=
\begin{pmatrix}
1&5^N[q]\\
5^{N-1}[z]&1+5^{2N-1}[q][z]
\end{pmatrix}
\]
for an arbitrary $q\in k$. A determinant-one filtration-preserving
lift with this value exists by lifting its three free matrix
parameters. Coordinate pullback has no Taylor displacement at
zero, since the coordinate fixes zero.

Transporting the next Frobenius to the original basis gives
$F^*=F+5^NX$ modulo $5^{N+1}$. Its two diagonal errors at zero
are, by direct multiplication,
\[
X_{11}(0)=q-z^5,\qquad X_{22}(0)=z-q^5.
\tag{7}
\]
All omitted products have valuation at least $N+1$, INCLUDING
when $N=1$. There can be another lower-left error, which is not
being omitted from the full matrix comparison.

The last-digit reduction of the ACTUAL determinant and horizontal
equations gives
\[
X_{12}=tX_{22},\qquad X'+\Gamma X+Z\overline F=0.
\]
The second column is a multiple of the horizontal vector $(t,1)^t$;
hence $X_{22}'=0$ and $\rho=X_{22}^{1/5}\in k[[t]]$.
An integral last-digit gauge with upper-right entry $\rho$ removes
that column. A diagonal gauge solving $s+s^5=r$ removes the
remaining lower-left error. This is exactly the gauge computation
at level two, now with $5^2$ replaced by $5^N$; all products of
two errors vanish at the working precision. The resulting window
has error $jE_{11}$ with
\[
j(0)=X_{11}(0)+X_{22}(0)^{1/5}.
\]
The established effective-window calibration gives
$[t^{-1}]\Delta_N=2j(0)$. Substitution of (7) cancels $q$ and
proves (3). This also proves that it detects precisely liftability
of the supplied closed-fiber marking.

This computation has not replaced crystalline coordinate pullback
by entrywise substitution. It uses only its value at zero, where
the divided Taylor displacement is zero. A coordinate-jet formula
away from that point still needs the Taylor terms, as the sharp
level-two theorem shows.

## 3. Pass from the universal reference to arbitrary local groups

Work on a completed supersingular disc. A given BT$_{N+1}$
extends there to a full group, and the unit Kodaira--Spencer map
identifies its deformation parameter with a universal one. These
are the local prolongation and universality inputs already used
in [actual Cartier realization](versal_bt_cartier_realization.md).
They do not assert a full prolongation on a proper curve.

Prolong $A$ and $B$ separately. Their supersingular full closed
fibers are isomorphic over $k$; normalize one such isomorphism on
the determinant. Universality expresses the second local full
group as a coordinate pullback of the first. The supplied level-$N$
marking becomes an actual comparison for this pullback. One can
arrange the coordinate derivative and closed graded comparison to
be one by composing with a full supersingular automorphism: the
graded determinant-one action is the norm-one subgroup of
$\mathbf F_{25}^\times$, and its tangent action is exactly the
one dictated by Kodaira--Spencer. Such composition has zero
next-level difference. Equivalently the computation may be done
without this normalization; the residue is multiplied by a unit,
which does not affect its vanishing.

Formula (3) now says that the principal part vanishes exactly when
the supplied closed level-$N$ comparison lifts to the actual next
closed fibers. This is independent of the auxiliary prolongations,
parameters and full closed-fiber isomorphism. Neither this argument
nor the conclusion says that a chosen closed-fiber lift extends
over the completed disc.

## 4. Properness removes the remaining regular difference

If the fiber tests hold at every supersingular point of the proper
curve, the actual rational function $\Delta_N(A,B)$ has no poles.
It is therefore a constant $c\in k$. The necessary Cartier identity
on the logarithmic character cover is
\[
C(c\Omega)=c^{1/5}\Omega=0.
\]
Since $\Omega\ne0$, this forces $c=0$. Exact realization and
normalized marked injectivity now give the unique actual group
isomorphism. The reverse implication is immediate by restriction.

Apply this to $f^*A_X$ and $g^*B_Y$ on the ORIGINAL smooth proper
source $Z$. Etaleness preserves versality and simple Hasse zeros,
so it gives exactly the two-map criterion in the statement. All
endpoint groups and their level-$N$ identification are retained.
The criterion tests supplied objects; it does not manufacture
their closed-fiber agreement.
