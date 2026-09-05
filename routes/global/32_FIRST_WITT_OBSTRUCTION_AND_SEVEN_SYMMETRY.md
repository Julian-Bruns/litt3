# The first Witt obstruction and the order-seven reduction

## Status and purpose

**Status: proved.**  This note identifies the first obstruction to lifting
two tame covering structures on the same characteristic-five curve to one
common source over \(W_2(k)\).  It also computes the exact representation
space in which the obstruction forced by Corollary 29.4 must lie.

This is a structural reduction, not yet an exclusion theorem.  It explains
both occurrences of the number \(42\):

- every generalized profile of degree below \(62\) has a
  \(42\)-dimensional first-order deformation space; and
- a scheme cover of \(Y\) of degree \(N\) has a
  \(42N\)-dimensional deformation space.

For a free order-seven symmetry, the possible nonzero obstruction is
confined to a \(36N\)-dimensional moving summand.

Throughout, \(k=\overline{\mathbf F}_5\), and \(W_2(k)\) denotes the ring of
length-two Witt vectors.

## 1. Marked liftings of a tame stacky curve

Let \(\mathcal T\) be a smooth proper connected tame Deligne--Mumford curve
with trivial generic stabilizer.  A marked \(W_2(k)\)-lifting means a flat
smooth stack \(\widetilde{\mathcal T}/W_2(k)\), together with an
identification of its special fiber with \(\mathcal T\).

### Proposition 32.1 (the deformation torsor)

Suppose \(\mathcal T\) is hyperbolic.  Its marked \(W_2(k)\)-liftings form a
nonempty torsor under

\[
                         H^1(\mathcal T,\Theta_{\mathcal T}).       \tag{32.1}
\]

There are no obstructions in degree two and no infinitesimal
automorphisms.

#### Proof

The standard square-zero deformation calculation for a smooth stack gives
automorphisms, deformations, and obstructions in

\[
 H^0(\Theta_{\mathcal T}),\qquad
 H^1(\Theta_{\mathcal T}),\qquad
 H^2(\Theta_{\mathcal T}),
\]

respectively.  The last group vanishes because \(\mathcal T\) is a curve.
Hyperbolicity gives \(H^0(\Theta_{\mathcal T})=0\).  Thus liftings exist,
their marked isomorphism classes form the torsor (32.1), and marked
isomorphisms are unique.  Strictly, the deformation group is tensored with
the square-zero ideal \(pW_2(k)\).  Since \(k\) is perfect, the rule
\(p[a]\mapsto a\) canonically identifies this ideal with the
one-dimensional \(k\)-module used in (32.1). \(\square\)

Let \(C\) be the coarse curve and let \(U\subset C\) be the reduced divisor
under the stacky locus.

### Lemma 32.2 (coarse description and dimension)

There is a canonical equality

\[
 H^1(\mathcal T,\Theta_{\mathcal T})
       \simeq H^1(C,\Theta_C(-U)).                         \tag{32.2}
\]

If \(g=g(C)\) and \(\tau=\deg U\), then

\[
             \dim H^1(\mathcal T,\Theta_{\mathcal T})
                         =3g-3+\tau.                       \tag{32.3}
\]

#### Proof

At a root point of order \(n\), use a chart
\([\operatorname{Spec}k[[z]]/\mu_n]\) with coarse parameter \(t=z^n\).
An invariant vector field has the form

\[
                       z\,a(z^n)\frac{\partial}{\partial z}.
\]

Since \(n\) is invertible in \(k\), its coarse image is a unit multiple of
\(t\,a(t)\partial/\partial t\).  Thus the coarse pushforward of
\(\Theta_{\mathcal T}\) is \(\Theta_C(-U)\).  Tameness makes coarse
pushforward exact, which proves (32.2).

The line bundle \(\Theta_C(-U)\) has degree \(2-2g-\tau<0\), so it has no
global sections.  Riemann--Roch now gives (32.3). \(\square\)

For the generalized profile with parameter \(m\), file 16 gives

\[
                        g=15-m,\qquad \tau=3m.
\]

Consequently every row has

\[
                         3g-3+\tau=42.                    \tag{32.4}
\]

For a scheme cover \(W\to Y\) of degree \(N\), Proposition 29.2 gives
\(g(W)=14N+1\), and hence

\[
                         h^1(W,\Theta_W)=42N.             \tag{32.5}
\]

## 2. The difference of the two canonical source liftings

