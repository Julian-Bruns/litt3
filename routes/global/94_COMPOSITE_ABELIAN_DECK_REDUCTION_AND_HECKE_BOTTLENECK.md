# Composite abelian deck groups: the exact normalizer and Hecke bottleneck

**Status: proved below; author self-check PASS, 2026-09-04.**

This note tests whether file 92 extends from abelian prime-power deck
groups to arbitrary finite abelian deck groups.  It does not prove that
extension.  Instead it gives a rigid reduction of every possible failure:
the bottom of the subgroup lattice is forced, the prime-to-\(p\) part is a
fixed-point-free Fitting subgroup, and simplicity leaves exactly one
rank-one rational Hecke packet of sharply bounded degree.  The two smallest
simple-group envelopes satisfying the raw normalizer conditions are then
excluded uniformly.

All curves are smooth, projective, and connected over an algebraically
closed field \(k\).  Fix an odd prime \(p\), possibly equal to
\(\operatorname{char}k\), and assume

\[
 g(X)=g\ge2,\qquad J(X)\text{ is simple},\qquad
 \operatorname{Aut}(X)=C_p,\qquad X/C_p\simeq\mathbf P^1.       \tag{94.1}
\]

Let \(\mathcal B\) be the reduced branch set of \(X\to\mathbf P^1\), and
assume

\[
 \operatorname{Stab}_{\operatorname{PGL}_2(k)}(\mathcal B)=1.  \tag{94.2}
\]

Let \(D\to X\) be a connected finite etale Galois cover with arbitrary
finite abelian deck group \(H\), and put

\[
 A=\operatorname{Aut}(D),\qquad N=N_A(H).
\]

## 1. The bottom interval is forced

We first isolate the part of file 91 which applies inside any finite
subgroup of \(\operatorname{Aut}(D)\).

### Lemma 94.1 (no self-normalizing minimal overgroup)

There is no subgroup \(M\le A\) such that

\[
 H<M,\qquad H\text{ is maximal in }M,\qquad N_M(H)=H.           \tag{94.3}
\]

#### Proof

The nontrivial map \(D/H=X\to D/M\), together with simplicity of \(J(X)\),
forces \(D/M\simeq\mathbf P^1\): a positive-genus quotient would pull back
to a nonzero abelian subvariety of \(J(X)\), and Riemann--Hurwitz then rules
out the resulting equality of genera.

Put \(C=\operatorname{Core}_M(H)\), \(G=M/C\), and \(B=H/C\).  The coset
action of \(G\) is faithful and primitive, and its abelian point stabilizer
\(B\) is self-normalizing.  If \(1\ne c\in B\cap B^u\), with \(u\notin B\),
then

\[
 \langle B,B^u\rangle\le C_G(c).
\]

Maximality of \(B\) makes the left side all of \(G\), so \(c\) is central.
A central element fixing a point in a faithful transitive action is trivial.
Thus the action is Frobenius.

Let \(K\triangleleft G\) be its Frobenius kernel and let \(\widetilde K\)
be the inverse image in \(M\).  Since \(C\subseteq H\) acts freely on
\(D\), every geometric point stabilizer injects into \(G\).  A nonidentity
element in its image cannot fix a coset: it would then belong to a conjugate
of the free group \(H\).  It is therefore a derangement and lies in \(K\).
Hence

\[
 D/\widetilde K\longrightarrow D/M\simeq\mathbf P^1
\]

is a nontrivial connected finite etale cover, impossible.  This is the
minimal-overgroup argument of file 91, stated in the relative form needed
here. \(\square\)

### Theorem 94.2 (unique atom and self-normalizing first layer)

If \(A>H\), then

\[
 N/H=C_p,\qquad D/N\simeq\mathbf P^1,\qquad N_A(N)=N.           \tag{94.4}
\]

Moreover, every subgroup \(K\) with \(H<K\le A\) contains \(N\).
Equivalently, \(N\) is the unique minimal overgroup of \(H\) in \(A\).

#### Proof

The usual descent map is injective:

\[
 N_A(H)/H\hookrightarrow\operatorname{Aut}(X)=C_p.             \tag{94.5}
\]

If \(N=H\), Theorem 91.1 (or its proof, which is Lemma 94.1) gives
\(A=H\).  Thus \(A>H\) implies \(N/H=C_p\), and then
\(D/N=X/C_p=\mathbf P^1\).

Because \(D\to X\) is etale, the reduced branch set of the \(N\)-quotient
is exactly \(\mathcal B\).  The group \(N_A(N)/N\) acts faithfully on
\(D/N\) and preserves this set.  Hypothesis (94.2) gives \(N_A(N)=N\).

Now take \(H<K\le A\) and choose \(M\le K\) minimal over \(H\).  If \(M\)
does not normalize \(H\), then \(N_M(H)=H\), contrary to Lemma 94.1.  Thus
\(M\le N\).  Since \([N:H]=p\), one has \(M=N\), and hence \(N\le K\).
\(\square\)

