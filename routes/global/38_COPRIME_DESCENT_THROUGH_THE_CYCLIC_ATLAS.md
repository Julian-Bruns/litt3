# Coprime descent through the cyclic atlas

## Status and purpose

**Status: proved.**  [Independent audit](audits/38_COPRIME_DESCENT_AUDIT.md).

This note strengthens the order-seven reduction in
file 29.  The intermediate curve produced there may still be chosen with a
finite-etale map to the particular cyclic curve

\[
             Y:\quad y^{31}=x(x-1),
\]

not merely with a map to the asymmetric triangle stack

\[
 S_0=\mathbf P^1_k(2,3,62).
\]

The point is a coprime-descent lemma.  A seven-group which preserves the
composite map to \(S_0\) must preserve successively its lifts through the
\(S_3\)-torsor \(S\to S_0\) and the \(\mu _{31}\)-torsor \(Y\to S\).  Thus
the reduction gives an exact etale diamond with equal horizontal degrees.

The last section records what the extra factorization remembers.  It gives
a finer three-divisor structure and a distinguished Tango differential, but
does not by itself make either structure intrinsic under the order-seven
automorphism.

Throughout, \(k=\overline{\mathbf F}_5\), and all curves and stacks are
connected unless otherwise stated.

## 1. Coprime descent of a chosen lift

### Lemma 38.1 (coprime torsor descent)

Let

\[
                         E\longrightarrow B
\]

be a torsor under a finite constant group \(H\).  Let a finite
\(\ell\)-group \(Q\) act on a connected reduced \(k\)-scheme \(W\), and let
\(u:W\to B\) be supplied with a \(Q\)-descent datum.  Suppose that
\(\ell\nmid |H|\).  Then every lift

\[
                         \widetilde u:W\longrightarrow E
\]

of \(u\) is \(Q\)-invariant, with its induced descent datum.  If the action
of \(Q\) on \(W\) is free, then \(\widetilde u\) descends to a map
\(W/Q\to E\).

The same statement holds for representable maps to Deligne--Mumford stacks
and for torsors in their etale topology.

#### Proof

Pulling the torsor back by \(u\) gives an \(H\)-torsor

\[
                         P=W\mathbin{\times_B}E\longrightarrow W.
\]

The descent datum on \(u\) induces a \(Q\)-linearization of \(P\), and that
linearization commutes with the right \(H\)-action.  The lift
\(\widetilde u\) is equivalently a section \(s\) of \(P\to W\).

After trivializing \(P\) by \(s\), the translate of \(s\) by any
\(g\in Q\) has the form

\[
                              g(s)=s\cdot h_g
\]

for a unique map \(h_g:W\to H\).  Since \(W\) is connected and reduced and
\(H\) is finite constant, \(h_g\) is constant.  The \(Q\)-action commutes
with the right \(H\)-action, so the cocycle rule says, up to the harmless
choice of left-versus-right convention, that

\[
                              g\longmapsto h_g
\]

is a homomorphism from \(Q\) to \(H\) (or to \(H^{\mathrm{op}}\)).  Its
image is an \(\ell\)-subgroup of \(H\), and is therefore trivial.  Hence
every \(h_g=1\), so \(s\), and equivalently \(\widetilde u\), is
\(Q\)-invariant.

When the action is free, \(W\to W/Q\) is a finite-etale \(Q\)-torsor.
Effective etale descent for morphisms gives the asserted descended lift.
The argument was expressed entirely in terms of a pulled-back torsor and
its section, so it applies unchanged in the stated stack setting.
\(\square\)

### Corollary 38.2 (a vertical seven-group is already vertical over \(Y\))

Put

\[
 S=\mathbf P^1_k(31,31,31),\qquad
 S_0=[S/S_3]=\mathbf P^1_k(2,3,62),
\]

and let

\[
              Y\xrightarrow{\tau}S\xrightarrow{\pi}S_0
\]

be the \(\mu _{31}\)-torsor and the \(S_3\)-torsor of files 10 and 14.
Suppose that \(a:W\to Y\) is finite etale and a seven-group \(Q\) acts
freely on \(W\).  Set