Fix a smooth \(W_2(k)\)-lifting \(\widetilde{\mathcal S}\) of a tame target
\(\mathcal S\).  If

\[
                         u:\mathcal T\longrightarrow\mathcal S
\]

is finite etale, invariance of the finite-etale site under nilpotent
thickenings gives a unique finite-etale lifting

\[
                 \widetilde u:\widetilde{\mathcal T}_u
                                      \longrightarrow\widetilde{\mathcal S}.
\]

Here uniqueness is in the category of covers of
\(\widetilde{\mathcal S}\); the marking of the source special fiber is
retained.

### Definition 32.3 (first simultaneous-lifting class)

For two finite-etale legs

\[
                    u,v:\mathcal T\rightrightarrows\mathcal S,
\]

let

\[
 \delta_1(u,v)\in H^1(\mathcal T,\Theta_{\mathcal T})       \tag{32.6}
\]

be the ordered torsor difference
\([\widetilde{\mathcal T}_v]-[\widetilde{\mathcal T}_u]\) between the two
marked source liftings.

### Proposition 32.4 (exact first-order criterion)

The two legs admit finite-etale liftings to the same marked
\(W_2(k)\)-lifting of \(\mathcal T\) if and only if

\[
                              \delta_1(u,v)=0.             \tag{32.7}
\]

#### Proof

If a common marked source lifting exists, uniqueness of lifting a finite
etale cover over \(\widetilde{\mathcal S}\) identifies it with both
\(\widetilde{\mathcal T}_u\) and
\(\widetilde{\mathcal T}_v\), so their difference is zero.

Conversely, vanishing of the difference gives a unique marked isomorphism
between the two source liftings.  Transporting one lifted leg across this
isomorphism puts both lifted maps on the other source. \(\square\)

Vanishing at the first Witt level is only the first condition.  Analogous
classes occur at higher Witt levels; simultaneous lifting to
characteristic zero requires all of them to vanish.

## 3. Automorphism-induced correspondences

Let \(u:\mathcal T\to\mathcal S\) be finite etale, and let a finite group
\(G\) act on \(\mathcal T\).  Changing the marking gives an affine action,
written \(\alpha\mathbin\cdot\xi\), on the deformation torsor.  Write

\[
 \rho:G\longrightarrow
 \operatorname{GL}\!\left(H^1(\mathcal T,\Theta_{\mathcal T})\right)
\]

for its linear part.  To avoid the inverse ambiguity inherent in pullback
notation, use the convention that \(\alpha\mathbin\cdot\xi_u\) is the marked
source class selected by
\(u\circ\alpha^{-1}\).  Here \(\xi_u\) is the torsor point selected by
\(u\).  Put

\[
 c_u(\alpha):=\delta_1(u,u\circ\alpha^{-1})
              =\alpha\mathbin\cdot\xi_u-\xi_u.           \tag{32.8}
\]

Thus \(\delta_1(u,u\circ\alpha)=c_u(\alpha^{-1})\).  Inversion does not
alter the invariant or moving subspaces.

### Proposition 32.5 (cocycle and coprime-order constraint)

The classes \(c_u(g)\) satisfy

\[
                  c_u(gh)=c_u(g)+\rho(g)c_u(h).           \tag{32.9}
\]

If \(|G|\) is prime to \(5\), then

\[
 H^1\!\left(G,H^1(\mathcal T,\Theta_{\mathcal T})\right)=0, \tag{32.10}
\]

and the deformation space decomposes as

\[
 H^1(\mathcal T,\Theta_{\mathcal T})
   =H^1(\mathcal T,\Theta_{\mathcal T})^G
      \oplus
     \left\langle(g-1)H^1(\mathcal T,\Theta_{\mathcal T}):g\in G\right\rangle.
                                                               \tag{32.11}
\]

Every \(c_u(g)\) lies in the moving part.  For a cyclic generator
\(\alpha\) of order \(\ell\ne5\), it satisfies

\[
       (1+\rho(\alpha)+\cdots+\rho(\alpha)^{\ell-1})
                         c_u(\alpha)=0.                    \tag{32.12}
\]

#### Proof

Equation (32.9) follows by expanding
\((gh)\mathbin\cdot\xi_u-\xi_u\).  Since \(|G|\) is invertible in \(k\), averaging
is an exact projector onto invariants.  This proves (32.10)--(32.11).
More precisely, (32.10) says that the affine \(G\)-action on the deformation
torsor has a fixed point \(\xi_0\).  Writing \(\xi_u=\xi_0+w\), one gets

