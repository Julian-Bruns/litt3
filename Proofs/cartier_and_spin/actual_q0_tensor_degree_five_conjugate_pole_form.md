# Proof: retain the conjugate pole pair and proportional numerator edge

Version1,3 October2026. New necessary four-parameter form, pending independent review. No computation or exclusion is claimed here.

The [coarse reduction](actual_q0_tensor_cubic_coarse_curve_reduction.md) and the degree-five pole argument in the [rational form](actual_q0_tensor_degree_five_rational_form.md) give div(z)=2R1−2R2 and TWO shared simple infinity poles. For genus ONE or TWO, z is a separating degree-TWO map, ramified at R1,R2. Choose its quadratic coordinate y with y²=Φ(z), where Φ has simple root ZERO and degree THREE or FIVE. Suppose the two shared poles are the TWO distinct points over z=a. Thus a≠0, Φ(a)≠0, and J=z−a.

The exact pole divisors give
\[
x_1=A_1/(zJ)+b y/(z^2J),\qquad
x_2=A_2/J+c y/J,\qquad\deg A_i\le2.
\]
In genus TWO, b,c are nonzero constants: y has pole FIVE at infinity; x2's triple pole therefore forces c constant, and x1's regularity forces b constant. In genus ONE, b,c have degree at most ONE and c has degree ONE. These bounds come from the actual polar divisors; the two poles over a are retained, so no cancellation at a conjugate point is imposed.

In the proportional case write b=βh,c=h, with β≠0. Absorb the leading scalar into y. Genus TWO has h=ONE. Genus ONE has h=z−e. The odd q-cube coefficient gives A2=βA1. Put A=A1,r=β²,Y=h y,Ψ=h²Φ. The even coefficient gives the exact identity
\[
(z-r)(\Psi-zA^2)=D z(z^3-1)(z-a)^2.
\]
Here q0 has first been centered as x²+D, D≠0. Triple-pole data forces h(0)≠0. If genus ONE had e=a, then the odd parts would have no pole at the two points above a and A(a)≠0 would be required for both actual simple poles. Their leading q-ratio forces r=a. Dividing the displayed identity by z−a and evaluating at a would instead give A(a)=0, a contradiction. Thus e≠a.

When h(a)≠0, a root r=a would make the product of the two x1 residues vanish: evaluating gives Ψ(a)=aA(a)², and that product is a²A(a)²−rΨ(a)=ZERO. Since the two simple poles are actual and distinct, neither residue can vanish. Thus r≠a. Polynomiality then forces r³=ONE, and
\[
\Psi=z[A^2+D(z^2+rz+r^2)(z-a)^2].
\]
In particular Ψ(a)=aA(a)²≠0 and a≠r. The leading coefficient A2²+D and the simple-zero coefficient A0²+D r²a² are nonzero, since Ψ has degree FIVE and simple zero ZERO in both actual field presentations.

For completeness, in the elliptic case the extra root e is ordinary. If Φ(e)=0, locally z−e has order TWO and h y has order THREE. Both xi would have no order-ONE term. The allowed local indices ONE/THREE force both even z-derivatives to vanish, so both indices are THREE. Comparing the order-TWO coefficient of q2=z³q1 gives 3e²q1(e)=ZERO. Since e≠0, this makes xi land at q-roots, where the actual coarse projections must instead be unramified. This contradiction proves Φ(e)≠0. The auxiliary Ψ has a double root e; its field remains the smooth elliptic field.

Scale z=rZ,a=ra′,Y′=Y/r,A′=βA(rZ)/r. Because r³=ONE and β²=r, the second displayed map becomes the asserted normalized x2; the first becomes the asserted x1 up to its common centered sign βr∈{±ONE}. The polynomial becomes Ψ′=Z[A′²+D(Z²+Z+ONE)(Z−a′)²]. Finally scale both centered xi by a square root of D, along with A′,Y′, to normalize D to ONE. These are symmetries of necessary local ramification only; the fixed polynomial P is not asserted to be preserved. Drop primes. The physical opens in the statement follow.

Let δ=Y d/dz. Direct differentiation gives
\[
\delta x_1=(zYU+V)/(z^3J^2),\qquad
\delta x_2=(YC+W)/J^2.
\]
Taking the quadratic field norm therefore gives the exact numerators in the statement. V is divisible by z, so N1 is polynomial. Characteristic FIVE kills the leading derivative of Ψ; hence V has leading coefficient−3p in degree SIX and W has leading coefficient−p in degree FIVE. The leading coefficients of N1,N2 are respectively9p²=4p² and p², nonzero. Both degrees are TEN.

On a smooth genus-two model, every zero and pole of dxi has even order, since all local indices are ONE/THREE. Dividing by dz/y preserves even orders: this differential has divisor2R2. The rational norm of δxi is therefore a square in k(z), and its displayed denominators are squares. Thus N1,N2 are squares up to nonzero scalars. For the elliptic presentation, δ=(z−e)δ0, where δ0=y d/dz and dz/y is regular and nowhere zero. The same even-order argument applies to δ0, and the extra norm factor(z−e)² is itself a square. Thus the exact same necessary square condition holds, without treating the singular Ψ as smooth.

The known square leading coefficients allow a quintic root with leading2p for N1 and p for N2. Successively match coefficients of degrees NINE through FIVE, dividing only by2p or4p. Each remaining degree FOUR through ZERO coefficient gives one equation. Clearing only powers of p produces TEN necessary polynomial equations in the four listed parameters. Their satisfaction alone is not an actual map construction and supplies no original Y-leg.