\[
                         q=\pi\tau a:W\longrightarrow S_0.
\]

If \(q\simeq qg\) for every \(g\in Q\), then \(a\) descends uniquely to a
finite-etale map

\[
                         \overline a:W/Q\longrightarrow Y.
                                                               \tag{38.1}
\]

In particular, every seven-subgroup of
\(\operatorname{Deck}(W/S_0)\) is contained in
\(\operatorname{Deck}(W/Y)\), for the displayed factorization of the map.

#### Proof

The 2-isomorphisms \(q\simeq qg\) are unique: \(q\) is dominant, \(W\) is
connected and reduced, and \(S_0\) has trivial generic inertia.  Their
identity and cocycle conditions are consequently automatic, so they give a
\(Q\)-descent datum on \(q\).

Apply Lemma 38.1 first to the \(S_3\)-torsor \(S\to S_0\).  Since
\(7\nmid6\), the chosen lift \(\tau a:W\to S\) is \(Q\)-invariant and
descends through \(W/Q\).  Apply the lemma again to the
\(\mu _{31}\)-torsor \(Y\to S\).  Since \(7\nmid31\), its chosen section
\(a:W\to Y\) is \(Q\)-invariant and descends to (38.1).

Finite etaleness is local for the finite-etale topology on the source, so
the descended map is finite etale.  Uniqueness follows from the
surjectivity of \(W\to W/Q\). \(\square\)

The second application is important.  Merely counting the thirty-one
sections of a pulled-back \(\mu _{31}\)-torsor would not suffice, because a
seven-group can have nontrivial orbits in a set of size thirty-one.  What
rules this out is that the action commutes with the simply transitive
\(\mu _{31}\)-action, so it is measured by a homomorphism
\(Q\to\mu _{31}\).

## 2. The strengthened common-cover reduction

### Theorem 38.3 (the equal-degree etale diamond)

Let

\[
 X:\quad v^2=x^7-x+1,
 \qquad
 Y:\quad y^{31}=x(x-1).
\]

If \(X\) and \(Y\) have a finite etale cover in common, then there are
smooth projective curves \(V,C\), an integer \(M\geq2\), and a diagram of
finite-etale maps

\[
 \begin{array}{ccc}
 V&\xrightarrow{\ a_V\ }&Y\\
 \big\downarrow&&\\[-2mm]
 C&\xrightarrow{}&X
 \end{array}
\]

with the following precise properties:

1. \(\deg(a_V)=\deg(C/X)=M\);
2. \(V\to C\) is a \(C_7\)-torsor, generated by a fixed-point-free
   automorphism \(\beta\) of \(V\);
3. if \(\rho:Y\to S_0\) is the degree-\(186\) atlas and
   \(q_V=\rho a_V\), then
   \[
                         q_V\not\simeq q_V\beta;
                                                               \tag{38.2}
   \]
4. equivalently, \(a_V\beta\ne a_V\); and
5. the genera are
   \[
                         g(V)=14M+1,\qquad g(C)=2M+1.
                                                               \tag{38.3}
   \]

Thus the remaining order-seven symmetry may be studied on an etale cover
of the explicit curve \(Y\), without losing the equal-degree relation to an
etale cover of \(X\).

#### Proof

Use the notation and construction of Theorem 29.3 and Corollary 29.4.
Thus \(W\to X\) is Galois with deck group \(G\), there is a finite-etale
map \(a:W\to Y\) of degree \(N\), and

\[
                              |G|=7N.
\]

Choose the subnormal series of a Sylow seven-subgroup used in Corollary
29.4,

\[
 1=P_0\triangleleft P_1\triangleleft\cdots\triangleleft P_r,
 \qquad P_{j+1}/P_j\simeq C_7,
\]

and let \(i\) be the first index at which
\(q=\rho a\) is invariant under \(P_i\) but not under \(P_{i+1}\).

Corollary 38.2 shows that \(a\), not only \(q\), descends through \(P_i\).
Put

