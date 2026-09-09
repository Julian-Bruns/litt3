# The no-clump Schwarzian obstruction for an ordinary genus-two endpoint

Decide the precise implication (NC) below: prove it, or give an actual
counterexample satisfying every hypothesis. It is an intermediate lemma
toward Litt's common finite-etale-cover problem over bar(F5), not a request
to solve that whole problem. Work with the supplied results without
rederiving them. No local files are available to you.

## Target

Let k=bar(F5). Let X,Y,Z be smooth projective connected curves, g(X)>2,
g(Y)=2, and Y ordinary. Suppose there are ACTUAL finite ETALE maps

    X <-f- Z -g-> Y,

with k(X) intersect k(Y)=k inside k(Z), and Hom_k(J_X,J_Y)=0.
Identify canonical tensors by the actual differential pullbacks. Assume

    f*H0(X,omega_X^m) intersect g*H0(Y,omega_Y^m)=0
    for EVERY integer m>=1.                              (H)

Is there a regular projective connection on each endpoint whose
pullbacks to Z agree?                                     (NC)

The conclusion, if true, is automatically UNIQUE and DORMANT. Existence
is the task; proving only uniqueness or dormancy does not answer it.
Neither map degree is assumed prime to5 and neither leg is Galois.

Here a projective connection has local equation v''=r v and transforms
by r_t=(dx/dt)^2 r_x-{x,t}/2, where
{x,t}=x'''/x'-(3/2)(x''/x')^2 is the Schwarzian derivative. Regularity
means regular in every local uniformizer. Differences are quadratic
differentials. In characteristic5 dormancy is r''-3r^2=0 in every
separating coordinate. These definitions concern projective connections,
not an arbitrary connection on an unspecified rank-two bundle.

## An exact rational formulation of the same missing step

Replace Z by the normalization of its ACTUAL joint image, so its field
is M=F_X F_Y. This preserves both etale maps and (H). Choose separating
x in F_X and u in F_Y; let D=d/dx on M and b=Du!=0. Then (NC) is
equivalent to solvability of the single additive-separation equation

    R_X-b^2 R_Y = -(1/2){u,x},
    R_X in F_X, R_Y in F_Y.                              (S)

All fields here have their specified embeddings in M. In particular,
the question is whether the ACTUAL Schwarzian class vanishes in

    M/(F_X+b^2 F_Y).

The quotient is of additive k-vector spaces, not a field quotient.
Vanishing is independent of the separating coordinates. Arbitrary
solutions in M with no endpoint descent do not count.

A common rational solution is already regular: its nonempty pole set,
if any, would be a finite set saturated under BOTH maps, called a clump.
Over bar(F5), for a coreless etale span, a clump exists iff the common
regular canonical tensor ring is not k. Thus (H) excludes those poles.
Similarly (H) makes a common regular quadratic zero, proving uniqueness.
The quartic (r''-3r^2)(dx)^4 is intrinsic and common, so (H) forces
dormancy. These implications are supplied; the missing step is (S).

## Why this particular question is now useful

The positive-tensor branch has recently become substantially narrower.
An independently checked ramified-root contact theorem proves the
following. If a shared weight-d tensor has uniform divisor eD, D reduced,
5 prime to d(e+d), and q>=2 is least with e+dq=0mod5, then

    d(q-2)>e implies the actual span has a core.

It handles arbitrary gcd(d,e) and torsion roots. Its mechanism counts
contacts on canonical ramified root covers while retaining equivariance:
downstairs contact I becomes 1+(d/gcd(d,e))(I-1). For d=7,e=2 this is
at least22. Hodge index bounds the total degree of EVERY finite union
of preserving joint images, making the entire relation finite.
No Jacobian orthogonality or Cartier assumption is needed for that theorem.
Do not redo the old weight7 spin or root-Prym problem; it is resolved.

Consequently a coreless span with a genus-two endpoint has clump-image
size1 or4mod5. For our selected ordinary genus-two family the singleton
case has also been excluded independently. Every remaining positive
clump then yields a common regular nilpotent projective connection.
The no-clump case (H) is the remaining EXISTENCE gap. If (NC) holds,
all possible common covers of that selected pair reduce to matching
regular nilpotent endpoint connections. Excluding such matches is
still a separate problem, so (NC) alone does not solve Litt's problem.
Our selected X has an absolutely simple genus-nine Jacobian, hence
the stated Hom-zero hypothesis against every genus-two Y.

## Known pitfalls and the required scope of an answer

Universal existence of a common regular projective connection is FALSE:
there are actual coreless Igusa-Hecke spans preserving a Cartier-fixed
one-form with all zeros of order2, whose common rational connections
all have poles. Those examples HAVE a clump and violate (H).
An example with X=Y also violates the displayed Hom-zero hypothesis.
Conversely Hom-zero alone does not exclude common etale covers.

Ordinarity of Y does not control defects on all its etale covers.
Finite-field descent does not give a finite simultaneous Galois closure,
or stabilization of an alternating one-leg closure tower. Finite-dimensional
representations over bar(F5) cannot be applied to an unbounded union of
growing section spaces. No simultaneous lifting argument is available.
Refining the original source cannot change solvability of (S) with
coefficients still required to lie in the two original endpoint fields.

Please attempt the actual equation/lemma, with methods of your choice.
A counterexample must prove both projective maps everywhere etale,
corelessness, (H), the genus/ordinary/Hom conditions, AND nonsolvability
of (S); a formal germ or ramified seed alone is insufficient.
If undecided, state exactly what additional structural implication you
can prove about this obstruction on actual two-leg joint fields. Merely
renaming the affine intersection or proving its at-most-one dimension
repeats supplied information. Cite any external theorem with the precise
hypotheses used. Make no genericity or prime-to5-degree substitution.
