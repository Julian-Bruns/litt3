# Mochizuki's canonical lifting: the exact finite-cover bridge and its failure on the cyclic atlas

**Status:** proved.  The positive statements below are conditional lifting
lemmas.  The negative statement for the cyclic genus-fifteen curve is
unconditional.  Nothing in this note proves or disproves the existence of a
common finite etale cover of the two curves in the main problem.

## 1. The datum which Mochizuki canonically lifts

Let `k` be a perfect field of odd characteristic `p`, and put `A=W(k)`.  For
an `r`-pointed smooth curve `(C,D)` write

\[
 \mathcal T_C^{\log}=\mathcal T_C(-D),\qquad
 Q(C,D)=H^0(C,\omega_C^{\otimes2}(D)).                    \tag{33.1}
\]

The second equality is the usual identity
`(omega_C^log)^2(-D)=omega_C^2(D)`.  If `P` is a nilpotent
indigenous bundle, its square Hasse invariant induces mutually dual maps

\[
 \Phi_P^\tau:H^1(C,\mathcal T_C^{\log})^{(1)}
       \longrightarrow H^1(C,\mathcal T_C^{\log}),
 \qquad
 \Phi_P^\omega:Q(C,D)\longrightarrow Q(C,D)^{(1)}.       \tag{33.2}
\]

Mochizuki calls `P` **ordinary** when `Phi_P^tau` is an isomorphism;
equivalently, by Chapter II, Proposition 2.12, `Phi_P^omega` is an
isomorphism.

The point parametrized by

\[
                         (C,D;P)                           \tag{33.3}
\]

lies in `N^ord_(g,r)`.  It is (33.3), and not the bare curve `(C,D)`, that
has the unique canonical lift of Chapter III, Theorem 3.2.  This distinction
is explicit in Definition 3.1 and the remark following it: a p-adic
quasiconformal class is a curve **together with a choice** of nilpotent
ordinary indigenous bundle.  Theorem 2.8 constructs the canonical Frobenius
on `N^ord_(g,r)`, not on `M^ord_(g,r)`.

There can be several choices over one curve.  In fact
`N_(g,r) -> M_(g,r)` is finite flat of degree `p^(3g-3+r)`, and Mochizuki
emphasizes in Chapter II, Proposition 3.13 and the following discussion that
there is no canonical choice on a generic curve under the hypotheses of that
proposition.  This does not by itself prove that the underlying curves of two
canonical lifts are different.  It does show that Theorem 3.2 supplies no
bundle-independent identification between them.

## 2. What Theorems 2.8 and 2.10 actually give

The extra hypothesis in Chapter III, Theorem 2.10 is essential.  In that
theorem one has a finite log-etale, marked-point-preserving map

\[
                         \varphi:Y^{\log}\longrightarrow X^{\log}          \tag{33.4}
\]

and the pullback `F=varphi^*E` of the canonical indigenous bundle.  Immediately
before the theorem, Mochizuki assumes

\[
                         F\bmod p\quad\text{is ordinary}.                 \tag{33.5}
\]

Only under (33.5) does the classifying map to `N^ord_(q,s)` exist.  Theorem
2.10 then says that this map commutes with the two canonical Frobenius
liftings and that the canonical bundle upstairs is the pullback of the one
downstairs.  It is not a theorem that (33.5) is preserved by every finite
cover.

Here is the precise pointwise consequence needed for the common-cover
question.

### Theorem 33.6 (one-leg canonical lifting)

Let

\[
                         f_0:Z_0\longrightarrow C_0                       \tag{33.6}
\]

be a finite etale map of smooth projective curves over `k`.  Let `P_0` be a
nilpotent ordinary indigenous bundle on `C_0`, and assume that
`f_0^*P_0` is ordinary on `Z_0`.  Let `(C,P)` be the canonical lift of
`(C_0,P_0)` over `A`.  Then:

1. `f_0` has a unique finite etale lift `f:Z -> C`;
2. `(Z,f^*P)` is the canonical lift of `(Z_0,f_0^*P_0)`.

In particular the generic-fiber map `f_K:Z_K -> C_K` is finite etale in
characteristic zero.

#### Proof

