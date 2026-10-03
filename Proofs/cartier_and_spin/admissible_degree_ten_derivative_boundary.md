# Proof: admissible degree ten derivative boundary

Canonical statement: [admissible_degree_ten_derivative_boundary](../../Theorems/cartier_and_spin/admissible_degree_ten_derivative_boundary.md).
The supplied data and prior hypotheses are recorded in the retained
[inputs](../../../litt3-computation-data/structural_norm_replies_20260924/extracted/degree10_admissible_primitive/INPUTS.md).
Archive-relative certificate and source filenames below refer to this
[retained evidence directory](../../../litt3-computation-data/structural_norm_replies_20260924/extracted/degree10_admissible_primitive/).
The new written implications were reviewed locally and the full exact
verifier replay passed on 24 September 2026; see the
[focused integration record](../../Research/audits/STRUCTURAL_NORM_REPLIES_2026_09_24.md).


## 0. Status and main statements

**The original existence question is not decided.** This report proves a substantial geometric boundary exclusion and several new necessary conditions. All conclusions apply over the full algebraic closure, not just at the points of a finite field.

Throughout, the actual existence problem and the reductions listed in `INPUTS.md` are accepted as supplied. In particular, all four surviving supports must be retained, and a point of the necessary linear family is not automatically a cover.

**Theorem A — complete exclusion of the linear-derivative boundary.** In the normalized affine 17-dimensional necessary family, no member with `a_1=a_2=0` can be the irreducible degree-ten polynomial of an everywhere étale cover of X. For each support this locus is an affine six-dimensional family, with the open condition `v!=0`. Consequently, any solution of the original problem must have
\[
\deg_W H_5'(W)=2\quad\text{or}\quad3.
\]

The theorem holds for all four supports and all geometric parameter values. Its proof does not use `5T~0`, or even the final admissible divisor assertions once the necessary polynomial family has been reconstructed.

**Theorem B — a necessary infinity-cluster test for the full family.** The first two jets of a specified integral polynomial at infinity have the form
\[
\mathcal P(U)=sU^5+\alpha_2U^2+\alpha_1U+\alpha_0,
\qquad
\mathcal Q(U)=\delta_3U^3+\delta_2U^2+\delta_1U+\delta_0,
\qquad s=[8]\ne0.
\]

For every actual étale candidate:

* If `alpha_2!=0` and `u_*=-alpha_1/(2 alpha_2)` satisfies `mathcal P(u_*)=0`, then `mathcal Q(u_*)=0`.
* If `alpha_2=alpha_1=0`, then all four `delta_i` vanish.

The seven variable jet coefficients are affine-surjective functions of the 17 parameters. Thus the first assertion excludes a nonempty open subset of a 16-dimensional geometric double-cluster boundary. The second restricts a 15-dimensional quintuple-cluster boundary to an 11-dimensional locus at this jet level. These are necessary conditions only; the surviving loci are not asserted to be étale.

Section8 records the trace restriction, exact order-five condition and discriminant-parity test. The later [trace-dual theorem](admissible_degree_ten_trace_zero_exclusion.md) excludes the remaining quadratic-derivative sector with the order-five requirement. The relaxed non-torsion loci and cubic-derivative sector remain undecided; this sequel is not an input to the boundary proof.

## 1. Fields, polynomials and accepted dependencies

The base field is `k=algebraic closure of F_5`. A code `[a+5b]` denotes `a+b beta`, with `beta^2=beta+3`. All polynomial rows are ascending. The polynomials P, A, Q, B0 and L are exactly those in `INPUTS.md` and `inputs.json`.

The monic associate of A is
\[
A_{\rm mon}(x)=[5]+[2]x+[6]x^2+[7]x^3+x^4.
\]

The certificate verifies that A has no factor of degree one or two and that `x^(25^4)=x mod A`. In particular A is irreducible of degree four over F_25. Set
\[
E_0=\mathbf F_{25}[\rho]/(A_{\rm mon}(\rho)),\qquad |E_0|=25^4=390625.
\]

This is a field of definition for one support and the calculations, not a restriction on the geometric parameters.

To distinguish the two encodings, write `⟨n⟩` for an E_0-code. If `n=n_0+25n_1+625n_2+15625n_3`, then
\[
\langle n\rangle=[n_0]+[n_1]\rho+[n_2]\rho^2+[n_3]\rho^3.
\]

Base-field codes below 25 embed unchanged. The base support omits the root rho, so
\[
t_B=A_{\rm mon}/(x-\rho),
\qquad
 t_B=(\langle20152\rangle,\langle806\rangle,\langle32\rangle,1).
\]

