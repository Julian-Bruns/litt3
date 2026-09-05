# The Cartier bundle on the `(31,31,31)` orbifold

**Status:** proved-text.  This note computes the Cartier bundle on

\[
                 S=\mathbf P^1_k(31,31,31),
                 \qquad k=\overline{\mathbf F}_5,
\]

and its coarse base-change lattice for a representable finite etale leg.
It also proves that the orbifold pullback identifications and the elementary
divisors of their coarse shadows do not select degree `35` or the profile-4
boundary.  The full coarse transition retains substantially more information;
Section 6 describes exactly what is and is not canonical about it.

The scheme case, including the exact Frobenius twists, is proved in
[file 22](22_CARTIER_BUNDLE_ETALE_FUNCTORIALITY_AND_LIMITS.md).

## 1. Cartier bundles and tame coarse spaces

Let `A` be a smooth proper tame Deligne--Mumford curve over `k`.  Since all
stabilizer orders below are prime to `5`, its relative Frobenius

\[
                     F_A:A\longrightarrow A^{(1)}
\]

is finite flat and induces an automorphism on every stabilizer.  Define

\[
 0\longrightarrow\mathcal O_{A^{(1)}}
 \longrightarrow F_{A,*}\mathcal O_A
 \longrightarrow B_A^1\longrightarrow0.                  \tag{23.1}
\]

The proof of etale base change in file 22 works etale-locally on tame stack
charts and gives, for a representable finite etale map `a:A' -> A`,