For a proper scheme over a complete noetherian local ring, restriction to
the closed fiber is an equivalence on finite etale covers.  Applied to `C/A`,
this gives the unique cover `f:Z -> C`; this is SGA 1, Expose IX,
Theorem 1.10.  Smoothness of `Z/A` follows from that of `C/A` and etaleness.

The map `f` is log admissible for the trivial log structures, and the
reduction of `f^*P` is ordinary by hypothesis.  Mochizuki, Chapter III,
Corollary 3.5 says in exactly this situation that `(C,P)` is canonical if
and only if `(Z,f^*P)` is canonical.  The former is canonical by construction,
so the latter is the canonical lift of its reduction.  This proves both
claims. \(\square\)

The same proof works for a pointed log-admissible map whenever a
log-admissible lift of that map has been supplied.  The scheme-etale case in
Theorem 33.6 is the case directly relevant to Problem 3 and needs no extra
logarithmic lifting assertion.

### Corollary 33.7 (a sufficient simultaneous-lifting condition)

Suppose that

\[
                 Z_0\xrightarrow{f_0}X_0,\qquad
                 Z_0\xrightarrow{g_0}Y_0                              \tag{33.7}
\]

are finite etale.  Suppose there are nilpotent ordinary indigenous bundles
`P_X` and `P_Y` on `X_0` and `Y_0` such that their pullbacks are ordinary and

\[
                         f_0^*P_X\simeq g_0^*P_Y                       \tag{33.8}
\]

as indigenous bundles on `Z_0`.  Then the canonical lifts of `(X_0,P_X)`
and `(Y_0,P_Y)` have a finite etale cover in common in characteristic zero.

#### Proof

Apply Theorem 33.6 to both legs.  The two resulting lifts of `Z_0` are the
canonical lifts of the same pair in (33.8).  The uniqueness in Chapter III,
Theorem 3.2 identifies those pairs, and hence their underlying curves.  After
this identification, the two lifted maps give the desired common cover on
the generic fiber. \(\square\)

All the data are of finite presentation.  Thus, if desired, the generic-fiber
diagram descends to a finitely generated characteristic-zero field and then
base-changes to a diagram of complex curves.

Condition (33.8) is not a conclusion of Mochizuki's theory.  Without it, the
two legs canonically lift

\[
              (Z_0,f_0^*P_X)\quad\text{and}\quad(Z_0,g_0^*P_Y),          \tag{33.9}
\]

which need not be the same point of `N^ord_(g(Z),0)`.  The uniqueness
theorem applies separately to these two points and gives no identification
of their underlying lifted curves.  Hence Theorem 2.10 does not, by itself,
turn an arbitrary common cover of bare curves into a simultaneous
characteristic-zero common cover.

## 3. Where pullback ordinarity can fail

The obstruction in (33.5) consists of all deformation directions upstairs,
not just those descending to the base.  For example, let `f:Z -> C` be a
finite etale Galois cover with group `G` of order prime to `p`.  The operator
`Phi_(f^*P)^omega` is Frobenius-equivariant for the `G`-action.  The invariant
summand of `Q(Z)` is `Q(C)`, and its operator is `Phi_P^omega`.  Thus
ordinarity of `P` controls only the invariant summand.  Every nontrivial
isotypic summand gives an additional determinant condition.

For a cyclic etale cover arising from an `n`-torsion line bundle `eta`, this
is visible in

\[
 Q(Z)=\bigoplus_{i\in\mathbf Z/n}
 H^0(C,\omega_C^{\otimes2}\otimes\eta^i).                \tag{33.10}
\]

Frobenius permutes these summands by multiplication by `p` (or by `p^(-1)`,
depending on the direction in which (33.2) is written).  The `i=0` block is
the downstairs operator.  No statement about that block forces the other
blocks to be invertible.  Notice that every summand in (33.10) has dimension
`3g(C)-3`; the simple character-dimension test used below is therefore silent
for an unramified cyclic cover.  It is the ramification of the coarse
triangle cover, equivalently its log-etale marked structure, that makes the
next obstruction immediate.

## 4. The natural triangle bundle is not ordinary on `Y`

Work now in characteristic five.  Put

\[
 Y:\ y^{31}=x(x-1),
 \qquad \pi:Y\longrightarrow\mathbf P^1_x,                \tag{33.11}
\]

and let `P_0,P_1,P_infty` be the unique points over `0,1,infinity`.  The
curve has genus `15`.  With the three points marked, (33.11) is a finite
log-etale map to the three-pointed projective line.

