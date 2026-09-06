# Explicit first-integral charts for the characteristic-five dormant equation

Let K/k be a one-variable function field over a perfect field of
characteristic5, let x be separating, D=d/dx, and C0=K^5=ker D. Put xi=x^5.
The FIELD solutions of D^2r=3r^2 have the following exact description.

1. The first integral c=(Dr)^2-2r^3 equals D^4r and belongs to C0.
2. If c=0, then either r=0 or r=2/(x-b)^2 for a unique b in C0.
3. If c!=0, solutions correspond bijectively to triples c,h in C0^*, b in C0
   satisfying

       3h^5-c^5*h^2+c^10*(xi-b^5)^2=0.

   Set s=x-b and q=c*s^2+3h/c. Reconstruction is r=q^3/h; conversely
   h=r^5 and b=x-r*Dr/c. These are functions in the constant field K^5,
   not three ordinary scalar parameters over k.

For any r, put E=D^2r-3r^2 and J=(Dr)^2-2r^3-D^4r. Then

    J=-D^2E-rE,       DJ=2(Dr)E.

Consequently J=0 is equivalent to E=0 in a differential coefficient ring
where Dr is a unit and D^5=0. Dropping that condition in nonreduced families
is invalid; the field classification alone is not a scheme presentation.

There is also a uniform nonvanishing result. For ANY squarefree monic F
of degree10, in K=k(x,y), y^3=F(x), take

    r=2F''/F+2(F'/F)^2+(2x^8+B)/F+C*y/F+A*y^2/F^2,
    deg B<=7, deg C<=4, deg A<=10.

Then D^4r is NEVER identically zero, with no dormancy assumption. Its unique
fifth root has the form

    gamma=(G0(x)+G1(x)y+G2(x)y^2)/F(x),
    deg G0<=8, deg G1<=5, deg G2<=2.

For the [fixed X](Thm_fixed_x_dormant_equations.md), before coefficient
fifth roots, the map from the24 potential coefficients
to the18 displayed numerator coefficients is affine linear of rank17,
and its image does not contain zero. Thus every dormant solution in this
degree-ten trigonal family belongs to the nonsingular c!=0 chart above.

Status: author proof with exact polynomial/matrix certificate. This supplies
a structural description and removes a genuine global exceptional case;
it does not yet impose all global regularity conditions in the new chart,
enumerate the remaining opers, or exclude an atlas.
[Proof and certificate](../Solutions/Sol_dormant_first_integral_charts.md).
