# Hermitian coefficient rank and elimination audit

Verdict: PASS for the rank bound and both algebraic eliminations below,
with the stated scheme and genericity qualifications.
Auditor: /root/rank_reduction_audit. Date: 2026-09-06.
Scope: bounded independent prose audit of the proposed new claims;
not a verification of the numerical sample computations, the complete
new scalar reconstruction theorem, or the original common-cover problem.

## Rank bound

For stable rank-two V with det V=omega on a genus-nine curve, a
surjection pi:V->omega^2 has kernel omega^-1. Its dual sequence is

    0 -> omega^-2 -> V^vee -> omega -> 0.

Stability gives H^0(V^vee)=0. The connecting map embeds the
nine-dimensional H^0(omega) into H^1(omega^-2); its image is exactly
the kernel of pi^*. Thus pi^* has rank 31, since h^1(omega^-2)=40.
Composing with Frobenius pullback, dual-extension identification and
j0^-1 has rank at most 31. More precisely, if P represents pi^* and
N represents the subsequent semilinear map, its coefficient matrix is
N P^[5], up to the specified duality sign. The ordinary matrix kernel
contains the Frobenius twist of ker P, not necessarily ker P itself.

## Rank-31 lower block

Suppose the system is a lambda+A lambda^[5]=g,
B lambda^[5]=h, with a invertible, A of size 40 by 40, B of size 56
by 40, and rank [A;B]<=31. Choose 31 rows I and columns J with
D=B_IJ invertible. On the rank-31 determinantal chart,

    A=A_J D^-1 B_I,    B=B_J D^-1 B_I.

Consequently the original system is equivalent to

    h_Ic=B_Ic,J D^-1 h_I,
    B_I [a^-1(g-A_J D^-1 h_I)]^[5]=h_I,

and lambda is uniquely a^-1(g-A_J D^-1 h_I). These are 25+31
displayed equations, with no assertion of their independence.
The proof uses matrix identities and substitution, not extraction of
fifth roots, so gives an isomorphism of solution schemes after inverting
a and det D and imposing the determinantal equations. It remains valid
over nonreduced test rings on this chart.

## General ranks

On the rank-s stratum of M=[A;B], choose s pivot columns forming C.
They identify im M with a free rank-s module on the pivot chart, and
write M lambda^[5]=Cu uniquely. If the lower block has rank r,
choosing a lower-block r by r pivot solves r coordinates of u and
leaves 56-r compatibility equations and d=s-r free coordinates.
Substitute lambda=a^-1(g-C_top u). A full-rank s-row pivot of C
reduces M lambda^[5]=Cu to s equations. Thus there are 56+d displayed
equations in d remaining auxiliary coordinates, scheme-theoretically.
Rank strata here mean minors vanish as equations and the selected
pivots are inverted; geometric pointwise ranks alone do not justify
the assertion over a nonreduced parameter base.

## Genericity limits

For a fixed V with algebraically varying quotient parameters, a verified
rank-31 sample proves the rank-31 locus nonempty and open. The space of
surjections is an open subset of the vector space Hom(V,omega^2), so
this locus is dense for that fixed V. Two tested V give this conclusion
for those two V only. Neither all dormant V nor every component of a
dormant-oper parameter scheme is covered by those samples.

Canonical inputs inspected: the statements, dependency listings and
proofs of semilinear_hermitian_lift and
hermitian_atlas_extension_criterion, and the Frobenius-form conventions.
