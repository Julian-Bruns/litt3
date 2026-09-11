# A finite quartic calculation controlling an entire abelian cover tower

Determine the formal defect germ of the genus-three family below, and
establish its resulting uniform defect law. The opportunity is concrete:
an actual degree125 calculation has found a rank-two quadratic part in
three variables and a nonzero quartic along its corrected radical. This
would turn the next finite calculation into a theorem about every balanced
abelian5-power cover, rather than another isolated cover computation.

The target is the following parameterized statement, including its exact
specialization criterion:

> For the actual genus-three pair (C_t,r_t) below, the scalar abelian
> defect relation at the geometric generic parameter has formal type
> UV+W^4. Determine an explicit nonvanishing condition on t under which
> this holds, decide that condition at alpha^3+alpha+1=0, and hence prove
> that the maximal balanced (Z/5^n)^3 cover has defect
> (7*5^(2n)-3)/4 for every n>=1 on that locus.

Here formal type means multiplication by a unit and an invertible formal
change of coordinates. The central new task is the quartic after the two
transverse directions have been eliminated; substituting the radical
line into the uncorrected equation is not the same calculation.

## The actual curves and connection

Work in characteristic5 over an algebraically closed field. For the
generic assertion take the algebraic closure of F5(t). Set

    G(u)=u(u-1)(u-2)(u-3), F(u)=G(u)(u-t),
    Y_t: v^2=F(u), A(u)=(t+1)^2 G(u),
    a(u)=A(u)/F(u)^2,
    r_t=3a''/a+(a'/a)^2.

Primes denote d/du; r_t is a scalar projective connection in that
coordinate. Let C_t be the smooth projective curve with function field

    k(u,v,kappa),  v^2=F(u),  kappa^2=u(u-3),

and pull r_t back to C_t. The actual map C_t->Y_t is connected etale of
degree2, and C_t has genus3. Write eta=du/v and R=u(u-3).

Use the parameter domain

    (t^5-t)(t^2+2t+3) != 0.

On this domain J(Y_t) is ordinary, and the elliptic Prym factor of
C_t->Y_t has Hasse invariant t^2+2t+3, so C_t has p-rank3.

The small parameter important for specialization is alpha with
alpha^3+alpha+1=0. Another application uses t of very large prime degree
over F5. An explicit exceptional polynomial and a degree bound would
therefore be useful even if the A3 assertion is not valid at every
parameter of the displayed domain.

## Established inputs, available without reproving them

1. The pair on Y_t is regular, active, admissible, and indigenous-ordinary.
   The pulled-back pair on C_t has defect exactly1 with a simple zero:
   its six-dimensional Frobenius-semilinear Hodge operator Psi has rank5
   and rank(Psi^2)=5. The other five directions are bijective.

2. The relevant defect bundle on S^(1) is the actual rank-four bundle

       E_r = coker(T_(S^(1)) -> F_(S*) T_S),

   formed by normal projection of the horizontal p-curvature line.
   It is compatible with finite etale pullback. Its H0 and H1 identify
   with ker(Psi_S) and coker(Psi_S). It has a perfect alternating pairing
   E_r tensor E_r -> omega_(S^(1)). This gives the appropriate duality
   between defect kernel and cokernel, not an alternating form on H0 alone.

3. For every actual finite5-group cover T->S and normal subgroup H,

       coker(Psi_(T/H))
          = k[G/H] tensor_(k[G]) coker(Psi_T),

   after linearizing coefficient Frobenius. Negative tangent cohomology
   is free of rank3g(S)-3 over the deck group ring. These are actual
   norm/base-change identifications, not exactness of arbitrary invariants.

4. Choose a basis of the maximal abelian pro5 quotient of pi1(C_t),
   which is Z_5^3. Write Lambda=k[[e1,e2,e3]], ei=sigma_i-1. Compatible
   free bases of the actual tangent-cohomology systems give a6-by6 Hodge
   presentation over Lambda. Its constant term has rank5. Eliminating
   that invertible block leaves one scalar relation f_t, up to a unit.
   For q=5^n the actual maximal (Z/q)^3 cover T_q->C_t therefore has

       defect(T_q)=length Lambda/(f_t,e1^q,e2^q,e3^q).

   Coefficient Frobenius is transported in the source of this presentation;
   the abstract deck generators are fixed. It is not the substitution
   ei->ei^5. The degree125 cover already determines the complete4-jet
   of f_t, since its quotient ideal is (e1^5,e2^5,e3^5).

5. Related results are stronger than some tempting fallbacks: all neutral
   Galois covers already descend every given compatible full Witt tower,
   and the simple-defect cyclic5-power cases already have uniform delayed
   descent. A different, genus-two pair already has a nondegenerate
   two-variable node giving all its abelian defect lengths. The new
   feature here is the three-variable, rank-two Hessian and its higher
   radical term. This task concerns the special-fiber abelian defect
   module, not a new higher-Witt variation formula.

## A reproducible route through actual Artin--Schreier covers

The following is a computational starting point; a shorter intrinsic
geometric calculation is equally welcome.

At infinity use z=u^2/v, so ord_z(u)=-2 and ord_z(v)=-5. Work with
Laurent expansions determined by v^2=F and this relation, not unrelated
formal coefficient data. In the eta^(-1) frame, the invariant tangent
classes on C have representatives z^-3,z^-1,z. In the kappa*eta^(-1)
frame the anti-invariant tangent classes have representatives z,z^2,z^3.

Invariant affine coefficients are k[u,v]/(v^2-F). Anti-invariant scalar
coefficients in the latter frame are

    k[u] + (v/R) k[u].

The invariant normal coefficient is reduced modulo that affine module
and z^2 k[[z]]; the anti-invariant one modulo its affine module and
z^4 k[[z]]. The operator sends a tangent coefficient pair (f0,f1) to

    ( A*f0^5, A*R^2*f1^5 ),

before these reductions, retaining coefficient Frobenius.

The Frobenius-fixed Artin--Schreier classes in H1(O_C) form an F5-space
of dimension3. Two are invariant, represented in span(z^-3,z^-1),
and one is anti-invariant, represented by kappa*z times a suitable
constant. Choose a basis chi1,chi2,chi3. Decompose each

    chi_i^5-chi_i = f_i,U - f_i,O

into its actual affine and infinity parts. The corresponding cover has
charts wi,U^5-wi,U=f_i,U, wi,O^5-wi,O=f_i,O and overlap difference chi_i,
with the sign chosen consistently in both equations. Their fiber product
is the actual maximal elementary-abelian degree125 cover.

One need not build a750-by750 Hodge matrix. There are only six free
generators: each of the six tangent classes multiplied by w1^4 w2^4 w3^4.
Their deck translates give the whole module. Reduce their Frobenius
images with the actual shifted overlap relations. In each Artin--Schreier
coordinate the conversion from powers w^i to powers of sigma-1 is the
triangular matrix obtained from successive finite differences of w^4.
Tensor the three conversions and retain coefficient Frobenius. This
produces the6-by6 presentation over
k[e1,e2,e3]/(e1^5,e2^5,e3^5).

Use its invertible5-by5 block to compute the scalar Schur relation.
The two-sided row/column changes need not agree; one must use the
actual presentation, not a presumed self-adjoint endomorphism.

## Executed finite evidence

At t^2+2=0, exact computation of the six free columns took about200
seconds and gave source genus251 and defect43. The quadratic part has
rank2. Its restriction to the invariant two-plane has rank1, its
anti-invariant square coefficient is nonzero, and its two mixed-parity
coefficients vanish. The31 actual cyclic quotients independently give
exactly the same quadratic restrictions, all nonzero over P2(F5).
An independent audit replayed all six columns and the complete relation
at higher Laurent precision. The formal A3 type and every balanced-cover
length at THIS specialization are established inputs too. The new task
is the parameterized theorem, especially the generic and degree-three
parameters, not another proof restricted to t^2+2=0.

Here is a numerical4-jet benchmark, with coefficients in

    k0=F5[a]/(a^4+4a^2+4a+2), t=3a+3a^2+3a^3.

In one consistently chosen deck basis the quadratic coefficient order
(x^2,y^2,z^2,xy,xz,yz) is

    (1+2a+2a^2, 3a+3a^2+4a^3, 4+a+a^2+a^3,
     4+a+a^2+2a^3, 0, 0).

Its radical is (1,lambda,0), lambda=2a+4a^3. After x=w and
y=lambda*w+u, solving the two transverse critical equations gives

    u=(3+2a^2+a^3)w^2+(a+a^3)w^3 mod w^4,
    z=0 mod w^4,

and the corrected radical restriction is

    (3a+3a^2)w^4 mod w^5,

with zero cubic coefficient. Thus the quartic is genuinely nonzero
after transverse correction. A different deck basis or unit multiple
will change the displayed coefficients; the rank and nonvanishing are
the invariant evidence.

For reproducing that deck basis, the two invariant Artin--Schreier
classes have coefficients in (z^-3,z^-1)

    (1+a^2, 3+4a+a^2+4a^3),
    (a+a^3, 3+4a+2a^2+4a^3),

and the third class is (4+a+3a^3)*kappa*z. Normalize the free tangent
generators and perform the finite-difference conversion as described
above. All three classes satisfy Frobenius(chi)=chi in H1(O_C).

At the separate degree-four parameter
t^4+4t^3+t^2+4t+3=0, all31 quadratic restrictions also fit one rank-two
form, with rank-one invariant restriction and nonzero anti square.
Its radical is not F5-rational. The quartic has not been computed there.
Neither specialization is being supplied as a proof of a generic or
uniform-in-t assertion.

If using Sage, cross-check small finite-field matrix products against
entrywise multiplication: in our build the optimized Givaro matrix
backend gave a wrong product for F25 with modulus t^2+2. Explicit generic
matrices avoid it; apply_map can silently reselect a native backend.
This warning concerns arithmetic reproducibility, not a restriction on
the theorem or on which exact software to use.

## Objective task list

1. Construct the actual scalar4-jet at the geometric generic parameter,
   or obtain it intrinsically from the defect bundle. Track the geometric
   coefficient and deck identifications far enough to certify its use as
   the4-jet of f_t.
2. Compute the Hessian rank and the radical term after transverse
   elimination. Prove the nonzero quartic criterion as a function of t,
   including specialization at alpha^3+alpha+1=0. If the generic A3 target
   fails, identify the actual first term that contradicts it in this
   geometric construction and its consequence for the growth law.
3. From the verified germ, derive the balanced-cover length formula for
   every n, including the coordinate-invariance of the q-power ideal.
   Check q=5 against defect43 where the A3 criterion holds. Provide an
   explicit exceptional polynomial and degree bound, or an equally exact
   parameter criterion that can be tested for the two applications.
4. Supply a reproducible exact certificate for the finite geometric
   calculation, and independently check its key invariant. State precisely
   which parameter assertions have been proved, rather than inferred from
   finitely many examples.

The payoff is a new uniform constraint on common sources: any actual
source dominating T_q has defect at least the displayed length, by
injectivity of pullback of defect sections. This applies to the Y_t
endpoint used in both our large-parameter and small-parameter strategies.
It does not by itself produce a second map or settle primitive
non-Galois descent; the new information is the amount of defect forced
by simultaneous abelian directions.

Carry out the objective list as a connected mathematical investigation.
Quality and completeness matter more than speed; take as much time as
the exact calculations and their geometric verification need. When an
approach stalls, use the explicit cover and its presentation to test the
next concrete possibility. Aim to deliver the new parameterized theorem
and its finite certificate, not a repetition of the supplied cyclic or
neutral-cover results.
