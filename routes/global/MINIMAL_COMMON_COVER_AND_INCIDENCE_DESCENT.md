# Incidence descent, minimal common covers and norm coordinates

Version2,2026-09-08. The original degree-minimal statements in §1 retain
[PASS metadata](audits/MINIMAL_COMMON_COVER_AND_INCIDENCE_DESCENT_AUDIT.md):
/root/x_elliptic_quotient_maps/m9_incidence_profiles,2026-09-04,
no breaking objection. The normalization-first formulation isolates what
that proof actually uses; global degree minimality is used only at the end.
Sections2–3 retain the author-only norm-field/line identities of2026-09-05.
Version2 extends norm-coordinate recovery from ω³ to ANY very ample line
bundle, with the same explicit inverse; this addition is not independently
audited. Consolidation: /root/library_generalization_cleanup_max.

## 1. The exact incidence square and the missing second leg

Work over algebraically closed k in ANY characteristic. Let Z have actual
finite etale maps f:Z→X,g:Z→Y, with X,Y smooth projective connected of
genus≥2. The normalization of their reduced joint image in X×Y is again
an actual common finite etale cover: both original maps factor through
it, the intermediate function fields are separable, and ramification
indices multiply to1. Thus a degree-minimal common cover is birational
to its joint image. From now on take Z to be that normalization; this
joint-normalization condition suffices for the incidence argument.

Suppose the integral image Γ has O(Γ)=A⊠B. Its defining section gives
a divisor-family morphism h:Y→P(H⁰(X,A)), with no zero coefficient
fiber because Γ is finite over Y. Suppose

    h:Y --q--> D --h₀--> P(H⁰(X,A)),       d=deg q,

where D is a smooth projective curve and q is finite; separability
is NOT assumed. Put B₀=h₀*O(1). Pulling back the tautological line
subbundle gives B=q*B₀ and an incidence divisor Γ₀ on X×D with

    Γ=(1_X×q)*Γ₀               scheme-theoretically.                (1)

Since q is finite faithfully flat, Γ₀ is integral and dominates both
factors. Let Z₀ normalize Γ₀, with s:Z₀→X and φ:Z₀→D. Then

    Z = Norm(Z₀×_D Y),        f=s r,        φ r=q g,
    deg r=d,                 Z --r--> Z₀ --s--> X finite etale.     (2)

The ENTIRE fiber product in(2) is integral. Both q and φ are separable,
but neither is asserted to be etale.

Here is the field-level justification, including the degree and
inseparability issues. Let E=k(D), L=k(Y), K₀=k(Z₀). From(1),

    k(Z)=K₀⊗_E L

is a FIELD of dimension d over K₀. Normalization changes neither
this generic algebra nor the degree. Also Z₀×_D Y is finite flat
over Z₀, hence torsion-free with this field as generic algebra;
it has no additional vertical or nilpotent component and is integral.
Since f=s r is etale, r,s are etale by the intermediate-field
argument above. Base change gives

    Ω_(L/E)⊗_L k(Z)=Ω_(k(Z)/K₀)=0,

so q is separable. Similarly etaleness of g forces K₀/E separable.
This retains the original map to Y on Z, not a replacement map.

If d>1, the original g CANNOT descend through r: an equality
g=λr would imply L⊂K₀ inside k(Z), hence k(Z)=K₀, contradicting
[k(Z):K₀]=d. Equivalently g pr₁=g pr₂ fails on Z×_(Z₀)Z.
The natural second target of Z₀ is D, not the fixed Y.

If J(Y) is simple, q has degree1 or D=P¹. Indeed a positive-genus
D gives, via q_*q^*=[d] on J(D), a positive-dimensional
abelian subvariety q*J(D)⊂J(Y) of dimension g(D). Thus g(D)=g(Y).
Separability and Riemann–Hurwitz then force d=1. There is no extra
purely inseparable alternative, even if char(k) divides d.

For the degree-minimal boundary, write

    g(Y)−1=r₀(g(X)−1),     b=deg(Z/Y),     ℓ=deg(Z₀/X).

Then dℓ=r₀b. If one ADDITIONALLY constructs an actual finite etale
map λ:Z₀→Y, Riemann–Hurwitz forces deg λ=ℓ/r₀=b/d<b for d>1,
contradicting minimality. When r₀ is integral, r₀|ℓ (equivalently
d|b) is necessary, NOT sufficient. In the endpoint ℓ=r₀, such a
map would require the extra geometric fact Z₀≅Y.
For the historical genus-(3,15) pair with r₀=7,b=9, the remaining
(d,ℓ)=(21,3),(63,1) give genera7 and3 for Z₀: neither can cover
the fixed genus15 Y etale. These descended curves therefore yield
no minimality contradiction.

The [connecting-class theorem](105_NONGALOIS_DESCENT_THROUGH_THE_CONNECTING_MAP.md)
can FORCE an incidence factor(1); it does not manufacture the missing
map Z₀→Y.

## 2. Norm coefficients recover the exact field for any very ample bundle

