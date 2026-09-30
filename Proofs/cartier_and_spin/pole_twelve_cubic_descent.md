# Proof: pole twelve cubic descent

Canonical statement: [pole_twelve_cubic_descent](../../Theorems/cartier_and_spin/pole_twelve_cubic_descent.md).
The supplied data and prior hypotheses are recorded in the retained
[inputs](../../../litt3-computation-data/structural_norm_replies_20260924/extracted/comparison_delta12/INPUTS.md).
Archive-relative certificate and source filenames below refer to this
[retained evidence directory](../../../litt3-computation-data/structural_norm_replies_20260924/extracted/comparison_delta12/).
The new written implications were reviewed locally and the full exact
verifier replay passed on 24 September 2026; see the
[focused integration record](../../Research/audits/STRUCTURAL_NORM_REPLIES_2026_09_24.md).


## 0. Completion status and precise scope

**Status: substantial partial result, not a decision of existence.**

Under the supplied hypotheses in `INPUTS.md`, the entire index-one case
is excluded. Thus every actual comparison of pole degree 12, if one
exists, satisfies
\[
 H_1=H_2=0,\qquad [k(T):k(x_1,x_2)]=3.
\tag{0.1}
\]

This conclusion holds for all covering degrees allowed by the supplied
bounds, for arbitrary geometric scalar coefficients, and with repeated
endpoint labels retained. No Galois closure of the endpoint maps, no
automorphism of `T` in the index-one case, and no bounded field of
definition for the remaining coefficients are assumed.

The proof uses both **actual** maps. It transports the first nonzero
cubic-character coefficient between their two local plane models. This
forces a uniform positive norm multiplicity. All three resulting types
are then excluded by exact endpoint arithmetic, with confluent conditions
at repeated labels. The finite computations exhaust roots of explicitly
specified unity, rather than arbitrary field-valued model coefficients.

The remaining index-three quartic problem is **not excluded or realized**.
Section 9 gives a necessary-and-sufficient reconstruction formulation
preserving both embedded endpoint fields and everywhere-etaleness. It also
proves that the normal closure of the degree-12 **parameter map** has
order dividing `1944=3^4*24`, prime to 5. This is not a statement about
the normal closures of the endpoint maps.

**Important scope boundary.** The uniform norm-multiplicity restriction
below is obtained under `H!=0`, as part of a contradiction. It must not
be carried into the surviving `H=0` case. All 35 norm patterns, all
quartic local fiber types, and arbitrary `epsilon` remain in that case.

The geometric arguments below are written proofs, not proof-assistant
certificates. All finite arithmetic they use is reproduced by
`python3 -B src/verify.py`; the executed logs and exact certificates are
included.

## 1. Conventions, parameters, and the two polynomials

Use the exact coefficient convention and polynomials in `INPUTS.md` and
`data/input.json`. All divisions by integers in formulas are in
characteristic 5. Write `A_4` for the leading coefficient of `A`.

Normalize the comparison parameter as supplied:
\[
 t=z/c_0,\quad c_0^{29}=\kappa^{18},\quad
 \epsilon=\kappa^{-3}c_0^4,\quad
 \eta=\kappa^{-7}c_0^{16}.
\]

Then
\[
 \eta^3=\epsilon^{-17},\qquad
 A(x_2)=\epsilon^4t^{-13}A(x_1),\qquad
 \theta_2=\eta t^{16}\theta_1.
\tag{1.1}
\]

Cubing the differential ratio gives the second equation of (4) in the
question. That calculation holds in `k(T)` **without** assuming index 3.

Let
\[
 F_1(x_1,y_1,t)=F_{10}(x_1,t)+y_1H_1(t)=0
\]

be the monic minimal polynomial of `t` over `K_1`. For the other leg
use `w=t^{-1}`, whose poles lie above its infinity point, and write
\[
 F_2(U,Y,w)=F_{20}(U,w)+YH_2(w)=0,\qquad (U,Y)=(x_2,y_2).
\tag{1.2}
\]

Both polynomials have degree `n` in their last variable, and
`deg H_i<=n-10`. Their normalizations are not related by simply reversing
coefficients: the endpoint fields are different. We use the actual
minimal polynomial for each embedding separately.

To obtain a contradiction assume index 1. By the supplied polynomial
criterion, **both** `H_1` and `H_2` are nonzero. Put
\[
 D=\deg H_1,\quad a=n-10-D,\quad
 h=\operatorname{ord}_{w=0}H_2,
\]

and let `a_D` and `j_h` be the nonzero leading coefficient of `H_1` and
initial coefficient of `H_2`, respectively. Also write
\[
 \mathcal B(U)=F_{20}(U,0)
       =c\prod_{\alpha:A(\alpha)=0}(U-\alpha)^{m_\alpha},
 \qquad \sum m_\alpha=4.
\tag{1.3}
\]

The scalar `c` may vary, and is nonzero. A different scalar convention,
such as writing `c A(U)` in the squarefree case, will be used when useful.

For a root with `m_alpha>0`, each of the three points `(alpha,Y)` of `X`
has precisely `m_alpha` zero branches of `w`. This follows from the
actual norm and etaleness. Every such branch is unramified under `w`,
and under the finite-coordinate map `U` at that point.

## 2. Exact finite endpoint facts

