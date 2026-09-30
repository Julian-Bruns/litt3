# Proof: localize the shared ring and use one quadratic identity

[Statement](../../Theorems/projective_connections/coreless_connection_spectrum.md).
Write E(r)=r''-3r^2. The [Cartier secant identities](cartier_dormant_secants.md)
identify E(r)(dt)^4 as the quartic projection of p-curvature and
det(psi_r) as a section of omega^10. Both are regular for a regular
connection and commute with etale pullback; dormancy is E(r)=0.

## The rational connection and the entire common space

If A=k, two common connections would differ by A_2=0. Any common
connection has E(r) in A_4=0, hence is dormant. The common connection
space is an intersection of affine-linear spaces, so this point is reduced.

For s=a(dt)^d,5 not dividing d, put ell=a'/(d a) and
r_s=-ell'/2+ell^2/4. The chain rule gives the projective-coordinate
transformation law. Thus r_s is intrinsic and shared, with poles
supported on S.

Choose j with2dj=-1 modulo5 and put v=a^j, b=v^-2. Then v''/v=r_s,
and y=vz changes y''=r_s y into z'=b w, w'=0.
In a separating coordinate D^5=0; the p-curvature in this gauge is

    [0,-D^4 b;0,0].

It is nilpotent, and vanishes iff C(b dt)=0. If1<=rho<=4 and
rho d=1 modulo5, the exponents -2j and rho differ by a multiple of5.
Cartier's product rule therefore identifies dormancy with the
Cartier-zero branch of s^rho.

Now let A=k[s] and let r be any common regular connection. For large N,
the shared rational quadratic r-r_s satisfies

    (r-r_s)s^N in A_(2+Nd).

This graded piece is zero if d>2, and is k s^(N+2/d) if d=1 or2.
Hence r=r_s in the first case, while r-r_s is a constant multiple of
the regular quadratic q=s^(2/d) in the second. Thus a common regular
connection exists exactly when r_s is regular, with the stated point
or line as its entire space.

## One regularity argument for every weight

At a zero a=t^e u, u a unit, the double-pole coefficient of r_s is

    (e/d)(e/d+2)/4.

It vanishes precisely when e=0 or-2d modulo5, leaving at most a
simple pole. To rule that out, it suffices to show E(r_s) is regular:
a genuine simple pole c/t would give the nonzero term2c/t^3 in E(r_s).

In the Cartier-zero branch E(r_s)=0 by the preceding gauge.
In the nonzero branch the primitive weights are1,2,4. For d=1,2 put
q=s^(2/d); for d=4 take a rational quadratic root q of s in a
separable quadratic extension. In characteristic5, r_s=q''/q.
After normalization C_1(q^3)=q, the secant identity gives

    E(r_s)=3q^2.

This is regular and descends in the d=4 case because q^2=s.
For d=1 the normalization follows from C(s)=s by Cartier's product
rule. This proves(1), including all unit coefficients and infinity.
It also proves the asserted dormant or active-nilpotent type when d>2.

## The line and its scheme multiplicities

For d=1,2 write q=a(dt)^2 and normalize
C_1(q^3)=epsilon q with epsilon in{0,1}. Then r_s=a''/a and
E(r_s)=3epsilon a^2. For r_c=r_s+c a, the secant identities and
the companion p-curvature determinant give

    E(r_c)=3(epsilon-c^2)a^2,
    det(psi_(r_c))=4c(epsilon-c^2)^2 a^5.

The determinant formula uses only a''=r_s a and is checked by
[the exact jet checker](../../scripts/connections/check_cartier_dormant_secants.sage).
The nonzero sections a^2 and a^5 each have a nonzero scalar coordinate,
so their coefficient equations generate exactly the ideals
(c^2-epsilon) and(c(c^2-epsilon)^2), over arbitrary parameter algebras.
These are the asserted schemes and lengths. Primitivity of q is
unnecessary; the same calculation covers q=s^2 for weight one.

## Fixed X and an actual empty family

For fixed X, let rX=|image_X(S)|. The uniform divisor equation is
e rX=16d, so neither e nor rX vanishes modulo5. Hence(1) is equivalent
to rX=2 modulo5. The known nonzero-Cartier profiles then give precisely
(2,1),(4,2). A regular Cartier-zero shared quadratic would supply a
nonzero shared dormant tangent, contradicting the fixed-X reduced
intersection in the Cartier secant theorem.

In the [partial Igusa family](../examples/igusa_hecke_correspondences.md),
the genus-seventeen curve has a Cartier-fixed alpha with
div(alpha)=2D, D reduced, preserved by both maps of every jointly
minimal coreless span of degree12*11^(n-1). Its primitive weight is1.
At each zero r_alpha has double-pole coefficient2 in F5; adding the
regular multiple c alpha^2 cannot cancel it. Thus P is empty on every
one of these actual spans.

The argument classifies the common connection space on the given
span. Its point and line alternatives supply no existence of matching
endpoint connections and no ordinary-source lifting hypothesis.
