# Proof of the Frobenius bounds for finite curve maps

Write V_C=H^1(C,O_C), V_D=H^1(D,O_D), and let F denote the
appropriate semilinear Frobenius. All kernels and images below are
k-subspaces because k is perfect. We retain the actual maps
\[
i=h^*:V_C\longrightarrow V_D,\qquad
t=\operatorname{Tr}_h:V_D\longrightarrow V_C.
\]
They commute with Frobenius. For trace this follows generically
from the sum over the distinct field embeddings:
Tr(a^p)=Tr(a)^p. The equality extends to the O-module trace
on the smooth curves. The trace identity is ti=deg(h) id=0.

## 1. The two needed properties

First, t is surjective. By Serre duality its dual is the ordinary
pullback H^0(C,omega_C)->H^0(D,omega_D), which is injective for a
finite separable map. Finite-map duality identifies the dual of
O-module trace with this differential pullback, also in the
presence of ramification. No degree inversion is involved.

Second, ker(i) has bijective Frobenius. The natural exact sequence
O_(C^(1))->F_(C/k)*O_C->B_C identifies H^0(B_C) with ker(F_C),
with the scalar twist understood. The differential embeds B_C
into F_(C/k)*omega_C, identifying these sections with regular
Cartier-killed forms. Their pullbacks remain locally exact and
regular on D, and nonzero by separability. Naturality of the
connecting map gives ker(i) intersect ker(F_C)=0. Since ker(i)
is Frobenius-stable and finite-dimensional, its Frobenius is
bijective. Thus no étale base-change assertion at ramified points
is needed. In the étale case B_D=h^(1)*B_C gives the shorter
faithfully flat section argument used in the invariant-Picard proof.

It follows that i is injective on ker(F_C^r) for every r>=0. These
are the only geometric properties needed in the next step.

## 2. A trace--pullback inequality for Frobenius modules

Fix r,s>=0, and put U=ker(F_D^r). Compose t with the quotient to get
a surjection
\[
q:V_D\longrightarrow V_C/\operatorname{im}(F_C^s).
\]
Its target has dimension a_s(C), and q kills im(F_D^s), by
Frobenius compatibility. Moreover i(ker(F_C^r)) is an a_r(C)-dimensional
subspace of U intersect ker(q), because ti=0. Therefore
\[
\operatorname{rank}(q|_U)\le a_r(D)-a_r(C).
\tag{2.1}
\]
The image of U in V_D/im(F_D^s) has codimension
\[
\begin{aligned}
a_s(D)-\dim U+\dim\bigl(U\cap\operatorname{im}(F_D^s)\bigr)
&=a_s(D)-a_r(D)+a_{r+s}(D)-a_s(D)\\
&=a_{r+s}(D)-a_r(D).
\end{aligned}
\tag{2.2}
\]
For the equality used here, F_D^s maps ker(F_D^(r+s)) onto
U intersect im(F_D^s), with kernel ker(F_D^s). Rank--nullity
applies to this semilinear map. Because q factors through
V_D/im(F_D^s) and is surjective, (2.2) gives
\[
\operatorname{rank}(q|_U)
\ge a_s(C)-a_{r+s}(D)+a_r(D).
\tag{2.3}
\]
Combining (2.1) and (2.3) proves
a_{r+s}(D)>=a_r(C)+a_s(C). This proof also covers r=0 or s=0.

## 3. Block form, towers and the fixed curve

The nilpotent semilinear operator has a Jordan-chain basis, so
a_j(C)=sum_i min(j,ell_i). Its successive increments are
nonincreasing. For fixed r+s=t, the largest a_r(C)+a_s(C) occurs
when r=floor(t/2) and s=ceil(t/2). For every integer ell>=1,
\[
\min\{\lfloor t/2\rfloor,\ell\}
+\min\{\lceil t/2\rceil,\ell\}
=\min\{t,2\ell\}.
\]
This proves (2), including its equivalence to the whole collection
(1). Taking r=s=e gives the finite-height consequence. Taking
sufficiently large t gives the stable p-rank consequence because
the bijective Frobenius subspace has dimension f_p(C).

For a tower, apply the balanced version at each step. Its operator
on the sequence a_j is order-preserving, and it takes the function
min(j,ell) to min(j,2ell). Induction proves (4).

The fixed-X specialization uses only its three length-one nilpotent
blocks, proved by the
[Cartier matrix calculation](isogeny_sieves/etale_endomorphism_packets.md).
Thus a_2(Z)>=3 min(2,2)=6 when 5 divides deg(f). Riemann--Hurwitz
gives deg(g)=8deg(f) for either genus-two endpoint. The remaining
claims follow directly. The number of nilpotent blocks of length
at least two equals a_2(Z)-a_1(Z), which is at least two if a_1(Z)=4.

Finally, the module bound itself cannot be strengthened without
additional input. For each base block of length ell take a source
block of length 2ell, embed the base in its bottom ell steps and
project its top ell steps to the base. These Frobenius-compatible
maps have injective pullback, surjective trace and zero composite.
They attain (2) for every t. They are only Frobenius modules; they
are not asserted to come from étale covers of curves.

## 4. An exact functor on finite local systems

Let M be a finite-dimensional F_p representation of the étale
fundamental group of C with finite image. Étale descent gives its
vector bundle E(M), together with the Frobenius which fixes the
constant local-system coordinate and raises regular functions to
pth powers. This construction is exact and functorial.

