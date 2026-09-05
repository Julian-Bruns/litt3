# Higher cyclic prime-power deck rigidity

**Status: proved; independently audited PASS, 2026-09-04.**

[Audit record](audits/90_HIGHER_CYCLIC_PRIME_POWER_DECK_RIGIDITY_AUDIT.md).

This extends the useful part of file 87 to unbounded cyclic covering
degrees. The main Sylow theorem does not require trivial automorphisms,
a rigid branch set, or a prime different from the characteristic.

All curves below are smooth, projective, and connected over an
algebraically closed field. The base curve \(X\) always has genus at
least two. Jacobian simplicity is geometric.

## 1. The finite-group obstruction

### Lemma 90.1

Let \(p\) be an odd prime, \(n\ge2\), and let \(Q\) be a finite group
with a cyclic normal subgroup \(H=\langle h\rangle\) of order \(p^n\)
and quotient \(Q/H=C_p\). Suppose that \(Q\) contains an element
\(b\notin H\) of order \(p\). Then all elements of order \(p\) in
\(Q\) lie in a proper characteristic subgroup of order \(p^2\).

#### Proof

We have \(Q=H\rtimes\langle b\rangle\). Write
\(bhb^{-1}=h^u\). Since \(u^p\equiv1\pmod {p^n}\), the elementary
description of the units modulo an odd prime power gives

\[
                         u=1+c p^{n-1}\pmod {p^n}.
\]

For every integer \(j\), the geometric sum satisfies

\[
              1+u^j+\cdots+u^{(p-1)j}\equiv p\pmod {p^n}.
\]

Indeed, the linear correction is divisible by
\(p^{n-1}p(p-1)/2\), and every higher correction is divisible by
\(p^{2n-2}\). Both are divisible by \(p^n\). Consequently

\[
                         (h^a b^j)^p=h^{pa}.                       \tag{90.1}
\]

Thus an element whose order divides \(p\) must have
\(p^{n-1}\mid a\). Such elements are exactly

\[
                    T=\langle h^{p^{n-1}},b\rangle\simeq C_p^2.
\]

This set is a subgroup, is characterized by the equation \(g^p=1\),
and is therefore characteristic. Its order \(p^2\) is smaller than
\(|Q|=p^{n+1}\). \(\square\)

## 2. Simplicity forces a higher cyclic deck group to be Sylow

### Theorem 90.2

Let \(J(X)\) be simple, with \(g(X)\ge2\), and let

\[
                       D\longrightarrow X
\]

be a connected finite etale Galois cover with deck group
\(H=C_{p^n}\), where \(p\) is odd and \(n\ge2\). Then \(H\) is a
Sylow \(p\)-subgroup of \(\operatorname{Aut}(D)\).

The statement includes \(p=\operatorname{char}k\).

#### Proof

Put \(A=\operatorname{Aut}(D)\), and choose a Sylow \(p\)-subgroup
\(P\) containing \(H\). Suppose \(H<P\). The strict-normalizer
property for finite \(p\)-groups gives

\[
                            H<N_P(H).
\]

Choose an order-\(p\) subgroup of \(N_P(H)/H\), and let \(Q\) be its
inverse image. Thus

\[
                    H\triangleleft Q,\qquad Q/H=C_p.
\]

The normalizer injection of Lemma 87.1 makes \(Q/H\) act faithfully on
\(X=D/H\). Since \(J(X)\) is simple, Lemma 87.2 applied to the
nontrivial separable quotient gives

\[
                         D/Q=X/(Q/H)\simeq\mathbf P^1.            \tag{90.2}
\]

The group \(H\) acts freely on \(D\). Hence every point stabilizer for
the \(Q\)-action injects into \(Q/H=C_p\), and has order either 1 or
\(p\). At least one is nontrivial: otherwise (90.2) would give a
nontrivial connected finite etale cover of \(\mathbf P^1\).
Choose a generator \(b\) of such a stabilizer. It is outside \(H\)
and has order \(p\).

