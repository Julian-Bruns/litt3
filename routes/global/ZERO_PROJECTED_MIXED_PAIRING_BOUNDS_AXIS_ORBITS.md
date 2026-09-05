# Zero projected mixed pairing bounds an actual axis orbit

Date: 2026-09-05.
Proposed strengthening: `/root`; proof check and write-up:
`/root/canonical_trace_algebra`.
Status: complete author proof; not independently audited. No novelty claim.
No existing theorem, curve, or certificate is changed.

## 1. Statement: dimension at least two, without simplicity

Fix a smooth projective connected hyperbolic curve \(T\) over an
algebraically closed field \(k\), and a surjective homomorphism
\[
                      \rho:J_T\longrightarrow A,
                      \qquad \dim A\ge2.                       \tag{1.1}
\]
The abelian variety \(A\) need not be simple. Choose an Abel base
point, set
\[
             a=\rho\operatorname{AJ}_T:T\to A,
             \qquad D=a(T)_{\mathrm{red}},
\]
and choose a fixed very ample line bundle on \(A\). Put
\[
 \begin{split}
 e&=[k(T):k(D)]_{\mathrm{sep}},\qquad d=\deg D,\\
 K_D&=\{\eta\in A(k):D+\eta=D\},\\
 M&=e\max\{|K_D|,d^2\}.
 \end{split}                                                     \tag{1.2}
\]
The finiteness of \(K_D\), with no simplicity assumption, is proved
below. The embedding is fixed once and for all; \(M\) is independent
of every group and source map considered next.

Let finite groups \(H_1,H_2\) act through their product on a smooth
projective connected curve \(W\), and let \(r:W\to T\) be nonconstant.
Write \(u=a r\).
Assume the **point-valued** mixed identity
\[
 u(h_1h_2w)-u(h_1w)-u(h_2w)+u(w)=0
                      \qquad(h_i\in H_i,\ w\in W).             \tag{1.3}
\]

**Theorem.** At least one factor has a bounded orbit on the actual map:
\[
           [H_i:\operatorname{Stab}_{H_i}(r)]\le M
                         \quad\text{for some }i\in\{1,2\}.     \tag{1.4}
\]
If the product action is free and \(r\) is finite étale, the
normalization \(C_i\) of the joint image in
\((W/H_i)\times T\) has actual finite étale maps to both factors,
and
\[
                         \deg(C_i/(W/H_i))\le M.               \tag{1.5}
\]
Neither group orders nor \(\deg r\) occur in \(M\). The intermediate
in (1.5) is not asserted to be Galois, and bounded orbit is not
asserted to mean that a whole axis fixes \(r\).

## 2. When projected Jacobian vanishing gives the required zero pairing

Suppose initially only that
\[
 \rho r_*(h_{1*}-1)(h_{2*}-1)=0:J_W\longrightarrow A
                              \qquad(h_i\in H_i).              \tag{2.1}
\]
The left side of (1.3) is then constant by the Albanese universal
property. Denote this constant by \(c(h_1,h_2)\).
The commuting product action and telescoping show that
\[
                c:H_1^{\mathrm{ab}}\times H_2^{\mathrm{ab}}
                                      \longrightarrow A(k)     \tag{2.2}
\]
is biadditive. Its values generate a finite torsion subgroup; the
set of values itself need not be a subgroup.

Each value is killed by the orders of both corresponding elements
of the abelianizations. Therefore
\[
                  \gcd(|H_1^{\mathrm{ab}}|,
                       |H_2^{\mathrm{ab}}|)=1                  \tag{2.3}
\]
implies \(c=0\), which is precisely (1.3).
In particular, (2.3) holds when the group orders are coprime, or
when either factor is perfect. No division by group orders is
used, and the groups may have order divisible by the characteristic.

Without a condition killing \(c\), (2.1) alone is not an input to
the theorem proved here. In particular, a pair of same-prime
abelian factors does not satisfy (2.3) automatically.

## 3. The two elementary facts about the projected Abel curve

The curve \(D\) generates \(A\), since \(a\) induces the surjection
\(\rho\) on Jacobians. It contains \(0\) for the chosen Abel base
point and is not contained in a translate of a proper abelian
subvariety.

First, \(K_D\) is finite. If the translation stabilizer had a
positive-dimensional reduced identity component \(B\), then for
any \(x\in D\) one would have \(x+B\subset D\). Since \(D\) is a
curve, \(\dim B=1\) and \(D=x+B\). It could then generate at most
an elliptic abelian variety, contradicting \(\dim A\ge2\).
Thus the stabilizer scheme is zero-dimensional, and its group of
geometric points \(K_D\) is finite. No reducedness of the full
stabilizer scheme is needed.

Second, for every geometric point \(\eta\notin K_D\), the
difference fiber
\[
              \{(x,y)\in D\times D:x-y=\eta\}
\]
has at most \(d^2\) geometric points. The second projection
identifies this fiber with \(D\cap(D-\eta)\). These are distinct
integral projective curves, so the intersection is finite and
Bézout bounds its number of geometric points by \(d^2\).
Translation preserves numerical degree in the fixed embedding.
The same argument holds after any algebraically closed field
extension, in particular at geometric generic points below.

