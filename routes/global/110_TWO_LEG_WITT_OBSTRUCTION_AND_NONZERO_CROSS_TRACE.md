# The two-leg Witt obstruction and a nonzero quadratic cross trace

**Status: collaborative author proof, 2026-09-05; not independently audited.**

Authors: /root and /root/gluing_cohomology_rigidity.

There is an exact obstruction to finding one W_2-lifting that supports
both maps of a given common etale cover. It is an affine deformation
difference, not a consequence of separate liftability. The Hom(J(X),J(Y))=0
hypothesis does not force its associated tangent cross trace to vanish.
An actual primitive bi-etale example of degrees two and four proves this,
retaining the current genus-25 Y but using an auxiliary genus-49 X.

The deformation and trace statements below concern the original two maps
on the same source. No canonical lifting of bare curves is assumed.

## 1. The exact affine obstruction

Work over k=Fbar_5, and let

\[
                       f:Z\longrightarrow X,\qquad
                       g:Z\longrightarrow Y
\]

be finite etale maps of smooth projective connected curves of genus at
least two. Put V_C=H^1(C,T_C). The marked W_2(k)-liftings of C form a
nonempty torsor Lift_2(C) under V_C: obstruction groups H^2(C,T_C)
vanish. Markings identify the special fiber with the given curve.

The equivalence of finite etale covers across a nilpotent thickening
assigns to every lifting of X a unique lifted f-cover. Its source
defines an affine map Lift_2(X)->Lift_2(Z), with linear part

\[
 a_f:V_X\longrightarrow V_Z,\qquad
 a_f=(df)^{-1}f^*.
\]

Define a_g similarly. Choose arbitrary target liftings X_tilde,Y_tilde,
and write Z_f,Z_g for their induced marked source liftings. The two
affine loci of induced source liftings are exactly

\[
                 Z_f+U_f,\qquad Z_g+U_g,\qquad
                 U_f=\operatorname{im}a_f,\quad
                 U_g=\operatorname{im}a_g.              \tag{110.1}
\]

### Proposition 110.1

The class

\[
 \mathfrak o(f,g)=[Z_g-Z_f]\in V_Z/(U_f+U_g)             \tag{110.2}
\]

is independent of the chosen target liftings. It vanishes if and only if
there exist liftings of X,Y,Z over W_2(k) on which both original maps
lift etale. When nonempty, the intersection of the two source loci is
an affine torsor under U_f cap U_g.

#### Proof

Changing the target liftings by xi in V_X and eta in V_Y changes the
ordered difference by a_g(eta)-a_f(xi). This proves independence in the
quotient. The two affine loci intersect exactly when Z_g-Z_f belongs
to U_f+U_g. An equality of marked source lifting classes identifies the
two lifted covers on one source; conversely a simultaneous diagram lies
in both loci. The direction space of an affine intersection is the
intersection of its direction spaces. QED.

Both a_f and a_g are injective, even when their degrees are divisible
by five. For example, the locally free quotient E=f_*O_Z/O_X becomes
trivial on an etale Galois closure of f. Hence H^0(X,T_X tensor E)=0,
since its pullback is a sum of negative-degree line bundles. The exact
sequence with kernel T_X then proves injectivity on H^1.

## 2. The Deligne--Illusie form and the dual test

Write F_C for relative Frobenius and retain its twists implicitly, as
in file 37. That file proves both

\[
 DI(Z_g)-DI(Z_f)=F_Z^*(Z_g-Z_f)
\]

and injectivity of F_Z^*:V_Z->H^1(Z,F_Z^*T_{Z^{(1)}}).
Naturality through the two lifted etale maps therefore gives

\[
 D_{f,g}:=
 g_F^*DI(Y_{\rm tilde})-f_F^*DI(X_{\rm tilde})
                       =F_Z^*(Z_g-Z_f).                 \tag{110.3}
\]

Here f_F^*,g_F^* include the differential identifications of the
Frobenius-pulled-back tangent bundles. Consequently the exact DI test is

\[
 \mathfrak o(f,g)=0
 \quad\Longleftrightarrow\quad
 D_{f,g}\in F_Z^*(U_f+U_g).                              \tag{110.4}
\]

The denominator is also
f_F^*(F_X^*V_X)+g_F^*(F_Y^*V_Y). The maps are Frobenius-semilinear;
over the perfect k this causes no ambiguity about the subspaces or
the vanishing criterion. Individual DI classes need not be zero.

For an etale map h, let Tr_h^(2) be trace on quadratic differentials,
using omega_source^2=h^*omega_target^2 and trace on h_*O. Serre duality
identifies the dual obstruction space with

\[
 \bigl(V_Z/(U_f+U_g)\bigr)^*
   =\ker\operatorname{Tr}_f^{(2)}
             \cap\ker\operatorname{Tr}_g^{(2)}
       \subset H^0(Z,\omega_Z^2).                       \tag{110.5}
\]

Thus (110.2) is equivalently tested by pairing the ordered deformation
difference against this intersection. This is a finite-dimensional test
for each given diagram; it does not evaluate the class for an unknown
common cover.

For the fixed genera g(X)=9,g(Y)=25, write N=deg g. Then
g(Z)-1=24N and

\[
 \dim V_X=24,\quad \dim V_Y=72,\quad \dim V_Z=72N,
\]

\[
 \dim V_Z/(U_f+U_g)
              =72N-96+\dim(U_f\cap U_g).                \tag{110.6}
\]

The source-dependent obstruction space therefore grows with the cover
degree. It is not a fixed-size invariant computed from the two targets.

## 3. What the tangent cross trace actually measures

Let tr_f^T:V_Z->V_X be the tangent trace, using T_Z=f^*T_X and the trace
on f_*O_Z. The operator in question is

