# Proof record: Translation rank detects fractional wild jumps

Canonical statement: [`translation_rank_bound`](../Theorems/Thm_translation_rank_bound.md).
Migrated 2026-09-06; hypotheses restated below are proof context.
The canonical statement and registry control promoted scope and evidence.

---

# Translation rank detects the fractional jumps with a prime-order second group

Author: /root, 2026-09-06. Status: independently audited PASS by
/root/integral_jump_degree_bound_audit, 2026-09-06; 275 separate exact
polynomial checks across 25 characteristic/degree pairs also passed.
[Audit record](../routes/global/audits/ARTIN_SCHREIER_TRANSLATION_RANK_AUDIT_2026_09_06.md).

## 1. A polynomial theorem

Let k be algebraically closed of characteristic p>0. Let f in k[x] have
degree B>1 prime to p, and put

    V_f={a in k: f(x+a)-f(x) belongs to (F-1)k[x]}.

Suppose V is a finite additive subgroup of V_f of order p^r>1.
Then B is congruent to one modulo p. Put Q=p^s, s=v_p(B-1). Exactly
the following degree-dependent bounds hold:

    B=Q+1:       |V|<=Q^2;
    B>Q+1:       |V|<=Q.                              (1)

Only necessary bounds are claimed; no sufficient conditions on f.

### Proof by a single coefficient

For a polynomial g, reduction modulo (F-1)k[x] replaces a term c x^(pj)
by c^(1/p) x^j and repeats until all positive exponents are prime to p.
Its positive-degree reduced coefficients are unique. The constant term
causes no obstruction over the algebraically closed field k.

If B is not congruent to one modulo p, the exponent B-1 is prime to p.
Its coefficient in f(x+a)-f(x) is B f_B a. No larger exponent in this
difference can reduce to B-1, and no lower term of f contributes to it.
Thus a=0 for every a in V_f, a contradiction.

Now B=1+uQ, where u is positive and prime to p. If u>1, set j=B-Q;
then j is prime to p and p j>B-1. Therefore the x^j coefficient of the
reduced difference is already its ordinary x^j coefficient. As a
polynomial in a, it has degree Q and leading coefficient

    f_B binom(B,Q)=u f_B !=0.

Terms of f of smaller degree contribute smaller powers of a. Every a
in V is a root, so |V|<=Q. This proves the second line of (1).

If u=1, take the coefficient of x in the reduced difference and raise
it to the Q-th power. Explicitly this is the polynomial in a

    P(a)=sum_(0<=j<=s) ([x^(p^j)](f(x+a)-f(x)))^(Q/p^j).

Its degree is exactly Q^2: the j=0 term has leading contribution
f_B^Q a^(Q^2), since B=Q+1=1 in k. Every j>=1 term has degree at most
(B-p^j)Q/p^j<Q^2, and the lower terms of f in the j=0 summand also
have smaller degree. Again all a in V are roots, so |V|<=Q^2.
This proves (1). QED.

## 2. Local application with |I_2|=p<|I_1|

Let I act faithfully on k[[z]], put P=I_1, and assume |I_2|=p<q=|P|.
Write q=p^(r+1). The positive lower jumps are 1 and B, and the last
nontrivial group has order p, hence B is prime to p.

Construct the HKG P-curve H for this local action. Then H/P is P1 and
the P-cover has just one, totally ramified point. The quotient H/P_2
is also P1. Here is the direct proof of the latter assertion, avoiding
any large-action hypothesis. For any subgroup N of P, subtract the
two Hurwitz formulas for H/P and H/N, using P_0=P_1=P, to obtain

    2|N| g(H/N)=sum_(i>=2)(|P_i|-|N intersect P_i|).

Taking N=P_2 makes the right side zero. Consequently H is an
Artin--Schreier curve w^p-w=f(x) over H/P_2=P1, with f a reduced
polynomial of degree B, and the quotient P/P_2 acts on the x-line
through translations by an F_p space V of dimension r.

The last ramification group P_2 is central in P. Indeed commutators
with an element of final break B have break greater than B. Thus a
lift of any translation a in V commutes with w->w+1 and must act
as w->w+h_a(x), with h_a in k(x). It follows that

    f(x+a)-f(x)=h_a(x)^p-h_a(x).

The function h_a has no finite pole, since the left side is polynomial
and a pole of h_a would give a pole of order p times as large on the
right. Therefore h_a is polynomial, and V is a subgroup of V_f.

There are now only two possibilities:

* B-1 is divisible by p^r. Both upper jumps of P are integers, namely
  1 and 1+(B-1)/p^r.
* B=p^s+1 for an integer s with s<r<=2s. Its second upper jump is
  1+p^(s-r), lying strictly between one and two.

To see exhaustiveness, use (1): if B>p^s+1 then r<=s, so p^r divides
B-1; if B=p^s+1 the bound is r<=2s, with r<=s again the integral case.

In particular any NONINTEGRAL case automatically has
q/g(H)>2p/(p-1), but this inequality is a consequence, not an assumption
or an input from a classification theorem.

## 3. Consequences for the current atlas theorem

The nonintegral case gives precisely the numerical data

    Q=p^s, R=p^(r-s), p<=R<=Q,
    q=p Q R, c=q+(p-1)Q-2,

used in Section 3 of
[the order-p-second-group degree bound](../routes/global/ORDER_P_SECOND_RAMIFICATION_GROUP_FORCES_A_DEGREE_BOUND.md).
Its elementary tame/genus arithmetic therefore applies unchanged.
The other case is covered by the checked integral-jump bound.

For h16,p5 this eliminates the apparent B=66 numerical pattern outright:
v_5(66-1)=1 and B>5+1 force the translation space to have order at most
5, whereas that pattern requires order25. The two remaining full
necessary tuples have B=6 and n=112000 or336000. They are still not
claimed to be globally realizable genus-nine atlases.

The polynomial theorem is independent of the atlas, chosen endpoints,
genus, or covering degree. The only external geometric input in Section 2
is HKG realization; compare
[Bleher--Chinburg--Poonen--Symonds, Section 1.B and Proposition 4.8](https://math.mit.edu/~poonen/papers/AutK.pdf).
The rationality calculation is also Matignon--Rocher Lemma 2.4(1), but
its full short proof is included above and no big-action classification
is required.
