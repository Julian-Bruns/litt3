# Fixed quotient atlases can be excluded without enumerating them

Let k=bar(F_p), let D/F_q be smooth projective geometrically connected
of genus d>=2, and let a finite constant group G act on D over F_q.
Put S=[D/G]. For h>=2 define

    n=(h-1)|G|/(d-1),   a=2d+floor(log_2|G|).

If n is not an integer, no genus-h curve admits a representable finite
etale map to S. Otherwise at most (n!)^a geometric isomorphism classes
do so. The bound allows wild stabilizers, non-Galois atlases, and
disconnected pulled-back G-torsors. It is stable under q-Frobenius.

More generally, for a finite list of such F_q quotient targets, sum
their bounds. If a family Y_t/F_q has at most c parameters in each
geometric isomorphism class, then any parameter of prime degree

    r > max(c, sum of the bounds)

gives a curve with no atlas to any target in the list.

## The already selected genus-two partner needs no Hermitian census

In characteristic five take H: X^6+Y^6+Z^6=0 and G=PGU_3(5), with
their F25 models. Here d=10, |G|=378000, n=42000 for h=2, and a=38.
Thus at most

    N_H=(42000!)^38

genus-two isomorphism classes admit a Hermitian quotient atlas.
For the ordinary family

    Y_t: v^2=u(u-1)(u-2)(u-3)(u-t),

every prime degree r=deg_F25(t)>N_H excludes ALL such atlases.
In particular no atlas to [H/PSU_3(5)] or [H/G'] for ANY subgroup
G' of PGU_3(5) exists: composition with [H/G] would give one.
This includes every cubic determinant character, not just untwisted forms.

The parameter bound ALREADY used in bounded_atlas_partner_finiteness
for fixed X, B=336000 and h=2 is larger than N_H. Therefore every Y_t
in that theorem's selected pair already has this no-Hermitian-atlas
property. No change of X or of the prescribed parameter bound is needed.

Scope: this does NOT prove A18 for the original genus-nine X, does not
decide the original small-field genus25 partner, and does not infer an
atlas from an arbitrary common dormant/nilpotent connection. It supplies
an independent atlas exclusion on the selected OTHER endpoint, not a
solution of the unmarked common-cover problem.

Version2,2026-09-13. Author proof using the already audited covering-count
argument; this new corollary has not been independently audited or Lean
verified. [Proof](../../Proofs/quotient_geometry/fixed_quotient_atlas_avoidance.md).
