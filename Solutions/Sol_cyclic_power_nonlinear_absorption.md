# Integral nonlinear absorption for every cyclic power

Version1,2026-09-10. Proved author algebra; fresh bounded audit PASS
by /root/audit_uniform_nonlinear_absorption, with the perfect-field
hypothesis explicit. Audited prose, not Lean. This is NOT an actual
higher inverse-Cartier comparison or common-cover theorem.
It extends the returned B125 absorption mechanism, and isolates the
geometric input still needed to use it at arbitrary Witt precision.

## Statement

Let k be a perfect field of characteristic5, p=5, a>=1, q=p^a,
O=W_(a+1)(k), and
M=Fun(Z/q,O), with sigma f(s)=f(s+1), e=sigma-1. Write
B_i(s)=binom(s,i), P_d=span_O(B_0,...,B_d). Let A:M→M be additive,
deck-equivariant, and A mod5=e². The coefficient Frobenius has already
been transported into the input. A may have noncommuting mixed
coefficient-linear and coefficient-Frobenius corrections.

For d>=2 let Q_d:M→M be deck-equivariant. Assume it is a finite sum
of diagonals of d-additive maps of the underlying Z/5^(a+1)-modules.
The individual d-additive presentations need NOT be deck-equivariant.
This includes integral homogeneous polynomial expressions of degree d
in arbitrary additive transforms, including coefficient Frobenius and
its inverse. No division by d! or polarization assertion is assumed.

1. If

       Ay=sum_(d=2)^(a+1) 5^(d-1) Q_d(y),                (I)

   then y mod5 lies in the invariant line kB_0. Equivalently, in the
   regular polynomial deck basis it lies in k e^(q-1).

2. For m>=2, if

       Ay=N eta+sum_(d=2)^(1+floor(a/m))
                         5^(m(d-1)) Q_d(y),             (II)

   then eta∈5O and y mod5 lies in kB_0. Here N eta means the
   constant function eta, identified with the group-ring norm of a
   cyclic basis coefficient. An empty sum is allowed.

Both statements concern actual solutions of the integral nonlinear
equation. They do not assert existence for every allowed leading
coefficient, an exact nonlinear obstruction scalar before elimination,
or a geometric realization of arbitrary Q_d.

## Proof

### 1. Binomial degree at the precise truncated level

The unitriangular binomial matrix identifies M with its coefficient
module. Therefore each P_d is a direct summand and is saturated for
division by powers of5. The exact cyclic wrap is

    eB_i=B_(i-1)-binom(q,i)B_(q-1),
    v5 binom(q,i)=a-v5(i), 0<i<q.                       (1)

If d<5^j, the wraps on 5^jP_d vanish modulo5^(a+1).
At a precision where the wraps vanish, P_d=ker(e^(d+1)):
successive finite differences give the binomial interpolation formula.
Consequently additive deck maps preserve these P_d at that precision.

The map (A-e²)/5 is canonically additive and deck-equivariant modulo
5^a. It is well defined on M/5^aM. All uses below need only this lower
precision. A deck-equivariant lift also exists by the regular-module
coefficient argument of cyclic_power_additive_norm, Section1.

### 2. Polynomial degree without dividing by a factorial

Even when d>=5, equivariance of Q_d ITSELF suffices for the degree
bound. The additive presentation need not be equivariant.

For a binomial function v of degree D with vanishing wraps,

    sigma^s v=sum_(i=0)^D binom(s,i)e^i v.              (2)

Substitute (2) into a d-additive presentation of Q_d. Products of
integer binomial polynomials have integral binomial expansions and
degrees add. Equivariance identifies the result with sigma^s Q_d(v).
Evaluating this vector-valued identity at the zero sheet proves the
same degree bound for Q_d(v) as an actual regular function.

More generally for v=sum_j 5^j v_j, deg(v_j)<=D_j, a term using
indices j_1,...,j_d has coefficient valuation at least sum j_i and
binomial degree at most sum D_(j_i). Apply the argument at each
required quotient precision, where the corresponding wraps vanish.
It does not assert separate equivariance of polarized cross terms.
Coefficient Frobenius fixes the integer binomial values, so it does
not multiply these degrees by5.

### 3. Two uniform absorption identities

For the initial equation define

    F_1=sum_(j=1)^a 5^j P_(3j-1),
    E_1=sum_(j=1)^a 5^j P_(3j+1).

For the later equation put

    F_m=sum_(j=m)^a 5^j P_(2j+4-2m),
    E_m=sum_(j=m)^a 5^j P_(2j+6-2m).

