# Exponent-four ordinarity controls all prime-to-five inversion towers

Date: 2026-09-05. Proposal: `/root`.
Proof check and write-up: `/root/canonical_trace_algebra`.
Status: author proof of the conditional theorem and the self-contained
fixed-exponent existence construction below, using standard smoothing
and finite-etale lifting theorems. The latter construction was also
checked independently by `/root/gluing_cohomology_rigidity` on
2026-09-05; this is not an independent consolidated audit of the
whole note. No novelty claim is made.

This removes the odd-order restriction from the
[ordinary-genus-two Prym theorem](ODD_GENERALIZED_DIHEDRAL_TOWERS_OVER_ORDINARY_GENUS_TWO_HAVE_FINITE_NONORDINARY_TARGETS.md)
under one additional, explicit hypothesis on the base. It includes
actual nonsplit inversion extensions as well as generalized-dihedral
groups. There is no fixed finite prime support, but five-primary
abelian kernels remain excluded.

## 1. Hypothesis and conclusions

Let Y/Fbar_5 be a smooth projective connected genus-two curve. Assume

\[
            \Theta_Y(k)\cap J(Y^{(1)})[4](k)=\varnothing,    \tag{H4}
\]

including avoidance of the origin. Equivalently, the connected
maximal abelian etale exponent-four cover V_4 -> Y is ordinary:
the character decomposition gives

\[
 a(V_4)=\sum_{M\in J(Y^{(1)})[4]}h^0(B_Y\otimes M),
\]

and a smooth curve has a-number zero exactly when it is ordinary.
In particular Y itself is ordinary. Hypothesis (H4) is not asserted
for every ordinary genus-two curve.

Consider actual finite etale Galois covers W -> Y with an extension

\[
 1\longrightarrow A\longrightarrow G\longrightarrow C_2
                         \longrightarrow1,                 \tag{1.1}
\]

where A is abelian of order prime to five and the nontrivial quotient
element acts on A by inversion. No oddness or splitting is required.

### Theorem 1

Under (H4):

1. There are finitely many geometric isomorphism classes of hyperbolic
   targets T with no ordinary simple isogeny factor in J(T) reached
   by actual finite etale maps from any such W, or from any actual
   intermediate curve of W -> Y.
2. For each of the fifteen double quotients U -> Y there is one fixed
   finite cover W_0 -> U controlling all its inversion-character
   covers, with ordinary new Pryms beyond that level. No fixed set
   of prime factors is imposed.
3. Every actual etale target T of any of these covers or intermediates,
   without any restriction on ordinary factors of J(T), satisfies
   \[
                               a(T)\le28.                   \tag{1.2}
   \]

For the targets in part 1, there is a bound on an **actual common
quotient** of every original correspondence, uniform in its degrees
and depending only on Y. The proof supplies that quotient and does
not assume that the original source contains the controlling level.

## 2. Representatives for every anti-invariant component

Fix a connected etale double cover a:U -> Y, with deck involution tau
and nonzero defining class epsilon in J(Y)[2]. Put P=(ker Nm_a)^0,
an elliptic curve. For the calculation in this section work entirely
on the Frobenius twists, and write a_1 and epsilon_1 accordingly.
Let

\[
                 K=\ker(1+\tau^{(1)*})\subset J(U^{(1)}).
\]

The norm-component calculation in Section 2 of the linked Prym note
proves

\[
 \ker a_1^*=\{0,\epsilon_1\},\qquad
 K^0=P^{(1)},\qquad K/P^{(1)}\simeq C_2^2.                  \tag{2.1}
\]

Define

\[
 \mathcal S_\epsilon
       =\{M\in J(Y^{(1)})[4]:2M\in\{0,\epsilon_1\}\}.
                                                               \tag{2.2}
\]

### Lemma 2.1

The image a_1^*S_epsilon is exactly K[2](k). It has sixteen points,
four on each of the four components of K.

