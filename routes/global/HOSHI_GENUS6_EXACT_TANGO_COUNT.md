# A genus-six curve with exactly ten maximal Tango structures in characteristic five

**Status:** exact computation and author proof, 2026-09-05; not independently
audited. This is an auxiliary example, not a replacement of either curve in
file 76 and not a common-cover counterexample.

The smooth projective normalization of

\[
 E:\ y^2=x^3+3x+2,\qquad
 Y:\ w^6=(x+3)y+4x^2+4x+3
\]

over \(\overline{\mathbf F}_5\) has genus six, p-rank four, and **exactly ten
maximal Tango structures**. In particular a universal bound
\(\#\operatorname{Tan}(C)\le p-1\), without a p-rank-one hypothesis, is false.
This does not contradict the affine-line bound of \(p-1\) in file 111 or
the higher-rank bound in file 117.

The complete exact-arithmetic certificate is
[HOSHI_GENUS6_EXACT_TANGO_COUNT_CERTIFICATE.py](HOSHI_GENUS6_EXACT_TANGO_COUNT_CERTIFICATE.py).
Run it with `sage -python`; it was tested with SageMath 10.9. The entire
625-element enumeration and symbolic verification take only a few seconds.

## 1. Geometry and the space of regular differentials

Write \(P=(1,1)\in E(\mathbf F_5)\), and let \(O\) be the origin. For
\(f=(x+3)y+4x^2+4x+3\), the identities

\[
 \operatorname{div}_E(f)=5P-5O,\qquad
 \frac{df}{f}=\frac{dx}{2y}
\]

are proved in the companion
[p-rank certificate](HOSHI_GENUS6_F5_KUMMER_P_RANK_CERTIFICATE.sage).
The valuations \(\pm5\) imply that the Kummer extension of degree six is
geometrically connected, tame, and totally ramified exactly at \(P,O\).
Thus Riemann--Hurwitz gives \(g(Y)=6\). Write \(P_Y,O_Y\) for their unique
preimages. Then

\[
 \beta=dw/w=\pi^*(dx/(2y)),\quad
 \operatorname{div}(w)=5P_Y-5O_Y,\quad
 \operatorname{div}(\beta)=5P_Y+5O_Y,\quad
 \operatorname{div}(dw)=10P_Y.                         \tag{1}
\]

Let \((x',y')\) denote the coordinates of \(Q-P\) for the variable point
\(Q=(x,y)\) on \(E\), explicitly

\[
 s=\frac{y+1}{x-1},\quad x'=s^2-x-1,\quad
 y'=-y+s(x-x').
\]

Set

\[
 v_2=x'-1,\quad v_3=y'-2x'-2,\quad
 v_4=y'+2(x')^2+4x'.
\]

For \(j=2,3,4\), the only pole of \(v_j\) is an order-\(j\) pole at
\(P\), and its vanishing order at \(O\) is \(j-1\). The pole statements
follow from the ordinary pole orders of translated Weierstrass
coordinates. The zero statements follow by expanding at
\((x',y')=(1,4)\); the certificate checks these jets exactly.
Consequently

\[
 \beta,\quad w\beta,\quad
 \eta_2=v_2w^2\beta,\quad \eta_3=v_3w^3\beta,\quad
 \eta_4=v_4w^4\beta,\quad w^{-1}\beta                 \tag{2}
\]

are regular: at \(P_Y,O_Y\), the respective orders of \(\eta_j\) are
\(5-j,j-1\). They are independent because their six Kummer characters
are distinct. Since the genus is six, (2) is a basis of
\(H^0(Y,\omega_Y)\).

## 2. All 625 dormant canonical connections

The exact Cartier computation is

\[
 C\beta=\beta,\quad C(w\beta)=C(w^{-1}\beta)=0,\quad
 C\eta_2=4\eta_4,\quad C\eta_3=3\eta_3,\quad
 C\eta_4=4\eta_2.                                    \tag{3}
\]

The certificate verifies these identities in a separating function-field
presentation. In particular the Cartier stable dimension is four; this
independently recovers the p-rank computed by point counts in the
[companion note](HOSHI_GENUS6_F5_KUMMER_P_RANK.md).

Use the following specified field and constants:

\[
 k_0=\mathbf F_5[u]/(u^4+4u^2+4u+2),\qquad
 \lambda=2u^3+2u^2+2u,\quad
 \mu=3u^3+u^2+3u+1.
\]

They satisfy \(\lambda^4=4\) and \(\mu^4=3\). An
\(\mathbf F_5\)-basis of **all geometric** Cartier-fixed regular forms is

