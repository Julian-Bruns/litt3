# The first Witt class as a Frobenius Cech cocycle

## Status and purpose

**Status: proved.**  This note gives an explicit test for the class
\(\delta _1(q,r)\) of file 32.  For a three-point tame cover, the test is
obtained from the two elementary local Frobenius liftings

\[
                    t\longmapsto t^5,
             \qquad t\longmapsto 1+(t-1)^5.
\]

Their discrepancy is the polynomial

\[
 \chi(t):=\frac{1+(t-1)^5-t^5}{5}\bmod 5
        =-t^4+2t^3-2t^2+t
        =-t(t-1)(t^2-t+1).                         \tag{37.1}
\]

If \(z\) is a local parameter on the source, the cover \(q\) produces the
Cech cocycle

\[
                  \epsilon_q(z)=
              \frac{\chi(q)}{(dq/dz)^5}(\partial_z)^{[5]}.              \tag{37.2}
\]

Here \((\partial_z)^{[5]}\) denotes the local frame of
\(F^*\Theta\), or equivalently the Frobenius-linear derivation which sends
\(z\) to one.  The main result is

\[
       F^*\delta _1(q,r)=[\epsilon_r]-[\epsilon_q].                    \tag{37.3}
\]

For every source curve of genus at least two, the Frobenius map on the
left of (37.3) is injective.  Thus (37.3) is an exact criterion, not merely
a necessary condition.  In the order-seven situation it says that the
first obstruction vanishes exactly when the explicitly computable class
\([\epsilon_q]\) is invariant.

The criterion is cohomological.  It does **not** say that
\(d r/d q\) is a fifth power.  A genus-fifteen three-point example at the
end shows that even simultaneous lifting through every Witt level does not
imply that conclusion.  Hence a proof of fifth-power rigidity for the
asymmetric triangle must use its fiber labels in addition to the bare
Witt-lifting condition.

Throughout, \(k=\overline{\mathbf F}_5\).  Frobenius twists are suppressed
from the notation when the perfectness of \(k\) gives an unambiguous
identification.

## 1. Variation of the Deligne--Illusie class

Let \(C/k\) be a smooth projective connected curve, and let
\(F:C\to C^{(1)}\) be relative Frobenius.  A marked lifting
\(\widetilde C/W_2(k)\) has a Deligne--Illusie class

\[
       \operatorname{DI}(\widetilde C)
          \in H^1\!\left(C,F^*\Theta_{C^{(1)}}\right).                 \tag{37.4}
\]

To define it, choose an affine cover and local liftings of relative
Frobenius.  The difference of two such local liftings, divided by \(5\),
is a Frobenius-linear derivation.  These differences form a Cech
one-cocycle with values in \(F^*\Theta_{C^{(1)}}\).  Changing the local
liftings changes the cocycle by a coboundary.

### Proposition 37.5 (variation formula)

Let \(\widetilde C_0\) and \(\widetilde C_1\) be two marked
\(W_2(k)\)-liftings, and let

\[
       \Delta=[\widetilde C_1]-[\widetilde C_0]
                         \in H^1(C,\Theta_C)                             \tag{37.5}
\]

be their ordered deformation-torsor difference.  With compatible Cech
sign conventions,

\[
 \operatorname{DI}(\widetilde C_1)
       -\operatorname{DI}(\widetilde C_0)
                         =F^*\Delta.                                    \tag{37.6}
\]

If \(g(C)\geq2\), the map

\[
 F^*:H^1(C,\Theta_C)\longrightarrow
          H^1\!\left(C,F^*\Theta_{C^{(1)}}\right)                       \tag{37.7}
\]

is injective.

#### Proof

Choose common affine local models for the two liftings.  On an overlap,
write the change in a lifted transition coordinate in the form

\[
              z_j=\widetilde f_{ij}(z_i)+5a_{ij}(z_i).                  \tag{37.8}
\]

The vector fields represented by the \(a_{ij}\) form the Cech cocycle
for \(\Delta\).  Modulo \(25\), the term \(5a_{ij}\) makes no contribution
to

\[
                    (\widetilde f_{ij}+5a_{ij})^5,
\]

but Frobenius on the twisted target transition sends it to
\(5a_{ij}^5\).  Thus the change in the Frobenius-discrepancy cocycle is
exactly the Frobenius pullback of the vector field represented by
\(a_{ij}\).  This proves (37.6).  Reversing both Cech conventions reverses
both sides and has no effect on any assertion below.

It remains to prove injectivity.  Put

\[
 B^1=\operatorname{im}\bigl(d:F_*\mathcal O_C\to F_*\omega_C\bigr).
\]