**Proof.** Multiplication by two from J(Y^(1))[4] onto J(Y^(1))[2]
has kernel of order 2^4=16. The two indicated fibers therefore give
|S_epsilon|=32. Pullback has kernel {0,epsilon_1}, contained in
S_epsilon, so its image has sixteen points.

For t=a_1^*M in that image, one has

\[
       2t=a_1^*(2M)=0,
       \qquad (1+\tau^{(1)*})t=2t=0.
\]

Thus the sixteen points lie in K[2]. Every component of K has a
two-torsion representative: if x lies in it, then 2x lies in P^(1),
and the surjectivity of [2] on P^(1) gives y in P^(1) with 2y=2x.
Then x-y is a two-torsion point in that component. Its full two-torsion
fiber is a translate of P^(1)[2], which has four points. There are
four components, so |K[2]|=16 and the image just constructed is all
of it. All these groups are etale in characteristic five.
\(\square\)

For every such t=a_1^*M, etale functoriality of B and projection
formula give

\[
 h^0(B_U\otimes t)
    =h^0(B_Y\otimes M)+h^0(B_Y\otimes M\otimes\epsilon_1)=0, \tag{2.3}
\]

because both lines on the right are four-torsion. Hence each of the
four elliptic components t+P^(1) contains a point outside Theta_U.
The restriction of theta to each is proper and finite. The same
formula with M=O proves that U is ordinary; its elliptic Prym is
therefore ordinary too.

For a fixed double cover, avoidance of only the 32 points S_epsilon
already proves (2.3). Taking all fifteen epsilon gives the uniform
hypothesis (H4): the union of their S_epsilon is J(Y^(1))[4].

## 3. Finite bad characters and actual inversion covers

Let

