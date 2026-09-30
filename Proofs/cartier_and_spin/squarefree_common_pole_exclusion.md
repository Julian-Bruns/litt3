Imported Pro proof, 24 September 2026; focused integration and local verification are recorded in [the audit](../../Research/audits/STRUCTURAL_TRIPLET_2026_09_24.md). File references inside this report are relative to the preserved [results archive](../../../litt3-computation-data/structural_triplet_replies_20260924/originals/pole/squarefree_common_poles_complete/). Generated certificates stay there; source copies are in scripts/arithmetic/pro_structural_triplet_20260924/pole. The canonical theorem statement governs its accepted scope.

# Complete exclusion of the squarefree-common-pole branch

**Status: completed negative decision, by a computer-assisted proof with exact certificates.**

Every normalized squarefree-denominator model in the question is impossible. In particular, the previously remaining degrees **8 through 23** are all excluded. Together with the preserved earlier work, this settles the entire requested range **8 through 64**, with every allowed genus and every allowed pole-sheet configuration.

The new obstruction is actually independent of the covering degree once the stated endpoint and squarefree finite-pole profiles hold. It does not use an assumption about the original covers being Galois or about their complete monodromy being tame.

All earlier reports, inputs, code, certificates, and logs are preserved without changes in `history/previous/`; the original ZIP is also included as `history/previous_archive.zip`. Statements there that the degree-8–23 problem remained open describe the historical state and are superseded by this report.

## 1. Exact scope and theorem

Let `k` be the algebraic closure of `F_5`. Write
\[
[a+5b]=a+b\beta,\qquad \beta^2=\beta+3,\qquad 0\le a,b<5.
\]
Coefficient rows are ascending. Square brackets distinguish field codes from mathematical integers. Integers in formulas are reduced modulo five when used as scalars.

The given polynomials are
\[
P=(11,22,18,5,19,20,15,16,9,22,1),\qquad
A=(1,21,14,22,13).
\]
Consider the quadratic function field of the smooth curve `S`, with separating coordinate `s` of degree two. The points above zero and infinity are unramified. Suppose `x_1,x_2` have the exact pole profile in the question: `x_1` has order-three poles at both infinity points and is regular at both zero points; `x_2` has the opposite endpoint profile. All other poles are common, have order one for both functions, and lie over the roots of a squarefree divisor of `s^29-1`. A common pole is initially allowed to be a branch point of the quadratic map.

Assume, for `epsilon != 0`, the two identities
\[
s^{13}A(x_2)=\varepsilon^4 A(x_1),\qquad
\left(\frac{dx_2}{dx_1}\right)^3P(x_1)^2
=\varepsilon^{-17}s^{48}P(x_2)^2.                 \tag{1.1}
\]
### Theorem

**No such quadratic model exists.** Consequently there is no model satisfying all the stronger conditions (1)–(7), the integer ranges, and the ramification requirements of the question. Therefore no pair of distinct, jointly generating embedded `X`-fields can arise from the squarefree-denominator subcase under investigation.

The conclusion does not assert recognition in the nonsquarefree-denominator subcase, or in other comparison-degree branches that are not covered by the supplied reductions.

### Proof outline

The two identities determine a common-pole residue and two terms of each endpoint expansion. Comparing these terms with the rational quadratic traces gives two scalar identities. Eliminating `epsilon` yields a necessary equation for four moments of the pole multiplicities. Those multiplicities are integers in `{0,1,2}`.

The endpoint leading data belong to an explicit set of 116 possibilities, even when all model coefficients are allowed to range over `k`. After valid symmetries, there are 787,176 endpoint cases. The moment equation becomes seven linear equations and one quadratic over `F_{5^7}`. Exact certificates exclude all but 42 moment vectors. Fourier inversion shows that each remaining vector forces at least four distinct multiplicity residues, whereas `{0,1,2}` contains only three. This is the contradiction.

The finite calculation concerns **all possible necessary endpoint and pole data**, not models sampled over a selected field. Sections 5–8 prove its coverage of arbitrary geometric coefficients.

## 2. Common poles: quadratic ramification is excluded, and the residue is fixed

