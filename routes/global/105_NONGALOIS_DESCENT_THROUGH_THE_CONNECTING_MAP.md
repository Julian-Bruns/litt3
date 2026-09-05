# Non-Galois descent through the connecting map

**Status: independently audited PASS, 2026-09-05.**

Auditor: `/root/gluing_cohomology_rigidity`. No breaking issues; one
optional clarification concerns finite flatness in the normalized
fiber-product integrality step. File 103 was an input, not re-audited.
[Audit record](audits/105_NONGALOIS_DESCENT_THROUGH_THE_CONNECTING_MAP_AUDIT.md).

This is the main-agent continuation of the three-route comparison. It
extends the coefficient-map argument in file 103 without assuming
a Galois coefficient map. After the PASS audit, the intermediate
symmetry-lifting special case (formerly file 104) was incorporated below
as a direct consequence and its separate file removed.

The result is an exact descent square, not a contradiction by minimality.
The descended source covers X etale; its other map is to a quotient D
of Y. The original Y is retained in the integral normalized fiber
product reconstructing Z. In particular this note does not repeat the
invalid step warned against in `MINIMAL_COMMON_COVER_AND_INCIDENCE_DESCENT.md`.

## 1. Setup

Let X,Y be smooth projective connected curves over an algebraically closed
field. Let Gamma be an integral divisor in S=X x Y, dominating both
factors, with

\[
                     \mathcal O_S(\Gamma)=A\boxtimes B.
\]

Let P,Q be positive-degree line bundles on X,Y, and suppose there is a
unit of (P boxtimes Q^{-1})|Gamma. Put

\[
                         L_X=PA^{-1},\qquad L_Y=QB^{-1}.
\]

Assume deg L_X>0 and deg L_Y>0. The inverse unit supplies the tensor

\[
 \delta_Y\in H^1(X,P^{-1}A^{-1})\otimes H^0(Y,L_Y).
                                                        \tag{105.1}
\]

Its coefficient span U_Y generates L_Y by Theorem 103.1. Let

\[
 \rho_Y:Y\longrightarrow\mathbf P(U_Y^*),\qquad
 q:Y\longrightarrow D
\]

be this coefficient morphism and its factorization through the smooth
normalization D of its image. Write rho_0:D->P(U_Y^*) for the remaining
map, and L_0=rho_0^*O(1). Thus

\[
 L_Y=q^*L_0,
 \qquad U_Y\subset q^*H^0(D,L_0).
                                                        \tag{105.2}
\]

The map q is finite and nonconstant. Separability is not assumed.

## 2. The section forces descent of the entire divisor

### Theorem 105.1

There is a line bundle T on D such that

\[
 Q\simeq q^*T^{-1},\qquad
 B\simeq q^*(L_0^{-1}T^{-1}).                          \tag{105.3}
\]

There is an integral divisor

\[
 \Gamma_0\in|A\boxtimes(L_0^{-1}T^{-1})|
                   \quad\text{on }X\times D
\]

with the exact scheme-theoretic identity

\[
                  \Gamma=(1\times q)^*\Gamma_0.
                                                        \tag{105.4}
\]

In particular the original divisor-family map

\[
 Y\longrightarrow\mathbf P(H^0(X,A)),\qquad
 y\longmapsto[F|_{X\times\{y\}}]
\]

factors through q. A projective-space convention dualizing the displayed
space does not change this factorization assertion.

#### Proof

The tensor (105.1) descends, using (105.2), to

\[
 \delta_0\in H^1(X,P^{-1}A^{-1})\otimes H^0(D,L_0).
\]

Construct on X x D the rank-two extension

\[
 0\longrightarrow P^{-1}\boxtimes\mathcal O_D
 \longrightarrow E_0
 \longrightarrow A\boxtimes L_0^{-1}
 \longrightarrow0                                    \tag{105.5}
\]

with class delta_0, with the sign adjusted to the connecting-map
convention. This is the full relevant extension space by Kunneth,
since H^0(X,P^{-1}A^{-1})=0. After pullback to X x Y and tensoring by Q,
we obtain

\[
 0\longrightarrow P^{-1}\boxtimes Q
 \longrightarrow V
 \longrightarrow A\boxtimes B
 \longrightarrow0,
 \qquad V=(1\times q)^*E_0\otimes\operatorname{pr}_Y^*Q.
                                                        \tag{105.6}
\]

