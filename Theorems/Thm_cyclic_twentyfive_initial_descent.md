# Initial two-digit descent along an original cyclic-twenty-five cover

Version1,2026-09-10. Proved; focused independent medium audit PASS for
the actual geometric comparison and separately its general scope.
Auditor /root/audit_cyclic25_initial_comparison. Audited prose, not Lean.

Let h:T→C be an ACTUAL connected finite etale cyclic25 cover of smooth
projective curves over bar(F5), g(C)>=2. Retain an active admissible
projective connection on C, its full preceding filtered Higgs--de Rham
tuple, prescribed graded identification and actual flat square-trivial
periodicity line. Let Psi_C have a bijective part of dimension3g(C)-4
and a one-dimensional zero part, and assume source defect2 on T.

Fix a GIVEN compatible reference C5^0 and its lifted original cover
T5^0. Here compatible W_j means that the full preceding tuple extends
through W_(j-1). No general existence of such a reference is asserted.

The actual source operator admits normalized nil-block coordinates

    R=k[e]/e25, e=sigma-1, Psi_nil=e²Phi,
    ker Psi_T=k e23+k e24, D_T=coker Psi_T=R/e²,
    h*(ker Psi_C)=k e24.

For every compatible marked third lift

    T3(d,b)=T3^0+d e23+b e24,

a compatible fourth extension exists. Its next Hodge obstruction
Theta(d,b) is independent of that compatible fourth digit and equals

    Theta(d,b)=d^5e in D_T,

under rho(S+xi)=rho(S)-Psi(xi). There is exactly ONE coefficient
Frobenius, and no quadratic remainder. Therefore T3(d,b) admits a
compatible W5 extension if and only if d=0. In that case the GIVEN
third truncation, with its tuple and marking, descends along the
ORIGINAL h to C3^0+b e_C, where h*e_C=e24.

The free integral deck lattices and cochain-level primitives needed
in the proof follow from these actual-cover/simple-defect hypotheses.
The result is not restricted to one genus or an involution. The
explicit genus3/genus51 family in the original request satisfies it
on Delta(t)=(t5-t)(t²+2t+3)(t²+2t+4)!=0, with no new exceptions.

This proves initial W5-to-W3 descent, NOT all-level cyclic25 descent,
descent of a given W5 itself, or a common-cover exclusion. The original
unmarked common-cover problem remains UNSOLVED.

[Proof](../Solutions/Sol_cyclic_twentyfive_initial_descent.md) ·
[Audit](../Research/audits/CYCLIC25_INITIAL_COMPARISON_AUDIT_2026_09_10.md).
