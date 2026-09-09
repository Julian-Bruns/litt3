# Proof: two explicit contacts exhaust the whole intersection

[Statement](../Theorems/Thm_family_singleton_root_exclusion.md).
Pro construction supplied by the user2026-09-08; root exposition and exact
replay. All arguments work over any algebraically closed field of char5.
Set G(u)=u(u-1)(u-2)(u-3), g=G(t), tau=t^5, d=t-tau=-(t+1)g.
Every displayed denominator below is nonzero because t^5-t!=0.

## 1. Inputs and conventions

[raynaud_genus_two_determinant](../Theorems/Thm_raynaud_genus_two_determinant.md)
gives a homogeneous quadric Q_t in the Kummer coordinates of J1 whose
global zero SUPPORT is Theta_B. Its proof Sections3--4 checks the actual
Cartier determinant and extends support equality across the branch,
repeated-divisor and theta boundaries; no multiplicity equality is used.
We use its exact coordinate convention w and coefficients, also reproduced
and checked by [the contact certificate](../scripts/family_singleton_contact_certificate.py).

[singleton_cartier_theta_bound](../Theorems/Thm_singleton_cartier_theta_bound.md)
proves that T is connected and that its144 Weierstrass/nonzero-kernel
points lie over Theta_B. For clarity, connectedness follows since the
Abel map induces an isomorphism H^1_et(J,F5)->H^1_et(C,F5), by the
Artin--Schreier sequence and its Frobenius-compatible H^1(O) isomorphism.
Multiplication by2 preserves this. Thus the pulled-back ker V torsor
has full monodromy. Ordinarity is checked below and puts (O,0) outside
Theta_B. The restricted quadric therefore defines a finite divisor.

## 2. Two nonzero kernel points

Choose lambda^2=t+1 and r^5=t. Put

    R=(r,(r-t)(r+1)^2/(2lambda)),
    f=(u-t)^2((u-t)(u+1)^2-2lambda v).

Direct multiplication, using v^2=G(u)(u-t), gives

    f iota(f)=(u-t)^5(u^5-t).

At W_t=(t,0), the two summands of f have orders6 and5, so f has
order5. R is nonbranch: r cannot equal0,1,2,3,t when t^5-t!=0.
At R the conjugate factor is nonzero (also r!=-1), so f has order5.
At O its summands have distinct pole orders10 and9. There are no other
zeros or poles, proving div(f)=5W_t+5R-10O.

For L=[W_t+R-2O], set M=Fr_J(L). Since V Fr_J=[5], M lies in ker V.
The identity lambda^5=lambda(t+1)^2 gives on C^(1)

    M=[W_tau+R1-2O1], R1=(t,d/(2lambda)),
    U1=(z-tau)(z-t), V1=(z-tau)/(2lambda).

The distinct abscissas show this divisor is not a hyperelliptic fiber,
so M!=0. Changing lambda to -lambda gives -M. These are distinct since
they are nonzero5-torsion and char5 is not2. They contain a branch point;
excluding the branch boundary would lose the decisive contacts.

## 3. The local ideal of the quadric at both kernel points

On the translated Abel curve Gamma={ [W_tau+R_X-2O1] }, the homogeneous
Kummer coordinates are

    Z(X)=(X-tau, (X+tau)(X-tau), tau X(X-tau),
          tau^2 X^2+(tau-tau^2)X-tau).

This follows by substituting S=X+tau, P0=tau X,
q1^2=G(X)/(X-tau) into the fixed w convention. The exact certificate
proves POLYNOMIAL identities over F5[t,X], without imposing t^5=t:

    Q_t(Z(X))=g^6(X-t)^4,
    (partial Q_t/partial Z3)(Z(X))=2(t+1)^2 g^3(X-t)^2.

Put q=Q_t(1,S,P0,w), xi=X-t. Since X-tau is a unit near t,
q|Gamma is divisible by xi^4 and q_w|Gamma by xi^2.

