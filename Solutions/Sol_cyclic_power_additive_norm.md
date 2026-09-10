# Cyclic-power norm obstruction for mixed additive operators

Version1, 2026-09-10. Independently audited PASS by
/root/audit_cyclic_additive_preparation (medium effort). Pure integral
linear algebra, not a higher inverse-Cartier comparison. This strengthens
the independently audited [scalar argument](../Research/CYCLIC_POWER_SMITH_LEMMA.md)
by allowing coefficient Frobenius and arbitrary additive deck-equivariant
corrections. [Statement](../Theorems/Thm_cyclic_power_additive_norm.md) ·
[Audit](../Research/audits/CYCLIC_POWER_ADDITIVE_PREPARATION_AUDIT_2026_09_10.md).

## Statement

Let p=5,a>=1,q=p^a,O=Z/p^(a+1), and let K be a FREE O-module,
possibly of infinite rank. Put

    F=(1+e)^q-1, N=F/e,
    M=K[e]/F K[e].

Let Phi be an O-linear automorphism of K, acting coefficientwise on M.
Let L:M→M be an ADDITIVE map commuting with sigma=1+e, whose reduction
modulo p is e² Phi. Then the following conclusions hold.

1. For each eta in K, the equation L(x)=N eta has a solution iff
   eta belongs to pK.
2. Whenever it is soluble, the reductions of ALL its solutions in
   M/pM are exactly e^(q-1)(K/pK).

More explicitly, composing on the domain by Phi^-1 gives A=e²I+pC(e)
with O-linear coefficient operators. There is a natural coefficient
normal form

    coker(A) ≅ K ⊕ e(K/p^a K), [N eta]=(p^a eta,0).       (1)

For finite rank f, A has f(q-2) unit Smith factors, f factors p^a,
and f zero factors over O. For infinite rank the conclusions above
do not rely on dimension or cardinality counting.

Application to coefficient fields: W_(a+1)(k) for a perfect field k
is a free Z/p^(a+1)-module (flat over this Artin principal ring).
Witt Frobenius is an additive automorphism. Hence the theorem allows
arbitrary sums of coefficient-linear and coefficient-Frobenius terms,
provided the FULL comparison operator being modeled is additive and
deck-equivariant. Nonlinear divided Hodge terms are still separate.

## 1. Reduction to a vector-valued distinguished operator

An additive map on a group killed by p^(a+1) is O-linear. Commutation
with sigma is equivalent to commutation with e. Thus A=L Phi^-1 is
O[e]-linear, with A mod p=e²I. Its difference from e²I takes values
in pM. Since K is free, divide the matrix coefficients by p to choose
an O[e]-linear C lifting that difference. A polynomial representative

    C(e)=sum_(j=0)^(q-1) e^j C_j, C_j in End_O(K)

extends A to K[[e]]. No commutativity among the C_j is required.
Commutation with the central variable e is all that is used.

## 2. Finite division in the power-series module

Let S=K[[e]]/A K[[e]]. Then

    S=K ⊕ eK as an O-module.                             (2)

For existence, write any series f=r+e²g with deg r<2. Modulo A,
replace e²g by -pC(g). Repeat on its high part. Each repetition gains
a factor p, so after a+1 steps the process terminates. This also works
for infinitely generated K: each formal coefficient is an actual
element of K, and the number of p-adic divisions is finite.

For uniqueness, if r=A g has deg r<2, reduce modulo p. The identity
r=e²g implies r mod p=g mod p=0. Divide both coefficient vectors by
p and repeat over O/(p^a), then lower precisions. Freeness of K
justifies each reduction. This proves uniqueness. The same induction
shows A is injective on K[[e]].

In S, e²S⊂pS and e^j S⊂p^floor(j/2)S. The exact binomial valuation
v_p binomial(p^a,j)=a-v_p(j), together with

    floor(j/2)>=v_p(j)+1 for j>=2,
    floor((j-1)/2)>=v_p(j)+1 for j>=3,

therefore gives

    F|S=p^a e, N|S=p^a(1+(q-1)e/2).                     (3)

These are equalities of operators on S. They do not require S to be
a ring or the coefficient operators C_j to commute.
For the second estimate, if r=v5(j)>=1 then j>=5^r and
(5^r-1)/2>=r+1; if r=0 the bound follows from j>=3.

The corresponding distinguished division for F gives
K[[e]]/F K[[e]]=M. Since A commutes with F, its cokernel on M is
S/F S. By(2)--(3), F S=p^a eK: the action on eK is zero because
p^a e²S=0. This proves(1), including the norm class.

## 3. Primitive kernel without finite-dimensional Smith theory

Suppose x in M lies in ker A. Choose a polynomial representative y.
There is z in K[[e]] with

    A y=F z.                                            (4)

In S write [z]=z0+e z1. Equation(3) and(4) imply p^a e z0=0
in the FREE module S. Hence z0 belongs to pK. Modulo p, the class of
z in S/pS lies in e(K/pK), and A mod p=e². It follows that the full
series z mod p is divisible by e. Reducing(4) now gives

    e² y=e^q z, hence y mod p in e^(q-1)(K/pK)[[e]].

Since y has degree<q, its reduction in M is in the claimed socle.

Conversely take b in K and set z=e b. In S, F z=p^a e² b=0.
Therefore F e b=A y for some series y. Its image in M lies in ker A,
and reduction of this equality gives y mod p=e^(q-1)b. Thus

    image(ker A→M/pM)=e^(q-1)(K/pK).                     (5)

This avoids the invalid inference that two infinite dimensions or
cardinalities distinguish one from two coefficient copies.

## 4. Norm equation and return to Phi

Equation(1) shows A y=N eta is soluble exactly when p^a eta=0, that
is eta in pK. If eta=p eta1, base-change(1) to O/(p^a), KEEPING
q fixed. The norm class is then zero. Choose z with A z=N eta1
modulo p^a; then y=pz solves the original equation and reduces to zero.
All other solutions differ by ker A, proving the exact reduction set
via(5). Finally y=Phi x preserves the subspace e^(q-1)(K/pK), so
the same assertion holds for L.

## Exact diagnostic

[verify_cyclic_power_additive_carry.py](../scripts/verify_cyclic_power_additive_carry.py)
uses only Python's standard library. It tests 1,337 exact samples with
q=5,25,125 and coefficient module (Z/5^(a+1))², representing the
unramified quadratic coefficient algebra with s²=2 and Frobenius
Phi(x,y)=(x,-y). Correction matrices need not commute with Phi or
one another. The test includes all 625 leading (c,d) pairs for each
of q=5,25, and varies the norm, operator and free repair digits.

Every early divided obstruction is zero; the final coordinates are
(-c,-2c-d), for already Frobenius-transported c,d. Completed norm
solutions reduce to the socle, and all recorded repair-support checks
pass. Runtime was 0.284 seconds. This is a bounded independent
diagnostic, not an exhaustive test of all coefficient operators and
not a computation of the geometric Hodge obstruction. The proof
above supplies the all-rank, all-a assertion.

## Geometric boundary

This permits mixed additive coefficient-Frobenius terms in the linear
norm test; it is stronger than a scalar W(k)-linear multiplier theorem.
It does not show that the actual several-digit Hodge comparison is an
additive operator of this form. Establishing that identification after
the corrected filtered/graded and Hodge-generator repairs remains
essential. No cyclic25 descent theorem is inferred from(1).
