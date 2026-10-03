# Proof: formal-subgroup avoidance and uniform finite intersection

[Statement](../../../Theorems/jacobians/ordinary_covers/cyclic_primary_section_stabilization.md).
Write A=Pic0(C) and f for the p-rank of C. If f=0 there are no
nontrivial connected cyclic p-power covers and the assertion is vacuous.
The identity cover is bounded by h0(C,E); enlarge R so p^R exceeds it.
Assume f>0. All theta divisors below are actual determinant-of-cohomology
divisors, not just sets of rational torsion points.

## 1. The formal line attached to an actual tower

The maximal abelian pro-p quotient of the geometric etale fundamental
group of C is Z_p^f. Thus a connected cyclic cover with a chosen
identification of its deck group with Z/p^r is a primitive character
\[
\chi_r:Z_p^f\longrightarrow Z/p^r.
\]
It lifts to a surjection chi:Z_p^f->Z_p. In particular every finite
cover extends to a tower of connected covers. The set of all such
infinite characters is the compact space
\[
\mathscr X=Z_p^f\setminus pZ_p^f.
\tag{1}
\]
The Jacobian description of abelian covers gives the displayed free
pro-p quotient; equivalently, H1_et(C,Z/p^r)=(Z/p^r)^f compatibly in r.

Put Q=p^r and R_Q=k[t]/(t^Q)=k[Z/Q], with gamma=1+t. The actual
pushforward (q_r)_*O_(D_r) is an invertible O_C tensor R_Q module.
This can be checked on the split torsor: the idempotent of a single
sheet is a free R_Q generator, and changing the sheet multiplies it
by a power of gamma. Its transition functions are therefore
\[
(1+t)^{n_{ij}},
\]
where n_ij is the locally constant cocycle defining the cover.
As a line bundle P_(chi,Q) on C times Spec(R_Q), this is the
tautological character family. Its class defines a group morphism
\[
\lambda_{\chi,Q}:\mu_Q\longrightarrow A.
\tag{2}
\]
The group assertion follows either from the cocycle formula or from
tensor multiplication of the character line bundles. The same
normal-basis construction is used in the established
[cyclic symplectic proof](../../deformations/section_growth/cyclic_symplectic_blocks.md).

The reductions modulo t^(p^r) of the compatible families agree.
They define a formal group morphism
\[
\lambda_\chi:\widehat{\mathbf G}_m\longrightarrow\widehat A.
\tag{3}
\]
It is nonconstant. Its tangent map is the coherent image of the
nonzero first Artin--Schreier character. The latter is nonzero by
the Artin--Schreier sequence: F-1 is surjective on k, so
H1_et(C,F_p)->H1(C,O_C) is injective. Thus (3) even has nonzero
tangent map. No identification with an arbitrary formal curve in A
has been made: (3) is a formal SUBGROUP morphism.

## 2. The algebraic closure of a formal subgroup

Let H be the reduced Zariski closure of the image of (3). One may
define it by contracting the kernel of the map from algebraic local
functions at zero to k[[t]], then taking the closure in A. Its local
coordinate ring is a subring of a domain, so H is irreducible. It
contains zero and has positive dimension because (3) is nonconstant.

The product of the formal image with itself is Zariski dense in
H times H. Here is the elementary point needed for that statement.
If finitely many series f_i(t) are k-linearly independent, then some
finite coefficient matrix already has full column rank. Consequently
the products f_i(t)g_j(s), for independent finite lists f_i and g_j,
are k-linearly independent in k[[t,s]]. Thus the tensor product of
the two algebraic coordinate rings injects into k[[t,s]]. The same
argument applies after restricting to affine neighborhoods of zero.

The formal group law carries the product formal image into the
formal image, and formal inversion preserves it. Algebraic density
therefore implies that addition carries H times H into H and
inversion carries H into H. More explicitly this is first checked
on a dense neighborhood of (0,0); the inverse image of H under the
global addition map is closed, so the assertion holds on all H times H.
Thus H is a positive-dimensional abelian subvariety. The theta
hypothesis excludes containment of H, so the formal character is
not contained in the theta divisor of E. When A is simple, H=A
and any proper closed divisor satisfies this hypothesis.
This step concerns schematic formal containment; the fact that all
mu_Q have just one geometric point is irrelevant.

## 3. The actual sections are a finite-length formal intersection

Pull the Poincare line bundle back along (3). Formal existence on
the proper curve gives a line bundle P_chi on C over k[[t]], whose
reductions are the preceding P_(chi,Q). Equivalently, its cohomology
complex is the pullback of the Poincare cohomology complex on A.
Because chi(E)=0, the result has an equal-rank two-term free
representative
\[
\mathcal C_\chi=[k[[t]]^n\xrightarrow{A_\chi(t)}k[[t]]^n]
\tag{4}
\]
in degrees zero and one. The determinant defines the pullback of
the generalized theta divisor, up to a unit. By Section2 it is
nonzero. Smith form over k[[t]] therefore has only finite exponents
e_1,...,e_n>=0; contractible unit entries have exponent zero.

