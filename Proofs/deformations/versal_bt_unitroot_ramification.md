# Proof: a sharp bound on the actual ordinary difference

[Statement](../../Theorems/deformations/versal_bt_unitroot_ramification.md).
All comparisons retain the specified BT1 marking. We first relate
the ordinary invariant to an etale character, then bound the actual
function for arbitrary integral groups, and finally construct effective
examples. The exact divided-connection formula below is the additional
input supplied by the returned pole counterexample.

## Kummer basis changes and the character

After a finite separable extension trivializing the ordinary
constituents, write $q_B=q_A r^5$ and
$c=d\log(r)/d\log(q_A)$. Then $\Delta=c^5-c$.
Fix common level-one constituent bases. If the etale basis changes by
$1+5a$ and the multiplicative basis by $1-5a$, the Kummer parameter
changes by exponent $1+10a$. Thus $r$ changes by $q_A^{2a}$ modulo
fifth powers, and $c$ changes by $2a$.

Apply this to Galois changes of trivializations of $A$ and $B$.
Their difference on the etale constituent is the cocycle defining
$\epsilon(A,B)$. The cocycle of the Artin--Schreier root $c$ is twice
that cocycle. This proves (1). One may first kill the common
level-one characters on a cover of degree prime to five; restriction
on $H^1(-,\mathbf F_5)$ is injective for that cover.

This argument uses only the actual ordinary groups and Kummer torsors.
It does not identify an arbitrary splitting of a connection with a
Kummer parameter. The latter shortcut would leave an uncontrolled
exact differential in the formula for the FUNCTION $\Delta$.

## The divided-connection formula

Over an ordinary separable extension splitting the constituents, a
Kummer crystal has connection $d+E_{12}d\log\widetilde q$ and matrices
\[
F_q=\begin{pmatrix}1&L_q\\0&5\end{pmatrix},\quad
V_q=\begin{pmatrix}5&-L_q\\0&1\end{pmatrix},\quad
L_q=\log(\sigma(\widetilde q)/\widetilde q^5)\in5C.
\]
When $q_B=q_A r^5$, choose the corresponding multiplicative lifts.
Then $L_{q_B}-L_{q_A}\in25C$, whereas the divided connection
difference is $E_{12}d\log r$. Thus an $F,V$ comparison equal to
the marking, measured from the multiplicative quotient to the unit-root
line and divided by the common Kodaira--Spencer differential, gives
$c=d\log r/d\log q_A$. Another determinant-one $F,V$ comparison
differs by $1+5\operatorname{diag}(b,-b)$, $b^5=b$; its off-diagonal
connection ratio changes by $-2b\in\mathbf F_5$. Consequently its
fifth-power difference is the SAME intrinsic function $\Delta$.
No horizontal group comparison is inferred from an $F,V$ comparison.

## The universal simple-pole bound

Choose a local horizontal determinant trivialization and a basis
adapted to the common Hodge line. The common reduced Frobenius has
matrix $(\begin{smallmatrix}a&0\\c&0\end{smallmatrix})$, with $c$ a
unit and $a$ a uniformizer times a unit. A determinant-one diagonal
change of basis makes $c=1$: it requires a sixth root of a unit,
which exists over the strictly henselian trait. Replacing the formal
parameter by the resulting $a$ gives
\[
F_0=\begin{pmatrix}t&0\\1&0\end{pmatrix}.
\tag{5}
\]
Only this local calculation uses the parameter; pole order is intrinsic.
Set $v=(t,1)^{\mathsf T}$. Horizontality gives $\nabla_0v=0$.
Use the actual alternating crystalline pairing obtained from the
normalized determinant. In paired frames one may take
$V_0=(\begin{smallmatrix}0&0\\1&-t\end{smallmatrix})$;
Verschiebung is the paired adjoint of Frobenius. All frame changes
below have determinant one and reduce to the given marking.

