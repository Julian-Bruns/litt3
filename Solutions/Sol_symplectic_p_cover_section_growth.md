# Proof: the first unipotent layer and its alternating cup form

[Statement](../Theorems/Thm_symplectic_p_cover_section_growth.md).
Author /root,2026-09-10. Sections1--7 retain author-proof status.
Version4 adds Section8, distinguishing constant defect from unbounded
Frobenius nilpotence and retaining the actual two-map obstruction.
That NEW section has focused medium audit PASS /root/audit_simple_zero_towers:
actual semilinear Fitting, twisted theta and two-leg trace transfer checked.
No inherited-input or whole-statement audit or Lean verification is claimed.

## 1. A cyclic p-cover cannot preserve an odd number of sections

For a connected cyclic p-cover U->C, the regular function representation
has a two-dimensional subrepresentation: constants and an additive
coordinate on Fp. It descends to a rank-two subbundle F2 of h_*O_U,
with an exact sequence

    0 -> O_C -> F2 -> O_C -> 0.

Let alpha in H1(C,O_C) be its extension class. Tensoring by E gives
the connecting map alpha cup - : H0(E)->H1(E).

The omega-valued symplectic form identifies H1(E) with H0(E)^dual by
Serre duality. Under this identification the connecting map is the
alternating bilinear form

    (s,t) -> trace_H1(omega)(alpha cup <s,t>).

The assertion follows directly by multiplying a Cech representative
for alpha by s and then applying the bundle pairing with t. In odd
dimension an alternating form has nonzero kernel. Therefore if r is
odd, the long exact cohomology sequence gives

    h0(E tensor F2)=r+dim ker(alpha cup -)>=r+1.

The inclusion F2->h_*O_U and the projection formula give the same
lower bound for h0(U,h*E). No trace divided by p is involved.

For a non-Galois cover T->C with p-group Galois closure L->C, write
P=Gal(L/C), H=Gal(L/T). Since H is proper, it is contained in a maximal
subgroup M of P, normal of index p. The ACTUAL intermediate cover
U=L/M gives T->U->C. Apply the cyclic assertion, then section pullback.

If r=0, a nonzero section on T would pull back to L. Every nonzero
representation of a finite p-group in characteristic p has nonzero
invariants. Galois descent would then produce a nonzero section on C.
Thus zero stays zero under these covers. No assertion is made for
p-power degree without the Galois-closure hypothesis.

## 2. The first socle layer for an arbitrary p-group

For a Galois cover with group P, view the regular representation as
functions P->k. Let F be its subspace of functions

    x -> c+lambda(x), c in k, lambda in Hom(P,k_add).

The homomorphism space has k-dimension d(P). Translation changes
lambda(x) by a constant, so F is stable and fits in

    0 -> k -> F -> k^d(P) -> 0

with trivial outer actions. It gives a subbundle F_C of h_*O_T,
and an extension of O_C^d(P) by O_C. Write alpha_1,...,alpha_d for
its extension classes. For r=1, EACH cup map alpha_i cup - is zero:
an alternating form on the one-dimensional H0(E) is identically zero.
The entire connecting map H0(E)^d -> H1(E) therefore vanishes. Hence

    h0(E tensor F_C)=1+d(P),

which proves the claimed bound after inclusion in h_*h*E.
Equivalently F is the first two socle layers of the function regular
module, dual to k[P]/I^2. This description is not needed to assume any
unproved freeness or commutativity of a group-ring cokernel.

## 3. Source defect one and actual deck groups

If h0(T,h*E)=1, section injectivity makes r either zero or one. The
zero case is impossible for a p-group-closure cover by Section1, and
the one case would force at least two sections. Thus no nontrivial
such cover has source dimension one.

