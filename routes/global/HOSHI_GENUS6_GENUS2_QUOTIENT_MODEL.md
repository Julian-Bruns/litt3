# Explicit genus-two quotient and quadratic presentation of the Hoshi curve

**Status:** exact identities and author proof, 2026-09-05; not independently
audited. No unramified twists were enumerated. The existing fixed pair is
unchanged.

For the genus-six curve

\[
 E:y^2=x^3+3x+2,\qquad
 Y:w^6=(x+3)y+4x^2+4x+3,
\]

the involution \(\tau(Q,w)=(P-Q,2/w)\), \(P=(1,1)\), has the following
explicit smooth genus-two quotient:

\[
 \boxed{B:\quad v^2=2t^6+2t^4+3t^2+4.}                \tag{1}
\]

The original quadratic cover \(Y\to B\) is the smooth projective
normalization of

\[
 \boxed{h^2=2t^8+4t^6+2+(t^2+4)v.}                   \tag{2}
\]

Both equations are over \(\mathbf F_5\). The
[certificate](HOSHI_GENUS6_GENUS2_QUOTIENT_MODEL_CERTIFICATE.py), run with
`sage -python`, verifies them identically in the original function field
and reproduces the finite coefficient reconstruction. It does not rely
on sampled point identities.

## 1. Exact generators and proof that this is the quotient

Use \(\beta,\eta_2,\eta_4\) from the
[ten-Tango note](HOSHI_GENUS6_EXACT_TANGO_COUNT.md). The invariant regular
differentials

\[
 \nu_1=(w-2/w)\beta,\qquad \nu_2=\eta_2-\eta_4
\]

are independent and form the holomorphic differential basis downstairs.
Their invariance follows from \(\tau^*\beta=-\beta\),
\(\tau^*\eta_2=4\eta_4\), and \(\tau^*\eta_4=4\eta_2\).
Define inside \(k(Y)\)

\[
              t=\nu_2/\nu_1,\qquad v=dt/\nu_1.       \tag{3}
\]

Both are invariant under \(\tau\). Exact reduction in the separating
degree-five presentation over \(k(w)\) gives (1). Its sextic is squarefree,
so the displayed hyperelliptic curve is smooth of genus two after taking
its standard projective model.

For completeness, this inclusion of function fields gives the whole
quotient, not a smaller subfield. The geometric quotient \(Y/\tau\)
has genus two, by the independently proved six-fixed-point calculation.
The derivative of \(t\) is nonzero, so the induced map from that quotient
to (1) is separable. Riemann--Hurwitz between two genus-two curves forces
its degree to be one. Thus \(k(B)=k(t,v)\).

## 2. The quadratic generator

Set \(a=w-2/w\); it is anti-invariant and nonzero. The exact identity is

\[
 a^2=\frac{2t^8+4t^6+2+(t^2+4)v}{t^{10}}.             \tag{4}
\]

Multiplying by the square \(t^{10}\), and putting \(h=t^5a\), gives
(2). As \(\tau(h)=-h\ne h\), the element \(h\) is not in the invariant
field and generates its degree-two extension. Consequently (1)--(2)
reconstruct the original function field exactly; normalization produces
the original smooth curve, even if a particular affine chart of these
equations is singular.

One useful exact norm identity is

\[
 \begin{aligned}
 &(2t^8+4t^6+2)^2-(t^2+4)^2(2t^6+2t^4+3t^2+4)\\
 &\hspace{25mm}=4t^{10}(t^6+4t^4+4t^2+2).             \tag{5}
 \end{aligned}
\]

The factor \(t^{10}\) is even; it must not be mistaken for ten additional
branch points. The smooth cover remains the six-branched-point double
cover proved in the [reflection note](HOSHI_GENUS6_REFLECTION_AND_TWIST_BOUNDARY.md).

## 3. Readiness for a future bounded twist test

The hyperelliptic branch polynomial factors as

\[
 2t^6+2t^4+3t^2+4
     =2(t^2+2)(t^2+2t+4)(t^2+3t+4),                  \tag{6}
\]

with all three quadratic factors irreducible over \(\mathbf F_5\).
Hence all six Weierstrass points, and all fifteen geometric nonzero
two-torsion classes of \(J_B\), are defined over \(\mathbf F_{25}\).
The Cartier matrix in the basis \(dt/v,t\,dt/v\) is

\[
                       \begin{pmatrix}0&0\\0&1\end{pmatrix},
\]

confirming that \(B\) has p-rank one. Formula (2) can now be multiplied
by rational representatives of the unramified quadratic classes when
such a test is requested. No assertion about the p-ranks or Tango
structures of those twists follows from the equations alone, and none
has been computed here.