Identify the two crystals modulo five using the marking. Put
$P=(F_B-F_A)/5$ modulo five. The equations $FV=VF=5$ imply that
its second column is $h v$ for some $h\in R$. Subtracting the two
Frobenius horizontality equations and using $d\sigma\equiv0\pmod5$
gives
\[
P'+C P+D F_0=0.
\]
Its second column says $h'=0$. Hence $h=y^5$ with $y\in R$.
An integral basis change $1+5N$, using only $N_{12}$, removes this
second column: the second column of $NF_0-F_0N^{(5)}$ is $-y^5v$.
We may therefore suppose
\[
F_B-F_A=5\begin{pmatrix}u_1&0\\v_1&0\end{pmatrix},
\qquad u_1,v_1\in R.
\tag{6}
\]
The paired Verschiebung difference is then
$5(\begin{smallmatrix}0&0\\v_1&-u_1\end{smallmatrix})$.
Write $D=(C_B-C_A)/5\bmod5$, so $D$ is integral and
$C_{12}\in R^*$ by Kodaira--Spencer. Over a finite separable
extension choose
\[
x-x^5=u_1/t,\qquad z=(v_1+x+x^5)/t,\qquad
X=\begin{pmatrix}x&0\\z&-x\end{pmatrix}.
\tag{7}
\]
Direct multiplication proves that $U=1+5X$ is an $F,V$ comparison.
The divided connection defect is $D+X'+[C,X]$, with upper-right
entry $D_{12}-2C_{12}x$. The ratio in the preceding lemma is
$w-2x$, where $w=D_{12}/C_{12}\in R$. Therefore
\[
\boxed{\Delta=w^5-w+2u_1/t.}
\tag{8}
\]
This proves the actual simple-pole bound. In the ordinary frame the
defect has image in the unit-root line and kills that line, so its
upper-right entry and the Hodge second fundamental form are multiplied
by the same frame factor; their ratio is the one used in the lemma.

An independent unit-root calculation also checks the conductor:

Over the ordinary generic field write
\[
F_A=\begin{pmatrix}t+5a_{11}&5a_{12}\\
1+5a_{21}&5a_{22}\end{pmatrix}.
\]
Its unit-root line has a generator $(t+5s,1)^{\mathsf T}$. Direct
substitution gives
\[
s=a_{11}-ta_{21}+t^{-5}(a_{12}-ta_{22}),\qquad
\lambda_A=t^5+5(s^5+a_{21}t^5+a_{22}).
\]
Thus (6) changes its multiplier by the ratio
\[
\frac{\lambda_B}{\lambda_A}
=1+5\bigl((u_1/t)^5+v_1-v_1^5\bigr).
\tag{9}
\]
The corresponding order-five character is represented, up to the
contravariant sign, by $u_1/t$ in the Artin--Schreier quotient.
Its regular part contributes no local character, since $R$ is
strictly henselian and $F-1:R\to R$ is surjective. It therefore has
Swan conductor zero or one, consistently with (8).

## Full effective local groups

Put $A=W(k)[[T]]$, $\sigma(T)=T^5$, with Witt Frobenius on constants.
For $j=0,1$ put $f_j=T+5j$ and use the displayed companion matrices
in the statement. They satisfy $F_jV_j=V_jF_j=5$.
Construct a trace-zero connection
\[
\nabla_j=d+C_j\,dT,\qquad
C_j=\begin{pmatrix}a_j&b_j\\c_j&-a_j\end{pmatrix}
\]
by the equations
\[
\begin{aligned}
c_j&=T^4\sigma(b_j),\\
a_j&=f_jT^4\sigma(b_j)-5T^4\sigma(a_j),\\
b_j&=-1-f_ja_j+5T^4f_j\sigma(a_j)
       +25T^4\sigma(c_j).
\end{aligned}
\tag{10}
\]
The affine operator on the right has a square that strictly raises
the $T$-adic order of differences. It has a unique fixed point in
$A^3$. Substitution proves
\[
F_j'+C_jF_j=5T^4F_j\sigma(C_j).
\tag{11}
\]
The Verschiebung equation follows from $V_j=5F_j^{-1}$ over $A[1/5]$
and the absence of five-torsion in $A$.

Modulo five both solutions of (10) coincide. Writing their common
$c$ as $b$, the common connection matrix is
\[
C_0=\begin{pmatrix}tb&-1-t^2b\\b&-tb\end{pmatrix},\qquad
b=-t^4-t^{14}b^5.
\tag{12}
\]
In the integral basis $((t,1)^{\mathsf T},(1,0)^{\mathsf T})$ this
connection is $d+(\begin{smallmatrix}0&b\\0&0\end{smallmatrix})dt$.
Its $5$-curvature squares to zero. Hence the tenth power of the
connection derivation is zero modulo five, and repeated tenth powers
of the integral derivation send the module into successively higher
powers of five. This proves topological quasi-nilpotence. Integrability
is automatic in dimension one.

