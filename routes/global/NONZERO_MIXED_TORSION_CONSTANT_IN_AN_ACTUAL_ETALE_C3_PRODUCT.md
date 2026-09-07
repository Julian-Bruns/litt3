# An actual etale C₃×C₃ diamond with nonzero mixed pairing

Version2,2026-09-08: the geometric example and its exact arithmetic
parameter are consolidated, with no promotion of evidence.
Geometry: /root/gluing_cohomology_rigidity,2026-09-05, author-checked,
NOT independently audited. Arithmetic: author proof plus exact scalar
certificate, replayed PASS2026-09-08 by
/root/library_generalization_cleanup_max (not a fresh prose audit).
The unchanged [Sage certificate](EXPLICIT_C3_CUBIC_DIAMOND_WEIL_CERTIFICATE.sage)
retains the finite-field counts and character enumeration.

## 1. Result and scope

For every algebraically closed k of characteristic≠3 and
λ∈k\{0,1}, there are ACTUAL finite etale maps

    T ← W → V,      (g(T),g(W),g(V))=(4,10,2),
                    (deg(W/T),deg(W/V))=(3,9),

with T nonhyperelliptic, W/V Galois with group H₁×H₂=C₃×C₃,
and k(W)=k(T)k(V). For r:W→T,

    r_*(a_*−1)(b_*−1)=0       for all a∈H₁,b∈H₂,

but the constant mixed pairing c:H₁×H₂→J(T)[3](k) is nonzero
with trivial radicals. Neither factor fixes r. Thus unrestricted
axis descent is FALSE, exactly as allowed by the
[bounded residual theorem](MIXED_JACOBIAN_VANISHING_AND_BOUNDED_RESIDUAL_DESCENT.md).

In characteristic5 the explicit parameter

    k₀=F₅[α]/(α²−α+2),       λ=α+3∈F₂₅

makes BOTH endpoints ordinary and Hom_(Fbar₅)(J(T),J(V))=0,
while a(W)=4 and f(W)=6. This is a common-cover example, NOT a
counterexample to Litt. The arithmetic assertions are for this
specified parameter, not for every λ or for the active fixed X.

## 2. One compact curve, both free actions

Choose ζ of order3. Let W⊂P³_[U:Z:A:S] be

    U³−Z³=S³,                  U³−A³=λS³.

Its affine function field is

    u³=t,      z³=t−1,      a³=t−λ,                 u=U/S.

The three Kummer classes are independent by their valuations at
0,1,λ, so the extension of k(t) has degree27, with group G=F₃³
acting by (u,z,a)↦(ζ^x u,ζ^y z,ζ^z₀ a).
The complete intersection is smooth: neither gradient can vanish,
and a dependence between them forces Z=A=0, then U=S=0 because
λ≠1. Its affine generic field is irreducible; S=0 contains only
nine points, so no additional curve component lies at infinity.
Thus this is the smooth projective connected Kummer model.

The only inertia lines in G are

    <e₁>, <e₂>, <e₃>, <(1,1,1)>       at0,1,λ,∞ respectively.

At infinity the three radicands all have valuation−1 and yield
the same local tame cubic extension. There is no other ramification.
Riemann–Hurwitz gives 2g(W)−2=27(−2+4·2/3)=18.

Put h₁=(1,1,0), h₂=(1,0,1), k₀=(0,1,1), and

    H_i=<h_i>,    H=H₁×H₂=ker(x−y−z₀),    K=<k₀>.

The functional x−y−z₀ is nonzero on every inertia generator.
Hence the WHOLE H acts freely, not just its individual factors.
K also differs from all inertia lines and acts freely. Its
functional value is−2=1 in F₃, so G=H×K. Therefore

    r:W→T=W/K,        s:W→V=W/H

are finite etale of degrees3 and9, including at infinity.

## 3. The target models and the exact mixed identity

The K-invariants u,v=z/a generate k(T), with

    v³(u³−λ)=u³−1,       equivalently u³=t, v³=(t−1)/(t−λ).

This is a smooth (3,3) curve in P¹_u×P¹_v. In the affine chart
simultaneously vanishing partial derivatives would force
v³=1,u³=λ, contrary to λ≠1; at u=0 or v=0 the other derivative
is nonzero. At u=∞ one has v³=1 and nonzero v-derivative; at
v=∞ one has u³=λ and nonzero u-derivative. There is no point
with both coordinates infinite. Adjunction gives g(T)=4 and
ω_T=O_T(1,1); its four canonical sections give the restricted
Segre embedding, so T is nonhyperelliptic in every allowed characteristic.

Let σ(u,v)=(ζu,v), τ(u,v)=(u,ζv). The two factors induce
h̄₁=στ, h̄₂=στ⁻¹, generating the C₃²-action with quotient P¹_t.
Its only inertia lines are <σ> and <τ>, so each <h̄_i> acts
freely. Their etale degree3 quotients have genus2 and models

    T₁: b³=t(t−λ)/(t−1),  b=u/v;
    T₂: d³=t(t−1)/(t−λ),  d=uv.

For e_i=(1+h̄_i*+h̄_i*²)/3 in End⁰(J(T)), the image is
q_i*J(T_i), of dimension2. The product e₁e₂ is the whole-group
norm divided by9, hence zero because T/C₃²=P¹. Their images
therefore have finite intersection and sum to J(T), giving an
isogeny J(T₁)×J(T₂)→J(T). The first factor action fixes the first
summand, the second fixes the second. Since the actions commute,

    (ā_*−1)(b̄_*−1)=0 in End(J(T)),     a∈H₁,b∈H₂.

