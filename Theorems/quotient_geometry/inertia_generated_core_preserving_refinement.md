# Core-preserving refinements with fixed auxiliary degree

Let k be algebraically closed. Start with an ACTUAL finite bi-etale
coreless span X <- Z -> Y of smooth projective connected curves of
genus at least two.

## General compositum criterion

Let X'->X and Y'->Y be finite Galois covers whose inertia groups
normally generate their full Galois groups. Suppose their completed
extensions, pulled back to Z, agree at every point. In the tame case
this means the SAME ramification index at each point of Z.

Every connected component of the normalized reduced fiber product
X' x_X Z x_Y Y' is an ACTUAL bi-etale coreless span X'<-W->Y'.
No coprimality with either original leg degree is needed. If in
addition both auxiliary Galois groups are perfect, every prime-to-char(k)
primitive canonical weight is preserved EXACTLY.

## A uniform characteristic-five construction

In characteristic five, let C have genus at least two, D a nonempty
reduced divisor, and n in {2,3,4}. There exists a Galois cover C'->C
with group PSL2(F7), degree168, ramification index n at EVERY point
of D and nowhere else. It is genuinely ramified and its group is
perfect. Its genus is

    g(C')-1 = 168(g(C)-1) + 84(n-1) deg(D)/n.

Therefore any actual coreless bi-etale span with a clump admits
compatible degree168 endpoint covers of any one of these three
uniform indices, retaining both upper etale legs, corelessness and
every prime-to-five primitive canonical weight. The original leg
degrees each grow by at most a factor168.

## Application to all positive Cartier-zero generators

Suppose the original shared canonical ring is k[s], with primitive
weight d prime to five and div(s_C)=eD_C at the endpoints, D_C reduced.
Suppose its eligible generalized Cartier image is zero. Put E=e/d
in F5. If E=0, take n=1 and identity covers: the existing equation
is already regular and transverse.
Otherwise E is in {1,2,3}; choose respectively n=3,2,4 above.

On the resulting ACTUAL coreless bi-etale span, the pulled-back s
still has primitive weight d. Its zero multiplicity

    e'=n(e+d)-d

is divisible by five. The associated dormant projective connection
is globally regular and its distinguished horizontal Borel is
everywhere transverse to the oper Borel. Both objects match on W.

This is a fixed-DEGREE refinement, independent of the original leg
degrees, tensor weight, and clump size. The new endpoint GENERA
still grow with the clump size. It neither bounds that size nor
constructs a clump in an unmarked span. It changes the endpoints;
the old fixed-endpoint oper computations cannot be applied to the
new curves. Transverse dormant data are NOT themselves a contradiction.

Version2,2026-09-08: explicit genus and n=1 conventions; no substantive
extension beyond the audited scope. AUDITED PROSE, PASS by
/root/audit_inertia_refinement_medium,2026-09-08; exact group replay0.018s.
[Audit receipt](../../Research/audits/INERTIA_REFINEMENT_AUDIT_2026_09_08.md)
is reference-only; open its body only for a concrete doubt.
[Proof](../../Proofs/quotient_geometry/inertia_generated_core_preserving_refinement.md).
