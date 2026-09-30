# Proof: the generated Cartier hyperplane has a stable Frobenius top factor

Version1,22September2026. Independently audited. This bounded calculation concerns the actual fixed
genus-nine curve. Both original common-cover problems remain open.
It closes the suggested high-line HN shortcut: the relevant upper piece
is stable of rank two, not a line of degree at least twenty-five.

The input bundles and their actual embeddings are those in
[the generated-hyperplane proof](cartier_kernel_generated_subbundle.md),
[the split symplectic quotient](cartier_symplectic_reduction_split.md),
and [radical recognition](cartier_radical_field_recognition.md).
Put \(C=X^{(1)}\), \(F=F_X:X\to C\), and
\[
\ell=\mathcal O_C(-3O),\quad U=\ell^\perp,\quad
\deg U=13,\quad
N=U/\ell=\mathcal O_C(6O)\oplus\mathcal O_C(10O).
\]
Let \(\alpha:F^*U\to\omega_X\) be the canonical evaluation morphism,
and put \(H=\ker\alpha\).

**Result.** The map \(\alpha\) is surjective. The rank-two bundle \(H\)
has degree \(49\) and is geometrically stable. Consequently
\[
0\subset H\subset F^*U
\]
is the HN filtration, with slopes \(49/2\) and \(16\). In particular,
\(F^*U\) has no line subbundle of degree at least \(25\).

The exact certificate is reconstructed by
[cartier_generated_frobenius_hn.py](../../scripts/arithmetic/cartier_generated_frobenius_hn.py);
its executed
[receipt](../../../litt3-computation-data/cartier_generated_frobenius_hn_20260922/certificate.json)
is stored outside the repository. The all-geometric stability argument
below is separate from that finite-field arithmetic.

## 1. Canonical Cartier grades and an elementary modification

Write \(y^3=P(x)\), with \(\deg P=10\), and let \(O\) be infinity.
Set \(\theta=dx/y^2\), so \(\operatorname{div}\theta=16O\).
Let \(R\) be the reduced divisor of ten finite cubic branch points,
and \(W\) the certified squarefree degree-seven kernel Wronskian,
coprime to \(P\). Radical evaluation has the reduced zero divisor
\[
D=R+x^*\operatorname{div}_0W,\qquad \deg D=31,\qquad
\operatorname{div}(yW)=D-31O.
\tag{1}
\]

The local evaluation calculation gives initial orders \((0,1,2)\)
off \(D\), and \((0,1,3)\) on \(D\), after saturating the original
three-section lattice. At a cubic branch point the original orders
\((0,3,6)\) become \((0,3,1)\); at infinity the original orders
\((10,7,1)\) become \((0,2,1)\). Thus the canonical Cartier graded
defects of \(F^*U\) are
\[
D_1=D_2=0,\qquad D_3=D.
\tag{2}
\]
Here division by a base uniformizer in \(U\) subtracts five from the
source order after Frobenius pullback. The
[local jet formula](common_cartier_subbundles.md)
then gives the three line grades
\[
\omega_X,\qquad \omega_X^2,\qquad \omega_X^3(-D)
\]
of degrees \(16,32,17\). In particular evaluation is surjective and
\[
0\longrightarrow\omega_X^3(-D)\longrightarrow H
\longrightarrow\omega_X^2\longrightarrow0,\qquad \deg H=49.
\tag{3}
\]
These are Cartier filtration grades; (3) is not an HN filtration.

The morphism \(F^*\ell\to\omega_X\) is injective, with cokernel
\(\omega_X|_D\). Comparing it with evaluation of \(F^*U\) gives
the exact negative elementary modification
\[
0\longrightarrow H\longrightarrow
F^*N=\mathcal O_X(30O)\oplus\mathcal O_X(50O)
\longrightarrow\omega_X|_D\longrightarrow0.
\tag{4}
\]
This retains the full reduced divisor \(D\); no singular or
modification contribution is discarded.

## 2. A second presentation and its explicit extension class

For the explicit arithmetic use absolute Frobenius on the fixed
\(\mathbf F_{25}\) model. The relative result is obtained by
transporting every coefficient through the same field automorphism.
Work over \(\mathbf F_{25}\)
with \(a^2=a+3\), and use the code
\([n_0+5n_1]=n_0+n_1a\). Coefficient rows below are ascending.