## 2. What the prime-to-\(p\) part must do

Write

\[
 H=H_p\times L,
\]

where \(H_p\) is the Sylow \(p\)-subgroup and \(L\) is the characteristic
Hall \(p'\)-subgroup of \(H\).

### Theorem 94.3 (fixed-point-free coprime carrier)

Assume \(A>H\).  There is an element \(t\in N\) of order \(p\) such that

\[
 N=H\rtimes\langle t\rangle.                                  \tag{94.6}
\]

The prime-to-\(p\) part satisfies

\[
 L=[L,t],\qquad C_L(t)=1.                                      \tag{94.7}
\]

Furthermore,

\[
 N_A(L)=N.                                                      \tag{94.8}
\]

If \(L\ne1\), then

\[
 F(N)=H,                                                        \tag{94.9}
\]

where \(F(N)\) denotes the Fitting subgroup.

#### Proof

The cover \(D\to D/N=\mathbf P^1\) is ramified.  Its inertia groups meet
the free deck group \(H\) trivially and inject into \(N/H=C_p\).  Every
nontrivial inertia group consequently has order \(p\), and any one of them
supplies a complement \(\langle t\rangle\), proving (94.6).  The inertia
groups normally generate \(N\), since otherwise their normal closure would
leave a nontrivial connected etale quotient of \(\mathbf P^1\).

Consider an inertia generator \(h t^i\), with \(i\ne0\), and its
\(L\)-component \(\lambda\).  The order-\(p\) relation says that the norm
of \(\lambda\) for the coprime \(C_p\)-action is one.  Coprime cohomology
gives

\[
 \ker(1+t+\cdots+t^{p-1})=(t-1)L=[L,t].                          \tag{94.10}
\]

Thus every inertia generator has trivial \(L/[L,t]\)-component.  Since
they normally generate \(N\), this forces \(L=[L,t]\).  The standard
coprime decomposition

\[
 L=C_L(t)\times[L,t]
\]

then gives \(C_L(t)=1\).

Put \(E=D/L\).  It is an etale abelian \(p\)-group cover of \(X\), with
deck group \(H_p\).  File 92, including its trivial-cover case, gives

\[
 |\operatorname{Aut}(E)|\le p|H_p|.
\]

On the other hand \(N/L\le\operatorname{Aut}(E)\) already has order
\(p|H_p|\).  Descent gives

\[
 N_A(L)/L\hookrightarrow\operatorname{Aut}(E),
\]

and therefore equality in (94.8).

Finally suppose \(L\ne1\).  The nilpotent normal subgroup \(H\) lies in
\(F(N)\), and \([N:H]=p\).  If \(F(N)>H\), it must equal \(N\), making
\(N\) nilpotent.  In a nilpotent group its Sylow \(p\)-subgroup centralizes
\(L\), contrary to (94.7).  Hence \(F(N)=H\). \(\square\)

The prime-power case \(L=1\) is already impossible by file 92.  Thus every
genuinely new counterexample to arbitrary-abelian deck normality must have
\(L\ne1\) and must extend the self-normalizing local configuration

\[
 F(N)=H\triangleleft N=H\rtimes C_p,\qquad N_A(N)=N<A
\]

inside a larger automorphism group.

## 3. The rational Hecke obstruction

The local configuration alone does not force normality: the abstract
triple \(A_5>A_4>V_4\), with \(p=3\), has exactly this shape.  Simplicity
adds a stronger representation-theoretic condition.

For a rational irreducible \(A\)-module \(W\), put

\[
 \Delta_W=\operatorname{End}_{\mathbf Q A}(W),
\]

and view \(W\) as a right \(\Delta_W\)-space.  Say that \(W\) is active if
its rational central idempotent acts nontrivially on \(J(D)\) and
\(W^H\ne0\).

### Theorem 94.4 (single cyclotomic packet of bounded degree)

Assume \(A>H\), and put \(h=|H|\).  There is exactly one active rational
irreducible packet \(W\).  It satisfies

\[
 \dim_{\Delta_W}W^H=1,qquad W^N=0,                              \tag{94.11}
\]

and

\[
 \mathbf Q(\zeta_p)\hookrightarrow\Delta_W^{\mathrm{op}}
       \hookrightarrow\operatorname{End}^0(J(X)).                \tag{94.12}
\]

Writing \(d=\dim_{\Delta_W}W\), one moreover has the sharp dimension
bound

\[
 d\,g\le 1+h(g-1),qquad	ext{hence}\qquad d\le h-1.             \tag{94.13}
\]

#### Proof

Let

\[
 e_H={1\over h}\sum_{u\in H}u\in\mathbf Q[A].
\]

Its image on \(J(D)\) is, up to isogeny, the pullback copy of \(J(X)\).
Distinct rational central simple components of \(\mathbf Q[A]\) cut out
mutually orthogonal abelian subvarieties inside this copy.  Simplicity of
\(J(X)\) allows exactly one nonzero component.  In a component

\[
 S_W\simeq\operatorname{End}_{\Delta_W}(W),
\]

the corner is

\[
 e_HS_We_H\simeq
 \operatorname{End}_{\Delta_W}(W^H).                             \tag{94.14}
\]

If \(\dim_{\Delta_W}W^H>1\), this matrix algebra has a proper nonzero
idempotent and splits \(J(X)\), again impossible.  This proves uniqueness
and the first part of (94.11).

Since \(D/N=\mathbf P^1\), the averaging idempotent \(e_N\) acts as zero
on \(J(D)\).  The active simple algebra \(S_W\) acts faithfully on its
nonzero isotypic abelian subvariety, so \(e_N|_W=0\), or \(W^N=0\).

Choose the order-\(p\) inertia lift \(t\) from Theorem 94.3.  It preserves
the rank-one \(\Delta_W\)-space \(W^H\).  Its action is a unit \(u\) of the
division corner (94.14), satisfying

\[
 u^p=1,qquad 1+u+\cdots+u^{p-1}=0.
\]

Therefore \(u\ne1\) has minimal polynomial \(\Phi_p\), proving the first
embedding in (94.12).  Faithfulness of the corner action on \(J(X)\) gives
the second.

Let \(B_W\subseteq J(D)\) be the active isotypic abelian subvariety.  A
rank-one idempotent in \(M_d(\Delta_W)\) cuts out \(J(X)\), up to isogeny;
the \(d\) standard rank-one idempotents have mutually isogenous images.
Consequently

\[
 \dim B_W=d\,g.
\]

The etale genus formula gives

\[
 \dim J(D)=g(D)=1+h(g-1).
\]

This proves the first inequality in (94.13).  For \(h>1\), its right side
divided by \(g\) is

\[
 h-{h-1\over g}<h,
\]

so the integral number \(d\) is at most \(h-1\). \(\square\)

No tame hypothesis is used here.  Averaging takes place in rational
endomorphism algebras, and all geometric covers from \(H\) are etale even
when their order is divisible by \(\operatorname{char}k\).

## 4. Two uniform envelope exclusions

### Corollary 94.5

In the situation above, the subgroup triples

\[
 (A,N,H)=(A_5,A_4,V_4)
 \quad\text{or}\quad
 (\operatorname{PSL}_2(7),C_7\rtimes C_3,C_7)                    \tag{94.15}
\]

cannot occur.

#### Proof

For \(A_5>A_4>V_4\), the rational irreducible packets have dimensions
\(1,6,4,5\), where the six-dimensional packet combines the two conjugate
three-dimensional characters.  The corresponding pairs

\[
 \bigl(\dim_{\Delta_W}W^H,\dim_{\Delta_W}W^N\bigr)
\]

are respectively

\[
 (1,1),\ (0,0),\ (1,1),\ (2,0).                                  \tag{94.16}
\]

Thus the only possible \(N\)-anisotropic active packet has \(H\)-fixed
rank two, contradicting (94.11).

For \(\operatorname{PSL}_2(7)>C_7\rtimes C_3>C_7\), the two conjugate
three-dimensional representations and the rational six-dimensional
representation have no \(C_7\)-fixed vectors.  The seven-dimensional
representation has one \(C_7\)-fixed vector but also one
\((C_7\rtimes C_3)\)-fixed vector.  The remaining eight-dimensional
rational representation has

\[
 \dim W^{C_7}=2,qquad \dim W^{C_7\rtimes C_3}=0.
\]

It is again the only possible active packet and violates (94.11).
\(\square\)

These exclusions are independent of a branch signature and of the
characteristic.  They explain why the abstract \(A_5\) obstruction does
not produce a simple-Jacobian curve in this setup.

## Exact remaining boundary

Files 91 and 92 prove normality when \(N=H\) and when \(H\) is a
\(p\)-group, respectively.  The results above show that every unresolved
composite-order case must supply a larger finite group \(A>N\) together
with one rational irreducible \(W\) satisfying all of

\[
 \dim_{\Delta_W}W^H=1,quad W^N=0,quad
 \mathbf Q(\zeta_p)\subseteq\Delta_W^{\mathrm{op}},quad
 \dim_{\Delta_W}W\le |H|-1.                                    \tag{94.17}
\]

In addition, that packet must actually occur in the cohomology of the
curve action.  Local normalizer and Fitting arguments alone cannot remove
this possibility; \(A_5>A_4>V_4\) already satisfies those raw group
conditions.  Ruling out (94.17), or realizing it geometrically, is the
precise remaining step for extending file 92 to arbitrary abelian deck
groups.  This boundary is separate from the non-Galois common-cover
problem.
