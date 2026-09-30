# Proof: one binomial-degree filtration absorbs the nonlinear terms

[Statement](../../../Theorems/deformations/cyclic_descent/cyclic_power_nonlinear_absorption.md).
Use its p,h,a,q,O,K,M,A and equation(*). Put
B_i(s)=binom(s,i), and let P_D consist of K-valued functions of
binomial degree at most D. All degree and saturation arguments below
apply coefficientwise to the free O-module K.

## 1. Integral degree and the cyclic wrap

The binomial evaluation matrix is unitriangular, so P_D is a direct
summand and is saturated for division by p. The exact wrap is

    eB_i=B_(i−1)−binom(q,i)B_(q−1),
    v_p binom(q,i)=a−v_p(i), 0<i<q.                    (1)

Thus every wrap on p^j P_D vanishes in O when D<p^j. At that
precision, P_D=ker(e^(D+1)): forward differences recover the Newton
coefficients. Additive deck maps therefore preserve P_D. Writing
A=e^h+pT, the correction T is additive and equivariant modulo p^a;
this suffices wherever it is multiplied by p.

For a polynomial function v of degree D, translation gives

    sigma^s v=sum_(i=0)^D binom(s,i)e^i v.              (2)

Substitute this into a d-additive presentation of Q_d. Products of
integer binomial polynomials have integral binomial expansions with
additive degrees. Equivariance of the diagonal Q_d then shows that
Q_d(v) has degree at most dD. Its individual additive factors need
not be equivariant. For v=sum p^j v_j, each term has valuation at
least sum j_i and degree at most sum deg(v_(j_i)). No factorial
polarization is used. Coefficient Frobenius fixes integer binomial
values and therefore obeys the same bound.

## 2. A single degree schedule for every partial solution

Set

    b=h−1 if eta∈pK, and b=h otherwise,
    lambda=max(h,ceil((b+h)/m)),       d_j=lambda*j+b.

The hypotheses say exactly p>2h and p>lambda+b. Hence

    lambda≥h,  lambda*m≥b+h,  d_j<p^j for j≥1.         (3)

The leading equation e^h y0=N C has degree at most b. We claim every
partial solution modulo p^a has representatives

    y=sum_(j=0)^(a−1)p^j y_j,       y_j∈P_(d_j).       (4)

At weight j, a degree-d nonlinear term satisfies
m(d−1)+sum j_i≤j, so its degree is at most

    lambda*j+lambda*m+d(b−lambda*m)
       ≤lambda*j+b−h=d_j−h.                          (5)

The additive correction has degree at most d_(j−1)≤d_j−h, and norm
digits are constant. Saturation allows division of the combined
residual by p^j; h-fold binomial integration gives the next digit in
P_(d_j). Its free ambiguity P_(h−1) already fits. This proves (4)
and existence of every intermediate repair, for all leading values.

For precision in this induction, the initial degree b is below p,
so weight-zero wraps first occur at p^a, outside the equation modulo
p^a. Positive-weight wraps vanish in O by (1),(3). An initial wrap
inside pT or a nonlinear term acquires another p and also vanishes.
The initial e^h wrap at the terminal digit is retained for the exact
additive carry below.

## 3. Absorb the whole nonlinear error

Put

    F=sum_(j=m)^a p^j P_(d_j−h),
    E=sum_(j=m)^a p^j P_(d_j).

Then F⊂A(E). Indeed I_h(B_i)=B_(i+h) integrates e^h exactly on
these weighted spaces, since every weight is positive and d_j<p^j.
The correction pT carries the weight-j piece of E into the weight-
(j+1) piece of F, since d_j≤d_(j+1)−h. Consequently

    z=sum_(n=0)^a (−I_h pT)^n I_h f ∈E

is finite: each application of I_h pT gains a p-adic digit. Applying
e^h to z+I_h pTz=I_h f gives A z=f.

By (4),(5), the full nonlinear error belongs to F. It does not depend
on the terminal digit of y, since every nonlinear weight is positive.
Choose z∈E with A z equal to this error. Subtracting z preserves
all leading coefficients and the terminal residual, and turns the
partial equation into

    A(y−z)−Neta=p^a r.

The [additive norm theorem](cyclic_power_additive_norm.md) now gives

    [r modp]=−U_h(e)(C+sum_(i=1)^(h−1)D_i e^i),
    U_h(e)=sum_(i=0)^(h−1)(−1)^i e^i/(i+1).

The unit U_h makes this zero exactly when C=D_1=...=D_(h−1)=0.
A terminal digit then removes the remaining image component. Every
socle leading value occurs, and no free repair alters the obstruction.
If m>a there is no nonlinear error; if a=1 there are no intermediate
repairs. Both boundaries use the same argument.

## Evidence

The [bounded audit](../../../Research/audits/GENERAL_CYCLIC_ORDER_AUDIT_2026_09_13.md)
checks the wrap precision, degree induction and absorption, including
the new m=1 arbitrary-norm case p>3h. The
[unified checker](../../../scripts/deformations/cyclic/verify_general_cyclic_order.py)
passes252 exact additive/nonlinear cases in characteristics3,5,7,11,
with noncommuting coefficients, free repairs and arbitrary terminal
digits; [receipt](../../../Research/computations/general_cyclic_order_checks.json).
The original [absorption](../../../Research/audits/CYCLIC_POWER_NONLINEAR_ABSORPTION_AUDIT_2026_09_10.md)
and [carry](../../../Research/audits/CYCLIC_UNRESTRICTED_NORM_AUDIT_2026_09_13.md)
audits retain their stated scopes. These algebraic results require a
separate identification with an actual geometric comparison.
