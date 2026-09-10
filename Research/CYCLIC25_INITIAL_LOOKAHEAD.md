# Cyclic25: the first obstruction moves one digit later

2026-09-10. Historical input investigation, now resolved by
[cyclic_twentyfive_initial_descent](../Theorems/Thm_cyclic_twentyfive_initial_descent.md).
The initial calculation below was the tested basis of its Pro request;
statements marked unknown describe that pre-answer stage, not the
current frontier. The cyclic5 theorem v2,
including all reduced C10/D10/C2×D10 carriers, is now audited and
canonical. This note is author research toward a new C25 question,
not a claimed degree25 descent theorem.

## 1. An actual family, not an abstract group representation

Use the previous actual D10 family and the same open Delta(t)!=0:

    C:k(u,kappa,gamma), kappa²=u(u-3),
    gamma²=(u-1)(u-2)(u-t), E:gamma²=(u-1)(u-2)(u-t).

The elliptic curve E is ordinary. Replace its degree-five Verschiebung
cover E^(5)→E by its composite degree25 Verschiebung E^(25)→E, and
take T25=C×_E E^(25). The quadratic C/E is ramified and prime to25,
so T25 is connected. T25→C is ACTUAL cyclic25 etale, g(T25)=51.
The lift of [-1] supplies a reversing involution, so T25→Y is D50.
Its unique intermediate cyclic5 cover is the previous T5 of genus11.
The equations need not be replaced by an unrelated separable map.

The active connection, initial canonical marking, full preceding tuple
and actual flat periodicity twist are unchanged and pulled from Y.
The established cyclic-tower Fitting theorem applies because T5 has
defect2<5. With R=k[e]/e25 it gives a free rank-six module, a bijective
rank-five part and nilpotent rank one with multiplier e²u(e)Frob.
Hence T25 also has defect2, ker Psi=e23R and D=R/e². No new150x150
matrix enumeration is required. The reference full tower is obtained
by lifting the ORIGINAL covers to canonical ordinary Y.

## 2. A useful general multiplication rule

For any actual cyclic q=5^a torsor, let A be its sheaf of function
algebras on the base and e=σ-1. Set F_r=e^(q-1-r)A, 0<=r<q.
Then

    F_r*F_s ⊂ F_min(r+s,q-1).                            (1)

This can be checked after an etale trivialization of the torsor, where
A is the regular FUNCTION algebra on Z/q. Its binomial-function basis
B_j(i)=binomial(i,j) mod5, 0<=j<q, has e B_j=B_(j-1), including
the wrap at i=q-1 by Lucas/binomial divisibility. Thus F_r is spanned
by B_0,...,B_r. The integral binomial product identity has degree at
most r+s, with integral coefficients; reduction proves(1) when r+s<q.
For r+s>=q-1 the assertion is vacuous. Descent gives(1) on the actual
torsor and with coefficients in pulled-back bundles. No Leibniz rule
for e or logσ has been assumed.

In particular at q25,

    (e23 A)^2⊂e22 A⊂e² A,
    (e23 A)*(e³ A)⊂e² A,
    (e23 A)^3⊂e21 A⊂e² A.                              (2)

The first repairs have e23 support. Therefore ordinary initial
quadratics vanish by precisely the newly audited AS product mechanism.
If the next repairs can be retained in e³ at cochain level, (2) would
also kill ordinary next-digit cross terms and cubics. The required
actual higher filtered/graded precision must still be checked.

## 3. The first two integral carries

In W3(k)[e]/((1+e)^25-1),

    e25/5 mod5 = -e5-2e10-2e15-e20.                      (3)

Thus the first divided linear carry of e23,e24 has zero image in
R/e². Combined with the ordinary quadratic cancellation above and
the same actual initial filtered/graded comparison, all compatible
T3=T3^0+d e23+b e24 have a compatible W4 extension. This is a
corollary of the audited local mechanism with the different integral
relation, not a new formula for the NEXT obstruction.

The existing relative comparison between compatible W4 lifts uses
only the common descended W2 tuple. Their free top-digit difference
is in e23R, so its divided carry again has zero image in D. Hence the
next class epsilon(T4) is independent of which compatible W4 extension
of this T3 is used. Denote it by Theta_t(d,b). This is the genuinely
new quantity: whether it vanishes only on d=0 is UNPROVED.

For pure multiplier A=e²+5B+25C, the separately audited Smith lemma
shows that the TWO-digit reduced carry has coordinates(-c,-2c-d),
independent of B,C and free higher digits. At c=0 this suggests a
nonzero d channel. The actual comparison can contain mixed additive
Frobenius terms and Hodge carries, so the Smith lemma alone does not
evaluate Theta_t or decide its roots.

There is a useful colon bound in a free integral deck module M:

    ((e23 M ∩5M)/5) mod5 ⊂ e5(M/5M).                    (4)

Indeed e23 x divisible by5 gives x mod5 in(e²); write x=e²y+5z,
then use(3). This shows why the first divided carry followed by an
inverse e² comparison can require e³, rather than retaining e23.
It does not justify moving arbitrary division through augmentation.

## 4. Tested new leverage and remaining task

verify_cyclic25_function_filtration.py checks all625 binomial-basis
products and the integral first carry. The earlier all-a Smith theorem
has a fresh algebra-only audit. These are local algebra proofs/tests,
not a150-dimensional higher obstruction computation.

A good next Pro target is the ACTUAL initial two-step obstruction
Theta_t(d,b), including its coefficient Frobenius and mixed carries.
A proof that only d=0 survives would recover the given T3→C3 from
an extra W5 digit; nonzero surviving d would give actual delayed
descent failures and identify a different further test. Either is
more informative than recomputing the already zero W4 obstruction.
Neither by itself is a full compatible-tower/common-cover verdict.

Before declaring a prompt ready, check the geometric use of the
cochain e³ bound and the stated independence of the free W4 digit.
Do not pass the pure multiplier Smith theorem off as a theorem about
all mixed coefficient-semilinear operators.
