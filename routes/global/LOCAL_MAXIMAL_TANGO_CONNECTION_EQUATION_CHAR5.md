# The local connection equation for maximal Tango structures in characteristic five

**Status: author proof and exact symbolic check, 2026-09-05; not independently
audited.**

This note gives a coordinate-invariant differential equation for maximal
Tango structures.  The equation is precise only on the affine space of
regular connections on the canonical bundle; it does not prove that this
space, or its solution locus, is nonempty.

Throughout, \(C\) is a smooth projective curve over an algebraically closed
field of characteristic five.

## 1. The local polynomial

Choose a local parameter \(t\), write \(\partial=d/dt\), and describe a
connection on \(\omega_C\) by

\[
                \nabla(dt)=a\,dt\otimes dt.
\]

A horizontal differential \(fdt\) then satisfies

\[
                         \partial f=-af.                 \tag{1.1}
\]

Set \(P_0=1\) and

\[
                         P_{n+1}=\partial P_n-aP_n.
\]

Then \(\partial^nf=P_nf\), and exact expansion in \(\mathbf F _5\) gives

\[
\begin{aligned}
 P_1={}&-a,\\
 P_2={}&a^2-a',\\
 P_3={}&-a^3+3aa'-a'',\\
 \boxed{P_4={}&a^4-a^2a'+3(a')^2+4aa''-a'''},           \tag{1.2}\\
 P_5={}&-a^5-a''''.
\end{aligned}
\]