This section states all the finite arithmetic used in the proof.
Section 10 describes complete reproducibility and the certificates.

### Lemma 2.1: properties of mu_29 in characteristic 5

In `k`, the following hold.

1. Any at most four distinct elements of `mu_29` are linearly independent
   over `F25`.
2. For each `m=2,3,4`, two multisets of `m` elements of `mu_29` have the
   same sum only when the multisets are equal. Repetitions are allowed.
3. If `lambda_0,lambda_1,lambda_2` belong to one nonzero scalar multiple
   of `mu_29` and `lambda_j=A+B zeta^j`, where `zeta` is a primitive cube
   root, then all three `lambda_j` are equal.

**Exact verification and proof of geometric coverage.** Let
\[
 f_{14}(X)=1+2X+4X^2+4X^4+4X^5+3X^6+X^7+
 3X^8+4X^9+4X^{10}+4X^{12}+2X^{13}+X^{14}.
\]

The verifier proves its irreducibility over `F5` by the finite-field
irreducibility criterion, and verifies that its residue `xi` has order
29. Thus `F=F5[xi]` is `F_(5^14)` and contains **all** 29th roots of
unity in `k`.

For (1), every four-set can be multiplied by a root of unity so that
one exponent is zero. The verifier checks the 3276 sets
`{0,e1,e2,e3}`, `1<=e1<e2<e3<=28`. For each it records a nonzero
8-by-8 minor of the 14-by-8 matrix with columns
`xi^e, beta*xi^e`, in an `F5` basis. This proves independence over
`F25`. Smaller sets extend to four-sets. These are exhaustive finite
linear-algebra certificates, not sampling.

For (2), the full numbers of multisets checked are 435, 4495, and 35960.
Their exact sums are pairwise distinct within each size. Every sum and
its multiset are recorded. For (3), the affine relation implies
`lambda_0+zeta lambda_1+zeta^2 lambda_2=0`. Part (1), grouping equal
labels if necessary, forces all three labels equal. The verifier also
checks the 841 normalized ordered pairs directly. This proves the
statements for arbitrary geometric scalar multiples. QED.

### Lemma 2.2: the curve-dependent arithmetic

Let `alpha_j=alpha^(25^j)`, `0<=j<4`, where `alpha` is the residue in
\[
 E=\mathbf F_{25}[\alpha]/(\alpha^4+[7]\alpha^3+[6]\alpha^2
                                  +[2]\alpha+[5]).
\]

