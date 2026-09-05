# Non-weakly ramified wild over-orbifolds do not occur

## Status

`proved-text`, using only the proved fiber/different bookkeeping and
at-most-one-wild-point result in file `11`, and the tame-character, tame
summation, and Swan-divisibility results in file `13`.

In particular, this proof does not use the invalid unrestricted assertion
that all lower breaks have one residue modulo `5`.  It also does not assume
that abstract ramification data are realizable: the necessary numerical
conditions themselves are contradictory.

## Proposition

Let `k=\bar F_5` and

`S=P^1_k(31,31,31)`.

There is no representable finite etale map

`f:S -> O`

to a smooth proper connected Deligne--Mumford curve with trivial generic
stabilizer for which a wild stabilizer has wild Sylow subgroup `P` satisfying
`P_2 != 1`.

## 1. The global master equation

Assume that such a map exists and let `d` be its generic degree.  File `11`
shows that there is at most one wild target point; call it `y_0`.  Write

`I_0=P semidirect C_T`,  `Q=|P|=5^q`,  `q>=1`,

and define the wild excess

`epsilon=sum_{j>=1}(|P_j|-1)`.

The local different is

`delta_0=QT-1+epsilon`.                     `(1)`

Because `P_2` is nontrivial,

`epsilon >= (Q-1)+(|P_2|-1) >= Q+3`.       `(2)`

File `13` gives

`T | epsilon`.                              `(3)`

We shall also use

`4 | epsilon`,                              `(4)`

which is immediate from the definition: every nonzero summand
`|P_j|-1` is of the form `5^e-1`.

Let the fiber above `y_0` contain `m` ordinary points and `n` of the three
order-`31` points of `S`, and set

`A=31m+n`.

If `y_1,...,y_r` are all the tame stacky target points, define similarly

`A_i=31m_i+n_i`,

and denote their inertia orders by `N_i>1`.  The fibers are nonempty, so all
these integers are positive.  Fiber degrees give

`31d=QT A=N_i A_i`,                         `(5)`

and

`n+sum_i n_i=3`.                            `(6)`

At the wild point, file `11` gives

`D_0-d=m(epsilon-1)+(n/31)(epsilon-31)`

`       =(A(epsilon-1)-30n)/31`.            `(7)`

At a tame point,

`D_i-d=-(m_i+n_i)`.                         `(8)`

Substitution in `D_0+sum_i D_i=2d-2`, followed by use of (5)--(6), gives

`sum_i A_i=A[QT(r-1)+epsilon-1]-28`.        `(9)`

## 2. There is exactly one tame stacky point

If `r>=2`, equation (5) and `N_i>=2` give

`A_i<=QT A/2`.

Summing and comparing with (9) yields

`A[QT(r/2-1)+epsilon-1]<=28`,

so in particular

`A(epsilon-1)<=28`.                         `(10)`

If `n=0`, then `A>=31`, contradicting (2) and (10).  If `n>0`,
representability injects an order-`31` stabilizer into `I_0`; hence `31|T`.
Equations (3) and (10) then contradict `31|epsilon`.  Thus `r<=1`.

If `r=0`, all three order-`31` source points lie over `y_0`, so
`A=31m+3`.  Equation (9) says

`A(epsilon-1-QT)=28`.

In particular `A|28`.  But a positive divisor of `28` cannot be congruent
to `3` modulo `31`: since `A<=28`, this would force `A=3`, and `3` does not
divide `28`.  Hence

`r=1`.                                      `(11)`

## 3. Coprime normalization

Let `N=N_1` and `B=A_1`.  Equations (5) and (9) become

`B=A(epsilon-1)-28`,                        `(12)`

`NB=QT A`.                                  `(13)`

Put

`g=gcd(A,B)=gcd(A,28)`,

`A=ga`,  `B=gb`,  `D=28/g`.

Then `D` belongs to

`{1,2,4,7,14,28}`,

`gcd(a,b)=gcd(a,D)=1`, and

`b=a(epsilon-1)-D`,                         `(14)`

`Nb=QT a`.                                  `(15)`

The two tame orders `N,T` are prime to `5`.  If `5|a`, coprimality would
give `5` not dividing `b`, contradicting (15).  Hence `5` does not divide
`a`, and comparison of 5-adic valuations in (15) gives

`b=Qc`,  `5` does not divide `c`.           `(16)`

Moreover `gcd(a,c)=1`, and cancellation in (15) gives `Nc=Ta`.  Therefore
there is a positive integer `t`, prime to `5`, such that

`T=ct`,  `N=at`.                            `(17)`

By (3), write

`epsilon=cR`,  `t|R`.                       `(18)`

Substitution of (16) and (18) in (14) gives the exact normalized system

`a+D=ch`,                                   `(19)`

`Q+h=aR`,                                   `(20)`

`epsilon=cR`,                               `(21)`

where `h=aR-Q` is a positive integer.

The source fibers also impose

`ga congruent n (mod 31)`,                  `(22)`

