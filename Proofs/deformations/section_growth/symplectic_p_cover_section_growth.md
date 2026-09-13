# Proof: the first unipotent layer and its alternating cup form

[Statement](../../../Theorems/deformations/section_growth/symplectic_p_cover_section_growth.md).

## 1. The first socle layer and its section count

Let h:T->C be a connected finite etale Galois cover with nontrivial
p-group P, and put d=dim_Fp Hom(P,Fp). In the regular representation
of functions P->k, the subspace

    F={x -> c+lambda(x): c in k, lambda in Hom(P,k_add)}

is translation-stable: translating lambda adds a constant. Thus
0->k->F->k^d->0, with trivial outer actions, descends to

    0 -> O_C -> F_C -> O_C^d -> 0,     F_C subset h_*O_T.

Write alpha_i in H1(O_C) for the extension classes and V=H0(E),
r=dim V. The pairing E tensor E->omega_C identifies H1(E)=V^dual.
Under this identification, alpha_i cup - is the alternating form

    B_i(s,t)=trace_H1(omega)(alpha_i cup <s,t>).

This follows by multiplying a Cech representative of alpha_i by s
and pairing with t. The connecting map V^d->V^dual is sum_i B_i;
its transpose has kernel R=intersection_i rad(B_i). Therefore

    h0(E tensor F_C)=r+rd-rank(sum_i B_i)=rd+dim R.        (S)

Inclusion in h_*h*E gives the same lower bound upstairs. No division
by p or freeness assertion for a group-ring cokernel is used.

## 2. Growth and preservation under p-group covers

For cyclic p-covers, d=1 and (S) reads r+dim rad(B_1). An alternating
form in odd dimension is singular, so an odd r grows by at least one.
If r=1, every B_i vanishes and (S) gives 1+d for any p-group P.
More generally, if a nontrivial P-cover preserves r>0 sections, then
rd+dim R<=r forces d=1 and R=0. The Burnside basis theorem makes P
cyclic, and nondegeneracy of B_1 makes r even.

For a non-Galois cover T->C with p-group Galois closure L->C, write
P=Gal(L/C), H=Gal(L/T). A maximal subgroup M containing H is normal
of index p. The actual intermediate U=L/M gives T->U->C; the cyclic
bound on U and section pullback prove odd growth on T.

Zero remains zero under these covers. Otherwise sections would pull
back to a nonzero P-module on L, which has nonzero invariants in
characteristic p. Galois descent would give a section on C. This
argument needs the p-group closure, not merely p-power degree.

## 3. Section dimension bounds actual deck p-subgroups

Let h:T->C be any connected finite etale cover and let
m=h0(T,h*E)>0. For a nontrivial p-subgroup P of Deck(T/C), the free
action gives an actual etale quotient T->T/P. The bundle descends
from C, with its canonical-valued alternating pairing. Its downstairs
section dimension is r=dim H0(T,h*E)^P>=1. Formula(S) gives

    m>=1+d(P) if r=1;
    m>=r d(P)>=2d(P)>=1+d(P) if r>=2.

Thus every such P satisfies d(P)<=m-1. In particular m=1 excludes
p-torsion in the deck group, and m=2 forces every p-subgroup to be
cyclic. These are statements about the original source's deck group.
The stronger p-group-closure prohibition when m=1 follows from
Section2: downstairs r is either zero or one, and both are impossible.

## 4. The character must be quadratic

Suppose h is Galois and h0(C,E)=0, h0(T,h*E)=1. Its deck group G acts
on the unique section by a character chi:G->k*. The character is
nontrivial by Galois descent. The corresponding torsion character line
L on C satisfies h0(E tensor L)=1. Since E^dual tensor omega=E and
chi(C,E tensor L)=0, Serre duality and Riemann--Roch give

              h0(E tensor L^-1)=h0(E tensor L)=1.

Pulling these two spaces to T gives section characters chi and chi^-1.
The total section space is one-dimensional, so chi=chi^-1. Its order
is exactly two. The quotient T/ker chi is the asserted distinguished
double. Sections cannot decrease on passing upward from it to T,
so its section dimension is also one. The prime-to-p assertion follows
from Section3. No classification of general finite groups is used.

