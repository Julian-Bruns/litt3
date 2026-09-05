# Weakly ramified wild over-orbifolds do not occur

## Status

`proved-text`, conditional only on the already proved fiber/different
bookkeeping in file `11` and the weak local ramification statement in file
`13`.

This file proves `PROP-WEAK-WILD-EXCLUSION` from
[`11_PROOF_OVER_ORBIFOLD_CLASSIFICATION.md`](11_PROOF_OVER_ORBIFOLD_CLASSIFICATION.md).
It does not edit the older file, whose status was correctly left open when
the calculation below was absent.

## Proposition

Let

`S = P^1_k(31,31,31)`, with `k = \bar F_5`.

There is no representable finite etale map

`f : S -> O`

to a smooth proper connected Deligne--Mumford curve with trivial generic
stabilizer for which a wild stabilizer has wild Sylow subgroup `P` satisfying
`P_2=1`.

No realizability assumption about abstract permutation data or finite local
groups is used: the necessary degree and different equations already have no
solutions.

## Notation and local input

Assume such a map exists, and write its generic degree as `d`.  File `11`
shows that there is at most one wild point of `O`; call it `y_0`.  Write its
inertia group as

`I_0 = P semidirect C_T`,  `Q=|P|=5^q`,  `q>=1`,

where `T` is prime to `5`.  Weak ramification and file `13` give

`delta_0 = QT+Q-2`,                         `(1)`

`T | Q-1`.                                  `(2)`

Let `m` be the number of ordinary points of `S` over `y_0`, and let `n` be
the number of the three order-`31` points of `S` over `y_0`.  Put

`A=31m+n`.

The fiber is nonempty, so `A>0`, and fiber-degree bookkeeping gives

`31d=QT A`.                                 `(3)`

Let `y_1,...,y_r` be all the tame stacky points of `O`.  Their inertia orders
are denoted `N_i>1`.  If their fibers contain `m_i` ordinary points and `n_i`
order-`31` points, put

`A_i=31m_i+n_i`.

Then

`N_i A_i=31d=QT A`,                         `(4)`

and, because every order-`31` point upstairs lies over a stacky point,

`n+sum_i n_i=3`.                            `(5)`

## Step 1: the master Riemann--Hurwitz equation

At the wild point, equations (1) and the formulas in file `11` give

`D_0-d = m(Q-2)+(n/31)(Q-32)`

`        = (A(Q-2)-30n)/31`.                `(6)`

At a tame point `y_i`, where `delta_i=N_i-1`, the same formulas give

`D_i-d=-(m_i+n_i)`.                         `(7)`

Substitute (6) and (7) in

`D_0+sum_i D_i=2d-2`.

Using (3), (5), and

`31(m_i+n_i)=A_i+30n_i`,

one obtains the integer identity

`sum_i A_i=A[QT(r-1)+Q-2]-28`.              `(8)`

This is the missing canonical equation in the earlier summary of the weak
case.

## Step 2: exactly one tame stacky point

There cannot be no tame stacky point: for `r=0`, the right hand side of (8)
is

`A[Q(1-T)-2]-28<0`,

whereas the left hand side is zero.

Suppose `r>=2`.  From (4) and `N_i>=2`,

`A_i=QT A/N_i <= QT A/2`.

Combining the sum of these inequalities with (8) gives

`A[QT(r/2-1)+Q-2] <= 28`,

and hence

`A(Q-2)<=28`.                               `(9)`

If `n=0`, then `m>=1` and `A=31m>=31`, contradicting (9), since `Q>=5`.

If `n>0`, representability injects an order-`31` source stabilizer into
`I_0`.  Its image in the tame quotient has order `31`, so `31|T`.  By (2),
`31|(Q-1)`.  Since

`ord_31(5)=3`,

we have `3|q`, hence `Q>=125`.  This again contradicts (9).  Therefore

`r=1`.                                      `(10)`

## Step 3: coprime reduction for the two fibers

Write `N=N_1` and `B=A_1`.  Equation (8) becomes

`B=A(Q-2)-28`,                              `(11)`

while (4) is

`NB=QT A`.                                  `(12)`

Set

`g=gcd(A,B)=gcd(A,28)`,

`A=ga`,  `B=gb`,  `D=28/g`.

Thus `D` is a positive divisor of `28`, `gD=28`, and `gcd(a,b)=1`.
Equations (11)--(12) reduce to

`b=a(Q-2)-D`,                               `(13)`

`Nb=QT a`.                                  `(14)`

Both `N` and `T` are prime to `5`.  If `5|a`, coprimality would give
`5` not dividing `b`, contradicting (14).  Hence `5` does not divide `a`,
and comparison of 5-adic valuations in (14) gives

`b=Qc`

for a positive integer `c` prime to `5`.  Coprimality gives
`gcd(a,c)=1`; after cancelling `Q` in (14), it follows that

`c | T | Q-1`.                              `(15)`

Combining `b=Qc` with (13), and putting `h=a-c`, gives

`Qh=2a+D`.

In particular `h` is a positive integer, and

`2c=(Q-2)h-D`.                              `(16)`

Since `c|(Q-1)`, reduction of `Qh=2(c+h)+D` modulo `c` shows

`c | h+D`.

Thus `c<=h+D`.  Equation (16) now implies

`(Q-4)h <= 3D <=84`.                        `(17)`

Consequently `Q>=125` is impossible, because then the left hand side of
(17) is at least `121`.

## Step 4: the remaining powers `Q=5,25`

It remains to exclude `Q=5` and `Q=25`.  In either case `31` does not divide
`Q-1`.  Equations (2) and representability therefore show that `n=0`: an
order-`31` source stabilizer cannot lie over the wild point.  Hence

`A=31m`.

Because `g|28`, it follows that `a=A/g` is a positive multiple of `31`.
On the other hand, (13) with `b=Qc` says

`a=(Qc+D)/(Q-2)`.

By (15), `c<=Q-1`, and `D<=28`.  Therefore

- if `Q=5`, then `a<=(5*4+28)/3=16`;
- if `Q=25`, then `a<=(25*24+28)/23=628/23<28`.

Both bounds contradict the fact that `a` is a positive multiple of `31`.
This exhausts all powers `Q=5^q`, and proves the proposition.

## Audit notes

The only group-theoretic inputs beyond the bookkeeping of file `11` are the
weak local conclusions `(1)`--`(2)` from file `13`, cyclicity of the tame
local quotient, and injectivity of stabilizers under a representable map.
The proof does not assume that a formal branch-cycle description is
realizable.  An exhaustive integer search over the displayed equations was
used to locate the reduction, but the proof above does not depend on that
search or on an omitted table.
