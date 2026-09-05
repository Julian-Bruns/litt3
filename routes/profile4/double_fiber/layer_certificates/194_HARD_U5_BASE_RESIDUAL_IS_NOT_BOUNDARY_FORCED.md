# The hard repeated-\(u^5\) base residual is not boundary-forced

## Status and scope

This note is **proved-text** in the exact boundary-compatible coefficient
space of files 79, 190, and 193.  It gives two explicit points on the hard
locus

\[
 c+d=cd=1
\]

which have the same three boundary fibers, the exact trace coefficient
\(a_{34}\) from file 193, a clean second blow-up, and vanishing of all
four polar \(u^0\) differential residuals.  After solving the simple
\(u^5\) equation, their exceptional repeated-\(u^5\) cokernel
scalars are respectively \(0\) and \(2\).

Consequently, the scalar \(\lambda(p^{-1}b_5)\) in file 192 is not
determined by the boundary data, even after the global trace identity of
file 193 is imposed.  It genuinely depends on older coefficient data.

The two displayed coefficient points are not asserted to define smooth,
irreducible profile curves, and they are not asserted to satisfy the
differential equation at the other fibers.  Thus this is a no-go theorem
for a boundary-only elimination of the hard locus, not a construction of a
common-cover counterexample.

The exact calculation is independently rerun by
`194_HARD_U5_BASE_RESIDUAL_VERIFY.sage` in the same directory.  It uses no
random choices or stored output.

## The two exact coefficient points

Let

\[
 L=\mathbf F_5[c]/(c^2-c+1),\qquad d=1-c.
\]

Then \(c+d=cd=1\), and \(c,d\) are distinct and avoid
\(0,1\).  We take \(\alpha=1\), so the boundary scalar in file 79
is also one.  Write

\[
 (1-z)^{31}=\sum_{j=0}^{31}A_jz^j,\qquad
 z^{32}(z-1)^2(z+1)=\sum_{j=0}^{35}B_jz^j.
\]

For \(\epsilon\in\{0,1\}\), define
\(f_\epsilon(x,z)=\sum_{j=0}^{35}a_j^{(\epsilon)}(x)z^j\)
as follows:

\[
\begin{aligned}
 a_0^{(\epsilon)}&=(x-1)^2,\\
 a_j^{(\epsilon)}&=(1-x)A_j+xB_j
       +x(x-1)U_j^{(\epsilon)}(x)\qquad(1\le j\le33),\\
 a_{34}^{(\epsilon)}&=
 x^3\bigl(x^3+3(c+1)x^2+(2c+2)x+3\bigr),\\
 a_{35}^{(\epsilon)}&=x^4(x^2-x+1).
\end{aligned}
\tag{194.1}
\]

The nonzero polynomials \(U_j^{(\epsilon)}\) are the following;
every omitted \(U_j\) is zero.

| \(j\) | \(U_j^{(0)}(x)\) | \(U_j^{(1)}(x)\) |
| ---: | --- | --- |
| 33 | \(4+4x+(c+4)x^2\) | same |
| 32 | \(4+4cx\) | same |
| 31 | \(2c+2+2x\) | same |
| 30 | \(2\) | same |
| 29 | \((3c+1)x^2\) | same |
| 28 | \(0\) | \(1\) |
| 27 | \(4c+4+(2c+4)x+(c+3)x^2\) | \(2+(3c+3)x+(c+3)x^2\) |
| 22 | \(2c+1\) | \(4c+2\) |

The entries at \(j=27\) are older first-layer coefficients.  At the
new \(u^5\) layer, all variables are set to zero except the simple pivot
\(U_{22}(0)\), whose two solved values are displayed in the last row.

### Boundary and trace checks

Equation (194.1) immediately gives

\[
\begin{aligned}
 f_\epsilon(x,0)&=(x-1)^2,\\
 f_\epsilon(0,z)&=(1-z)^{31},\\
 f_\epsilon(1,z)&=z^{32}(z-1)^2(z+1).
\end{aligned}
\tag{194.2}
\]