This polynomial is `A/A_4` and is irreducible. Thus `E=F_(5^8)` and
these are all four roots of `A`. Define
\[
 c_\alpha=\frac{3A'(\alpha)^3P(\alpha)^2}{A_4^3},\qquad
 b^0_\alpha=(c_\alpha)^{29^{-1}\bmod(5^8-1)},\qquad
 W_\alpha=P(\alpha)A'(\alpha)(b^0_\alpha)^{-14}.
\tag{2.1}
\]

The exponent is legitimate because `gcd(29,5^8-1)=1`.

The following exact facts hold:

- the four nonzero `c_alpha` are distinct;
- no nonempty subset of the four `W_alpha` has sum zero;
- for every two distinct roots, `b^0_alpha/b^0_beta` has degree 4 over
  `F25`, or equivalently is not fixed by the 625th-power map.

The field-code rows, in the base-25 encoding defined in
`data/reference_fields.json`, are

| Quantity | j=0 | j=1 | j=2 | j=3 |
|---|---:|---:|---:|---:|
| alpha_j | 25 | 145049 | 211895 | 211959 |
| c_alpha | 49582 | 18014 | 375108 | 111330 |
| b0_alpha | 356746 | 98060 | 384506 | 134116 |
| W_alpha | 370054 | 338804 | 224174 | 42772 |

`certificates/curve_checks.json` includes every nonempty subsum, all six
ratios and their 625th powers, and all intermediate `P(alpha),A'(alpha)`
values. The verifier checks these assertions from the input coefficients.

We will use the elementary finite-field consequence
\[
 E\cap F_{5^{14}}=F_{25},\qquad [E F_{5^{14}}:F_{5^{14}}]=4.
\tag{2.2}
\]

Indeed finite subfields of an algebraic closure are fixed fields of
powers of Frobenius; their intersection has degree `gcd(8,14)=2` over
`F5`. Consequently Lemma 2.1(1) stays true after extending its coefficient
field from `F25` to `E`. Also each ratio in the third assertion has degree
4 over `F_(5^14)`.

### Lemma 2.3: a confluent four-label exclusion

For any multiset `r_1,...,r_4` in `mu_29`, put
\[
 Q(V)=\prod_{i=1}^4(V-r_i),\qquad
 M(V)=\prod_{i=1}^4(V+r_i)(V^2+r_i^2).
\]

There is no `L in k^times` such that
\[
 Q(V)\mid M(V)-L V^{112}.
\tag{2.3}
\]

**Proof and exact verification.** Scalar multiplication of all roots by
one element of `mu_29` does not affect existence of `L`. It therefore
suffices to check the 4495 multisets `(0,e1,e2,e3)` with
`0<=e1<=e2<=e3<=28` in exponent notation.

At a distinct root `r`, the forced value of `L` is `M(r)/r^112`. The
verifier finds unequal forced values for every normalized multiset
except `(0,0,0,0)`. Each rejection has two exact unequal values recorded
in `certificates/confluent_m4_checks.csv`. Such a comparison excludes
arbitrary `L` in `k`, not merely coefficients in the finite field.

For `(0,0,0,0)`, `Q=(V-1)^4`. The ratio
`(V+1)^4(V^2+1)^4/V^112` has value 1 and first Taylor coefficient 4 at
`V=1`. It is not constant modulo `(V-1)^4`. The verifier retains the
Taylor condition, rather than replacing exponent 112 by 25 after merely
evaluating on `mu_29`. For any multiset surviving the point-value comparisons, it also checks
the higher jets required at its repeated roots. This proves (2.3), including multiplicities. QED.

## 3. Endpoint jets and cubic balance, without cubic descent

We first work on `T`, before assuming either field index.
At `w=0`, write `U=x_2` for the finite coordinate and `V=x_1` for the
pole coordinate. The exchanged identities give
\[
 V=\epsilon^{-1}(b w^{-3}+c_1w^{-2}+\cdots),\qquad
 U=\alpha+\lambda w+\mu w^2+\cdots.
\]

The first two jets are
\[
 b^{29}=c_\alpha,\quad
 \lambda=\frac{A_4b^4}{A'(\alpha)},\quad
 c_1=b\lambda\left(\frac{P'(\alpha)}{P(\alpha)}+
                         \frac{A''(\alpha)}{4A'(\alpha)}\right),
\tag{3.1}
\]
\[
 \mu=4\lambda c_1/b-\frac{A''(\alpha)}{2A'(\alpha)}\lambda^2.
\tag{3.2}
\]

For completeness, compare the coefficients of `w,w^2` in the `A`
identity. They give `lambda` and (3.2). The leading coefficient in the
cubed differential identity gives
`(2b/lambda)^3 P(alpha)^2=b^20`, hence `b^29=c_alpha`.
Its next coefficient gives
`mu/lambda=2c_1/b+2(P'/P)lambda`. Combining with (3.2) gives (3.1).
Terms of degree below 4 in `A(V)`, or below 10 in `P(V)`, begin at
relative order at least 3, so do not enter this calculation. This
calculation requires only the local identities and actual etale endpoint
branches, not a quartic quotient.

For fixed `alpha`, the possible `lambda` form one scalar multiple of
`mu_29`. Moreover `lambda` determines `b` uniquely: `b^4` and `b^29`
determine `b` since `29-7*4=1`. Thus it also determines `mu`.

### Proposition 3.3: balanced labels and initial divisibility

For a root `alpha` with `m=m_alpha>0`, the multiset of `m` leading
labels `lambda` is the same at each of its three points `(alpha,Y)`.
For any label of multiplicity `r`,
\[
 \operatorname{ord}_0 H_2\ \ge m+2r.
\tag{3.3}
\]

In particular `h>=m+2`.

**Proof.** Near each `(alpha,Y)` the local plane curve of `F_2` has
exactly `m` branches, each with `w` a uniformizer and
`U-alpha=lambda w+...`, with `lambda!=0`. Consequently its initial
order in `(U-alpha,w)` is `m`. Subtracting the equations at `Y` and
`zeta Y` shows first that `ord H_2>=m`.

Put `U=alpha+Sw` and divide by `w^m`. At `w=0` the polynomials in `S`
for the three values of `Y` have the same nonzero leading coefficient;
they differ only in their constant coefficient, which is affine in `Y`.
If `m>=2`, the sums of their `m` roots agree. Lemma 2.1(2), after
scaling, identifies their complete multisets. If `m=1`, the three roots
are affine functions of the three cube roots `Y`; Lemma 2.1(3) identifies
them. This proves the asserted balance.

For a common label `lambda` of multiplicity `r`, all three sets of
branches have the same second coefficient `mu`, by (3.1)-(3.2). Evaluate
their equations at
`U_*(w)=alpha+lambda w+mu w^2`. Locally, by the branch factorization,
`F_2(U,Y(U),w)` is a unit times the product of `U-U_j(w)`.
At `U_*`, the `r` chosen factors have order at least 3 and the other
`m-r` factors have order at least 1. Therefore the evaluation has order
at least `m+2r` for each of the three `Y` branches. Their difference is
`(zeta-1)Y(U_*)H_2(w)`, with the first factor a unit. This proves
(3.3). Repeated labels have not been discarded. QED.

## 4. Transporting the first nonzero cubic-character term

This is the central structural argument. The formal coordinate changes
in this section are **not** assertions that `T` already has a cubic
automorphism.

### 4.1 A local transport lemma

Let two pairs of equations in a two-variable complete local ring satisfy
`G=U f` and `G^sigma=V f^sigma`, where `U,V` are units. Suppose
`G_0=G^sigma_0`, `f_0=f^sigma_0`, so `U_0=V_0`, where subscript zero
means reduction modulo a parameter `w`. Suppose the first nonzero
`w`-coefficients of `G^sigma-G` and `f^sigma-f` occur at orders `a,b`,
and each of these coefficients is nonzero at the marked point of the
other variable. Then
\[
 a=b,\qquad [w^a](G^\sigma-G)\equiv
 U_0[w^a](f^\sigma-f)\pmod{f_0}.
\tag{4.1}
\]

**Proof.** Inductively compare coefficients below `min(a,b)` in
`G^sigma-G=(V-U)f+V(f^sigma-f)`. Since the power-series coefficient
ring is a domain and `f_0!=0`, the corresponding coefficients of `V-U`
vanish. If `a<b`, the coefficient at `a` would be divisible by `f_0`
but nonzero at its marked root, a contradiction. The same argument with
`b<a` gives the other contradiction. At equal orders reduce modulo
`f_0`. This proves (4.1), including its full multiplicity at the root.
This elementary mechanism is independent of the particular curve or
pole degree. QED.

### 4.2 The two actual plane models on a blown-up chart

At the first endpoint infinity use the exact uniformizer
\[
 q=x_1^3/y_1.
\]

Because `q^3=x_1^9/P(x_1)`,
\[
 x_1(q)=q^{-3}(1+O(q^3)),\quad
 y_1(q)=q^{-10}(1+O(q^3)),\quad
 \theta_1=2q^{16}(1+O(q^3))\,dq.
\tag{4.2}
\]

Both units here are power series in `q^3`. The cubic coordinate change
`q -> sigma q`, with `sigma=zeta^{-1}`, fixes `x_1` and multiplies
`y_1` by `zeta` exactly.

Blow up the endpoint by writing `q=wr`. For a label `b` at `alpha`,
let `r_0` be the corresponding leading value of `r`. Then
\[
 r_0^3=\epsilon/b.
\tag{4.3}
\]

The leading differential comparison gives
\[
 Y=J_\alpha r_0^{29},\qquad
 J_\alpha=\frac{2\eta\epsilon^{-4}P(\alpha)A'(\alpha)}{A_4}.
\tag{4.4}
\]

Indeed `lambda/Y^2=2 eta r_0^17`; combine `Y^3=P(alpha)` and
`lambda=A_4b^4/A'`. Formula (4.4) also verifies that replacing `r_0`
by `sigma r_0` replaces `Y` by `zeta Y`, since `sigma^29=zeta`.
Thus Proposition 3.3 gives full cubic triples of leading `r_0` values,
with their correct multiplicities.

For each `alpha` let `b_alpha,1,...,b_alpha,m_alpha` be its multiset of
labels, independent of `Y`. Define
\[
 C_\alpha(B)=\prod_j(B-\epsilon/b_{\alpha,j}),\qquad
 C(B)=\prod_\alpha C_\alpha(B).
\tag{4.5}
\]

The degree of `C` is 4. Its factors for distinct `alpha` have disjoint
roots, since the `c_alpha=b^29` are distinct (Lemma 2.2).

The regular strict-transform equation from the first leg is
\[
 G(r,w)=w^n F_1(x_1(wr),y_1(wr),w^{-1}).
\]

Regularity follows from the supplied pole bound on every coefficient.
Of the `n` local branches over `O`, precisely 12 have poles of `t`;
the others stay finite. The balanced pole labels therefore give
\[
 G(r,0)=r^{-12}C(r^3).
\tag{4.6}
\]

In particular this reduction is invariant under `r -> sigma r`.
The first nonzero term of the difference is
\[
 G(\sigma r,w)-G(r,w)
  =(\zeta-1)a_D r^{-10}w^a+\text{higher powers of }w,
 \quad a=n-10-D.
\tag{4.7}
\]

Now fix `alpha` and an actual leading root `r_0`. Solve the `A` identity
uniquely near `U=alpha`:
\[
 A(U_\alpha(r,w))=\epsilon^4 w^{13} A(x_1(wr)).
\tag{4.8}
\]

Since `A'(alpha)!=0`, this gives
\[
 U_\alpha=\alpha+w\ell_\alpha(r)+O(w^2),\qquad
 \ell_\alpha(r)=\frac{\epsilon^4 A_4}{A'(\alpha)}r^{-12}.
\tag{4.9}
\]

The coordinate change from `r` to `(U-alpha)/w` has nonzero derivative
at `r_0`: its leading derivative is `-12 lambda/r_0`. Thus it is an
isomorphism of these completed blown-up charts. Choose the analytic
cube root `Y(U)` with prescribed value `Y` at `alpha`, and set
\[
 f_{\alpha,Y}(r,w)=w^{-m_\alpha}
 F_2(U_\alpha(r,w),Y(U_\alpha(r,w)),w).
\tag{4.10}
\]

Let
\[
 g_\alpha=\left.\frac{\mathcal B(U)}{(U-\alpha)^{m_\alpha}}
                                      \right|_{U=\alpha},\qquad
 T_\alpha(S)=\prod_j\left(S-\frac{A_4b_{\alpha,j}^4}{A'(\alpha)}\right).
\]

Then
\[
 f_{\alpha,Y}(r,0)=g_\alpha T_\alpha(\ell_\alpha(r)),
\tag{4.11}
\]

and its first change on replacing `Y` by `zeta Y` is
\[
 (\zeta-1)j_hY w^{h-m_\alpha}.
\tag{4.12}
\]

### Why the equations differ by units

This is where actual maps and both original embeddings are essential.
`k(T)=K_1(t)=K_2(w)`, so both minimal plane equations normalize to the
same `T`, with exactly its actual branches. At a fixed label the map
(4.8)-(4.9) identifies those branches. The possible other fourth-root
choices for the leading pole coefficient are separated on this blown-up
chart; the chosen label `b^29=c_alpha` selects the actual one. The cubic
choice is selected by (4.4). Hence `G` and `f_alpha,Y` have the same
reduced formal branches, each with multiplicity one in their defining
equations. They differ by a unit. Repeated *leading labels* may give
tangent branches, but do not change this statement about the reduced
formal equations.

More explicitly, etaleness at `O` splits the first minimal polynomial
over `k((q))` into distinct factors `t-t_j(q)`. At a pole branch
`t_j(q)=a_j/q+O(1)`, the strict transform has the smooth equation
`1-w t_j(wr)=0`; its derivative in `r` at `(a_j,0)` is nonzero.
The other local factors are units. For the second minimal polynomial,
its `m_alpha` factors at `(alpha,Y)` give the distinct actual series
`U=U_j(w)`. The chart isomorphism (4.9) identifies each such factor
with one series `r=r_j(w)`. Its constant term is forced first by the
label `b`, then by (4.4). Conversely a first-leg branch at `r_0` has a
unique `alpha`, because the `c_alpha` are distinct, and has the specified
`Y` by (4.4). Thus the two products contain exactly the same smooth
factors, with none added or removed, even when some tangent directions
coincide. This gives the asserted unit equality in `k[[r-r_0,w]]`.

Similarly `G(sigma r,w)` corresponds to `f_alpha,zeta Y`: (4.8) is
unchanged under `r -> sigma r`, and (4.4) identifies the other cube root.
This supplies the second unit relation required in Lemma 4.1. No global
cubic action on `T` has been assumed.

### Proposition 4.3: uniform positive multiplicities and full congruence

Under `H_1,H_2!=0`, all positive `m_alpha` are the same number `m`.
Thus the only possibilities are
\[
 (1,1,1,1),\qquad (2,2,0,0),\qquad (4,0,0,0),
\tag{4.13}
\]

up to permutation. Moreover the following confluent congruence holds.
Define
\[
 M_\alpha(B)=\prod_j(B+s_{\alpha,j})(B^2+s_{\alpha,j}^2),\qquad
 s_{\alpha,j}=\epsilon/b_{\alpha,j},
\]
\[
 K_\alpha=(-1)^m\left(\frac{A_4}{A'(\alpha)}\right)^m
                              \prod_j b_{\alpha,j}^4,\qquad
 d_\alpha=\epsilon^{29}/c_\alpha,
\]

and `Lambda=j_h/a_D`. Then
\[
 \boxed{\quad
 g_\alpha K_\alpha M_\alpha(B)
 \equiv \Lambda J_\alpha d_\alpha^{-3}
 B^{4m+96}\frac{C(B)}{C_\alpha(B)}
 \pmod{C_\alpha(B)}.\quad}
\tag{4.14}
\]

The congruence includes the multiplicity of every repeated label.

**Proof.** Apply Lemma 4.1 at any actual root `r_0` using
(4.7) and (4.12). Their leading coefficients are nonzero at that root.
It follows that
\[
 n-10-D=h-m_\alpha.
\tag{4.15}
\]

The left side and `h` are independent of `alpha`, so all positive
multiplicities are equal. Their sum is 4, proving (4.13). In particular
`a>=2` and `D<=n-12`, by Proposition 3.3.

The congruence supplied by Lemma 4.1 is
\[
 g_\alpha r^2\frac{T_\alpha(\ell_\alpha(r))}{C(r^3)}
       \equiv \Lambda Y
       \pmod{(r-r_0)^{e}},
\tag{4.16}
\]

where `e` is the multiplicity of the label. The quotient in (4.16) is
a regular nonzero function at the root: its equal zero multiplicities
have been cancelled.

Put `B=r^3`. Factoring each fourth-power difference gives
\[
 \frac{T_\alpha(\ell_\alpha(r))}{C(r^3)}
  =K_\alpha B^{-4m}
       \frac{M_\alpha(B)}{C(B)/C_\alpha(B)}.
\tag{4.17}
\]

All denominators in this expression are units at roots of `C_alpha`.
For example two labels over the same `alpha` have ratio in `mu_29`,
so it is never `-1` or a fourth root of unity other than 1.

To retain confluence, do not differentiate the value identity
`Y=J_alpha r_0^29` as if `Y` varied with `r`. Instead observe
`r_0^87=d_alpha` and, since `e<=m<=4<5`,
\[
 Y=J_\alpha r_0^{29}
 \equiv J_\alpha d_\alpha^{-3}r^{290}
                \pmod{(r-r_0)^e}.
\tag{4.18}
\]

Indeed `290=29+3*87` is divisible by 5, so
`r^290-r_0^290` vanishes to order at least 5. Divide (4.16) by `r^2`
and use `r^288=B^96`. Substitute (4.17) and clear unit denominators.
This gives (4.14) modulo every power `(B-s_alpha,j)^e`, hence modulo
`C_alpha(B)`. QED.

The step (4.18) is necessary: retaining only point values would not
justify the exclusion of repeated labels.

## 5. Excluding the squarefree norm type

Assume `m=1`, so all four roots of `A` occur. Write
`mathcal B=c A`, hence `g_alpha=c A'(alpha)`. The four numbers
`s_alpha=epsilon/b_alpha` are distinct by Lemma 2.2.

Evaluating (4.16)-(4.17) at a root and using (4.4), or simplifying
(4.14), gives
\[
 P(\alpha)A'(\alpha)b_\alpha^{-14}\, C'(s_\alpha)
           =\text{one common nonzero constant}.
\tag{5.1}
\]

For example in (4.17) with `m=1`,
`M_alpha(s_alpha)=4s_alpha^3` and
`K_alpha=-(A_4/A')b_alpha^4`; substituting these in (4.16) gives
(5.1) directly. All dependence on `c,epsilon,eta,Lambda` is in the
same nonzero constant.

For a monic separable quartic `C`, Lagrange interpolation of the constant
polynomial gives `sum_alpha 1/C'(s_alpha)=0` (compare the coefficient
of degree 3). Therefore (5.1) forces
\[
 \sum_{\alpha}P(\alpha)A'(\alpha)b_\alpha^{-14}=0.
\tag{5.2}
\]

Every geometric label is `b_alpha=b0_alpha xi^{e_alpha}`. Hence (5.2)
is
\[
 \sum_\alpha W_\alpha\xi^{-14e_\alpha}=0.
\tag{5.3}
\]

Group equal exponents. Lemma 2.1(1), extended to `E` by (2.2), says
that every group coefficient must vanish. Each such coefficient is a
nonempty subset sum of the `W_alpha`, contrary to Lemma 2.2. This excludes
the squarefree norm type for arbitrary geometric labels and scalars.

## 6. Excluding the two-double-root norm type

Assume `m=2`, with two distinct roots `alpha,beta` of `A` in the norm.
Write
\[
 C_\alpha(B)=(B-r_1)(B-r_2),\qquad
 C_\beta(B)=(B-s_1)(B-s_2).
\]

First suppose `r_1!=r_2`. Point values of (4.16) imply that
\[
 \frac{M_\alpha(r_i)}{r_i^{17}C_\beta(r_i)}
\]

is independent of `i`. Since
\[
 M_\alpha(r_i)=4r_i^3(r_1+r_2)(r_1^2+r_2^2),
\]

and the common factor is nonzero, this is exactly
\[
 r_1^{14}C_\beta(r_1)=r_2^{14}C_\beta(r_2).
\tag{6.1}
\]

Normalize by `r_1`. Then `r_1=1`, `r_2=r in mu_29-{1}`, and the
other roots are `d a,d b`, with `a,b in mu_29` and
`d=b0_alpha/b0_beta`. Expanding (6.1) gives
\[
 (1-r^{14})ab\,d^2+(r^{15}-1)(a+b)d+(1-r^{16})=0.
\tag{6.2}
\]

Its leading coefficient is nonzero. It is a quadratic equation over
`F_(5^14)` for `d`, contradicting its degree 4 in Lemma 2.2 and (2.2).
This argument also allows `a=b`. Interchanging the two groups proves
that their labels must both be repeated if the type is to survive.

It remains to consider
\[
 C_\alpha=(B-r)^2,\qquad C_\beta=(B-s)^2.
\]

Now the confluent, not just pointwise, part of (4.14) is decisive.
Before clearing denominators it says
\[
 f_\alpha(B)=g_\alpha K_\alpha B^{-8}
          \frac{(B+r)^2(B^2+r^2)^2}{(B-s)^2}
   \equiv \text{nonzero constant}\cdot B^{96}
                                          \pmod{(B-r)^2}.
\]

Taking logarithmic derivatives at `B=r` is valid, since every factor
is a unit there. The derivative of the middle numerator divided by the
numerator is `3/r`. Thus, in characteristic 5,
\[
 -8/r+3/r-2/(r-s)=96/r,
\]

or `-2/(r-s)=1/r`, hence `s=3r`. The other group similarly gives
`r=3s`, which would imply `r=9r=4r`, impossible for `r!=0` in
characteristic 5. This excludes the whole two-double-root type.

## 7. Excluding the quadruple-root norm type

Assume `m=4`, supported at a single root of `A`. Then `C_alpha=C` and
(4.14), with its nonzero constants absorbed, becomes
\[
 C(B)\mid M(B)-L B^{112},\qquad L\ne0.
\tag{7.1}
\]

All roots of `C` are one nonzero scalar multiple of `mu_29`, including
multiplicities. Rescale `B` by that scalar. The scalar factors in
`M` and `B^112` are absorbed into `L`, and (7.1) becomes precisely
Lemma 2.3. It is impossible. This handles every repeated-label pattern,
not merely four distinct labels.

## 8. Main structural theorem and its dependencies

### Theorem 8.1

For the exact `P,A` of this problem, under the supplied established inputs,
any actual comparison of pole degree 12 has
\[
 H_1=H_2=0\quad\text{and}\quad[k(T):N]=3.
\]

**Proof.** If index 1 held, both character polynomials would be nonzero.
Proposition 4.3 reduces all 35 norm patterns to the three uniform types:
24 nonuniform patterns are impossible, leaving one squarefree pattern,
six two-double-root patterns, and four quadruple-root patterns. Sections
5, 6 and 7 exclude all of these. Thus index 1 is impossible. The supplied
dichotomy leaves index 3, and gives both vanishing statements. QED.

The finite field computations are used only for Lemmas 2.1-2.3. All
subsequent deductions are algebraic or formal-local proofs. The argument
is uniform in `n`; it does not enumerate any covering maps or assume a
bound on the field of their coefficients.

### Reusable form of the criterion

The same proof applies to any curve/polynomial pair with this cubic and
pole-window setup for which the supplied two-leg polynomial shape and
endpoint identities hold, provided:

- the four constants `c_alpha` are distinct;
- a common field `E` contains `F25`, all four roots of `A`, the relevant
  polynomial coefficients, and chosen 29th roots of the `c_alpha`, and
  is linearly disjoint from `F_(5^14)` over `F25`;
- the four associated weights in `E` have no nonempty vanishing subset sum;
- pairwise ratios of these chosen roots have degree greater than 2 over
  `F_(5^14)`.

Lemma 2.1 and the confluent obstruction of Lemma 2.3 are universal in
characteristic 5. The local transport lemma 4.1 is independent even of
this pole degree. Thus the mechanism is a two-ended character-term
obstruction, not a list of field-valued candidate comparisons.

## 9. The remaining quartic branch, preserving the maps

### 9.1 What is now known

Let `S` be the smooth model of `N`. The supplied consequences now apply
without an unproved index assumption:
\[
 [k(T):k(S)]=3,\quad \deg(t:S\to\mathbf P^1)=4,
 \quad \deg u=\deg v=n,\quad 12\le n\le186,
 \quad g(S)\le3n-21.
\]

In fact
\[
 k(S)=k(u,t)=k(v,t)=k(u,v).
\tag{9.1}
\]

For example `F_{10}(u,t)` is irreducible over `k(u)` because it is
irreducible over `K_1`; its degree in `t` is `n`. Hence
`[k(T):k(u,t)]=3`. Since `k(u,t)` lies in `N`, which has the same
index, equality follows. The other leg is identical.

The original source is still the connected cubic normalization
`y^3=P(u)`, with the original second coordinate `y_2=r y`, where
`r^3=P(v)/P(u)`. The original embeddings have not been replaced by an
unrelated quotient model.

### Proposition 9.2: parameter normal-closure bound

The normal closure of `k(T)/k(t)` has degree dividing
\[
 3^4\cdot24=1944.
\]

Its Galois group is solvable and has order prime to 5.

**Proof.** The normal closure `M` of the separable quartic extension
`k(S)/k(t)` has group a subgroup of `S_4`, hence order dividing 24.
Over `M`, adjoin cube roots of the at most four conjugates of `P(u)`.
Because `mu_3` lies in `k`, this is a Kummer extension of degree dividing
`3^4`. The resulting field is normal over `k(t)`, and is the normal
closure of `k(T)`. Its group is an extension of an abelian 3-group by a
subgroup of the solvable group `S_4`. QED.

This places no prime-to-five restriction on `n`. It does not assert
that either endpoint map is Galois, nor that passing to this normal
closure preserves their etaleness. The normal closure can ramify over
`T`, so it is not a simultaneous etale Galois closure of the two legs.

### Proposition 9.3: exact reconstruction criterion

The unresolved existence question is equivalently the existence of the
following data over `k`:

1. A smooth proper connected curve `S` with separating functions `t,u,v`,
   of degrees `4,n,n`, such that `k(S)=k(u,v)=k(u,t)=k(v,t)`.
2. `P(u)` is not a cube in `k(S)`, and there is `r in k(S)^times` with
   `r^3=P(v)/P(u)`.
3. Both `u` and `v` are unramified outside the eleven-point set consisting
   of the roots of `P` and infinity; at points above that set their
   ramification indices are 1 or 3.
4. Some `epsilon in k^times` satisfies

   \[
   A(v)=\epsilon^4t^{-13}A(u),\qquad
   (dv/du)^3P(u)^2=\epsilon^{-17}t^{48}P(v)^2.
   \tag{9.2}
   \]

One may retain the supplied bounds and all supplied endpoint/common-pole
conditions as additional necessary filters. No quartic Galois or
involution hypothesis is included.

**Necessity** follows from the actual comparison, Theorem 8.1, (9.1),
and the supplied index-three description.

**Sufficiency, including the original-map tests.** Let `T` be the smooth
proper normalization of `S` in `k(S)(y)` with `y^3=P(u)`. The noncube
condition makes it connected and of degree 3 over `S`. Define
\[
 h_1=(u,y),\qquad h_2=(v,r y).
\]

These are the two indicated embeddings of `k(X)`. They give finite maps
between the smooth proper curves. Each has degree `n` by the field
tower over `k(u)` or `k(v)`.

To verify everywhere-etaleness, consider either coordinate map, say `u`.
Away from the eleven branch values the cubic curve `X/P1` is unramified,
and assumption 3 makes `h_1` unramified. Above a branch value let the
ramification index of `u` be `e=1` or `3`. Normalizing the cubic base
change gives index `3/gcd(3,e)` over `S`; consequently its index over
`X` is `e/gcd(3,e)=1`. All these indices are prime to 5. This proves
etaleness, including at infinity. The same calculation applies to
`v`, since `k(S)(r y)=k(S)(y)`, proving etaleness of `h_2` as well.

By (9.2), `((dv/du)/r^2)^3=epsilon^{-17}t^48`. Hence
`(dv/du)/r^2=eta t^16` for some constant `eta` with
`eta^3=epsilon^{-17}`. Thus
\[
 h_2^*\tau=\epsilon^{64}\eta^{13}h_1^*\tau.
\]

The joint image of the two fields contains `u,v,y`; by condition 1 it
is all of `k(T)`. If their images were equal, their identifications
with `k(X)` would differ by an automorphism of `X`. Its supplied
`C3` automorphism group fixes `x`, so `u=v`. The first equation of
(9.2) would then make `t` constant, a contradiction. Thus the embedded
endpoint fields are distinct.

Finally `div(theta_i)=16D_i` and their ratio `eta t^16` give
`div(t)=D_2-D_1`. The degree of `t` on `T` is `3*4=12`.
This proves precisely the required actual comparison, not just a
necessary-equations model. In particular the reduced endpoints and
the remaining common-pole properties follow for any successful
reconstruction. QED.

### What is not proved

No data satisfying all four items of Proposition 9.3 have been produced.
No contradiction to their simultaneous existence has been proved.
The first-character-term method stops when both character polynomials
vanish. The degree-four function-field problem, including connectedness,
Kummer compatibility, all ramification conditions and both-map
reconstruction, remains unresolved in this archive.

## 10. Computation, evidence, and reproducibility

The verifier uses only the Python standard library. It was executed with
Python 3.13.5. It requires no SageMath, SymPy, external files, network
access, or input attachments.

Exact commands from the extracted archive root:

```
python3 -B src/check_manifest.py
python3 -B src/verify.py
```

The default verifier recomputes all arithmetic and compares five
certificate files byte-for-byte. Generation is also reproducible via
`python3 -B src/verify.py --write-certificates`; that command was
executed, and its separate log is retained.

The finite fields and encodings are fully specified in
`data/reference_fields.json`. Irreducibility is checked before field
arithmetic is used. All 625 products in the input `F25` are also checked
against the explicit independent formula
\[
 (a+b\beta)(c+d\beta)=ac+3bd+(ad+bc+bd)\beta.
\]

Certificates:

- `arc_rank_checks.csv`: 3276 full-rank witnesses, each with eight pivot
  rows and a nonzero determinant modulo 5.
- `mu29_sum_checks.csv`: every multiset and exact sum for sizes 2, 3, 4.
- `confluent_m4_checks.csv`: one exact obstruction for each of the 4495
  normalized multisets, distinguishing unequal point values from a
  nonzero higher jet.
- `curve_checks.json`: exact root, derivative, endpoint-constant, chosen
  29th-root, weight, subsum and ratio data.
- `arithmetic_summary.json`: finite-field generators, counts, the sole
  point-value survivor and its failed confluent jet, and scope labels.

`claims.json` maps each mathematical and computational claim to its
proof and evidence. The supplied established facts are explicitly marked
as assumptions, not as independently checked claims. Verification logs
record what actually ran. The written formal-local argument is not
mislabelled as a machine-verified theorem.

## 11. Failed routes and safeguards against overinterpretation

**Norm alone.** Polynomial norm does not force `H=0`. This report does
not use that invalid inference. The two minimal polynomials, their
common actual normalization, and the label-preserving formal chart
comparison are all necessary in Section 4.

**First jets alone.** The first two endpoint jets balance the cubic
orbits, but do not give a uniqueness theorem for all higher formal
coefficients. The proof transports the *first nonzero character term*,
wherever it occurs, rather than asserting that higher coefficients
vanish by a characteristic-zero uniqueness argument.

**Simple label tests.** Rejecting only four distinct labels would leave
an actual gap. The congruence modulo `C_alpha` retains all multiplicities;
the Frobenius replacement (4.18), exponent 112, and the jet check in
Lemma 2.3 close that gap.

**Quartic quotient arithmetic.** The finite endpoint arithmetic in this
archive is not a finite-field search for quartic models. It imposes no
field bound on coefficients of `S,u,v,t` or on `epsilon`. It also does
not exclude the 35 norm patterns when `H=0`.

**Genus and normal closures.** The supplied genus upper bound is
compatible with a nonempty range of degrees and is not an exclusion.
The new parameter normal-closure bound does not turn that normal closure
into an etale cover of either endpoint. Neither observation settles
Proposition 9.3.

**No unattained computation is claimed.** No enumeration of all etale
covers, no solution of a quartic reconstruction scheme, and no search
in a guessed coefficient field was executed or certified. The archive
contains no purported surviving actual-map witness.

## 12. Sources and logical independence

The curve-specific setup, the five established inputs, and the stated
polynomial dichotomy are supplied hypotheses, transcribed in `INPUTS.md`.
The main new proofs are Sections 3-8 and the first-defect transport lemma.
Their finite arithmetic is supplied in full here, not cited to an
external computation.

For standard background only, the following primary reference sections
were checked on 2026-09-24:

- The Stacks Project, Tag **0BXX**, “Curves and function fields”: extension
  of rational maps from normal proper curves and correspondence between
  function fields and smooth proper models.
  `https://stacks.math.columbia.edu/tag/0BXX`
- The Stacks Project, Tag **0C1B**, “Riemann-Hurwitz”: the local
  ramification/differential formula and the etale genus calculation.
  `https://stacks.math.columbia.edu/tag/0C1B`

The relevant local index computations and field arguments have also been
included explicitly, so downloading these references is not necessary
to reproduce the certificates or follow the specific proof.