Lemma 90.1 now puts every point stabilizer in a proper characteristic
subgroup \(T\triangleleft Q\) of order \(p^2\). Therefore

\[
                           D/T\longrightarrow D/Q
\]

is a connected finite etale Galois cover with nontrivial group
\(Q/T\), of order \(p^{n-1}\). This again contradicts (90.2).
Thus \(P=H\). \(\square\)

The argument kills point stabilizers, not their different exponents.
Wild ramification therefore causes no change in the proof.

## 3. From Sylow control to the full automorphism group

### Proposition 90.3

Let \(D\to X\) be a connected finite etale Galois cover, with
\(J(X)\) simple and nontrivial abelian \(p\)-group deck group \(H\).
Suppose

\[
 H\text{ is Sylow in }A=\operatorname{Aut}(D),\qquad
                         H\subseteq Z(N_A(H)).                    \tag{90.3}
\]

Then

\[
                         A=H\times R,                             \tag{90.4}
\]

where \(p\nmid|R|\) and \(R\) embeds in \(\operatorname{Aut}(X)\).

#### Proof

Burnside's normal-complement theorem gives
\(R\triangleleft A\), with \(p\nmid|R|\), and
\(A=R\rtimes H\). Let \(G\) be the normal closure of \(H\) in
\(A\), and put \(R_0=R\cap G\). Since \(A/R=H\) is abelian, all
conjugates of \(H\) have the same image, and

\[
                            G/R_0\simeq H.
\]

If \(G>H\), simplicity gives \(D/G\simeq\mathbf P^1\). Every Sylow
\(p\)-subgroup of \(G\) is conjugate to \(H\), hence acts freely.
All point stabilizers have order prime to \(p\), and therefore map
trivially to \(G/R_0=H\). Thus \(D/R_0\to D/G\) would be a nontrivial
connected finite etale cover of \(\mathbf P^1\), impossible.

Hence \(G=H\), so \(H\triangleleft A\). The normal subgroups \(R,H\)
have trivial intersection, and therefore commute. This proves (90.4).
Finally \(A/H=R\hookrightarrow\operatorname{Aut}(X)\) by Lemma 87.1.
\(\square\)

### Corollary 90.4 (a parameterized coprimality criterion)

Assume \(J(X)\) is simple, \(p\) is odd, and

\[
                    \gcd(|\operatorname{Aut}(X)|,p-1)=1.
\]

For every connected finite etale cyclic \(p^n\)-cover \(D\to X\)
with \(n\ge2\), its deck group \(H\) is normal and (90.4) holds.

#### Proof

Theorem 90.2 makes \(H\) Sylow. Since \(H\) is abelian, conjugation
on \(H\) factors through
\(N_A(H)/H\hookrightarrow\operatorname{Aut}(X)\). This quotient has
order prime to \(p\), and its image in
\(\operatorname{Aut}(C_{p^n})\), of order \(p^{n-1}(p-1)\), has order
dividing \(p-1\). The coprimality assumption makes that image trivial.
Proposition 90.3 applies. \(\square\)

## 4. Uniform consequences for nonhyperelliptic curves

### Theorem 90.5

Suppose \(\operatorname{char}k\ne2\), \(X\) is nonhyperelliptic, and
\(J(X)\) is simple. Then for each of the following covers:

- a connected finite etale cyclic \(2^n\)-cover, \(n\ge1\);
- a connected finite etale cyclic \(3^n\)-cover, \(n\ge2\),

the deck group \(H\) is normal and
\(\operatorname{Aut}(D)=H\times R\), with \(|R|\) odd. In
particular, \(D\) has no nontrivial involution with a fixed point.

Consequently \(D\) cannot also be a finite etale abelian Galois cover
of any hyperelliptic curve of genus at least two.

#### Proof