A defining section F of Gamma lifts to a section s of V: the obstruction
is F delta_Y, which vanishes by the restriction long exact sequence.
The connecting-class calculation in Theorem 103.2 identifies the
restriction of s on Gamma, in the kernel of (105.6), with the inverse
of the original unit, up to scalar. It is nowhere zero there. Outside
Gamma its quotient F is nonzero. Hence s is nowhere zero on X x Y.

Fix d in D and choose y over d. Restriction of s to X x {y}, followed
by a nonzero identification of the one-dimensional fiber Q_y with k,
gives a nowhere-zero section of the rank-two bundle E_{0,d} on X.
Its determinant, up to a one-dimensional constant factor, is L_X^{-1},
which has negative degree. The section therefore gives an exact sequence

\[
 0\longrightarrow\mathcal O_X\longrightarrow E_{0,d}
                    \longrightarrow\det E_{0,d}\longrightarrow0.
\]

Since H^0(X,det E_{0,d})=0, we have

\[
                    h^0(X,E_{0,d})=1\quad\text{for every }d.
                                                        \tag{105.7}
\]

Let pi:X x D->D be projection. Cohomology and base change now imply
that T=pi_*E_0 is a line bundle, its formation commutes with base
change, and the evaluation map

\[
                         \pi^*T\longrightarrow E_0
                                                        \tag{105.8}
\]

has the expected fiber evaluation maps. One may apply the usual
constant-cohomology criterion: E_0 is a vector bundle on the proper
flat family of curves, h^0 is constantly one, and h^1 is also constant
by Riemann--Roch. Every fiber's generating section is nowhere zero by
the preceding argument. Thus (105.8) is a line subbundle everywhere.

Base change and the projection formula identify s with a section of

\[
                              q^*T\otimes Q
\]

on Y. Because evaluation (105.8) is a subbundle and s has no zero,
this line-bundle section is nowhere zero. It trivializes the bundle,
giving Q=q^*T^{-1}. Combining this with L_Y=q^*L_0 gives the second
identity in (105.3).

Compose (105.8) with the quotient in (105.5). This yields a section

\[
 F_0\in H^0\bigl(X\times D,
                     A\boxtimes L_0^{-1}T^{-1}\bigr).
                                                        \tag{105.9}
\]

It is nonzero. Otherwise the subbundle pi^*T would map into
P^{-1} boxtimes O_D, but such a morphism is zero because
H^0(X,P^{-1})=0. Under the isomorphisms (105.3), the pullback of
F_0 is precisely the image F of s, up to the nonzero scalar choosing
the trivialization. This proves (105.4).

Since 1 x q is finite faithfully flat, a nonzero component or
nonreduced structure of div(F_0) would persist under pullback.
The integrality of Gamma therefore implies that Gamma_0=div(F_0)
is integral. Neither projection has a constant component, since
such a component would also persist upstairs. The asserted
factorization of the divisor-family map follows from (105.9).
\(\square\)

## 3. Both etale maps force a separable normalized descent square

### Corollary 105.2

Suppose now that the normalization Z of Gamma has both maps
f:Z->X and g:Z->Y finite etale. Let b=deg q, and let Z_0 normalize
Gamma_0. Then q is separable, as is Z_0->D. Moreover

\[
 Z\longrightarrow Z_0\longrightarrow X
\]

are finite etale of degrees b and d_X/b, respectively, and

\[
                 Z=\operatorname{Norm}(Z_0\times_D Y).
                                                        \tag{105.10}
\]

The fiber product is integral. Its normalization still has the
original etale map to the fixed Y, of degree d_Y. Also

\[
                      b\mid d_X,\qquad b\mid\deg Q.
                                                        \tag{105.11}
\]

If g(Y)>=2 and J(Y) is absolutely simple, then either b=1, or D=P^1.

#### Proof

The map Gamma->Gamma_0 is a finite flat base change of q, of degree b.
Since Gamma is integral, its generic algebra is a field. Writing
K_0=k(Z_0), L=k(Y), and E=k(D), we obtain

\[
                          k(Z)=K_0\otimes_E L
                                                        \tag{105.12}
\]

as a field of degree b over K_0. Passing to normalizations therefore
gives Z->Z_0 of degree b, and f factors through Z_0. In a factorization
of a finite etale map between smooth projective curves, both
intermediate maps are etale, by separability and transitivity of the
different. Thus Z->Z_0 and Z_0->X are etale.

The degree-preserving field base change (105.12) gives

\[
 \Omega_{k(Z)/K_0}=\Omega_{L/E}\otimes_L k(Z).
\]