`gQc congruent 3-n (mod 31)`.               `(23)`

Reducing (12) modulo `31` gives the useful consequence

`n epsilon congruent 0 (mod 31)`.           `(24)`

Finally, (2) and (19)--(21) imply

`Q(c-a)>=2a-D`.                             `(25)`

Indeed, `a epsilon=c(Q+h)=cQ+a+D`, while
`a(epsilon-Q)>=3a`.

## 4. Elimination of `n=0` and of `h>=2`

Suppose first that `n=0`.  Equation (22) makes `a` a positive multiple of
`31`, so `a>D`.  The right hand side of (25) is positive, hence `c>a`.
But (19) would give `c<a` if `h>=2`; consequently `h=1`.  Equation (20) now
says `a|(Q+1)`, which is impossible because `31|a` whereas

`5^q mod 31` cycles through `5,25,1`

and is never `-1`.  Thus

`n>0`.                                      `(26)`

Now suppose `h>=2`.  If `a>=D`, equation (19) gives `c<=a`, while the right
side of (25) is positive, a contradiction.  Thus `a<D`.  The remaining
possibilities can be listed completely by using

- `D|28` and `g=28/D`;
- `gcd(a,D)=1` and `5` not dividing `a`;
- `n=ga mod 31` belongs to `{1,2,3}`;
- `h|(a+D)`, `h>=2`, and `c=(a+D)/h` is prime to `5`.

There are only the following four rows:

| `D` | `g` | `a` | `h` | `c` | `n` | contradiction |
|---:|---:|---:|---:|---:|---:|:---|
| 14 | 2 | 1 | 5 | 3 | 2 | `epsilon=3(Q+5)=2 mod 4` |
| 14 | 2 | 1 | 15 | 1 | 2 | (23) requires `2Q=1 mod 31` |
| 28 | 1 | 1 | 29 | 1 | 1 | `epsilon=Q+29=2 mod 4` |
| 28 | 1 | 3 | 31 | 1 | 3 | (23) requires `Q=0 mod 31` |

For completeness, the enumeration preceding the table is immediate:
`D=1,2,4,7` gives no admissible `a`; for `D=14` only `a=1` survives, and
the divisor `h=3` is excluded because it gives `c=5`; for `D=28`, only
`a=1,3` survive and `a+D` is respectively the prime `29` or `31`.
The cycle `Q=5,25,1 mod 31` also shows that neither congruence in the last
column can hold.  This proves

`h=1`.                                      `(27)`

## 5. The remaining global branch

Now `c=a+D` and `aR=Q+1`.  From (22),

`gc congruent n+28 congruent n-3 (mod 31)`.

Equation (23) therefore says

`(Q+1)(n-3)=0 mod 31`.

As `Q` is never `-1` modulo `31`, we get

`n=3`,  `31|c`.                             `(28)`

We have reached

`c=a+D`,  `R=(Q+1)/a`,

`epsilon=Q+1+DR`.

Put

`E=epsilon-(Q-1)=DR+2`.                     `(29)`

We claim

`E<Q-1`.                                    `(30)`

Otherwise, since `Q-1=aR-2`, equation (29) would give

`(a-D)R<=4`.                                `(31)`

If `a<=D`, the conditions `31|a+D` and `a+D<=56` force
`(D,a)=(28,3)`.  Then `R=(Q+1)/3`; its integrality forces `q` odd, and
`Q=5 mod 12`, so `R=2 mod 4`.  This contradicts
`4|epsilon=31R`.

If `a>D`, put `e=a-D`.  Equation (31) gives `1<=e<=4`, while
`31|a+D=2D+e`.  Checking the six divisors of `28` leaves only
`(D,e)=(14,3)`.  Then (31) forces `R=1`, so `Q+1=aR=17`, impossible.
This proves (30).

Let `b_1` be the first lower break of `P`.  If `b_1>=2`, then every one of
the `Q-1` nonidentity elements has break at least `2`, so
`epsilon>=2(Q-1)`, contrary to (30).  Hence

`b_1=1`.                                    `(32)`

Let

`s_1=dim_{F_5}(P/P_2)`.

Because `P_2` is nontrivial, `1<=s_1<q`.  At the first break, the tame
character lemma in file `13`, together with `c|T`, gives

`c | 5^{s_1}-1`.                            `(33)`

In particular, (28) and `ord_31(5)=3` give

`3|s_1`.                                    `(34)`

The Swan-divisibility theorem in file `13` gives

`L=5^{ceil(s_1/2)} | E`.                    `(35)`

Multiplying (29) by `a` and using `aR=Q+1` and `c=a+D`, we find

`aE=DQ+(2c-D)`.

Since `5` does not divide `a`, `L|E`, and `L|Q`, it follows that

`L | 2c-D`.                                 `(36)`

The following elementary lemma shows that (33)--(36) are impossible.

## 6. The local arithmetic lemma

### Lemma

There are no integers

`D in {1,2,4,7,14,28}`,  `c>D`,  `31|c`,  `s>=1`