This is EXACT: the endomorphism vanishes after precomposition
with a surjective isogeny. It is not an inference from a zero
differential. Equivariance of r gives the asserted mixed vanishing.

Choose v₀³=1/λ and P_j=(0,ζ^j v₀). The trigonal fiber classes satisfy

    H_u=[P₀+P₁+P₂],             H_v=[3P_j] for every j.

At a point of W over P₀, the mixed constant is

    c(h₁,h₂)=[2P₀−P₁−P₂]=H_v−H_u.

The fiber identities give3c=0. If c=0, the distinct effective
degree-two divisors2P₀ and P₁+P₂ would be equivalent, contradicting
nonhyperellipticity. Hence c has exact order3. Biadditivity gives
c(h₁^i,h₂^j)=ijc, proving trivial radicals and residual indices3.

The H-invariants t,w=uz²/a generate

    k(V): w³=t(t−1)²/(t−λ).

The four branch valuations at0,∞,1,λ are1,1,2,2 modulo3, giving
g(V)=2. The field degree verifies k(V)=k(W)^H. Finally, from the
two target fields one recovers z=w/(uv), a=z/v. Thus k(T)k(V)=k(W):
W is the normalization of the joint image in T×V, with BOTH original
etale legs retained.

## 4. The exact ordinary, Hom-orthogonal parameter

Now use characteristic5 and λ=α+3 above. For each cubic model,
every branch fiber contributes one rational point, and every other
fiber is counted by its cube roots. The scalar certificate gives:

| Curve | # over F₂₅ | # over F₆₂₅ |
| --- | ---: | ---: |
| V | 28 | 724 |
| T₁ | 22 | 592 |
| T₂ | 10 | 598 |

These determine the genus-two Frobenius polynomials

    P_V(t)=t⁴+2t³+51t²+50t+625=(t²+t+25)²,
    P₁(t)=t⁴−4t³−9t²−100t+625,
    P₂(t)=t⁴−16t³+114t²−400t+625=(t²−8t+25)².

All three middle coefficients are prime to5, so V,T₁,T₂ are
ordinary, as is T via the preceding isogeny.

For a root β of t²+t+25, Q(β)=Q(√−11) and
Q(β^n)=Q(√−11) for every n≥1: β/β̄ belongs to that quadratic
field, has neither value±1, and cannot be any other root of unity.
The roots of P₂ lie in Q(i). The polynomial P₁ has root field
L=Q(√−3,√7), as seen from

    P₁(t)=(t²+(−2+3√7)t+25)(t²+(−2−3√7)t+25).

The quadratic discriminants are−3(2±√7)²; the four conjugates
are distinct, proving irreducibility and the asserted field.
Its quadratic subfields are Q(√−3),Q(√7),Q(√−21). Thus both
L and Q(i) intersect Q(√−11) only in Q.

A nonzero geometric Hom from either J(T_i) to J(V) is defined
over some F_(25^n). On Tate modules it forces a common Frobenius
eigenvalue γ^n=β^n, with γ a root of P_i. But the right side
generates Q(√−11), while the left side lies in L or Q(i).
This contradiction proves both Hom groups zero and therefore
Hom(J(T),J(V))=0. It is a geometric, not merely base-field,
Hom-vanishing certificate.

## 5. Nonordinary common source despite proper restricted theta

For a nonzero character χ=(i,j,k)∈F₃³, put
r(χ)=#{nonzero entries among i,j,k,i+j+k}. The cyclic quotient
attached to {χ,−χ} has genus r(χ)−2. The exact distribution of
the13 pairs, also enumerated in the certificate, is

    r=2:6 pairs;          r=3:4 pairs;          r=4:3 pairs.

The genus-two packets are exactly J(T₁),J(T₂),J(V).
The four genus-one quotients each have an order3 automorphism
with a fixed point, so j=0 and they are supersingular in char5.
The others are rational. Group-algebra projectors, whose denominators
are powers of3, consequently give a PRIME-TO-5 isogeny

    J(W) ∼ J(T)×J(V)×E_ss⁴.

Here the four elliptic curves are isomorphic over Fbar₅ to the
j=0 curve E_ss. Pullbacks and norms provide the inverse after
inverting3; the kernel is killed by a power of3. Thus this
isogeny identifies5-divisible groups, justifying

    f(W)=6,          g(W)−f(W)=4,          a(W)=4.

The a-number claim uses the prime-to-5 isogeny, NOT arbitrary
isogeny invariance. The origin therefore lies in the two-leg
restricted Raynaud bad locus on J(T^(1))×J(V^(1)). Nevertheless
that locus is proper: either original leg is abelian Galois of
prime-to-5 degree, so its axis is proper by the
[character-filtration criterion, §1](RESTRICTED_RAYNAUD_THETA_SUFFICIENT_CONDITIONS_AND_STABILITY_BOUNDARY.md).
This retains the concrete distinction between theta properness
and ordinarity of the common source.

The small-parameter boundary is also exact: over F₂₅, λ=2 gives
P_V=P₂, λ=3 gives P_V=P₁, with this common polynomial ordinary;
λ=4 gives P_V=(t+5)⁴, nonordinary. Thus no λ∈F₅\{0,1} has both
desired properties. These extra scalar counts were replayed on
2026-09-08 using the certificate's point-count functions.
Passing to F₂₅ is substantive. No absence of common covers or
ordinary-pullback theorem is inferred.