The three original exact forms are \(q_i\theta\), where
\[
\begin{split}
q_0&=(24,2,1),\\
q_1&=(5,16,0,1),\\
q_2&=(5,20,0,0,8,1).
\end{split}
\]
The rows of \(P\) and \(W\) are
\[
P=(11,22,18,5,19,20,15,16,9,22,1),\qquad
W=(3,1,13,11,8,17,9,3).
\tag{5}
\]
The compatible quotient rows \(r_2,r_3\) and polynomial lifts used
in the split evaluation are
\[
\begin{split}
r_2&=(19+x,-16-x,20+14x+15x^2),\\
r_3&=(1,-18-24x-24x^2-18x^3,3+7x+23x^2+14x^3),\\
v_0&=((22,16,0,4,10),(7,4,0,21),(8,19,1,1)),\\
v_1&=((14,5,0,12,13),(10,12,0,14),(3,4,18,18)).
\end{split}
\tag{6}
\]
Every coefficient in these displays is a field code. Then
\[
(r_2v_0,r_3v_0)=(x,1),\qquad
(r_2v_1,r_3v_1)=(1,0).
\]
Put \(w=v_0-xv_1\). On the finite affine curve, \(v_1,w\) lift the
two rational summand frames \((1,0),(0,1)\) of \(N\). Define
\[
S_2=\sum_i v_{1,i}^{\,5}q_i,\qquad
S_3=\sum_i w_i^{\,5}q_i.
\tag{7}
\]
These are full polynomial fifth powers, not coefficient powers alone.
Their degrees are \(22,27\), respectively, and exact calculation gives
\[
\gcd(S_2,P)=\gcd(S_2,W)=
\gcd(S_3,P)=\gcd(S_3,W)=1.
\tag{8}
\]
In particular the coefficient of the second summand in (4) is nonzero
at every point of \(D\). Projection to the first summand is therefore
surjective on \(H\), giving a different exact sequence
\[
0\longrightarrow\mathcal O_X(50O-D)
\longrightarrow H\longrightarrow\mathcal O_X(30O)
\longrightarrow0.
\tag{9}
\]
Use multiplication by \(yW\) to identify its left term with
\(\mathcal O_X(19O)\).

Let \(Q=PW\) and choose the unique polynomial \(A\) of degree at most
sixteen satisfying
\[
A\equiv-S_2/S_3\pmod Q.
\tag{10}
\]
The affine lift of the first summand to \(H\subset F^*N\) is
\((1,A)\). Near infinity, which is disjoint from \(D\), use \((1,0)\).
Their difference, divided by the kernel generator \((0,yW)\), gives
the extension class of (9), up to the harmless Cech sign:
\[
e=\frac{A}{yW}=\frac{y^2A}{PW}
\quad\text{in }H^1(X,\mathcal O_X(-11O)).
\tag{11}
\]
Using \(PW\) in (10) is correct also at a cubic branch point:
for a polynomial in \(x\), vanishing at its branch value means
divisibility by \(y\), in fact by \(y^3\).

The \(\gamma:y\mapsto\zeta y\) character of (11) is \(\zeta^2\).
That character space in \(H^1(\mathcal O_X(-11O))\) has basis
\[
y^2x^{-1},y^2x^{-2},\ldots,y^2x^{-10}.
\tag{12}
\]
For example, this follows by writing
\(\xi_*\mathcal O_X=\mathcal O\oplus
\mathcal O(-4)\oplus\mathcal O(-7)\), or directly by the valuations
\(\operatorname{ord}_Ox=-3\), \(\operatorname{ord}_Oy=-10\).
More generally the \(y^j\) character basis for \(H^1(\mathcal O(kO))\)
is \(y^jx^{-m}\) with
\(1\le m\le-\lfloor(k-10j)/3\rfloor-1\).
Expanding (11) gives the coefficient vector
\[
c=(c_1,\ldots,c_{10})=(2,16,16,7,1,2,7,1,24,11).
\tag{13}
\]

Only three small identities are needed for stability. Define
\(K_r=(c_{i+j+1})_{0\le i,j<r}\). Then
\[
\det K_4=[12]\ne0,\qquad \det K_5=0,\qquad
\operatorname{rank}K_5=4.
\tag{14}
\]
The unique monic four-atom recurrence determined by \(c_1,\ldots,c_8\)
is
\[
g(T)=T^4+[7]T^3+[6]T^2+2T+[5],\qquad \gcd(g,P)=1.
\tag{15}
\]
Specifically, if \(g=\sum_{j=0}^4g_jT^j\), then
\(\sum_jg_jc_{i+j+1}=0\) for \(i=0,\ldots,4\), whereas its value
for \(i=5\) is \([16]\ne0\). The first four equations determine
\(g_0,\ldots,g_3\) using the invertible matrix \(K_4\).

## 3. All-geometric stability from invariant principal parts