The Cartier sequences are

\[
\begin{aligned}
 0&\longrightarrow\mathcal O_{C^{(1)}}
      \longrightarrow F_*\mathcal O_C\longrightarrow B^1\longrightarrow0,\\
 0&\longrightarrow B^1\longrightarrow F_*\omega_C
      \xrightarrow{\operatorname{Car}}\omega_{C^{(1)}}
      \longrightarrow0.                                                 \tag{37.9}
\end{aligned}
\]

Tensor the second sequence by \(\omega_{C^{(1)}}\).  Projection formula
identifies its middle term with \(F_*\omega_C^{\,6}\).  The induced map on
global sections

\[
 H^0(C,\omega_C^{\,6})
       \longrightarrow H^0(C^{(1)},\omega_{C^{(1)}}^{\,2})              \tag{37.10}
\]

is the Serre dual of (37.7).

Now

\[
 H^1(C^{(1)},\omega_{C^{(1)}}\otimes B^1)^\vee
                         =H^0(C^{(1)},(B^1)^\vee).                       \tag{37.11}
\]

The first sequence in (37.9) gives an injection

\[
 \operatorname{Hom}(B^1,\mathcal O_{C^{(1)}})
       \hookrightarrow
       \operatorname{Hom}(F_*\mathcal O_C,\mathcal O_{C^{(1)}}).
\]

Finite-flat duality for Frobenius identifies the space on the right with

\[
                         H^0(C,\omega_C^{\,1-5}),
\]

which is zero when \(g(C)\geq2\).  Hence (37.11) vanishes, (37.10) is
surjective, and its Serre dual (37.7) is injective. \(\square\)

The injectivity is useful here because a Deligne--Illusie class normally
contains less visibly organized information than a deformation class.  In
this particular degree, no information about the first Witt deformation
is lost.

## 2. The universal three-point cocycle

Let

\[
       \mathcal S=\mathbf P^1_k(n_0,n_1,n_\infty),
              \qquad 5\nmid n_0n_1n_\infty,                            \tag{37.12}
\]

and fix its standard lifting over \(W_2(k)\).  On the open root substacks
obtained by deleting respectively the point over \(1\) and the point over
\(0\), there are local Frobenius liftings with coarse formulas

\[
                 \Phi_0(t)=t^5,
             \qquad \Phi_1(t)=1+(t-1)^5.                               \tag{37.13}
\]

They lift to the root substacks because the relevant root orders are
invertible and each retained marked divisor pulls back with multiplicity
five.  Choices of roots of the units at infinity change only local
trivializations.  On the overlap, their difference divided by five is the
Frobenius-linear derivation sending \(t\) to \(\chi(t)\) from (37.1).

Let

\[
                         q:C\longrightarrow\mathcal S                  \tag{37.14}
\]

be representable finite etale, with \(C\) a scheme.  Pulling back the two
opens in (37.13) gives an affine cover of \(C\).  The unique lifting of the
finite-etale cover gives a marked source lifting \(\widetilde C_q\).

### Proposition 37.15 (explicit pulled-back class)

The class \(\operatorname{DI}(\widetilde C_q)\) is represented on the
pulled-back cover by (37.2).  Consequently, for two legs

\[
                     q,r:C\rightrightarrows\mathcal S,
\]

one has

\[
       F^*\delta_1(q,r)=E(r)-E(q),
       \qquad E(q):=[\epsilon_q]
           \in H^1(C,F^*\Theta_{C^{(1)}}).                              \tag{37.15}
\]

If \(g(C)\geq2\), then

\[
                  \delta_1(q,r)=0
                    \quad\Longleftrightarrow\quad E(q)=E(r).           \tag{37.16}
\]

#### Proof

Lift each local Frobenius in (37.13) uniquely through the finite-etale map
\(\widetilde C_q\to\widetilde{\mathcal S}\).  Their difference is carried
by \(F^*dq\) to the target discrepancy \(\chi(q)\).  If \(z\) is a local
parameter and a Frobenius-linear derivation \(D\) satisfies
\(D(z)=a\), then

\[
                         D(q)=(dq/dz)^5a.                               \tag{37.17}
\]

Solving (37.17) gives (37.2).  At a coarse ramification point this quotient
need not be regular, but that point is absent from one member of the Cech
overlap; it is precisely an allowed pole of the resulting rational coarse
representative.  On the root stack the calculation is regular before
passing to coarse coordinates.  Naturality of the construction gives the
first equality in (37.15), and Proposition 37.5 gives the second.  Finally,
(37.16) follows from the injectivity in Proposition 37.5. \(\square\)