## 5. Why the actual tangent bundles have the required pairing

In characteristic five, the dormant tangent bundle V_d is the Cartier
descent of the scalar jet system for quadratic coefficients. On a
coordinate change u=u(t), with a=du/dt, its jet transition is

    [[a^2,0],[2aa',a^3]],

with determinant a^5. The scalar connection has zero trace, and these
determinant transitions are horizontal. Cartier descent therefore gives
det V_d=omega_(C^(1)), not just equality after Frobenius pullback or of
degrees. Wedge product supplies its perfect alternating pairing.

For an admissible active connection, E_r=pi_*V_(pi*r+q) on Frobenius
twists, where pi is its actual canonical etale double, split or not.
Wedge product upstairs followed by the finite-etale trace gives

    E_r tensor E_r -> pi_*omega_(C_s^(1)) -> omega_(C^(1)).

It is perfect and alternating. This can be checked etale-locally, where
the double splits and the form is the direct sum of the two rank-two
wedge forms. Both tangent-bundle constructions commute with the actual
finite etale maps, as proved in
[tangent_bundle_cyclic_refinements](../../projective_connections/tangent_bundle_cyclic_refinements.md).
Their section dimensions are the respective actual connection defects.

## 6. The whole Galois one-defect branch over the selected genus-two family

For Y_t with parameter degree>9, all active connections are ordinary
on the endpoint, by [genus_two_active_twists](../../projective_connections/genus_two_active_twists.md).
Section4 forces a source-defect-one Galois cover through a bad double
in that theorem's complete table. There are only two choices for each
of its five exceptional connections; the other80 have none.

On every such double C_L, the three-dimensional invariant Psi block
is the bijective endpoint block. Its anti-invariant Cartier-dual block
is an invertible2x2 block plus one identically zero scalar. Hence
Psi_(C_L) has a bijective five-dimensional part plus a zero line.
This uses the actual block decomposition proved in the cited table,
not just its numerical corank.

Let q:T->C_L be the remaining Galois cover. Its degree is prime to5
by Section3. The trace projector

                      (1/deg q) q* q_*

on H1(T,T_T) splits off q*H1(C_L,T_(C_L)). It commutes with the
semilinear Psi: the maps are etale, its coefficient quartic pulls back,
trace commutes with Frobenius, and 1/deg q belongs to F5. The complement
therefore is Psi-stable. Source and intermediate kernel dimensions are
both one, so the complement has zero kernel and Psi is bijective there.
This proves rank(Psi_T²)=rank(Psi_T), without a degree bound on q.

This last application uses the previously proved high-degree table;
the abstract growth and character results do not depend on that table.

## 7. Strict growth across the opposite Galois leg of a coreless span

Let s_i=E(r_i)/3 be the normalized common square-Hasse quartics. The
scalar model gives C_3(s_i^4)=s_i. Put

    U_i=ker[C_1(s_i -):H0(omega_i^2)->H0(omega_i^2)].

The dimension of U_i is the actual indigenous defect, by the dual
infinitesimal Verschiebung identification. All these spaces pull back
compatibly under the actual etale maps; no arbitrary kernel of a chosen
bundle operator is substituted.

Suppose G=Gal(Z/Y) and d_Z=d_X>0. A pulled-back basis phi_1,...,phi_d
of U_X is then a basis of U_Z. G preserves this space and s_Z. Hence
the finite-dimensional space spanned by

                        phi_i phi_j / s_Z

is G-stable and lies in the embedded k(X). For any element w of it,
the polynomial product_(gamma in G)(T-gamma(w)) has coefficients in
BOTH k(X) and k(Y). Corelessness makes all coefficients constant.
Since k is algebraically closed, w itself is constant. In particular
phi_i^2/s_Z is a nonzero constant. Rescale phi_i so that phi_i^2=s_Z.
The twisted Cartier projection formula now gives

    s_Z=C_3(s_Z^4)=C_3(phi_i^8)=phi_i C_1(phi_i^3).

Thus C_1(s_Z phi_i)=phi_i!=0, contrary to phi_i in U_Z. This proves
d_Z>d_X whenever d_X>0. The Galois group used is the ACTUAL Y-leg
group; no simultaneous normal closure or unrelated cover is invoked.

For source defect one, d_X<=1 by section pullback, so this forces d_X=0.
Together with Section6, it gives an ordinary X endpoint and a simple
zero on every such Galois one-defect source. The later
[defect-preserving descent theorem](../defect_preserving_etale_descent.md)
excludes this branch for the selected main pair.

## 8. A small defect can hide arbitrarily deep Frobenius nilpotence

### 8.1 The abstract simple-zero calculation is on actual cohomology

Suppose dim ker(Psi_C)=1 and rank(Psi_C^2)=rank(Psi_C), and let
h_n:C_n->C be an actual cyclic5^n etale tower. Set q=5^n,
R=k[e]/(e^q), e=deck-1, and D=dim H1(C,T_C). The audited
[p-cover theorem](../etale_p_witt_obstruction.md) identifies
V_n=H1(C_n,T_(C_n)) with a free R-module of rank D. Psi_n is
semilinear for sigma:R->R which takes coefficients to fifth powers
and FIXES e. It is not the ring map sending e to e^5. Reduction modulo
e, identified with invariant vectors by the norm, is the actual Psi_C.

Take the Fitting decomposition of Psi_n as a semilinear endomorphism
of the finite-dimensional k-space V_n. Its bijective and nilpotent
parts are R-stable: sigma is an automorphism and fixes e. They are
direct summands of a free module over the local Artin ring R, hence
free. The bijective part stays bijective modulo e; the nilpotent part
stays nilpotent. By the simple-zero hypothesis downstairs, their R
ranks are D-1 and1 respectively.

In an R-basis of the latter line, Psi_n is a_n(e)*sigma, where
a_n has e-order l_n (take l_n=q if a_n=0). Therefore

    dim ker Psi_n=l_n,
    rank Psi_n^j=(D-1)q+max(q-j*l_n,0).                    (10)

Indeed the coefficient of the jth iterate is
a_n*sigma(a_n)*...*sigma^(j-1)(a_n), with e-order j*l_n until
it vanishes. This uses a Fitting decomposition of the OPERATOR, not
independent row and column changes that would fail to control its powers.

The norm/base-change identity from
[the abelian node proof, Section1](../abelian_covers/abelian_p_defect_node.md) gives

    coker Psi_1 = k[e]/(e^5) tensor_R coker Psi_n.

The nilpotent line gives coker Psi_n=R/(e^(l_n)). If the first-cover
defect is ell<5, it follows that min(l_n,5)=ell and hence l_n=ell.
This proves(8) at every level without a higher-degree computation.

Pullback identifies V_C with V_n^(deck), which in a regular module
is e^(q-1)V_n. Its kernel line lies in the nilpotent rank-one summand,
so every nonzero pulled-back kernel vector is a nonzero multiple of
e^(q-1) times its generator. The image of Psi_n^j in this summand is
e^(j*ell)R, or zero. This proves(9), including the failure of membership
at the next power. Negative-H1 pullback is injective.

Every connected cyclic5 cover can be extended to a nested cyclic5^n
tower. One elementary justification is the exact sequence
0->Z/5->Z/5^(n+1)->Z/5^n->0 and H2_et(C,Z/5)=0. The latter is
[Stacks59.63.5](https://stacks.math.columbia.edu/tag/0A3J): it follows
from Artin--Schreier, coherent H2(O)=0, and surjectivity of F-1 on
H1(O) over an algebraically closed field. The same source's Lemma59.63.2
proves this surjectivity directly for every finite-dimensional
Frobenius-semilinear vector space.
A lift of a surjective cyclic character is still surjective because
its reduction modulo5 is nonzero. Only existence of the tower is used.

### 8.2 At least two such directions for every relevant bad double

On selected Y=Y_t, let r be one of the five exceptional ordinary active
connections and L one of its two bad two-torsion twists. Put F=E_r tensor L.
Then F is stable, omega-valued symplectic, h0(F)=h1(F)=1, has proper
theta, and is unchanged by tensoring with the nonzero canonical-double
line kappa. These facts follow respectively from the active-bundle
theorem, L^2=O, the exact bad-twist table, translation of the proper
theta divisor, and E_r tensor kappa=E_r. In these cases kappa is
nontrivial; no genus-three base-point classification is invoked.

The argument in [proper theta, Section6](../../projective_connections/genus_two_active_theta.md)
applies to THIS F as a bundle: even theta follows from its symplectic
form, and multiplicity>=5 would be even and hence at least6. Intersect
with the reduced [2]Theta curve through the origin, whose six branches
give intersection at least36, larger than32. Containment would force
equality of the two divisors and a free kappa-involution of a genus-two
normalization. Thus the multiplicity is at most4. This is a stated
extension of the earlier argument to an order-two twist, not an assertion
that F itself is the tangent bundle of another connection.

Among the six tangent directions of mu5 subgroups in the ordinary
Jacobian of Y, at least two avoid this nonzero initial term. The exact
nonreduced character-family calculation in that same proof gives,
for each corresponding connected cyclic5 cover Y_1->Y,

    ell=h0(Y_1,E_(r_1) tensor L_1)<5.

In fact ell is2 or4. In a formal coordinate on mu5 in which inversion
is e->-e (for example u-u^-1 with u^5=1), an invariant trivialization
makes the theta equation even. Its nonzero order below5 is positive
and even. The single-entry minimal cohomology complex gives that order
as ell, retaining the whole length-five subgroup scheme.

Let C_L->Y be the bad double and C_(L,1)=C_L times_Y Y_1. It is
connected, since degrees2 and5 are coprime. The character decomposition
for its double map to Y_1 gives

    defect(C_(L,1))=h0(Y_1,E_(r_1))+h0(Y_1,E_(r_1) tensor L_1)=ell.

The first term is zero: r is ordinary on Y and the cyclic5 cover
preserves zero defect by Section2. Section6 already gives a simple
Psi zero on C_L. Section8.1 now proves ALL cyclic-tower formulas on
C_(L,n)=C_L times_Y Y_n, with the same ell=2 or4 at every level.

### 8.3 Trace transfer and two-leg obstructions

Let q:Z->C be connected finite etale of degree prime to5, with the
active connection pulled back from C. Suppose C has a simple Psi zero
and both C and Z have defect one. The normalized trace projector
commutes with Psi. Its complement has zero kernel and is bijective,
so Z also has a simple zero.

For any cyclic tower C_n->C in Section8.1, the source Z_n=Z times_C C_n
is connected by coprimality. Apply the Fitting argument separately to
C_n->C and Z_n->Z. Their nilpotent summands both have dimension5^n;
pullback between them is injective and trace-split, hence an isomorphism.
All other summands are bijective. Thus Z_n has the same defect ell and
rank formula(10), with D=dim H1(Z,T_Z).

This applies in particular to the bad-double towers of Section8.2
and any prime-to5 defect-preserving Z->C_L. If Z also has two actual
etale maps to endpoints, all refinements retain those maps. A nonzero
v in ker Psi_Z stays nonzero upstairs and satisfies

    h_n^*v in im(Psi_(Z_n)^j) iff j*ell<=5^n-1.

For any fixed j it eventually lies in that image, but it never lies
in the stable image at any finite level. In particular first-image
Serre residues vanish after the first refinement while v survives.

An actual difference delta of the two canonical W3 source lifts, when
nonzero and in ker Psi_Z, obeys this rule. Ordinary endpoints put the
difference in that kernel by
[forced canonical lifting](../forced_canonical_witt_endpoint.md).
Common etale refinement preserves the original two-map deformation
functor, so this vanishing of residues does not repair nonliftability.
The argument supplies no example realizing such a nonzero delta.