\[
 \Gamma_U=K(k)_{5'}
     =\{x\in K(k):\operatorname{ord}(x)\text{ is prime to }5\}.
\]

This is a subgroup; even orders and arbitrary odd primes are allowed.
Section 2 makes Theta_U(k) cap Gamma_U finite. Set

\[
             \Lambda_{0,U}=\langle\Theta_U(k)\cap\Gamma_U\rangle.
                                                               \tag{3.1}
\]

For any finite Lambda<=Gamma_U, form its connected abelian etale
character cover W_Lambda -> U. Apply the
[finite-bad-character theorem](FINITE_RESTRICTED_THETA_CHARACTERS_FORCE_UNIFORM_ETALE_TARGET_DESCENT.md).
If Lambda contains Lambda_(0,U), the Prym of
W_Lambda -> W_(Lambda_(0,U)) is ordinary. An arbitrary Lambda is
handled by the actual dominating cover for Lambda+Lambda_(0,U).
This gives a single controlling level for the full directed family,
not a different level for each finite set of primes.

Here is the precise group interface. The condition Lambda<=K says
that tau* acts by inversion on its characters. Its cover kernel in
pi_1(U) is invariant under pi_1(Y), so W_Lambda -> Y is Galois with
an extension (1.1), A=Lambda^dual. If s is a lift of the nontrivial
element of C_2, then

\[
                  s a s^{-1}=a^{-1}\quad(a\in A),
                         \qquad s^2\in A[2].                \tag{3.2}
\]

For even A the final element need not be trivial. Indeed changing
s to a s does not change its square when the action is inversion.
We therefore make no splitting claim.

Conversely, every actual cover (1.1) has double quotient U=W/A.
Its character subgroup in J(U^(1)) has prime-to-five order and is
anti-invariant under tau, hence lies in Gamma_U. The directed family
above thus contains **every actual** inversion extension with this
double quotient, including nonsplit ones. This proves cofinality for
the stated geometric class; it is not an assertion that every
abstract finite group of the form (1.1) is realized.

## 4. The uniform a-number bound

Section 3.1 of the linked Prym note proves
deg(Theta_U|_(P^(1)))=2(p-1)=8. Translation preserves this degree.
Thus the four proper restricted divisors from Section 2 have total
degree 32.

For every point alpha on any one of these components, a local
determinant-of-cohomology matrix over its DVR gives

\[
              h^0(B_U\otimes\alpha)
                    \le\operatorname{mult}_\alpha(\Theta_U|_K).
                                                               \tag{4.1}
\]

The reason is that the generically invertible square matrix has
special-fiber corank h^0, while its determinant valuation is at least
that corank. This applies independently on all four components.

The ordinary elliptic P has four nonzero geometric points in
ker(V_P:P^(1) -> P). They belong to Theta_U: for such a nontrivial
alpha, F_U^*alpha=O_U, and the defining sequence for B_U tensor alpha
injects k=H^0(U,O_U) into H^0(B_U tensor alpha). These four points
have order five and are excluded from Gamma_U.

Consequently the character formula and (4.1) give

\[
 a(W_\Lambda)=\sum_{\alpha\in\Lambda}h^0(B_U\otimes\alpha)
                           \le32-4=28.                      \tag{4.2}
\]

Any actual finite etale map to T injects H^0(B_T) into H^0(B_W),
proving (1.2), also after composition from any actual etale
intermediate. This does not bound stable p-rank defect by 28, and
does not bound the torsion orders in (3.1).

## 5. Finite targets and the actual common quotient

For targets T with no ordinary simple factor, the ordinary-Prym
descent theorem makes every lifted map descend to W_(Lambda_(0,U)).
For an actual intermediate Z of W_Lambda -> Y and an etale map
r:Z -> T, work in the field of W_(Lambda+Lambda_(0,U)). The image
r^*k(T) lies in both k(Z) and k(W_(Lambda_(0,U))). Therefore

\[
 k(D)=k(Y)\,r^*k(T)
      \subset k(Z)\cap k(W_{\Lambda_{0,U}}),\qquad
                  \deg(D/Y)\le2|\Lambda_{0,U}|.              \tag{5.1}
\]

Normalization gives actual etale maps Z -> D -> Y and D -> T,
with the original map to T factoring through D. This is the precise
bounded-quotient conclusion of the general finite-character theorem;
the original source need not contain the controlling level.

Each fixed controlling curve has finitely many hyperbolic etale
quotient curves. There are only fifteen possible U -> Y. Taking the
union of these finite target sets, or the maximum of their bounds
in (5.1), proves all remaining assertions of Theorem 1.

## 6. Existence by a fixed-exponent nodal construction

### Proposition 6.1

For each fixed positive integer m prime to five, there is a smooth
genus-two curve over Fbar_5 whose connected maximal abelian
exponent-m cover is ordinary. In particular bases satisfying (H4)
exist. The following proof does not require the generic-curve
ordinarity theorem.

Put k=Fbar_5. Choose ordinary elliptic curves E_1,E_2 over k and
identify their origins to form the compact-type nodal curve
C_0=E_1 union E_2 of arithmetic genus two. One may use
E_i:y^2=x^3+x over F_5: the curve is smooth, and its Hasse coefficient
is the nonzero coefficient 2 of x^4 in (x^3+x)^2. Let

\[
 A_i=E_i[m](k)\simeq(\mathbf Z/m)^2,\qquad A=A_1\times A_2.
\]

Take one copy of E_1 for each b in A_2 and one copy of E_2 for each
a in A_1, each mapping to its base elliptic curve by [m]. Glue the
point a on the E_1-copy indexed by b to the point b on the E_2-copy
indexed by a. Thus the nodes are labelled by (a,b) in A. Translation
on elliptic components, together with translation of the copy labels,
defines an A-action. The resulting map W_0 -> C_0 is a finite etale
A-torsor. In particular, at a node [m] is an isomorphism on each
completed branch, so the induced homomorphism of completed nodal
local rings is an isomorphism. This is an unramified cover of nodal
curves, not a ramified admissible cover.

Its dual graph is the complete bipartite graph K_(m^2,m^2), hence is
connected, with

\[
 b_1=m^4-2m^2+1,\qquad p_a(W_0)=2m^2+b_1=m^4+1.             \tag{6.1}
\]

The normalization sequence gives a Frobenius-compatible exact sequence

\[
 0\longrightarrow k^{b_1}\longrightarrow H^1(W_0,O_{W_0})
 \longrightarrow
 \bigoplus_{b\in A_2}H^1(E_1,O_{E_1})\ \oplus\!
 \bigoplus_{a\in A_1}H^1(E_2,O_{E_2})\longrightarrow0.
                                                               \tag{6.2}
\]

Frobenius on the graph term is bijective over the perfect field k,
and the elliptic components are ordinary. Thus Frobenius on the
middle term is bijective. This uses coherent cohomology directly;
no assertion about geometric p-torsion points of the graph torus
is needed.

The proper nodal curve C_0 has a flat projective smoothing
\(\mathcal C\to\operatorname{Spec}k[[t]]\) with smooth generic fiber, by
[Stacks, Lemma 93.17.6](https://stacks.math.columbia.edu/tag/0E7S).
Because the base is complete local and \(\mathcal C\) is proper,
[Stacks, Lemma 58.9.1](https://stacks.math.columbia.edu/tag/0A48)
gives an equivalence between finite etale covers of \(\mathcal C\) and
of C_0. Hence W_0 lifts to a finite etale cover
\(\mathcal W\to\mathcal C\).
Full faithfulness lifts the A-action and its torsor identity as well.
The complete-local proof uses unique lifting through nilpotent
thickenings and algebraization; it applies to these nodal special
fibers without a smoothness assumption.

The geometric generic fibers are smooth and connected. For
connectedness, h^0 of each special fiber is one, so upper
semicontinuity gives the same assertion generically, also after any
finite extension of the fraction field; the residue field remains k.
Their arithmetic genera are constant. Consequently H^1(O) commutes
with base change and is locally free in these proper flat families.
The linearization of Frobenius on \(H^1(\mathcal W,O)\) is a square map
between free k[[t]]-modules. By (6.2) its determinant is nonzero
modulo t, hence is a unit. The smooth geometric generic fiber of
\(\mathcal W\) is therefore ordinary.

This generic connected A-torsor has degree m^4 and exponent m.
For a smooth genus-two curve the maximal prime-to-five abelian
exponent-m quotient of its geometric fundamental group is
(Z/m)^4. Thus the generic torsor is exactly its maximal abelian
exponent-m cover, not a proper quotient of that cover.

To obtain a k-valued smooth curve, work on a finite-type pointed
genus-two moduli chart, adding level structure if necessary. Pullback
of [m] on the universal Jacobian along the pointed Abel map gives
the family of connected maximal abelian exponent-m covers. The
ordinary-cover locus is open, by the cohomological Hasse determinant.
The constructed geometric generic example gives a field-valued point
of this open, so it is nonempty. A nonempty finite-type scheme over
the algebraically closed field k has a k-point. With m=4, the
character identity of Section 1 shows that its base satisfies (H4).

The argument uses one fixed m and one nonempty open. It does not
intersect infinitely many ordinary-cover opens over the countable
field Fbar_5. No explicit smooth genus-two equation has been supplied,
and no claim is made that all ordinary Y satisfy (H4).

For historical comparison, Raynaud attributes the stronger generic
abelian-cover ordinarity theorem to Nakajima in the introduction,
printed p. 73, and Rappel 2, printed p. 77, of
[*Revêtements des courbes en caractéristique p>0 et ordinarité*](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/16AB72912D3CE32BFC5D012B1025A8E4/S0010437X00000440a.pdf/revetements-des-courbes-en-caracteristique-pandgt0-et-ordinarite.pdf).
The fixed-exponent proof above is sufficient here and does not rely
on an uninspected proof of that stronger statement.

## 7. Scope

The conditional theorem concerns actual prime-to-five inversion
extensions over specially chosen genus-two bases. It does not cover
arbitrary nonabelian groups or five-primary abelian kernels. Its
finite-target part requires no ordinary simple factors in the target
Jacobian; its a-number obstruction does not require that condition.
The construction neither replaces the fixed curves of file 76 nor
claims a new exclusion there beyond the previously available bounded
character-degree packet results.
