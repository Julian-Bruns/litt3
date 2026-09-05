# The oriented Kummer model and its exact etale equality

**Status: collaborative author proof, 2026-09-05; not independently audited.**
Main agent: `/root`. Bounded proof contributions:
`gluing_cohomology_rigidity` (ambient quotient and singularities),
`canonical_trace_algebra` (actual curve lift), and
`x_elliptic_quotient_maps` (literature boundary).

## Scope and conclusion

This strengthens the fixed model in
`KUMMER_DIAGONAL_QUADRIC_MODEL_AFTER_LABEL_TRIVIALIZATION.md`.
The cyclic norm polynomial has square discriminant. Adding its square root
gives a fixed normal variety with exactly the canonical degree required by
the etale diagram, uniformly in the common-cover degree.

The equality is **not an obstruction**: after an etale refinement it is
the sum of the original etale differential identities. Moreover, orientation
alone still forgets individual hyperelliptic signs. Both limitations are
part of the theorem, not assumptions left implicit.

## 1. Setup

Let k be algebraically closed of characteristic p different from 2. Let
r be an odd prime, and retain the actual diagram from file 68.1:

\[
 V\xrightarrow{a}Y,\qquad V\xrightarrow{p_V}C\xrightarrow{c}X,
 \quad \deg p_V=r,\quad\deg a=\deg c=M,
\]

with all maps finite etale, p_V a connected cyclic torsor with generator
beta, and a beta different from a. Assume

\[
 g(X)=s+1,\qquad g(Y)=rs+1,
\]

and Y hyperelliptic, with branch set B of size q=2rs+4. Fix one branch
point P_infinity. Write D_alpha=(p_V)_*a^*P_alpha.

The square-label construction supplies a connected etale 2-power cover
q_C:C'->C of degree n, a connected cyclic etale cover
V'=V x_C C', and a morphism

