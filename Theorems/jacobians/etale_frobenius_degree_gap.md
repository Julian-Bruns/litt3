# Frobenius kernels and finite curve maps

Version3,3 October2026. The later exact coefficient functor also
identifies the actual nilpotent deck module.
Let h:D->C be a finite separable
map of smooth projective connected curves over an algebraically closed field
k of characteristic p>0. Put
\[
a_t(C)=\dim_k\ker\bigl(F_C^t:H^1(C,\mathcal O_C)
\longrightarrow H^1(C,\mathcal O_C)\bigr),\qquad a_0(C)=0,
\]
using the semilinear Frobenius, and define a_t(D) similarly.
Suppose p divides deg(h). Then, for every r,s>=0,
\[
\boxed{a_{r+s}(D)\ge a_r(C)+a_s(C).}
\tag{1}
\]
Neither étaleness nor a Galois assumption is required for (1)--(4).

Equivalently, if ell_1,...,ell_b are the lengths of the nilpotent
Frobenius blocks on H^1(C,O_C), the strongest bound in (1) at each
fixed t is
\[
\boxed{a_t(D)\ge\sum_{i=1}^b\min\{t,2\ell_i\}.}
\tag{2}
\]
In particular,
\[
a_{2e}(D)\ge2a_e(C),\qquad
g(D)-f_p(D)\ge2\bigl(g(C)-f_p(C)\bigr).
\tag{3}
\]
The same assertions hold over a perfect ground field for
geometrically connected curves, by extension of scalars.

For a specified tower of finite separable maps C_r->...->C_0 with p dividing the degree
of every stage, (2) iterates to
\[
a_t(C_r)\ge\sum_i\min\{t,2^r\ell_i(C_0)\}.
\tag{4}
\]
Divisibility of the total degree by p^r alone does not supply such
a tower. For Galois p-group towers the Deuring--Shafarevich formula
gives a stronger stable p-rank statement; (1) also treats arbitrary
non-Galois p-divisible stages.

## Consequence for both selected pairs

For the fixed genus-nine X, the audited Cartier calculation gives
f_p(X)=6 and three nilpotent blocks of length one. Thus every actual
finite separable f:Z->X with 5 dividing deg(f) satisfies
\[
a_2(Z)\ge6,\qquad g(Z)-f_5(Z)\ge6.
\tag{5}
\]
In an actual finite étale common-cover span X<-Z->Y with g(Y)=2, the two degrees
are n and 8n. Consequently either a_2(Z)<=5 or g(Z)-f_5(Z)<=5
forces BOTH degrees to be prime to five. This does not imply that
their Galois closures have order prime to five.

At a_1(Z)=4, a 5-divisible degree forces at least two nilpotent
Frobenius blocks of length at least two. The hypothesis a_1(Z)=4
alone does not exclude that degree, and no upper bound on the
Frobenius kernels of an arbitrary common source has been proved.
Neither candidate common-cover problem is resolved by (5).

The proof uses the actual pullback and trace. The bound is sharp for
abstract Frobenius modules with these two maps; no geometric
sharpness assertion is made.

## Exact nilpotent cohomology and p-group monodromy

For the remainder of the statement, h:D->C is finite étale.
For a finite F_p local system M on C, let E(M)=M tensor_(F_p) O_C
be its associated vector bundle, with its natural semilinear
Frobenius. Put
\[
\mathcal N_C(M)=H^1(C,E(M))_{\mathrm{nil}},\qquad
a_t(M)=\dim\ker(F^t|\mathcal N_C(M)).
\]
The functor N_C is exact on finite F_p local systems. For any
filtration with graded local systems M_j this implies
\[
\max_{\substack{r_j\ge0\\\sum_jr_j=t}}
\sum_j a_{r_j}(M_j)
\ \le\ a_t(M)\ \le\ \sum_j a_t(M_j).
\tag{6}
\]
The lower bound is a finite optimization of the actual graded
Frobenius kernel functions; no associated-graded equality is asserted.

### The actual nilpotent deck module

