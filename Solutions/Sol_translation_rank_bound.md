# Proof: Artin–Schreier translation rank and fractional jumps

[Statement and audit metadata](../Theorems/Thm_translation_rank_bound.md).
Write V_f={a:f(x+a)−f(x)∈(F−1)k[x]} and f_B≠0 for the leading
coefficient, with B>1 prime to p.

## 1. One reduced coefficient bounds every translation subgroup

Reduction modulo(F−1)k[x] replaces c x^(pj) by c^(1/p)x^j until
all positive exponents are prime to p. These reduced positive-degree
coefficients are unique; constants pose no obstruction over algebraically
closed k.

If B≢1 mod p, the reduced coefficient at x^(B−1) is B f_B a.
No smaller term contributes and no larger exponent reduces to B−1.
Thus V_f={0}, contradicting the nontrivial subgroup in the theorem.

Now write B=1+uQ, where Q=p^s, s=v_p(B−1), and p∤u.
For u>1 let j=B−Q. Then p∤j and pj>B−1, so the reduced x^j
coefficient is its ordinary coefficient. As a polynomial in a it has
degree Q and leading coefficient

    f_B binom(B,Q)=u f_B≠0.

Lower terms of f contribute lower powers of a. Every a∈V is a root,
giving |V|≤Q.

For u=1, raise the reduced x coefficient to the Qth power. It becomes

    P(a)=∑_(j=0)^s ([x^(p^j)](f(x+a)−f(x)))^(Q/p^j).

Its j=0 summand has leading term f_B^Q a^(Q²). Every j≥1 term has
degree≤(B−p^j)Q/p^j<Q², as do the remaining j=0 terms.
Thus P has degree exactly Q² and vanishes on V, proving |V|≤Q².
These root counts are necessary conditions, not sufficiency criteria.

## 2. The local application and the actual auxiliary curve

Let P=I_1, |P|=p^(r+1), and |P_2|=p. The lower jumps are1 and B;
the last group has order p, so B is prime to p. Realize the P-action
by its HKG curve H: H/P=P¹ with one totally ramified point.

For any subgroup N⊂P, subtract Hurwitz for H/P and H/N.
Since P_0=P_1=P, the constant terms cancel to give

    2|N|g(H/N)=∑_(i≥2)(|P_i|−|N∩P_i|).                     (1)

Taking N=P_2 proves H/P_2=P¹, with no large-action hypothesis.
Hence H has Artin–Schreier equation w^p−w=f(x) over that quotient,
with f reduced of degree B. The group P/P_2 acts on this x-line as
translations by an F_p-space V of dimension r.

The last ramification group P_2 is central in P: its commutators would
have break greater than B. A lift of x↦x+a therefore commutes with
w↦w+1 and has form w↦w+h_a(x), h_a∈k(x). Thus

    f(x+a)−f(x)=h_a(x)^p−h_a(x).

No h_a can have a finite pole, since its Artin–Schreier difference
would retain a pole of p times that order. So h_a∈k[x], and V⊂V_f.

Section1 is now exhaustive. If B>p^s+1 then r≤s and p^r|(B−1).
If B=p^s+1 then r≤2s; either r≤s, again integral, or s<r≤2s.
These give exactly the two upper-jump alternatives in the statement.
In the fractional case the local genus satisfies q/g(H)>2p/(p−1);
that inequality is a consequence, not an imported classification
hypothesis.

## 3. Retained atlas consequence and evidence boundary

The fractional alternative has numerical data

    Q=p^s, R=p^(r−s), p≤R≤Q,
    q=pQR, c=q+(p−1)Q−2.

These are the inputs to the separate
[order-p-second-group degree bound](../routes/global/ORDER_P_SECOND_RAMIFICATION_GROUP_FORCES_A_DEGREE_BOUND.md);
the other alternative uses the [integral theorem](Sol_integral_jump_bound.md).
For p=5,h=16, the putative B=66 pattern requires |V|=25, whereas
v_5(65)=1 and B>6 force |V|≤5. Thus only the B=6 necessary full tuples
of degrees112000 or336000 survive. Global genus-nine atlas existence
is not asserted.

The polynomial argument is independent of atlas, genus or endpoints.
For HKG realization see
[Bleher–Chinburg–Poonen–Symonds, §1.B and Proposition4.8](https://math.mit.edu/~poonen/papers/AutK.pdf).
Equation(1) is also Matignon–Rocher Lemma2.4(1), proved here directly.
The HKG curve is NOT an étale cover of an endpoint and inherits none
of its ordinarity assumptions. The retained275 exact polynomial checks
support, but do not replace, the audited all-degree proof.
