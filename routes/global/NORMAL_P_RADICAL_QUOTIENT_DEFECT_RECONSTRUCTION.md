# Normal p-radicals and reconstruction of actual quotient defects

**Status:** author proof and bounded algebraic check, 2026-09-05.
**Author/checker:** canonical_trace_algebra.
**Scope:** normal \(p\)-subgroups need not be Sylow or complemented.
All geometric statements concern quotients of one actual finite Galois
étale cover; no module-realization assertion is made.

Use the notation and theorem of
[Projective Frobenius defect and non-Galois quotient tests](PROJECTIVE_FROBENIUS_DEFECT_AND_NONGALOIS_QUOTIENT_TESTS.md).
Thus \(W\to Y\) is a connected finite Galois étale cover with group \(G\),
\(k\) is algebraically closed of characteristic \(p\), and
\[
 N=H^1(W,\mathcal O_W)_{\mathrm{nil}},\qquad
 \Delta(C)=g(C)-f(C).
\]
Fix a normal \(p\)-subgroup \(P\triangleleft G\), and put
\[
 Q=G/P,\quad B=W/P,\quad \bar H=PH/P
 \quad(H\le G).
\]
In particular \(B\to Y\) is the actual \(Q\)-torsor.

## 1. Taking P-invariants retains every projective multiplicity

### Proposition 1

For every finite-dimensional projective \(kG\)-module \(M\), the norm
induces an isomorphism of \(kQ\)-modules
\[
 M_P\xrightarrow{\ \sim\ }M^P,\qquad
 [m]\longmapsto \sum_{x\in P}xm.
 \tag{1}
\]
The module \(M^P\) is projective over \(kQ\). If \(S\) is a simple
\(kQ\)-module, inflated to \(G\), then
\[
 P_G(S)^P\simeq P_Q(S).
 \tag{2}
\]
Consequently taking \(P\)-invariants gives a bijection on isomorphism
classes of finite projective modules. It does not forget their
indecomposable-projective multiplicities.

### Proof

Every projective \(kG\)-module restricts to a free \(kP\)-module.
For \(kP\) the norm identifies its one-dimensional coinvariants and
invariants, and hence does so for every free module. Normality makes
this identification \(Q\)-equivariant. Coinvariants of a summand of
\((kG)^a\) are a summand of \((kQ)^a\), proving projectivity.

All simple \(kG\)-modules are trivial on \(P\): a nonzero simple module
has nonzero \(P\)-invariants, which form a \(G\)-submodule. Equivalently,
the ideal \(I=\ker(kG\to kQ)\) is nilpotent and lies in
\(\operatorname{rad}(kG)\). Quotienting a projective cover \(P_G(S)\)
by \(I P_G(S)\) leaves its simple top equal to \(S\), and gives a
projective \(kQ\)-module. It must therefore be \(P_Q(S)\). Together
with (1), this proves (2) and the assertion on multiplicities.
\(\square\)