Finally, the generic geometric fibers of \(a:T\to D\) have exactly
\(e\) points. If \(a\) has an inseparable part, only its separable
degree is counted. The finitely many singular or exceptional
values of the curve map cause no problem for generic-point counts.

## 4. Proof by a single invariant difference

For \(b\in H_2\), define
\[
                    \delta_b(w)=u(bw)-u(w)\in D-D.
\]
By (1.3),
\[
                         \delta_b(h_1w)=\delta_b(w)
                                         \qquad(h_1\in H_1).  \tag{4.1}
\]

If every \(\delta_b\) is constant, each such constant lies in
\(K_D\), because \(u\) and \(u b\) both surject onto \(D\).
At a geometric generic point \(w\), the values \(u(bw)\) therefore
number at most \(|K_D|\). Each actual value is generic on \(D\)
and has at most \(e\) preimages under \(a\). Hence the values
\(r(bw)\), and thus the distinct maps \(r b\), number at most
\(e|K_D|\). This proves (1.4) for \(H_2\).

Otherwise choose \(b\) with \(\delta_b\) nonconstant. At a
geometric generic point \(w\), its value
\(\eta=\delta_b(w)\) avoids the finite set \(K_D\).
For every \(h_1\in H_1\), (4.1) places the ordered pair
\[
                         \bigl(u(bh_1w),u(h_1w)\bigr)
\]
in this **same** difference fiber. There are at most \(d^2\)
such geometric pairs. Thus \(u(h_1w)\) has at most \(d^2\)
values, and \(r(h_1w)\) has at most \(e d^2\) values.
Every actual value \(u(h_1w)\) is generic on \(D\), since each
\(u h_1\) is surjective, so the generic bound \(e\) applies
simultaneously. Distinct morphisms are distinguished at a geometric
generic point. Consequently
\[
                 [H_1:\operatorname{Stab}_{H_1}(r)]\le e d^2,
\]
which proves (1.4) in the other case.

This proof uses no bound for curves in the surface \(D-D\), no
translation stabilizer of that surface, and no assumption that
\(D-D\) is proper in \(A\). It therefore includes \(\dim A=2\).

## 5. The actual étale intermediate

For the factor supplied by (1.4), put
\(Q=\operatorname{Stab}_{H_i}(r)\). Galois correspondence gives
\[
                       k(W)^Q=k(W)^{H_i}\,r^*k(T).             \tag{5.1}
\]
Indeed the subgroup fixing that compositum is exactly the
stabilizer of the actual map \(r\). If the original action is not
effective, its kernel is contained in \(Q\) and the same equality
uses the effective quotient group.

Thus \(W/Q\) is the smooth normalization \(C_i\) of the joint
image, and its degree over \(W/H_i\) is \([H_i:Q]\).
When the action is free, both quotient maps out of \(W\) are
finite étale, as is the intermediate map \(C_i\to W/H_i\).
The descended map \(C_i\to T\) is an intermediate factor of
the actual finite étale map \(r\); separability and multiplicativity
of ramification indices make it finite étale. This proves (1.5).

## 6. The entire nonordinary quotient can be used

Over \(\overline{\mathbf F}_p\), let \(P_{\mathrm{mix}}\subset J_W\)
be generated by all images
\((h_{1*}-1)(h_{2*}-1)J_W\). If \(P_{\mathrm{mix}}\) is ordinary
and \(A\) has **no ordinary simple isogeny factor**, then
\[
                    \operatorname{Hom}(P_{\mathrm{mix}},A)=0.
\]
Indeed every quotient of an ordinary abelian variety is ordinary,
and a nonzero image in \(A\) would have an ordinary simple factor.
This gives (2.1). Under (2.3), the pairing also vanishes, so the
theorem applies as soon as \(\dim A\ge2\).

In particular one may take the quotient of \(J_T\) by its maximal
ordinary isotypic abelian subvariety, provided the remaining total
dimension is at least two. This permits a nonordinary simple
abelian surface, several nonordinary elliptic factors, or any
mixture of nonordinary simple factors of total dimension at least
two. Ordinary factors elsewhere in \(J_T\) do not prevent the
application. Merely saying that a nonsimple \(A\) is nonordinary
would not suffice: its ordinary simple factors must be absent.

This is the zero-pairing strengthening of
[the earlier one-simple-factor theorem](ONE_SIMPLE_FACTOR_CONTROLS_MIXED_ETALE_MAP_DESCENT.md).
It retains that theorem for nonzero projected pairing; it does not
extend the present proof to nonzero \(c\).
It also does not cover \(\dim A=1\), where the generating curve
\(D\) is the whole elliptic variety and \(K_D\) is infinite.

Projected mixed vanishing, its ordinary-mixed sufficient condition,
and any needed tower geometry remain actual hypotheses. This note
does not establish them from a common cover, does not turn a
bounded orbit into full axis descent, and makes no cofinality,
fixed-corner, or common-cover exclusion claim.