\[
             V=W/P_i,\qquad C=W/P_{i+1},\qquad
             M=N/|P_i|.
\]

The descended map \(a_V:V\to Y\) has degree \(M\).  Since
\(P_i\triangleleft P_{i+1}\) and the quotient has order seven, the map
\(V\to C\) is a \(C_7\)-torsor.  A generator is the required \(\beta\),
and (38.2) is exactly the defining choice of \(i\).

Because \(P_{i+1}\leq G\), the quotient \(C=W/P_{i+1}\) maps finite
etale to \(W/G=X\), and

\[
 \deg(C/X)=[G:P_{i+1}]
 =\frac{7N}{7|P_i|}=M.
\]

If \(a_V\beta=a_V\), then its composite \(q_V\) would be invariant,
contradicting (38.2).  Conversely, if \(q_V\) were invariant, Corollary
38.2 applied to the group \(\langle\beta\rangle\) would make \(a_V\)
invariant.  This proves the equivalence in item 4.

Etale Riemann--Hurwitz gives

\[
 g(V)-1=M(g(Y)-1)=14M,
 \qquad
 g(C)-1=M(g(X)-1)=2M,
\]

which is (38.3).  Finally \(M=1\) would identify \(V\) with \(Y\), while
\(V\) would have an automorphism of order seven.  This contradicts
\(\operatorname{Aut}(Y)=C_{31}\times C_2\), proved in file 20.  Hence
\(M\geq2\). \(\square\)

### Corollary 38.4 (seven genuinely different maps to \(Y\))

In Theorem 38.3, the seven maps

\[
                    a_V,\ a_V\beta,\ldots,a_V\beta^6:V\to Y
\]

are pairwise distinct, even after postcomposition by automorphisms of
\(Y\).

#### Proof

If two maps in the list were equal, a nontrivial power of \(\beta\) would
preserve \(a_V\).  Since every nontrivial power generates \(C_7\), this
would contradict Theorem 38.3(4).

File 20 shows that every automorphism \(\gamma\) of \(Y\) preserves
\(\rho:Y\to S_0\) up to 2-isomorphism: its \(C_{31}\)-part is vertical over
\(S\), and its \(C_2\)-part induces a permutation of the three points of
\(S\), which disappears on passage to \(S_0=[S/S_3]\).  Therefore an
identity \(a_V\beta^j=\gamma a_V\beta^k\) would imply
\(q_V\beta^j\simeq q_V\beta^k\), again making a nontrivial power of
\(\beta\) preserve \(q_V\). \(\square\)

## 3. The extra ramification data retained on \(V\)

Let \(P_0,P_1,P_\infty\) be the three points of \(Y\) over
\(x=0,1,\infty\), and define reduced divisors of degree \(M\) on \(V\) by

\[
                         B_i=a_V^*P_i.
\]

Write again \(x,y\in k(V)\) for the functions pulled back from \(Y\).  Then

\[
\begin{aligned}
 \operatorname{div}(x)&=31(B_0-B_\infty),\\
 \operatorname{div}(x-1)&=31(B_1-B_\infty),\\
 \operatorname{div}(y)&=B_0+B_1-2B_\infty.              \tag{38.4}
\end{aligned}
\]

One may choose the coarse coordinate \(t\) on \(S_0\) so that

\[
 t=\frac{3(x^3+x^2+x+1)^2}{x^2(x-1)^2},
 \qquad
 t-1=\frac{3(x^2-x+1)^3}{x^2(x-1)^2}.                  \tag{38.5}
\]

Indeed, in characteristic five the identity behind (38.5) is

\[
 x^2(x-1)^2-2(x^2-x+1)^3
       =3(x^3+x^2+x+1)^2.
\]

Consequently, in the notation

\[
 t^*(0)=2A_2,\qquad t^*(1)=3A_3,
 \qquad t^*(\infty)=62A_{62},
\]

the factorization through \(Y\) gives the refinement

\[
\begin{aligned}
 A_2&=\operatorname{div}_0(x^3+x^2+x+1),& \deg A_2&=93M,\\
 A_3&=\operatorname{div}_0(x^2-x+1),& \deg A_3&=62M,\\
 A_{62}&=B_0+B_1+B_\infty,& \deg A_{62}&=3M.            \tag{38.6}
\end{aligned}
\]

