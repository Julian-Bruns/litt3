# The surviving genus-six twist has p-rank five: a negative finite-packet result

**Status:** author proof and exact scalar-arithmetic certificate, 2026-09-05;
not independently audited. The calculation was independently reproduced
by `/root` in a different basis. No Tango enumeration on this twist was
performed, and the fixed pair in file 76 is unchanged.

For \(r^2=3\) in \(\mathbf F_{25}\), put

\[
 \begin{aligned}
 F&=2t^6+2t^4+3t^2+4,\\
 A&=2t^8+4t^6+2,\qquad B_0=t^2+4,\\
 q&=t^2+rt+1.
 \end{aligned}
\]

Let \(X\) be the smooth projective curve with function field

\[
              v^2=F,\qquad h^2=q(A+B_0v).              \tag{1}
\]

This is the unramified quadratic twist of the previous genus-six double
cover of \(B:v^2=F\). Its exact p-rank is

\[
                              \boxed{f(X)=5,}
\]

not one. Its Frobenius-conjugate twist with \(q=t^2-rt+1\) has the same
p-rank. Therefore both survivors of the
[fifteen-class Prym filter](HOSHI_GENUS2_UNRAMIFIED_PRYM_FILTER.md)
fail the rank-preserving criterion of file 119.

The complete
[certificate](HOSHI_GENUS6_SINGLE_TWIST_P_RANK_CERTIFICATE.py)
runs with `sage -python`. It performs exact polynomial arithmetic and
explicit elementary Gaussian elimination on scalar field elements.

## 1. A complete holomorphic anti-invariant basis

Write \(e=A+B_0v\), \(Q_0=(0,2)\in B\), and \(I_+,I_-\) for the two
geometric points at infinity. The earlier norm identity gives

\[
 \operatorname{Norm}_{k(B)/k(t)}(e)
       =4t^{10}(t^6+4t^4+4t^2+2).
\]

The sextic on the right is squarefree and coprime to both \(F\) and
\(B_0\). At \(t=0\), \(e\) vanishes at \(Q_0\), while its value at
\((0,3)\) is nonzero. At either infinity its pole order is eight.
Consequently

\[
 \operatorname{div}(e)=10Q_0+R_1+\cdots+R_6-8I_+-8I_-.
\]

Here the six points \(R_i\) are distinct, finite, and not hyperelliptic
Weierstrass points. If \(W_a,W_b\) are the two Weierstrass points selected
by \(q\), then

\[
 \operatorname{div}(q)=2W_a+2W_b-2I_+-2I_-.
\]

Thus (1) is ramified exactly at the six \(R_i\), and has genus six.
Its invariant holomorphic differential space is the two-dimensional
pullback from \(B\), on which the Cartier stable rank is one.

All anti-invariant rational differentials have the form

\[
                 \xi=(a+bv)\,\frac{dt}{vh}.
\]

The divisor statements show that such a differential is holomorphic
exactly when

\[
 \deg a\le6,\quad \deg b\le3,\quad q\mid a,\quad
 a+b(2+2t^2+2t^4)\equiv0\pmod{t^5}.                 \tag{2}
\]

Indeed the frame \(dt/(vh)\) is a unit at each ramification point
\(R_i\); at \(Q_0\) its pole order is five, giving the jet condition.
At \(W_a,W_b\) its pole order is one, giving \(q\mid a\). At either
infinity its zero order is six, giving the degree bounds. Elsewhere the
numerator must be regular, hence belongs to \(k[t,v]\). Cancellation
cannot improve the degree bound at both infinities simultaneously.

There are eleven coefficients and seven independent constraints in
(2), giving the complete four-dimensional anti-invariant space. One
scalar-elimination basis consists of pairs \((a_i,b_i)\):

\[
\begin{aligned}
 &(t^6+1,\ 3t^2+2),\\
 &(4rt^6+4t^5+t,\ 3t^3+2t),\\
 &(3t^6+2rt^5+t^4+t^2,\ 2t^2),\\
 &(4rt^6+3t^5+t^3,\ 2t^3).
\end{aligned}                                             \tag{3}
\]

## 2. Exact semilinear Cartier computation

For a polynomial \(P\), define

\[
 \mathcal C(P)=\sum_{j\ge0} P_{5j+4}^{1/5}t^j.
\]

In \(\mathbf F_{25}\), taking fifth roots is itself fifth powering.
Reduce

\[
       (a+bv)(qe)^2=A_1+B_1v.
\]

Then the exact Cartier formula is

\[
 C\left((a+bv)\frac{dt}{vh}\right)
      =\bigl(\mathcal C(F^2A_1)+v\mathcal C(B_1)\bigr)
                                        \frac{dt}{vh}. \tag{4}
\]

To see this, write the original denominator as \(v^5h^5\), multiplying
the numerator by \(F^2(qe)^2\), and use \(F^2v=v^5\). Cartier is linear
over fifth powers with their fifth roots on the output, giving (4).

In basis (3), with columns recording images, the matrix is

\[
 M=\begin{pmatrix}
 1&0&0&3r\\
 2r&3&4r&4\\
 1&4r&4&3r\\
 0&0&3r&3
 \end{pmatrix}.
\]

Every image is checked to satisfy (2) and is reconstructed directly
from (3). The certificate computes the matrices of the semilinear
iterates by \(N_0=I\), \(N_{j+1}=M N_j^{(5)}\), and their scalar
Gaussian-elimination ranks are

\[
                         4,4,4,4,4,4.
\]

Thus the anti-invariant part is Cartier-bijective and contributes four
to the p-rank. Together with the invariant contribution one, this gives
\(f(X)=5\).

## 3. Why optimized finite-field matrix routines were excluded

During this calculation, SageMath 10.9 matrix routines over the specified
custom representation \(\mathbf F_5[r]/(r^2-3)\) returned a purported
kernel vector that failed a direct polynomial constraint. Rank and solve
operations also contradicted direct coefficient reconstructions. The
cause is not diagnosed here, and no general software claim is made.

The final certificate therefore calls **no Sage matrix constructor,
kernel, rank, solve, or matrix-product routine**. Kernel construction,
coordinates, products and ranks are all computed by explicit scalar
field operations; basis and image identities are independently checked
as polynomial coefficient equalities. No numerical arithmetic is used.

## 4. Exact scope of the negative result

For either of the two surviving classes, the actual Klein-four cover
\(Z\to B\) has

\[
 f(Z)=f(Y)+f(X)+f(B')-2f(B)=4+5+1-2=8.
\]

Hence \(Z\to Y\) does not preserve p-rank. The other thirteen unramified
classes already have \(f(B')=2\), and their twists satisfy \(f(X)\ge
f(B)=1\), by the degree-two pullback/trace splitting. They cannot meet
the rank criterion either. Thus **the whole fifteen-class packet fails
the specific rank-preserving strategy of file 119**.

This does not prove that the twists have Tango structures, does not
settle unrestricted étale Tango descent, and does not produce a
counterexample to it. No higher-degree or further-curve search was
undertaken.
