# The critical-cover argument transfers to the constant family

[Statement](../../Theorems/cartier_and_spin/degree140_constant_critical_monodromy.md).
The accepted ratio-source coefficients are read from the received
[constant-family source](../../../litt3-computation-data/september29_replies/primitive140_continuation_record/primitive140/data/ratio_source.json).
They give G_i/w on q*z^3=P(x), with H=h*w and q=w^3. The
[new exact constructor](../../scripts/arithmetic/constant_critical_norm_source_20260929.sage)
forms
\[
\Delta_c=(4(G_1/w)^2+3(G_0/w)(G_2/w))/z^6.
\]
Division by P^2, using z^6=P^2/q^2, is exact. Relative to the
original critical discriminant this changes only a nonzero parameter
scalar that is geometrically a square. Further divide by the leading
coefficient B of the z^2 component, a nonzero constant times q^2.
The resulting coefficients d0,d1,d2 have degrees(10,7,4), with
d2[4]=1 and d1[7] a fixed nonzero constant.

## No downstairs square class

The pole-order argument in the
[root-nine nondescent proof](degree140_root9_critical_nondescent.md)
applies verbatim: a descended square class would be represented by
a monic quartic f dividing P. The case with a vanishing y-character
is excluded by the degree mismatch18 versus17; the case with a
vanishing y2-character would make Delta a square, excluded by the
accepted constant-family critical-discriminant identity. Both remaining
character coefficients are nonzero constants and the scalar comparison
has exactly the same two equations on q*z^3=P.

Put R=d2-f, M=d1[7], N=R[3], and k=N/M. Since M is now a fixed
nonzero constant, there is no exceptional M=0 chart. The necessary
identities are
\[
qk d1=qfR+(P/f)k^3,\qquad
4qk^2d0=qfR^2+3Pk^3.
\]
For each of the210 quartic divisors of P, the exact coefficient ideal,
localized only at q,H,N, contains1. The
[new construction](../../scripts/arithmetic/constant_critical_nondescent_20260929.sage)
retains every multiplier and verifies its polynomial combination
literally. All210 identities passed. q and H are original units,
while N is nonzero precisely because k, and hence the required
character coefficient, is nonzero. Thus no geometric downstairs
square class is omitted.

## The critical cubic norm is also nonsquare

Use the norm and eight square-root tails17..24 from the
[root-nine norm argument](degree140_root9_critical_monodromy.md),
now with the constant-family d_i. Its first three tail bidegrees are
(16,96),(17,102),(17,108). The two fixed H-resultants consequently
have q-degree bounds3264 and3360. The same exact algorithm reconstructs
them at3756 roots of unity, exceeding both bounds. Their actual
degrees are2279 and2375, and their monic gcd is
\[
q^{481}(q-q_1)^2,
\]
where q1=2a7+4a6+3a4+4a3+4a2+1 in the fixed prime-field model
a8+a6+2a3+4a2+2a+2=0. The q factor is already an original unit.
The additional factor is retained rather than inverted.

On the entire fibre q=q1, the eight H-polynomials have an exact
combination equal to1. The
[boundary constructor](../../scripts/arithmetic/constant_critical_norm_boundary_20260929.sage)
checks that identity and the global univariate Bezout identity
literally. Hence the localized tail ideal I contains(q-q1)^2, and
I+(q-q1) is the whole ring. If1=i+(q-q1)u, squaring this equality
shows1 belongs to I: i2+2i(q-q1)u is in I and(q-q1)^2u2 is in I.
This retains all nilpotents and closes the full geometric chart.

All new exact rows, resultants, projection and boundary multipliers,
and the210 nondescent identities are retained in the
[evidence directory](../../../litt3-computation-data/conceptual_continuation_20260929/constant_critical/).
The accepted source certificates were not replayed; the source
transformation and the new implications were computed and checked.

## The group

The cyclic F2[C3]-module proof in the
[root-nine monodromy theorem](degree140_root9_critical_monodromy.md)
now applies without change. Nondescent excludes dimension one;
nonsquare norm excludes dimension two. The three conjugate square
classes are independent, giving(C2)^3 semidirect C3, or C2 times A4.
This statement concerns the ramified auxiliary critical cover only.