\[
                         c_u(g)=\rho(g)w-w,
\]

which places every difference in the moving part.  Telescoping gives
(32.12). \(\square\)

The vanishing of group cohomology does not make
\(c_u(\alpha)\) vanish: it says that this cocycle is a coboundary,
which is already visible in (32.8).  Averaging produces some
\(G\)-invariant lifting of the abstract source, but that lifting need not
be the particular one selected by the covering map \(u\).

## 4. Exact dimensions for a free order-seven action

### Proposition 32.6 (the \(6N+36N\) decomposition)

Let \(W\) be a smooth projective curve of genus \(14N+1\), and let
\(\alpha\) act freely with order \(7\).  Put \(C=W/\langle\alpha\rangle\).
Then

\[
                       g(C)=2N+1,                          \tag{32.13}
\]

and

\[
\begin{aligned}
 \dim H^1(W,\Theta_W)&=42N,\\
 \dim H^1(W,\Theta_W)^{\langle\alpha\rangle}&=6N,\\
 \dim H^1(W,\Theta_W)_{\mathrm{moving}}&=36N.              \tag{32.14}
\end{aligned}
\]

For the exceptional order-seven symmetry forced by Corollary 29.4, its
first simultaneous-lifting class belongs to the last summand.  To see that
the proposition applies, put \(d=\deg(V/S_0)\).  Since \(V\) is a scheme and
the map is representable etale, the fibers above the stacky points force
\(2,3,62\mid d\), hence \(186\mid d\).  Now
\(\deg\omega_{S_0}=14/93\), so, on writing \(d=186N\), canonical-degree
pullback gives \(g(V)=14N+1\).

#### Proof

Etale Riemann--Hurwitz gives
\[
                       g(W)-1=7(g(C)-1),
\]
which proves (32.13).  Since the action is tame,
taking invariants is exact.  Etale pullback identifies
\(\Theta_W\) with the pullback of \(\Theta_C\), and projection formula gives

\[
 H^1(W,\Theta_W)^{\langle\alpha\rangle}
       \simeq H^1(C,\Theta_C).
\]

The two dimensions are therefore
\[
                  3g(W)-3=42N,\qquad 3g(C)-3=6N.
\]
Their difference is \(36N\).  The last assertion follows from
Proposition 32.5, since
\(\delta_1(q_V,q_V\circ\beta)=c_{q_V}(\beta^{-1})\). \(\square\)

## 5. Resulting target

Together, files 17, 29, and 32 show that it is enough to establish the
following statement for every exceptional pair supplied by Corollary 29.4.
Fix the standard Witt lift
\(\widetilde S_0=\mathbf P^1_{W(k)}(2,3,62)\).
Let \(q:W\to S_0\) be its finite-etale map and let \(\alpha\) be its
fixed-point-free automorphism of order seven.  The map \(q\) selects a
compatible system of marked Witt liftings.  One must prove that this system
is \(\alpha\)-invariant at every Witt level.  At the first level this means
\(\delta_1(q,q\circ\alpha)=0\) in \(H^1(W,\Theta_W)\).  Indeed,
compatible invariance lifts \(\alpha\) to the resulting formal curve over
\(W(k)\).  Formal GAGA algebraizes the proper curve, its two finite maps,
and this automorphism.  After passing to a characteristic-zero generic
fiber and embedding a field of definition in \(\mathbf C\), the
commensurator calculation in file 17 forces the lifted automorphism to
preserve the map to \(S_0\).  A 2-isomorphism between these two maps is
unique: two such isomorphisms differ by a section of the inertia, and that
section is trivial on the dense inverse image of the nonstacky locus.
Faithfully flat descent therefore brings the complex 2-isomorphism back to
the generic field.  Its Isom space over the lifted source is finite because
the diagonal of \(S_0\) is finite.  The closure of the generic section is
finite and birational over the smooth, hence normal, source, so it is a
section over \(W(k)\).  Reduction now contradicts
\(q\not\simeq q\circ\alpha\).  At the first level the only possible failure
lies in the explicit moving summand of dimension \(36N\).

This formulation explains the finite-Witt obstruction without assuming
that an arbitrary abstract lifting of \(W\) is compatible with \(q\).  The
remaining step must use the special three-point covering structure of
\(q\); coprime averaging alone cannot supply it.
