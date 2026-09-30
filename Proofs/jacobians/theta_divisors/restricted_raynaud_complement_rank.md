# Proof: the transverse finite Frobenius comparison

This proves the
[statement](../../../Theorems/jacobians/theta_divisors/restricted_raynaud_complement_rank.md).
The user-supplied Pro response of15 September2026 proves the
prime-to-p split two-leg version. The argument below replaces its
formal group product by coordinates for the smooth quotient J->J/A.
It thereby removes the splitting requirement from the general bound.
The [bounded independent audit](../../../Research/audits/RESTRICTED_RAYNAUD_COMPLEMENT_RANK_AUDIT_2026_09_15.md)
passes this generalization, the finite-height extension and the actual
two-map consequences.

## 1. A square finite matrix near the trivial line

For the Poincare family on C times J, derived cohomology has a
two-term locally free model. At0 its cohomology dimensions are1,G.
Cancel all matrix entries that are units at0. The resulting completed
model has ranks1,G and differential a column with zero constant term.
Its first derivative in a Picard tangent direction xi is cup product
1 cup xi=xi. Thus its G entries have independent linear terms and
are a regular system of parameters of the completed local ring.

Moreover ANY prescribed regular parameters can replace this column
by a change of basis of the degree-one free module: two parameter
columns differ by an invertible G by G matrix over the complete ring.
The same construction applies on C^(1) times J^(1).

The line-bundle pullback F_C^*:J^(1)->J is Verschiebung V_J under
Jacobian autoduality. The short exact sequence

    0 -> N -> F_C* F_C^*N -> B_C tensor N -> 0

therefore gives a chain map from the first minimal cohomology
complex on J^(1) to the V_J-pullback of the complex on J. At0 its
degree-zero arrow is the isomorphism on constants. It is a unit
over the complete ring. Multiply the entire target-complex map by
its inverse; this is an invertible operation on its mapping cone.
The degree-zero arrow is now1. Denote its degree-one matrix by H.

Cancelling that unit in the cone leaves the square complex

    [R^G --H--> R^G]

computing the actual cohomology of B_C after restriction to any
formal parameter subspace. Its generic kernel dimension is the
generic defect on that subspace. No Cartier-crystal quotient is used.

## 2. Quotient coordinates, without an isogeny splitting

Write d=dim A and c=dim Q, so G=d+c. The case A=0 is the equality
delta_A=a(C): the matrix at the origin is dV_J, and eliminating
its rank leaves the zero a(C)-square Schur matrix. Assume d>0.
The quotient pi:J->Q is smooth with
fiber A at0. Choose parameters z_1,...,z_c on Q and lift parameters
x_1,...,x_d on A. Together they are parameters on J, and A is
cut out by z=0. Make the corresponding independent choices on
J^(1),Q^(1),A^(1). Choose the minimal-complex bases of Section1
so their differential columns are these adapted coordinates.

Naturality of Verschiebung gives

    pi V_J=V_Q pi^(1).

Its expression in these coordinates consequently has the form

    (x,z) -> (Y(x,z), V_Q(z)).

The chain-map identity on the FULL completed Jacobian is

    H(x,z) (x,z)^t = (Y(x,z), V_Q(z))^t.                 (1)

In particular the lower-right c by c block of H(0,0) is dV_Q.
This follows also by differentiating (1) at0. It must be identified
before restricting to A; the restricted chain relation alone would
not determine that block.

Now set z=0 and R=k[[x_1,...,x_d]]. The vector y=Y(x,0) describes
V_A:A^(1)->A on formal neighborhoods. This is a finite morphism,
so its d coordinates form a parameter regular sequence in R.
Writing the restricted matrix in blocks gives

    H=[[U,B],[C,D]],       Ux=y,       Cx=0,              (2)
    rank D(0)=c-b,         b=a(Q).

No formal GROUP product J=A times Q has been assumed. Only smooth
quotient coordinates and naturality of Verschiebung were needed.

## 3. The elementary determinant lemma

