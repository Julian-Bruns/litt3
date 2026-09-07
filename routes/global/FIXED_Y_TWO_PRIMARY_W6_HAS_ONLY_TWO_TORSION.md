# The fixed Y has no higher two-primary torsion on W6

Author: /root, 2026-09-06. Status: independently audited PASS, including
certificate replay, by `/root/contact_bound_to_core_audit`, 2026-09-06;
[audit record](audits/ENDPOINT_TWO_PRIMARY_LOW_DEGREE_TORSION_AUDIT_2026_09_06.md).
The earlier failed scalar
Frobenius criterion is not used. This settles its actual W6 torsion
question by a different, parameterized method.

## Theorem

For the ordinary genus25 hyperelliptic Y of file76, embedded using its
point O at infinity,

    W6(Y) intersect JY[2^infinity] = W6(Y) intersect JY[2].

In particular W6 contains no point of exact order16,32,64, or any other
two-power order greater than two. Two-torsion itself is allowed: it is
represented by small subsets of the Weierstrass points.

## 1. A parameterized computation with the small doubled group

Let C/F_q be an odd-degree hyperelliptic curve with rational Weierstrass
points, genus g, and Jacobian J. Put T=J(F_q)[2^infinity] and

    delta=v2(#J(F_q))-2g.

Because all of J[2] is rational, the finite group 2T has order exactly
2^delta. It can therefore be very small even when J[2] is enormous.

Suppose a separate descent argument puts W_r intersect J[2^infinity]
inside J(F_q), and suppose 2r<=g. If every NONZERO member of 2T has
reduced Mumford divisor degree greater than2r, then

    W_r intersect J[2^infinity] is contained in J[2].

Indeed write a in W_r as [E-mO], with E reduced and m<=r. Doubling
removes each Weierstrass point by 2P~2O and doubles the other
multiplicities. No conjugate pairs are introduced; the remaining degree
is at most2r<=g, so the resulting divisor is already reduced. Thus
2a in 2T has Mumford degree at most2r and must be zero.

To certify the group 2T without enumerating T, set
n_odd=#J(F_q)/2^(2g+delta). For rational divisor classes P, the points
2n_odd P lie in 2T. Once they generate 2^delta distinct reduced classes,
the subgroup equals 2T by its known order. This is an exhaustive
certificate, even if the generating divisor classes were found by search.
No assumption that rational curve points generate the full Jacobian is
needed: attaining the required subgroup order proves what is needed.

## 2. The actual fixed curve

Take q=125 and sigma=pi³. All 52 branch points are rational. The
[new hyperelliptic descent theorem](HYPERELLIPTIC_LOW_DEGREE_TWO_PRIMARY_TORSION_DESCENDS.md)
gives W6 two-primary torsion rational over F125, using

    v2 det(sigma-I)=56,  v2 det(sigma+I)=51,

and the low-degree Frobenius-difference lemma. The second valuation
implies that the two-primary kernel of sigma+I has exponent4; since
4*6<=25, that descent theorem applies.

Now delta=56-50=6, so 2T has only64 elements. The
[standalone exact certificate](FIXED_Y_SMALL_DOUBLED_GROUP_CERTIFICATE.sage)
constructs all64 using rational points of Y and Cantor arithmetic.
It verifies their reduced Mumford degrees have distribution

    degree0:1, degree22:4, degree24:3, degree25:56.

In particular every nonzero member has degree at least22, greater
than12=2*6. Section1 proves the theorem. The certificate completed
in about eight seconds on the current environment.

## 3. What this restores and what it does not prove

The checked parameterized logarithmic-torsion theorem in
`TWO_POINT_LOGARITHMIC_DIFFERENTIAL_TORSION.md` forces a class
[E_Y-6O] of exact order16,32,or64 in the previously unresolved
two-point wild family. The present theorem excludes that family using
Y alone, independently of the new genus-nine W2 obstruction.

Thus the two endpoint arguments provide genuinely different ways to
close that same unbounded branch, useful if one endpoint is changed.
This does not settle other cored signatures or produce a clump for a
coreless span. It also does not imply that all small cyclic etale covers
of Y are ordinary; a checked nonordinary double cover still exists.

The stronger global scalar-Frobenius shortcut remains false for this Y.
All J[2] is rational over F125, of size2^50, while v2(#J(F125))=56;
there is therefore an F125-rational point a of order4. Its F5-Galois
orbit has odd size dividing3 and cannot contain -a=3a: if pi^j(a)=-a,
then (pi^j)^3(a)=-a, contradicting pi^3(a)=a. This point is not on W6.
The exact Weil coefficients and resultant are retained in the
[integer data certificate](FIXED_Y_LOW_DEGREE_TORSION_FROBENIUS_CERTIFICATE.py).