Put \(w=dr/dq\).  On a common refinement, the rational representatives in
(37.15) satisfy

\[
       \epsilon_r=
       \frac{\chi(r)w^{-5}}{(dq/dz)^5}(\partial_z)^{[5]}.               \tag{37.18}
\]

Thus the exact consequence of \(\delta_1(q,r)=0\) is the cohomological
identity

\[
 \left[
   \frac{\chi(r)w^{-5}-\chi(q)}{(dq/dz)^5}(\partial_z)^{[5]}
 \right]=0,                                                            \tag{37.19}
\]

where the brackets retain the two natural Cech covers (or any common
refinement).  Equation (37.19) is not the pointwise assertion that its
numerator is zero.

If \(r=q\circ\alpha\), naturality gives

\[
                         E(r)=\alpha\mathbin\cdot E(q).                 \tag{37.20}
\]

Therefore, for \(g(C)\geq2\),

\[
 \delta_1(q,q\circ\alpha)=0
       \quad\Longleftrightarrow\quad
       E(q)\in H^1(C,F^*\Theta_{C^{(1)}})^{\langle\alpha\rangle}.       \tag{37.21}
\]

This is an explicit form of the invariant-lifting target in file 32.

## 3. Principal parts for the asymmetric triangle

Take

\[
                        \mathcal S_0=\mathbf P^1_k(2,3,62)
\]

and write \(\pi:\mathcal S_0\to\mathbf P^1\) for the coarse map.  If
\(\mathcal D_2,\mathcal D_3,\mathcal D_{62}\) are the root divisors and
\(H\) is the pullback of a point, then

\[
 \Theta_{\mathcal S_0}
   =\mathcal O\!\left(2H-\mathcal D_2-2\mathcal D_3
                                -61\mathcal D_{62}\right).
\]

Using \(2\mathcal D_2=3\mathcal D_3=62\mathcal D_{62}=H\), one obtains

\[
 F^*\Theta_{\mathcal S_0^{(1)}}
   =\mathcal O\!\left(-2H+\mathcal D_2+2\mathcal D_3
                                  +5\mathcal D_{62}\right).          \tag{37.22a}
\]

Consequently

\[
 \pi_*F^*\Theta_{\mathcal S_0^{(1)}}=\mathcal O_{\mathbf P^1}(-2),
 \qquad
 h^1(\mathcal S_0,F^*\Theta_{\mathcal S_0^{(1)}})=1.                \tag{37.22b}
\]

The class represented by \(\chi(t)\) is nonzero, hence generates this
one-dimensional space.  Indeed, the dual six-differential is

\[
                 \eta_0=\frac{(dt)^6}{t^3(t-1)^4},
\]

and their product has residue

\[
 \operatorname{res}_{t=1}
   \frac{\chi(t)\,dt}{t^3(t-1)^4}=-2\ne0.                            \tag{37.22c}
\]

Thus \(E(q)\) below is the pullback of a distinguished generator, rather
than an arbitrary class on the source.

Now let \(q:C\to\mathcal S_0\) have degree \(186N\).  Use the notation

\[
 q^*(0)=2A_2,\qquad q^*(1)=3A_3,
       \qquad q^*(\infty)=62A_{62}.                                    \tag{37.22}
\]

Let \(R_q\) be the reduced inverse image of the two roots of
\(t^2-t+1\).  A direct local calculation gives

\[
     \operatorname{div}(\epsilon_q)
        =R_q+67A_{62}-3A_2-7A_3.                                      \tag{37.23}
\]

Indeed, at a point where \(q\) has local degree \(e\), the denominator in
(37.2) has order \(5(e-1)\).  The numerator has order \(e\) above zero or
one, and order \(-4e\) above infinity.  Substitution of
\(e=2,3,62\) gives respectively \(-3,-7,67\).  The remaining two simple
zero fibers give \(R_q\).  The degree check is

\[
 372N+67(3N)-3(93N)-7(62N)=-140N
       =\deg(F^*\Theta_C).                                             \tag{37.24}
\]

Formula (37.23) turns (37.16) into a finite residue computation.  For
\(\eta\in H^0(C,\omega_C^6)\), Serre duality gives, up to the fixed Cech
orientation,

\[
 \langle E(q),\eta\rangle
       =\sum_{P\in A_3}\operatorname{res}_P(\epsilon_q\eta)
       =-\sum_{P\in A_2}\operatorname{res}_P(\epsilon_q\eta).          \tag{37.25}
\]

There are no other poles.  Since \(g(C)=14N+1\),

\[
                         h^0(C,\omega_C^6)=154N.                        \tag{37.26}
\]

