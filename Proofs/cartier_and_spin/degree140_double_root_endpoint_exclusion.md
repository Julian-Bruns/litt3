# Proof: complete endpoint incidence and the unit conclusion

27 September2026. This integrates Sections35--50 of the stopped Pro
[report](../../../litt3-computation-data/double_root_square_endpoints_reply_20260927/extracted/REPORT.md).
The fixed source and K-code convention are those of
[the cubic ratio construction](degree140_linear_cubic_cusp_exclusion.md).
All original source and scale conditions are retained. In particular,
the ratio equation is g=b(q)u^2+2c(q)u+3e(q)=0, and the ordinary-double-root
open has bu+c!=0. The field K is a coefficient field, not a bound on
the unknown geometric ratio or scale.

## Normalization and statement at one endpoint

Use the exact scale substitution tau=q^2 nu and normalized residual
Rstar=q^48 d^36 R. The multiplying factor is the square of q^24 d^18,
a unit on the original open. Thus this does not change squareness.
The polynomial has x-degree140 and scale-degree at most6. Its complete
global array, including every coefficient, is tied to the actual source
by exact normalization divisions and separately reconstructed norms.

Let I be the full seventy-equation square ideal, not only its first
tails, and choose a root a of t. Write
F_a=Rstar(nu,a), G_a=partial_x Rstar(nu,a). The computational core proves
I+(F_a,G_a)=(1), on exactly the authorized open. It includes every
vanishing leading coefficient and every scale on the projected support.

## Finite incidence coverage

The fraction-free resultant factorization in Sections43--46 reduces
the simultaneous incidence F_a=G_a=0 to two explicitly factored ratio
projections, of lengths2,244 and1,518 with their multiplicities retained.
Complete scale gcd identities give two linear graphs, of reduced sizes
264 and726, and one quartic-scale algebra over a396-point ratio support.
Other blocks are excluded by gcd1 or by the original nonzero-scale open.
No primitive-element choice selects just one root of the quartic.

For each endpoint, the quartic algebra is presented by a monic polynomial
of degree1,584, with explicit q,u,nu satisfying its original equations.
The relation z=nu+q proves surjectivity of the presentation. Equal
dimensions396*4=1,584 prove that it is the FULL algebra. An independent
squarefreeness check also passes; that property is not needed to justify
the dimension argument.

On each of the three algebras per endpoint the actual norm is reconstructed
with all141 x-coefficients. It is compared to a second reconstruction from
the global residual array. The normalized square tails in degrees71,72
are reconstructed independently by the ordinary formal-root recurrence.
Each of the nine algebras has an exact Bezout identity making the first
tail a unit. This suffices to exclude the full square ideal there; it
does not claim that these two tails are generally sufficient.

Projected primary multiplicities are at most10. A unit identity modulo
a squarefree factor Z lifts modulo Z^m by raising it to25: in
characteristic five, (j+cZ)^25=j^25+c^25 Z^25 and Z^25=0 for m<=10.
The Chinese remainder theorem covers every primary block. The global
fraction-free resultant identity then proves I+(F_a,G_a)=(1).

## Why evaluation becomes a unit in the square algebra

In the full square algebra there is an identity Rstar=Lstar B^2 with
Lstar a unit and B the canonical normalized root polynomial. Therefore
F_a=Lstar B(a)^2 and G_a=2Lstar B(a)B'(a), so G_a^2 belongs to(F_a).
Modulo F_a, G_a is square-zero but generates the unit ideal by the previous
paragraph. Squaring a relation1=cG_a gives1=0. Thus F_a is a unit modulo I.
This argument preserves all nilpotents.

The three endpoint evaluations give a global unit
Omega=Res_x(t,Rstar), of scale-degree9. Together with the earlier complete
ten-branch exclusion, the exact global identity is
\[
\operatorname{Res}_x(Pt,Rstar)
 =q^{98}(q-\langle118020\rangle)^{84}\Lambda^3\Omega.
\]
Here Lambda is the degree19 scale polynomial supplied by the ten-branch
calculation. Every displayed factor is a proved unit in the square algebra.
This proves the asserted coprimality. Inverting a projected content
polynomial alone would be unjustified: its companion u-sheet need not be
excluded. The integration does not make that extra localization.

## Evidence and execution scope

The entire original archive and manifest are retained in
[the receipt](../../../litt3-computation-data/double_root_square_endpoints_reply_20260927/receipt_manifest.json).
The111 executable source files have byte-exact copies under
[the source directory](../../scripts/arithmetic/pro_double_root_endpoints_20260927/).
Verification was performed in a separate external copy, preserving the
original extraction. On this Mac the only environment adjustment was
CPATH=/opt/homebrew/opt/gmp/include and LIBRARY_PATH=/opt/homebrew/opt/gmp/lib.

The driver `python3 -u src/verify_endpoint_continuation.py --jobs 2`
passed ALL51 commands. It freshly reconstructed the endpoint/source
identities, complete ratio/scale algebras, all nine full norms and separate
root recurrences, exact Bezout identities and global endpoint factors.
The [execution summary](../../../litt3-computation-data/double_root_square_endpoints_reply_20260927/execution/logs/endpoint_continuation_checks.json)
records228.209 seconds and all successful commands. Earlier1,375 prefix
samples and old large graph-norm replays were not freshly recomputed by
this default endpoint driver; their prior provenance remains explicit.

The general ideal-lifting arguments above were reviewed directly. The
result is a complete endpoint-incidence exclusion, with the global
ordinary-double-root square decision still unresolved.
