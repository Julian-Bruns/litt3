# P-rank-one maximal Tango structures descend through etale p-groups

**Status: collaborative author proof and two-author verification,
2026-09-05; not independently audited.**

Authors and author-verifiers: /root and /root/gluing_cohomology_rigidity.
The authors checked the cardinal bound and descent argument by separate
routes. This is author verification of this note, not an independent audit
of its inputs or of the surrounding project.

A curve of p-rank one has at most p-1 maximal Tango structures. Consequently
every such structure descends through an etale Galois p-group quotient.
For a general finite Galois etale cover whose source has p-rank one,
descent through a Sylow p-subgroup gives a useful genus-divisibility
obstruction, without claiming descent through the entire Galois group.

Throughout, k is algebraically closed of odd characteristic p, and curves
are smooth, projective and connected. Write gamma(C) for the geometric
p-rank, and F_C:C -> C^(1) for relative Frobenius.

## 1. Maximal lines, roots and connections

Set

\[
 B_C^1=\ker\bigl(\operatorname{Car}:F_{C*}\omega_C
                         \longrightarrow\omega_{C^{(1)}}\bigr).
\]

A maximal Tango structure is an embedded line bundle L in B_C^1 whose
adjoint map

\[
                         F_C^*L\longrightarrow\omega_C             \tag{111.1}
\]

is an isomorphism. Denote the set of these embedded subbundles by Tan(C).
Equivalently, it is specified by a nonzero rational differential xi with

\[
             \operatorname{Car}(\xi)=0,\qquad
             \operatorname{div}(\xi)=pD.                            \tag{111.2}
\]

In particular

\[
 \operatorname{Tan}(C)\ne\varnothing
                  \quad\Longrightarrow\quad p\mid g(C)-1.         \tag{111.3}
\]

Here “maximal” means equality deg L=(2g(C)-2)/p, not a floor-rounded
maximum of the Tango number. The distinction matters when the right side
is not an integer.

The Frobenius roots of omega_C, if any, form a torsor under

\[
 K_C=\ker\bigl(F_C^*:\operatorname{Pic}^0(C^{(1)})(k)
                         \longrightarrow\operatorname{Pic}^0(C)(k)\bigr).
\]

This is an F_p-vector space of dimension gamma(C): the indicated
isogeny is Verschiebung on the Jacobian, and its geometric kernel has
p^gamma(C) elements. The relative Frobenius twist in this statement is
essential. For every root L, adjunction gives

\[
 \operatorname{Hom}(L,F_{C*}\omega_C)
   =H^0(C,\omega_C\otimes F_C^*L^{-1})=k.                            \tag{111.4}
\]

Thus a root supports at most one embedded maximal Tango line; multiplying
the embedding by a nonzero scalar does not change its image. In particular,
gamma(C)=0 implies |Tan(C)|<=1. This observation alone does not settle
non-Galois descent from a cover whose Galois closure has larger p-rank.

By Cartier descent, Frobenius roots with their isomorphism (111.1)
correspond to regular connections on omega_C with zero p-curvature.
Changing that isomorphism by a global scalar does not change the
connection. The root lies in B_C^1 precisely when the horizontal local
differentials are Cartier-zero. This condition can be checked at the
generic point: Cartier is linear over pth powers, and a map of line
bundles which is generically zero is zero everywhere.