The other supports are its conjugates under `rho -> rho^25`. Frobenius is an automorphism of k, so a proof for this support transports to all four, including arbitrary geometric parameter values. The verifier additionally rebuilds and checks each conjugate support.

The accepted inputs used in the main exclusion are: the four-support reduction, the displayed polynomial form of F_b, the nonzero function v in `L_X(10O)`, and equations (4)–(6). The uniform norm theorem and the small-degree exclusions are not reproved here and are not used to replace actual étaleness.

## 2. Exact reconstruction and a smaller equivalent linear system

Use the 195 coefficients `c_(i,r,a)` in the order prescribed in the question, and append kappa as the 196th variable. Let
\[
D(Z)=\sum_{i=0}^5N_iZ^{5-i},\qquad d=Q-L^5.
\]

### 2.1 The finite-cluster equations

The identities supplied in the question imply `t_B^3 | d`. In fact d has order exactly three at each selected root r: `d'=Q'=PA^2` has order exactly two there, and 3 is invertible. Put
\[
J=d/t_B^3.
\]

Then J is a unit modulo t_B. The coefficient equations (5) are equivalent to
\[
J D(-L)+\kappa y^{10}=0\pmod{t_B^2},
\qquad
D'(-L)=0\pmod{t_B}.
\tag{2.1}
\]

Both are imposed in all three polynomial y-components. To see this directly, for `j<5` the `U^5 D(U-L)` term contributes nothing. For `j=0`, cancel `t_B^3`. For `j=1`, cancel `t_B^3` and use that J is a unit modulo t_B. For `j>=2`, the required power `t_B^(5-j)` divides `t_B^3`, so the condition is automatic.

The first congruence gives 18 scalar equations and the second gives nine. This reduction retains all three sheets over every selected root and all collisions of selected branches.

### 2.2 The infinity equations

The weight of `x^a y^r` is `3a+10r`. In (6), for `j=6,7,8`, the product `Q N_(j-5)` automatically meets the stated bound. For `j=9,10`, the only coefficients above the bounds give
\[
c_{4,1,16}=0,\qquad
c_{5,0,23}=0,\qquad
[24]c_{5,1,20}+\kappa=0.
\tag{2.2}
\]

For `j<=5` there is no additional restriction. Here the leading coefficient of Q is **[24], not 1**. In the normalized family,
\[
c_{5,1,20}=-[24]^{-1}=[8].
\tag{2.3}
\]

Equations (2.1)–(2.2), together with (4), are therefore equivalent to the original necessary system.

### 2.3 What was computed

The finite-pole matrix in (4) has rank 148 and a 47-dimensional kernel. Adding kappa gives 48 reduced coordinates. The 30 extra equations above have rank 30 on those coordinates. Hence the full kernel has dimension 18 and the slice `kappa=1` is affine 17-dimensional.

These ranks are recomputed by exact field arithmetic. The delivered data include the matrices, pivot columns and kernel bases. As an independent check, the verifier substitutes all 18 full kernel vectors into the **original** equations (4), (5) and (6), rather than only into the reduced equations. It executes 216 component remainder checks for (4), 270 for (5), and 540 component weight checks for (6).

The normalization of kappa is harmless: scaling all N_i, v and kappa together leaves `a_i=N_i/(y^i v)` and `kappa/v` unchanged.

## 3. Exact description of the locus with H_5' linear

Because the characteristic is five,
\[
H_5'(W)=4a_1W^3+3a_2W^2+2a_3W+a_4.
\]

Thus `deg H_5'<=1` is exactly `N_1=N_2=0` when v is nonzero.

**Lemma 3.1.** For the support omitting rho, the entire normalized locus `N_1=N_2=0` consists of
\[
\begin{aligned}
N_0&=v, &N_1&=N_2=0,\\
N_3&=yP S_2, &N_4&=yP S_5,\\
N_5&=Qv+yP R_{10}+\lambda y^2P t_B^2,
\end{aligned}
\tag{3.1}
\]

where v is arbitrary in `L_X(10O)`, lambda is arbitrary in k, and the following rows are in E_0-code notation:

```
S2  = [5214,322308,359499]
S5  = [85587,10892,294894,309137,299187,228099]
R10 = [293295,44771,284495,328179,186707,213113,
       112526,42751,34742,361101,8]
```

