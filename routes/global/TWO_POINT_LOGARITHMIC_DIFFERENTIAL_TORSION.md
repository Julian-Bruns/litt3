# Logarithmic-differential torsion for a two-point wild orbifold

**Status:** Sections 1–2 independently audited **PASS**, 2026-09-05.
Auditor: `/root/canonical_trace_algebra`. The parameterized theorem and
actual connected Kummer-cover argument were checked. The later fixed-model
corollaries are outside this audit's scope.
[Audit record](audits/ALL_DEGREE_COMMON_ORBIFOLD_BOUND_AND_LOGARITHMIC_TORSION_AUDIT.md).

The main theorem is parameterized. The final two corollaries retain the actual fixed curves
of file 76.  This gives necessary conditions for a finite common orbifold;
it does not address coreless common covers or assert realization of the
remaining local signatures.

## 1. Parameterized theorem

Let `k` be algebraically closed of characteristic `p`, and let `C` be a
smooth projective curve of genus at least two.  Suppose a separable map

\[
                         f:C\longrightarrow\mathbf P^1
\]

is the coarse map of a representable finite etale atlas of an effective
orbifold with exactly two stacky points.  Choose a coordinate `v` whose
zero is the tame point and whose pole is the wild point.  Assume the local
data are

\[
\begin{array}{c|c|c}
 &\text{inertia order}&\text{different exponent}\\ \hline
\text{wild}&RtP&RtP-1+\epsilon\\
\text{tame}&t&t-1,
\end{array}                                                \tag{1.1}
\]

where `P` is a positive power of `p`, both `R` and `t` are prime to `p`,
and

\[
                         \epsilon=RP+c,\qquad c>1.      \tag{1.2}
\]

Let `E` and `F` be the reduced wild and tame fibers.  Thus

\[
 f^*(\infty)=RtP E,\qquad f^*(0)=tF.                   \tag{1.3}
\]

### Theorem 1

Put

\[
                 \mathcal L=\mathcal O_C(F-RP E)\in J(C).
                                                               \tag{1.4}
\]

Then

\[
 \boxed{
 \mathcal L^{\otimes t}\simeq\mathcal O_C,qquad
 \omega_C\simeq
 \mathcal O_C((c-1)E)\otimes\mathcal L^{-1},qquad
 \deg E=\frac{2g(C)-2}{c-1}.}                           \tag{1.5}
\]

In addition, the rational `t`-differential

\[
              \Psi=(v\circ f)\,\eta^{\otimes t}          \tag{1.5a}
\]

is holomorphic and has

\[
                         \operatorname{div}(\Psi)
                              =(c-1)tE.                   \tag{1.5b}
\]

If `C` is ordinary, then `L` is nontrivial.

More generally, if a divisor `B` satisfies

\[
                         \omega_C\simeq\mathcal O_C((c-1)B),
                                                               \tag{1.6}
\]

then the degree-zero class

\[
                              D=[E-B]\in J(C)             \tag{1.7}
\]

satisfies

\[
                 (c-1)D=\mathcal L,qquad
                 (c-1)tD=0.                              \tag{1.8}
\]

For ordinary `C`, the first class in (1.8) is nonzero.

### Proof

Put `n=deg(f)`.  The reduced fiber degrees are

\[
                         \deg E=\frac n{RtP},qquad
                         \deg F=\frac nt.                 \tag{1.9}
\]

Riemann--Hurwitz and (1.1)--(1.2) give

