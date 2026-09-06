# Proof: Hermitian atlases as normalized bundle extensions

Canonical [statement](../Theorems/Thm_hermitian_atlas_extension_criterion.md).
Write omega=omega_C and kappa=2g-2. This proof uses no lifting and does
not presume a simultaneous Galois closure of two arbitrary covers.

## 1. The finite frame torsor

The map of smooth schemes

    GL_3 -> Mat_3^invertible,       B |-> B^t B^(5)

has invertible differential dB |-> (dB)^t B^(5). It is geometrically
surjective: every nonsingular Frobenius form over a separably closed
field has an orthonormal basis. This is Cheng, *q-bic forms*,
[Props. 2.5-2.6 and Cor. 2.7, printed pp.8-9](https://chngr.github.io/assets/qbic-forms.pdf).
Those proofs use the finite etale scheme of Hermitian vectors and show
that these vectors span. We use the transpose of Cheng's convention.

Two matrices have the same image precisely when they differ by left
multiplication by an element of U_3(5), scheme-theoretically. Thus the
map is an etale torsor under this finite constant group, and is finite.
Quotienting scalar matrices and scalar forms gives the finite etale
PGU_3(5)-torsor

    PGL_3 -> P(Mat_3)_(det!=0).

Indeed the central kernel on U is mu_6, and scalar normalization is
etale. This argument is valid after base change, so it constructs the
projective orthonormal-frame torsor W -> C for any line-valued form.

In local frames of E and M write beta(v,w)=v^t A w. The projective
connection has a representative

    nabla=d+Gamma,       Gamma=A^(-t) d(A^t).

It is trivial after an orthonormal change of frame, up to a scalar
one-form. Differentiating v^t A v^(5)=0 gives
(nabla v)^t A v^(5)=0. This proves the asserted containment of the
second fundamental map in K_L/L.

## 2. Equivalence with an actual atlas

On W, the isotropic line defines a PGU-equivariant map h:W -> H.
Its differential is exactly the second fundamental map: the tangent
line of the isotropic curve at L is Hom(L,K_L/L). Transversality
therefore says h is etale. Each component of W is projective, and an
etale map from it to the connected projective curve H is finite and
surjective. Quotient descent gives a representable finite etale
surjection C -> [H/PGU].

Conversely, pull an atlas C -> [H/PGU] back to H. On H let L_0 be the
tautological line in the constant V=k^3 bundle. The bundles

    E_H=Hom(L_0,V),       M_H=L_0^-6

carry the normalized standard form and the nowhere-zero section given
by inclusion L_0 -> V. Scalars in U_3(5) act trivially on these data,
so they have PGU linearizations and descend to C. Their second
fundamental map is an isomorphism, because W -> H is etale. This
constructs global normalized vector bundles directly; no assertion
about a degree-zero lift of projective monodromy is needed.

## 3. Normalized line-bundle identities

Normalize any transverse datum by L^-1. Its distinguished line is O_C;
write K=ann(F_C^*O_C). Nonsingularity and transversality give

    E/K=M,             K/O_C=omega^-1,
    det E=M tensor omega^-1.

Taking determinants in F_C^*E=E^vee tensor M gives
(det E)^6=M^3. Substitution yields M^3=omega^6. Therefore
M=omega^2 tensor tau for a uniquely specified tau in Pic(C)[3], and
deg E=kappa. These are line-bundle identities, not just degree equalities.

## 4. The osculating extension and automatic transversality

We prove the Cech identity needed in both directions. Suppose E has a
nonsingular form, a global nowhere-zero section e, and its annihilator
K fits 0 -> O_C -> K -> omega^-1 -> 0. Do not assume transversality.
Let e_j=e_i G_ij be local frames of E, and let the frame of M change
by u_ij. The Gram matrices satisfy

    A_j=u_ij^-1 G_ij^t A_i G_ij^(5).

The trace-free representatives Gammahat_i=Gamma_i-tr(Gamma_i)I/3
therefore transform as

    Gammahat_j = G_ij^-1 Gammahat_i G_ij + G_ij^-1 dG_ij
                 - (1/3)dlog(det G_ij) I.

The local sections sigma_i=nablahat_i(e) lie in K tensor omega and
have differences, expressed in E itself,

    sigma_j-sigma_i = -(1/3)dlog(det G_ij) e.

Their common image in (K/O_C) tensor omega=O_C is a scalar s in k,
the second fundamental map. If epsilon is the extension class of
0 -> omega -> K tensor omega -> O_C -> 0, the connecting homomorphism
gives, with the displayed Cech convention,

    s epsilon = -(1/3)c_1(det E) in H^1(C,omega).                 (1)

The trace of c_1 of a line bundle is its degree in k. For transverse
data, s is nonzero, hence K is nonsplit exactly when 5 does not divide
kappa. Conversely, if deg E=kappa is nonzero in k, (1) forces s!=0.
Since s is a global scalar, this makes the map an isomorphism EVERYWHERE,
not just generically.

Now fix a nonzero extension K_C and M=omega^2 tensor tau. An extension
E of M by K_C has degree kappa. If beta(-,F_C^*e)=q, its annihilator
is precisely K_C. Equation (1) proves automatic transversality, and
Section 2 constructs the desired atlas. Every atlas gives such an
extension: its nonsplit K is isomorphic to K_C with distinguished
subline, allowing a scalar quotient identification. This proves the
criterion without a hidden differential condition.

The bundle K_C tensor M^-1 has a filtration with line quotients of
degrees -2kappa and -3kappa. Thus H^0 vanishes, its degree is -5kappa,
and Riemann--Roch gives h^1=6kappa=12(g-1). For a fixed E the form
constraint is affine linear. Its determinant lies in

    M^3 tensor (det E)^-6 = M^-3 tensor omega^6 = O_C.

Therefore a determinant nonzero at one point is nowhere zero.

## 5. The PSU character

For the universal normalized bundles on H,

    det E_H = L_0^-3 tensor det V,
    omega_H = L_0^-3 tensor (det V)^-1.

The second identity is adjunction with its U-linearization: the degree-six
Hermitian equation is U-invariant. Consequently

    M_H tensor omega_H^-2 = (det V)^2.

This character is trivial on scalar U matrices, has image mu_3, and
its kernel in PGU is PSU. Indeed the determinant in U takes values
in mu_6; multiplying a unitary matrix by a scalar changes its
determinant by an element of mu_2, so determinant-square is the exact
projective quotient character. These equivariant identities descend
to the frame torsor of C, identifying tau with that character line.

A reduction of this torsor to PSU exists exactly when its induced
mu_3-torsor is trivial. Since k is algebraically closed and C is
connected projective, the Kummer sequence identifies H^1(C,mu_3)
with Pic(C)[3]: global units have cube roots. Thus triviality is
equivalent to tau=O_C, and reduction is equivalent to lifting the
atlas through [H/PSU] -> [H/PGU].

## Scope

No extension satisfying the criterion has been found or excluded for
the fixed genus-nine X. The result replaces a large local equation by
an exact global bundle problem. It does not make every dormant oper,
Tango structure, or differential tensor into such an atlas.