Hence an exact algorithm for deciding the first obstruction is:

1. compute a basis \(\eta_1,\ldots,\eta_{154N}\) of
   \(H^0(C,\omega_C^6)\);
2. compute the residue vector (37.25) for \(q\) and for \(r\);
3. compare the two vectors.

They agree if and only if \(\delta_1(q,r)=0\).  This test uses only finite
linear algebra and local expansions in the function field of \(C\).

The pole orders in (37.23) separately remember the fibers of local degree
two and three; the degree-sixty-two fiber contributes a large zero.  This
is more information than the logarithmic form of file 36, which initially
groups the degree-three and degree-sixty-two fibers together modulo five.
However, equality in (37.19) is a global Mittag--Leffler condition, so the
pole description alone does not force equality of those divisors.

There is nevertheless no pointwise escape.  If the rational sections
\(\epsilon_q\) and \(\epsilon_r\) are equal, their divisors identify in
turn the coefficient \(-3\), \(-7\), and \(67\) loci in (37.23).  Thus
\(A'_2=A_2\), \(A'_3=A_3\), and \(A'_{62}=A_{62}\), and the zero, one, and
pole fibers force \(r=q\).  Consequently, for \(r\ne q\),

\[
                         \epsilon_r-\epsilon_q\ne0.                   \tag{37.26a}
\]

Every nonzero rational section of the degree-\(-140N\) line bundle
\(F^*\Theta_C\) has total pole degree at least \(140N\).  Hence a vanishing
first Witt obstruction for two distinct triangle maps could occur only by
a genuinely global Cech coboundary with at least this much pole data; it
can never come from pointwise cancellation of the two Frobenius
discrepancies.

## 4. Why the class does not force a fifth-power ratio

The following example rules out such an implication for bare tame
three-point covers, even in the same genus as the cyclic atlas.

### Proposition 37.27 (simultaneous Witt lifting without a fifth-power ratio)

Let

\[
                  \mathcal S=\mathbf P^1_k(31,31,31)
\]

and let \(q:Y\to\mathcal S\) be the cyclic atlas whose coarse equation is

\[
                         Y:\ y^{31}=q(q-1).                             \tag{37.27}
\]

Put \(r=1/q\).  Then \(Y\) has genus fifteen, the two maps have the same
tame three-point profile, and

\[
                         \delta_1(q,r)=0,                               \tag{37.28}
\]

indeed the two legs lift on one source through every Witt level.  But

\[
                         \frac{dr}{dq}=-q^{-2}\notin k(Y)^5.            \tag{37.29}
\]

#### Proof

The target automorphism \(t\mapsto1/t\) preserves the three equal root
orders and lifts over \(W(k)\).  Compose it with the unique lifted cover
\(\widetilde Y_q\to\widetilde{\mathcal S}\).  This puts lifted versions of
\(q\) and \(r\) on the same marked source at every level, proving
(37.28).

At the point above \(q=0\), the valuation of \(-q^{-2}\) is \(-62\),
which is not divisible by five.  Every fifth power has all valuations
divisible by five, proving (37.29). \(\square\)

The example uses a visible symmetry of the equal-weight triangle, which is
unavailable for \(\mathcal S_0=(2,3,62)\).  It nevertheless proves that
neither vanishing of the first Witt class nor simultaneous lifting itself
has a formal implication

\[
                  \delta_1(q,r)=0\quad\Longrightarrow\quad
                         dr/dq\in k(C)^5.                               \tag{37.30}
\]

For the actual order-seven reduction, the new exact target is instead
(37.19), or equivalently the invariance condition (37.21).  Combining that
cohomological condition with the asymmetric pole data (37.23) is the
remaining possible bridge to the stronger divisorial rigidity theorem in
file 36.

Order seven by itself does not repair the failed implication.  For
example, take \(C=\mathbf P^1_z\), a primitive seventh root \(\zeta\),

\[
        \alpha(z)=\zeta z,\qquad q=4z(1-z),
             \qquad r=q\circ\alpha.
\]

These are tame Belyi maps (equivalently, scheme-etale maps to the root
stack with order two at \(1\) and \(\infty\)) and lift together with
\(\alpha\) over \(W(k)\), while

\[
             \frac{dr}{dq}
                =\zeta\frac{1-2\zeta z}{1-2z}
\]

has a simple pole and is not a fifth power.  This example has genus zero
and the order-seven action is not free.  It shows that the genuinely
relevant extra inputs in files 29 and 36 are precisely the free action and
the asymmetric \((2,3,62)\) profile, not the numerical order of the
automorphism alone.