\[
                  C_{f,g}=\operatorname{tr}_f^T a_g
                         :V_Y\longrightarrow V_X.
\]

Its Serre dual is precisely

\[
 C_{f,g}^*
       =\operatorname{Tr}_g^{(2)}f^{*(2)}
       :H^0(X,\omega_X^2)\longrightarrow H^0(Y,\omega_Y^2).
                                                        \tag{110.7}
\]

For separating rational parameters x on X and y on Y, its function-field
formula is

\[
 a(x)(dx)^2\longmapsto
 \operatorname{Tr}_{k(Z)/k(Y)}
       \left(a(f)\left(\frac{dx}{dy}\right)^2\right)(dy)^2.
                                                        \tag{110.8}
\]

Hom(J(X),J(Y))=0 annihilates the correspondence on one-differentials,
whose analogous formula contains dx/dy to the FIRST power. It does
not identify (110.8) with that map. The following actual example proves
that no general vanishing inference is valid.

## 4. A primitive bi-etale counterexample of degrees two and four

### Theorem 110.2

Let Y be a hyperelliptic curve of genus h>=2 over an algebraically closed
field of odd characteristic, with absolutely simple Jacobian. There exist a smooth
connected curve Z_aux and a smooth curve X_aux with primitive joint map
and finite etale projections

\[
 f:Z_{\rm aux}\longrightarrow X_{\rm aux},\quad \deg f=2,
 \qquad
 g:Z_{\rm aux}\longrightarrow Y,\quad \deg g=4,
\]

such that

\[
 g(Z_{\rm aux})=4h-3,\qquad g(X_{\rm aux})=2h-1,
 \qquad \operatorname{Hom}(J(X_{\rm aux}),J(Y))=0,
\]

but

\[
                         \operatorname{rank}C_{f,g}\ge2h-1.
                                                        \tag{110.9}
\]

#### Construction and etaleness

Partition the 2h+2 hyperelliptic branch points into three nonempty
even-sized subsets B_1,B_2,B_3. Choose a coordinate t whose infinity is
outside the branch set, and let F_i(t) be the square-free polynomial
with roots B_i. After rescaling the hyperelliptic coordinate, Y has
function field

\[
                       k(t)\bigl(\sqrt{F_1F_2F_3}\bigr).
\]

Let Z_aux be the smooth normalization in

\[
                  k(t)(u_1,u_2,u_3),\qquad u_i^2=F_i.
\]

The square classes of the F_i are independent by valuations at their
disjoint nonempty branch sets. This is a connected degree-eight cover
with group G=(C_2)^3. Each local inertia group flips exactly one u_i;
infinity is unramified because every deg F_i is even.

Let H be the subgroup of even sign changes. The quotient by H is Y,
and Z_aux->Y is etale of degree four because no inertia group meets H
nontrivially. Let sigma flip all three u_i and put
X_aux=Z_aux/<sigma>. Again no inertia group contains sigma, so this
degree-two quotient is etale.

The two quotient subgroups have trivial intersection. Their invariant
function fields therefore generate k(Z_aux), proving primitivity of
the joint image. The genus formulas follow from the two etale
Riemann--Hurwitz identities.

Equivalently, label G as F_2 x F_2^2 and use the three independent
inertia vectors (1,c_i), where c_i runs through the nonzero vectors of
F_2^2. The Y quotient is the first-coordinate character, while the
X_aux quotient uses the color coordinates.

#### The Hom condition

The biquadratic cover X_aux->P^1 has the three double quotients

\[
              C_{ij}:\ v_{ij}^2=F_iF_j,\qquad i<j.
\]

Its character decomposition gives an isogeny

\[
 J(X_{\rm aux})\sim J(C_{12})\times J(C_{13})\times J(C_{23}).
\]

One can see this directly by the three pullback maps: the nontrivial
characters of the biquadratic group are distinct, and their dimensions
sum to g(X_aux). For {i,j,k}={1,2,3},

\[
                        g(C_{ij})=h-\frac{|B_k|}{2}<h.
\]

Absolute simplicity of J(Y) rules out a nonzero homomorphism between
J(Y) and any of these lower-dimensional Jacobians, in either direction.
The isogeny decomposition proves the asserted Hom vanishing.

#### The nonzero cross trace

Write iota_Y for the hyperelliptic involution. The automorphism sigma
acts on Y as iota_Y. For any

\[
                         b\in H^0(Y,\omega_Y^2)^{\iota_Y},
\]

the pullback g^*b is sigma-invariant and hence descends through the
etale quotient f to a quadratic differential a on X_aux. Therefore

\[
                     f^*a=g^*b,\qquad
                     C_{f,g}^*(a)=4b.
\]

Four is nonzero in odd characteristic. The invariant quadratic space
has dimension 2h-1: it is the pullback of
H^0(P^1,omega_{P^1}^2(B)), whose line bundle has degree 2h-2.
At a branch point a simple pole downstairs becomes regular upstairs.
Thus the image of C_{f,g}^* contains this entire invariant space,
proving (110.9). QED.

## 5. What this settles for the current route

Take the absolutely simple genus-25 Y of file 76. The example has
g(X_aux)=49 and g(Z_aux)=97, and its tangent cross trace has rank at
least 49. Both maps are etale on the same connected source, and its
joint image is primitive.

The auxiliary genus-49 curve is not the fixed genus-nine X. This is a
counterexample to the proposed universal implication from Hom vanishing,
not a common cover of the fixed pair.

The affine class (110.2), or equivalently (110.4), remains a legitimate
two-leg obstruction for that fixed pair. Its value has not been computed,
and Hom vanishing does not supply the suggested cross-trace simplification.
Nothing here identifies independently induced source liftings or supplies
the compatible ordinary indigenous bundles required in file 33.
