# Audit: endpoint two-primary torsion in low-degree Abel images

Date: 2026-09-06. Auditor: `/root/contact_bound_to_core_audit`.
Verdict: **PASS** for the hyperelliptic descent theorem, the fixed-Y W6
theorem, and the optional fixed-X W3 and three-point Cartier theorem.
No mathematical objections or required repairs. No subagents used.

Scope: the three new theorem files linked below and their exact
certificates. The checked finite-field Boxall translation lemma and
the fixed endpoint Weil polynomials were retained inputs. No older
audit archives or unrelated downstream degree assertions were reviewed.

## Hyperelliptic descent

[The descent theorem](../HYPERELLIPTIC_LOW_DEGREE_TWO_PRIMARY_TORSION_DESCENDS.md)
is valid. A function with divisor twice the difference of the two
reduced effective divisors has degree at most 2r. If it were outside
the hyperelliptic rational subfield, the degree-two function-field
extension makes the joint map birational, and the bidegree genus bound
would give g<=2r-1. Thus the function lies in the rational subfield.
After cancellation, involution invariance forces all remaining support
to be Weierstrass points; their rationality makes their coefficients
in the Frobenius difference zero. This proves the geometric lemma.

All rational Weierstrass points imply rational J[2], so sigma² is
identity modulo four on the actual Tate module. The retained Boxall
lemma and the geometric lemma force sigma²(a)=a, proving descent to
F_(q²).

For descent further to F_q, b=(sigma-I)a lies in ker(sigma+I).
If b has exact order 2^t>1, multiplication of a by 2^(t-1) gives a
nonzero two-torsion Frobenius difference inside
W_(2^(t-1)r). The inequality 2^t r<=2^e r<=g licenses the same
geometric lemma. This includes t=1, so no order-two difference is
left over. Hence b=0.

For Y, rank(T_2J)=50 and all fifty Smith exponents of sigma+I are
positive. Their sum 51 implies one exponent two and forty-nine
exponents one, so the kernel exponent is four. Since 24<=25,
W6 two-primary points descend from F15625 to F125 exactly as claimed.
W12 has the stated F15625 rationality by the first assertion.

## Fixed Y: the exhaustive doubled group

[The W6 theorem](../FIXED_Y_TWO_PRIMARY_W6_HAS_ONLY_TWO_TORSION.md)
is valid. Replayed
`sage routes/global/FIXED_Y_SMALL_DOUBLED_GROUP_CERTIFICATE.sage`.
It completed successfully in 9.25 seconds, reporting

    complete doubled group size 64
    reduced degrees [(0,1),(22,4),(24,3),(25,56)].

The certificate checks the correct curve equation, squarefreeness,
all 51 finite branch points over F125, v2(#J(F125))=56, and
v2(det(pi³+I))=51. The latter uses the exact remainder modulo T³+1;
the displayed quadratic norm and its signs are correct.

Completeness does not require rational curve points to generate J.
For T=J(F125)[2^infinity], its order is 2^56 and its doubling kernel
is the full rational J[2] of order 2^50, giving |2T|=64.
Multiplication by twice the odd part of #J produces elements of 2T.
The certificate constructs 64 distinct reduced Mumford classes,
checks their orders and closure under its generators, and verifies
the reduced-divisor conditions. Thus it enumerates exactly 2T.

For a in W6, doubling its reduced effective representative removes
Weierstrass points and doubles the other multiplicities. It introduces
no hyperelliptic conjugate pairs and has degree at most twelve, below
the genus, so it is already reduced. Hence 2a has reduced degree at
most twelve. The complete enumeration has no nonzero member of that
degree, forcing 2a=0 and proving the claimed equality with W6[2].
This excludes every higher two-power order, with no exponent cutoff.

## Optional fixed X: W3 and the three-point Cartier obstruction

[The W3 theorem](../../../Solutions/Sol_two_primary_w3.md)
also passes. The trace-zero bundle of a bidegree(e,3) image is O(-e)^2;
normalization gives a generically full-rank injection into the curve's
trace-zero bundle. Negative degree prevents a nonzero component into
O(-b) when e<b, proving the asserted pencil bound. For the fixed
cubic curve, the integral bases at infinity give b=7. All ramification
indices of x are odd. Therefore a twice-principal divisor difference
of degree at most six must already be principal, proving disjointness
of W3 from every nonzero two-torsion translate.

The two-step Frobenius criterion is sound: M²-I is four times a Tate
module unit, so Boxall first puts every eligible point in A[4]. Then
M-I=2 times a unit eliminates exact order four, and disjointness
eliminates order two. Cayley--Hamilton and the displayed polynomial
Bezout identities establish this on the actual Tate module.

Replayed `sage routes/global/GENUS9_W3_CARTIER_CERTIFICATE.sage`.
Both its retained W2 checks and its new Frobenius remainder and
Cartier coefficient checks passed. In particular the two selected
coefficients are coprime over F25, hence cannot vanish simultaneously
anywhere in the algebraic closure.

W3 torsion triviality makes the reduced degree-three divisor a finite
unramified x-fiber. The resulting tensor formula is correct. The
generalized Cartier rule reduces weight three to the stated ordinary
Cartier test, and for weight 3g0 the identity g0*r=2+5j propagates its
nonvanishing. The specified two-branch signature has the required
power-of-two g0 because its tame factor divides the positive different
sum j(q-1)=8. Its entire stated family is therefore excluded.

Sage generated the usual sibling `.sage.py` files during replay; no
unrelated files were removed or altered by this audit.