Put
\[
u=P_9=[22],\qquad \chi=2u.
\]
Let a common pole lie above `s=xi`. It has order one for both functions. Use `t=1/x_1` as its local parameter. Write
\[
s=\xi h(t),\quad x_2=V(t)/t,\quad h(0)=1,\quad V(0)=\lambda\ne0.
\]
The leading terms of (1.1) give
\[
\lambda^4=\varepsilon^4\xi^{-13},\qquad
\lambda^{17}=\varepsilon^{17}\xi^{-48}.
\]
Dividing the second equality by the fourth power of the first gives
\[
\lambda=\varepsilon\xi^4.
\]
In particular the common-pole leading comparison used below follows directly from both identities. We already know `xi^29=1` from the normalized model.

Let
\[
A_t(V)=\frac{t^4}{A_4}A(V/t),\qquad
P_t(V)=t^{10}P(V/t).
\]
Since `dx_2/dx_1=V-tV'`, the local identities become
\[
h^{13}A_t(V)=\lambda^4A_t(1),\qquad
\lambda^{17}(V-tV')^3P_t(1)^2=h^{48}P_t(V)^2.   \tag{2.1}
\]
Write `h=1+sum h_j t^j` and `V=lambda+sum v_j t^j`. At order `j`, after dividing the equations by their leading powers, the matrix of the new coefficients `(h_j,v_j)` is
\[
\begin{pmatrix}
3&4/\lambda\\
-3&3(1-j)/\lambda
\end{pmatrix},\qquad
\det=(j+1)/\lambda.                            \tag{2.2}
\]
Indeed the two powers of `P_t(V)` have total leading exponent 20, whose linear variation in `v_j` is zero in characteristic five. The derivative of `V-tV'` contributes `(1-j)v_j`.

The coefficient of `t` in the differential identity gives
\[
3h_1=2u(1-\lambda^{-1}),\qquad
h_1=4u(1-\lambda^{-1}).                         \tag{2.3}
\]
If `lambda != 1`, this is nonzero, so `s` is unramified at the pole.

If `lambda=1`, the constant series `h=V=1` solves (2.1). The matrices in orders one and two are invertible. They therefore force `h_1=h_2=0` in any such local solution. It would follow that `ord_t(s-xi)>=3`. That is impossible for the local ramification index of a separable map of degree two. Thus `lambda=1` is impossible as well.

We have proved that every common pole is unramified for the quadratic map, including the cases initially allowed to have `B(xi)=0`. Its residue with respect to `s-xi` is
\[
\rho_\xi=\xi h_1
=4u\left(\xi-\varepsilon^{-1}\xi^{-3}\right).    \tag{2.4}
\]
The residue for `x_2` is `epsilon xi^4 rho_xi`.

This is also a result of the earlier archive, where the local coefficient computations through order three were checked symbolically over `F_25(lambda)`. The short argument above makes the part needed here explicit without using the subsequent norm-degree argument.

## 3. Endpoint expansions and the finite endpoint set

### 3.1. Two terms at zero

At either zero point write
\[
x_1=\alpha+a s+b s^2+O(s^3),\qquad
s^3x_2=\ell+m s+O(s^2),\quad \ell\ne0.
\]
The first identity forces `A(alpha)=0`. The polynomials `A,A',P` are pairwise coprime where needed; these properties are checked by the preserved verifier. Comparing the first two coefficients gives
\[
a=\frac{A_4\varepsilon^{-4}\ell^4}{A'(\alpha)},\qquad
\frac ba=4\frac m\ell-\frac{A''(\alpha)}{2A'(\alpha)}a.        \tag{3.1}
\]
For the leading coefficient of the differential identity, `dx_2/dx_1` starts with `-3 ell a^{-1}s^{-4}`. As `(-3)^3=3`, we obtain
\[
\ell^{29}=c_{\rm end}\varepsilon^{29}H(\alpha),\qquad
c_{\rm end}=3/A_4^3=[14],\quad
H=A'^3P^2\bmod A=(3,21,7,14).                  \tag{3.2}
\]
For the next coefficient, the leading term of `P(x_2)^2` has exponent 20, so its linear relative correction is zero. The lower terms enter at least three orders later. The coefficient equation is
\[
2m/\ell-b/a+2(P'/P)(\alpha)a=0.
\]
Together with (3.1), this says
\[
\frac m\ell=F(\alpha)a,\qquad
F=P'/P-A''/A'.                                  \tag{3.3}
\]
Set `L=ell/epsilon`. Define the endpoint set
\[
\mathcal E=\{(\alpha,L): A(\alpha)=0,\quad
 L^{29}=c_{\rm end}H(\alpha)\}.                 \tag{3.4}
\]
For `e=(alpha,L)` define
\[
a(e)=J_a(\alpha)L^4,\quad
b(e)=J_b(\alpha)L^8,\quad
m(e)=J_m(\alpha)L^5,
\]
where, in `F_25[X]/(A)`,
\[
J_a=A_4/A',\qquad
J_b=\left(4F-\frac{A''}{2A'}\right)J_a^2,\qquad
J_m=FJ_a.                                      \tag{3.5}
\]
Then the actual endpoint expansion is
\[
x_1=\alpha+a(e)s+b(e)s^2+O(s^3),\qquad
s^3x_2=\varepsilon\bigl(L+m(e)s+O(s^2)\bigr).   \tag{3.6}
\]
The two zero points need not have distinct endpoint data. Repetition is retained throughout the proof and calculation.

### 3.2. Infinity

Replacing `(s,epsilon,x_1,x_2)` with `(1/s,epsilon^{-1},x_2,x_1)` preserves (1.1). Thus at either infinity point, for some `e=(alpha,L)` in the same set,
\[
x_2=\alpha+a(e)s^{-1}+b(e)s^{-2}+O(s^{-3}),
\]
\[
x_1=\varepsilon^{-1}\bigl(Ls^3+m(e)s^2+O(s)\bigr).         \tag{3.7}
\]
### 3.3. Exact endpoint coefficient certificate

The following ascending rows are recomputed from `P,A` by `src/verify_constants.py`:

| Element of `F_25[X]/(A)` | Row |
|---|---|
| `J_a` | `(0,21,5,21)` |
| `F` | `(16,11,4)` |
| `J_b` | `(0,1,10,6)` |
| `J_m` | `(2,11,4,4)` |

The polynomial `A` is irreducible of degree four over `F_25`. The verifier checks the degree-four Frobenius criterion, not a list of roots in a bounded field. Since `29` is coprime to `25^4-1`, the power map of exponent 29 on `F_{25^4}^*` is bijective. In fact
\[
29\cdot67349=1+5(25^4-1).
\]
A canonical root in `F_25[X]/(A)` is
\[
L_*(X)=(c_{\rm end}H(X))^{67349}\bmod A
=(21,19,20,22).                                 \tag{3.8}
\]
The coefficient values for this root are
\[
b_*(X)=J_b(X)L_*(X)^8=(1,3,8,15),\qquad
m_*(X)=J_m(X)L_*(X)^5=(22,7,9,23).               \tag{3.9}
\]
The verifier checks `L_*^29=c_end H mod A`, as well as every formula above.

Let `alpha_0` be a chosen root, `alpha_i=alpha_0^{25^i}` for `0<=i<4`, and let `zeta` be a primitive 29th root of unity. The **entire** endpoint set has 116 elements
\[
e_{i,a}=\bigl(\alpha_i,L_*(\alpha_i)\zeta^a\bigr),
\quad 0\le i<4,\quad0\le a<29.                 \tag{3.10}
\]
Their coefficient values are `b_*(alpha_i) zeta^{8a}` and `m_*(alpha_i) zeta^{5a}`. This parametrizes the geometric roots, not only roots discovered by a point scan.

## 4. Quadratic traces impose a moment identity

After Section 2, each value `xi` in `mu_29` has either zero, one, or two common-pole sheets. Denote this ordinary integer by `w_xi`, and its image in the prime field by the same symbol. Thus
\[
w_\xi\in\{0,1,2\},\qquad
S_j=\sum_{\xi\in\mu_{29}}w_\xi\xi^j.            \tag{4.1}
\]
Zero multiplicity means that the value is not a root of the minimal denominator. This description includes a regular second sheet at a one-sheet pole and includes both sheets when both are poles.

Let `Tr_2/2` denote average under the quadratic involution. By (2.4), its simple principal parts are
\[
\frac12\operatorname{Tr}_2(x_1)=H_1(s)+R_1(s),\quad \deg H_1\le3,
\]
\[
R_1=\chi\sum_{\xi\in\mu_{29}}
\frac{w_\xi(\xi-\varepsilon^{-1}\xi^{-3})}{s-\xi},
\]
\[
\frac12\operatorname{Tr}_2(x_2)=H_2(s)+R_2(s),
\quad H_2=h_0+h_1/s+h_2/s^2+h_3/s^3,
\]
\[
R_2=\chi\sum_{\xi\in\mu_{29}}
\frac{w_\xi(\varepsilon\xi^5-\xi)}{s-\xi}.       \tag{4.2}
\]
To see that these are the entire traces, subtract the displayed principal parts. The remaining rational function has only the indicated endpoint poles. Hence it is the indicated polynomial or Laurent polynomial. No assumption on the genus or the branch locus elsewhere is used.

Let the two zero endpoint data be `e_0,e_z`, and let the two infinity endpoint data be `e_f,e_g`. Put
\[
c=\tfrac12\bigl(b(e_0)+b(e_z)\bigr),\quad
 a=\tfrac12\bigl(m(e_0)+m(e_z)\bigr),
\]
\[
d=\tfrac12\bigl(b(e_f)+b(e_g)\bigr),\quad
 b=\tfrac12\bigl(m(e_f)+m(e_g)\bigr).            \tag{4.3}
\]
Here the standalone letters `a,b,c,d` refer only to these four endpoint averages, **not** to the numerator polynomials in the original model. This notation is local to Sections 4–9.

The coefficient of `s^2` in `R_1` at zero is
\[
-\chi(S_{-2}-\varepsilon^{-1}S_{-6}).
\]
By (3.6), the coefficient of the whole trace there is `c`. By (3.7), the coefficient of `s^2` in the polynomial `H_1` is `epsilon^{-1} b`. Equating gives
\[
\varepsilon(c+\chi S_{-2})=b+\chi S_{-6}.      \tag{4.4}
\]
For `R_2`, the coefficient of `s^{-2}` at infinity is `chi(epsilon S_6-S_2)`. The trace coefficient is `d`, whereas the coefficient of `s^{-2}` in `H_2`, read at zero, is `epsilon a`. Thus
\[
\varepsilon(a+\chi S_6)=d+\chi S_2.            \tag{4.5}
\]
Eliminate `epsilon` by cross multiplication, without dividing by either coefficient. Every model must satisfy
\[
(c+\chi S_{-2})(d+\chi S_2)
-(b+\chi S_{-6})(a+\chi S_6)=0.                \tag{4.6}
\]
Consequently no exceptional vanishing coefficient was discarded in this reduction. In particular, the forthcoming contradiction does not require determining a field of definition for `epsilon` or for the numerator coefficients.

## 5. The exact finite fields of the necessary data

The powers of five modulo 29 are
\[
1,5,25,9,16,22,23,28,24,4,20,13,7,6.
\]
They are distinct, with `5^7=-1 mod 29` and `5^14=1 mod 29`. Therefore `mu_29` lies in `F_{5^14}`, and every moment `S_j` lies in that field because all weights lie in `F_5`.

Let
\[
q=5^7=78125,\quad F=\mathbf F_q,\quad
C=\mathbf F_{q^2}=F(j),\quad j^2=2.
\]
The element 2 is a nonsquare in `F` since it is a nonsquare in `F_5` and the extension degree seven is odd. We take `beta=j+3`, which satisfies the required relation `beta^2=beta+3`.

The endpoint coefficients lie in
\[
E=\mathbf F_{5^{56}}=C(\alpha_0).
\]
Indeed `alpha_0` and the canonical `L_*(alpha_0)` lie in `F_{5^8}`, and the 29th roots lie in `F_{5^14}`. These fields have compositum of degree `lcm(8,14)=56`. The polynomial `A` remains irreducible of degree four over `C`, since `C/F_25` has degree seven, coprime to four. Thus
\[
1,j,\alpha_0,j\alpha_0,\alpha_0^2,j\alpha_0^2,
\alpha_0^3,j\alpha_0^3                           \tag{5.1}
\]
is an `F`-basis of `E`.

For actual moments, Frobenius of degree `q` gives
\[
S_{-2}=S_2^q,\qquad S_{-6}=S_6^q,
\]
because each weight is fixed and `xi^q=xi^{-1}`. Write
\[
S_2=t_0+jt_1,\quad S_6=v_0+jv_1,
\qquad t_0,t_1,v_0,v_1\in F.                  \tag{5.2}
\]
This restriction to `F^4` is a proved consequence of the pole multiplicities. It is **not** a restriction imposed on the unknown geometric model coefficients.

## 6. Endpoint normalization and exhaustive case count

There is no loss of generality in making the first zero endpoint `e_{0,0}`.

First apply a coefficient Frobenius automorphism of exponent `25^i`. It fixes `P,A` and sends the chosen root of `A` to `alpha_0`. It preserves the existence problem. The chosen endpoint parameter then differs from `L_*(alpha_0)` by a 29th root of unity.

Next replace
\[
s\longmapsto s_{\rm new}=\zeta^h s,\qquad
\varepsilon\longmapsto\varepsilon_{\rm new}=\zeta^{-4h}\varepsilon.
\]
Both identities (1.1) are preserved: the quartic scaling uses `-16=13 mod 29`, and the differential scaling uses `68+48=116=0 mod 29`. The finite pole values are permuted within `mu_29`, and all endpoint and pole conditions remain the same.

At zero, the normalized endpoint parameter `L` is multiplied by `zeta^{7h}`. Since seven is invertible modulo 29, choose `h` to remove the remaining root-of-unity factor. At infinity the corresponding factor is `zeta^{-7h}`; those endpoint choices remain unrestricted in our enumeration.

Index `e_{i,a}` by the integer `29i+a`, between 0 and 115. After this normalization the second zero endpoint can be any index `z`; the infinity pair can be any unordered pair `(f,g)`, with repetitions allowed. The number of cases is exactly
\[
116\binom{117}{2}=116\cdot6786=787176.           \tag{6.1}
\]
No case is removed on the basis of endpoint equality, field degree, genus, the choice of denominator, or the relationship between the sheets at the two ends.

## 7. Seven linear equations and one quadratic

Substitute (5.2) in (4.6). Since `chi=2[22]=3+3j`, we have
\[
\chi^2=2+3j.
\]
Define
\[
Q(t_0,t_1,v_0,v_1)=t_0^2-2t_1^2-v_0^2+2v_1^2.
\]
The moment equation is the following identity in `E`:
\[
cd-ab
+\chi(c+d)t_0+\chi j(c-d)t_1
-\chi(a+b)v_0+\chi j(a-b)v_1
+\chi^2 Q=0.                                   \tag{7.1}
\]
Let the constant term in (7.1) be `K=cd-ab`, and let its four linear coefficient vectors be
\[
C_0=\chi(c+d),\quad C_1=\chi j(c-d),\quad
C_2=-\chi(a+b),\quad C_3=\chi j(a-b).          \tag{7.2}
\]
For `y=sum_{i=0}^3 (y_{2i}+j y_{2i+1}) alpha_0^i`, define the `F`-linear projection
\[
\pi(y)=(y_2,y_3,y_4,y_5,y_6,y_7,\;3y_0-2y_1).
\]
Its kernel is exactly the one-dimensional space `chi^2 F`. Therefore (7.1) implies the seven linear equations
\[
\pi(C_0)t_0+\pi(C_1)t_1+\pi(C_2)v_0+\pi(C_3)v_1=-\pi(K).  \tag{7.3}
\]
Once these hold, the full residual lies in `chi^2 F`; its remaining scalar equation is quadratic. In particular, solving (7.3) and this scalar equation is equivalent to (7.1), not merely to its projection.

## 8. Exact classification of the finite necessary system

### 8.1. Numerical field representation

The certificate uses
\[
F=\mathbf F_5[T]/(T^7+T+1).
\]
An integer from 0 through 78124 encodes an ascending base-five coefficient vector of length seven. For instance code 9 is `T+4`. The implementations independently verify that this element traverses every nonzero residue exactly once in a cycle of length 78124. This also certifies that the quotient is a field: every nonzero residue is a power of a unit.

An element of `C` is a pair of such codes `(a,b)` meaning `a+bj`. The fixed primitive root is
\[
\zeta=(45685,35188).
\]
Its order 29 and its inverse-Frobenius relation are checked. An element of `E` is a row of four `C` coefficients modulo
\[
A/A_4=(5,2,6,7,1)
\]
in the original `F_25` coding. The embedding of a code `[a+5b]` into `C` is `(a+3b,b)`, with these two entries in the prime field.

`data/FORMATS.md` specifies all file formats and ordering conventions. The code requires no external field tables.

### 8.2. Linear inconsistency certificates

The finite classification is:

| Class | Number of normalized endpoint cases |
|---|---:|
| Inconsistent seven-equation linear system | 787146 |
| Consistent rank-four system | 1 |
| Consistent rank-three system | 29 |
| Any other consistent rank | 0 |
| Total | 787176 |

For every inconsistent case, the archive stores a seven-entry row `w` such that, for the augmented matrix `[M | r]` of (7.3),
\[
wM=0,\qquad wr=1.                              \tag{8.1}
\]
These identities are explicit inconsistency witnesses. The file `linear_witnesses.bin` stores one record for every endpoint case in the exact loop order of (6.1). Zero records occur precisely in the following 30 cases:
\[
(z,f,g)=(0,58,58),                              \tag{8.2}
\]
and
\[
(z,f,g)=(58,29+h,87+h),\qquad 0\le h<29.       \tag{8.3}
\]
Both the C++ checker and the independent Python checker verified all 787146 identities (8.1). They do not have to trust the generator's Gaussian elimination. The Python checker constructs the projected columns differently from the C++ implementation and checks the same certificates by direct multiplication.

### 8.3. The 30 consistent systems

For (8.2), rank is four and the unique solution is
\[
(t_0,t_1,v_0,v_1)=(1,0,1,0).
\]
Its full residual in (7.1) is `1+4j`, not zero. This case is excluded.

For each of (8.3), rank is three. `consistent_systems.json` supplies the complete augmented matrix, one particular solution, and a nonzero kernel vector. The checker verifies the rank, the particular solution, and the kernel dimension. Hence the displayed affine line is the **entire** solution set of the linear equations over `F`.

The scalar residual on each line is a nonzero quadratic. The file gives its three coefficients, its roots, and all resulting moment vectors. Completeness of each root list is independently checked as follows: a list of two distinct roots is checked by polynomial factorization; an empty list is checked by a nonsquare discriminant in `F`. Thus the verifier does not assume that an incomplete root list is exhaustive.

For example, the case `(58,29,87)` has `t_1=v_1=0`, `v_0=1`, and free parameter `t_0=h`. Its remaining equation is
\[
h^2+4h+2=0.
\]
The discriminant is 3, a nonsquare in `F_{5^7}`, so it contributes no roots.

Of the 29 quadratics, 21 have two roots and eight have no roots. They give **42** moment vectors in total. No positive-dimensional family remains after the scalar equation.

This exhausts every possible moment vector of any geometric model, because the necessary moments belong to `F^4` by Section 5. Roots of one of these quadratics in a larger field are irrelevant: they would fail that proved necessary moment-field condition.

## 9. Fourier inversion excludes all 42 moment vectors

The two Frobenius orbits
\[
\{2\cdot5^r\bmod29:0\le r<14\},\qquad
\{6\cdot5^r\bmod29:0\le r<14\}
\]
are disjoint and cover the 28 nonzero residues modulo 29. For actual prime-field pole weights, knowing `S_2,S_6` therefore determines every nonzero moment:
\[
S_{2\cdot5^r}=S_2^{5^r},\qquad
S_{6\cdot5^r}=S_6^{5^r}.                       \tag{9.1}
\]
For a candidate moment vector define
\[
b_i=29^{-1}\sum_{j=1}^{28}S_j\zeta^{-ij}
=4\sum_{j=1}^{28}S_j\zeta^{-ij},\quad 0\le i<29.           \tag{9.2}
\]
These belong to `F_5`, both by Frobenius invariance of the sum and by exact computation. The full Fourier inversion formula is
\[
w_{\zeta^i}=b_i+29^{-1}S_0=b_i+4S_0.           \tag{9.3}
\]
For completeness, Fourier inversion follows from
\[
\sum_{j=0}^{28}\zeta^{j(a-i)}=
\begin{cases}29,&a=i,\\0,&a\ne i.\end{cases}
\]
The nonzero value 29 is invertible in characteristic five. Thus no hypothesis about characteristic-zero cyclotomic fields is involved.

The unknown zeroth moment changes all 29 entries by the **same** prime-field scalar. In particular it does not change how many distinct entries the row contains.

The exact classification of the 42 rows (9.2), independently checked in Python, is:

| Number of distinct `F_5` entries in the row | Number of rows |
|---|---:|
| 4 | 7 |
| 5 | 35 |
| At most 3 | 0 |

Every row is stored in `consistent_systems.json`; the verifier reconstructs it from the moment vector and verifies each of its 29 entries.

But an actual pole-weight row has entries only in `{0,1,2}`. It can have at most three distinct residues. Adding the constant `4S_0` cannot turn any of the 42 rows into such a row. This contradicts (9.3).

This contradiction does not use the sum of the pole weights, a bound on `n`, the count of two-sheet poles, or the genus bound. It therefore excludes all models with the stated squarefree endpoint/pole profile, and in particular every degree from 8 through 23 left by the previous archive. **The theorem is proved.**

## 10. Coverage audit

The following possible losses of cases have been explicitly avoided.

* Quadratic ramification at a common pole was allowed at the start and excluded by the identities in Section 2. It was not removed by a condition imposed on `B` before analysis.
* A single used sheet and a regular second sheet contribute the integer weight one; two used sheets contribute two. Both are covered at every 29th root.
* Arbitrary geometric coefficients remain allowed. Only endpoint roots and integer pole moments are proved to lie in the finite fields used by the certificate.
* Equal endpoint data at the two zero points or at the two infinity points are included; the enumeration uses pairs with repetition.
* The scalar `epsilon` was eliminated by cross multiplication, not by an unjustified nonvanishing division.
* The finite endpoint normalization consists of symmetries preserving the equations and pole profile. No isomorphism of the original covers with a Galois cover was assumed.
* The zero record list in the large certificate is checked exhaustively. Every one of those records has its affine solution space and remaining quadratic checked separately.
* Root lists for the quadratics are certified as complete. The 42 Fourier rows are recomputed, not accepted as unverified data.

The proof uses the full quartic and differential identities, through their local consequences at the common poles and both ends. The additional ramification profile of `x_1` and the reconstruction implication are not needed once this necessary system is shown impossible. Consequently there is no positive model to reconstruct or omit.

## 11. Preserved results, additional reusable observations, and approaches not needed

### 11.1. Earlier work preserved

The previous archive's complete arguments remain available. They include centering by `K=[15]`, the first three common-pole jets, exclusion of common quadratic branch points, triple divisibility `D_2^3 | b,d,q`, the residual norm of degree 20, the degree-18 and degree-17 derivative polynomials, the endpoint annihilator/Bézout certificate, the bound `n<=23`, and the exact reduced existence problem that was then unresolved.

Their old verification was rerun successfully, including its own manifest. The source archive is retained byte for byte. The old open problem is now empty by Sections 2–9; none of the earlier proved reductions has been retracted.

### 11.2. Auxiliary trace rigidity

This is a reusable intermediate result, although the final proof does not need to divide by its coefficient.

For any pair of endpoint data, the average of their `b(e)` values does not belong to the cyclotomic field `C=F_{5^14}`. To prove this, put `K_4=F_{25^4}` and use the canonical value `b_*(alpha_0)` of (3.9). The three triples
\[
1,\ b_*(\alpha_0),\ b_*(\alpha_0)^{25^r},\qquad r=1,2,3
\]
have nonzero 3-by-3 minors with coded determinants `[8],[8],[19]`. Their exact matrices are stored in `endpoint_certificate.json` and checked by `verify_constants.py`.

The fields `K_4` and `C` are linearly disjoint over `F_25`, because their extension degrees four and seven are coprime. Thus those triples remain linearly independent over `C`. If the two endpoints have different `A`-roots, their two `b`-values, with their root-of-unity factors, cannot sum to an element of `C`.

If they have the same `A`-root, their sum is a nonzero `C`-multiple of one canonical `b`-value. The coefficient cannot vanish: it is a sum of two 29th roots of unity, and `-1` is not a 29th root of unity. The canonical `b`-value is not in `F_25`, as also follows from the minors. The same disjointness therefore excludes membership in `C`.

Consequently the coefficient `c+chi S_{-2}` in (4.4) is always nonzero. Before the final contradiction was found, this gave
\[
\varepsilon=\frac{b+\chi S_{-6}}{c+\chi S_{-2}}\in E.
\]
Moreover both rational quadratic traces are determined by the endpoint data, pole multiplicities, and this scalar. Their values and first two coefficients at one end, their highest pole coefficient at the other, and the prescribed simple principal parts determine all four free coefficients of `H_1` or `H_2`. The remaining subleading coefficient gives exactly (4.4) or (4.5).

### 11.3. Approaches that did not close the old problem

The residual norm and its first two derivative constraints gave the earlier bound 23 but not emptiness. Repeated local-uniqueness arguments cannot simply be continued: the old archive verifies that the order-four coefficient matrix has rank one and its compatibility obstruction vanishes. This limitation remains correctly recorded there.

A trace-based reduction to finitely many odd-part candidates of the quartic was considered during the continuation. No global sextic-factorization search was needed or used in the final proof. Instead, the two trace coefficient identities already yielded the complete endpoint/multiplicity obstruction above.

No positive-model search, no search over genera or individual denominators, and no global Gröbner-basis elimination is claimed. The only exhaustive new computation is the fully specified necessary endpoint/moment system, with geometric coverage proved beforehand.

## 12. Verification and dependencies

The main verification command is

```sh
python3 -B verify.py --manifest
```

It uses only the Python standard library and performs all of the following:

1. reruns the entire previous certificate and its manifest;
2. recomputes every endpoint coefficient and canonical field value from `P,A`;
3. independently constructs the fields used in the new certificate;
4. checks the ranks and complete affine solution spaces of all 30 exceptional systems;
5. certifies completeness of all quadratic root lists;
6. recomputes all 42 Fourier rows;
7. verifies every one of the 787146 left-null-vector inconsistency witnesses;
8. checks the cumulative SHA-256 manifest and file coverage.

The certificate was generated with C++17. A separate C++ checker also verified every linear witness without Gaussian elimination. Both C++ programs and the independent Python implementation are included. Tested versions are **CPython 3.13.5** and **g++ 14.2.0 (Debian 14.2.0-19)**. No Sage, Magma, SymPy, external databases, or network access is required for any delivered verification or certificate regeneration.

The exact executed logs are in `logs/`. This is an exact computer-assisted proof, not a proof-assistant formalization. The local-series, trace, finite-field coverage, and Fourier arguments are the mathematical justification for the certified finite calculation.

The original problem's reductions and reconstruction are retained in `INPUT.md` as established inputs, not newly certified claims about arbitrary étale correspondences. The new nonexistence proof itself needs only the normalized identities and pole conditions stated in Section 1.

A standard background reference for uniqueness in the local simple-root arguments retained from the earlier archive is the Stacks Project, *Henselian local rings*, tag `04GE`, especially Lemma 10.153.2. The new theorem and its finite classification are established here and are not attributed to that reference. The current continuation consulted `https://stacks.math.columbia.edu/tag/04GE`; no external result specific to this curve is used.

**Final conclusion:** the requested squarefree-denominator existence problem has no geometric solution. There is no remaining gap within that branch.