\[
\begin{aligned}
2g(C)-2
 &=n\left[-2+
  \frac{RtP-1+RP+c}{RtP}+\frac{t-1}{t}\right]\\
 &=\frac n{RtP}(c-1)=(c-1)\deg E.                        \tag{1.10}
\end{aligned}

Moreover,

\[
 \operatorname{div}(v\circ f)=tF-RtP E=t(F-RP E),       \tag{1.11}
\]

which proves that `L` has degree zero and is killed by `t`.

Now consider the rational logarithmic differential

\[
                   \eta=\frac1t\frac{d(v\circ f)}{v\circ f}.
                                                               \tag{1.12}
\]

The pullback of `dv` has orders

\[
 RP+c-1-RtP\quad\text{along }E,qquad
 t-1\quad\text{along }F.                                \tag{1.13}
\]

Subtracting the divisor (1.11) therefore gives the exact divisor

\[
                         \operatorname{div}(\eta)
                              =(RP+c-1)E-F.               \tag{1.14}
\]

Adding (1.11) to `t` times (1.14) gives (1.5b), including
holomorphicity of `Psi`.

Consequently

\[
 [\omega_C]=(RP+c-1)[E]-[F]
             =(c-1)[E]-\mathcal L,                       \tag{1.15}
\]

which is the middle assertion of (1.5).  Its degree is (1.10).

Suppose now that `C` is ordinary and `L` is trivial.  Choose
`h` in `k(C)^*` with

\[
                         \operatorname{div}(h)=F-RP E.
\]

Equation (1.11) and algebraic closedness of `k` give
`v o f = lambda h^t` for a constant `lambda`.  Therefore

\[
                         \eta=\frac{dh}{h},qquad
                         \operatorname{div}(dh)=(c-1)E.  \tag{1.16}
\]

The differential `dh` is nonzero because `d(v o f)` is nonzero and
`p` does not divide `t`.  Thus (1.16) is a nonzero exact holomorphic
differential.  Cartier kills it, contradicting ordinarity.  Hence `L` is
nontrivial.  Finally, (1.6) and (1.15) give (1.8).  \(\square\)

## 2. What the possibly disconnected Kummer equation really gives

The equation

\[
                         u^t=v\circ f                  \tag{2.1}
\]

defines a finite etale Kummer scheme over `C`, because all valuations in
(1.11) are divisible by `t`.  It need not be connected.  Let

\[
                         s=\operatorname{ord}(\mathcal L)\mid t.
                                                               \tag{2.2}
\]

Then (2.1) has `t/s` components, each a connected cyclic etale cover of
degree `s`.  On a component one may write

\[
                         u^s=a,\qquad
                         \operatorname{div}(a)=s(F-RP E).
                                                               \tag{2.3}
\]

If `pi:C_s -> C` denotes this component, direct differentiation using
(1.12) gives the simpler identity

\[
                         du=u\,\pi^*\eta,
 \qquad
                         \operatorname{div}(u)=\pi^*(F-RP E).
\]

It follows that

\[
                         \operatorname{div}(du)
                              =(c-1)\pi^*E.               \tag{2.4}
\]

Thus `du` is a nonzero exact holomorphic differential on `C_s`.  If
`s=1`, this is the contradiction on the original ordinary curve used in
Theorem 1.  If `s>1`, it only says that the etale cover `C_s` is
nonordinary; prime-to-`p` etale covers of an ordinary curve need not be
ordinary.  Hence ordinarity forces

\[
                              s>1,                       \tag{2.5}
\]

but it does **not** force `s=t`.  This is the exact connectedness boundary
of the Kummer argument.

In particular, the profile forces a connected cyclic etale cover of `C`
of some degree `s|t` carrying a nonzero exact holomorphic differential.
That cover is nonordinary.  Therefore the profile is impossible whenever
`C` is ordinary and all of its connected cyclic etale covers of every
degree dividing `t` are ordinary.  This statement concerns only the
finitely many divisors of `t`; it does not assume ordinarity is generally
preserved by prime-to-`p` covers.

## 3. The fixed ordinary hyperelliptic genus-twenty-five curve

For the three residual rows of
[`TWO_POINT_NONWEAK_ORBIFOLD_LOCAL_REDUCTION.md`](TWO_POINT_NONWEAK_ORBIFOLD_LOCAL_REDUCTION.md),
the data on the actual fixed curve `Y` are

\[
 R=3,\qquad c=9,\qquad t\in\{2,4,8\},\qquad g(Y)=25.  \tag{3.1}
\]

The reduced wild fiber `E_Y` has degree six.  If `H` denotes a fiber of
the hyperelliptic map, then

\[
                  \omega_Y\simeq\mathcal O_Y(24H)
                         =\mathcal O_Y(8(3H)).           \tag{3.2}
\]

Put

\[
                         D_Y=[E_Y-3H]\in J(Y).           \tag{3.3}
\]

Theorem 1 gives

\[
                         8D_Y=\mathcal L_Y\ne0,qquad
                         \mathcal L_Y\in J(Y)[t].        \tag{3.4}
\]

If `s=ord(L_Y)`, then `s>1` and `s|t`.  Since `s` and `t` are powers of
two, (3.4) forces

\[
 \boxed{
  \operatorname{ord}(D_Y)=8s\in\{16,32,64\}.}           \tag{3.5}
\]

More precisely, `t=2` forces order 16; `t=4` allows orders 16 or 32; and
`t=8` allows orders 16, 32, or 64.  This condition is independent of the
unbounded wild order `P`.

Equivalently, one of the connected cyclic etale covers of this fixed `Y`
of degree `2`, `4`, or `8` (as allowed by the chosen `t`) must be
nonordinary, and its defining torsion class is exactly `L_Y`.

## 4. The simultaneous constraint on the fixed genus-nine curve

The same hypothetical orbifold map has degree `6Pt` on the fixed curve
`X`, so its reduced wild fiber `E_X` has degree two.  On the superelliptic
model of file 76, let `infinity` be its unique point at infinity.  One has

\[
                         \omega_X\simeq\mathcal O_X(16\,\mathord\infty)
                                  =\mathcal O_X(8(2\,\mathord\infty)).
                                                               \tag{4.1}
\]

Thus

\[
 D_X=[E_X-2\,\mathord\infty],qquad
 8D_X=\mathcal L_X,qquad 8tD_X=0.                       \tag{4.2}
\]

The Weierstrass semigroup at infinity is exactly the numerical semigroup
generated by 3 and 10.  Indeed `x` and `y` have pole orders 3 and 10,
and this semigroup already has genus nine.  Because `E_X` is reduced,
the assertions `D_X=0`, `2D_X=0`, and `4D_X=0` would produce a
nonconstant function whose sole pole at infinity has order respectively
in `{1,2}`, `{2,4}`, or `{4,8}`, depending on whether infinity belongs
to `E_X`.  All these integers are gaps of `<3,10>`.  Hence

\[
 \boxed{
   \operatorname{ord}(D_X)\in\{8,16,32,64\}.}            \tag{4.3}
\]

Unlike `Y`, the curve `X` is not ordinary, so this argument does not
exclude `L_X=0`; order eight remains possible.

If `Z` is an actual common refinement over this orbifold (for example, a
connected component of `X times_S Y`), with etale maps
`rho_X:Z -> X` and `rho_Y:Z -> Y`, let `E_Z` be the reduced divisor over
the wild stacky point.  Etale pullback preserves reduced fibers, and the
two composites to the orbifold agree.  Hence the fiber divisors used above
are not unrelated choices: they satisfy

\[
                         \rho_X^*E_X=E_Z=\rho_Y^*E_Y.    \tag{4.4}
\]

## Scope

The theorem converts the unbounded wild-group parameter into fixed
low-order torsion conditions on the actual Jacobians and on the actual
wild fiber divisors.  It does not by itself show that no such divisors
exist.  Connectedness of the full degree-`t` Kummer equation must not be
assumed: the exact invariant is the possibly proper divisor
`s=ord(L_Y)` of `t`.
