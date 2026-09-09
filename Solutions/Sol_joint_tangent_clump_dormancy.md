# Proof: pointed extensions, finite projective monodromy, and first instability

[Statement](../Theorems/Thm_joint_tangent_clump_dormancy.md).
Author /root,2026-09-09. Independent medium audit PASS,
/root/audit_joint_tangent_clump,2026-09-09; no blocking objection.
The audit checks this proof, not a fresh re-audit of every dependency.
Version3 adds the intrinsic identification in Section4a. Sections1--4
and the narrower version2 application passed the existing audit;
the NEW Section4a and strengthened application passed a separate fresh
medium audit, /root/audit_intrinsic_oper_identification,2026-09-09.
Neither audit is a fresh verification of every existing dependency.
Version4 adds reducedness at the end of Section4 and the full-height
contact congruences in Section4b; these short additions are author prose,
not part of either earlier audit.
All maps of curves retained below are actual finite
etale maps; Frobenius is applied only to their vector bundles.

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

    H^1(C^(1),omega_(C^(1))^(-a)) → H^1(C,omega_C^(-5a)).

Indeed let B be the image of d:F_*O_C→F_*omega_C. Tensor
0→O_(C^(1))→F_*O_C→B→0 by omega^(-a). Its possible kernel on H^1 is
an image of H^0(B tensor omega^(-a)). The latter injects into

    H^0(F_*omega_C tensor omega^(-a))
       =H^0(C,omega_C^(1-5a))=0.

Iteration shows that a nonzero extension of omega_C by O_C never becomes
split under Frobenius. All twists may equivalently be handled by descent
to one finite field and absolute Frobenius there.

## 2. A common positive pointed bundle cannot be strongly semistable

Take matching pointed extensions

    0→O_i --e_i--> E_i --q_i--> omega_i→0

on X,Y, with an isomorphism f*E_X=g*E_Y preserving the two arrows.
Assume, for contradiction, that the normalized rank-two bundles are
strongly semistable. Choose theta characteristics theta_i; they need NOT
match on Z. The bundles E_i tensor theta_i^(-1) have degree zero.

