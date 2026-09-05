# Odd generalized-dihedral towers over ordinary genus two: one finite exceptional level

Date: 2026-09-05. Proposal: `/root`.
Proof check and write-up: `/root/canonical_trace_algebra`.
Status: author proof with the previously checked inputs identified below;
not an independent audit of the consolidated theorem. No novelty claim.
The four/five a-number refinement in Section 3.2 received a focused
**PASS** from `/root/gluing_cohomology_rigidity`, 2026-09-05; that check
is not presented as an audit of the whole note.

Throughout k=Fbar_5. All curves are smooth, proper, and connected.
Fix an ordinary genus-two curve Y. A target T is required to be
hyperbolic and to have **no ordinary simple isogeny factor** in J(T).
It need not have simple Jacobian or a specified endomorphism algebra.

The groups allowed below have an abelian subgroup of odd order prime
to 5, acted on by inversion through a quotient of order two. There is
**no restriction to a fixed finite set of odd primes**. The abelian
kernel's 2-primary and 5-primary parts are excluded.

The reusable core is the separate
[finite-bad-character theorem](FINITE_RESTRICTED_THETA_CHARACTERS_FORCE_UNIFORM_ETALE_TARGET_DESCENT.md):
for arbitrary U and any prime-to-p torsion subgroup Gamma, finiteness
of Theta_U cap Gamma gives one ordinary-Prym descent level. No fixed
primes or ambient dimension are required by that theorem. The present
note proves the geometric hypotheses and sharper quantitative bounds
for the elliptic Prym in this particular group class.

## 1. Statements

Fix a connected etale double cover a:U -> Y, with involution tau, and put

\[
 P=(\ker(\operatorname{Nm}_a:J(U)\to J(Y)))^0.
\]

It is an elliptic curve. Write P^(1) for its Frobenius twist inside
J(U^(1)), and let