This section needs joint normalization and the actual etale maps above,
but NO split class O(Γ)=A⊠B and NO degree-range or Hom hypothesis.
Let H be ANY very ample line bundle on X, V=H⁰(X,H), b=deg g.
Compare h:Y→Sym^bX with the projective norm-polynomial map

    n:Y→P(Sym^b V*),       y↦[s↦Nm_g(f*s)(y)].

They generate the SAME subfield of k(Y), hence have the same normalized
image quotient. In particular H=ω_X³ gives the earlier tricanonical
statement. The proof preserves the coefficient field, not just geometric
pointwise injectivity.

Indeed Γ→Y is finite flat: its finite module is torsion-free over the
smooth base curve. Fiberwise the norm is the product of nonzero evaluation
linear forms at the points of the effective divisor Γ_y, with their
multiplicities, including collisions. Thus its coefficients have no
common zero and n is the Chow-product map applied to h.
Any differential framing contributes only a scalar discarded here.

Put L=k(Y), E=the incidence field, K=the norm coefficient field.
The product description gives K⊂E. For the converse choose a basis
s₀,…,s_m of V with s₀ nonzero on all b geometric generic points x_i
and t_i=s₁(x_i)/s₀(x_i) pairwise distinct. Very ampleness and the
infinitude of k allow these choices; the generic points are distinct
because Γ has normalization Z and g is etale. Put
u_ji=s_j(x_i)/s₀(x_i). After dividing the norm by its nonzero s₀^b
coefficient, substitute s=z s₀−s₁+Σ_(j≥2)w_j s_j. This gives

    F(z,w)=∏_i(z−t_i+Σ_(j≥2)w_j u_ji),
    P(z)=F(z,0)=∏_i(z−t_i),
    Q_j(z)=[w_j]F=Σ_i u_ji∏_(l≠i)(z−t_l),                 all over K.

The bracket selects the term linear in w_j, with no other w variables;
there is no division by an integer. P is separable, so P' is invertible
in the etale K-algebra R=K[z]/(P). The assignments

    s₁/s₀↦z,                s_j/s₀↦Q_j(z)/P'(z)

embed Spec R as a closed subscheme of the affine projective chart:
the first coordinate generates R. After faithful scalar extension they
are exactly the x_i, because Q_j(t_i)=u_ji P'(t_i). All equations of X
therefore already vanish over K. This recovers the generic reduced
degree-b divisor over K, proving E⊂K and hence E=K.

Reducedness is essential for this inverse. Merely factoring geometric
polynomials would miss inseparability: replacing a norm by its p-th power
replaces its coefficient field K by K^p in characteristic p. No such
operation occurs in the argument.

The [canonical connecting-field identity, §4](105_NONGALOIS_DESCENT_THROUGH_THE_CONNECTING_MAP.md#4-the-canonical-unit-recovers-exactly-the-incidence-field)
identifies its strict-range quotient with this same field. Norm
coordinates give a uniform input bundle and explicit nonlinear
reconstruction, not a finer quotient or a common-cover obstruction.

## 3. Exact normline identities and why free line bundles do not obstruct

Again suppose O(Γ)=A⊠B, for example when Hom(J(X),J(Y))=0.
Set a=deg f,b=deg g, so deg A=b,deg B=a. For EVERY line bundle H on X,

    Nm_g(f*H) ≅ B^(deg H).                                        (3)

For H=O_X(Σm_x[x]), its norm divisor is Σm_x g_*f*[x].
The divisor g_*f*[x] on Y is the intersection fiber Γ_x, whose line
bundle is B. Etaleness over X describes each completed branch as a
graph over X; restricting the product of branch equations counts
each branch once, including collision multiplicities. This proves(3)
for arbitrary integer m_x. It is an isomorphism class, not a preferred
scalar trivialization.

Norming the ACTUAL differential isomorphism f*ω_X≅g*ω_Y, and its
symmetric version, gives

    ω_Y^b ≅ B^(2g(X)−2),           ω_X^a ≅ A^(2g(Y)−2).             (4)

No descent of the canonical unit to singular Γ is needed for(4).
They can reject FIXED candidate bundles A,B and are stronger than
the numerical Riemann–Hurwitz identity. If one weakens the premise to
only a trivial n-th power on Γ, its norm yields only the n-th powers
of(4); a possible n-torsion discrepancy cannot be discarded.

With A,B free, however, these line-bundle equations alone are always
solvable subject to a(2g(X)−2)=b(2g(Y)−2). Starting with any degree-a
B₁, the degree-zero bundle ω_Y^b B₁^−(2g(X)−2) has a
(2g(X)−2)-th root in Pic⁰(Y): multiplication by any positive integer
is surjective on geometric points, including in the characteristic.
Adjust B₁ by that root; do the same for A. At fixed degrees the choices
form finite torsors, possibly nonreduced scheme-theoretically.
This constructs bundle classes only, not an integral Γ, its defining
section or its two etale projections. The common-cover problem remains
unsolved.