The three-pointed line is totally degenerate.  By Mochizuki, Chapter II,
Propositions 3.5 and 3.7, it has a unique nilpotent admissible indigenous
bundle `P_0^tri`, and that bundle is ordinary.  Its pullback to `Y` is
nilpotent and admissible.  Nevertheless it is not ordinary.

We prove a stronger statement, which also treats the unpointed curve.

### Proposition 33.12 (Frobenius-character obstruction)

Let `Gamma=mu_31` act on `Y` by `y |-> zeta y`.

1. No indigenous bundle on the three-pointed curve
   `(Y,P_0+P_1+P_infty)` whose square Hasse invariant is
   `Gamma`-invariant is ordinary.
2. No indigenous bundle on the unpointed curve `Y` whose square Hasse
   invariant is `Gamma`-invariant is ordinary.

Consequently the pullback `pi^*P_0^tri` is not ordinary.  Also, any
nilpotent ordinary indigenous bundle on the unpointed `Y`, if one exists,
must break the `mu_31`-symmetry.

#### Proof

The valuations at the three ramification points are

\[
\begin{array}{c|ccc}
 &P_0&P_1&P_\infty\\ \hline
 x&31&0&-31\\
 x-1&0&31&-31\\
 y&1&1&-2\\
 dx&30&30&-32.
\end{array}                                                \tag{33.12}
\]

Let

\[
             \eta=\pi^*\!\left(\frac{dx}{x(x-1)}\right).
\]

As a meromorphic differential,

\[
             \operatorname{div}(\eta)=-P_0-P_1+30P_\infty.              \tag{33.13}
\]

Thus, as a section of
`omega_Y(P_0+P_1+P_infty)`, its zero divisor is `31P_infty`.  Division by
`eta` identifies the pointed quadratic-differential space with

\[
 Q(Y,P_0+P_1+P_\infty)
       \simeq H^0(Y,\omega_Y(31P_\infty)).                \tag{33.14}
\]

A basis of the right side is

\[
 \frac{x^a dx}{y^j},\qquad
 1\leq j\leq30,
 \quad 0\leq a\leq\left\lfloor\frac{2j-1}{31}\right\rfloor.           \tag{33.15}
\]

Indeed, (33.12) shows regularity at `P_0` and `P_1`, while the condition at
`P_infty` is exactly `31a <= 2j-1`.  A coefficient in `k(x)` can have no
finite pole, again by (33.12), so these vectors exhaust each character
space.  There is no invariant (`j=0`) vector.  The count is
`15+2*15=45`, as required by `3g-3+3`.

The vector indexed by `j` has `Gamma`-character `-j`.  Hence its character
multiplicity is

\[
 m_j^{\rm pt}=
 \begin{cases}
 1,&1\leq j\leq15,\\
 2,&16\leq j\leq30.
 \end{cases}                                               \tag{33.16}
\]

If the square Hasse invariant is `Gamma`-invariant, the construction in
Chapter II, Proposition 2.12 makes `Phi_P^omega` Frobenius-equivariant for
`Gamma`: it is formed from the dual square Hasse invariant and the Cartier
trace, both of which are natural under automorphisms.  Equivalently, after
the usual identification with a Frobenius-semilinear operator, equivariance
is through the relative Frobenius
`F_Gamma:Gamma -> Gamma^(1)`, which multiplies character indices by `5`.
The rule `Car(c alpha)=c^(1/5)Car(alpha)` consequently shows that the
operator carries a character space indexed by `j` to the one indexed by
`5^(-1)j`.  Reversing the convention replaces `5^(-1)` by `5` and gives
the same orbits.  Therefore an isomorphism would force the
multiplicity function to be constant on every orbit of multiplication by
`5` in `(Z/31)^*`.  But

\[
                         1\longmapsto5\longmapsto25\longmapsto1,         \tag{33.17}
\]

whereas `(m_1^pt,m_5^pt,m_25^pt)=(1,1,2)`.  Thus
`Phi_P^omega` cannot be an isomorphism.  By the duality in Proposition 2.12,
`P` is not ordinary.  This proves the pointed assertion.

For the unpointed curve, (33.13) instead gives

\[
 Q(Y)=H^0(Y,\omega_Y^{\otimes2})
 \simeq H^0(Y,\omega_Y(30P_\infty-P_0-P_1)).              \tag{33.18}
\]