The Frobenius on H^0(C,E(M)) is bijective. Indeed, on a connected
étale Galois cover trivializing M, every global section is constant.
Thus H^0(C,E(M)) is the invariant subspace of k tensor_(F_p) M.
Its equations have coefficients in F_p, so coordinate Frobenius
and its inverse preserve it. This uses no semisimplicity of M.

Finite-dimensional semilinear Frobenius spaces have a natural
Fitting decomposition into nilpotent and bijective parts. Maps
respect these parts, and taking either part is exact: an image or
quotient of a bijective part is bijective, while one of a nilpotent
part is nilpotent. Apply the nilpotent part to the cohomology exact
sequence of
0->E(M')->E(M)->E(M'')->0.
The H^0 terms have zero nilpotent part and H^2 on C vanishes. Hence
\[
0\longrightarrow\mathcal N_C(M')
\longrightarrow\mathcal N_C(M)
\longrightarrow\mathcal N_C(M'')\longrightarrow0
\tag{4.1}
\]
is exact. This proves the asserted coefficient functoriality in all
finite monodromy, including groups with p-divisible order.

## 5. Frobenius kernels in an extension

For an exact Frobenius-compatible sequence 0->U->V->W->0 of
finite-dimensional spaces, write a_t for the dimension of ker(F^t).
For nonnegative r,s the preimage V_s of ker(F_W^s) has dimension
dim U+a_s(W). Frobenius to the power s sends V_s into U, so
F^(r+s)(V_s) is contained in F^r(U), of dimension dim U-a_r(U).
Rank--nullity therefore gives
\[
a_{r+s}(V)\ge a_r(U)+a_s(W).
\tag{5.1}
\]
The kernel sequence also gives a_t(V)<=a_t(U)+a_t(W).
Induction through (4.1) proves both bounds in (6).
This statement concerns extension bounds, not a splitting of the
Frobenius module into its associated graded.

## 6. Permutation modules with p-group monodromy

For the permutation local system M of D/C, E(M)=h_*O_D, with
its actual Frobenius. Therefore N_C(M) is the nilpotent part of
H^1(D,O_D). If its monodromy P is a p-group, the augmentation
ideal J is nilpotent and each J^jM/J^(j+1)M is a trivial local
system of dimension d_j. The associated cohomology layer from
(4.1) is consequently N_C(F_p)^(d_j). This proves (7).

Dimensions add in (4.1), proving dim N_C(M)=n(g(C)-f_p(C)).
If the base nilpotence index is e, then F^e lowers the resulting
L-step filtration. Thus F^(eL)=0 on N_C(M). If the base is
ordinary, this nilpotent module is zero.

A composition series of M has n trivial one-dimensional factors.
Apply (6) and choose its n nonnegative indices as evenly as possible:
if t=qn+r, with 0<=r<n, choose r indices q+1 and the others q.
For each base block length ell their contribution is
(n-r)min(q,ell)+r min(q+1,ell)=min(t,n ell).
This proves (8). The Loewy-layer bound (7) may be stronger;
neither statement replaces the actual module by its associated graded.

If F vanishes on the base nilpotent part, a_r(C)=b for r>0 and
a_0(C)=0. Optimizing (7) simply selects the t largest layer
dimensions, or all of them if t>=L. This is (9).
For P=(C_5)^2 the layer coefficients of (1+x+...+x^4)^2 are
1,2,3,4,5,4,3,2,1. For P=(C_5)^3 they are
1,3,6,10,15,18,19,18,15,10,6,3,1.
Multiplying the largest coefficients by b=3 gives15 and57.
These group-algebra polynomials also occur in the independently
checked [augmentation-width argument](../deformations/section_growth/augmentation_width_defect.md).
No indigenous connection or marking is used here.

The cyclic-p case of the local-local filtration is consistent with
[Cais--Ulmer, Theorem1.2](https://arxiv.org/html/2307.16346v2).
Their Theorem1.10 supplies extra polarized constraints which the
elementary H1(O) argument does not assert. Our proof of (4.1)--(9)
is independent of those additional group-scheme results.

## 7. Removing the two constant layers

For an arbitrary finite étale cover with p dividing n, the actual
permutation local system M has the filtration
0 subset F_p 1 subset ker(epsilon) subset M.
Its graded local systems are F_p,H_h,F_p, respectively. Apply
the exact functor of Section4 to get (10), and take dimensions
to get (11). Applying the extension inequality with zero index
on the middle quotient also recovers (1) in the étale case.
Thus the local-system argument explains the trace bound but
is not needed for its extension to ramified separable maps.

The dot product on a geometric fibre of M is nondegenerate,
and the perpendicular of the constant line is ker(epsilon).
Because n=0 in F_p, the constant line is isotropic. The radical
of the restricted form on its perpendicular is precisely that
line, so the quotient form on H_h is nondegenerate and symmetric.
All identifications respect the actual permutation monodromy.

When C is ordinary, N_C(F_p)=0. The two maps in the exact
sequences for the displayed filtration then identify N_C(M)
canonically with N_C(H_h), respecting Frobenius. Nonvanishing
of this latter module is a restriction on the cover, not a
contradiction for covers of an ordinary curve.