\[
 \beta,\quad \eta_2-\eta_4,\quad
 \lambda(\eta_2+\eta_4),\quad \mu\eta_3.              \tag{4}
\]

Indeed these four forms are Cartier-fixed by (3), independent over the
algebraic closure, and the Cartier-fixed space has dimension four over
\(\mathbf F_5\). Thus no further fixed forms appear upon extending
\(k_0\).

Let \(\nabla_0\) be the rational connection for which \(dw\) is
horizontal. Equation (1) makes it regular everywhere: locally a
rational horizontal frame is a fifth power of a local parameter times
a unit, so its logarithmic connection coefficient is regular.
It is dormant by its rational horizontal section. All dormant regular
connections on \(\omega_Y\) are uniquely \(\nabla_0+\alpha\), with
\(\alpha\) in the 625-element space (4). This is the standard Cartier
descent parametrization, also explained in the local connection note.

For \(c=(c_0,c_1,c_2,c_3)\in\mathbf F_5^4\), their coefficients in the
frame \(dw\) are therefore

\[
 a_c=c_0/w+c_1(v_2w-v_4w^3)
       +c_2\lambda(v_2w+v_4w^3)+c_3\mu v_3w^2.
                                                               \tag{5}
\]

## 3. Exact Tango test and result

Put \(D=d/dw\). The separating presentation used by the certificate is

\[
 k_0(Y)=k_0(w)[z]/
 \bigl(4z^5+(2z^2+z+3)w^6+w^{12}\bigr),\qquad z=x-1.
                                                               \tag{6}
\]

For a horizontal differential \(h\,dw\), one has \(Dh=-a_ch\), whence

\[
 D^4h=P_4(a_c)h,\quad
 P_4(a)=a^4-a^2Da+3(Da)^2+4aD^2a-D^3a.              \tag{7}
\]

The Cartier formula implies that its horizontal line is Cartier-zero
if and only if \(P_4(a_c)=0\). Because the connections in (5) are
already globally regular and dormant, this is exactly the maximal
Tango condition, not merely a local or generic surrogate. Different
connections give different embedded descended Tango lines.

The computation exhausts all 625 tuples. It first evaluates (7) at a
specified regular point over \(k_0\), checking that all denominators
are nonzero. Nonzero evaluations rigorously reject 615 tuples. It then
verifies (7) **identically in (6)** for all ten survivors:

```text
(0,0,0,0), (2,0,0,0), (3,0,0,0), (4,0,0,0),
(3,2,0,0), (4,2,0,0),
(3,4,2,0), (4,4,2,0),
(3,4,3,0), (4,4,3,0).
```

Thus the exact geometric count is ten. The first four are the known
structures on the \(\beta\)-direction line; the other six are distinct
additional structures. The exceptional non-Tango point on that line
is \(c=(1,0,0,0)\), the connection for which \(\beta\) is horizontal.

## 4. Affine span and the Kummer automorphism action

The ten points contain the origin and span exactly the three-dimensional
\(\mathbf F_5\)-hyperplane \(c_3=0\). In the specified constant field,
\(\lambda^2=3\), and \(\zeta=\lambda+3\) is a primitive sixth root of
unity. The Kummer automorphism \(\sigma:w\mapsto\zeta w\) fixes
\(x,y\) and acts by weights \(0,2,3,4\) on
\(\beta,\eta_2,\eta_3,\eta_4\), respectively. The connection
\(\nabla_0\) is invariant because \(\sigma^*dw=\zeta dw\) differs by
a constant. Hence its action on the four connection coordinates is
linear, with no hidden translation:

\[
 \boxed{\sigma^*(c_0,c_1,c_2,c_3)
   =(c_0,\ 2c_1+3c_2,\ c_1+2c_2,\ -c_3).}
\]

There are four singleton orbits, namely the known \(\beta\)-line
structures \((c_0,0,0,0)\) for \(c_0=0,2,3,4\). The remaining six
structures split into **two length-three orbits**, not one orbit of six:

\[
 (a,2,0,0)\longmapsto(a,4,2,0)
 \longmapsto(a,4,3,0)\longmapsto(a,2,0,0),
 \qquad a=3,4.
\]

In particular the order-two subgroup of \(\mu_6\) fixes all ten Tango
structures; the induced action on this set factors through \(C_3\).
The certificate checks the matrix, preservation of the set, its affine
span, and this complete orbit decomposition exactly.

The curve construction is the \(q=5,n=1\) case of Hoshi's
[RIMS1917, Theorem 3 and Remark 10](https://www.kurims.kyoto-u.ac.jp/preprint/file/RIMS1917.pdf).
The exact count here is a separately recorded finite computation; no
claim about the existing literature's knowledge of this count is made.
