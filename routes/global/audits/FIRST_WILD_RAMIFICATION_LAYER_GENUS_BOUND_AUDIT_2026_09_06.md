# Audit: first wild ramification layer versus atlas genus

Date: 2026-09-06. Auditor: `/root/contact_bound_to_core_audit`.
Verdict: **PASS**. No mathematical objections or required repairs.
No subagents used. Scope is the new first-layer theorem and its stated
bounded-abelian-index consequence, not other historical or downstream
degree claims.

Audited [the theorem file](../../../Solutions/Sol_wild_first_layer.md),
reading the needed portions of the integral-jump theorem, file 13's
first-break Swan proof, the audited Artin--Schreier translation-rank
theorem, the single-jump bound, and the bounded-denominator theorem's
representation-theoretic corollary. No audit archives were read.

## Critical geometric passage

For nontrivial N=P_2, the F_p-vector space dual to N/Phi(N) is nonzero.
A finite p-group acting on this space has a nonzero fixed vector
(the number of fixed vectors is divisible by p, and includes zero).
The kernel gives an index-p subgroup N0 normal in P. This needs no
assumption that N is abelian or central.

Upper-numbering quotient compatibility shows the quotient P/N0 retains
its first break 1 and first quotient P/N. Just after this break its
ramification group is N/N0. Thus its second lower group has order p,
and the audited translation-rank theorem applies with the same rank r.
It gives B-1>=p^ceil(r/2)=Q in both its integral and exceptional cases.

The HKG quotient H/N0 is again a one-branch P/N0 cover of P1. Its genus
is therefore `2g(H/N0)=(p-1)(B-1)`. Subtracting the Hurwitz formulas
for H/P and H/K, using subgroup lower-numbering compatibility and
P_0=P_1=P, gives exactly

    2|K|g(H/K)=sum_(i>=2)(|P_i|-|K intersect P_i|).

This is at most 2g(H), including when K is nonnormal. At K=N0,
|K|=|N|/p, so the claimed bound

    2g(H)>=(p-1)|N|Q/p

is valid. This confirms the main new step for arbitrary wild P.

## Arithmetic and case completeness

- The first-break bound follows from `(q+1)/(q-1)<=2` for q>=3.
  File 13's Swan proof works verbatim with p replacing five. Since
  Q divides q, multiplication by m gives `Q|D+(b+1)m`.
- Genus zero means P_2=1 and one jump, covered by the retained
  single-jump bound. The non-large case either bounds q immediately
  or gives the stated finite range for m; combining it with Swan
  divisibility bounds Q. The q=p case is already bounded.
- The large inequality forces b=1. N=1 has genus zero and was already
  removed. The tame character on P/P_2 is faithful and gives
  `t0|p^r-1`; Swan gives `Q|D+2m`.
- In the m>=t0 case, the genus lower bound gives
  `D>=(p-1)Q-2`. In the w>=2 case, m<D gives Q<3D.
- For w=1, the upper bound on m follows by evaluating the decreasing
  function `D(vA+1)/((p-1)vQ/p-2)` at v=p. Its denominator is positive.
  The displayed estimate k<7D is valid for all p>=3 and Q>=p.
- From `2t0=kQ+D` and `t0|A-1`, squaring modulo t0 proves
  `t0|D^2-e k^2` without cancellation by a nonunit. A nonzero
  right side gives exactly the stated uniform bounds on t0 and Q.
- If the right side is zero, e=p is impossible; e=1 gives k=D.
  Since Q is odd, m=D(Q-1)/2 is divisible by D. Coprimality forces
  D=1. Then m divides q+1, hence p^a+1 with |N|=p^a. Reducing a
  modulo s, where Q=p^s, is legitimate because p^s=1 modulo m.
  The resulting `(p-2)p^(s-1)<=3` implies Q<=9, including p=3.
- Thus b and r are bounded in all cases. If N has an abelian subgroup
  of index at most J, its index in P is p^r times that index.
  The cited representation-theoretic corollary then applies exactly
  as stated; no bound on |N| is silently assumed.

## Specialization h=16, p=5

All exclusions check. The m>=t0 case would require D>=18, impossible.
For w>=2 and r>=3, Q>=25 while `D+2m<48`; D=1 is impossible and
the other D are even, so no multiple of Q is possible in that range.
For w=1, reduction modulo four makes m and D have the same parity;
coprimality and D|16 force D=1. The displayed odd-r estimate is
strict already at Q=5. For even r>=4, Q>=25 gives `1+2m<3Q`;
its oddness forces it to equal Q, landing in the exceptional case,
where p=5 requires Q<=5. Finally r=1 contradicts the strict large
inequality directly. Therefore every large case has b=1 and r=2.

The proof bounds the first graded quotient and the first lower break.
It correctly leaves the unrestricted deeper subgroup N unbounded.
