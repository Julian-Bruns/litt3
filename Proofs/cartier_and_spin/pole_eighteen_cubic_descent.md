# Proof: an endpoint character obstruction closes cubic descent

[Statement](../../Theorems/cartier_and_spin/pole_eighteen_cubic_descent.md).
The complete human-readable received proof is
[REPORT](../../../litt3-computation-data/pole18_descent_reply_20260927/extracted/pole18_descent/REPORT.md).
Its established inputs are stated there explicitly. In Section7, the
otherwise implicit notation is U_i=H_i0/B_i6.

Write the actual minimal equations as
\[
F_i=Z^n+\sum_{r=0}^6B_{ir}(Z)X^r
 +Y\bigl(H_{i0}(Z)+XH_{i1}(Z)+X^2H_{i2}(Z)\bigr).
\]
At zero the norm is a degree-six polynomial supported on the four
A-roots. The leading coefficient B_i=B_i6 has precisely the common
infinity factors, with integer multiplicities.

The later [integer phase theorem](unbounded_modular_phase_balance.md)
applies because each root has equal sheet cardinalities m_alpha
and sum m_alpha=6. Every phase therefore agrees as an INTEGER
multiplicity across the three sheets on both legs. Each root has
at most one fivefold block, removed by the index-five norm
coefficient. Neither the old length-six sum enumeration nor a
separate absent-root/singleton argument is needed.

The endpoint differential equation has linearization eigenvalue two.
Equal phases therefore have the same two-jet on all three sheets,
giving H_is=O(t^3). The pole product of the actual branches gives the
growth bounds0,3,6 for H_i2/B_i,H_i1/B_i,H_i0/B_i respectively.
The first ratio has only simple poles; the missing second character
fixes its finite part. The established
[reciprocal lemma](reciprocal_finite_part_rigidity.md) kills it on both
legs. The next ratio has no poles, hence equals a_i t^3. Its endpoint
coefficient is a polynomial of degree at most one divisible by the
product of (x-alpha)^(m_alpha-1), of degree at least two. Thus it is
zero too, and H_i0=O(t^4).

If a residual H_i0 is nonzero, both legs are in index one. For a root
of multiplicity m and a phase of multiplicity r, actual contact
orders on the two legs give
\[
j_i=m+2r+5K,\qquad 8-e_{3-i}=2r+5L,
\]
where j_i=ord_0(H_i0/B_i), e_i is its growth degree, and K,L>=0.
The positive m have the same residue modulo five and sum six
over at most four occupied roots. Distinct such values would be
1 and6, whose sum already exceeds six; hence all m are equal.
Thus m divides six and m is2,3 or6. At each root the positive
phase multiplicities r likewise have one residue and sum m<=6,
so they are equal and divide m. Consequently
\[
d=m/r\in\{1,2,3,6\},\qquad r\not\equiv0\pmod5.
\]
This replaces the finite composition/partition list.

At a root alpha put x1=alpha+t z. The common sheet-independent
endpoint derivation is t partial_t+J(z,t) partial_z, with
\[
J(a+h,0)=2h+2h^2/a+O(h^3)
\]
at each nonzero slope a. Divide the three actual equations by t^m.
They have invariant leading part cD(z)^r, where D is the monic
polynomial of distinct slopes, and first character t^nu times a
nonzero constant at t=0. Thus its ratio is R=kappa/D^r and nu=2r mod5.
Regularity of the character of the logarithmic derivative forces
\[
\nu R+J(z,0)R'
\]
to be regular. When r=1 its constant term is also forced to vanish
by regularity of the second character -R(nu R+JR'). For every r this
gives B_a/A_a=r/a in the first two Laurent coefficients of R at a.
Equivalently
\[
\sum_{b\ne a}\frac1{a-b}=-\frac1a,
\qquad zD''+2D'=0.
\]
The leading coefficient is d(d+1), nonzero for d=1,2,3,6 in
characteristic five. This contradicts every remaining pattern without
assuming away the common-infinity resonance. Therefore all characters
vanish and the granted embedded-field criterion gives cubic descent.

On the quotient the four root multiplicities sum to six. Their
difference gcd divides six; when divisible by three its factor is
removed on passing from lambda=gamma^-1 to epsilon=gamma^3. The
proved full-fibre identity therefore gives epsilon^2 in
F_(5^8)^* mu29. A29th-root change of t removes the phase part, yielding
the stated sharper scalar bound. This is a scalar bound only.

The [original audit](../../Research/audits/POLE18_ONE_SHEET_2026_09_27.md)
checks actual reciprocal contacts and the r=1 second-character term.
The later phase theorem and divisibility argument replace the two
finite inputs. Original evidence remains in
[external provenance](../../../litt3-computation-data/archive_cleanup_20260930/older_phase_before_hindsight/).
