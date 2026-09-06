# Low-degree two-primary torsion descends to a small field

Author: /root, 2026-09-06. Status: independently audited PASS by
`/root/contact_bound_to_core_audit`, 2026-09-06;
[audit record](audits/ENDPOINT_TWO_PRIMARY_LOW_DEGREE_TORSION_AUDIT_2026_09_06.md).
This is a positive refinement of the earlier fixed-Y scalar-Frobenius
boundary; it does NOT prove that every such torsion point has order two.

## Theorem

Let C/F_q be an odd-degree hyperelliptic curve of genus g, in odd
characteristic, with all Weierstrass points F_q-rational. Embed its
W_r in J using the point at infinity, and write sigma for q-Frobenius.

1. If 2r<=g, every two-primary point of W_r is F_(q²)-rational.
2. If the two-primary kernel of sigma+I has exponent dividing 2^e,
   and 2^e r<=g, every such point is already F_q-rational.

### The low-degree geometric lemma

If tau is an automorphism of the algebraic closure fixing F_q, a in W_r,
2r<=g, and tau(a)-a belongs to J[2], then tau(a)=a.

Represent a uniquely by a reduced divisor E-m infinity with m<=r.
Here E has no conjugate hyperelliptic pair, no infinity, and each
Weierstrass point in E has multiplicity one. If 2(tau(a)-a)=0, a
function has divisor 2(tau(E)-E), hence degree at most2r.
A function not in the hyperelliptic rational subfield would give a
birational map to a curve of bidegree(2,<=2r) in P1 x P1, forcing
g<=2r-1. Thus the function belongs to that rational subfield and its
divisor is invariant under the hyperelliptic involution.

After cancellation, its positive and negative parts are both reduced
away from their coefficients2: neither can contain a conjugate pair.
They must therefore be supported on Weierstrass points. But tau fixes
each such point, so these coefficients in tau(E)-E are all zero.
Thus E=tau(E), proving the lemma.

### Frobenius descent

All J[2] is rational, so sigma=I+2A on T_2J and
sigma²=I+4(A+A²). If a two-primary a in W_r were not fixed by sigma²,
the checked finite-field Boxall translation lemma would produce a power
tau of sigma² with tau(a)-a a nonzero two-torsion point. This contradicts
the geometric lemma. It proves assertion1.

Now let b=(sigma-I)a. Assertion1 gives (sigma+I)b=0. If b has exact
order2^t>1, then t<=e and

    sigma(2^(t-1)a)-2^(t-1)a=2^(t-1)b

is nonzero of ordertwo. The point 2^(t-1)a lies in W_(2^(t-1)r),
because multiplication is represented by multiplying an effective
divisor (and then reducing). Since 2^t r<=g, the geometric lemma again
gives a contradiction. Therefore b=0, proving assertion2.

## Fixed genus25 application

For Y of file76 all 52 Weierstrass points are rational over F125. Put
sigma=pi³. The retained exact Weil polynomial gives

    v2 det(sigma+I)=51=2g+1.

Since sigma+I is divisible by2 on the rank50 Tate module, its Smith
exponents are fifty positive integers with sum51. Thus they are all1
except one2, and its two-primary kernel has exponent4. The theorem gives

    W12(Y) intersect JY[2^infinity] is rational over F15625,
    W6(Y) intersect JY[2^infinity] is rational over F125.

The valuation is a small exact resultant computation. In the notation
of `FIXED_Y_LOW_DEGREE_TORSION_FROBENIUS_CERTIFICATE.py`, reduce P_Y
modulo T³+1 to a+bT+cT². Then

    det(pi³+I)=(a-b+c)((a-c)²+(a-c)(b+c)+(b+c)²),

whose valuation is51. This supplies a reproducible integer formula,
not a numerical approximation or an assumption about a Tate-module
companion matrix.

The earlier pole-order argument excludes exact orders4 and8 on W6.
It does not exclude orders16 and higher in the remaining finite-field
set. We do not infer such an exclusion from these rationality statements.

Inputs: the checked [finite-field translation lemma](BOXALL_PRUFER_TORSION_AND_EVERY_CYCLIC_TOWER.md#11-the-elementary-finite-field-translation-lemma);
reduced-divisor uniqueness as recalled in
[Zarhin, Section2](https://archive.mpim-bonn.mpg.de/3152/1/preprint_2018_31.pdf).
The low-degree map and Frobenius arguments are included above.