For an actual connected finite étale Galois cover q:T->C with
group G, write N_T=H^1(T,O_T)_nil. Pullback identifies, compatibly
with Frobenius,
\[
\mathcal N_{T/H}(\mathbf F_p)\simeq N_T^H
\qquad(H\le G).
\]
The module N_T is projective over k[G]. In particular, if G=P
is a p-group and b=g(C)-f_p(C), then
\[
\boxed{N_T\simeq k[P]^b.}
\]
This is an isomorphism of deck modules, not a splitting of
Frobenius. For every H, the actual trace followed by pullback is
the group norm; it induces an isomorphism from (N_T)_H to N_T^H.

For P a p-group, choose a free basis and let A be the matrix of
semilinear Frobenius, which fixes the abstract group elements.
Via the norm identification N_T^P~=N_C, the augmentation of A
is exactly the base Frobenius matrix. If F_C^e kills N_C, then
\[
F_T^e(N_T)\subseteq JN_T,\qquad
F_T^e(J^jN_T)\subseteq J^{j+1}N_T.
\]
The p-group dimension and filtration bounds below therefore
describe an actual free deck module with a Frobenius operator.
For mixed G, projectivity gives no free rank b or arbitrary-source
upper bound.

Suppose now h:D->C is finite étale and its Galois closure is a
p-group P. Let M be the
F_p permutation module of the cover, n=dim M=deg(h), J the
augmentation ideal of F_p[P], and
\[
d_j=\dim_{\mathbf F_p}J^jM/J^{j+1}M\quad(0\le j<L),
\qquad J^LM=0,
\]
omitting zero final layers. Then
\[
\max_{\sum_jr_j=t}\sum_j d_j a_{r_j}(C)
\ \le\ a_t(D)\ \le\ n a_t(C).
\tag{7}
\]
In particular the nilpotent Frobenius part upstairs has dimension
n(g(C)-f_p(C)), and its nilpotence index is at most L times the
base index. A composition series with n one-dimensional factors
also gives
\[
a_t(D)\ge\sum_i\min\{t,n\ell_i(C)\}.
\tag{8}
\]
The stable dimension recovers the unramified p-group
Deuring--Shafarevich formula. Statements (7) and (8) retain finite
Frobenius height and apply to non-Galois quotients of p-group covers.

When F kills the base nilpotent part, let b=g(C)-f_p(C)=a_1(C).
Order the d_j decreasingly as d_[1]>=...>=d_[L]. Then (7) reduces to
\[
\boxed{a_t(D)\ge b\sum_{j=1}^{\min(t,L)}d_{[j]}.}
\tag{9}
\]
For an actual Galois (C_5)^2 or (C_5)^3 cover of the fixed X, this
forces respectively a_1(D)>=15 or a_1(D)>=57. More generally the
same bounds pass to any actual étale source dominating such a
cover. They do not pass merely from a quotient of a closure group
which the source does not dominate.

The free p-group deck module is Nakajima's equivariant
Deuring--Shafarevich theorem, used by reference. The exact
coefficient bounds retain finite Frobenius height and arbitrary
finite local systems. Cais--Ulmer give additional polarized
cyclic-p restrictions; the bounds here do not reconstruct the
whole p-torsion group scheme.

## The permutation heart in arbitrary étale monodromy

For any connected finite étale cover of degree n divisible by p,
let M=h_*F_p, let 1:F_p->M be the constant sub-local-system, and
let epsilon:M->F_p be the sum of coordinates. Since epsilon(1)=0,
the local system
\[
\mathcal H_h=\ker(\epsilon)/\mathbf F_p\,1
\]
has rank n-2. The nilpotent cohomology of D has an actual
Frobenius-stable filtration with three successive quotients
\[
\mathcal N_C(\mathbf F_p),\quad
\mathcal N_C(\mathcal H_h),\quad
\mathcal N_C(\mathbf F_p).
\tag{10}
\]
Consequently
\[
g(D)-f_p(D)=2(g(C)-f_p(C))+
\dim\mathcal N_C(\mathcal H_h).
\tag{11}
\]
The coordinate dot product induces a nondegenerate symmetric
pairing on H_h. This statement does not identify its cohomology
with that of a polarized abelian subvariety.

If C is ordinary, there is a canonical Frobenius-compatible
isomorphism N_C(M)~N_C(H_h). Thus all nonordinary cohomology
upstairs is carried by this actual finite-monodromy local system.
No p-group or prime-to-p closure hypothesis is used in (10)--(11).

[Proof](../../Proofs/jacobians/etale_frobenius_degree_gap.md).
