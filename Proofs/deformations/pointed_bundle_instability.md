# Proof: Grassmannian quotient rigidity and transverse pointed extensions

[Statement](../../Theorems/deformations/pointed_bundle_instability.md) · [Independent structural review](../../Research/audits/COMMON_GRASSMANNIAN_QUOTIENT_RIGIDITY_AUDIT_2026_10_03.md).

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

## 2. Common strongly semistable quotients preserve slope

Work over $k=\overline{\mathbf F}_p$ in any characteristic.
Let $E_X,E_Y$ be strongly semistable of rank $N$, with their
ACTUAL comparison, and let $E_C\twoheadrightarrow I_C$ be
compatible locally free quotients of rank $0<r\le N$.

A strongly semistable rank-N bundle becomes projectively trivial
after Frobenius and a finite etale cover. Write N=p^a m, with p not
dividing m. An exact-order m Jacobian torsion point supplies a connected
cyclic etale cover of degree m (the identity when m=1). The pullback of
F^(a)*E has degree N deg E, hence integral slope. Twist by a line
bundle of that slope to obtain strongly
semistable degree zero. Such a bundle over bar(F_p) is trivialized after
some Frobenius power and finite etale cover, by
[Deninger--Werner, Theorem18(c), pp.573–574](https://www.numdam.org/item/ASENS_2005_4_38_4_553_0.pdf).
This is the finite-field Frobenius-periodicity/Lange–Stuhler theorem.
Consequently, on an actual etale cover, a Frobenius pullback of E is
M^(direct-sum N), with arbitrary deg M. Increase both endpoint exponents to one
common n and take Galois etale trivializing covers.

Let $X'\to X$ and $Y'\to Y$ be these individual finite etale
Galois trivializing covers. Choose one connected component $T$
of $X'\times_X Z\times_Y Y'$ over the ACTUAL source $Z$.
Its maps to $X',Y'$ are finite etale and surjective.
The two projective frames compare on $T$ by a morphism to the
affine group $\operatorname{PGL}_N$. Properness makes it constant;
adjust the $Y'$ frame by this constant.

The quotient maps $X',Y'\to\operatorname{Gr}_r(k^N)$ now agree
on $T$. Each individual deck group acts by constant projective
matrices, again by properness and affineness, and has finite image.
Both matrix groups and the frame comparison lie in one finite
subfield of $k$. Thus they generate a finite
$H\subset\operatorname{PGL}_N(k)$.
The Grassmannian has a finite geometric quotient by $H$,
including when $p\mid|H|$: take invariant affine neighborhoods
of finite orbits and their integral invariant-ring quotients.

Composing with this quotient gives deck-invariant maps, which
descend to the ORIGINAL $X$ and $Y$. Their pullbacks agree on
$T$, hence on $Z$ by faithful flatness. A curve as common image
would put its function field in $k(X)\cap k(Y)$ inside $k(Z)$,
contradicting corelessness. The common image is therefore a point.
Finiteness makes the Grassmannian map constant on each connected
trivializing cover. No Galois closure of the two-leg span was used.

There the quotient is a fixed vector-space quotient of
$M^{\oplus N}$, hence is $M^{\oplus r}$. Equality of slopes
descends through the actual cover and the Frobenius power:
$\mu(I_C)=\mu(E_C)$.
Apply the same argument to every Frobenius pullback of the
quotient. A quotient of a semistable bundle with the same
slope is semistable, so $I_C$ is strongly semistable.
Duality proves the saturated-subbundle assertion.
Every actual morphism image is locally free on a smooth curve
and is a compatible quotient of its source; the assertion
therefore applies to images before any saturation.

This stronger statement immediately proves the positive
pointed-bundle principle: the matching nowhere-zero section
gives a compatible saturated subline $\mathcal O\subset E$,
whose slope zero would equal the positive slope of $E$.
If only a nonzero matching section is supplied, its saturation
$J\subset E$ instead has slope $\mu(E)$ and rank one.
Its zero divisors are ACTUAL common divisors of degree
$\deg J_C=\mu(E_C)$. Thus the slopes are integers and, when
positive, those divisors give a clump. This latter consequence
uses the section's saturation; it does not pretend that a
section with zeros trivializes a positive line.

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
the stronger Witt-lifting consequences.
None of these results excludes the characteristic-five span itself.