such that, with `L=5^{ceil(s/2)}`,

`3|s`,  `c|(5^s-1)`,  `L|(2c-D)`.           `(37)`

### Proof: even `s`

Suppose first that `s` is even.  Then `s=6k` and, on putting

`L=5^{s/2}`, 

we have `L=1 mod 31` and `L>=125`.  Write

`2c=Lu+D`,                                  `(38)`

where `u` is a positive integer.  Since `c|(L^2-1)`, the integer `2c`
divides `2(L^2-1)`.  Reducing after multiplication by `u^2` and using
`Lu=-D mod 2c` gives

`2c | 2(D^2-u^2)`.                          `(39)`

Modulo `31`, equation (38) says `u+D congruent 0`.  If `u<=D`, then
`2<=u+D<=56`, so `u+D=31`.  The inequality leaves only `D=28,u=3` among
the six possible values of `D`; but then `Lu+D` is odd, contradicting
`2c=Lu+D`.  Hence `u>D`.

Put

`v=2(u^2-D^2)/(Lu+D)`.

This is a positive integer by (39).  Since `c<=L^2-1`, equation (38) gives
`u<2L`; consequently

`0<v<2u/L<4`.

Thus `v` is one of `1,2,3`, and

`2u^2-vLu-D(2D+v)=0`.

Its discriminant is a square `W^2`, with

`(W-vL)(W+vL)=8D(2D+v)`.

Both factors on the left are positive.  Therefore

`2vL<8D(2D+v)`,

so

`L<4D(2D+v)/v<=6384`.

The only power `L=5^{3k}` in this range is `L=125`; hence `s=6`.

### Proof: odd `s`

Suppose that `s` is odd.  Then `s=6k+3`; putting

`L=5^{(s+1)/2}`

gives `L=25 mod 31` and `L>=25`.  Again write `2c=Lu+D`.  Now

`c | (L^2-5)/5`.

Multiplying the resulting divisibility by `5u^2` and reducing modulo `2c`
gives

`2c | 2(D^2-5u^2)`.                        `(40)`

We have `5u^2>D^2`.  Equality is impossible for positive integers, since
`5` is not a square.  If the reverse strict inequality held, then
`0<u<D/sqrt(5)`.  Modulo `31`, equation `2c=Lu+D` gives
`6u-D congruent 0`.  But

`-31<6u-D<48<62`,

so this integer is `0` or `31`.  The first possibility would give `3|D`,
and the second would give `D=5 mod 6`; neither can hold for a divisor of
`28`.

Therefore

`v=2(5u^2-D^2)/(Lu+D)`

is a positive integer.  Since `c< L^2/5`, we have `u<2L/5`, and hence

`0<v<10u/L<4`.

Again `v` is one of `1,2,3`.  The equation

`10u^2-vLu-D(2D+v)=0`

has square discriminant `W^2`, and

`(W-vL)(W+vL)=40D(2D+v)`.

It follows that

`L<20D(2D+v)/v<=31920`.

The only powers `L=5^{3k+2}` in this range are `25` and `3125`, giving
`s=3` and `s=9`.

### The three residual values

It remains only to test `s=3,6,9`.  The complete divisor check is displayed
below.  In the fourth column, `c` runs through every divisor of `5^s-1`
which is divisible by `31`; the listed set is the complete set of residues
`2c mod L`.  The last column is the set of possible residues of `D`.

For a directly checkable enumeration, write `c=31e`.  The possible `e` are

- for `s=3`: `{1,2,4}`;
- for `s=6`:
  `{1,2,3,4,6,7,8,9,12,14,18,21,24,28,36,42,56,63,72,84,126,168,252,504}`;
- for `s=9`:
  `{1,2,4,19,38,76,829,1658,3316,15751,31502,63004}`.

Multiplication of these lists by `62`, followed by reduction modulo `L`,
gives exactly the fourth column.

| `s` | `L` | factorization of `5^s-1` | all `2c mod L` | all `D mod L` |
|---:|---:|:---|:---|:---|
| 3 | 25 | `2^2*31` | `{12,23,24}` | `{1,2,3,4,7,14}` |
| 6 | 125 | `2^3*3^2*7*31` | `{31,41,52,58,59,61,62,83,89,97,104,107,111,113,116,118,119,121,122,123,124}` | `{1,2,4,7,14,28}` |
| 9 | 3125 | `2^2*19*31*829` | `{62,124,248,1178,1398,1562,1587,2356,2467,2796,3123,3124}` | `{1,2,4,7,14,28}` |

The two sets in the last two columns are disjoint in every row.  Thus
`L` cannot divide `2c-D`, proving the lemma.

## 7. Conclusion

Apply the lemma with `s=s_1`.  Conditions (28), (33), (34), and (36) are
exactly its hypotheses, a contradiction.  Therefore the assumed non-weakly
ramified wild over-orbifold does not exist.

Together with file `16`, this supplies both wild exclusions left open in
file `11`.
