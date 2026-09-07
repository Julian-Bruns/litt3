# Proof: Hermitian local rigidity with the target retained

[Statement and audit metadata](../Theorems/Thm_hermitian_local_normality.md).
Use its p,t,E,A,B,δ,r,D. The action is faithful, with |P|=p³,
|I_2|=⋯=|I_(p+1)|=p, I_(p+2)=1 and t>p+1 prime to p.

## 1. The pointed HKG curve and action are forced

Realize the full I-action by an HKG curve(H,Q). Its restriction to P
is HKG by [Bleher–Chinburg–Poonen–Symonds, Theorem4.9 and Proposition4.8](https://math.mit.edu/~poonen/papers/AutK.pdf),
p.9; only existence is used, not uniqueness of HKG realizations.
P acts freely away from Q. Its different2(p³−1)+p(p−1) gives
g(H)=p(p−1)/2. The normal subgroup N=I_2 has different(p+2)(p−1);
Hurwitz for H→H/N gives

    p²−p−2=p(2g(H/N)−2)+(p+2)(p−1),

so H/N=P¹. Its reduced Artin–Schreier equation is y^p−y=f(x),
deg f=p+1. The pole orders p,p+1 of x,y at Q generate a semigroup
with exactly g(H) gaps, hence

    L(pQ)=⟨1,x⟩,   L((p+1)Q)=⟨1,x,y⟩.                     (1)

This triangular-coordinate argument also appears in
[Lehr–Matignon, Proposition3.3, Case1, pp.3–4](https://arxiv.org/pdf/math/0307031).

The tame generator acts faithfully on H/N: a kernel element would
belong to N. Translate x so τ(x)=αx, α of exact order t.
By (1), τ(y)=βy+dx+e; the equation gives β∈F_p^*.
Split the prime-to-p τ-module in (1), replacing y by y′=y+r_0x+s_0
with τ(y′)=βy′. Its equation is y′^p−y′=F(x), deg F=p+1.
Equivariance gives F(αx)=βF(x), and the leading term forces
β=α^(p+1). Since t>p+1, no other exponent0,…,p+1 has that character.
Thus F=a_0x^(p+1), and scaling converts the curve to

    y^p+y=x^(p+1),   t|(p²−1).

Inserting the possible pole-space transformations into this equation
shows that every infinity-fixing automorphism is precisely

    x↦ax+b,  y↦a^(p+1)y+ab^p x+c,
    a^(p²−1)=1, b^(p²)=b, c^p+c=b^(p+1).                   (2)

The a=1 subgroup has order p³, hence is P; the complement is diagonal.
The P-invariant u=x^(p²)−x has pole order p³, so k(H)^P=k(u).
The complement sends u↦αu; hence F_t=u^(-t) is a quotient uniformizer.

For z=x/y, an element with a=1,b≠0 has
σ(z)−z numerator by−b^p x²−cx of pole order2p and denominator
of pole order2(p+1), giving valuation2. If b=0,c≠0 the valuation
is p+2; a tame element has linear coefficient a^(-p).
Thus (2) verifies exactly the asserted filtration.

## 2. Quotient coefficients and the fixed-base scalar

Put w=1/x. The curve equation and quotient series become

    w+z^(p−1)w^p=z^p,
    F_t=w^(p²t)/(1−w^(p²−1))^t.

The first equation has a unique solution
w=z^p(1−z^(p²−1)+higher terms). Consequently

    F_t=z^E+t z^(E+A)+t z^(E+B)+O(z^(E+B+1)).                (3)

There are no missing intermediate terms: numerator corrections start
at increment p²(p²−1)>B; the first denominator term has increments
A and B, both with coefficient1, and its square starts at2A>B.
Thus ord F_t′=E+B−1=δ.

Any quotient uniformizer for this action is h(F_t)=aF_t+O(F_t²).
The [controlled determinacy lemma](Sol_finite_jet_local_normality.md)
absorbs the target tail: its order≥2E and3E>2δ+2, equivalently E>2B,
which follows from t>p+1 and p≥3. The scalar a is not discarded.

For f=aF_t(φ(z)), φ=λz+O(z²), equation(3) gives

    c_E=aλ^E, c_(E+A)=atλ^(E+A), c_(E+B)=atλ^(E+B).           (4)

Indeed the first possible increment from z^E is p³>A.
The first two displayed exponents are divisible by p, so their
substitutions cannot contribute to E+B, which is prime to p.
They also create nothing strictly between E and E+A.
Since B−A=p²−1 and Er=p³(p²−1), (4) proves

    J(f)=c_E^r(c_(E+A)/c_(E+B))^(p³)=a^r.

Thus fixed-base isomorphism of aF_t,bF_t requires(a/b)^r=1.
Conversely, the diagonal elements in (2) multiply F_t by a_1^(-t);
as a_1 ranges through F_(p²)^*, these multipliers are exactly μ_r.
This proves sufficiency, with the target fixed.

## 3. The short jet test

[Nguyen, Definition2.1 and Proposition2.8](https://www.journalofsing.org/volume10/nguyen.pdf)
gives determinacy degree D=Q+K−1, where Q=δ+1 and
K=max ceil((Q−n)/(p^v_p(n)−1)) over supported n<Q.
For (3) the values are ceil(B/(p³−1))=2 and(B−A)/(p−1)=p+1.
Thus D=δ+p+1. Only the source-change upper bound from that proof
(p.241, Step1) is used.

Replacing a source automorphism by its degree-(p+1) truncation first
changes a supported monomial z^n in degree at least
n+p^v_p(n)(p+1). For the three terms in (3) the increments are
p³(p+1),p(p+1),p+1, all placing the change above D.
Every n>Q likewise changes only above D. Hence exact equivalence
implies the stated finite test using only b_1,…,b_(p+1).

Conversely the finite test matches the D-jet of a right transform of
aF_t, so determinacy corrects it to an exact equivalence.
Nonzero scalars and source automorphisms preserve the determinacy bound.
Finally equality of J aligns several resulting extensions over their
SAME target field. No global quotient or atlas is inferred merely from
the local test.