Near either +/-M, use two curve points, one near W_tau with parameter
delta=v1 and one near R1 (or its conjugate) with parameter xi. These
are formal Jacobian coordinates: the degree-two Abel differential is
invertible because the abscissas tau and t differ. The first abscissa
is tau+O(delta^2). Relative to Gamma at the same xi, S and P0 change
by O(delta^2), and w by O(delta). Taylor expansion of the quadratic q
therefore yields the IDEAL containment

    q in (delta^2,delta xi^2,xi^4)=(delta,xi^2)^2.             (1)

The argument applies at both signs; it concerns actual regular Kummer
functions, since these divisors lie in the degree-two affine chart and
have distinct abscissas. In particular q has multiplicity at least2.

## 4. Tangency of the distinguished inverse-image branch

Let c_i=[u^i](G(u)(u-t))^2. Exact multiplication gives

    [[c4,c3],[c9,c8]]=(t+1)[[1-2t,-2t],[-2,t-2]],
    c4 c8-c3 c9=3(t+1)^4.

Thus C is ordinary, V is etale of degree25. With eta=du/v and
eta1=dz/v1, the RELATIVE Cartier formulas are

    V*eta=(c4+c9 z)eta1, V*(u eta)=(c3+c8 z)eta1.

There are no fifth roots on these coefficients: the source of V is
the Frobenius-twisted Jacobian. These formulas follow from dualizing
F_C^* on H^1(O), or directly from relative Cartier after writing
eta=F(u)^2 du/v^5. At z=t the two coefficients are respectively
(t+1)^2 and t(t+1)^2. Hence dV sends the tangent of Gamma to the
line (1,t), the Abel tangent at W_t; [2] preserves that line.

The branch of T through (W_t,+/-M) therefore has, in the above
coordinates, delta=O(s^2), xi=O(s). By(1), its q has order at least4.
Every other branch through (W,+/-M) has order at least2 by(1).
The T->J1 map is immersive, since [2]Abel is and V is etale; no
singular parametrization or missing branch is implicit in these orders.

## 5. Exhaustion, with no Raynaud multiplicity assumption

Write pi:T->C and mu:T->J1. A Kummer hyperplane pulls back to2Theta1,
so Q_t is a section of4Theta1. The standard polarized isogeny identities
V*Theta=5Theta1 and [2]*Theta=4Theta, and Abel degree2, give

    5 deg(mu*Theta1)=deg(pi*Abel*[2]*Theta)=25*2*4=200.

Thus div(mu*Q_t) has degree160. It is a genuine finite divisor by
Section1. Its144 forced points are distinct. The22 kernel elements
other than +/-M contribute at least132; +/-M over the other five
Weierstrass points contribute at least20; over W_t they contribute
at least8. Their sum is160, the ENTIRE degree. Every lower bound is
therefore equality and no other zero exists, proving(1) and(3) of the
statement. Support equality with Theta_B is sufficient throughout.

## 6. Actual etale root covers and scope

The nonbranch root equivalence is singleton_cartier_theta_bound:
the unique prime-to5 lift under V of [2P-2O] must lie in Theta_B.
Although that prerequisite is stated over bar(F_p), its actual torsor
proof works over every algebraically closed k for a prime-to5 torsion
class. It never requires arbitrary Jacobian points to be torsion.
Section5 excludes it. At a Weierstrass P that lift is0, which is
outside Theta_B by ordinarity. This proves the ALL-WEIGHT root assertion.
The h formulation follows by writing Fr_J^(-1)(M)=[D-2O] using
Riemann--Roch; the unique twisted canonical section is eta/h. This is
exactly the rational-frame Cartier test, not a norm-only condition.

Only a singleton clump image is excluded. Large Cartier-zero clump
profiles really do pass independent endpoint tests, and a clump need
not be assumed to exist. Both actual etale legs from the same source
remain necessary in every use toward Litt Problem3.

## Exact evidence

Root executed the user-supplied certificate with Sage's Python/SymPy on
one CPU,2026-09-08: all12 identities PASS. The source in scripts is the
same polynomial verifier, with its header updated to this canonical name.
Its checks prove identities, not the intersection-theoretic argument;
that argument is given above. No finite-field sampling or solver verdict
is used. The fresh medium audit by /root/audit_family_singleton_medium
passed2026-09-08; its sole non-breaking field-scope clarification is
incorporated in Section6. This generalization now subsumes the old
special-parameter singleton exclusion, not the general theta-bound theorem.