Over an algebraic closure of a finite field, some Frobenius pullback of
each is trivialized by a finite etale cover. Here is precisely the input:
[Deninger--Werner, Theorem18(c), pp.573–574](https://www.numdam.org/item/ASENS_2005_4_38_4_553_0.pdf),
whose proof was read. Descend the bundle and curve to F_q. Boundedness
gives finitely many isomorphism classes of rank-two semistable degree-zero
bundles over F_q, so the Frobenius sequence repeats. A repeated iterate is
Frobenius-periodic, and Lange--Stuhler trivializes that iterate etale.
This is the finite-field result; no claim of this kind over arbitrary
algebraically closed fields is used, and no mixed-characteristic lifting
from that paper is used. Increase the two exponents to one common n.

Write L for the maximal unramified extension of k(Z) in a fixed separable
closure. It is also the maximal unramified extension of EACH specified
endpoint field: etale covers base change and compose, and etale Galois
closures remain etale. Thus

    G_X=Gal(L/k(X)), G_Y=Gal(L/k(Y))

are actual field-automorphism groups. No FINITE simultaneous Galois cover
is assumed. Let P_i=P(F^(n)*E_i), using projectivized lines. Each P_i
has a global projective frame on a finite connected etale endpoint cover.
These frames compare on a connected common finite etale refinement of Z.
The comparison is a morphism from a smooth projective curve to the affine
group PGL_2; it is constant. Therefore we can fix ONE projective frame
over L compatible, up to a constant matrix, with both endpoint frames.

The distinguished subline F^(n)*O_i gives, in this frame, a rational
coordinate t in L. Each sigma in G_X or G_Y acts on t by a constant
Möbius transformation. To verify constancy, compare a frame and its
sigma-translate on a finite proper etale cover dominating their fields
of definition; both are global frames of the same projective bundle.
For each endpoint the set of transformations is finite: its frame is
defined over a finite etale extension, whose pointwise stabilizer fixes
the frame. Equivalently, first choose a Galois etale trivializing cover
of that endpoint and its finite projective monodromy group.

The two finite sets of matrices have entries in one finite subfield of k.
They generate a finite subgroup H of PGL_2(k). A nonconstant rational
invariant R(t) for H is consequently fixed by both G_X and G_Y. Notice
that no compatibility of arbitrary changes of endpoint embeddings is
claimed: these two groups fix the ORIGINAL endpoint fields in L.

The coordinate t is nonconstant. On an actual connected etale cover
trivializing F^(n)*(E_X tensor theta_X^(-1)), the subline O gives two
basepoint-free sections of the positive-degree line theta_X^(5^n),
pulled back to that cover. A constant ratio would give a nowhere-vanishing
section of this positive-degree line, impossible. Hence R(t) is also
nonconstant, and

    R(t) in L^(G_X) intersect L^(G_Y)=k(X) intersect k(Y)=k

is a contradiction. The distinction between linear and projective frames
is important: theta_X and theta_Y were never assumed compatible.

## 3. A nonzero shared tangent creates a clump

Let 0!=xi=f*xi_X=g*xi_Y be a common tangent class. By the injectivity
of negative-degree cohomology under etale pullback, both endpoint classes
are nonzero. Their pointed extensions have a unique identification on Z,
since its possible differences lie in H^0(Z,omega_Z^(-1))=0.

Section2 rules out normalized strong semistability. Thus some iterate
E_i^(n)=F^(n)*E_i is unstable; etale preservation and reflection make the
first such index the SAME on both endpoints and their common source.
Let N_i be its maximal line. Its degree is greater than
5^n(g(C_i)-1)>0, and its pullbacks are the same line in E_Z^(n).

Projection N_i→omega_i^(5^n) is nonzero: otherwise N_i would lie in O_i,
contradicting its positive degree. Its zero divisor Delta_i is nonempty:
an empty divisor would identify N_i with the quotient, splitting the
extension E_i^(n), contrary to Section1. Both projection maps are obtained
by pullback from their endpoints, so

    f*Delta_X=g*Delta_Y=Delta_Z.

Their nonempty finite support is saturated under BOTH original maps,
hence is a clump. This proves that no-clump spans have no shared tangent.
This argument did not require a genus-two endpoint, ordinarity, or Hom-zero.

## 4. Genus two makes the first instability an oper

Now g(Y)=2. Every nontrivial extension 0→O_Y→E_Y→omega_Y→0 is
semistable. A destabilizing line would have degree>=2 and map nontrivially
to omega_Y of degree2; equality would split the extension and a larger
degree is impossible. Consequently the common first index n is >=1.

The canonical connection on E_Y^(n)=F*E_Y^(n-1) has zero p-curvature.
Its second fundamental map on the maximal line is

    N_Y → (E_Y^(n)/N_Y) tensor omega_Y.                 (1)

It is nonzero. If N_Y were horizontal, Cartier descent would give a
saturated line in E_Y^(n-1); its pulled-back slope would destabilize the
previous semistable iterate. Cartier descent here is the usual equivalence
between vector bundles and flat connections of zero p-curvature; a
horizontal subbundle and its locally free quotient descend as well.

The source of (1) has degree deg N_Y>5^n. Its target has degree
2*5^n-deg N_Y+2. Therefore

    5^n<deg N_Y<=5^n+1.

Integrality forces deg N_Y=5^n+1. Equation(1) is then a nonzero map of
equal-degree line bundles, so is an everywhere isomorphism. Thus
N_Y²=omega_Y^(5^n+1). Pulling (1) to Z, and then using the corresponding
maximal line over X, proves the SAME isomorphism over X. In particular
deg N_X=(5^n+1)(g(X)-1). No arithmetic divisibility of either map degree
is used.

The projectivizations of E_i^(n), with their canonical zero-p-curvature
connections and lines N_i, are consequently regular dormant PGL_2-opers.
Their projective connections match on Z, because EVERY constituent of
this construction was pulled back from the same pointed extension there.
One may choose theta_i²=omega_i and tensor by theta_i^(-5^n), the INVERSE
square root of the determinant, with its canonical Frobenius connection,
to use trace-free rank-two notation. Indeed
theta_i^(5^n)=F*(theta_i^(5^(n-1))), with n>=1. The projective object is independent
of the square-root choice. The oper second fundamental isomorphism is the
local transversality which guarantees regularity, not merely rational
agreement of potentials.

The projection divisor is in fact REDUCED, not just uniform. Near a zero,
use a local frame (e,v) of E in which e is the specified nowhere-vanishing
section. Its Frobenius frame (e,v) of E^(n) is horizontal. A local
generator of N has the form A e+B v, with A a unit at this point and
B vanishing. The second fundamental map is, up to units, d(B/A).
Its being an isomorphism forces B/A to have a SIMPLE zero. Thus
Delta_Y has exactly5^n-1 points and Delta_X has exactly
(5^n-1)(g(X)-1) points. Their equal pullbacks already give the nonempty
clump. No bound on n follows from this observation.

## 4a. The distinguished horizontal section identifies WHICH oper

Put m=5^n and Q_i=E_i^(n)/N_i. The second fundamental isomorphism
beta_i:N_i->Q_i tensor omega_i, together with det E_i^(n)=omega_i^m,
gives a SPECIFIED isomorphism

                         Q_i² ≅ omega_i^(m-1).             (2)

Project the distinguished horizontal section e_i to q_i in H^0(Q_i).
It is nonzero: otherwise its nowhere-vanishing image would identify the
positive line N_i with O_i. Its zero divisor is exactly Delta_i, since
the wedge with e_i also identifies the projection N_i->omega_i^m with
the same section, up to sign. Squaring removes that sign. Thus (2) gives
regular tensors sigma_i=q_i² of weight m-1, with divisor2Delta_i.
ALL maps defining (2) pull back from the same pointed Frobenius bundle,
so these are actual shared tensors, not just proportional divisor classes.

Here is an explicit local computation fixing the potential and its sign.
Choose a separating coordinate x and a frame (n0,n1) with n0 spanning N
and n0 wedge n1=(dx)^m, horizontal for the determinant connection.
After a local etale square-root rescaling, normalize beta(n0)=n1 dx.
This is possible because beta is an isomorphism and2 is invertible.
The connection then has the form

     nabla(n0)=(A n0+n1)dx,    nabla(n1)=(C n0-A n1)dx.

Write the horizontal distinguished section as e=v n0+u n1.
Its two horizontal equations are v'+Av+Cu=0 and u'+v-Au=0.
Eliminating v gives

                   u''=(A'+A²+C)u=r u.                    (3)

This r is exactly the scalar potential of the induced projective oper.
For standard determinant-one notation, tensor by the inverse horizontal
square root of omega^m as in Section4; the quotient coefficient remains u.
Under (2), the shared tensor has local expression

                         sigma=u²(dx)^(m-1).              (4)

Indeed in this normalized frame n0 wedge n1=n1² dx for the beta-induced
identification. Equations(3)--(4) require only etale-local frames; their
rational tensors and projective connections already descend globally.

By canonical_intersection, the shared ring is k[s], say s=a(dx)^d,
and sigma=c s^j where d*j=m-1 and c in k*. In particular5 does not divide
d and j=-1/d in k. Differentiating u²=c a^j gives

 r=u''/u=(j/2)a''/a+(j/2)(j/2-1)(a'/a)²
          =-a''/(2d a)+(2d+1)(a'/a)²/(4d²)=r_s.           (5)

Thus the dormant oper from first instability is not an unspecified
common connection: it is PRECISELY the intrinsic connection r_s of the
primitive tensor. This additional argument is necessary in a split
active pencil. Version2 correctly noted that merely producing SOME
dormant companion was insufficient.

Since Delta_i is reduced, sigma_i has zero order exactly2 at every
point of its support. In sigma=c s^j, the exponent j must therefore
divide2. The primitive weight/zero-order pair is exactly
((5^n-1)/2,1) or (5^n-1,2). Arbitrary repeated clump multiplicities
are not additional cases of this pointed-extension construction.

## 4b. The FULL Frobenius height controls local branch contact

Put P=5^n. In a local coordinate z choose a frame (e,v) of E whose
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

This improves the off-clump congruence from modulo5 to moduloP, but
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

## 5. Rigidity and the remaining obstruction

If there is an active common nilpotent connection, the exact spectrum
coreless_connection_spectrum makes r_s active. In primitive weight4 it
is the unique common connection; in primitive weight2 (or1) it is the
active midpoint, NOT either dormant companion. Equation(5) would instead
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
[negative-extension theorem](Sol_two_leg_negative_extensions.md) owns
the stronger Witt-lifting consequences; version5 removes the obsolete
weaker paragraph here. The local FL boundary is recorded separately in
[FL_CONTACT_TWO_BOUNDARY](../Research/FL_CONTACT_TWO_BOUNDARY.md).
None of these results excludes the characteristic-five span itself.
