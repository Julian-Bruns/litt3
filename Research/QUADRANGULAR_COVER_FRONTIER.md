# Small-cover Hecke work completed locally

2026-09-09,17:43CEST. Auxiliary BACKUP work; main X/high-degree Y_t
unchanged. No solver or agent running. The former quadrangular question
was resolved locally and its unsent draft removed. The replacement
[degree24 prompt](PRO_BACKUP_TRIANGLE246_REQUEST.md) is ready for the user.

## Three new exclusions, with actual geometry

1. `triangle344_frobenius_obstruction` v2: moduli Frobenius orbit>=3
   forces any genus-two uniform(3,4,4) map through an actual elliptic
   double quotient. Complete10-class census; all three surviving
   order576 cases have preserved pair blocks. Aut(C_alpha)=C2 excludes
   them. No Jacobian arithmetic or character table is now needed.
2. `quadrangular_genus_two_hecke_obstruction`: uniform2233 degree6
   with Aut=C2 is impossible, since S4/C4 has an elliptic double quotient.
3. Its degree12 uniform2223 case gives an actual integral symmetric
   T with T^2=[5]. The identity is A^2=5Delta+2A+2B for actual degree5
   etale correspondence cycles, and B=iota A. The backup's Rosati-fixed
   field Q(sqrt21) has no sqrt5. This was the prepared Pro target,
   now solved by root. No independent audit is claimed.

The backup therefore has FOUR tame and THREE small-wild rows left.
The first remaining tame row is C's own hyperelliptic pencil and cannot
be excluded on C alone; its actual X leg is essential. See BACKUP_CANDIDATE.

## Reproduction

- `scripts/verify_triangle344_monodromy.cpp`: complete enumeration of
  1,247,400 permutations,11,178 valid pairs,10 classes, plus all three
  elliptic quotients,0.052s. Sanitized replay PASS,0.071s.
- `scripts/genus_two_quadrangular_monodromy.sage`: COMPLETE9/39
  subgroup censuses for2233/2223, matching published counts including
  nonnormal subgroups;0.27s/5.83s excluding startup.
- `scripts/verify_quadrangular_quotients.py`: Python stdlib, every
  retained row's group/deck data, six elliptic quotients and18 exact
  integer adjacency identities;0.013s. This checker alone does NOT
  establish completeness of the input census.

Receipts are in computations/triangle344_native_verification.txt,
computations/genus_two_quadrangular_{2233,2223}.json, and
computations/quadrangular_quotient_verification.txt.
Proofs and primary sources are canonical; do not duplicate them here.

## Remaining boundaries

The small Hecke proof relies on an ACTUAL hyperelliptic deck involution
on a genus-two source. Arbitrary main Y-leg closures have no supplied
such involution; this result is not a general coreless obstruction.

The earlier quick radical-quadratic test of246 gives an ACTIVE
nilpotent connection, not a dormant one:
r=3/[t^2(t-1)], E=1/[t^2(t-1)^3], N=0.
The dormant tangent exclusions therefore do not apply.
The canonical radical theorem now contains an EXACT alternative for246:
on each of85 known active quartics s=A eta^4 with div(s)=2D, solve
(delta f)^4=3A f^2(f-1)^3 in H0(O(6D)), retaining pole divisor EXACTLY6D.
The space has dimension23; the equation plus pole condition recovers
every local ramification index. Its fourth-root cover maps to ordinary
E:y^2=x^3+3x, with degree12 or24. That root cover is ramified over C;
neither its elliptic factor nor the residual equation is excluded.
Use radical_quadratic_atlas_obstruction v2 for the proof, not this note.
For238/237 the branch fibers are too large to support that regular
quadratic radical.

Return to priorities1/3. Do not launch a large degree24/48/84 low-index
enumeration blindly. An index-two triangle-group inclusion usually
creates a new genus-three double cover of C, not a344 atlas on C.