The pullback of the differential used in the Tango calculation of file 28
has

\[
                  \operatorname{div}(dx)
                    =30B_0+30B_1-32B_\infty.            \tag{38.7}
\]

Thus

\[
 D_x=6B_0+6B_1-7B_\infty,
 \qquad \deg D_x=5M,
 \qquad \operatorname{div}(dx)=5D_x+3B_\infty.         \tag{38.8}
\]

Equations (38.4)--(38.8) are strictly more information than the bare
\((2,3,62)\) profile on \(V\to S_0\).  They provide three distinguished
degree-\(M\) divisors, a Kummer relation, and a degree-\(5M\) Tango line.

There is also a useful numerical warning.  Because \(\beta\) acts freely,
every \(\beta\)-invariant reduced divisor has degree divisible by seven.
Hence preservation by \(\beta\) of any one of

\[
 B_i,\quad A_{62},\quad A_2,\quad A_3+A_{62}
\]

forces \(7\mid M\): their degrees are respectively

\[
                         M,\quad3M,\quad93M,\quad65M,
\]

and none of \(1,3,93,65\) is divisible by seven.  In particular, when
\(7\nmid M\), the mod-five ramification coloring of file 36 cannot be
preserved merely for orbit-counting reasons.  Thus the retained
factorization does not formally force the missing coloring invariance.

## 4. A p-rank check and the precise remaining obstruction

For reference, the \(5\)-rank of \(Y\) is six.  In the hyperelliptic model

\[
                         v^2=1-y^{31},
\]

the Hasse--Witt matrix is obtained from

\[
                         (1-y^{31})^2=1+3y^{31}+y^{62}.
\]

With rows and columns indexed by \(1,\ldots,15\), its nonzero positions are

\[
 (1,5),(2,10),(3,15),(7,4),(8,9),(9,14),
 (13,3),(14,8),(15,13).
\]

Its stable image consists of the two three-cycles

\[
                         (3,13,15),\qquad(8,14,9),
\]

and therefore has dimension six.

For the \(C_7\)-torsor \(V\to C\), Hochschild--Serre gives

\[
 H^1_{\mathrm{et}}(C,\mathbf F_5)
    =H^1_{\mathrm{et}}(V,\mathbf F_5)^{C_7}.
\]

Since \(5\) has order six modulo seven, \(\Phi _7\) is irreducible over
\(\mathbf F_5\).  Semisimplicity of \(\mathbf F_5[C_7]\) consequently
gives only the congruence

\[
                         f(V)-f(C)\equiv0\pmod6,          \tag{38.9}
\]

where \(f\) denotes \(5\)-rank.  This is compatible with all genus and
degree identities in Theorem 38.3.  Moreover, as recalled in file 22,
ordinarity is not preserved by arbitrary finite-etale covers.  Thus
elementary \(p\)-rank comparison does not close the argument.

The exact remaining issue can now be stated without stacks.  One must rule
out a curve \(V\) with

* an etale degree-\(M\) map \(a_V:V\to Y\),
* a free automorphism \(\beta\) of order seven, and
* seven genuinely distinct maps \(a_V\beta^j:V\to Y\),

such that \(V/\langle\beta\rangle\) is an etale degree-\(M\) cover of
\(X\).  The data (38.4)--(38.8) are transported, not fixed, by \(\beta\).
To turn them into a contradiction one still needs a uniqueness theorem for
at least one of the following related kinds of distinguished structure:

1. the pulled-back Kummer pencil generated by \(x\);
2. the three divisors \(B_0,B_1,B_\infty\);
3. the exact-differential line \(k(V)^5dx\); or
4. the first Witt lift selected by the covering map.

Coprime torsor descent proves uniqueness under **actual** verticality over
\(S_0\).  It does not promote Frobenius-linear, Cartier, or Witt-level
compatibility to actual verticality.  That promotion is the remaining
structural bottleneck.