The left side is zero, so q is separable. Similarly, the etale map
Z->Y shows that K_0/E is separable. Identity (105.12) also proves the
integrality and normalization statement (105.10). The first
divisibility in (105.11) follows from the etale factorization; the
second follows from Q=q^*T^{-1}.

Finally, if g(D)>0, pullback along the separable q gives a
positive-dimensional abelian subvariety of J(Y), up to finite kernel.
Absolute simplicity forces g(D)=g(Y). For b>1 this contradicts
Riemann--Hurwitz, since g(Y)>=2. Hence b>1 forces g(D)=0 and D=P^1.
\(\square\)

## 4. Covering symmetries as a direct consequence

Return to the canonical case P=omega_X^n, Q=omega_Y^n, with both maps
on Z etale and both connecting line bundles of positive degree. If
a finite subgroup G of Aut(Y) fixes rho_Y pointwise as a map, then
it acts trivially on its normalized image D. Equation (105.4) makes
Gamma invariant under 1 x G. Normalization lifts this action faithfully
to Z over X. A nonidentity automorphism of a connected etale cover
over X has no geometric fixed point. Hence

\[
 G\hookrightarrow\operatorname{Aut}_X(Z),\qquad
 |G|\mid d_X,\qquad Z\longrightarrow Z/G\longrightarrow X
\]

are the asserted free action and etale factorization. The map Z->Y
is still the original etale map and is G-equivariant. This argument
does not require the order of G to be prime to the characteristic.
The same statement holds with the two factors exchanged.

For hyperelliptic Y of genus h, rho_Y necessarily factors through
the hyperelliptic map when 0<deg L_Y<=h. Indeed, U_Y is basepoint-free;
if its morphism did not factor, a general basepoint-free pair in U_Y
could be chosen with ratio outside the hyperelliptic subfield. This
ratio and the degree-two hyperelliptic function generate k(Y), giving
a birational map to a curve of bidegrees 2 and deg L_Y in P^1 x P^1.
Its arithmetic genus is deg L_Y-1<h, a contradiction. This reasoning
also allows an inseparable second map: the generated function field
is still k(Y). Consequently the hyperelliptic involution lifts freely
over X in this range, and d_X is even.

For the current pair this range is 1<=16n-N<=8, with d_Y=N and d_X=3N.
It supplies an actual Galois degree-two factor, not a claim that the
entire X-leg is Galois. Some numerical cases in the interval are
already excluded by basepoint-freeness and gonality; the new content
is the lifted action.

This section is the direct symmetry consequence formerly recorded
separately in file 104; its general input is the audited Theorem 105.1.

## 5. Canonical gluing consequences and relation to the earlier route

For P=omega_X^n and Q=omega_Y^n, the etale degree relation implies
that deg L_X and deg L_Y vanish together or are positive together.
The zero case is handled by the equality/core theorem in file 103.
The positive case satisfies Theorem 105.1 and Corollary 105.2, giving

\[
                         b\mid\gcd(d_X,2n s_Y).
\]

In particular the connecting coefficient map is always separable in
this strict range. If the original divisor-family map Y->|A| is
birational, its factorization through q forces b=1. Thus the connecting
coefficient map must itself be birational; it cannot discard information
by an inseparable or higher-degree factor.

For a hyperelliptic Y of genus h, a basepoint-free birational linear
series has degree at least h+2. Indeed, degree at most h forces
factorization through the hyperelliptic map as in Section 4. For degree
h+1, a birational map needs at least three independent sections. A
general divisor in that birational series would then have h^0>=3,
and Riemann--Roch gives h^1>=1; equivalently it is a special moving
series. The standard hyperelliptic divisor description shows that its
moving part is a multiple of the hyperelliptic pencil, contradicting
birationality. Consequently, in the birational divisor-family case,

\[
                          2n s_Y-d_X\ge g(Y)+2.
\]

The principal structural gain is not this additive bound. It is that
the NEW connecting map is now linked, by an exact non-Galois descent,
to the OLD incidence quotient of
`MINIMAL_COMMON_COVER_AND_INCIDENCE_DESCENT.md`. The older note proves
what happens once a divisor-family factor is given; here the factor is
forced by the connecting class of the differential gluing unit.

If b>1, Z_0 is not asserted to map to the fixed Y. Only the integral
fiber product with Y reconstructs the original common cover. If b=1,
the construction gives no smaller source. Neither case alone solves
the common-cover problem or bounds arbitrarily large gluing orders.
