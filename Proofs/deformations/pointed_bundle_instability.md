# Proof: finite projective monodromy and transverse pointed extensions

[Statement](../../Theorems/deformations/pointed_bundle_instability.md).

## 1. Two elementary bundle facts

Semistability of vector bundles is preserved and reflected by finite
etale covers. For preservation, pass to an etale Galois closure. The
unique destabilizing Harder--Narasimhan subbundle upstairs is deck-invariant
and descends by etale descent; its slope would destabilize downstairs.
This uses no averaging. Reflection follows by pulling back a destabilizing
subbundle. The same argument identifies the maximal line of an unstable
rank-two bundle after etale pullback. It applies separately at every
Frobenius iterate, since Frobenius commutes with these pullbacks.

For every hyperbolic curve C and a>=1, Frobenius pullback is injective on

    H^1(C^(1),omega_(C^(1))^(-a)) → H^1(C,omega_C^(-pa)).

Indeed let B be the image of d:F_*O_C→F_*omega_C. Tensor
0→O_(C^(1))→F_*O_C→B→0 by omega^(-a). Its possible kernel on H^1 is
an image of H^0(B tensor omega^(-a)). The latter injects into

    H^0(F_*omega_C tensor omega^(-a))
       =H^0(C,omega_C^(1-pa))=0.

Iteration shows that a nonzero extension of omega_C by O_C never becomes
split under Frobenius. All twists may equivalently be handled by descent
to one finite field and absolute Frobenius there.

## 2. Positive pointed bundles and finite projective monodromy

The argument works over k=bar(F_p), in any rank. Suppose bundles E_X,E_Y
of positive degree have nowhere-zero sections e_X,e_Y and an isomorphism
of their actual pullbacks carrying one section to the other. If one
bundle were strongly semistable, so would the other by Section1.
Rank one is impossible already: its section would trivialize it.

