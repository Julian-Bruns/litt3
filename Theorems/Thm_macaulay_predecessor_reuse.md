# Exact predecessor reuse for bounded polynomial multiples

Let K be any field, f_1,...,f_m polynomials, and T the monomials of total
degree at most B in a chosen subset of the variables. Order T by a
degree-compatible multiplicative monomial order, and order rows t*f_i
first by t and then i.
Fix ANY column order for their finite coefficient matrix. Consider
incremental normalized forward elimination, recording each row's new
pivot polynomial or its zero outcome.

For t!=1 choose a variable z dividing t. Instead of loading t*f_i:

- If the earlier row (t/z)*f_i reduced to zero, skip the row as dependent.
- Otherwise let p be the recorded normalized pivot polynomial for that
  earlier row. Load z*p and reduce it against the current pivots.

At EVERY input-row prefix this algorithm spans exactly the same vector
space as the original matrix. It has the same rank, pivot-column set,
zero-row decisions, and first input index at which 1 is in the span.
Every resulting relation has a certificate with multipliers in span(T).
No genericity or characteristic assumption is needed.

Stored pivot tails need not coincide: forward elimination stops at its
first new pivot and does not necessarily reduce against later pivot
columns. Certificate or rowspace checks, not byte-equal tails, verify the
algorithm. No speedup or favorable sparsity follows from this theorem.

For atlas matrices, take T to be b-monomials of degree<=B and keep the
v variables linear. This applies over every one of the18 exact coefficient
fields. It does not itself implement fast arithmetic in those fields or
prove a bounded degree B sufficient to exclude an atlas.

Status: author proof,2026-09-07. Implementation validation pending.
[Proof](../Solutions/Sol_macaulay_predecessor_reuse.md).