Derived base change, followed by the projection formula for the
ACTUAL q_r, identifies the degree-zero cohomology of (4) modulo t^Q
with H0(D_r,q_r^*E). The kernel of multiplication by t^e on R_Q
has k-dimension min(e,Q). Hence
\[
h^0(D_r,q_r^*E)=\sum_i\min(e_i,p^r),
\qquad
\operatorname{ord}_t\det A_\chi=\sum_i e_i<\infty.
\tag{5}
\]
In particular every single tower stabilizes. Pullback of sections
along its finite etale transition maps is injective; equality of
dimensions then makes the actual pullback an isomorphism. This
argument does not confuse an inverse limit of cohomology with
cohomology after base change: it computes the latter from (4).

## 4. Compactness makes the bound uniform over all towers

For a fixed Q=p^r, the finite character family P_(chi,Q), and thus
the vanishing or nonvanishing of its determinant in R_Q, depend
only on chi modulo p^r. Define
\[
U_r=\{\chi\in\mathscr X:
\det A_\chi\not\equiv0\pmod {t^{p^r}}\}.
\tag{6}
\]
This is a union of finitely many residue cylinders in (1), hence
is open and closed. It is independent of determinant trivializations.
The U_r are increasing, and Section2 implies that their union is all
of the compact space (1). Therefore U_R=mathscr X for some R.
For every chi one has
\[
\sum_i e_i<p^R.
\tag{7}
\]
All its individual exponents are consequently smaller than p^R,
and (5) is constant from level R onward. Taking M=p^R-1 proves the
claimed uniform statement, also for the shorter covers.

The argument is not asserting compactness of k or boundedness over
all vector bundles. Its compact parameter is the finite-rank
Z_p-module of etale characters of this fixed curve. For a finite
family of bundles, take the largest of their finitely many levels R.

There is a terminating finite criterion, although no useful size
estimate is supplied: at each level r, test all the finitely many
primitive cyclic characters and their determinant restrictions.
The proof guarantees a level where all these restrictions are
nonzero. An equivalent sufficient finite test is that all the
section dimensions at that level are less than p^r. In that case
no Smith exponent on ANY extension tower can reach p^r.

## 5. The exact linear term without a proper theta divisor

Here assume A simple. Retain chi(E)=0 but allow delta_E>0. Near zero in A the
Poincare cohomology is still represented by an equal-rank matrix.
Its generic corank is delta_E. Density of every formal character
implies that its pullback has exactly this corank over k((t)).
Smith form therefore consists of delta_E zero entries and finitely
many nonzero entries with finite exponents e_i. Formula(5) becomes
\[
h^0(D_r,q_r^*E)=\delta_Ep^r+\sum_i\min(e_i,p^r).
\tag{8}
\]
The ideal of the maximal nonzero minors pulls back to the principal
ideal (t^(sum e_i)). It replaces the determinant in(6). The same
compactness argument uniformly bounds sum e_i and proves the
eventual formula delta_E p^r+c_chi. Once every finite exponent is
less than p^R, its multiset, and hence c_chi, is already determined
by the character modulo p^R.

For a fixed f:Z->C, take E=f_*B_Z on first twists. Projection formula
identifies its sections on D_r with the exact forms on the actual
etale fiber product Z times_C D_r. Finite pushforward preserves
Euler characteristic, and chi(B_Z)=0, so (8) applies. This proves
the refinement formula, including disconnected fiber products.

This is a real boundary, not just a missing estimate. The established
[cofinal Raynaud saturation theorem](../theta_divisors/raynaud_cofinal_saturation.md)
constructs actual prime-to-p solvable refinements for which delta_f>0.
Thus cyclic primary stabilization at C cannot be silently applied
after an arbitrary intervening cover. The two-map geometric defect
has not disappeared; it has become the linear coefficient in(8).

## 6. Cartier kernels and actual maps to X

