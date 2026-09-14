# Uniform (2,4,6) covers force an elliptic quotient or real multiplication

Version2. Exact census cross-checked by independent Python and C++
enumerations; the proof below supplies the geometric deductions.

Let p>=5 be prime and C/bar(F_p) a smooth projective genus-two curve with Aut(C)=C2,
and with geometric moduli Frobenius orbit length at least three.
If C admits an ACTUAL finite separable tame degree-24 map to P1 with
precisely the three complete branch fibers

                  (2^12, 4^6, 6^4),

then at least one of the following holds:

1. There is an actual separable degree-four map C->E to a smooth
   genus-one curve.
2. J(C) has an INTEGRAL, Rosati-symmetric endomorphism T with T²=[5].
   It comes from an actual degree-five bi-etale self-span of C with
   common quotient P1, via the previously proved degree-12 theorem.

Consequently the characteristic-five backup C_alpha admits no such map:
its Jacobian is geometrically simple, and its Rosati-fixed endomorphism
field is Q(sqrt21), which does not contain Q(sqrt5).

The complete census has40 classes. Of these,23 have extra deck
automorphisms,6 have a nonhyperelliptic deck involution,3 lie in
Frobenius-stable parts of sizes1 or2,4 force an elliptic quotient, and4
factor through the already excluded degree-12 profile2223.

This supplies one profile of the
[complete backup cored theorem](../endpoint_exclusions/backup_cored_span_exclusion.md).
It excludes no arbitrary coreless span.

[Proof](../../../Proofs/quotient_geometry/tame_covers/triangle246_frobenius_quotient_obstruction.md) ·
[Exact receipt](../../../Research/computations/triangle246_verification.txt).