\[
 \psi:C'\longrightarrow W\subset\mathbf P^{q-1},\qquad
 A=\mathcal O_{C'}(q_C^*D_\infty),\qquad \psi^*H=A.
\]

Here H=O_W(1), W is the smooth dimension-r intersection of q-r-1
diagonal quadrics, and

\[
 \omega_W=H^{q-2r-2},\quad \deg A=Mn,\quad
 \rho:W\longrightarrow\mathbf P^r=\operatorname{Sym}^r\mathbf P^1,
 \quad\rho^*O(1)=H^2.
\]

The defining square coordinates of W evaluate the binary norm polynomial.
All its roots are generically distinct. Indeed, invariance of t a under
beta would give an action of the odd-order cyclic group on the quadratic
extension k(Y)/k(t); that action must be trivial, contrary to a beta != a.
Primality of r then gives the full orbit of size r.

## 2. A fixed normal discriminant cover

Let Disc be the universal binary degree-r discriminant. Its degree in
the coefficients is 2r-2. Therefore

\[
 \Delta=\rho^*\operatorname{Disc}\in H^0(W,H^{4r-4}).
\]

Define

\[
 \pi:\widetilde W=
 \operatorname{Spec}_W\bigl(O_W\oplus H^{-(2r-2)}\bigr)\longrightarrow W,
 \qquad w^2=\Delta.                                      \tag{107.1}
\]

### Theorem 107.1

The variety tilde W is integral, normal, and Gorenstein, and

\[
 \boxed{\ \omega_{\widetilde W}=\pi^*H^{2rs}.\ }         \tag{107.2}
\]

There is no normalization/conductor correction to this formula.

### Proof

In characteristic different from two the discriminant hypersurface is
generically reduced: at a binary form with one double root and all other
roots simple, its transverse local parameter is the square of the
difference of the colliding ordered roots. Its generic point is on none
of the evaluation hyperplanes. The Kummer map rho is etale there.
Consequently the pullback discriminant divisor on W is nonempty and
reduced. In particular Delta is not a square in k(W).

The double cover (107.1) is thus integral. It is a hypersurface over the
regular W, hence satisfies S2, and a reduced branch divisor makes it
regular in codimension one. Serre's criterion proves normality. The
double-cover dualizing formula gives

\[
 \omega_{\widetilde W}
 =\pi^*(\omega_W\otimes H^{2r-2})
 =\pi^*H^{q-4}=\pi^*H^{2rs}.
\]

This also proves the Gorenstein assertion. No resolution formula is being
inferred. QED.

## 3. Exact quotient by a product of curves

Let T be the full Kummer curve for the same branch evaluations, i.e. the
dimension-one version of W, and put

\[
 G=(\mu_2)^q/\mu_2,\qquad H_T=O_T(1).
\]

Then T->P1 has group G and degree 2^(q-1),

\[
 \pi_T^*O_{\mathbf P^1}(1)=H_T^2,
 \qquad\omega_T=H_T^{q-4}=H_T^{2rs}.
\]

The product-of-signs character chi:G->mu_2 is well-defined because q is
even. It is nontrivial on every branch inertia group. Its quotient curve
is Y. With J=ker chi, the map T->Y is a J-torsor and is finite etale:
the order-two inertia maps injectively to G/J at every branch value.

Put G_0=ker(G^r -> G), where the arrow multiplies coordinates.

### Theorem 107.2

There are exact normal quotient descriptions

\[
 W=T^r/(G_0\rtimes S_r),\qquad
 \widetilde W=T^r/(G_0\rtimes A_r).                       \tag{107.3}
\]

The quotient map T^r->tilde W is etale in codimension one. If p>r,
tilde W has canonical singularities. In particular this applies to the
current r=3, p=5 case.

### Proof

Use homogeneous square-root coordinates z_alpha on T. On T^r the products

\[
                         X_\alpha=\prod_{i=1}^r z_{\alpha,i}
\]

are sections of the exterior product of H_T. They have no common zero:
each factor contributes at most one vanishing label, and r<q. Their
squares evaluate the product binary form, giving a morphism Phi:T^r->W
with Phi^*H=boxtimes H_T. The composite to Sym^r P1 is finite of degree
|G|^r r!, so Phi is finite of degree |G|^(r-1)r!.

Phi is invariant under G_0 semidirect S_r, whose order is precisely that
degree. Its invariant field is therefore k(W), proving the first normal
quotient identity. The intermediate alternating quotient adjoins the
Vandermonde, the square root of Disc. Normality in Theorem 107.1 gives
the second identity, including over the boundary.

For an element (g_i,sigma) of G_0 semidirect A_r, a nonidentity permutation
sigma has at most r-2 cycles, so its fixed locus has codimension at least
two. If sigma=1, a divisorial fixed locus would require exactly one
nonidentity g_i. The product-one condition excludes this. Thus the finite
quotient is etale in codimension one.

For p>r its group is prime to p. Here is the tame discrepancy argument.
Extend a divisorial valuation E over tilde W to F over the smooth T^r,
with ramification index e. The codimension-one canonical identity and
tame different formula on extracted models give

\[
 a(F,T^r)+1=e\bigl(a(E,\widetilde W)+1\bigr).
\]

The left side is positive, while a(E,tilde W) is integral because its
canonical bundle is Cartier. Hence a(E,tilde W)>=0. This assertion is
not extended here to p<=r. QED.

## 4. The actual cyclic diagram lifts, including at collisions

### Theorem 107.3

The original psi lifts to a morphism psi_or:C'->tilde W, with no further
base change. Moreover

\[
 \boxed{\ \psi_{\rm or}^*\omega_{\widetilde W}
           =A^{2rs}\simeq\omega_{C'}^{\otimes r}.\ }      \tag{107.4}
\]

### Proof

Write a':V'->Y and p':V'->C'. The line bundle
L=a'^*O_Y(2P_infinity) has norm A^2. Etale locally split p' and write
the r hyperelliptic coordinate pairs as (u_i,v_i), sections of L_i.
The Vandermonde

\[
                  d=\prod_{i<j}(u_iv_j-u_jv_i)
\]

is a section of (tensor_i L_i)^(r-1)=A^(2r-2). Changing a cyclic
ordering multiplies it by the sign of an r-cycle, namely +1. It thus
descends to C', and d^2=psi^*Delta after the harmless fixed discriminant
normalization. Sending w to d defines the lift to (107.1).

The homogeneous formula also works at infinity and at collisions. After
formal splitting its vanishing order is the sum of the vanishing orders
of the displayed pairwise determinants. Such collisions are not
ramification of the etale map p'.

For (107.4), take norms in the ACTUAL differential identifications

\[
 a'^*\omega_Y\simeq\omega_{V'}\simeq p'^*\omega_{C'}.
\]

Since omega_Y=O_Y(2rs P_infinity), their norms are A^(2rs) and
omega_C'^r. Combine with (107.2). QED.

Already on C, the same argument says that
omega_C tensor O_C(-2sD_infinity) is r-torsion. Killing this torsion
by an r-power base change is NOT asserted to preserve connectedness of
V/C: it may split the cyclic torsor. The 2-power refinements below do
preserve it.

### Theorem 107.4 (an ordered etale refinement)

There is a connected finite etale 2-power cover C''->C', of degree at
most |J|^r, for which

\[
 U_0=V'\times_{C'}C''
\]