The group \(\operatorname{Aut}(X)\) has odd order. Otherwise it would
contain an involution; simplicity would make its quotient rational,
expressing \(X\) as a degree-two cover of \(\mathbf P^1\), contrary to
nonhyperellipticity.

For \(p=3\), Corollary 90.4 applies because \(p-1=2\). For \(p=2\),
the normalizer injection and the strict-normalizer property already make
\(H\) Sylow: any proper containment in a Sylow subgroup would give a
nontrivial 2-subgroup of \(\operatorname{Aut}(X)\). Moreover
\(\operatorname{Aut}(C_{2^n})\) is a 2-group, whereas \(N_A(H)/H\)
has odd order, so conjugation on \(H\) is trivial. Apply Proposition
90.3. In both cases \(R\) embeds in the odd-order group
\(\operatorname{Aut}(X)\).

When \(p=3\), the full automorphism group is odd and has no involution.
When \(p=2\), every involution lies in the etale deck group \(H\), so
has no fixed point. Finally, the hyperelliptic involution has a
nontrivial fixed-point-preserving lift through every connected etale
abelian Galois cover, by the proof of Theorem 87.8. This gives the last
claim. \(\square\)

### Corollary 90.6 (all cyclic cubic powers for the current pair)

Let \(X\) be the genus-nine curve of file 76. For every \(n\ge1\),
there is no common finite etale cover of \(X\) and a hyperelliptic
curve whose map to \(X\) is cyclic Galois of degree \(3^n\), and
whose map to the hyperelliptic curve is Galois.

For \(n\ge2\), a cyclic \(3^n\)-cover \(D\to X\) in fact satisfies

\[
                         \operatorname{Aut}(D)=C_{3^n}.
\]

#### Proof

For \(n=1\), Corollary 87.11 says that \(\operatorname{Aut}(D)\)
is abelian of order 3 or 9. The second deck group is therefore abelian,
and Corollary 87.12 applies. For \(n\ge2\), Theorem 90.5 supplies
the direct-product description. Its complement \(R\) has order prime
to 3 and embeds in \(\operatorname{Aut}(X)=C_3\), so \(R=1\). Again
any second Galois deck group is automatically abelian, and Theorem
90.5 gives the exclusion. \(\square\)

### Corollary 90.7 (simple targets, without hyperellipticity)

Let \(X\) be the curve of file 76, and let \(D\to X\) be a connected
finite etale cyclic \(3^n\)-cover with \(n\ge2\). If \(D\to Y\) is
another finite etale Galois map and \(J(Y)\) is simple with
\(g(Y)\ge2\), then \(Y\simeq X\) and the two deck groups coincide.

#### Proof

Corollary 90.6 identifies \(\operatorname{Aut}(D)\) with the deck group
\(H\) over \(X\). The deck group \(H_Y\) over \(Y\) is a subgroup
of \(H\). Thus \(Y=D/H_Y\to D/H=X\) is a finite etale map.
If its degree were greater than one, the simple Jacobian of \(Y\)
would forbid its positive-genus quotient \(X\), by Lemma 87.2.
Hence the degree is one and \(H_Y=H\). \(\square\)

## Scope

This genuinely covers unbounded degrees for the fixed genus-nine and
genus-25 pair, not merely primes incompatible with their genus ratio.
The first leg can have degree \(3^n\), while the required second degree
is \(3^{n-1}\).

For the current pair it does not treat noncyclic first-leg groups or a
non-Galois second leg. In the more general Theorem 90.5, the second leg
must still be abelian Galois unless an additional argument makes its
deck group abelian. Arbitrary common covers cannot presently be replaced
by covers with these properties. In particular this result neither
proves visibility nor eliminates the generic coefficient row.

The semidirect-product power identity (90.1) was also checked exactly for
\(p=3,5,7,11\), \(n=2,3,4\), every possible action parameter \(c\),
and every \(j\bmod p\). The calculation passed; the uniform proof in
Lemma 90.1, not this finite check, establishes the result for all parameters.
