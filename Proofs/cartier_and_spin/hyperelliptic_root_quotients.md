# Proof: the hyperelliptic involution separates the root geometry

[Statement](../../Theorems/cartier_and_spin/hyperelliptic_root_quotients.md).
Author /root,2026-09-09. The genus-two superspecial calculation in
the earlier quadratic Cartier certificate already used this biquadratic
construction. Here the quotient, its Cartier test and actual two-leg
compatibility are stated for arbitrary hyperelliptic genus and odd p.
No new independent audit is claimed.

## Geometry and the actual etale quotient

The odd-valuation supports of F and P are disjoint and nonempty, so
their square classes are independent in k(u). Thus B is connected
and B→P1 is a biquadratic cover. Its inertia at finite branch points
changes just v or just w. At infinity only v ramifies: deg F is odd
and deg P is even. Therefore the diagonal involution (v,w)↦(-v,-w)
acts freely everywhere, and its quotient is C, with z=vw. This proves
that h:B→C is etale, including infinity, not merely generically so.

The equation of C has squarefree degree4g-1, hence genus2g-1;
etale Hurwitz gives genus(B)=4g-3. The third quotient E has genus g-2.
The three nontrivial character summands of the biquadratic action
give J_B~J_Y×J_E×J_C. More concretely the pullbacks of the three
Jacobians give an isogeny: their character projectors are (1±sigma)/2,
their dimensions add to g(B), and the inverse projectors have only
powers of2 in their denominators. The kernel is therefore killed by
a power of2, so this isogeny is prime to p.

Since alpha=w du/v=P du/(vw), it descends to alpha_C. At each root
of P, z is a parameter, du/z is a unit, and P has order2; thus alpha_C
has order2. At roots of F it is a unit. At infinity du/z has order
4g-4 and P has pole order4g-4, so alpha_C is again a unit. This proves
the full differential divisor. Also alpha² is the pullback of q,
which identifies B with its canonical root cover.

## Both new legs and corelessness

The matching tensor on Z has a nonempty simple zero divisor: etale
pullback preserves the divisor orders of q. Its quadratic root W→Z
is therefore connected and ramified. The root q_X also has simple
zeros, so A→X is connected. The specified tensor equality identifies

    W=Z×_X A=Z×_Y B

after normalization. Both products are connected, since an etale
extension cannot contain either ramified quadratic root field.
Normalization commutes with etale base change. Thus W→A and W→B
are finite etale, and composing W→B with the proved etale h gives
the claimed second leg W→C. The root forms agree, with compatible
sign choices.

To retain corelessness, put L=k(Z), K=k(W). If t belongs to both
embedded k(A),k(B), its characteristic polynomial on the degree-two
extension K/L is obtained by scalar extension both from k(A)/k(X)
and from k(B)/k(Y). Its coefficients therefore lie in k(X)∩k(Y)=k.
Thus t is algebraic over k and is constant. The smaller subfield
h^*k(C)⊂k(B) has the same trivial intersection with k(A). This proves
corelessness in the ACTUAL new source, without a presumed common
Galois closure or an arbitrary replacement of either map.

## The scalar Cartier calculation

Put e=(p+1)/2. On C one has

    alpha_C=z^(-p) F^((p-1)/2) P^e du.

Cartier extracts powers u^(pi+p-1), taking p-th roots of coefficients.
The degree of the polynomial on the right is
((4g-1)p-3)/2, so its Cartier output has degree at most2g-2. Comparison
with P du/z gives exactly(Q), including all coefficient roots.

The same equations describe C_1(q^e)=q. Indeed on B their pullbacks
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
eigenspace of H0(B,omega_B) for w↦-w. Regularity holds even at the
ramification divisor: a pulled-back regular quadratic has order at
least2 there, exactly the zero order of alpha. Conversely multiply
a minus eigenform by alpha and descend; the same valuation calculation
gives a regular quadratic on Y. Cartier's projection formula gives

    pi^*C_1(q^(e-1)t)=alpha C(pi^*t/alpha).

The minus eigenspace is the sum of the E and C character spaces.
Their prime-to-p pullbacks intertwine Cartier, so its kernel dimension
is a(E)+a(C). In genus two E is rational and contributes zero.