The last equality can also be checked from \(P_5=P_4'-aP_4\): all mixed
terms cancel in characteristic five.

For a differential \(fdt\), the Cartier formula is

\[
 \operatorname{Car}(fdt)
       =\bigl(-\partial^4f\bigr)^{1/5}dt.                \tag{1.3}
\]

Consequently a horizontal differential is Cartier-zero exactly when

\[
                             P_4(a)=0.                  \tag{1.4}
\]

For \(D=\partial+a\), the fifth-power identity

\[
                 D^5=\partial^5+a^5+a''''
\]

shows that \(a^5+a''''\) is the local coefficient of the \(5\)-curvature.
Thus (1.2) proves directly that (1.4) implies zero \(5\)-curvature.  The
converse is false; zero curvature only imposes \(P_5=0\).

## 2. Coordinate invariance and gluing

Let \(u\) be another parameter and put \(q=dt/du\).  Comparing the two
coordinate frames gives the connection transformation law

\[
                 a_u=q a_t-\frac{q'}q,                  \tag{2.1}
\]

where the prime on the right denotes \(d/du\) when applied to \(q\).
If \(f_tdt=f_udu\), then \(f_u=qf_t\).  Coordinate invariance of Cartier,
or a direct characteristic-five differentiation, gives

\[
 \left(\frac d{du}\right)^4(qf_t)
      =q^5\left(\frac d{dt}\right)^4f_t.
\]

Dividing by \(f_u=qf_t\) yields

\[
                       P_4(a_u)=q^4P_4(a_t).             \tag{2.2}
\]

Therefore

\[
                         P_4(a_t)(dt)^4                 \tag{2.3}
\]

is a globally defined section of \(\omega_C^4\).  In particular, (1.4)
is a coordinate-independent condition on a regular connection.

A line bundle on a smooth projective curve admits a regular connection
exactly when its degree vanishes in the ground field.  Thus
\(\omega_C\) can admit such a connection only when

\[
                         5\mid 2g(C)-2.                 \tag{2.4}
\]

When nonempty, the space of regular connections on \(\omega_C\) is an
affine space under \(H^0(C,\omega_C)\).  Equation (2.3) defines a
degree-at-most-four polynomial map from that affine space to
\(H^0(C,\omega_C^4)\).  Merely finding a local function \(a\) satisfying
(1.2) does not provide the affine transition laws (2.1), and therefore does
not by itself provide a global connection.

## 3. Equivalence with the maximal Cartier-zero condition

### Proposition

Regular connections on \(\omega_C\) satisfying \(P_4=0\) are equivalent to
canonical connections obtained from nonzero rational differentials \(\xi\)
such that

\[
             \operatorname{Car}(\xi)=0,
             \qquad \operatorname{div}(\xi)=5D          \tag{3.1}
\]

for a divisor \(D\).  In particular these are precisely the connection
forms of maximal Tango structures.  They form a finite set.

#### Proof

If a regular connection satisfies \(P_4=0\), Section 1 shows that its
\(5\)-curvature vanishes.  Cartier descent writes it as the canonical
connection on \(F^*M\), for a line bundle \(M\) on the Frobenius twist of
\(C\).  Choose a nonzero rational section of \(M\).  Its pullback is a
rational horizontal section \(\xi\) of \(\omega_C\), and its divisor is
five times a divisor.  Locally \(\xi=fdt\); equations (1.2)--(1.4) give
\(\operatorname{Car}(\xi)=0\).

Conversely, write a differential satisfying (3.1) locally as
\(\xi=fdt\), and declare it horizontal, so \(a=-f'/f\).  At a zero or pole,

\[
                         f=t^{5m}v,
\]

with \(v\) a unit.  Hence \(a=-v'/v\) is regular.  These local expressions
obey (2.1) and give a regular global connection on \(\omega_C\).  Formula
(1.3) gives \(P_4(a)=0\).

For finiteness, two regular connections differ locally by \(b-a=v\), and
the coefficients \(vdt\) glue to a global regular differential.  If both
connections have zero \(5\)-curvature, then

\[
                        v''''+v^5=0,                    \tag{3.2}
\]

or equivalently

\[
                    \operatorname{Car}(vdt)=vdt.
\]

The Cartier-fixed regular differentials form an \(\mathbf F _5\)-vector
space of dimension equal to the \(5\)-rank \(f(C)\).  Thus, once one
zero-curvature connection is fixed, there are exactly \(5^{f(C)}\) such
connections.  The locus satisfying the stronger equation \(P_4=0\) is a
subset and is therefore finite.  QED.

### Lemma (a Cartier-fixed affine line is never entirely Tango)

Let \(a\) be any regular zero-\(5\)-curvature connection coefficient and
let \(b\,dt\ne0\) be a global Cartier-fixed regular differential.  Then all
five connections

\[
                         a+t b,\qquad t\in\mathbf F _5,  \tag{3.3}
\]

have zero \(5\)-curvature, but at most four of them satisfy \(P_4=0\).

#### Proof

Equation (3.2), together with \(t^5=t\), shows that every member of (3.3)
has the same zero \(5\)-curvature.  Regard

\[
                         P_4(a+Tb)
\]

as a polynomial in \(T\) with coefficients in
\(H^0(C,\omega_C^4)\).  It has degree exactly four: the coefficient of
\(T^4\) is the nonzero section \(b^4\), while every other term in (1.2) has
degree at most three in \(T\).  A nonzero polynomial of degree four over
\(\mathbf F _5\), including one with coefficients in a vector space, cannot
vanish at all five elements of \(\mathbf F _5\).  Hence at most four members
of (3.3) are Tango.  QED.

This is only a one-dimensional statement.  It makes no descent assertion
for higher-dimensional Cartier-fixed translation spaces.

## 4. The exact difference equation

For two coefficients \(a\) and \(a+v\), direct expansion of (1.2) gives

\[
\begin{aligned}
 P_4(a+v)-P_4(a)={}&v^4-av^3+a^2v^2-a^3v
   -2aa'v-a'v^2-a^2v'\\
 &-2avv'-v^2v'-a''v+a'v'-2(v')^2
   -av''-vv''-v'''.                                    \tag{4.1}
\end{aligned}
\]

All coefficients are in \(\mathbf F _5\).  Under a coordinate change,
\(v_u=qv_t\), so \(vdt\) is a global one-form, and (4.1) transforms with
weight four by (2.2).  If \(P_4(a)=0\), then \(a+v\) is another maximal
Tango connection exactly when the right side of (4.1) vanishes.  Such a
solution automatically also satisfies the weaker Cartier-fixed equation
(3.2).

## 5. Two local checks

For \(f=t^j\), one has

\[
 a=-\frac jt,
 \qquad
 P_4(a)=j(j-1)(j-2)(j-3)t^{-4}.                         \tag{5.1}
\]

Thus \(fdt\) is Cartier-zero precisely for

\[
                         j\not\equiv4\pmod5.
\]

However, the connection extends regularly across \(t=0\) only for
\(j\equiv0\pmod5\); this is exactly the requirement that the local order of
the horizontal differential be divisible by five.  The other allowed
Cartier residues describe logarithmic, not regular, connection forms.

For the unit \(f=1+ct\),

\[
                  a=-\frac c{1+ct},
\]

which is regular wherever \(1+ct\) is a unit.  Since \(\partial^2f=0\),
one has \(P_4(a)=0\).  This confirms that the local equation has many formal
solutions even though its global solution set on a fixed projective curve
is finite and may be empty.