First, a strongly semistable rank-r bundle becomes projectively trivial
after Frobenius and a finite etale cover. Write r=p^a m, with p not
dividing m. An exact-order m Jacobian torsion point supplies a connected
cyclic etale cover of degree m (the identity when m=1). The pullback of
F^(a)*E has degree r deg E, hence integral slope. Twist by a line
bundle of that slope to obtain strongly
semistable degree zero. Such a bundle over bar(F_p) is trivialized after
some Frobenius power and finite etale cover, by
[Deninger--Werner, Theorem18(c), pp.573–574](https://www.numdam.org/item/ASENS_2005_4_38_4_553_0.pdf).
This is the finite-field Frobenius-periodicity/Lange–Stuhler theorem.
Consequently, on an actual etale cover, a Frobenius pullback of E is
M^(direct-sum r), with deg M>0. Increase both endpoint exponents to one
common n and take Galois etale trivializing covers.

Let K^ur be the maximal unramified extension of k(Z) in a fixed separable
closure. It is also the maximal unramified extension of each original
endpoint field: etale covers base change and compose, and their etale
Galois closures remain etale. Thus G_i=Gal(K^ur/k(C_i)) are actual
field-automorphism groups. Projective frames of P(F^(n)*E_i) compare on
a connected common finite etale refinement of Z by a morphism to the
affine group PGL_r. Properness makes that comparison constant, so choose
one compatible frame over K^ur.

The distinguished section now defines x in P^(r-1)(K^ur). Each G_i acts
on x by constant projective matrices. These form a finite group for
each endpoint: the subgroup fixing its Galois trivializing cover fixes
the frame. The two matrix groups have entries in one finite subfield
of k and therefore generate a finite H subset PGL_r(k). This construction
uses the original endpoint embeddings, with no finite simultaneous
Galois closure assumed.

On an endpoint trivializing cover, the coordinates of e are sections
of the positive line M with no common zero. They define a nonconstant
map to P^(r-1): a constant image would make them constant multiples of
one nowhere-zero section, contradicting deg M>0. The finite quotient
P^(r-1)->P^(r-1)/H therefore still has a curve as image. A rational
function on the quotient, defined at this image's generic point and
nonconstant along it, evaluates at x to a nonconstant element of K^ur.
It is fixed by both G_X and G_Y, contradicting

    (K^ur)^(G_X) intersect (K^ur)^(G_Y)=k(X) intersect k(Y)=k.

The quotient step also holds when p divides |H|: a finite morphism
preserves the image dimension. One can lift any nonconstant function
of the image curve from the quotient's local ring at its generic point.
This proves the pointed-bundle principle without compatible theta roots.

## 3. A nonzero shared tangent creates a clump

A nonzero shared tangent gives nonsplit pointed extensions
0→O_i→E_i→omega_i→0, with a unique matching on Z because
H^0(Z,omega_Z^(-1))=0. Sections1–2 give a common first Frobenius
instability index n. The maximal lines N_i then have positive degree
greater than p^n(g(C_i)−1) and agree after the actual pullbacks.

Projection N_i→omega_i^(p^n) is nonzero by positivity and has a
nonempty zero divisor: otherwise it would split the extension.
These projection divisors have equal pullbacks, whose finite nonempty
support is saturated under both maps. It is a clump.

## 4. A common pointed-oper calculation

Here is the calculation shared by tangent and Witt-lifting extensions.
Let P be a positive multiple of the odd characteristic p. Suppose
matching nonsplit extensions

    0→O_i --e_i→ E_i →omega_i^P→0

carry matching regular connections with nabla(e_i)=0 and the canonical
determinant connection. Assume g(Y)=2, the bundles are unstable, and
their maximal lines N_i are not horizontal. The second fundamental
map beta_i:N_i→Q_i tensor omega_i, Q_i=E_i/N_i, is then nonzero.
On Y its slope bounds are

                     P<deg N_Y<=P+1.

Thus deg N_Y=P+1 and beta_Y is an isomorphism. Pullback to Z and
descent along the other leg give the same isomorphism on X:
N_i²=omega_i^(P+1).

The projection N_i→omega_i^P has a nonempty divisor Delta_i by
nonsplitting. It is reduced. At a zero write a generator as A e+B v,
with A a unit and B vanishing. Since nabla(e)=0, the coefficient of
n wedge nabla(n) modulo B is A dB. Invertibility of beta forces B to
have a simple zero. Hence

       |Delta_i|=(P−1)(g(C_i)−1),   f*Delta_X=g*Delta_Y.

For a tangent extension on genus-two Y, index zero is semistable:
a line of degree at least two would project isomorphically to omega_Y
and split it. Its first instability index is therefore n>=1.
The canonical connection on F^(n)*E has zero p-curvature, and its
maximal line cannot be horizontal, since Cartier descent would
destabilize the preceding iterate. Apply the calculation with P=p^n.
This gives the matched regular dormant projective opers and their
reduced divisors. The entire construction uses the original pointed
extensions and their actual pullbacks.

## 4a. The distinguished section identifies the intrinsic oper

In the general calculation of Section4, beta and the determinant give
a specified isomorphism Q_i²≅omega_i^(P−1). The projection q_i of e_i
to Q_i has zero divisor Delta_i: both projections are given, up to
sign, by wedging with e_i. Thus sigma_i=q_i² are actual matching
tensors of weight P−1 and divisor 2Delta_i.

Locally choose a separating parameter x and a frame (n0,n1) with n0
spanning N, n0 wedge n1=(dx)^P, and beta(n0)=n1 dx. The last
normalization requires only an etale square root of a unit. Horizontality
of the determinant gives

    nabla(n0)=(A n0+n1)dx,   nabla(n1)=(C n0−A n1)dx.

Writing e=v n0+u n1, the horizontal equations are
v'+Av+Cu=0 and u'+v−Au=0. Elimination gives

    u''=(A'+A²+C)u=r u,   sigma=u²(dx)^(P−1).              (3)

This is the scalar potential of the projective oper. The computation
uses the horizontal distinguished section and determinant, so it also
applies to the active FL connection.

By [the canonical-ring theorem](../shared_tensors/matched_section_rings.md),
the shared ring is k[s], say s=a(dx)^d, and sigma=c s^j with
dj=P−1. In particular p does not divide d or j, and j=−1/d in k.
Differentiating u²=c a^j yields

    r=u''/u
     =−a''/(2d a)+(2d+1)(a'/a)²/(4d²)=r_s.                (4)

Thus this oper is the intrinsic connection of the primitive tensor.
Since div(sigma)=2Delta with Delta reduced, j divides two. The
primitive (weight,zero order) is ((P−1)/j,2/j), with
j dividing gcd(2,P−1). For P=p^n this gives the two stated pairs.
This proves both the identification and the multiplicity assertion
in every odd characteristic.

## 4b. The FULL Frobenius height controls local branch contact

Put P=p^n. In a local coordinate z choose a frame (e,v) of E whose
second vector maps to dz in the quotient omega. In the induced
F^(n)*E frame write the oper line as span(T(z)e+v). Transversality
says T' is a unit where T is finite. Its poles are precisely Delta,
and are simple by the preceding argument.

Compare two distinct branches with equal tangent at the same point
of a preserving joint image. Their comparison is a formal automorphism
phi(z)=z+c z^I+... with c!=0,I>=2 of the endpoint, and an identification
of its pointed extension. The latter preserves e and induces phi' on
the quotient omega, so its matrix BEFORE Frobenius has diagonal(1,phi')
and one upper-right coefficient B(z). After n Frobenius pullbacks,
preservation of the unique HN line gives

                   T(phi(z))-(phi'(z))^P T(z) in k((z^P)).       (6)

Indeed the expression is minus B(z)^P. This retains the entire height
n; ordinary differentiation alone would only retain its first level.

Away from Delta, change v by a constant multiple of e to arrange T(0)=0.
This is allowed also after Frobenius since every constant has a P-th
root. Write T(z)=a z+..., a!=0. The first changed term on the left of(6)
is a c z^I: the correction from (phi')^P has order at least
P(I-1)+1>I. Thus P divides I.

At Delta write T(z)=a/z+..., a!=0. The first changed term is instead
-a c z^(I-2), while the (phi')^P correction has order at least
P(I-1)-1>I-2. Thus P divides I-2. The case I=2 is allowed: its leading
changed term is a constant and hence a P-th power.

Every ingredient is preserved by composition of the actual pointed
spans. The same calculation therefore applies to distinct branches
of any reduced union of their jointly minimal preserving images.
No new endpoint map or embedding was introduced.

This improves the off-clump congruence from modulo p to modulo P, but
does not satisfy the existing root-contact inequality at the clump.
For either primitive pair above, its reduced root data are
d0=(P-1)/2,e0=1,N=(P+1)/2. Contact2 downstairs still lifts to contact N,
giving mu=N-1 rather than the required mu>N. Hence the current global
contact budget cannot by itself exclude this remaining configuration.

Both local bounds are sharp even with(6), not just with its derivative.
Off the clump take T=z and phi=z+c z^P, c!=0. At the clump take T=1/z.
There is a unique A in1+z k[[z]] satisfying

                  A^(P-1)=(A^P+c z)²,

because the implicit derivative at(A,z)=(1,0) is-1. Put
phi=z/(A^P+c z). Direct differentiation gives phi'=A, and hence

                  T(phi)-(phi')^P T=c.

Here phi=z-c z²+..., so the contact is exactly2; the constant c is a
P-th power in k. These are formal local models, not actual global
coreless spans. They show why an improvement beyond these contact
bounds must use additional global information.

## 5. Active rigidity in characteristic five

Here p=5. If there is an active common nilpotent connection, the exact spectrum
coreless_connection_spectrum makes r_s active. In primitive weight4 it
is the unique common connection; in primitive weight2 (or1) it is the
active midpoint, NOT either dormant companion. Section4a would instead
make it dormant. Therefore EVERY active matched span with a genus-two
endpoint has zero joint curve tangent, including both-endpoint split
canonical doubles. The argument also proves rigidity if r_s is not
regular, and Section3 already proves it when there is no clump.

The remaining possibly nonrigid spans have a positive common generator
whose intrinsic r_s is regular and dormant. For the selected pair,
the existing spectrum identifies this as the Cartier-zero branch of
primitive weight greater than2. We do not exclude it here.

This does NOT identify a curve-deformation tangent with the nonordinary
oper defect on Z. The latter can be nonzero even when the simultaneous
curve-deformation tangent is zero. The later
[negative-extension theorem](two_leg_negative_extensions.md) owns
the stronger Witt-lifting consequences. The local FL boundary is recorded separately in
[FL_CONTACT_TWO_BOUNDARY](../../Research/notes/deformations/fl_contact_two_boundary.md).
None of these results excludes the characteristic-five span itself.

The common pointed-oper calculation and its all-odd-characteristic
applications have bounded medium audit PASS,
/root/audit_extension_fiber_scope,2026-09-14. Earlier scoped audits
are linked from the statement.
