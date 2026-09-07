# Exact genus-two Hermitian oper test

Author computation and proof,2026-09-07. This is a small actual atlas
example, not an exclusion or a solution of Litt3. The actual quotient
construction and acyclicity argument are maintained separately by the
main research agent. No intrinsic incidence tensor is exported here.

## Complete three-parameter chart

Work in characteristic5 on C: v²=F(t)=t⁶+3. The differential
eta=dt/v is nonzero at the finite branch points and has a simple zero
at each of the two infinities. For a local differential a dz, its
half-density potential is

    r_a=−(a'/a)'/2+(a'/a)²/4.

In the t-frame this gives 2t¹⁰/F². At either infinity, u=1/t and
eta=±u(1+3u⁶)^(-1/2)du, up to a nonzero constant sign. Its local
potential is 2u^-2+O(u⁴), with no simple pole. The quadratic
differential 3t⁴ eta² has expansion 3u^-2+O(u⁴), cancelling the pole.
Consequently the following is a globally regular projective connection:

    r*=2t¹⁰/F²+3t⁴/F=4t⁴/F².

The three regular quadratic differentials eta²,t eta²,t² eta² form
a basis of H0(omega²). Thus the complete affine space is

    r=4t⁴/F²+(b0+b1 t+b2 t²)/F.

This argument handles both infinities and all branch points; it does
not borrow the genus-nine one-point pole semigroup.

## Exact curvature algebra

The characteristic-five companion recurrence used in
[the canonical fixed-X proof](../Solutions/Sol_fixed_x_dormant_equations.md)
applies over any separating coordinate: dormancy is exactly r''−3r²=0.
With n=4t⁴+(b0+b1t+b2t²)F, its cleared numerator is

    F² n''−4FF'n'+(6(F')²−2FF'')n−3n².

The script extracts every coefficient and computes the tiny three-variable
lexicographic basis

    b0+b2², b1²−2b2³−1, b1 b2, b2⁴−2b2.

Its length is5. There are precisely two points (0,±1,0), and three
points (−c²,0,c) with c³=2. All five lie over F25. The script checks
every point in the original curvature numerator and verifies Jacobian
rank3 at every point. Thus the entire oper scheme here is reduced.
The field presentation and exact five tuples are in
[the certificate](computations/genus_two_hermitian_opers.json).

## Identification of the actual Hermitian atlas

On H: x⁶+y⁶+1=0, set

    t=(x³+y³+1)/(xy),
    v=(x³−y³)(y³−1)(1−x³)/(xy)³.

In the degree-six function-field extension k(x)[y], the script checks
v²=t⁶+3 exactly. For D=d/dx, Dy=−x⁵/y⁵ and D²y=0. The rank-two
horizontal plane x⁵A+y⁵B+C=0 contains the oper line s=(x,y,1);
its derivatives s' and s'' satisfy s''=0. This is the projectivization
of the Frobenius pullback dual of E/O from the Hermitian atlas (line
twists have no effect on the projective connection). Hence the
projective connection is zero in the x-frame.

For a change of separating variable t=t(x), the equation r_x=0 becomes

    r_t = (D³t/Dt − (3/2)(D²t/Dt)²)/(2(Dt)²).

The exact function-field comparison with all five candidates gives
the unique match

    (b0,b1,b2)=(0,1,0),
    r_t=4t⁴/(t⁶+3)²+t/(t⁶+3).

This is an identity of rational functions on H, not numerical sampling.
The automorphism t->−t also carries this oper to (0,−1,0), so composing
the actual atlas with this curve automorphism supplies the second
oper as well. The subsequent exact120-Mobius-transformation check in
the script realizes all five points, each24 times. Its completeness
and actual lift to curve automorphisms are proved in
[the canonical test theorem](../Solutions/Sol_hermitian_genus_two_test.md).

## Reuse and limitations

Run `sage scripts/genus_two_hermitian_opers.sage`. Only a three-variable
zero-dimensional basis and small exact function-field operations run.
The source is [here](../scripts/genus_two_hermitian_opers.sage).

For future one-point cohomology code, choose beta in F25 with beta⁶=2
and put z=1/(t−beta), w=v z³. Then

    w²=1+beta z+beta⁵ z⁵,
    t=beta+1/z, v=w/z³.

The degree-five model has its unique point at infinity at the selected
Weierstrass point. Its semigroup is <2,5>, and dz/w has divisor2O.
The old scalar potential and frames must be transformed before reusing
one-point linear algebra. No such reuse or incidence tensor construction
is claimed by this computation.