If R=k[[x_1,...,x_d]], y is a parameter regular sequence, and
U x=y, then det U is nonzero. Here is a precise Koszul proof.
The induced surjection R/(y)->R/(x)=k gives, by exactness of
Ext_R^d(-,R) on finite-length modules over the regular ring R,
an injection

    k=Ext_R^d(k,R) -> Ext_R^d(R/(y),R)=R/(y).

The map of Koszul resolutions with first matrix U identifies this
map with multiplication by det U, up to transpose/sign conventions.
Thus det U is nonzero even modulo (y), proving the assertion.
This argument also explains why no first-order invertibility of U
is required when V_A has inseparable directions.

## 4. Eliminate only genuinely invertible blocks

Choose a (c-b)-square unit minor of D and use it as a pivot. Row
and column elimination gives its identity block plus a remaining
matrix of size d+b. These operations preserve the two vector
relations in (2): row subtraction uses lower output coordinates,
which are zero, and the pivot-row entry multiplying x is zero
because Cx=0. The resulting matrix therefore has blocks

    H'=[[U',B'],[C',D']],       U'x=y,       C'x=0.

Explicitly partition the lower block as
D=[[E,F],[G0,J0]] with E the chosen unit minor, and write
B=[B1,B2], C=[C1;C2]. Then

    U'=U-B1 E^-1 C1,        C'=C2-G0 E^-1 C1,
    B'=B2-B1 E^-1 F,        D'=J0-G0 E^-1 F.

Since C1 x=C2 x=0, the stated vector relations follow immediately.

Section3 makes U' invertible over K=Frac(R). Its Schur complement

    S=D'-C'(U')^-1 B' in Mat_b(K)

has exactly the same generic corank as H. Hence

    delta_A=corank_K S <= b=a(Q).

Generic rank over this completion agrees with rank at the generic
point of A^(1): completion of its local ring at0 is faithfully flat,
and the original perfect cohomology object is defined on an open
neighborhood of0. The subsequent formal coordinate and basis changes
need not themselves algebraize; they do not change that rank.
The argument includes b=0 with the empty Schur complement.

For any fixed e>=1, replace relative Frobenius by its e-fold
composite throughout. Pullback on Jacobians is the e-fold relative
Verschiebung, still finite and natural for pi. The cohomology model
still has ranks1,G, the degree-zero map on constants is a unit,
and the normal block at0 is now dV_Q^[e]. Thus the very same
elimination proves the finite-height bound and exact Schur matrix,
with b replaced by a_e(Q). No iteration of a Frobenius endomorphism
on an individual nontrivial line bundle is being assumed.

## 5. Same-source maps and the split numerical form

For an actual span, its parameter map JX times JY -> A is dominant.
Pulling back the cohomology family preserves its generic rank even
if this map is inseparable. Thus its generic mixed defect is delta_A.
Applying the general theorem gives the claim in arbitrary degrees.

Under Hom-zero let i=f^*+g^* and r=(Nm_f,Nm_g). Then

    r i=([n],[m]).

When n,m are prime to p this makes r smooth and surjective. Put
Q0=(ker r)^0. Addition JX times JY times Q0 -> JZ is an isogeny
whose kernel has prime-to-p order: its first two coordinates lie
in JX[n] times JY[m], and the third is determined. It follows that
Q0 -> JZ/A is also a prime-to-p isogeny. The a-number is additive
on products and invariant under such isogenies. Consequently

    a(JZ/A)=a(Z)-a(X)-a(Y).

The prime-to-p isogenies commute with every relative Verschiebung
and are isomorphisms on tangent spaces. Consequently this additive
identity holds for a_e as well, proving the finite-height consequence.

On differentials the quotient map JZ->JZ/A identifies its invariant
one-forms with the annihilator of Lie A. Prime-to-p degrees ensure
that Lie A is exactly the sum of the two pulled-back Picard tangent
spaces. Serre duality identifies this annihilator with the two-trace
kernel on H0(Z,omega_Z). Cartier commutes with pullback from the
quotient, so its kernel there has dimension a(JZ/A).

These arguments keep both actual maps throughout. They neither force
the excess a-number to vanish nor make a generic nonzero determinant
into a common-cover exclusion.