Then

    F_1⊂A(E_1),     F_m⊂A(E_m).                       (3)

Let I(B_i)=B_(i+2). Every displayed integration degree is <5^j:
3j+1<5^j for j>=1, and 2j+6-2m<=2j+2<5^j for j>=m>=2.
Thus (1) gives e²If=f exactly at these weighted precisions.

Write A=e²+5M at its needed lower precision. The correction 5M sends
E_1 to F_1 and E_m to F_m. Indeed an integration degree at weight j
is no larger than the error degree at weight j+1. Additive degree
preservation from Section1 applies before that multiplication by5.
Starting with If, subtract I(5M If) and iterate. Each step gains5;
the finite geometric correction stays in E and solves Az=f.
Every preimage in (3) constructed this way is divisible by5; in the
later case it is divisible by5^m.

### 4. Combined repairs for (I)

An actual solution of(I) satisfies

    y mod5^a ∈ sum_(j=0)^(a-1) 5^j P_(3j+1).          (4)

Modulo5 the equation gives y∈ker e²=P_1. Suppose the digits before
j are represented by polynomials of degrees 3i+1. For a nonlinear
term at weight j, d-1+sum i_l<=j, so its degree is at most

    sum(3i_l+1) <= 3j-2d+3 <= 3j-1.

The linear correction has degree at most 3(j-1)+1=3j-2. The known
residual, divided inside the saturated polynomial submodule, therefore
gives e² y_j∈P_(3j-1), so y_j∈P_(3j+1). This proves (4).
All wraps used in this induction vanish: the known digit i has
degree 3i+1<5^(i+1), and the induction stops modulo5^a, before the
final degree-one cyclic carry.

Using(4) in the whole right side of(I), Section2 gives membership in
F_1. Terms involving the unknown 5^a digit vanish because nonlinear
weights start with5. Absorb it as Az with z∈E_1⊂5M. Then
A(y-z)=0 with unchanged reduction. The established integral norm
theorem gives reduction k e^(q-1), proving(I).

### 5. Combined repairs for (II)

The leading norm is a constant function, so e² y_0 is constant and
y_0∈P_2. The analogous induction gives

    y mod5^(a+1-m) ∈ sum_(j=0)^(a-m)5^j P_(2j+2).      (5)

At weight j, a nonlinear term obeys m(d-1)+sum i_l<=j; its degree
is at most

    2sum i_l+2d <=2j+2m+d(2-2m)
                         <=2j+4-2m <=2j.

The linear correction has degree at most2j. Norm digits have degree0.
Double integration therefore gives degree2j+2 for the next input
digit. When a<m there is no nonlinear term and no bound(5) is needed.
The same wrap and saturation argument justifies division at each step.

Substitute(5) into the complete nonlinear contribution: it belongs
to F_m. Absorb it as Az with z∈E_m⊂5^mM. The resulting equation
A(y-z)=N eta has unchanged reduction. The established norm theorem
forces eta∈5 and reduction in k e^(q-1), proving(II).

## What this would give geometrically

If the ACTUAL early comparison for cyclic q=5^a has equation(I) at
n2 and equation(II) with m=n-1 at subsequent stages, this algebra
recovers the given next lower digit at EVERY stage. The already proved
late theorem would then only be a special range of the same mechanism.
That uniform geometric comparison is not an input fabricated here.
At degrees>=5 one must justify integral homogeneous presentations and
their valuations directly; division by d! is not available.

The returned B125 finite-chart proof has separately passed its finite
geometric audit, with the global-oper input/projection construction
made explicit. No all-order geometric comparison is established by
this algebra.

## Evidence and references

[Statement](../Theorems/Thm_cyclic_power_nonlinear_absorption.md) ·
[focused audit](../Research/audits/CYCLIC_POWER_NONLINEAR_ABSORPTION_AUDIT_2026_09_10.md).
The integral input is [cyclic_power_additive_norm](Sol_cyclic_power_additive_norm.md).

[verify_uniform_binomial_absorption.py](../scripts/verify_uniform_binomial_absorption.py)
checks actual regular functions at q5,25,125,625 over the unramified
quadratic coefficient rings. All240 coefficient-basis generators and
80 nonlinear examples pass, with mixed noncommuting Frobenius terms
and degree-five nonlinearities. It also checks166,650 weight budgets
through a100. Runtime1.295s, standard library only. These are bounded
algebraic tests, not exhaustive verification of all operators and not
a geometric higher-IC certificate.