Raynaud's theorem says that the Cartier bundle B_C on C^(1) has
a proper generalized theta divisor. One exposition, including the
determinant construction, is Madore, *Theta divisors and the Frobenius
morphism*, Theorem3.1
([paper](https://alexjbest.github.io/buntes/courbes-semi-stables.pdf)).
It has chi(B_C)=0, and etale base change identifies its pullback
with B_D. If J(C) is simple, so is its relative twist. Applying
the theorem on C^(1) then proves uniform stabilization
of the actual Cartier kernels of cyclic covers of C.

The later [all-defect Raynaud bound](../theta_divisors/raynaud_rank_one_dimension.md)
also supplies the theta hypothesis for EVERY genus-two curve.
A positive-dimensional abelian coset of generic defect>0 would
have dimension at most(p−1)/p<1, impossible. Thus Section2 applies
without Jacobian simplicity in genus two, in every characteristic.
The arbitrary-pushforward formula in Section5 still requires the
simple-Jacobian density input; no hypothesis is removed from it.

For odd p, B_C has its canonical alternating omega-valued pairing.
At a stabilized level with Q larger than every exponent, there are
no full-length blocks. The
[odd block parity theorem](../../deformations/section_growth/cyclic_symplectic_blocks.md)
then makes the total section dimension even.

For the fixed X, [geometric simplicity](../../curve_arithmetic/fixed_pair_arithmetic.md)
and [two-form recognition](../../cartier_and_spin/two_form_map_descent.md)
are already established inputs. Choose the uniform level R_X above.
If h:D_r->X is finite etale and r>=R_X, every member of h^*ker C_X
belongs to the pullback of ker C_(D_R_X), by equality of the exact
section spaces. Any two independent such forms trigger the actual
map-descent theorem. Thus h=h_0 composed with D_r->D_R_X, with h_0
finite etale. The original tower map also factors through D_R_X.

There are only finitely many connected cyclic covers of X of the
fixed degree 5^(R_X). Each has only finitely many finite etale maps
to the fixed hyperbolic X. For clarity, their degrees are fixed by
Riemann--Hurwitz; the corresponding Hom scheme is of finite type,
and its tangent space at any such map is H0(D,h^*T_X)=0 because
that line has negative degree. It is therefore a finite set of
geometric points. This proves the final finite-correspondence claim.

The [one-long-block result](../../cartier_and_spin/cyclic_cartier_orbit_bound.md)
now has an additional consequence: along every cyclic tower over X
that block has a finite even eventual length, uniformly bounded
over the towers. The possible full-length case cannot persist forever.
The characteristic-primary argument alone treats neither a general
p-group tower nor a second endpoint of different genus.

## 7. Mixed abelian covers with fixed finite prime support

Here retain A simple. Let k=bar(F_p) and fix a finite prime set S. Write S'=S minus
the characteristic prime. The previously established
[finite-support Boxall theorem](../../../routes/global/BOXALL_PRUFER_TORSION_AND_EVERY_CYCLIC_TOWER.md)
implies that the proper generalized theta divisor of E meets
Pic0(C)[S'-infinity] in a FINITE set B. Its simple-ambient proof
is the only prime-to-p input used here. The older
[finite-character target theorem](../../../routes/global/FINITE_RESTRICTED_THETA_CHARACTERS_FORCE_UNIFORM_ETALE_TARGET_DESCENT.md)
already handles prime-to-p covers; the addition here is simultaneous
control of a cyclic characteristic-primary factor.

Let q:T->C have abelian group G=P times A, with P cyclic of order
p^r and A of prime-to-p order supported on S'. The quotient D=T/A
is the actual cyclic p^r-cover of C; the quotient T/P is the actual
character cover attached to a finite subgroup Lambda of
Pic0(C)[S'-infinity]. Their fiber product is T, since the two degrees
are coprime. Character decomposition gives
\[
H^0(T,q^*E)=
\bigoplus_{L\in\Lambda}H^0(D,q_D^*(E\otimes L)).
\tag{9}
\]
Inverting the labels L, if required by the character convention,
does not change the argument.

If L is not in B, then H0(C,E tensor L)=H1(C,E tensor L)=0.
Its cohomology matrix at zero is invertible, so it stays invertible
over every finite local character algebra k[t]/t^(p^r).
Consequently that summand of (9) is zero, at EVERY p-level.
For L in the finite set B, apply Sections1--4 to E tensor L.
Its theta divisor is a translate of the same proper divisor; a
translated formal character cannot lie in it, by the density proof.
There is a common R such that every nonzero Smith exponent for all
these finitely many bundles and every cyclic character is less
than p^R. Thus (9) is uniformly bounded.

This dimension bound gives actual section descent. Put
Lambda_*=the finite subgroup generated by B. The tame subgroup
annihilating Lambda intersect Lambda_* acts trivially on (9).
The p-subgroup generated by gamma^(p^R), interpreted as the trivial
subgroup if r<=R, also acts trivially: on each Smith summand its
deviation is t^(p^R), which is zero. Quotient T by the product of
these two subgroups and call the result T_0. Then
\[
[T_0:C]\le p^R|\Lambda_*|,
\qquad
H^0(T,q^*E)=H^0(T,q^*E)^{\operatorname{Gal}(T/T_0)}
=q_{T/T_0}^*H^0(T_0,E|_{T_0}).
\tag{10}
\]
The last equality is ordinary descent of invariant global sections
on an actual finite etale torsor; it does not divide by the group
order. It remains valid when that order is divisible by p.

For E=B_X, apply this on the first twists and then use two-form
recognition exactly as in Section6. Every second map T->X descends
to T_0. There are finitely many connected covers of X of bounded
degree, and finitely many etale maps from each to X, proving the
finite-correspondence conclusion.

This argument needs finite prime support in the tame factor and
rank ONE in the p-primary character direction. Neither is supplied
by an arbitrary common-cover diagram. The known positive restricted
Raynaud defects after a refinement still give the linear term in(8).
