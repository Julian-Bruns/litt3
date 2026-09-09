# Selected-column inverse criterion — bounded audit

Verdict: PASS, with the wording clarifications below.
Auditor: /root/audit_inverse_column_compression.
Date: 2026-09-08.
Scope: Research/INVERSE_COLUMN_COMPRESSION_DRAFT.md; selected-column
scheme equivalence, all invalid quotients, nonacyclic r=3, and the rooted
R completion. This is an independent prose audit, not Lean verification
or a rerun of the numerical spanning certificate.

No blocking mathematical objection. Retain the full hypotheses of
`cohomological_bezout_data` explicitly in the final statement. In the
Cech boundary proof, “regular global 0-cochain” means a pair of regular
local sections on the fixed cover, NOT a global section of V. Its image
under b_u is closed and hence is a global section of M(-E). Indeed
a xi=0 gives d(h_V a_u i_T xi+z)=a_u i_T xi, so b_u of this cochain is
closed; the projection P_M therefore acts as the identity, including
at inadmissible u. This proves the claimed lifting obstruction without
acyclicity. Since S has no base point, every nonzero invalid u is
excluded; u=0 is excluded by Q!=0.

The scheme argument also passes: a finite-type coordinate algebra over
the algebraically closed ground field has det D in no maximal ideal,
so det D is a unit in that algebra itself, with all nilpotents retained.
The universal inverse block belongs to the fixed linear space im K on
the admissible open. Surjectivity of S*H0(M)->H0(M^2) makes restriction
to Q a split injection of vector spaces, hence an injection after any
scalar extension. Thus the selected equations force equality of the
entire cup block over that algebra and determine Z uniquely. The same
argument applies when its rank is n-r=21; no invertibility of that cup
block, choice of a nonzero q minor, or omitted boundary chart is used.

For rooted completion, define s(v,b) explicitly as the coefficient fifth
root of the compact projected R tensor i_proj R_U(i^-1 beta)^[5], with
U replaced by v and beta^[5] replaced by b, and root D,K,Q consistently.
On the normalized inverse graph N=0 and the regular gradient identity
identifies this s with the full augmented inverse trace t. Consequently
b=s^[5] is the same rooted completion as (R), with all exceptional trace
terms included implicitly. The zero-tangent argument in the cited
inverse-cup proof is valid and gives the finite reduced scheme, not
merely a geometric-point bijection. The r*s auxiliary-variable count
and its specialization to nine variables for r=s=3 are correct.

Objections: none blocking; make the inherited hypotheses, local meaning
of Cech 0-cochain, and precise rooted definition of s explicit. This
audit certifies no runtime improvement, atlas emptiness, or solution of
the unmarked common-cover problem, which remains unsolved.