Every variable part is \(x(x-1)U_j\) with \(\deg U_j\le3\).
Thus the degree bounds of file 190 hold.  The coefficient of \(x^6\)
is \(z^{34}(z+1)\).  Moreover, since \(cd=1\) and
\(d=1-c\), the displayed \(a_{34}\) is exactly

\[
 x^3\bigl(x^3+3(c+1)x^2+(cd+3c+d)x+3cd\bigr),
\]

the forced trace coefficient (193.5).  Thus no formerly free
\(a_{34}\)-direction is being used in these examples.

## Clean polar branches and the first residual

Put

\[
 \Phi_\epsilon(u,w)=w^{35}f_\epsilon(u,w^{-1}).
\]

Direct substitution in (194.1) gives

\[
 \Phi_\epsilon(u,u+u^2y)
 =u^7\bigl(3y(y-1)(y-2)+O(u)\bigr).
\tag{194.3}
\]

Hence the three repeated second-order slopes are \(0,1,2\), and the
second blow-up is clean.  The fourth polar branch has tangent \(w=-u\).

For any one of these branches write \(z=w^{-1}=\sum Z_nu^n\), and
put

\[
 E_m=[u^{5m}](D^4z-z+z^5)
     =Z_m^5-\sum_{j=0}^4Z_{5m+j},\qquad
 D=(u-1)\frac d{du}.
\tag{194.4}
\]

Successive coefficient comparison in \(\Phi_\epsilon(u,w)=0\)
is triangular: the simple branch has derivative order three, while each
repeated branch has derivative order five and unit leading coefficient
\(P_0'(s)\).  Solving through \(w_{11}\), and then applying
(194.4), gives the following exact table.  The repeated entries are ordered
by slopes \(s=0,1,2\).

| \(\epsilon\) | simple \(E_0\) | repeated \((E_0(s))_s\) | simple \(E_1\) | repeated \((E_1(s))_s\) |
| ---: | ---: | --- | ---: | --- |
| 0 | 0 | \((0,0,0)\) | 0 | \((c+3, 4c+4, 3)\) |
| 1 | 0 | \((0,0,0)\) | 0 | \((c+2, 2c+4, 2c+3)\) |

This is a finite exact calculation in the quadratic field \(L\), not
a numerical sample.  For transparency, the verifier constructs all 36
coefficient polynomials, checks (194.2), the degree bounds, (193.5), and
(194.3), solves each branch by the stated triangular recurrence, substitutes
it back into \(\Phi_\epsilon\) through the required order, and
finally evaluates (194.4).

## The exceptional cokernel values

Here the tangent scalar is \(a=-cd=4\), so the leading coefficient of
the clean cubic is

\[
 \gamma=2a=3.
\]

The simple \(E_1\) entry in the table is zero, exactly as required
after the simple-\(u^5\) pivot solve.  Proposition 193.2 therefore
identifies the exceptional repeated scalar with

\[
 \lambda(p^{-1}b_5)=\gamma\sum_{s=0,1,2}E_1(s).
\tag{194.5}
\]

For \(\epsilon=0\), the sum in (194.5) is

\[
 (c+3)+(4c+4)+3=0.
\]

For \(\epsilon=1\), it is

\[
 (c+2)+(2c+4)+(2c+3)=4,
\]

and multiplication by \(\gamma=3\) gives \(2\).  Thus

\[
 \boxed{
 \lambda(p^{-1}b_5)=0\quad\text{at }\epsilon=0,\qquad
 \lambda(p^{-1}b_5)=2\quad\text{at }\epsilon=1.}
\tag{194.6}
\]

This proves the claimed dependence on older coefficients.

## Consequence for the proof route

The exact global trace fixes \(a_{34}\), but it fixes only the sum of
the polar and regular-cluster traces.  The two points above show concretely
that the regular-cluster contribution in (193.11) is not determined by the
three boundary fibers and the first polar residual equations.  Therefore
one cannot infer either automatic vanishing or automatic nonvanishing of
(192.23) from the boundary or trace identities alone.

Any elimination of the hard locus at this stage must carry the relevant
older coefficient relations from the other local fibers, or compute the
regular order-31 cluster term itself.  Files 192 and 193 correctly leave
that equation open; any stronger boundary-only inference is invalidated by
(194.6).
