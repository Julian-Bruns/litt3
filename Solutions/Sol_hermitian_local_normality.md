# Hermitian local normal forms with the target field retained

Author: /root, 2026-09-06. Major audit PASS,
/root/hermitian_fixed_base_major_audit, 2026-09-06.
[Audit record](../Research/audits/HERMITIAN_FIXED_BASE_MAJOR_AUDIT_2026_09_06.md).
[Statement](../Theorems/Thm_hermitian_local_normality.md).

## 1. The pointed HKG curve is forced

Realize the full I-action by an HKG curve (H,Q). Existence, and the fact
that restriction to its Sylow p-subgroup P is an HKG P-curve, are
[Bleher–Chinburg–Poonen–Symonds, Theorem 4.9 and Proposition 4.8](https://math.mit.edu/~poonen/papers/AutK.pdf),
printed p.9. Only existence is invoked, not an unproved uniqueness assertion
for HKG realizations. P acts freely away from Q, and

    different(P)=2(p^3-1)+p(p-1),    g(H)=p(p-1)/2.

The ramification subgroup N=I_2, of order p, is normal in I. Its different
is (p+2)(p-1), since its lower filtration is obtained by intersection with
I_i. Riemann-Hurwitz for H -> H/N gives

    p^2-p-2 = p(2g(H/N)-2)+(p+2)(p-1),

so H/N is rational. The N-cover is unramified away from Q. Its reduced
Artin-Schreier equation is y^p-y=f(x) with deg(f)=p+1, and x,y have their
only poles at Q, of orders p,p+1. These two pole orders generate a numerical
semigroup with p(p-1)/2 gaps, exactly the genus. In particular

    L(pQ)=<1,x>,           L((p+1)Q)=<1,x,y>.

The same triangular-coordinate argument is used in
[Lehr–Matignon, Proposition 3.3, Case 1](https://arxiv.org/pdf/math/0307031),
printed p.4; its proof and the Artin-Schreier setup on p.3 were read.

Let tau generate the tame complement. Its action on H/N is faithful:
an element acting trivially there belongs to N and cannot belong to the
prime-to-p complement. After translating x, tau(x)=alpha x with alpha of
exact order t. The displayed bases give tau(y)=beta y+d x+e. Comparing
Artin-Schreier equations gives beta^p=beta, beta nonzero.

Since t is prime to p, split the tau-module L((p+1)Q) over L(pQ) and choose
y'=y+r_0 x+s_0 with tau(y')=beta y'. Its equation y'^p-y'=F(x) still has
degree p+1 (a degree-p term is allowed at this stage). Equivariance yields
F(alpha x)=beta F(x). The leading term forces beta=alpha^(p+1).
As t>p+1, no other exponent from 0 through p+1 has this character.
Thus F(x)=a_0 x^(p+1). Scaling x,y' converts the equation to

    y^p+y=x^(p+1).

Also beta in F_p^* implies alpha^(p^2-1)=1, proving t|(p^2-1).

## 2. The action and quotient series are explicit

The same pole-space calculation shows every infinity-fixing automorphism
of this Hermitian model has the form

    x -> a x+b,     y -> a^(p+1)y+a b^p x+c,
    a^(p^2-1)=1, b^(p^2)=b, c^p+c=b^(p+1).             (1)

Indeed insert x -> a x+b, y -> d y+e x+c into the equation and compare
coefficients of y,x^(p+1),x^p,x,1. This forces d=a^(p+1) in F_p^*,
e=a b^p, b^(p^2)=b, and the constant equation in (1). Conversely direct
substitution verifies each displayed map. The a=1 subgroup has order p^3;
it is therefore the given P. The complement is already diagonal by Part 1.

The P-invariant u=x^(p^2)-x has its only pole of order p^3. Hence the
degree of H -> P^1_u is p^3 and k(H)^P=k(u). The complement sends u to
alpha u, so F_t=u^(-t) is a quotient uniformizer at the wild branch.

For completeness, z=x/y has order one at Q. For a=1,b!=0, the numerator
of sigma(z)-z is b y-b^p x^2-cx, of leading pole order 2p; the denominator
has pole order 2(p+1). Thus its valuation is 2. For b=0,c!=0 it is p+2.
The tame linear coefficient is a^(-p), so no nonidentity complement
element is tangent to the identity. This verifies the stated filtration.

Write w=1/x. The curve equation in z=x/y becomes

    w+z^(p-1) w^p=z^p,
    F_t=w^(p^2 t)/(1-w^(p^2-1))^t.                    (2)

The first equation has a unique formal solution w=z^p+O(z^(p+1)), by
coefficient recursion or its unit derivative with respect to w. It starts

    w=z^p(1-z^(p^2-1)+higher terms).

With E,A,B as in the statement, equation (2) gives

    F_t=z^E+t z^(E+A)+t z^(E+B)+O(z^(E+B+1)).        (3)

To check that no intervening terms were missed: numerator corrections
start at increment p^2(p^2-1)>B. In the denominator, the first term
w^(p^2-1) starts at A and its next term at A+(p^2-1)=B, with coefficient
one for each; its next possible terms exceed B. Its square starts at
2A>B for p>=3. This proves (3). In particular ord(F_t')=E+B-1=delta.

## 3. Removing target tails, but not its scalar

An arbitrary quotient uniformizer on the same local action has the form
h(F_t), with h(T)=aT+O(T^2), a nonzero. Source conjugacy accounts for
the initial identification of the given action with (1).
The [controlled determinacy lemma](Sol_finite_jet_local_normality.md)
absorbs the strictly tangent-to-identity target part: its error has order
at least 2E and 3E>2delta+2. For this inequality, write delta=E+B-1;
it reduces to E>2B, which follows from t>p+1 and p>=3. Consequently
the given fixed-base extension is represented by a F_t after a source
change. Scaling the target by a is not silently discarded.

Suppose f=a F_t(phi(z)), phi(z)=lambda z+O(z^2). Both exponents E and
E+A are divisible by p, and E is divisible by p^3. Formula (3) shows

    c_E=a lambda^E,
    c_(E+A)=a t lambda^(E+A),
    c_(E+B)=a t lambda^(E+B).                        (4)

The first term cannot contribute at E+A because its first possible
increment is p^3>A. The first two terms cannot contribute at E+B,
an exponent prime to p. They also cannot create terms strictly between
E and E+A. These facts justify (4) for an ARBITRARY source automorphism,
not just a diagonal one.

Since B-A=p^2-1 and Er=p^3(p^2-1), equation (4) gives

    c_E^r (c_(E+A)/c_(E+B))^(p^3)=a^r.              (5)

Thus the scalar invariant is independent of the source coordinate.
Necessity of (a/b)^r=1 for fixed-base isomorphism follows immediately.
For sufficiency use (1) with b=c=0: a diagonal a_1 in F_(p^2)^* sends
F_t to a_1^(-t)F_t. Its possible multipliers are exactly mu_r. Every
required scalar ratio is therefore induced by a source automorphism.

## 4. The short finite test

Nguyen's support-dependent determinacy formula, Definition 2.1 and
Proposition 2.8 of
[The right classification of univariate power series in positive characteristic](https://www.journalofsing.org/volume10/nguyen.pdf),
uses Q=delta+1, K=max ceil((Q-n)/(p^v_p(n)-1)) over supported n<Q,
and determinacy degree D=Q+K-1. Its upper-bound proof, p.241 Step 1,
uses source-coordinate changes only. For (3), the two values in the
maximum are ceil(B/(p^3-1))=2 and (B-A)/(p-1)=p+1. Thus K=p+1 and
D=delta+p+1. This use needs only the upper-bound part of that proposition.

Moreover a source change congruent to the identity modulo z^(p+2)
does not alter F_t modulo z^(D+1). For the three terms of (3), the
first possible increments are respectively p^3(p+1), p(p+1), and p+1.
Their resulting degrees all exceed D; terms of degree >Q cannot
contribute below D upon this change either, since their first increment
is at least p+1. It follows by factoring an arbitrary source automorphism
through its degree-(p+1) truncation that only b_1,...,b_(p+1) are needed.

An exact equivalence therefore implies the finite test. Conversely a
finite equality gives a series with the same D-jet as a right transform
of a F_t; determinacy corrects it to an exact equivalence. Multiplication
by a nonzero scalar and source automorphisms preserve the determinacy
bound. Finally (5) tests equality of the resulting fixed-base extension
classes at different points. This preserves precisely the local condition
needed by the actual-atlas theorem, without asserting any global atlas.
