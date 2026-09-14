# Proof: primitive Cartier constraints and endpoint roots

[Statement](../../Theorems/cartier_and_spin/cartier_generator.md).

By the [matched-section-ring theorem](../shared_tensors/matched_section_rings.md),
A_j=0 unless d divides j. This weight restriction and the two standard
Frobenius operations give all the assertions.

## 1. Frobenius descent and twisted Cartier

If d=pm, the canonical connection on omega^(pm) sends s to a matched
section of weight d+1, hence to zero. Its horizontal sections are
p-th powers of weight-m tensors, by
[Katz, *Nilpotent connections and the monodromy theorem*, Theorem5.1](https://web.math.princeton.edu/~nmk/old/nilpconn.pdf#page=17).
Equivalently, in a rational frame, da=0 gives a=b^p; valuations make
the root regular. The two endpoint roots agree on Z since their
p-th powers agree. This contradicts primitive weight d, so p∤d.

In Katz's notation let F:C→C^(p) be relative Frobenius.
[His Theorem7.2](https://web.math.princeton.edu/~nmk/old/nilpconn.pdf#page=27)
and the projection formula give

    H⁰(C,omega_C^(pn+1))
      → H⁰(C^(p),omega_(C^(p))^(n+1)).

Compose with the inverse of the natural p-semilinear scalar base-change
bijection on sections. This defines C_n on the original section spaces,
without identifying C with C^(p). It commutes with étale pullback and
obeys C_(n+b)(v^p u)=v C_n(u). Its local coefficient formula is recorded
in the definitions.

## 2. Read the target weight and leading zero

The target weight of C_n(s^r) is w=(rd+p−1)/p. Since p∤d,
d divides w exactly when d divides p−1. In that case
r=p−(p−1)/d and w=d; otherwise A_w=0. This proves the alternative,
and the p-th-power rule gives (1).

At a zero, write s locally as t^e u(t)(dt)^d, with u(0)≠0.
If e+d=0 mod p, then er=p−1 mod p. The first term survives Cartier
and has exact order

    (er−(p−1))/p < e.

This contradicts both possible outputs, zero or c s. Hence
e+d≠0 mod p. The clump conclusions follow from et=dh; if p∤h,
then e,t are invertible modulo p, so e+d≠0 is equivalent to t+h≠0.

## 3. Endpoint powers

For s_X=v^m, write mr=a+pj with 1<=a<=p−1 inverse to b modulo p.
Then n=n_b+bj, so the same p-th-power rule proves (2).
For v=beta a one-form, rd=pn+1 gives

    C_n(s_X^r)=beta^n C(beta),

which proves the eigenform assertion.

Finally, let a matched tensor of weight M be beta^M on X. Write
M=qd and that tensor as c s^q. The rational function
s_X/beta^d has constant q-th power, hence is constant. This holds
also when p divides q. Rescaling reduces to the previous paragraph.

If beta has simple zeros, then s_X has uniform zero multiplicity d.
Equality through both étale maps gives the same multiplicity for s_Y.
For p>=5 the [shared simple-root theorem](../shared_tensors/shared_tensor_core.md)
then forces a core, a contradiction. This last use explains the p>=5
qualification; the preceding Cartier constraints hold for every prime.