Now let h:T->C be ANY connected finite etale cover with source dimension
one. If p divided |Deck(T/C)|, Cauchy's theorem would supply a subgroup
H of order p. Cover automorphisms act freely, so T->T/H is a connected
finite etale cyclic p-cover. The bundle h*E descends to T/H as the
pullback of E from C; it still has a perfect canonical-valued alternating
pairing. The preceding contradiction applies. Therefore the actual
deck group has order prime to p. The Galois closure is not substituted
for T in this assertion.

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
[tangent_bundle_cyclic_refinements](Sol_tangent_bundle_cyclic_refinements.md).
Their section dimensions are the respective actual connection defects.

The calculation is genus-independent. The genus-two no-theta
classification is not used. In particular the explanation of odd-defect
growth does not require another theta or high-degree cover computation.

## 6. The whole Galois one-defect branch over the selected genus-two family

For Y_t with parameter degree>828, all active connections are ordinary
on the endpoint, by [genus_two_active_twists](Sol_genus_two_active_twists.md).
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
Together with Section6, it shows that the ordinary-X and simple-zero
assumptions of the new Pro question retain the entire Galois Y-leg
one-defect branch over the selected high-degree family. They do not
settle its mixed residue, nor cover arbitrary non-Galois one-defect legs.

## 8. A small defect can hide arbitrarily deep Frobenius nilpotence

### 8.1 The abstract simple-zero calculation is on actual cohomology

Suppose dim ker(Psi_C)=1 and rank(Psi_C^2)=rank(Psi_C), and let
h_n:C_n->C be an actual cyclic5^n etale tower. Set q=5^n,
R=k[e]/(e^q), e=deck-1, and D=dim H1(C,T_C). The audited
[p-cover theorem](Sol_etale_p_witt_obstruction.md) identifies
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
[the abelian node proof, Section1](Sol_abelian_p_defect_node.md) gives

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

The argument in [proper theta, Section6](Sol_genus_two_active_theta.md)
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
preserves zero defect by Section1. Section6 already gives a simple
Psi zero on C_L. Section8.1 now proves ALL cyclic-tower formulas on
C_(L,n)=C_L times_Y Y_n, with the same ell=2 or4 at every level.

### 8.3 What this does to the actual mixed obstruction

Consider an actual jointly minimal coreless span with selected Y,
Galois Y-leg, matching admissible active connections and source defect1.
Sections3,4,6,7 give a factorization Z->C_L->Y with Z->C_L of degree
prime to5, a simple zero on Z, and ordinary X and Y endpoints.
For any one of the chosen cyclic towers, Z_n=Z times_Y Y_n is connected
because deg(Z/Y) is prime to5. It remains an actual common source for
BOTH original endpoints, although it need not remain jointly minimal.

Write q_n:Z_n->C_(L,n). The trace projector (1/deg q_n)q_n^*q_(n*)
commutes with Psi and splits off the pulled-back cohomology. Applying
the Fitting argument of Section8.1 separately to the cyclic covers
Z_n->Z and C_(L,n)->C_L shows that BOTH nilpotent summands have
k-dimension5^n. Their pullback is injective and split, so it is an
isomorphism on these nilpotent summands. The other summand is bijective.
Thus the source defect on Z_n is also ell, and its full rank formula
is(8) with D=dim H1(Z,T_Z).

Let delta be a NONZERO actual difference of the two canonical source
W3 lifts on Z, if one exists. The forced-canonical-endpoint theorem
puts it in ker Psi_Z. Both individually existing source lifts pull
back along Z_n->Z; their actual difference is delta_n=h_n^*delta.
It remains nonzero by negative-H1 pullback injectivity, and (9) gives

    delta_n in im(Psi_(Z_n)^j) iff j<=floor((5^n-1)/ell).

In particular the Serre residue against EVERY covector annihilating
im Psi_(Z_n) vanishes once n>=1, even though delta_n is nonzero.
For each FIXED j, one can make it belong to im(Psi^j) by refinement.
It NEVER belongs to the stable image at any finite stage. These two
orders of quantifiers must not be exchanged.

The original two-map deformation functor is unchanged by these common
etale refinements. Hence no actual obstruction has been repaired.
This describes how a hypothetical obstruction is hidden by such tests;
it does not assert that delta!=0 can occur or decide the new Pro target.