The matrices now define genuine full Dieudonne crystals, not merely
truncated candidate matrices. By
[de Jong, Main Theorem1](https://www.numdam.org/item/PMIHES_1995__82__5_0.pdf)
they come from p-divisible groups on $\operatorname{Spf}R$. At each
finite level, completeness algebraizes their finite free Hopf algebras
over $R$. Their rank and the elementary divisors $(1,5)$ give height
two and dimension one. Their determinants have the same constant
rank-one coefficient: $\det F_j=-5$ and $\operatorname{tr}C_j=0$.
Over the algebraically closed constant field this common determinant
has a fixed identification with the multiplicative one. Thus both
truncations admit compatible normalized determinants.

Their mod-five crystals coincide, so finite-flat full faithfulness
gives the specified BT1 identification. Its Hasse invariant is $t$
up to a unit, and the Kodaira--Spencer coefficient is
$-1-t^2b$, a unit. All the required actual group hypotheses hold.

## Exact difference of the two effective examples

Put $h=(C_j)_{12}\bmod5$, $m=((C_1-C_0)/5)_{12}\bmod5$.
Subtracting (10) gives the uniquely solvable integral equations
\[
h+t^6h^5=-1,\qquad m+t^6m^5=-2t^5h^5.
\tag{13}
\]
They have $h(0)=-1$, $m=2t^5+O(t^6)$, and $w=m/h\in t^5R$.
Here (6) has $u_1=1,v_1=0$. Formula (8) is precisely
$\Delta=2/t+w^5-w$, proving the optimal pole order one.
The returned reply constructs these same effective objects by
[Lau's Breuil windows](https://arxiv.org/abs/0908.4588), with
$P=A^2$, $Q=5Ae_1\oplus Ae_2$ and
$F_1(5e_1)=f_je_1+e_2$, $F_1(e_2)=e_1$.
The full-crystal argument above is the local continuation's independent
effectivity route; the two repeated versions of the Pro reply are
not counted as independent audits.

Modulo25 the ordinary unit-root vector and multiplier are
\[
v_j=\bigl(f_j+5/T^5,1\bigr)^{\mathsf T},\qquad
\lambda_j=T^5+5j+5/T^{25}.
\]
These satisfy $F_j\sigma(v_j)=\lambda_jv_j$ directly. Therefore
\[
\lambda_1/\lambda_0=1+5/t^5.
\]
The comparison torsor of these unit-root lines has equation
$x^5-x=-t^{-5}$. With $z=x+t^{-1}$ it becomes
\[
z^5-z=-t^{-1}.
\tag{14}
\]
The unit-root crystal is contravariant to the etale quotient. Thus
the etale-character difference is represented by $t^{-1}$. Even
without choosing that sign convention, (14) is a
nonzero conductor-one character, which is sufficient for the pole
conclusion.

Indeed a regular representative of $\Delta$ would have zero local
Artin--Schreier class, because $F-1:R\to R$ is surjective. This
contradicts the nonzero character just computed. More elementarily,
$t^{-1}$ is not an Artin--Schreier
difference in $K$: a pole of $h^5-h$ has order divisible by five,
whereas $t^{-1}$ has pole order one. The requested nonnegative pole
bound is therefore refuted by actual integral groups.

The same construction with $T+5[\alpha]$, $\alpha\in k$, gives
character class $\alpha/t$. Thus every simple-pole coefficient is
realized locally. No simultaneous global realization is asserted.

## Global principal parts and higher truncations

On a proper curve the etale quotient characters exist on $C-S$;
their differences form the additive character map in the statement.
The local calculation puts $\Delta$ in $H^0(\mathcal O_C(S))$. The
[valuative comparison theorem](versal_bt_valuative_comparison.md)
has made $\Delta$ injective. If its character is unramified, it cannot
have a simple pole: a nonzero simple pole has nonzero local
Artin--Schreier class. Hence $\Delta$ is globally regular, and the
[global Kummer argument](versal_bt2_extension_quotient.md) makes it
zero. This proves injectivity of the character as well and excludes
nonzero unramified differences. Arbitrary functions $c^5-c$ can have
zero character, but their poles have orders divisible by five;
the new pole bound is what excludes them here.

Versality gives $\deg S=4(g-1)$, even when the determinant has a
nontrivial finite character. Riemann--Roch gives
$h^0(\mathcal O_C(S))=3g-3$. Constants cannot be nonzero differences,
so principal parts inject the additive group $Q_C$ into a
$3g-4$ dimensional ambient vector space. No finiteness follows merely
from this bound on an ambient vector-space dimension.

For two extensions of a fixed BT$_N$, use an integral comparison
of the marked level $N$ and divide all differences by $5^N$. The
reduced equations (6)--(8) are identical. On the ordinary locus
$q_B=q_A r^{5^N}$; the divided Kummer connection is again $d\log r$,
and the Frobenius difference vanishes modulo $5^{N+1}$. Thus the
same pole estimate holds at every last digit. Determinant-normalized
changes of constituent bases still alter $c$ by an element of
$\mathbf F_5$.

## Bounded verification

The standard-library checker
[verify_versal_bt_pole_model.py](../../scripts/deformations/verify_versal_bt_pole_model.py)
checks the connection equations, identical BT1 data, $F,V$ horizontality and unit
Kodaira--Spencer modulo25 through $T^{199}$. Its
[recorded output](../../../litt3-computation-data/bt_valuative_pole_20260920/matrix_check.json)
is a bounded algebra check. The all-order contraction, crystalline
effectivity and character-to-pole argument above supply the proof.
