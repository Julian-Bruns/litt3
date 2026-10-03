# Proof: identify the Frobenius kernel with the sharp degree-one bundle

Version2,3October2026. The later exact line-degree theorem replaces
the invariant-principal-parts stability calculation. The actual
Cartier kernel is H=K(24O), so its maximum line degree is20.
Both original common-cover problems remain open.

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
the maximum line-subbundle degree of both \(H\) and \(F^*U\)
is exactly \(20\).

The exact certificate is reconstructed by
[cartier_generated_frobenius_hn.py](../../scripts/arithmetic/cartier_generated_frobenius_hn.py);
its executed
[receipt](../../../litt3-computation-data/cartier_generated_frobenius_hn_20260922/certificate.json)
is stored outside the repository. Only its quotient lifts, divisor
units and extension coefficients are used. The obsolete Hankel and
recurrence algorithm has been removed from the source.

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

## 3. The later sharp line bound gives stability and the HN filtration

Twist (9) by \(\mathcal O_X(-24O)\). Its graded lines become
\(\mathcal O_X(-5O)\) and \(\mathcal O_X(6O)\), and (13) is
exactly the transition class of K in
[the sharp line-degree theorem](small_shift_line_twist_vanishing.md).
A change of Cech sign only rescales one extension frame. Thus
\[
H\simeq K(24O).
\]
That theorem is proved from the explicit extension and cyclic
determinant reduction alone; it does not depend on this HN result.
It gives maximum line degree minus four in K and a saturated
\(\mathcal O_X(-4O)\) subline. Consequently
\[
\max_{M\subset H}\deg M=20,\qquad
0\longrightarrow\mathcal O_X(20O)\longrightarrow H
\longrightarrow\mathcal O_X(29O)\longrightarrow0.
\]
In particular \(20<49/2\), so H is geometrically stable. Since
\(F^*U/H=\omega_X\) has slope16, the two-step filtration
\(0\subset H\subset F^*U\) is the HN filtration.

A line in \(F^*U\) either maps nontrivially to \(\omega_X\), giving
degree at most16, or lies in H, giving degree at most20. The displayed
subline attains20, proving the exact bound for \(F^*U\) too.

These are bounds on X. On an arbitrary finite cover, the pulled-back
sharp line-degree bound need not persist. In particular the
Y-descended degree24d line of the degree-one radical orbit is still
compatible with the rank-two factor of slope49d/2; no common-cover
exclusion follows.