Suppose \(H\) is not stable. Since its degree is odd, its unique
destabilizing line \(S\) has degree at least \(25\). The action of
\(\gamma\) preserves \(U\), evaluation and \(H\), hence preserves \(S\).
The elementary-modification presentation (9) is also invariant:
its kernel is the intersection of \(H\) with the intrinsic
degree-fifty summand of \(F^*N\).

The composite \(S\to\mathcal O_X(30O)\) is nonzero, since a line
contained in \(\mathcal O_X(19O)\) has degree at most \(19\).
Its zero divisor identifies
\[
S=\mathcal O_X(30O-E),\qquad
E\ge0,\quad \gamma E=E,\quad \deg E\le5.
\tag{16}
\]
The lifting criterion for (9) says that \(e\) lies in the kernel of
\[
H^1(\mathcal O_X(-11O))
\longrightarrow H^1(\mathcal O_X(-11O+E)).
\tag{17}
\]
This is precisely the image of principal parts supported on \(E\).
Both line bundles have negative degree, so no quotient by global
sections is needed in this kernel description. The kernel is
\(\gamma\)-invariant, and the order three is prime to five. Since
\(e\) has character \(\zeta^2\), project the principal parts onto
that character.

Here is the full list of possible contributing directions when
\(\deg E\le5\). Coordinates are those of (12). Put
\[
V(u)=(1,u,u^2,\ldots,u^9).
\]

* At a finite fixed point \(P_u\), where \(P(u)=0\), use \(y\) as
  uniformizer. The \(\zeta^2\) polar directions first occur at pole
  orders \(1\) and \(4\). They give \(V(u)\) and \(V'(u)\), with
  minimal divisor costs \(1\) and \(4\), respectively. Indeed expand
  \(y^2/(x-u)\) and \(y^2/(x-u)^2\) at infinity. At order four the
  span also includes the earlier direction \(V(u)\).
* A free orbit consists of three points above a nonbranch value
  \(u\). A reduced orbit has one \(\zeta^2\) direction, again \(V(u)\),
  and costs degree \(3\). Multiplicity two would already cost \(6\).
* At \(O\), the parameter \(z=x^3/y\) has character \(\zeta^2\).
  For \(\mathcal O(-11O)\), the contributing orders are \(z^{10}\)
  and \(z^7\), first allowed by multiplicities \(1\) and \(4\).
  Their spans are respectively the last coordinate vector and the
  last two coordinate vectors of (12).

For the finite branch directions, a change of local uniformizer can
add an earlier direction to the displayed derivative; it leaves the
stated span unchanged. All assertions concern geometric branch points,
not only \(\mathbf F_{25}\)-rational points.

The first seven coordinates, and hence \(K_4\), ignore both infinity
directions. A simple moment \(bV(u)\) contributes a matrix of rank at
most one. A confluent pair \(bV(u)+dV'(u)\) contributes rank at most
two. This follows either by differentiating the rank-one factorization
or by writing its entries as
\[
b\,u^{i+j}+d(i+j)u^{i+j-1}.
\]
Consequently any degree-at-most-five support using a free orbit has
finite moment rank at most three: the orbit costs three and leaves
at most two further simple directions. A fourth-order direction
at a finite branch point likewise costs four and leaves rank at
most three. A fourth-order infinity direction leaves rank at most
one. Each contradicts \(\det K_4\ne0\).

After discarding multiplicities that introduce no new character
direction, the only remaining cases are therefore at most five
distinct simple finite branch moments, with possibly the last
coordinate direction at \(O\). At least four finite moments are
required by \(\operatorname{rank}K_4=4\).

If there are four finite moments, their nonzero weights and distinct
support values \(u_1,\ldots,u_4\) make their recurrence
\(\prod_j(T-u_j)\) the unique monic polynomial determined by the first
eight coordinates. An infinity direction changes only \(c_{10}\),
so it cannot affect this determination. Thus (15) would have four
roots among those of \(P\), contradicting \(\gcd(g,P)=1\).

If there are five finite moments, there is no remaining budget for
an infinity direction. Zero weights reduce to the preceding case.
Otherwise their \(5\)-by-\(5\) moment matrix factors as a Vandermonde
matrix, the diagonal matrix of their five nonzero weights, and the
transpose Vandermonde matrix. Its determinant is nonzero, contradicting
\(\det K_5=0\).

This exhausts (16), proving that \(H\) is geometrically stable.
Its slope \(49/2\) exceeds the slope \(16\) of \(F^*U/H=\omega_X\);
therefore the asserted two-step HN filtration follows.
