# Mixed additive cyclic-power algebra: bounded audit

Verdict: PASS, pure algebra as stated. No blocking objection.
Auditor: /root/audit_cyclic_additive_preparation.
Date: 2026-09-10.
Scope: proof now recorded as
[Sol_cyclic_power_additive_norm.md](../../Solutions/Sol_cyclic_power_additive_norm.md),
reviewed initial draft SHA256 b8eca1e668446c7ca0d667637b469336fd479495cbfd93b273ccee31e8a68c67.
The canonical version adds the requested explicit norm valuation bound
and the separate diagnostic record, without changing the statement.
This is an independent prose audit, not formal verification. No geometric
Hodge comparison, cyclic25 descent, or common-cover conclusion is audited.

The argument survives the following attempted failure modes.

- Arbitrary free rank: lift images of each basis vector in pM, then extend
  O[e]-linearly. The resulting finite polynomial of coefficient
  endomorphisms acts on K[[e]] coefficientwise. Its operators need not
  commute with one another. All divisions terminate after a+1 steps in
  the p-adic filtration, so no infinite sum inside K is required.
- Distinguished division: the high-part replacement gains a factor p.
  Uniqueness follows by reducing a low-degree identity r=A g modulo p,
  then dividing and working at one lower precision. The same induction
  proves injectivity. Only coefficientwise freeness is used; the product
  module K[[e]] is not presumed free.
- Exact group and norm actions: e²S is contained in pS. For F, the printed
  estimate floor(j/2) >= v5(j)+1 for j>=2 kills every higher term. For N,
  explicitly use floor((j-1)/2) >= v5(j)+1 for j>=3. This latter estimate
  is also true: it is immediate when v5(j)=0, and for r=v5(j)>=1 follows
  from j>=5^r and (5^r-1)/2>=r+1. Thus the claimed exact F and N actions
  follow, including j=q. Adding this differently indexed inequality to
  the proof would make the norm calculation explicit; no statement
  change is needed.
- The cokernel identification follows from centrality of F and division
  by its monic distinguished polynomial. In S=K+eK, F S=p^a eK exactly.
  The norm's e-coordinate disappears in that quotient. No ring structure
  on S or commutation of coefficient endomorphisms is assumed.
- Primitive kernel: from A y=F z, the constant coordinate z0 of [z] is
  in pK. Since S/pS= (K/pK)[[e]]/e², the full reduced series z has zero
  constant coefficient. Consequently y reduces into e^(q-1); conversely
  z=e b gives every such reduced kernel vector. No dimension argument is
  hidden here, including for infinite-rank K.
- Norm solutions: base change of the cokernel formula to O/(p^a), with
  q fixed, makes every norm class zero. Lifting a solution there and
  multiplying by p gives a solution with zero reduction upstairs. Its
  translates by the kernel give precisely the stated reduction set.
  The domain automorphism Phi preserves that set.

The Witt-coefficient example is legitimate for perfect k: truncated
Witt vectors have the requisite p-annihilator equalities and are flat,
hence free over the Artin local base Z/5^(a+1). Frobenius is an additive
automorphism fixing that base. The requirement that the FULL operator
be additive and commute with the deck action remains essential.

No counterexample or extra finite-rank hypothesis was found. The scalar
proof was not needed as an unexamined dependency; the vector argument
was checked directly. Numerical tests are the main agent's separate
diagnostic and are not claimed as evidence executed by this auditor.