is connected and cyclic etale of degree r over C'', and the r conjugate
maps to Y lift equivariantly to finite etale maps f_i:U_0->T. In
particular C''->X remains finite etale. Their ordered map F:U_0->T^r
satisfies

\[
                    F^*\Omega^1_{T^r}
                    \simeq\omega_{U_0}^{\oplus r}.       \tag{107.5}
\]

### Proof

Over V', form the product U of the r pulled-back J-torsors associated
with a' beta^i. Cyclic rotation lifts beta to an order-r action on U.
The number of connected components of U is a power of two. Since r is
an odd prime, at least one component U_0 is stable under this action.
Its quotient C''=U_0/C_r is connected, and equivariant etale descent gives
C''->C' finite etale and U_0=V' x_C' C''. The degree is a power of two
and is bounded by the degree |J|^r of U/V'.

The coordinate lifts U_0->T have etale composites to Y. Since T->Y
is etale, the lifts are etale as well. Taking the direct sum of their
differential isomorphisms proves (107.5). All maps to X in this argument
are the original ones followed by etale base change. QED.

## 5. Orientation does not retain every sign

For r=3, A_3=C_3, so orientation recovers the cyclic ordering of the
three distinct t-roots. It does not recover the individual Y-points.
Indeed G_0 can change an even number of their hyperelliptic signs.

Put J_0=ker(J^r -> J). The fixed variety

\[
                 R=T^r/(J_0\rtimes C_r)                 \tag{107.6}
\]

maps to both Y^r/C_r and tilde W. Its degree over tilde W is

\[
                      2^{r-1}[A_r:C_r].                 \tag{107.7}
\]

For r=3 this is four. It is not asserted to be Galois.

The actual diagram supplies a compatible map C'->R. To see this
generically, choose T-lifts of the cyclic tuple of Y-points. The norm
labels determine their product G-coordinate; the product-of-signs
compatibility is exactly the norm of the hyperelliptic square-root
coordinate. Choose the permitted signs of s_alpha compatibly with that
norm. The choices of lifts with fixed product then differ by J_0;
cyclic relabeling accounts for C_r. This gives the generic R-point.
Properness extends it over the smooth curve C'. Equivalently, use the
etale refinement in Theorem 107.4 and descend its ordered tuple with
these norm labels. A residual product discrepancy in J can be corrected
by applying the same element to every factor: r is odd, so this changes
the product by that element and leaves all Y-maps unchanged.

Thus an arbitrary curve in tilde W cannot be substituted for the
original diagram. Even membership in R alone does not impose the
individual etaleness conditions or the map C'->X.

## 6. Why the exact threshold is not yet a contradiction

In the current r=3,s=8 case, K_W=44H. The discriminant has class 8H,
so its double cover has K=48H. Equation (107.4) gives exactly

\[
                    48\deg A=3(2g(C')-2).
\]

After the actual product lift, (107.5) shows that this equality is
automatic. Canonical positivity alone cannot make it strict. Nor do
canonical singularities alone imply a degree inequality for curves
lying in exceptional divisors of a resolution.

There is a precise literature warning against generic equality rigidity:
Autissier--Chambert-Loir--Gasbarri construct growing-genus, Zariski-dense
equality families in powers of Shimura curves, using distinct finite
etale maps. Their Theorem 3 and Section 9 show that equality need not
force a graph. Their setting is characteristic zero, not an exclusion
or a realization theorem for our fixed characteristic-five targets.
[Primary paper](https://arxiv.org/html/1003.3804v3).

The reusable gain is an exact fixed quotient model retaining orientation,
an explicit additional sign refinement, and a bounded etale ordered lift.
A future obstruction must use additional information, especially the
map to the fixed X, cyclic/sign equivariance, or the prescribed local
behavior. It cannot come solely from the canonical-degree equality.