The connection interpretation uses the precise inverse-character
criterion in the retained source-checked note
[ordinary indigenous inverse characters](../../routes/global/ORDINARY_INDIGENOUS_INVERSE_CHARACTER_CARTIER_CRITERION.md),
Sections1–3. That interpretation is not used for the geometric or
Cartier proofs above. In particular it does not transfer endpoint
ordinariness to a new, possibly nonhyperelliptic common source.
The primary formula was rechecked directly in
[Mochizuki, Ordinary p-adic Curves](https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Theory%20of%20Ordinary%20p-adic%20Curves.pdf),
ChapterII, Lemma2.11, Proposition2.12, Theorem2.13 and Definition3.1
(PDF pp.73–75,80). The proofs identify the dual infinitesimal
Verschiebung with Cartier after multiplication by the square Hasse
invariant. In the normalized root model that invariant is
minus s^(4/d), as computed in the linked note. Its sign does not
affect invertibility. This is a source check, not an independent audit.

## Genus-two nonsplit quartics

Every unmarked genus-two indigenous connection is fixed by the
hyperelliptic involution: it acts trivially on the quadratic-differential
translation space, and an affine translation of order2 in
characteristic5 must be zero. The natural square Hasse quartic is
therefore invariant. This is the argument in the retained
[hyperelliptic invariance proof](../../routes/global/GENUS_TWO_HYPERELLIPTIC_INDIGENOUS_INVARIANCE_AND_COMPLETE_UNMARKED_QUARTIC_POOL.md),
not a claim that all genus-two quartics are invariant.

There are six Weierstrass points and deg D=4, so infinity can be chosen
outside D. Then A has degree4. A finite nonbranch root of A must have
multiplicity2, while a branch root must have multiplicity1, since the
corresponding orders of s are2. Thus A=RH² as stated, with b=0,2,4.
The case b=0 is the quadratic case already treated. For b=2 or4,
R represents a nontrivial branch-pair two-torsion class on Y, so the
fourth-root extension is connected of degree4. Equivalently, its square
subextension adjoins sqrt(R), a nontrivial etale quadratic extension;
a fourth root cannot then have degree2. Tame Hurwitz gives genus9.

Put kappa=w²/H, so kappa²=R, and set z=vw/kappa. Then

    z²=kappa S H, z^4=R S² H², alpha=w du/v=H du/z.

The diagonal involution fixes z and has this degree-four quotient over
k(u). It is free: at R-roots the inertia in the order-eight total cover
is generated by (w,v)↦(i w,-v), whose square is(-w,v); at H-roots it
is(-w,v); at S-roots and infinity it is(w,-v). None contains(-w,-v).
This checks every point, including infinity, so the quotient is etale
and has genus5.

Let sigma be induced by w↦i w. On C it sends z↦-i z, and alpha has
character i. The forms in character i are

    span{du/z,u du/z} if b=2,    span{du/z} if b=4.

To check this, du/z is regular at every finite point; at infinity its
order is2 or0 respectively. A rational coefficient with a finite pole
cannot remain regular there: at R a pole subtracts4 from order2, and
at an index-two point it subtracts2 from order0. Thus the coefficient
is a polynomial, and the infinity bound gives the displayed basis.

For the inverse character -i, du/z³ needs one factor of S H at its
index-two finite branch points and no factor at R. After these factors
its infinity order is4. Hence its complete basis is S H u^j du/z³,
j=0,1,2. Since z^4=G:=R S² H²,

    S H G³=(S H)^5 F² A,

Cartier on this basis is exactly the matrix(K), with coefficient fifth
roots on the output. These calculations prove the full character
dimensions and the coefficient formula without a smooth-plane-model
assumption.

We recall why the two inverse character Cartier kernels have the same
dimension. In H=H1_dR(C), let A0=ker F and B0=ker V. The BT1 identities
im V=A0 and im F=B0 give dim A0_rho+dim B0_rho=dim H_rho. Polarization
pairs rho with rho^-1, and makes A0_rho perpendicular to A0_(rho^-1),
and B0_rho perpendicular to B0_(rho^-1). Consequently

    dim(A0_rho intersect B0_rho)
       =dim H_rho/(A0_rho+B0_rho)
       =dim(A0_(rho^-1) intersect B0_(rho^-1)).

These are the respective Cartier-kernel dimensions. The characters
are F5-valued, so Frobenius does not permute them. The normalized root
form alpha is nonzero and Cartier-fixed. Thus its character block has
kernel dimension at most1 for b=2, and zero for b=4. The same holds
for the inverse block(K). The inverse-character indigenous criterion
quoted above identifies its invertibility with indigenous ordinariness.
No ordinariness of the intermediate elliptic quotient
when b=4 is required.

In applying this to a span, the diagonal quotient preserves an ACTUAL
etale upper leg to B. But a fourth-root cover pulled back to the common
source can split into quadratic components. The earlier degree-two
Cartesian corelessness proof therefore has not been extended to this
case. This distinction is essential when retaining the original fields.