This connection dictionary is also described in
[Wakabayashi, Moduli of Tango structures and dormant Miura opers,
Sections 0.2 and 5.3](https://arxiv.org/html/1709.04241).
The explicit characteristic-five equation and its gluing are recorded in
[the local maximal Tango connection note](LOCAL_MAXIMAL_TANGO_CONNECTION_EQUATION_CHAR5.md).
The argument below works for every odd p.

## 2. The degree-p-minus-one bound

### Lemma 111.1

If gamma(C)=1, then

\[
                         |\operatorname{Tan}(C)|\le p-1.            \tag{111.5}
\]

More generally, on any curve, an affine F_p-line of zero-p-curvature
connections with nonzero Cartier-fixed direction contains at most p-1
maximal Tango connections.

#### Proof

We use the classical p^(-1)-semilinear Cartier operator on differentials
over the perfect field k; this is the usual untwisted notation for the
relative operator above. The regular Cartier-fixed differentials

\[
 V_C=\{\beta\in H^0(C,\omega_C):\operatorname{Car}(\beta)=\beta\}
\]

form an F_p-vector space of dimension gamma(C). Once one zero-p-curvature
connection exists, all such connections form an affine torsor under V_C.
For completeness this difference assertion follows from the local
p-curvature formula below, so it does not identify the roots by an
unjustified choice of Frobenius twist.

Choose a separating rational coordinate x, put partial=d/dx on k(C),
and write a connection as

\[
                  \nabla(dx)=a\,dx\otimes dx.
\]

The derivation partial has partial^p=0: its pth power is a derivation
vanishing on k(x), hence on the finite separable extension k(C). The
rank-one p-curvature formula is

\[
 (\partial+a)^p=\partial^p+a^p+\partial^{p-1}a.                      \tag{111.6}
\]

Therefore two regular connections with zero p-curvature differ by a
regular differential b dx satisfying

\[
                    b^p+\partial^{p-1}b=0,
\]

which is exactly Car(b dx)=b dx, since

\[
 \operatorname{Car}(u\,dx)
                   =\bigl(-\partial^{p-1}u\bigr)^{1/p}dx.          \tag{111.7}
\]

Conversely, adding a Cartier-fixed regular differential preserves zero
p-curvature by (111.6).

If no zero-p-curvature connection exists, the assertion is immediate.
Otherwise choose one, and choose a nonzero beta=b dx in V_C. On its
affine F_p-line the coefficients are a+t b, with t in F_p. Define

\[
 P_0(A)=1,\qquad P_{j+1}(A)=\partial P_j(A)-A P_j(A).                \tag{111.8}
\]

For each t, Cartier descent supplies a nonzero rational horizontal
differential u dx, so partial u=-(a+t b)u and

\[
                \partial^j u=P_j(a+t b)u.
\]

By (111.7), this connection is Tango exactly when

\[
                         P_{p-1}(a+t b)=0.                         \tag{111.9}
\]

Regard P_j(a+T b) as a polynomial in the indeterminate T over k(C),
with partial T=0. Induction in (111.8) shows that it has degree j and
leading coefficient (-b)^j: differentiating does not increase its
T-degree, whereas multiplication by -(a+T b) supplies the new top term.
In particular P_(p-1)(a+T b) is a nonzero polynomial of degree p-1.
It vanishes at at most p-1 of the p distinct elements of F_p.

When gamma(C)=1, V_C is exactly F_p beta, so this line comprises all
zero-p-curvature connections. Equation (111.4) and Cartier descent
identify the Tango connections with Tan(C), proving (111.5). QED.

For p=5, the polynomial used here is

\[
             P_4(a)=a^4-a^2a'+3(a')^2+4aa''-a'''.                  \tag{111.10}
\]

On a higher-dimensional Cartier-fixed translation space, the
one-dimensional assertion does not bound the entire Tango locus by p-1.
No higher-p-rank descent conclusion follows from this proof.

## 3. Descent through an etale p-group

### Theorem 111.2

Let f:D -> C be a connected finite Galois etale cover with p-group P.
If gamma(C)=1, then gamma(D)=1 and pullback gives a bijection

\[
                  \operatorname{Tan}(C)
                          \xrightarrow{\ \sim\ }\operatorname{Tan}(D).
                                                                    \tag{111.11}
\]

The same conclusion holds if gamma(D)=1 is assumed instead. Every
individual maximal Tango structure upstairs descends, not merely the
existence of some structure.

#### Proof

The unramified Deuring--Shafarevich formula gives

\[
                  \gamma(D)-1=|P|(\gamma(C)-1).                    \tag{111.12}
\]

Consequently either p-rank-one hypothesis implies the other. The natural
P-action on Tan(D) has orbits of p-power cardinality. By Lemma 111.1
the entire set has at most p-1 elements. Every orbit is therefore a
singleton, and every embedded maximal Tango line is invariant.

This invariance gives an actual descent datum, not just invariance of
an isomorphism class of line bundles. Because f is etale, its relative
Frobenius square is Cartesian and Cartier commutes with etale base
change. In particular

\[
                 B_D^1\simeq f^{(1)*}B_C^1.                        \tag{111.13}
\]

The canonical P-linearization of this ambient bundle restricts to every
invariant embedded line. Its cocycle condition is inherited from the
ambient bundle; there is no choice of independent scalars and no
division by |P|. Faithfully flat descent therefore gives a line
L_C in B_C^1 whose pullback is the chosen L_D. The adjoint
F_C^*L_C -> omega_C becomes (111.1) for D after the faithfully flat
pullback f, so it is an isomorphism. Thus L_C is maximal Tango.

Conversely, etale pullback preserves (111.1) and (111.13), so it
preserves maximal Tango structures. Faithful flatness gives uniqueness
of the descended embedded line and injectivity of pullback. QED.

Equivalently, the invariant connection on the canonically P-linearized
omega_D descends to omega_C. Zero p-curvature and the Cartier-zero
horizontal condition are etale-local. This is the same descent, not an
extra choice of linearization.

## 4. A Sylow genus filter for Galois covers

### Corollary 111.3

Let D -> X be a connected finite Galois etale cover with group G, and
suppose gamma(D)=1. For a Sylow p-subgroup P of G put B=D/P. Then every
maximal Tango structure on D descends to B. In particular, if

\[
                              p\nmid g(X)-1,                       \tag{111.14}
\]

then Tan(D) is empty.

#### Proof

The cover D -> B is Galois etale with p-group P. Formula (111.12)
forces gamma(B)=1, and Theorem 111.2 gives descent to B. Meanwhile
Riemann--Hurwitz for the etale map B -> X gives

\[
                    g(B)-1=[G:P](g(X)-1).                          \tag{111.15}
\]

The index [G:P] is prime to p. Under (111.14), equation (111.15)
contradicts the necessary divisibility (111.3) for a Tango structure
on B. QED.

There is no claim that the structure descends further to X. The subgroup
P need not be normal, and B -> X need not be Galois.

## 5. Application and exact scope

Over Fbar_5, the optional curve

\[
                       X_1:\ y^2=x^{19}+x^{14}+1
\]

has genus nine and p-rank one, as certified in
[the alternative-source note](P_RANK_ONE_GENUS9_ALTERNATIVE_SOURCE.md).
Since 5 does not divide g(X_1)-1=8, it has no maximal Tango structure.
Every connected Galois etale 5-group cover of degree 5^a consequently
has p-rank one, genus

\[
                              1+8\cdot5^a,
\]

and no maximal Tango structure, for every a>=0. For a>=1 the upstairs
genus passes the elementary divisibility test, so this conclusion uses
descent. More generally Corollary 111.3 applies to every finite Galois
etale cover of X_1 whose source has p-rank one.

The genus-nine X in
[the current genus-(9,25) pair, file 76](../../Theorems/Thm_fixed_pair_arithmetic.md)
is different: its Frobenius polynomial (76.5) has lowest nonzero
modulo-five term 3083 T^12, so its p-rank is six, not one. This note
does not replace either fixed curve and gives no new common-cover
exclusion for that pair. Its conclusion is a genus filter subject to
the explicitly stated p-rank and Galois hypotheses.

In particular, arbitrary non-Galois etale D -> X is not covered by
the argument. Its Galois closure may have p-rank greater than one even
when D has p-rank one; no bound of p-1 for the closure's Tango set has
been established here. Nor does a cover of p-power degree automatically
have p-group Galois closure. The higher-p-rank p-group descent problem
is also not resolved by this note.

## 6. Distinct maximal lines can coexist

The cardinal bound is not a uniqueness theorem. The following separate
construction gives higher-genus curves with at least p-1 distinct
maximal Tango structures; no p-rank or ordinarity claim is made for
these higher-genus curves.

Let E be an ordinary elliptic curve. It has exactly p geometric
Frobenius roots of O_E. For each nontrivial root L,

\[
 \operatorname{Hom}(L,F_{E*}\omega_E)=k,\qquad
 \operatorname{Hom}(L,\omega_{E^{(1)}})=H^0(E^{(1)},L^{-1})=0.
\]

Its unique adjoint embedding therefore lies in B_E^1 and is maximal.
The trivial root does not lie in B_E^1, since Cartier is nonzero on
the invariant differential of an ordinary elliptic curve. Thus
|Tan(E)|=p-1, including degree-zero maximal lines in this assertion.

Choose a degree-a line bundle A on E, a>=1, and a reduced divisor in
|A^(p+1)|. The associated cyclic cover h:D -> E of degree p+1 is smooth
and connected, with total tame ramification at its (p+1)a branch
points. Write R_red for the reduced ramification divisor; then

\[
 R_h=pR_{\rm red},\qquad
                     g(D)=1+\frac{p(p+1)a}{2}.                     \tag{111.16}
\]

If xi represents one of the elliptic maximal lines, its separable
pullback is still exact, and

\[
 \operatorname{div}(h^*\xi)
                  =p\bigl(h^*\operatorname{div}(\xi)/p+R_{\rm red}\bigr).
\]

Thus its saturated pullback is the maximal line

\[
 h^{(1)*}L\otimes
        \mathcal O_{D^{(1)}}(R_{\rm red}^{(1)})\ \subset B_D^1.
\]

These p-1 lines are distinct: pullback by h^(1) is injective on
p-torsion line bundles, since its norm composite is multiplication
by p+1. For p=5 and a=1 this gives a genus-sixteen curve with at least
four maximal Tango structures. Only the elliptic curve E was assumed
ordinary. The construction makes no assertion that D is ordinary or
has p-rank one, and the ramified map h is not a counterexample to
Theorem 111.2.
