# Proof: preparation and the truncated logarithmic unit

[Statement](../../Theorems/deformations/cyclic_power_additive_norm.md).
Use its p,h,a,q,O,K,M and A=L Phi^-1.

## 1. Preparation over an arbitrary free coefficient module

Additivity on a group killed by p^(a+1) is O-linearity, and commuting
with e gives O[e]-linearity. Since K is free, divide the matrix
coefficients of A−e^h by p and choose a polynomial lift

    A=e^h I+p C(e),       C(e)=sum_(j=0)^(q−1)e^j C_j.

The coefficient operators C_j need not commute. Only e is central.
Extend A to K[[e]]. Its preparation quotient is freely

    S=K[[e]]/A K[[e]] ≅ ⊕_(i=0)^(h−1)e^iK.               (1)

For existence, split a series as r+e^h g, deg r<h, and replace its
high part modulo A by −p C(g). Repeating gains one p-adic digit each
time, so terminates after a+1 steps. For uniqueness, r=A g with
deg r<h reduces to r=e^h g modulo p, forcing r=g=0 there.
Divide both by p and repeat at lower precision. Freeness justifies
these divisions and also proves A injective on K[[e]]. The argument
works for infinite-rank K: every series coefficient is an element
of K and only finitely many p-adic divisions are used.

## 2. The group relation and norm on the preparation quotient

On S, e^hS⊂pS. The exact valuation

    v_p binom(p^a,j)=a−v_p(j),       1≤j≤p^a,

therefore gives

    F|S=p^a e U_h(e),       N|S=p^a U_h(e).               (2)

Indeed for j≥h+1, p>2h implies
floor((j−1)/h)≥v_p(j)+1; the corresponding F bound starts at j=h.
If v_p(j)=s≥1, use j≥p^s and p^s−1≥h(s+1); for s=0 the
thresholds suffice. All such terms vanish modulo p^(a+1).
For 1≤j≤h<p, the remaining coefficient divided by p^a is
(−1)^(j−1)/j modulo p, giving the stated truncated logarithm.

Since e is nilpotent on S, U_h has an inverse. Distinguished division
for F identifies K[[e]]/F K[[e]] with M. The operators A and F
commute, so coker(A|M)=S/FS. Equation(2) gives

    FS=p^a eS=⊕_(i=1)^(h−1)p^a e^iK.

This proves the normal form and norm class: every positive-degree
term of p^a U_h eta vanishes in that quotient.

## 3. The primitive kernel and soluble norm equations

If A y=0 in M, choose a polynomial representative of degree<q.
Then A y=F z for a series z. In S, p^a e U_h[z]=0. Reducing
coefficients modulo p, freeness of (1) implies
e U_h[zbar]=0 in (K/pK)[e]/e^h. Its kernel is the last coefficient
line, so the full series zbar is divisible by e^(h−1).
Reduction of A y=F z now gives e^h ybar=e^q zbar; hence
ybar∈e^(q−1)(K/pK).

Conversely take z=e^(h−1)b. In S, Fz=p^a e^h U_h b=0,
so Fz=A y for some series y. Its image in M lies in ker A and
reduces to e^(q−1)b. Thus every socle coefficient occurs, without
finite-dimensional Smith theory.

The norm class shows A y=Neta is soluble exactly when eta∈pK.
For eta=p eta_1, base-change (1)–(2) to O/(p^a), keeping q fixed.
The norm class there is zero. Choose A z=Neta_1 modulo p^a;
then y=pz is a full solution reducing to zero. All solutions differ
by ker A, giving precisely the socle reductions. Finally Phi
preserves that coefficient subspace, so the assertion also holds for L.

## 4. Exact carry of every partial solution

Choose degree-<q representatives of y and r. The partial equation
gives an exact series identity A y=p^a r+Neta+F t. In the free
module S, (2) yields

    p^a([r]+U_h[eta]+e U_h[t])=0.

The expression in parentheses is divisible by p. Reducing the
original identity gives

    e^h ybar=e^(q−1)C+e^q tbar,
    tbar=sum_(i=1)^h D_i e^(i−1).

Substitution in S/pS proves the exact carry in the statement.
Its last leading coefficient D_h drops out, and U_h is invertible,
so the carry vanishes exactly when C=D_1=...=D_(h−1)=0.

## 5. Evidence and scope

The [bounded general-order audit](../../Research/audits/GENERAL_CYCLIC_ORDER_AUDIT_2026_09_13.md)
checks (2), the terminal sign and the nonlinear degree estimates.
The [new diagnostic](../../scripts/deformations/cyclic/verify_general_cyclic_order.py) passes
148 exact additive/nonlinear partial equations in characteristics3,5,7,11,
through leading order5, with noncommuting coefficients, free repairs
and arbitrary terminal representatives. Its
[receipt](../../Research/computations/general_cyclic_order_checks.json)
records the tested ranges. These finite checks do not replace the proof.

The original [preparation audit](../../Research/audits/CYCLIC_POWER_ADDITIVE_PREPARATION_AUDIT_2026_09_10.md),
[second-order carry audit](../../Research/audits/CYCLIC_UNRESTRICTED_NORM_AUDIT_2026_09_13.md)
and [mixed-coefficient diagnostic](../../scripts/deformations/cyclic/verify_cyclic_power_additive_carry.py)
remain independent evidence for p=5,h=2. Nonlinear terms are handled
by the [absorption theorem](cyclic_power_nonlinear_absorption.md);
an actual Hodge comparison is an additional geometric input.