In our geometric situation, the main quotient theorem gives a natural
Frobenius-compatible identification
\[
 \bar N:=H^1(B,\mathcal O_B)_{\mathrm{nil}}\simeq N^P.
\]
Thus, with the same nonnegative integers \(m_S\),
\[
 N=\bigoplus_S P_G(S)^{m_S},\qquad
 \bar N=\bigoplus_S P_Q(S)^{m_S},
\]
and for every actual intermediate curve \(W/H\),
\[
 \boxed{\Delta(W/H)=\sum_S m_S[k[G/H]:\operatorname{Inf}_Q^G S].}
 \tag{3}
\]
The normal-subgroup quotient and projective-module filtration are standard
modular algebra; a primary reference is
[MacQuarrie–Symonds, *Brauer Theory for Profinite Groups*, §7,
especially Lemmas 7.1–7.3](https://arxiv.org/pdf/1301.5625).
The argument above specifies the exact invariant-module consequence needed
here, rather than inferring it just from a dimension formula.

The full semilinear operator is a different matter. For example, on
\(kC_p\), zero Frobenius and the semilinear map
\[
 F(m)=(g-1)m^{[p]}
\]
(coefficientwise \(p\)-th power) both restrict to zero on invariants,
but have different ranks. They are nilpotent and commute with \(C_p\).
This is only a formal module example. Thus Proposition 1 reconstructs
the projective module, not all Frobenius dynamics.

## 2. A positive formula whenever the normal extension splits

### Theorem 2

Suppose \(G=P\rtimes Q_0\), where \(Q_0\simeq Q\). No hypothesis
\(p\nmid |Q_0|\) is imposed. For representatives
\(g\in Q_0\backslash G/H\), set
\[
 K_g=Q_0\cap gHg^{-1}\le Q_0\simeq Q.
\]
Then
\[
 \boxed{\Delta(W/H)=
       \sum_{g\in Q_0\backslash G/H}\Delta(B/K_g).}
 \tag{4}
\]
Equivalently, group the terms by \(Q\)-conjugacy classes of subgroups:
the coefficient of \(\Delta(B/K)\) is the number of \(Q_0\)-orbits
on \(G/H\) whose stabilizer is conjugate to \(K\).

### Proof

Restriction to \(Q_0\) takes every simple inflated \(kG\)-module \(S\)
to the corresponding simple \(kQ_0\)-module. It therefore preserves
the relevant composition multiplicities. Mackey's permutation-set
decomposition gives
\[
 \operatorname{Res}_{Q_0}^G k[G/H]
 \simeq \bigoplus_{g\in Q_0\backslash G/H} k[Q_0/K_g].
 \tag{5}
\]
Insert (5) in (3), and use the quotient-defect formula for the
actual \(Q\)-torsor \(B\to Y\). This gives (4).
\(\square\)

In particular, all the curves \(B/K_g\) ordinary imply \(W/H\)
ordinary, and conversely (4) makes each of them ordinary if \(W/H\)
is ordinary. The action of \(P\) on \(G/H\) need not be free.
Every test curve has degree at most \(|Q|\) over \(Y\), regardless of
the size of \(P\). This extends the normal-Sylow case to arbitrary
split normal \(p\)-radicals, including \(p\mid |Q|\).

This does not assert those test curves are ordinary, nor that a normal
\(p\)-subgroup always has a complement. Both the subgroup stabilizers
and their actual intermediate curves remain part of the test.

## 3. Exact reconstruction without a complement

A rational formula using only quotients of \(B\) exists for every
normal \(P\), without any splitting hypothesis.

Let \(\mathcal C\) be representatives of the \(Q\)-conjugacy classes
of cyclic \(p'\)-subgroups, including the trivial subgroup. For
\(C,D\in\mathcal C\), form the integer matrix
\[
 A_{C,D}=\left|(Q/D)^C\right|.
 \tag{6}
\]
Order these subgroups by decreasing size, refining arbitrarily.
The matrix is triangular: \(A_{C,D}\ne0\) implies that \(C\) is
conjugate to a subgroup of \(D\), and
\[
 A_{C,C}=|N_Q(C):C|>0.
 \tag{7}
\]
Thus \(A\) is invertible over \(\mathbb Q\).

For each \(C\), choose a subgroup \(\widetilde C\le G\) mapping
isomorphically to \(C\). Such lifts exist by Schur–Zassenhaus in
the inverse image of \(C\), and are conjugate by \(P\). Consequently
\[
 u_C=\left|(G/H)^{\widetilde C}\right|
 \tag{8}
\]
is independent of the choice. Define explicitly
\[
 (a_D)_{D\in\mathcal C}=A^{-1}(u_C)_{C\in\mathcal C}.
 \tag{9}
\]
Then the exact formula is
\[
 \boxed{\Delta(W/H)=\sum_{D\in\mathcal C}a_D\,\Delta(B/D).}
 \tag{10}
\]
Denominators may be cleared. No positivity of the \(a_D\) is asserted.

### Proof

Every \(p'\)-element of \(G\) projects injectively on its cyclic
subgroup in \(Q\). Lifts of a fixed cyclic \(p'\)-subgroup are
\(P\)-conjugate. The Brauer character of the permutation module
\(k[G/H]\), viewed through the simple-module bijection with \(Q\),
therefore has value \(u_C\) at a generator of \(C\).
The Brauer character of \(k[Q/D]\) there is \(A_{C,D}\).

These values suffice on every \(p\)-regular element: permutation
characters are constant on generators of a given cyclic subgroup.
Equation (9), and independence of irreducible Brauer characters,
therefore give the identity of rationalized Grothendieck groups
\[
 [k[G/H]]
 =\sum_D a_D[\operatorname{Inf}_Q^G k[Q/D]].
 \tag{11}
\]
Pair (11) with the projective multiplicities \(m_S\) in (3).
This proves (10).
\(\square\)

For an ordinarity test, it even suffices that the actual \(B/D\)
with \(a_D>0\) are ordinary: the remaining terms in (10) are
nonpositive, whereas its left side is nonnegative. This observation
does not ensure a useful smaller collection: the positive support
can include \(D=1\), requiring \(B\) itself ordinary.

### How the P-orbits enter the exact coefficients

The projection \(G/H\to Q/\bar H\) is its set of \(P\)-orbits;
every fiber has size \([P:P\cap H]\). For a fixed \(C\), sum (8)
over the \(C\)-fixed base points. In each such fiber, choose a
representative \(xH\) fixed by \(\widetilde C\); one exists by
conjugacy of complements in the relevant group with normal
\(p\)-subgroup. Put \(R_x=P\cap xHx^{-1}\). The coprime
fixed-coset lemma gives
\[
 \left|(P/R_x)^{\widetilde C}\right|
 =|C_P(\widetilde C):C_{R_x}(\widetilde C)|.
 \tag{12}
\]
Indeed, a fixed coset defines a cocycle in \(R_x\), and
\(H^1(\widetilde C,R_x)=1\) by conjugacy of complements; it can be
represented by an element centralizing \(\widetilde C\).
Thus
\[
 u_C=\sum_{x\bar H\in(Q/\bar H)^C}
       |C_P(\widetilde C):C_{R_x}(\widetilde C)|,
 \tag{13}
\]
with the fixed representatives just specified. Formula (13) explains
why the common fiber size alone is insufficient: the coprime
stabilizer action on each fiber matters.

## 4. Small exact tests and limitations

For a non-Sylow, nonfree-action test, take \(G=S_4\), \(p=2\),
\(P=V_4\), and the complement \(Q_0=S_3\) fixing one letter.
If \(H\) is generated by a four-cycle, then \(H\) is corefree,
\(|P\cap H|=2\), and \(Q_0\) acts freely and transitively on the
six cosets \(G/H\). Hence (4) gives
\[
                    \Delta(W/H)=\Delta(W/V_4).
\]
For \(H=C_3\), the \(Q_0\)-orbit sizes are instead \(2,6\), giving
\(\Delta(W/H)=\Delta(B/C_3)+\Delta(B)\).
Enumeration of all 24 permutations verified both orbit decompositions.
These are conditional identities for actual covers.

For \(G=S_3\), \(p=3\), \(P=C_3\), and \(H=C_2\), the three-point
permutation module has composition factors
\[
 [k[G/H]]=2[\mathbf1]+[\mathrm{sgn}].
 \tag{14}
\]
Indeed the constant line lies inside the augmentation plane in
characteristic three; the plane modulo that line is the sign
representation, and the final quotient is trivial. The complement
\(C_2\) has one orbit of size one and one of size two on the three
points. Consequently (4) reads
\[
 \Delta(W/H)=\Delta(Y)+\Delta(B),\qquad B=W/C_3.
 \tag{15}
\]
It is not the formula \(3\Delta(Y)\) suggested by just multiplying
the single \(P\)-orbit by its size. This is a conditional identity
for an actual \(S_3\)-cover, not a realization assertion.

The rational reconstruction genuinely permits negative coefficients,
even in a small quotient group. For \(Q=S_3\) in characteristic
three, its cyclic \(p'\)-subgroups are \(1,C_2\), and
\[
 [\mathbf1]=[k[Q/C_2]]-\tfrac13[kQ]
 \quad\text{in }G_0(kQ)\otimes\mathbb Q.
 \tag{16}
\]
This follows from (14) and
\([kQ]=3[\mathbf1]+3[\mathrm{sgn}]\). It also follows directly
from (6)–(9). Thus the general reconstruction is not automatically
a positive Mackey sum.

The resulting reduction is exact but limited: for fixed \(Q\), the
entire quotient library \(B/D\) has degrees bounded independently
of \(|P|\), while the multiplicities or rational coefficients retain
the actual \(G/H\)-action. Neither the abstract quotient group nor
the sizes of its \(P\)-orbits by themselves determine the answer.
No assertion about an unrelated replacement for \(W/H\), automatic
ordinarity of the bounded library, or geometric realization is used.
