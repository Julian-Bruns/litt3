# Two-leg Cartier quotients and their exact intersection defects

Let k be perfect of characteristic p>0. Let A,B be specified subfields
of a one-variable function field M/k, with M/A and M/B finite separable.
Choose separating x in A and u in B, put D=d/dx and b=Du!=0. For j>=1
write I_j=A intersect b^j B and Q_j=M/(A+b^j B), as additive spaces.
These denote rational weight-j intersections and quotients in the
(dx)^j frame, not field quotients.

For m>=1 the natural complex is

    0 -> Q_m --F--> Q_pm --D--> Q_(pm+1) --C--> Q_(m+1) ->0,

where F(a)=a^p and C(a) is the x^(p-1) coefficient root in the p-basis
expansion. It is always exact at its final two nonzero terms. Its two
possible defects have canonical additive identifications

    ker(F) = ker(C:I_(pm+1)->I_(m+1))/D(I_pm),
    ker(D)/im(F) = I_(m+1)/C(I_(pm+1)).

In particular, I_(pm+1)=I_(m+1)=0 makes the entire displayed sequence
exact. If I_j=0 for all j>0, then for every n>=1

    a^(p^n) in A+b^(mp^n)B iff a in A+b^m B.

This applies to actual coreless bi-etale spans with no common positive
canonical tensor, by canonical_intersection and its clump equivalence.
It does not prove that their Schwarzian obstruction is zero. The
nonzero obstruction, if present, survives all Frobenius powers.

Version1,2026-09-08. Author proof, including the two general defect
formulas extending the returned NC Pro exact sequence. No audit claimed.
[Proof](../../Proofs/cartier_and_spin/two_leg_cartier_quotients.md).