\[
 \mathcal T=P^{(1)}(k)_{(10)'}
       =\{x:\operatorname{ord}(x)\text{ is finite and prime to }10\}.
\]

For each finite subgroup Lambda<=T, let W_Lambda -> U be its associated
connected abelian etale character cover, constructed on the Frobenius
twists and then transported back by etale Frobenius base change. Its
degree is |Lambda|. Fix compatible basepoints so these covers form
one directed system, with W_(Lambda+Lambda') dominating both covers.

### Theorem A

There is a single finite subgroup Lambda_0<=T such that, for every
finite Lambda containing Lambda_0, the Prym of

\[
                         W_\Lambda\longrightarrow W_{\Lambda_0}
                                                               \tag{1.1}
\]

is ordinary. Every actual morphism W_Lambda -> T, for every target T
as specified above, therefore descends uniquely to W_(Lambda_0).
Etaleness is retained for an etale morphism.

The same finite cover controls the **entire directed family**, not
only the levels containing Lambda_0: a map from W_Lambda can first be
pulled to W_(Lambda+Lambda_0), where it descends to W_(Lambda_0).

### Theorem B

There are only finitely many isomorphism classes of such targets T
admitting an actual finite etale map from any W_Lambda, or from any
actual intermediate curve of W_Lambda -> Y. This holds simultaneously
for all fifteen connected etale double covers U -> Y.

Equivalently, it applies to every actual correspondence whose leg to
Y has Galois closure with generalized-dihedral group A semidirect C_2,
where A is abelian of odd order prime to 5 and C_2 acts by inversion.
No Galois hypothesis is imposed on the other leg.

There is also an actual bounded common quotient: for the fixed U and
its Lambda_0, every such intermediate Z -> Y with an etale map Z -> T
has a quotient Z -> D through which both maps factor etale, with

\[
                         \deg(D/Y)\le2|\Lambda_0|.           \tag{1.2}
\]

The bound is independent of Lambda, T, and the two original degrees.
It is allowed to depend on the fixed double cover U -> Y.

### Theorem C: a uniform a-number bound, with unrestricted targets

For every allowed finite Lambda, independently of Y and the character
orders,

\[
 a(W_\Lambda)\le
 \begin{cases}
 4,&U\text{ ordinary},\\
 5,&U\text{ nonordinary}.
 \end{cases}                                                \tag{1.3}
\]

Consequently every actual finite etale target T of such a W_Lambda
or one of its etale intermediates satisfies a(T)<=5. This last
conclusion does **not** require J(T) to have no ordinary simple
factor. These a-number bounds are not bounds on stable defect.

## 2. Norm components and odd anti-invariant characters

Let epsilon be the nontrivial two-torsion line class defining U -> Y.
The double-cover decomposition is

\[
                         a_*O_U=O_Y\oplus\epsilon.
\]

### Lemma 2.1

The following statements hold scheme-theoretically in characteristic 5:

\[
 \ker a^*=\{0,\epsilon\}\simeq C_2,
 \qquad (\ker\operatorname{Nm}_a)/P\simeq C_2,
 \qquad \ker(1+\tau^*)/P\simeq C_2^2.                     \tag{2.1}
\]

In particular every finite odd-order subgroup of ker(1+tau*) lies in P.
The same assertions hold on the Frobenius twists.

**Proof.** If a^*L=O_U for L in J(Y), projection formula gives

\[
 1=h^0(U,a^*L)=h^0(Y,L)+h^0(Y,L\otimes\epsilon).
\]

A degree-zero line has a section exactly when it is trivial, proving
the asserted geometric kernel. The identity Nm_a a^*=[2] puts the
scheme kernel inside the etale group J(Y)[2], so this is also its
scheme-theoretic description.

Norm is surjective and smooth, since its composite with a^* is [2],
including on tangent spaces. Factor it as

\[
 J(U)\xrightarrow{\pi} B=J(U)/P
               \xrightarrow{\beta}J(Y).
\]

Here beta is an isogeny. Under the canonical principal polarizations,
the dual of norm is a^*. The dual of pi is an embedding; thus
ker(beta^dual)=ker(a^*) has order two. Isogeny and dual isogeny have
the same degree, so ker beta is etale of order two. This proves the
middle assertion of (2.1). Riemann--Hurwitz gives g(U)=3, hence P has
dimension one and B, being isogenous to ordinary J(Y), is ordinary.

The identity a^* Nm_a=1+tau* shows that ker(1+tau*)/P is the kernel
of a^* beta:B -> J(U). It has order four. The image of tau*-1 on
J(U) is connected and lies in ker norm, hence lies in P. Consequently
pi tau*=pi. If h:B -> J(U) is the induced map a^* beta, then

\[
                              \pi h=[2]_B.
\]

Thus ker h is killed by two, and is the etale group C_2^2. This also
proves that P is the identity component of ker(1+tau*). An odd-order
subgroup has trivial image in this component group, proving the last
assertion. \(\square\)

### Lemma 2.2: the actual generalized-dihedral cover

Every W_Lambda -> U in Section 1 is Galois over Y, with group

\[
                  \widehat\Lambda\rtimes C_2,
            \qquad \widehat\Lambda=\operatorname{Hom}(\Lambda,k^*),
                                                               \tag{2.2}
\]

where C_2 acts by inversion. Conversely every actual generalized-dihedral
cover of the stated odd prime-to-five kind arises this way from its
double quotient U -> Y.

**Proof.** On P one has tau*=-1. Therefore tau preserves Lambda,
and the character-cover kernel in pi_1(U) is invariant under the
conjugation action from pi_1(Y). The composite W_Lambda -> Y is Galois.
Conjugation by any lift s of tau acts by inversion on its abelian
deck subgroup A=Lambda^dual. Now s^2 belongs to A and is fixed by
conjugation by s. Inversion therefore gives s^2=(s^2)^(-1). Since
|A| is odd, s^2=1, proving the asserted split extension.

Conversely take an actual cover with group A semidirect C_2 and let
U be its quotient by A. Its prime-to-five character subgroup in
J(U^(1)) is finite, odd, and acted on by tau* as inversion. Lemma 2.1
places it inside P^(1), giving exactly the claimed description.
All maps used are actual finite etale maps. \(\square\)

## 3. A finite bad-character set, with no fixed prime support

Write B_U=F_(U/k)*O_U/O_(U^(1)), and let Theta_U be its Raynaud theta
divisor in J(U^(1)). The
[ordinary-complement sufficient condition, Section 2](RESTRICTED_RAYNAUD_THETA_SUFFICIENT_CONDITIONS_AND_STABILITY_BOUNDARY.md)
gives

\[
                           P^{(1)}\not\subset\Theta_U,       \tag{3.1}
\]

because J(U)/P is ordinary. Its input is Tong's Dirac property for
Raynaud theta: the connected local component of the Verschiebung
kernel is contained in P^(1), and a local theta equation is nonzero
on that component. The prior note proves this implication from
[Tong, Definition 1.2.7.1 and Theorem 1.2.7.7](https://arxiv.org/pdf/0712.2046).
We use that checked implication, not a claim of generic stability
implying theta.

Since P^(1) is a curve, (3.1) makes the set

\[
                         D=\Theta_U(k)\cap P^{(1)}(k)
\]

finite. Set

\[
                  D_{(10)'}=D\cap\mathcal T,
                  \qquad \Lambda_0=\langle D_{(10)'}\rangle. \tag{3.2}
\]

This is a finite subgroup of order prime to ten. Over Fbar_5 every
geometric point of an abelian variety is torsion, but we explicitly
retain only the allowed orders. Finiteness of D, rather than a
fixed-prime-support torsion theorem, is the reason arbitrary odd
prime support is permitted here.

Multiplication by 5 is an automorphism of Lambda_0. In particular
Lambda_0 contains the complete multiplication-by-5 orbit of every
allowed bad point, including inverse iterates. No invariance of the
finite set D itself under multiplication by 5 is asserted.

### 3.1. Polarization degree and cohomology multiplicities

The restriction of the canonical Jacobian polarization to P has
degree two. Here is a degree proof. Write i:P -> J(U), let lambda_U
be the principal polarization, and let e_P be the degree of its
restricted line bundle on the elliptic P. The induced polarization
lambda_P has degree e_P^2 and kernel P cap a^*J(Y): the connected
orthogonal complement of P is the image of the dual of norm, a^*J(Y).
The isogeny

\[
 \phi:P\times J(Y)\longrightarrow J(U),\qquad
                         (x,y)\longmapsto i(x)+a^*y
\]

has degree 2e_P^2, because ker a^* has order two. Its pulled-back
polarization is block diagonal, lambda_P on P and twice the principal
polarization on J(Y), with zero cross terms by norm orthogonality.
Taking degrees gives

\[
                    (2e_P^2)^2=e_P^2\,2^4,
                           \qquad e_P=2.                    \tag{3.3}
\]

Scalar Frobenius twisting preserves this degree. P^(1) here is the
scalar-twisted subvariety of J(U^(1)), not a pullback of a polarization
along a degree-p isogeny.

The Raynaud divisor class is (p-1) times the principal theta class;
see [Tong, Corollary 1.2.3.2](https://arxiv.org/pdf/0712.2046), PDF p. 6.
Thus the nonzero restricted divisor D_sch=Theta_U|_(P^(1)) has degree

\[
                          \deg D_{\rm sch}=2(p-1)=8.         \tag{3.4}
\]

For every alpha in P^(1)(k),

\[
               h^0(B_U\otimes\alpha)
                            \le\operatorname{mult}_\alpha D_{\rm sch}.
                                                               \tag{3.5}
\]

Indeed the local family over the DVR O_(P^(1),alpha) has Euler
characteristic zero. Its cohomology is represented by a square matrix
between free modules, obtained for example using a sufficiently
positive auxiliary divisor on U^(1). This matrix is generically
invertible by (3.1); its determinant defines D_sch locally. Its
special-fiber corank is h^0(B_U tensor alpha). In Smith normal form,
the determinant valuation is the sum of positive elementary-divisor
valuations, at least their number, which is that corank.

The character decomposition therefore gives the initial uniform bound

\[
 a(W_\Lambda)=\sum_{\alpha\in\Lambda}h^0(B_U\otimes\alpha)
                                      \le8.                 \tag{3.6}
\]

In particular (3.4) bounds the number of bad character weights with
multiplicity. It does not bound their torsion orders or |Lambda_0|.

### 3.2. Dirac sharpening to four or five

The additional input is exactly
[Tong, Definitions 1.2.7.1 and 1.2.7.4, Theorem 1.2.7.7](https://arxiv.org/pdf/0712.2046),
PDF pp. 11--12: on ker V_J, a theta equation vanishes on every
nonidentity component and is a nonzero socle generator on the
identity component. These definitions and the stated theorem were
read directly for this refinement. All Verschiebung maps here have
source the Frobenius twist, so ker V_P is a subgroup of P^(1).

The isogeny phi of (3.3) has degree eight, prime to five. Hence it
identifies the five-divisible groups of J(U) and P times J(Y).
Since J(Y) is ordinary, U is ordinary exactly when P is ordinary;
otherwise P is supersingular and a(U)=1.

If U is ordinary, ker(V_P:P^(1) -> P) has p distinct geometric
points. Each of its p-1 nonidentity points alpha lies in Theta_U,
even without using Dirac: F_U^*alpha=O_U, and tensoring the defining
sequence for B_U by alpha gives an injection

\[
 H^0(U,O_U)=k\ \hookrightarrow\ H^0(U^{(1)},B_U\otimes\alpha),
\]

since H^0(U^(1),alpha)=0. These points all have order p and hence
are absent from the prime-to-p subgroup Lambda. Removing at least
this much divisor degree from (3.4) and using (3.5) gives

\[
                            a(W_\Lambda)\le p-1=4.           \tag{3.7}
\]

If U is nonordinary, the identity component of ker V_(J(U)) equals
ker V_P: the latter is contained in it, and both have length p by
the prime-to-p isogeny above. In the completed local ring of P^(1),
that subgroup has ring k[t]/(t^p). Dirac therefore makes a restricted
theta equation congruent to c t^(p-1) modulo t^p, with c nonzero.
Its local order is exactly p-1. Since Lambda contains the origin,
where h^0(B_U)=a(U)=1, (3.5) away from zero yields

\[
 a(W_\Lambda)\le 1+\deg D_{\rm sch}-(p-1)=p=5.              \tag{3.8}
\]

Finally an actual etale map W_Lambda -> T gives
B_(W_Lambda)=r^(1)*B_T, so pullback of sections injects and
a(T)<=a(W_Lambda). Composition gives the same conclusion for targets
of actual etale intermediates. This proves Theorem C without any
restriction on the ordinary isogeny factors of J(T).

## 4. Frobenius blocks and ordinary new Pryms

This is the specialization of Theorem 1 in the linked
[general finite-bad-character theorem](FINITE_RESTRICTED_THETA_CHARACTERS_FORCE_UNIFORM_ETALE_TARGET_DESCENT.md).
The block argument is included to make the Frobenius convention explicit.

Let Lambda contain Lambda_0. On the twists the character decomposition
of W_Lambda -> U gives, up to an immaterial inversion of labels,

\[
 H^0(W_\Lambda^{(1)},B_{W_\Lambda})
       =\bigoplus_{L\in\Lambda}
                        H^0(U^{(1)},B_U\otimes L).           \tag{4.1}
\]

This follows from etale Frobenius base change and projection formula.
Every summand indexed outside Lambda_0 is zero by (3.2).

On V_Lambda=H^1(W_Lambda,O), absolute Frobenius is semilinear and
sends a deck-character eigenspace chi to that for chi^5. The old
character set Lambda_0 and its complement in Lambda are both stable
under this permutation. Thus V_Lambda splits into Frobenius-stable
old and new parts. Equivalently use the averaging projector for the
prime-to-five group Gal(W_Lambda/W_(Lambda_0)); this gives the same
old part and commutes with Frobenius.

The defining exact sequence for B identifies (4.1) with the kernel
of relative Frobenius on coherent H^1, since the preceding map on
H^0 of the structure sheaf is an isomorphism. After scalar twisting,
it detects the kernel of absolute Frobenius. Its new part is zero.
Frobenius is therefore injective, hence bijective over the perfect
field k, on the whole new finite-dimensional part of V_Lambda.

The Jacobian of W_Lambda is isogenous to J(W_(Lambda_0)) times the
Prym of (1.1). The new cohomology part is that Prym's coherent H^1.
Its bijective Frobenius proves that the Prym is ordinary.

This also accounts for all higher Frobenius kernels: if a nilpotent
vector starts in a character block, its last nonzero iterate lies in
a first-kernel block. Its character therefore belongs to a finite
multiplication-by-five orbit of the bad characters. Those orbits
are all contained in Lambda_0. We do not mistake finiteness of the
first kernel for a bound on stable nilpotence without this invariant
block argument.

For any Lambda not containing Lambda_0 apply the result to
Lambda+Lambda_0. Hence the same fixed exceptional level works for
every member of the directed system, regardless of prime support.
Every cofinal nested sequence eventually contains Lambda_0 and has
ordinary successive and composite Pryms thereafter.

## 5. Actual target descent and finiteness

The input is
[Theorem A and Section 7 of the checked non-Galois descent theorem](NONGALOIS_JACOBIAN_ORTHOGONALITY_AND_ETALE_MAP_STABILIZATION.md):
for an actual finite etale q:V -> V_0, if its Prym has no nonzero
homomorphism to J(T), every morphism V -> T to a hyperbolic curve
descends uniquely to V_0; etaleness is retained.

An ordinary abelian variety has no nonzero homomorphism to J(T) when
J(T) has no ordinary simple factor. Section 4 therefore proves all
the map descent assertions of Theorem A, with one level independent
of T and its genus.

For the full intermediate statement, let Z be any actual intermediate
of W_Lambda -> Y and let r:Z -> T be finite etale. Put
W^+=W_(Lambda+Lambda_0) and W_0=W_(Lambda_0). Pull r up to W^+.
It descends to an actual etale map W_0 -> T. In the common field
k(W^+), the image r^*k(T) is consequently contained in both k(Z)
and k(W_0). Hence

\[
 k(D):=k(Y)\,r^*k(T)
                   \subseteq k(Z)\cap k(W_0).              \tag{5.1}
\]

Normalize this field. Both D -> Y and D -> T are intermediate maps
of the original etale maps from Z, so both are finite etale. Equation
(5.1) gives deg(D/Y)<=deg(W_0/Y)=2|Lambda_0|. This proves (1.2)
without assuming that Z or W_Lambda contains W_0, and without
replacing either original target map by an unrelated one.

A fixed hyperbolic W_0 has only finitely many hyperbolic etale
quotient curves. One proof bounds the outgoing degree by g(W_0)-1;
its Galois closure over such a quotient is then a bounded-degree
etale cover of W_0. The proper curve's finitely generated etale
fundamental group gives finitely many such covers, and each has
finite automorphism group and finitely many quotients. This is the
finiteness argument in the cited theorem, not an assertion about
finitely many points of a positive-dimensional moduli space.

Finally, Y has exactly 2^4-1=15 connected etale double covers, from
its nonzero two-torsion characters. Applying the proof to each of
these finitely many U and taking the union of their finite target
sets proves Theorem B. \(\square\)

## 6. Boundaries and relation to the fixed pair

- The abelian kernel is odd and prime to five. Even characters can
  occupy other components of ker(1+tau*), on which the identity-component
  theta argument proves nothing. Inversion lifts can also have
  nontrivial square when the kernel has two-torsion.
- Five-primary etale covers are not encoded by the prime-to-five
  torsion-line character decomposition used here. No assertion about
  adding arbitrary five-primary layers is made.
- Ordinary genus two is substantive: it makes the complementary
  Jacobian quotient ordinary and the Prym one-dimensional. In larger
  dimension proper theta restriction need not have finite support.
- The target hypothesis excludes every ordinary simple factor, not
  merely ordinary whole Jacobians. It includes absolutely simple
  nonordinary Jacobians, including positive-p-rank examples.
- This does not add a new exclusion for the fixed genus-nine X of
  file 76 in the present generalized-dihedral class: the earlier
  [bounded-character-degree packet result](96_NONABELIAN_PACKET_SCHUR_INDEX_DOMINATION_BOUND.md)
  already treats that fixed target in the relevant bounded-index-abelian
  range. Here the structural conclusion is instead uniform across
  all the specified targets, without an endomorphism-field hypothesis,
  and allows arbitrary odd prime support at once.

No assertion about unrestricted common covers, arbitrary solvable
monodromy, or a solution of Litt's problem is made.