A basis is

\[
 \frac{dx}{y^j}\ (1\leq j\leq29),
 \qquad
 \frac{x\,dx}{y^j}\ (17\leq j\leq29).                  \tag{33.19}
\]

The same valuation check proves both inclusion and exhaustiveness, and the
count is `29+13=42=3g-3`.  Thus the multiplicities are

\[
 m_j^{\rm unpt}=
 \begin{cases}
 1,&1\leq j\leq16,\\
 2,&17\leq j\leq29,\\
 0,&j=30.
 \end{cases}                                               \tag{33.20}
\]

The orbit (33.17) again has multiplicities `(1,1,2)`, so the unpointed
operator cannot be invertible either.

Finally, `pi^*P_0^tri` has invariant square Hasse invariant because it is
pulled back from the three-pointed line.  The pointed assertion therefore
shows that it is not ordinary. \(\square\)

The character argument uses only the square Hasse invariant, so no choice
of a linearization of the indigenous bundle is hidden in the proof.  If the
isomorphism class of a bundle is fixed by `Gamma`, its square Hasse invariant
is automatically fixed, and Proposition 33.12 applies.

## 5. Consequences for the proposed lifting strategy

For the proposed pair

\[
 X:\ v^2=x^7-x+1,
 \qquad
 Y:\ y^{31}=x(x-1),                                      \tag{33.21}
\]

the following are separate unresolved requirements:

1. The invertible Cartier--Manin matrix of `X` proves that its Jacobian is
   ordinary.  Mochizuki calls this **parabolic** ordinarity.  His canonical
   lifting theory needs **hyperbolic** ordinarity: an actual nilpotent
   ordinary indigenous bundle.  Chapter II proves that the hyperbolically
   ordinary locus is open dense, but this does not decide the particular
   curve `X` in (33.21).
2. Even after choosing suitable bundles on `X` and `Y`, a hypothetical common
   cover must preserve their ordinarity after both pullbacks.
3. To identify the two canonical lifts of the common covering curve by
   Theorem 3.2, one still needs the compatibility (33.8), or a separate proof
   that the two underlying canonical curves coincide.
4. The most natural attempt to retain the triangle presentation of `Y`
   fails already on `Y` itself: Proposition 33.12 shows that the canonical
   bundle pulled back from the three-pointed line is not ordinary.  Moreover,
   no `mu_31`-invariant ordinary bundle can replace it on unpointed `Y`.

Thus Mochizuki's theory gives a rigorous and useful functor on a restricted
category of **ordinary pairs with ordinary compatible pullback**, but not a
functor from bare curves and all finite etale maps.  The missing hypotheses
are separate unproved inputs, so these theorems do not close the
simultaneous-lifting route.

## 6. A nearby theorem which does not fill the gap

Wakabayashi's theorem on cyclic etale coverings concerns **dormant**
`GL_n`-opers, i.e. opers with zero p-curvature, and uses a different notion
of ordinarity.  Its preservation direction also assumes an abelian
prime-to-`p` cover and a general base curve.  It therefore does not prove
(33.5) for Mochizuki's nilpotent admissible indigenous bundles, for the
explicit curves (33.21), or for the log-ramified triangle atlas.  In
Mochizuki's setting, ordinary implies admissible, so the relevant
p-curvature is nonzero; replacing “nilpotent” by “dormant” changes the
problem.

## Primary references

* S. Mochizuki, *A Theory of Ordinary p-adic Curves*, Publ. RIMS **32**
  (1996), 957--1151.  The relevant results are Chapter II, Proposition 2.12,
  Definition 3.1, Propositions 3.5 and 3.7; and Chapter III, Theorems 2.8,
  2.10, 3.2 and Corollary 3.5:
  <https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Theory%20of%20Ordinary%20p-adic%20Curves.pdf>.
* A. Grothendieck et al., *Revetements etales et groupe fondamental
  (SGA 1)*, Expose IX, Theorem 1.10:
  <https://arxiv.org/abs/math/0206203>.
* Y. Wakabayashi, *Cyclic etale coverings of generic curves and ordinariness
  of dormant opers*, J. Algebra **623** (2023), especially
  Theorems A and B:
  <https://arxiv.org/abs/1602.07061>.
