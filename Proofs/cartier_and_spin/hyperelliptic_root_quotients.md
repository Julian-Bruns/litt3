# Proof: the hyperelliptic involution separates the root geometry

[Statement](../../Theorems/cartier_and_spin/hyperelliptic_root_quotients.md).
Mumford's hyperelliptic Prym theorem supplies the Jacobian decomposition;
Elkin's cyclic-cover basis supplies the character spaces. The tensor,
pointed-span and indigenous-connection arguments below are specific to
this record. Write C̃ for the root curve, following Mumford's cover notation.

## Geometry and the actual etale quotient

The odd-valuation supports of F and P are disjoint and nonempty, so
their square classes are independent in k(u). Thus C̃ is connected
and C̃→P1 is a biquadratic cover. Its inertia at finite branch points
changes just v or just w. At infinity only v ramifies: deg F is odd
and deg P is even. Therefore the diagonal involution (v,w)↦(-v,-w)
acts freely everywhere, and its quotient is C, with z=vw. This proves
that h:C̃→C is etale, including infinity, not merely generically so.

The equation of C has squarefree degree4g-1, hence genus2g-1;
etale Hurwitz gives genus(C̃)=4g-3. The third quotient E has genus g-2.
With Mumford's (C',C'')=(Y,E), his
[Prym Varieties I, §7, Theorem(a) and its hyperelliptic proof, p346](https://www.dam.brown.edu/people/mumford/alg_geom/papers/1974a--PrymVar-I-NC.pdf#page=22)
gives Prym(C̃/C)≅J_Y×J_E as principally polarized varieties and
J_C̃∼J_Y×J_E×J_C by a2-isogeny. It is prime to the odd characteristic.
Taking the character negative over Y also gives Prym(C̃/Y)∼J_E×J_C.

Since alpha=w du/v=P du/(vw), it descends to alpha_C. At each root
of P, z is a parameter, du/z is a unit, and P has order2; thus alpha_C
has order2. At roots of F it is a unit. At infinity du/z has order
4g-4 and P has pole order4g-4, so alpha_C is again a unit. This proves
the full differential divisor. Also alpha² is the pullback of q,
which identifies C̃ with its canonical root cover.

## Both new legs and corelessness

The matching tensor on Z has a nonempty simple zero divisor: etale
pullback preserves the divisor orders of q. Its quadratic root W→Z
is therefore connected and ramified. The root q_X also has simple
zeros, so A→X is connected. The specified tensor equality identifies

    W=Z×_X A=Z×_Y C̃

after normalization. Both products are connected, since an etale
extension cannot contain either ramified quadratic root field.
Normalization commutes with etale base change. Thus W→A and W→C̃
are finite etale, and composing W→C̃ with the proved etale h gives
the claimed second leg W→C. The root forms agree, with compatible
sign choices.

To retain corelessness, put L=k(Z), K=k(W). If t belongs to both
embedded k(A),k(C̃), its characteristic polynomial on the degree-two
extension K/L is obtained by scalar extension both from k(A)/k(X)
and from k(C̃)/k(Y). Its coefficients therefore lie in k(X)∩k(Y)=k.
Thus t is algebraic over k and is constant. The smaller subfield
h^*k(C)⊂k(C̃) has the same trivial intersection with k(A). This proves
corelessness in the ACTUAL new source, without a presumed common
Galois closure or an arbitrary replacement of either map.

## The scalar Cartier calculation

Put e=(p+1)/2. On C one has

    alpha_C=z^(-p) F^((p-1)/2) P^e du.

Cartier extracts powers u^(pi+p-1), taking p-th roots of coefficients.
The degree of the polynomial on the right is
((4g-1)p-3)/2, so its Cartier output has degree at most2g-2. Comparison
with P du/z gives exactly(Q), including all coefficient roots.

The same equations describe C_1(q^e)=q. Indeed on C̃ their pullbacks
are alpha C(alpha)=alpha², so nonzero alpha gives equivalence with
C(alpha)=alpha. Separable pullback of differentials is injective.

Each coefficient on the left of(Q) is homogeneous of degree e<p in
the a_j. Consequently the leading monomials of(Q), in any graded
order, are the pairwise coprime a_i^p. Buchberger's coprime criterion
proves that these equations are a Groebner basis, with basis monomials
whose individual exponents are below p. The length is p^(2g-1).
This length is NOT the number of good or reduced points.

For an infinitesimal variation Q=sum b_j u^j of P, the differential
of its coefficient equations is

    e [u^(pi+p-1)] (FP)^((p-1)/2) Q.

In the basis u^j du/z of H0(C,omega_C), the matrix with entries
[u^(p(i+1)-j-1)](FP)^((p-1)/2) is the usual Cartier coefficient matrix.
Its rank equals that of the semilinear Cartier operator. Since e!=0
in k, the asserted tangent dimension follows. For a finite scheme a
point is reduced iff its tangent space is zero. For a curve, Cartier
invertibility is exactly ordinariness.

## Full quadratic directions

The full quadratic-eigenform equations have the same form
x_i^p-P_i(x)=0, now in h0(omega_Y²)=3g-3 variables, with P_i of
degree e. The same leading-monomial argument gives length p^(3g-3).
Its tangent condition at q is C_1(q^(e-1)t)=0.

The map t↦pi^*t/alpha identifies H0(Y,omega_Y²) with the minus
eigenspace of H0(C̃,omega_C̃) for w↦-w. Regularity holds even at the
ramification divisor: a pulled-back regular quadratic has order at
least2 there, exactly the zero order of alpha. Conversely multiply
a minus eigenform by alpha and descend; the same valuation calculation
gives a regular quadratic on Y. Cartier's projection formula gives

    pi^*C_1(q^(e-1)t)=alpha C(pi^*t/alpha).

The minus eigenspace is the sum of the E and C character spaces.
Their prime-to-p pullbacks intertwine Cartier, so its kernel dimension
is a(E)+a(C). In genus two E is rational and contributes zero.

In characteristic five the connection interpretation is the
[Hasse–Cartier criterion](../projective_connections/hasse_cartier_criterion.md),
with square Hasse invariant minus s^(4/d).

## Genus-two nonsplit quartics

The [scalar model's automorphism corollary](../projective_connections/nilpotent_scalar_model.md)
makes every genus-two connection and its square Hasse quartic
hyperelliptic-invariant.

There are six Weierstrass points and deg D=4, so infinity can be chosen
outside D. Then A has degree4. A finite nonbranch root of A must have
multiplicity2, while a branch root must have multiplicity1, since the
corresponding orders of s are2. Thus A=RH² as stated, with b=0,2,4.
The case b=0 is the quadratic case already treated. For b=2 or4,
R represents a nontrivial branch-pair two-torsion class on Y, so the
fourth-root extension is connected of degree4. Equivalently, its square
subextension adjoins sqrt(R), a nontrivial etale quadratic extension;
a fourth root cannot then have degree2. Tame Hurwitz gives genus9.

Choose a primitive fourth root ζ. Put kappa=w²/H, so kappa²=R,
and set z=vw/kappa. Then

    z²=kappa S H, z^4=R S² H², alpha=w du/v=H du/z.

The diagonal involution fixes z and has this degree-four quotient over
k(u). It is free: at R-roots the inertia in the order-eight total cover
is generated by (w,v)↦(ζw,-v), whose square is(-w,v); at H-roots it
is(-w,v); at S-roots and infinity it is(w,-v). None contains(-w,-v).
This checks every point, including infinity, so the quotient is etale
and has genus5.

Let δ be induced by w↦ζw; it sends z↦ζ^−1z.
Use Elkin's D_i for the ζ^i-eigenspace and
ω_(i,j)=u^(j−1)h_(min,i) du/z^i. His
[§2, equations(2.2)–(2.4)](https://arxiv.org/pdf/0708.0431#page=5)
give h_(min,1)=1, h_(min,3)=SH and

    D_1=⟨du/z,u du/z⟩ if b=2,  D_1=⟨du/z⟩ if b=4;
    D_3=⟨SH u^j du/z³ : 0≤j≤2⟩.

These formulas include infinity through

    dim D_i=ceil(i·deg(RS²H²)/4)−1−deg h_(min,i).

For G=RS²H², the identity SH G³=(SH)^5 F²A and Cartier's projection
formula give exactly(K), with fifth roots of output coefficients.

The [polarized Cartier-kernel lemma](../projective_connections/hasse_cartier_criterion.md#3-inverse-character-kernels-have-equal-dimensions)
equates the two inverse-character kernel dimensions. The normalized root
form alpha is nonzero and Cartier-fixed. Thus its character block has
kernel dimension at most1 for b=2, and zero for b=4. The same holds
for the inverse block(K). The inverse-character indigenous criterion
quoted above identifies its invertibility with indigenous ordinariness.
No ordinariness of the intermediate elliptic quotient
when b=4 is required.

In applying this to a span, the diagonal quotient preserves an ACTUAL
etale upper leg to C̃. But a fourth-root cover pulled back to the common
source can split into quadratic components. The earlier degree-two
Cartesian corelessness proof therefore has not been extended to this
case. This distinction is essential when retaining the original fields.
