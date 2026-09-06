# The earlier scalar-Frobenius boundary is bypassed

The actual W6 torsion question formerly left open here is now settled by
the independently checked [small doubled-group theorem](FIXED_Y_TWO_PRIMARY_W6_HAS_ONLY_TWO_TORSION.md).
Its [hyperelliptic descent argument](HYPERELLIPTIC_LOW_DEGREE_TWO_PRIMARY_TORSION_DESCENDS.md)
does not assume that Frobenius acts by a scalar. The obsolete attempted
scalar certificates and the old open-question discussion were removed.

One warning remains useful: the full property that every two-primary
point has a Galois conjugate equal to its triple is FALSE for this Y.
Indeed all J[2] is rational over F125, of size2^50, whereas
v2(#J(F125))=56. Thus there is a rational point a of order4. Its
F5-Galois orbit has odd size dividing3 and cannot contain -a=3a:
if pi^j(a)=-a then (pi^j)^3(a)=-a, whereas pi^3(a)=a.
This point is not on W6, by the new theorem.

The [integer data certificate](FIXED_Y_LOW_DEGREE_TORSION_FROBENIUS_CERTIFICATE.py)
now retains only the Weil coefficients and exact resultant actually used
by the new group computation. The separate scalar-search calculation is
no longer an active proof dependency.
