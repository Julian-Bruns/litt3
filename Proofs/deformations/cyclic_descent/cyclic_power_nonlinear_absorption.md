# Proof: bounded binomial degree absorbs the nonlinear terms

[Statement](../../../Theorems/deformations/cyclic_descent/cyclic_power_nonlinear_absorption.md).
Use its p,h,a,q,O,M,A and equation(*). Put
B_i(s)=binom(s,i) and P_d=span_O(B_0,...,B_d).

## 1. Integral interpolation and degree preservation

The binomial evaluation matrix is unitriangular, so each P_d is a
direct summand of M and saturated for division by powers of p.
The exact cyclic wrap is

    eB_i=B_(i−1)−binom(q,i)B_(q−1),
    v_p binom(q,i)=a−v_p(i),       0<i<q.                (1)

Thus wraps on p^j P_d vanish modulo p^(a+1) when d<p^j.
At a precision where wraps vanish, successive finite differences
identify P_d with ker(e^(d+1)). Additive deck maps preserve these
submodules at that precision. The map (A−e^h)/p is canonically
additive and equivariant modulo p^a; this lower precision suffices
for every correction below. An equivariant lift follows from the
free regular-module coefficient argument in
[additive preparation](cyclic_power_additive_norm.md), Section1.

For a binomial function v of degree D at such a precision,

    sigma^s v=sum_(i=0)^D binom(s,i)e^i v.              (2)

Substitute (2) in a d-additive presentation of Q_d. Products of
integer binomial polynomials have integral binomial expansions, with
degrees adding. Equivariance of Q_d identifies the result with
sigma^s Q_d(v). Evaluate at the zero sheet to obtain the same degree
bound for the actual function Q_d(v). Individual additive factors
need not be equivariant, and no polarization denominator is used.

For v=sum_j p^j v_j, a term with indices j_1,...,j_d has valuation
at least sum j_i and degree at most sum deg(v_(j_i)). Apply the
argument at each required quotient precision. Coefficient Frobenius
fixes integer binomial values, so it does not multiply these degrees
by p. The estimate concerns the combined coordinate v.

## 2. Two filtered image inclusions

For the divisible-norm case m=1, define

    F_1=sum_(j=1)^a p^j P_((2h−1)j−1),
    E_1=sum_(j=1)^a p^j P_((2h−1)j+h−1).

For m≥2 define

    F_m=sum_(j=m)^a p^j P_(hj+2h−hm),
    E_m=sum_(j=m)^a p^j P_(hj+3h−hm).

Then

    F_1⊂A(E_1),       F_m⊂A(E_m).                      (3)

Let I_h(B_i)=B_(i+h). Its displayed output degrees are<p^j:
for E_1 use (2h−1)j+h−1≤(3h−2)j<p^j; for E_m, j≥m≥2
gives hj+3h−hm≤h(j+1)≤2hj<p^j. These follow from the stated
prime bounds. Equation(1) therefore gives e^h I_h f=f at the
weighted precision.

Write A=e^h+pT. Its correction sends E_1 into F_1 and E_m into
F_m: the integration degree at weight j is no greater than the
error degree at weight j+1. Degree preservation in Section1 applies
before multiplication by p. Starting with I_h f, subtract
I_h(pT I_h f) and iterate. Each correction gains a p-adic digit,
so the process terminates and stays in E. The chosen preimages
are divisible by p, or by p^m in the later case.

## 3. A divisible norm at the first nonlinear weight

Let m=1 and eta∈pO. Every partial solution modulo p^a satisfies

    y modp^a ∈ sum_(j=0)^(a−1) p^j P_((2h−1)j+h−1).    (4)

Modulo p its degree is at most h−1 because e^h y0=0.
Suppose earlier digits have degrees D_i=(2h−1)i+h−1.
A nonlinear term contributing at weight j satisfies
(d−1)+sum i_l≤j and hence has degree at most

    (2h−1)j+2h−1−hd ≤ (2h−1)j−1.

The additive correction has degree at most (2h−1)j−h, and norm
digits are constant. Saturation permits division of the combined
residual; h-fold integration gives the next degree D_j.
The initial wraps first occur at weight a, since h−1<p, and all
positive-weight wraps vanish by D_i<p^i. Thus every earlier repair
exists. Its arbitrary freedom is ker e^h=P_(h−1), already within
the bound, so the induction covers every partial solution.

By Section1 the full nonlinear error lies in F_1, as does Neta.
The unknown terminal digit cannot enter that error because every
nonlinear weight is positive. By (3), subtract z∈E_1⊂pM with
A z equal to the norm plus nonlinear error. This preserves y0 and
converts any partial equation to A(y−z)=p^a r. The exact additive
carry is therefore

    [r modp]=−U_h(e)sum_(i=1)^(h−1)D_i e^i.

A terminal digit contributes im e^h. Since U_h is a unit, it can
kill this residual exactly when D_1=...=D_(h−1)=0. This proves
the first-weight assertion, including a=1.

## 4. An arbitrary norm at later nonlinear weights

Let m≥2. The leading equation e^h y0=N C gives binomial degree
at most h. The analogous induction gives

    y modp^a ∈ sum_(j=0)^(a−1)p^j P_(hj+h).             (5)

At weight j, m(d−1)+sum i_l≤j implies nonlinear degree at most

    hj+hm+hd(1−m) ≤ hj+2h−hm ≤ hj.

The additive correction has degree at most hj; norm digits are
constant. Integration gives hj+h. Positive-weight wraps vanish
because hi+h<p^i for i≥1, and initial wraps again first occur at
weight a. The same free-repair argument establishes both existence
and the bound for every partial solution.

Substituting (5) places the whole nonlinear error in F_m. It does
not involve the terminal digit. Absorb it as A z with z∈E_m⊂p^mM,
leaving A(y−z)−Neta=p^a r and the same leading coefficients.
Additive preparation gives the full class

    −U_h(e)(C+sum_(i=1)^(h−1)D_i e^i).

It vanishes exactly under the condition in the statement; a terminal
digit then removes the remaining image component. Every socle
leading value occurs. If m>a the nonlinear sum is empty, and if
a=1 there are no intervening repairs, so both boundaries are covered.

## 5. Evidence

The [general-order audit](../../../Research/audits/GENERAL_CYCLIC_ORDER_AUDIT_2026_09_13.md)
checks the new degree budgets and logarithmic carry. The
[exact diagnostic](../../../scripts/deformations/cyclic/verify_general_cyclic_order.py) passes
148 additive/nonlinear partial equations in characteristics3,5,7,11,
through leading order5, with free repairs and terminal representatives.
Its [receipt](../../../Research/computations/general_cyclic_order_checks.json)
records the bounds actually tested.

The original [absorption audit](../../../Research/audits/CYCLIC_POWER_NONLINEAR_ABSORPTION_AUDIT_2026_09_10.md),
[carry audit](../../../Research/audits/CYCLIC_UNRESTRICTED_NORM_AUDIT_2026_09_13.md)
and [binomial diagnostic](../../../scripts/deformations/verify_uniform_binomial_absorption.py)
retain the independent second-order checks, including degree-five
nonlinear terms without factorial division. No geometric comparison
is identified by these algebra tests.
