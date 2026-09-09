# NC Pro response — 2026-09-08

Verdict: NC remains OPEN. No counterexample and no existence proof.
The response does not change the two remaining unmarked-cover branches.

## What was accepted and strengthened

1. The rational two-leg Frobenius–Cartier sequence is correct. The
   canonical theorem `two_leg_cartier_quotients` now proves it in every
   characteristic and identifies both defects WITHOUT no-clump:
   ker F=ker(C on I_(pm+1))/D I_pm and ker D/im F=coker(C on I).
   No-clump kills these defects. Repeated fifth powers cannot remove
   a nonzero Schwarzian class. This closes a possible false shortcut,
   not the existence gap.

2. The genus-two quintic is correct, including scheme-level triangular
   elimination. The count five was already in dormant_rank_two_candidates;
   the universal explicit formula was not. Exact symbolic verification
   passed. For the ACTUAL selected family C_t, the new resultant identity
   is Res(Psi,Psi')=-[t(t-1)(t-2)(t-3)]². Thus all smooth members have
   five DISTINCT dormant points. General genus-two fibers need not be
   reduced: the universal discriminants of F and Psi are NOT proportional.

3. The gcd criterion is valid, including the exclusion of multiple
   matching roots and the Bezout degrees. It requires the already given
   actual joint field. It does NOT bound that field, map degree, or poles
   of the A-valued certificate. It therefore is not an enumeration or
   exclusion of all possible spans. Registered with the quintic theorem.

## Where pushing this answer reaches a wall

The obstruction is a quotient class, not a common tensor. Its nonzero
Frobenius iterates occupy growing-weight spaces, so they do not contradict
the absence of shared tensors or yield a finite-dimensional invariant
space. The new endpoint reducedness does not survive arbitrary etale
pullback by any theorem available here. Neither ordinarity nor Hom-zero
has entered a mechanism forcing a nonconstant gcd.

The next Pro target is the genuinely different A18 generic-radical
problem, formulated in PRO_ATLAS_GENERIC_RADICAL_REQUEST.md. A positive
answer removes the higher-normal-corank branches on the twelve acyclic
representatives, including orbit0011; it is not an atlas emptiness proof
and leaves the six nonacyclic representatives. Main work returns to
ATLAS_REDESIGN.md and the full inverse-cup/Frobenius system, independently
of this proposed generic-rank lemma.