\[
                       B_{A'}^1\simeq(a^{(1)})^*B_A^1.      \tag{23.2}
\]

Let `q:A -> C` be the coarse-space map, with `C` smooth.  Tameness makes
`q_*` exact and gives `q_*O_A=O_C`.  Since
`q^(1) F_A=F_C q`, pushing (23.1) down gives the exact sequence

\[
 0\longrightarrow\mathcal O_{C^{(1)}}
 \longrightarrow F_{C,*}\mathcal O_C
 \longrightarrow q^{(1)}_*B_A^1\longrightarrow0.
\]

Consequently there is a canonical isomorphism

\[
                         q^{(1)}_*B_A^1\simeq B_C^1.       \tag{23.3}
\]

This observation will let us distinguish the genuine orbifold bundle from
its coarse underlying bundle.

## 2. The bundle on `S`

Write `pi:S -> P^1` for the coarse map.

### Proposition 23.4 (coarse splitting and inertia weights)

The following hold.

1. The coarse underlying bundle is

   \[
       \pi^{(1)}_*B_S^1\simeq B_{\mathbf P^1}^1
       \simeq\mathcal O_{\mathbf P^1}(-1)^{\oplus4}.       \tag{23.4}
   \]
2. At each of the three stack points, choose a root-chart parameter `t`
   and a stabilizer generator `zeta` whose geometric action is
   `t |-> zeta t`.  Use the convention that the induced action on local
   functions is `a(t) |-> a(zeta^(-1)t)`.  The four characters on the fiber
   of `B_S^1` are

   \[
                            6,12,18,24\pmod {31}.           \tag{23.5}
   \]
3. The orbifold bundle `B_S^1` is stable and does not split as a sum of
   orbifold line bundles.  It has

   \[
       \operatorname{rk}B_S^1=4,
       \quad \deg_S B_S^1=\frac{56}{31},
       \quad \det B_S^1\simeq\omega_{S^{(1)}}^{\otimes2}.  \tag{23.6}
   \]

### Proof

The first isomorphism in (23.4) is (23.3).  On `P^1`, the bundle `B^1` has
rank four and Euler characteristic zero.  Its two cohomology groups vanish:
this follows immediately from (23.1), because `H^0(O) -> H^0(O)` is an
isomorphism and `H^1(P^1,O)=0`.  If
`B_{P^1}^1=directsum_j O(a_j)`, the simultaneous vanishing of `H^0` and
`H^1` forces every `a_j=-1`.  This proves (23.4).

For (23.5), work on the formal root chart
`[Spec k[[t]]/mu_31]`.  Before taking the cokernel in (23.1), the local
Frobenius pushforward has basis

\[
                              1,t,t^2,t^3,t^4.
\]

The first vector is the unit and the remaining four give the fiber of
`B_S^1`.  Relative Frobenius sends a source stabilizer element `lambda` to
`lambda^5` on the target.  Since `5^(-1)=25 mod 31`, a target element
`zeta` acts on `t^j` through the source element `zeta^25`, and hence with
character

\[
                       -25j\pmod {31},\qquad1\le j\le4.
\]

These are exactly `6,12,18,24`.

The cyclic atlas `Y -> S`, where `Y:y^31=x(x-1)`, is finite etale of degree
`31`.  By (23.2), its pullback is `B_Y^1`, which is stable because `Y` has
genus `15`.  A destabilizing orbifold subbundle of `B_S^1` would pull back
to one of `B_Y^1`; thus `B_S^1` is stable.  In particular it cannot split
into orbifold line bundles.  Pullback to `Y`, together with
`deg B_Y^1=4(15-1)=56`, gives the orbifold degree in (23.6).  The perfect
Cartier pairing gives the determinant formula, just as in Proposition 2 of
file 22. \(\square\)

Thus (23.4) is a coarse splitting only.  The three weighted flags with
weights (23.5), including their global relative position, are essential;
the orbifold bundle itself is indecomposable.

### Proposition 23.7 (Cartier filtration)

There is a canonical Harder--Narasimhan filtration

\[
 0=I^5\subset I^4\subset I^3\subset I^2\subset I
       \simeq F_S^*B_S^1                                  \tag{23.7}
\]

with

\[
                         I^j/I^{j+1}\simeq\omega_S^{\otimes j},
                         \qquad1\le j\le4.                 \tag{23.8}
\]

Its quotient degrees are

\[
                         \frac{28}{31},\frac{56}{31},
                         \frac{84}{31},\frac{112}{31}.     \tag{23.9}
\]

### Proof

The diagonal-ideal proof of file 22 is equivariant on every tame stack
chart and therefore descends to `S`; it gives (23.7)--(23.8).  Since

\[
                    \deg\omega_S=-2+3\left(1-\frac1{31}\right)
                    =\frac{28}{31},
\]

the quotient degrees are (23.9), and their strict ordering makes this the
HN filtration.  As a local consistency check, Frobenius pullback multiplies
the weights (23.5) by `5`, giving `30,29,28,27`, which are the characters
`-1,-2,-3,-4` of the four powers of the cotangent line in (23.8).
\(\square\)

## 3. The coarse shadow of one etale leg

Let `u:T -> S` be representable finite etale.  Let `C` be the smooth coarse
curve of `T` and

\[
                         x:C\longrightarrow\mathbf P^1
\]

the coarse map.  In the profile range, its local coarse ramification index
is either `1` or `31`.  Combining (23.2) and (23.3), or directly using
Frobenius base change for `x`, gives a canonical generically invertible map

\[
             \beta_x:(x^{(1)})^*B_{\mathbf P^1}^1
                      \longrightarrow B_C^1.              \tag{23.10}
\]

It is important that (23.10) need not be an isomorphism: `x` is ramified as
a map of coarse curves even though `u` is etale as a map of orbifolds.

### Lemma 23.11 (local elementary divisors)

Suppose formally that `x` is `s=t^e`, with `(e,5)=1`.  Write

\[
                         ej=5q_j+r_j,
                         \quad1\le r_j\le4,
                         \quad1\le j\le4.                  \tag{23.11}
\]

In the natural Frobenius bases, (23.10) sends

\[
                           s^j\longmapsto t^{ej}
                           =(t^5)^{q_j}t^{r_j}.             \tag{23.12}
\]

It is therefore injective, with elementary divisors `q_1,...,q_4`.
For `e=31` they are

\[
                              6,12,18,24,                  \tag{23.13}
\]

and the local cokernel has length `60`.  For `e=1`, (23.10) is an
isomorphism.

### Proof

On the target of relative Frobenius, use the parameters `s^5` and `t^5`.
The source Cartier bundle has basis given by the classes of
`s,s^2,s^3,s^4`, and the target has the analogous `t`-basis.  Formula
(23.12) is the natural base-change map.  Since multiplication by `e`
permutes the nonzero residues modulo `5`, the target basis vectors
`t^{r_j}` are a permutation of `t,t^2,t^3,t^4`; this proves injectivity and
the elementary-divisor assertion.  For `e=31`, one has `31j=5(6j)+j`,
which gives (23.13) and length `6+12+18+24=60`. \(\square\)

More generally,

\[
 \sum_{j=1}^{4}\left\lfloor\frac{ej}{5}\right\rfloor
                         =\frac{(e-1)(5-1)}2,              \tag{23.14}
\]

the usual permutation-of-residues identity.

## 4. Why two legs do not force profile 4

Now let

\[
                          u,v:T\longrightarrow S           \tag{23.15}
\]

be a self-correspondence, with coarse maps `x,r:C -> P^1`.

On the orbifold itself, etale functoriality gives

\[
 (u^{(1)})^*B_S^1\xrightarrow{\sim}B_T^1
 \xleftarrow{\sim}(v^{(1)})^*B_S^1.                       \tag{23.16}
\]

These are not two transverse subbundles of `B_T^1`: both arrows are
everywhere isomorphisms to the same intrinsic Cartier bundle.  The
diagonal-ideal filtration (23.7) is functorial for etale maps, so both
arrows also carry the pulled-back filtration to the same intrinsic
filtration of `F_T^*B_T^1`.  Their relative-position divisor is zero.

At a stacky point of `T`, the four inertia characters are distinct.  Hence
their four eigenspaces are intrinsic, and both arrows in (23.16) identify
the target weight flag with that same eigenspace flag.  In particular the
local inertia flag and its relative position cannot detect which of the
three stack points of `S` is the image of that point of `T`.  Thus this
relative-position datum cannot recover the `3 by 3` incidence matrix in
Task 01.

After forgetting the orbifold structure, there really are two lattices:

\[
 (x^{(1)})^*\mathcal O(-1)^{\oplus4}
   \xrightarrow{\ \beta_x\ } B_C^1,
 \qquad
 (r^{(1)})^*\mathcal O(-1)^{\oplus4}
   \xrightarrow{\ \beta_r\ } B_C^1.                      \tag{23.17}
\]

Lemma 23.11 proves exactly what these lattices see.  Their cokernels are
supported at the ordinary points having coarse ramification index `31`,
with local elementary divisors `(6,12,18,24)`.  At every residual stacky
point appearing with coarse multiplicity one, both maps are locally
unramified and (23.10) is an isomorphism.  Thus (23.17) sees the three high
ramification points of each leg, while its degeneracy divisor and local
elementary-divisor data are blind to the residual divisors `E_i,F_j` whose
common degree is the parameter `m`.  The full generically invertible map
can of course retain more information than its relative-position divisor;
no claim to the contrary is made here.

For completeness, suppose `31<=d<62` and each leg has three index-`31`
points, as in the generalized profile stratum.  The total cokernel length in
(23.17) is always

\[
                            3\cdot60=180.                  \tag{23.18}
\]

Since

\[
 \deg B_C^1=4(g(C)-1),
 \qquad
 \deg (x^{(1)})^*B_{\mathbf P^1}^1=-4d,
\]

equality of degrees in (23.17) gives only

\[
                  4(g(C)-1+d)=180,
                  \qquad\text{or}\qquad g(C)=46-d.        \tag{23.19}
\]

Writing `d=31+m`, this is precisely `g(C)=15-m`, valid for every
`1<=m<=15`.  No step singles out `m=4`.

## 5. Conclusion

The characteristic-five Cartier bundle explains a genuine occurrence of
four: it has rank four and its coarse ramification modification has four
elementary divisors.  For ramification index `31`, however, those divisors
are `(6,12,18,24)` and have total length `60`, not `4`.  On the orbifold
level the two canonical pullback identifications have zero relative
position; on the coarse level their only nonzero relative position is
supported at the high index-`31` points and is independent of the residual
degree `m`.

Consequently the equality `35=31+(5-1)` is numerology for the proposed
relative-position-divisor construction: the canonical identifications and
the Cartier filtration neither force degree `35` nor select the profile-4
boundary or incidence matrix.  A refinement could still use the full
base-change maps or additional data not present here, but it would have to
couple the Cartier bundle to the actual functions `x,r` in a way that
detects their unramified residual fibers; the degeneracy data computed here
does not do so.

## 6. The full transition: a canonical `PGL_4`-valued function

The full transition has less gauge freedom than an arbitrary map between
two rank-four bundles.  Put

\[
 E=B_{\mathbf P^1}^1,
 \qquad
 V=H^0\bigl((\mathbf P^1)^{(1)},E(1)\bigr).
\]

By (23.4), `E(1)` is trivial of rank four.  Its evaluation map is therefore
a canonical isomorphism

\[
                  V\otimes\mathcal O\xrightarrow{\sim}E(1),
 \qquad
                  E\simeq V\otimes\mathcal O(-1).         \tag{23.20}
\]

Write

\[
 \ell_x=(x^{(1)})^*\mathcal O(-1),\quad
 \ell_r=(r^{(1)})^*\mathcal O(-1),\quad
 L_x=V\otimes\ell_x,\quad L_r=V\otimes\ell_r.
\]

Over the function field `K=k(C^(1))`, both base-change maps are
isomorphisms, so they give

\[
 M_{x,r}=\beta_r^{-1}\beta_x:L_x\dashrightarrow L_r.
                                                               \tag{23.21}
\]

Equivalently, `M_(x,r)` is an invertible element of

\[
 (\ell_x^{-1}\ell_r)_K\otimes_K\operatorname{End}_K(V_K).
\]

Projectivizing removes the one-dimensional line factor and gives a
canonical rational function

\[
             \Phi_{x,r}\in\operatorname{PGL}(V)(K).       \tag{23.22}
\]

This corrects a tempting but false gauge argument.  After choosing rational
generators of the two line bundles and a basis of the *common* vector space
`V`, the displayed matrix changes as

\[
                          M\longmapsto cA^{-1}MA,          \tag{23.23}
\]

where `c in K^*` and the same `A` is used on both sides.  Independent
left--right changes would forget the canonical common factor `V` in
(23.20), and are not allowed.  Thus `Phi_(x,r)` itself is intrinsic; its
matrix conjugacy class is basis-independent.  Scalar-homogeneous
conjugacy functions, for example
`e_i(M)^4/det(M)^i`, are genuine rational functions on `C^(1)` wherever
defined.

The construction is exactly compatible with refinement.  More generally,
let `a:C' -> C` be a finite separable map, for example the coarse map of a
representable finite etale refinement of `T`.  Frobenius base change gives
a generically invertible map

\[
             \gamma_a:(a^{(1)})^*B_C^1\longrightarrow B_{C'}^1.
\]

Functoriality of the base-change maps gives, at the generic point,

\[
 \beta_{x\circ a}=\gamma_a\,(a^{(1)})^*\beta_x,
 \qquad
 \beta_{r\circ a}=\gamma_a\,(a^{(1)})^*\beta_r.
\]

The common left factor cancels in the transition, and hence

\[
 \Phi_{x\circ a,r\circ a}=(a^{(1)})^*\Phi_{x,r}.          \tag{23.24}
\]

In particular, constancy or nonconstancy of `Phi`, and of any conjugacy
function of it, survives every finite etale refinement.  If
`r=sigma circ x` for an automorphism `sigma` of `P^1`, Cartier functoriality
and (23.20) give a projective representation

\[
 \rho:\operatorname{Aut}(\mathbf P^1)\longrightarrow
      \operatorname{PGL}(V)
\]

and `Phi_(x,r)=rho(sigma)^(-1)`, up to the convention in (23.21).  Hence a
nonconstant `Phi` is a valid obstruction to a correspondence becoming
visible in this sense on an etale refinement.  No converse is asserted.
Also, `Phi=1` whenever `x=r`, regardless of the degree, so `Phi` alone
cannot force degree `35`.

### What the full function remembers

The generic description shows why the new invariant is not automatically a
simplification of the correspondence.  Let `L=k(C)` and identify
`K=L^5=k(C^(1))`.  Since `r` is separating,

\[
                         L=K\oplus Kr\oplus\cdots\oplus Kr^4.
                                                               \tag{23.25}
\]

In the affine power bases, the `j`-th column of `M_(x,r)` is precisely the
coefficient vector of `x^j` modulo `K` in the basis
`r,r^2,r^3,r^4`.  Thus it is the change between the two power bases of the
purely inseparable extension `L/K`.

For fixed `r`, the projective matrix even determines `x`.  Indeed, if
`M_(x',r)=lambda M_(x,r)` for `lambda in K^*`, comparison of first columns
gives `x'=lambda x+a` with `a in K`.  Comparison of second columns then
gives in `L/K`

\[
             (\lambda^2-\lambda)[x^2]+2\lambda a[x]=0.
\]

Because `1,x,...,x^4` is a `K`-basis and `2` is nonzero, this forces
`lambda=1` and `a=0`.  The full `Phi`, together with either leg, therefore
repackages essentially the original pair of functions.  Passing only to
its conjugacy class loses information: if `x=ar+b` with constants `a,b`
and `a,a^2,a^3,a^4` distinct, its triangular matrix is conjugate to
`diag(a,a^2,a^3,a^4)` and hence forgets `b`.

### Relation with the lattice data

The ordered pair of lattices

\[
                         (\beta_x(L_x),\beta_r(L_r))
                         \quad\text{inside }B_C^1          \tag{23.26}
\]

is also intrinsic.  Let `H_x,H_r` denote the reduced divisors on `C^(1)`
formed by the three high index-`31` points of the respective legs.  Lemma
23.11 gives

\[
 \operatorname{div}(\det\beta_x)=60H_x,
 \qquad
 \operatorname{div}(\det\beta_r)=60H_r,
 \qquad
 \operatorname{div}(\det M_{x,r})=60(H_x-H_r).            \tag{23.27}
\]

The last determinant is that of the original line-valued map (23.21), not
of its projectivization: rescaling a matrix changes its determinant by a
fourth power.  At a single high point the orders of
`Fitt_0,Fitt_1,Fitt_2,Fitt_3` of the cokernel are respectively
`60,36,18,6`.  If a point is high for both legs, determinant orders cancel
but the relative Smith coweight may still be nonzero and can depend on the
relative flags.  Away from `H_x union H_r`, the relative lattice position
is zero.

Nevertheless the regular value of `Phi` at a residual stacky point need
not be trivial.  Under (23.20), the parabolic structure of `B_S^1` gives
three weighted flags `F_0,F_1,F_infinity` in `V`.  At a residual point `P`,
the two unramified base-change maps identify their corresponding flags with
the same intrinsic inertia flag on `T`; consequently

\[
                    \Phi_{x,r}(P)(F_{x(P)})=F_{r(P)}.     \tag{23.28}
\]

Thus the full transition can encode residual incidence even though all of
its local lattice invariants there vanish.  The rigorous outcome is
therefore mixed: a canonical, refinement-compatible `PGL_4`-valued
transition does exist, but its full value is essentially the original
function-field relation, while its simpler determinant and Fitting data do
not see `m`.  Nothing extracted here from its conjugacy class forces
`m=4` or degree `35`.