**Exact-computation proof.** Restrict the 18-dimensional homogeneous kernel by `N_1=N_2=0`; its dimension is seven. The seven vectors obtained from (3.1), by taking in turn `v=1,x,x^2,x^3,y`, `lambda=1`, and `kappa=1` with `v=lambda=0`, are independent and satisfy the full linear system. Thus they are the entire restricted kernel. Normalizing kappa leaves precisely the six parameters asserted. The matrices and vectors are in `linear_boundary.json`; the verifier reconstructs the restricted kernel and checks the formula vectors. ∎

In particular the locus is not merely sampled. Its full geometric parameter space has been identified.

Writing `q_W=W^5+f`, the corresponding degree-ten equation after multiplying by v is
\[
\mathcal F(W)
=vq_W^2+q_W\left(yS_2W^2+S_5W+R_{10}/y+\lambda t_B^2\right)+t_B^3.
\tag{3.2}
\]

The derivative is
\[
H_5'(W)=(2yS_2W+S_5)/v.
\tag{3.3}
\]

The polynomial S2 is nonzero, so this derivative has degree exactly one throughout the normalized locus.

The following identities and coprimalities are certified exactly:
\[
\deg S_2=2,\quad\deg S_5=5,\quad\deg R_{10}=10,
\]
\[
\gcd(S_2,S_2')=\gcd(S_2,P)=\gcd(S_2,S_5)=1.
\tag{3.4}
\]

Also, with
\[
D_0=S_5-2B_0S_2,\qquad
K_0=S_2B_0^2-S_5B_0+R_{10},
\]

one has
\[
\gcd(D_0,P)=1,\qquad P\mid K_0.
\tag{3.5}
\]

Each gcd assertion has a stored Bézout certificate. The exact quotient `K_0/P` is stored too. Together with the degree data, these supply all special-coefficient hypotheses for the local pole argument. Section6 closes its resulting norm identity by the existing fixed-X mixed-norm theorem.

## 4. A local pole-multiplicity lemma

Let R be `k[[t]]`, with valuation `ord_t`, and suppose a polynomial in Z begins
\[
V+A Z^r+C Z^{r+1}+\sum_{j\ge r+2}C_jZ^j,
\tag{4.1}
\]

where all coefficients are in R, `ord(V)=M>0`, and omitted coefficients of `Z,...,Z^(r-1)` are zero. A positive valuation of a root Z is a pole of the reciprocal variable.

The following are consequences of the Newton polygon. They can also be read from the first lower edges through the points corresponding to the displayed coefficients.

**Lemma 4.1.**

1. If A is a unit, the first edge joins `(0,M)` to `(r,0)`. It gives r roots, counted with multiplicity, of valuation `M/r`. If all roots belong to `k((t))`, then `r | M`.
2. If `ord(A)=1` and C is a unit, then:
   * for `M<r+1`, the first edge has length `r+1` and root valuation `M/(r+1)`;
   * for `M=r+1`, its root valuation is one;
   * for `M>r+1`, the positive-slope root groups have valuations `(M-1)/r`, with multiplicity r, and 1, with multiplicity one.

In particular, for `r=3`, integral root valuations require
\[
M\in\{4,7,10,13,\ldots\}
\tag{4.2}
\]

in the second case.

**Proof.** When A is a unit, all later points have nonnegative height and abscissa greater than r; none can lie below the indicated initial edge. In the second case the first relevant points are `(0,M),(r,1),(r+1,0)`. The middle point is above, on, or below the line joining the other two according as `M<r+1`, `M=r+1`, or `M>r+1`. Later points again cannot change these initial edges. The Newton-polygon root valuations follow. Roots in `k((t))` have integral valuation. ∎

For completeness, the root-valuation interpretation does not assume a separable residual polynomial. For a split polynomial, write it as a product of linear factors and order the valuations of its roots. The lower Newton polygon of the product is obtained by concatenating the lower segments of these factors; grouping equal valuations gives the stated lengths. Hence a nonintegral edge slope already contradicts splitting over `k((t))`, regardless of any later residual collision.

An everywhere finite étale degree-ten cover over a closed point of X becomes ten copies of `k[[t]]` after completion, because k is algebraically closed. Therefore every conjugate of its rational primitive belongs to `k((t))`. Lemma 4.1 gives a necessary test for actual étaleness.

The lemma is useful beyond this example: it depends on the gap between the top two nonzero coefficients, not on the global geometry of X or on an order-five line.

## 5. Global pole restrictions on the six-parameter family

Assume, towards a contradiction, that a member of (3.2), with v nonzero, is the degree-ten polynomial of an everywhere étale cover. Write
\[
v=V(x)+c_y y,\qquad \deg V\le3.
\]

### 5.1 The case c_y=0 is impossible at infinity

Here `V!=0`. Put `d=deg V`, so `0<=d<=3`. At O, the nonzero coefficients of (3.2) have the following pole bounds:

| Power of W | Coefficient | Pole order at O |
|---|---|---:|
| 10 | v | 3d |
| 7 | y S2 | 16 |
| 6 | S5 | 15 |
| 5 | 2vf+R10/y+lambda t_B^2 | at most 20 |
| 2 | f y S2 | 23 |
| 1 | f S5 | 22 |
| 0 | vf^2+f(R10/y+lambda t_B^2)+t_B^3 | at most 25 |

The W9 and W8 coefficients are zero. The bound 25 in the last row deserves attention. Since the leading coefficient of R10 is `[8]`,
\[
[24][8]+1=0.
\]

Thus the pole-order-27 terms of `f R10/y+t_B^3` cancel. Moreover `f R10/y=Q R10/P^2` is a rational function of x, so the remaining pole order is at most 24. The lambda term has pole order at most 25, and `vf^2` has pole order at most 23.

The Newton polygon has an edge between the W10 and W7 terms giving three roots with pole order
\[
 m=\frac{16-3d}{3}=\frac{16}{3}-d>2.
\tag{5.1}
\]

No other coefficient intervenes: at this m, the common value `10m+3d=7m+16` exceeds respectively `6m+15`, `5m+20`, `2m+23`, `m+22`, and 25. For example, the first two differences are `m+1` and `2m-4`, both positive; the others are larger still.

The number m is not an integer for any integer d. Hence the polynomial cannot split in the unramified completed algebra at O. This excludes **all** `c_y=0`, with no restriction on lambda or on the multiplicities that an actual G might have had over O.

### 5.2 Now assume c_y!=0

The function v has pole order exactly ten at O. Its zero divisor is finite and has total degree ten.

Let p be a finite zero of v, of multiplicity M.

#### Away from y=0 and S2=0

Both f and all coefficients in the brackets of (3.2) are regular, while `yS2` is a unit. Substitute `Z=1/W` and multiply by `Z^10`. The first coefficients are
\[
v+yS_2Z^3+S_5Z^4+\text{terms of degree at least five in Z},
\]

all regular. Lemma 4.1 gives
\[
3\mid M.
\tag{5.2}
\]

This argument includes selected roots of A and zeros of v lying above them. It does not assume v is nonzero at the selected support.

#### Above a zero of S2

By (3.4), x is unramified there, y is a unit, `ord(yS2)=1`, and S5 is a unit. Lemma 4.1 therefore gives
\[
M=4,7,10,\ldots.
\tag{5.3}
\]

Only the first three possibilities can occur in a divisor of total degree ten.

#### At a cubic branch point y=0

At such a point over `x=r`, the local parameter can be taken to be y, and `ord(x-r)=3`. If v vanishes, then `V(r)=0`, and
\[
v=c_y y+O(y^3).
\]

Thus M is exactly one.

It is important not to apply the preceding reciprocal-polynomial argument directly to b, since f and b have a common prescribed principal part here. Instead set
\[
w=b+B_0/y,\qquad g_0=(Q-B_0^5)/y^5.
\]

The function g0 is regular, since `P^2=y^6` divides the numerator. Then `q=w^5+g0`, and the bracket in (3.2) becomes
\[
yS_2w^2+D_0w+K_0/y+\lambda t_B^2.
\]

By (3.5), `K_0/y` is regular, `ord(yS2)=1`, and D0 is a unit. The reciprocal polynomial in `1/w` therefore begins
\[
v+yS_2Z^3+D_0Z^4+\cdots.
\]

With M=1, Lemma 4.1 gives four roots with valuation `1/4`. This contradicts étaleness. Consequently **v has no zero at a cubic branch point**.

### 5.3 The degree-ten count

All ordinary zeros of v have multiplicity divisible by three. Every exceptional zero lies over a root of S2 and has multiplicity `1 mod 3`, at least four. There can be at most two exceptional zeros because the total degree is ten. If their number is e, the total degree gives
\[
10\equiv e\pmod3.
\]

Thus e is exactly one. Call this point p*, with `x(p*)=r`. Its multiplicity is 4, 7 or 10, and `S2(r)=0`. Every other zero has multiplicity divisible by three.

Set `g=V/c_y`, a polynomial of degree at most three. The cubic norm is
\[
\operatorname{Nm}_{k(X)/k(x)}(v)=c_y^3(P+g^3).
\tag{5.4}
\]

At each x-value where v vanishes there is exactly one such point on X, namely `y=-g(x)`. None is a cubic branch point. Hence the multiplicities in the monic degree-ten polynomial `P+g^3` are precisely the multiplicities just described.

It follows that for some monic cubic B3,
\[
P(x)+g(x)^3=(x-r)B_3(x)^3,
\qquad S_2(r)=0,\quad B_3(r)=0.
\]

Writing `B3=(x-r)C2`, the necessary identity is
\[
P(x)+g(x)^3=(x-r)^4C_2(x)^3,
\quad \deg g\le3,\quad C_2\text{ monic of degree two},\quad S_2(r)=0.
\tag{5.5}
\]

This derivation allowed arbitrary multiplicities of v and G. In particular the multiplicities 7 and 10 have not been discarded; they are included in (5.5).

## 6. The later mixed-norm exclusion closes (5.5)

The [fixed-X mixed-norm theorem](../jacobians/isogeny_sieves/trigonal_constant_norm_obstruction.md),
Section7, excludes \(P+g^3=H^2J^3\) for every geometric cubic \(g\)
and monic quadratics \(H,J\), including repeated and common roots.
Equation(5.5) is its special case \(H=(x-r)^2\), \(J=C_2\).
Thus all \(c_y\ne0\) boundary candidates are excluded, including
multiplicities4,7and10. Together with Section5.1 this proves TheoremA
on all four supports. The old osculating-cubic computation is unnecessary.

## 7. Universal infinity-cluster conditions on the full 17-dimensional family

The remainder of this section does not assume `a_1=a_2=0`.

Let
\[
\mathcal F(W)=vF_b(W)
=\sum_{j=0}^{10}\frac{M_j}{y^j}W^{10-j},
\qquad M_0=v.
\]

Take the uniformizer `t=x^3/y` at O and set
\[
\mathcal G(t,U)=t^{25}\mathcal F(U/t).
\tag{7.1}
\]

Equations (6) imply that all coefficients of G are in `k[[t]]`. Indeed the contribution of a monomial of weight w in M_j has t-order at least `15+11j-w`, which is nonnegative under the stated bounds.

From `t^3=x^9/P(x)` one obtains
\[
x=t^{-3}(1+O(t^3)),\qquad y=t^{-10}(1+O(t^3)).
\]

Thus the constant and linear t-coefficients of G are obtained from weights `15+11j` and `14+11j`, respectively, without any additional unit corrections.

### 7.1 Exact jet formulas

Write `c_(i,r,a)` for the original coefficient of `x^a y^r` in N_i, and write `t_2=[x^2]t_B`. Then
\[
\mathcal G(t,U)=\mathcal P(U)+t\mathcal Q(U)+O(t^2),
\]

where
\[
\begin{aligned}
\mathcal P(U)&=sU^5+\alpha_2U^2+\alpha_1U+\alpha_0,\quad s=[8],\\
\alpha_2&=[24]c_{3,1,12},\\
\alpha_1&=[24]c_{4,0,19},\\
\alpha_0&=[24]c_{5,2,16},
\end{aligned}
\tag{7.2}
\]

and
\[
\begin{aligned}
\mathcal Q(U)&=\delta_3U^3+\delta_2U^2+\delta_1U+\delta_0,\\
\delta_3&=[24]c_{2,1,8},\\
\delta_2&=[24]c_{3,0,15},\\
\delta_1&=[24]c_{4,2,12},\\
\delta_0&=[24]c_{5,1,19}+[8]c_{5,1,20}+3(t_2+[22]).
\end{aligned}
\tag{7.3}
\]

The last term uses `[x^18]Q=[8]` and `[x^9]P=[22]`. In particular numerical codes in these expressions are field elements, not ordinary integer coefficients modulo 390625.

The verifier checks (7.2)–(7.3) in two ways: by the displayed linear map on coefficients, and independently by forming every M_j and extracting its top weights. The affine map from the 17 parameters to the seven coefficients `alpha_2,alpha_1,alpha_0,delta_3,delta_2,delta_1,delta_0` has rank seven. Appending the five coefficients of v gives rank twelve.

### 7.2 A general integral-cluster lemma

**Lemma 7.1.** Let `G in k[[t]][U]`. Suppose m distinct roots in `k((t))` are integral and reduce to the same `u_0 in k`. Then
\[
G\in(t,U-u_0)^m\subset k[[t]][U].
\tag{7.4}
\]

**Proof.** The roots have the form `u_i(t)=u_0+t a_i(t)`. Successive division by the monic factors `U-u_i(t)` takes place in `k[[t]][U]`. After any division, the remaining distinct roots are still roots of the quotient because their differences from the removed root are nonzero in the fraction field. Hence their product divides G in the coefficient ring. Each factor belongs to `(t,U-u_0)`, proving (7.4). ∎

For an actual candidate, the five selected branches over O satisfy `ord(b)>=-1`, so `U=tb` is integral on them. Every other branch has `ord(b)=-2-mult(G)`, because there `q` has pole order `10+5 mult(G)` whereas f has pole order seven. Thus there are exactly five integral roots in (7.1). Their reductions are precisely the five roots of P, with multiplicities: the leading coefficient s is nonzero and P has degree five.

This also shows explicitly why arbitrary G-multiplicities over O do not invalidate the test.

### 7.3 The double-cluster boundary

Suppose `alpha_2!=0`. Since
\[
\mathcal P'(U)=2\alpha_2U+\alpha_1,
\]

there is at most one repeated root, namely
\[
u_*=-\alpha_1/(2\alpha_2).
\]

It is repeated exactly when `mathcal P(u_*)=0`, equivalently
\[
\Delta=4\alpha_2^5\alpha_0-\alpha_2^4\alpha_1^2-2s\alpha_1^5=0.
\tag{7.5}
\]

Because the second derivative is `2 alpha_2!=0`, this root has multiplicity exactly two and the other three roots are simple. Lemma 7.1 with m=2 requires
\[
\mathcal Q(u_*)=0.
\tag{7.6}
\]

Consequently every geometric point satisfying
\[
\alpha_2\ne0,\qquad\Delta=0,\qquad\mathcal Q(u_*)\ne0
\tag{7.7}
\]

is excluded from actual étaleness. When the polynomial defines a separable function-field model, the local quadratic factor at this cluster has constant term of t-order one after centering at u*. Its discriminant has odd valuation one. Thus this is a genuine tame ramification-index-two obstruction, not merely an unusual choice of polynomial generator.

The affine surjectivity above shows that (7.7) is a nonempty open part of a 16-dimensional hypersurface in the necessary family. The condition `v!=0` does not empty it: the joint rank with v is twelve, and the archive supplies an exact point with
\[
v=1,\qquad\mathcal P(U)=[8]U^5+U^2,\qquad\mathcal Q(U)=1.
\]

This point is used only to verify nonemptiness of the forbidden parameter locus. No irreducibility assertion is made about it.

### 7.4 The quintuple-cluster boundary

Suppose `alpha_2=alpha_1=0`. Over k there is a unique u0 with
\[
\mathcal P(U)=s(U-u_0)^5.
\]

All five selected roots would reduce to u0. Lemma 7.1 with m=5 says that the coefficients of `t(U-u_0)^j` vanish for `j=0,1,2,3`. Since Q has degree at most three, this forces
\[
\delta_3=\delta_2=\delta_1=\delta_0=0.
\tag{7.8}
\]

The original boundary has dimension 15, and (7.8) cuts it to dimension 11 at this jet level. Higher jets and global étaleness remain to be imposed. Neither (7.6) nor (7.8) is asserted sufficient.

The cluster lemma and the mechanism behind (7.6) extend to other degrees: a cluster of m Laurent-series branches on an étale cover must satisfy the corresponding total-order-m vanishing conditions. The special feature here is the explicit sparse quintic and cubic jets and their verified ranks.

## 8. Additional reusable constraints and exact torsion reformulation

### 8.1 Trace restriction on the remaining a_1=0 locus

For an actual candidate, `Tr(b)=-a_1`. Assume `a_1=0`. At a finite base point outside y=0 use b itself; at y=0 use `w=b+B0/y`. In the second case
\[
\operatorname{Tr}(w)=\operatorname{Tr}(b)+10B_0/y=0
\]

in characteristic five. In both cases `q=w^5+g_0` with g0 regular at the base point (using `w=b` and `g0=f` outside y=0).

If a fibre contained exactly one point of G, w would have a pole on precisely that sheet and be regular on all other sheets. Its trace would have that nonzero principal part, contradicting trace zero. Therefore every finite fibre meeting G contains at least two distinct points of G, and every finite zero of v has multiplicity at least two.

In particular, if `c_y!=0`, v cannot vanish at y=0, where any zero would have multiplicity one. As in (5.4), with `g=V/c_y`, the polynomial
\[
W(x)=P(x)+g(x)^3
\]

is monic of degree ten and has **no simple geometric root**.

Factoring W over k and writing every multiplicity at least two as `2a+3b`, with `b=0` for even multiplicity and `b=1` for odd multiplicity, gives one of the following necessary identities:
\[
P+g^3=H_5(x)^2,
\quad\text{or}\quad
P+g^3=H_2(x)^2J_2(x)^3,
\tag{8.1}
\]

with the subscripts indicating monic degrees and `deg g<=3`. The number of odd multiplicities is even, and can only be zero or two in degree ten, which explains the two cases. Both alternatives are impossible by the [constant and mixed norm obstructions](../jacobians/isogeny_sieves/trigonal_constant_norm_obstruction.md). Hence the entire trace-zero nonzero-y sector is excluded, without an additional elimination.

There is also a simple infinity restriction when `c_y=0`: v cannot be a polynomial of degree three on an actual trace-zero candidate. In that case `h_*G` has multiplicity one at O. Exactly one sheet has b of pole order three, while all others have pole order at most two, again contradicting trace zero.

At a finite root r of a polynomial v of degree at most two, if P(r)!=0, each of the three points above r has multiplicity ord_r(v). That multiplicity cannot be one. At a root of P it is three times ord_r(v). Thus v is constant, has a single linear factor rooted at a P-root, has two distinct such factors, or is a scalar square of a linear polynomial. This applies to the entire actual `a_1=0` sector and retains all collisions; no remaining shape is asserted realizable.

### 8.2 The order-five condition is a balanced-divisor condition

For any actual primitive with the required divisor of q,
\[
5T-\operatorname{div}(q)=2E-10H.
\]

Hence
\[
5T\sim0\quad\Longleftrightarrow\quad 2E\sim10H.
\tag{8.2}
\]

Equivalently, the degree-zero Riemann–Roch space
\[
H^0\bigl(S,\mathcal O_S(10H-2E)\bigr)
\]

is nonzero. A nonzero element phi then has exactly
\[
\operatorname{div}(\phi)=2E-10H,\qquad
\operatorname{div}(q\phi)=5T.
\]

The exact nontriviality test is
\[
T\not\sim0\quad\Longleftrightarrow\quad q\phi\notin k(S)^5.
\tag{8.3}
\]

Indeed a fifth root gives a principal divisor T; conversely, if T is principal, the remaining constant has a fifth root because k is algebraically closed.

There is a useful symmetric form. Let `E^c=h^*B-E`, a reduced divisor of degree 50 complementary to E in the ten selected base fibres. Since `div(t_B)=B-10O`,
\[
z=\phi/h^*t_B
\quad\text{satisfies}\quad
\operatorname{div}(z)=E-E^c,
\qquad \operatorname{Nm}_h(z)\in k^\times.
\tag{8.4}
\]

Thus the order-five condition requires a separating degree-50 function whose simple zeros and poles form complementary five-sheet subsets in every selected fibre. This is an exact equivalence with (8.2), not a proof that such a function exists. The nontrivial fifth-power test (8.3) still has to be checked afterwards.

### 8.3 A global discriminant condition, and its limitation

For a separable irreducible member write `C=t_B^3/v`. From
\[
F_b=(W^5+f)H_5+C,\qquad F_b'=(W^5+f)H_5',
\]

one gets
\[
\operatorname{Nm}(q)=C^5,
\qquad
\operatorname{disc}(F_b)=-C^5\operatorname{Res}(F_b,H_5').
\tag{8.5}
\]

The first identity follows by reducing F_b modulo `W^5+f`; the sign in the second is `(-1)^(10*9/2)=-1`.

If h is everywhere étale, the discriminant of the power basis has even valuation at every point of X. To justify this even when b has poles or is not an integral generator, compare the power basis with a basis of the completed étale algebra. The latter has unit discriminant. Changing basis multiplies the discriminant by the square of a determinant in the fraction field.

Thus, up to squares and a nonzero constant,
\[
\delta=C\operatorname{Res}(F_b,H_5')
\tag{8.6}
\]

must have even divisor everywhere. This is a necessary condition on every remaining candidate. Its resultant only involves a derivative of degree at most three.

It is not sufficient for étaleness. For example the cubic Newton branches used in Section 5 can have tame ramification index three, whose different exponent is two; such ramification is invisible to a parity-only test. This is one reason the proof of Theorem A uses the actual integral-root restrictions rather than only a discriminant square class.

## 9. Verification scope, audit notes and unresolved work

### 9.1 Executed checks

`verification/generation.log` and `verification/verification.log` record the actual runs. The software versions are Python 3.13.5 and NumPy 2.3.5. The original delivered verifier also checked the now superseded
osculating-cubic identity. Its unchanged source and logs remain in the
retained evidence directory. The current reconstruction source retains
the checks still used here:

- checks the exact input-polynomial identities and the field construction;
- reconstructs both ranks and the full 18-dimensional kernel;
- verifies original equations (4)–(6) on every full kernel basis vector;
- identifies and verifies the complete seven-dimensional homogeneous boundary formula;
- checks all coprimality hypotheses, with Bézout identities;
- independently extracts the infinity jets and checks their ranks;
- verifies the stored forbidden-boundary point as a necessary-system point only;
- rebuilds and verifies the reduced kernel for all four supports;
- compares all rebuilt certificates with the delivered portable JSON data.

The original archive verifier optionally checks its SHA-256 manifest.
The current source compares the retained kernel fields of the old
four-support certificate, omitting its superseded osculation fields.
No probabilistic tests or finite-field point enumeration are used.

### 9.2 Implementation pitfalls corrected and guarded against

The leading coefficient `[24]` of Q must be retained in the last infinity equation. Replacing it by 1 produces the wrong affine family. Also, the five free-v directions on the linear-derivative boundary have `N5=+Qv`, not `-Qv`; this is why (3.2) contains `v q_W^2`.

Both signs/coefficient issues arose in preliminary exploration and were corrected before the delivered certificates were generated. The final checks against the original equations and the independent jet extraction guard specifically against silently carrying either error into the proof. No provisional or failed certificate is included as a valid certificate.

### 9.3 Approaches that do not complete the problem

The uniform norm result alone says nothing that kills the upstairs nontrivial order-five class. Section 8.2 makes the remaining divisor issue explicit but does not resolve it.

First-order infinity analysis cannot exclude the entire family: the verified affine surjectivity allows arbitrary seven jet coefficients, including squarefree initial quintics. Theorem B only excludes the specified collision boundaries. It does not assert that all other local branches, or any global model, are étale.

A dimension comparison between a parameter space and an anticipated ramification condition is not a nonexistence proof. No such heuristic is used here. Likewise, discriminant parity by itself misses some ramification, as explained above.

The norm alternatives(8.1) are now both closed by the existing norm theorem. No global nonlinear elimination of the full17-dimensional family, normalization/genus calculation, or torsion computation on an actual degree-ten cover is claimed.

### 9.4 Exact remaining problem

After Theorem A, a solution must lie in one of the two sectors
\[
a_1\ne0,
\qquad\text{or}\qquad
a_1=0,\ a_2\ne0.
\]

With the full order-five requirement, the later
[trace-dual exclusion](admissible_degree_ten_trace_zero_exclusion.md)
closes the second sector. The current actual existence gap is therefore
\(a_1\ne0\). The following tests remain necessary for the relaxed
non-torsion families as well.

The latter must also satisfy the trace restrictions in Section 8.1. Every actual point in either sector must pass the cluster restrictions of Section 7 and the full global étaleness requirement. After an actual cover and its divisors have been established, (8.2)–(8.3) provide the precise remaining order-five test.

A negative completion must exclude all geometric values in these sectors, not just a finite-field sample or a generic point. A positive completion must establish an irreducible separable degree-ten model, its everywhere étaleness, the exact required divisors, and nontriviality in (8.3). In particular a genus-81 certificate for the actual normalization would suffice for the zero-different part, but no such genus computation is claimed here.

## 10. Background references and proof dependencies

The problem-specific global inputs are the supplied hypotheses in `INPUTS.md`. All new local pole, divisor-count, trace and cluster arguments are proved above. The coefficient-dependent assertions are backed by the exact certificates identified in `claims.json`.

For the standard background on differents, Riemann–Hurwitz and discriminants, the following primary references were consulted:

- The Stacks Project, Section 53.12, tag **0C1B**, “Riemann-Hurwitz”, in particular the effective different divisor and the tame exponent `e-1`.
- The Stacks Project, Lemma 49.3.1, tag **0BJF**, “A finite locally free morphism is étale if and only if its discriminant is empty.”

These references are supplementary; the concrete certificates and the new geometric exclusions do not require any downloaded document or prior conversation file.
