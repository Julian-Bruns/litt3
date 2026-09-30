Imported Pro proof, 24 September 2026; focused integration and local verification are recorded in [the audit](../../Research/audits/STRUCTURAL_TRIPLET_2026_09_24.md). File references inside this report are relative to the preserved [results archive](../../../litt3-computation-data/structural_triplet_replies_20260924/originals/cartier/prime_to_five_cartier/). Generated certificates stay there; source copies are in scripts/arithmetic/pro_structural_triplet_20260924/cartier. The canonical theorem statement governs its accepted scope.

# An arithmetic support obstruction for the embedded order-five Cartier line

**Status: partial; the universal prime-to-five-monodromy decision remains unresolved.**

This report proves a new necessary condition for an actual witness, together with reusable arithmetic and orbitwise results. It neither constructs a witness nor excludes witnesses whose complementary selection projects to seven or more points of \(R_X\).

All data and supplied hypotheses are stated in `PROBLEM.md`. References numbered [R1], [R2] are in `REFERENCES.md`. The specific formulas, deductions, and computations used here are included below and in the archive; those references are background, not missing certificates.

## 1. Main statements and exact scope

Write \(R_X=O+Z_A\), where \(Z_A=x^*\operatorname{div}_0A\) consists of twelve geometric points. For a witness with scalar data \((q,E,G)\), define
\[
r=\#h(\operatorname{Supp}E).
\]
Thus \(r\) counts points of \(X\), not x-values: its possible range before applying the results is from five to thirteen.

### Theorem A — arithmetic of the thirteen-point support

Every degree-zero integral divisor supported on \(R_X\) represents a class of order prime to five in \(\operatorname{Pic}^0(X)\). Equivalently, every class \([P-O]\), for \(P\in\operatorname{Supp}R_X\), has order prime to five. The same assertion holds on the Frobenius twist, for corresponding point divisors.

This theorem is proved in Section 5 using an exact Cartier-matrix certificate. It does not compute the order of the Jacobian.

### Theorem B — exact determinant, not only its degree

For the actual embedded plane specified in the question,
\[
\det\mathcal P_X\simeq\mathcal O_{X^{(1)}}(7O^{(1)}).
\]
In particular there is no undetermined order-five factor in this formula. Section 4 proves it from the actual generators \([f],[f^2]\).

### Theorem C — new support obstruction

Assume the supplied low-degree exclusion for twisted degree-zero embedded lines on covers of degree at most three. Then **every actual witness in the question satisfies \(r\ge7\)**.

In fact this holds for every connected finite étale cover, without restricting the order of its Galois closure. In particular it holds throughout the requested prime-to-five-monodromy class. It excludes all upstairs selections with \(r\le6\), whether or not those selections descend to \(X\). Its proof in Section 6 retains the actual embedded lines throughout.

### Theorem D — orbitwise collision inequalities

On a Galois closure \(h:S\to X\), write \(N=\deg h\), and let \(m\) be the orbit size of the actual embedded line. Then \(m\ge4\). For distinct orbit members with data \((E_i,G_i)\),
\[
\deg(E_i\wedge E_j)+\deg(G_i\wedge G_j)\le4N.\tag{1.1}
\]
Here \(\wedge\) is the coefficientwise minimum of effective divisors. Define
\[
e_P=\#(E\cap h^{-1}P),\qquad
 g_{P,a}=\#\{Q\mid P:\operatorname{mult}_Q G\ge a\},\quad a\ge1.
\]
Then
\[
\sum_{P\in R_X}e_P^2+\sum_{P\in X}\sum_{a\ge1}g_{P,a}^2
\le\left(4+\frac2m\right)N^2,\tag{1.2}
\]
\[
\sum_{P\in R_X}e_P^2\le\left(4+\frac1m\right)N^2.\tag{1.3}
\]
If \(d=\deg D_h(G)\), the additional numerical consequence is
\[
\frac{25}{r}+\frac1d\le4+\frac2m.\tag{1.4}
\]
These inequalities handle arbitrary multiplicities in \(G\). They do not assume scalar trace survival, and they do not assert that a numerical profile is geometrically realizable.

### What these theorems do not decide

For \(7\le r\le13\), there is still no bound on the cover degree or a proof that the exact scalar reconstruction and horizontal lift are impossible. No unbounded group class is claimed to be entirely excluded independently of selections. The result fulfills the structural-obstruction alternative, not the full yes/no alternative.

## 2. Descent of the actual line and its orbit

### Lemma 2.1 — injectivity on order-five classes under separable pullback

For a smooth proper curve \(V\), define an additive map
\[
\operatorname{Pic}(V)[5](k)\longrightarrow H^0(V,\omega_V),\qquad
[\mathcal O_V(D)]\longmapsto d\log a,
\]
where \(\operatorname{div}a=5D\).

This map is well-defined, injective, and compatible with automorphisms and separable pullback. Its image consists of Cartier-fixed regular forms.

**Proof.** Replacing \(D\) by \(D+\operatorname{div}b\) replaces \(a\) by a constant times \(ab^5\), without changing \(da/a\). Locally \(a=t^{5c}v\), with \(v\) a unit, so \(da/a=dv/v\) is regular. If \(da/a=0\), then \(a\in k(V)^5\), since \(k\) is perfect and \(k(V)\) has transcendence degree one. Write \(a=b^5\). Equality of divisors gives \(D=\operatorname{div}b\), proving injectivity.

For the Cartier assertion, in the nonzero case \(a\) is a separating element. The defining p-basis formula gives \(C(a^4da)=da\), and \(C(c^5\eta)=cC(\eta)\). Hence
\[
C(da/a)=C(a^{-5}a^4da)=da/a.
\]
The zero case is immediate. The construction is equivariant, because it is defined using divisors and differentiation. For a finite separable extension of function fields, pullback on rational one-forms is injective. Therefore a nonzero logarithmic form, and thus its order-five class, cannot become zero under finite separable pullback. \(\square\)

Consequently, pulling a witness to a finite étale Galois closure preserves its nontrivial order-five line. All other witness conditions commute with étale pullback, by the stated reconstruction and Frobenius base-change properties. The projected support \(h(\operatorname{Supp}E)\) is unchanged by such a refinement.

### Lemma 2.2 — actual stabilizers and the orbit lower bound

Let \(\Gamma\) be the deck group on a Galois witness. The stabilizers of the actual line, its divisor \(E\), and its normalized primitive \(q\) are equal. They also stabilize \(G\). The orbit size \(m\) is at least four. In the allowed class, \(5\nmid m\).

**Proof.** The adjunction divisor of the actual line recovers \(\Delta\), and hence \(E=R-\Delta\). Conversely, two degree-zero embedded lines with the same \(E\) are equal by the supplied fixed-selection uniqueness. Generically
\[
[q^2]=[f^2]+2b^5[f]\quad\text{in } k(S)/k(S)^5.
\]
Since \(df\ne0\), the elements \(1,f,f^2\) are linearly independent over \(k(S)^5\). Equality of the one-dimensional subspaces above therefore forces equality of their normalized \([f^2]\)-coefficients and of \(b^5\), so it forces equality of \(q\). Finally \(G\) is recovered from the exact divisor of \(q\).

Let \(K\) be the line stabilizer. The actual subbundle is \(K\)-invariant inside a bundle pulled back from \(X^{(1)}\); the inherited equivariance descends it to a saturated degree-zero subbundle on \((S/K)^{(1)}\). The quotient \(S/K\to X\) is connected and finite étale, of degree \([\Gamma:K]=m\). Its adjunction divisor is twice a reduced selection of degree \(8m\). Saturation, the divisor, and its multiplicities descend by faithful flatness.

This descent need not preserve Frobenius triviality or exact order five: a prime-to-five twist can appear. We do **not** assert otherwise. The supplied small-degree exclusion explicitly allows twisted degree-zero lines, so it still gives \(m\ge4\). If \(5\nmid|\Gamma|\), then \(m\mid|\Gamma|\) also gives \(5\nmid m\). \(\square\)

No averaged section has been used to replace the original line. The only descent in this lemma is descent under its actual stabilizer.

## 3. Pairwise collision and orbit energy

### Theorem 3.1 — local difference-divisor bound

For two distinct normalized primitives on the same cover,
\[
q_i=f+b_i^5,\qquad \operatorname{div}q_i=3E_i-5G_i-10H,
\]
put \(a=b_i-b_j\ne0\). Then
\[
\operatorname{div}a\ \ge\ (E_i\wedge E_j)-2H-(G_i\vee G_j),\tag{3.1}
\]
where \(\vee\) is the coefficientwise maximum.

**Proof.** We have \(a^5=q_i-q_j\). At a point write \(e_i,e_j\in\{0,1\}\), \(g_i,g_j\ge0\), and \(h\in\{0,1\}\) for the multiplicities of \(E_i,E_j,G_i,G_j,H\). The disjointness of \(E_i,G_i\) gives \(e_i g_i=0\), and likewise for \(j\). The valuation satisfies
\[
v(a)\ge\left\lceil\frac{\min(3e_i-5g_i-10h,\ 3e_j-5g_j-10h)}5\right\rceil.
\]
If \(e_i=e_j=1\), both \(g_i,g_j\) are zero and the right side is \(1-2h\). Otherwise it is at least \(-2h-\max(g_i,g_j)\). These are exactly the coefficients on the right of (3.1). This argument applies for every nonnegative pair \(g_i,g_j\), not only the bounded values used in the sanity-check table. \(\square\)

Taking degrees in (3.1) gives
\[
0\ge\deg(E_i\wedge E_j)-2N-\deg(G_i\vee G_j)
=\deg(E_i\wedge E_j)+\deg(G_i\wedge G_j)-4N,
\]
which proves (1.1). Equality has the stronger consequence that (3.1) is an equality of divisors: an effective divisor of degree zero is zero.

### Theorem 3.2 — the exact averaging identities

The deck group acts regularly on each geometric fiber of a Galois étale cover. Hence
\[
\sum_{\sigma\in\Gamma}\deg(E\wedge\sigma E)=\sum_P e_P^2.\tag{3.2}
\]
Indeed, for each ordered pair of selected points over a fixed base point, exactly one deck transformation sends the second point to the first.

For a nonreduced effective divisor, use
\[
\min(a,b)=\sum_{j\ge1}\mathbf1_{a\ge j}\mathbf1_{b\ge j}.
\]
Applying the same ordered-pair count to every multiplicity layer gives
\[
\sum_{\sigma\in\Gamma}\deg(G\wedge\sigma G)
=\sum_P\sum_{a\ge1}g_{P,a}^2.\tag{3.3}
\]
There are \(N/m\) elements in the actual stabilizer. For these elements the sum of the two intersection degrees is \(5N+N=6N\). For the other \(N-N/m\) elements, (1.1) bounds it by \(4N\). Summing gives
\[
6N\frac Nm+4N\left(N-\frac Nm\right)
=\left(4+\frac2m\right)N^2,
\]
proving (1.2). The contribution of the stabilizer alone to (3.3) is \(N^2/m\); subtracting it proves (1.3).

Since \(\sum e_P=5N\) and there are \(r\) nonzero terms, Cauchy–Schwarz gives \(\sum e_P^2\ge25N^2/r\). Similarly \(\sum_{P,a}g_{P,a}=N\), and the number of its nonzero layer terms is exactly \(d=\deg D_h(G)\). Therefore \(\sum g_{P,a}^2\ge N^2/d\). Substitution gives (1.4). \(\square\)

### Corollary 3.3 — preliminary small-support bounds

The inequalities alone exclude \(r\le5\), since \(m\ge4\) would give \(5\le4+1/m\le17/4\). If \(r=6\), they give \(25/6\le4+1/m\), hence \(m\le6\). In the prime-to-five class the only remaining orbit sizes would be \(m=4\) or \(m=6\).

The finite integer-profile check in `certificates/exact_checks.json` records the only six-positive-entry rows on the degree-\(m\) stabilizer quotient satisfying these inequalities:

```
m=4: (4,4,3,3,3,3)
m=6: (5,5,5,5,5,5)
```

These are necessary incidence rows, not witnesses. Section 6 rules out the entire six-support case rather than leaving these rows unresolved.

## 4. The exact determinant of the actual plane

This computation uses the specified embedding, not only its numerical invariants.

### Proposition 4.1

The rational determinant section \([f]\wedge[f^2]\) has divisor
\[
Z_A^{(1)}-5O^{(1)}.
\]
Consequently \(\det\mathcal P_X\simeq\mathcal O_{X^{(1)}}(7O^{(1)})\), since \(Z_A^{(1)}\sim12O^{(1)}\).

**Proof.** In a completed local ring choose a parameter \(t\) on \(X\), and write \(s=t^5\) on the Frobenius target. Locally
\[
B_X\simeq\bigoplus_{i=1}^4 k[[s]]\,[t^i].
\]
Two local primitive classes with linearly independent reductions modulo \(s\) form a basis of the saturated rank-two lattice they generate.

At a finite nonbranch point where \(df\) is a unit, subtract the constant value of \(f\), obtaining \(q\) of order one. Then \([q]\) and \([q^2]\) have independent leading terms \(t\) and \(t^2\). Their determinant is a unit. Subtracting a fifth-power constant changes \([f^2]\) by a scalar multiple of \([f]\) and does not change the determinant.

At a point of \(Z_A\), \(df\) has order two. After subtracting the constant value, \(q\) has order three. Thus \([q]\) and \([q^2/s]\) have independent leading terms \(t^3\) and \(t\). They form a saturated local basis. Since \([q^2]=s[q^2/s]\), the determinant has one zero on \(X^{(1)}\).

At a finite cubic branch point \((r,0)\), use \(y\) as parameter. The identity \(Q'=PA^2\), with \(P\) squarefree and coprime to \(A\), implies that \(Q(x)-Q(r)\) has order two in \(x-r\), hence order six in \(y\). Choose \(c\in k\) with \(c^5=Q(r)\). Then
\[
f=(c/y)^5+q,\qquad q=(Q(x)-Q(r))/y^5,
\]
and \(q\) has order one. In \(B_X\), \([f]=[q]\) and \([f^2]=[q^2]+2(c/y)^5[q]\). The latter triangular change may have a pole in its off-diagonal entry, but its determinant is one. Therefore the determinant is again a unit.

At infinity, \(v_O(f)=-7\) and \(v_O(f^2)=-14\). The classes
\[
[t^{10}f],\qquad[t^{15}f^2]
\]
have leading terms \(t^3\) and \(t\), respectively, and are independent modulo \(s\). They form a saturated local basis. The rational determinant \([f]\wedge[f^2]\) is \(t^{-25}=s^{-5}\) times their determinant, so has pole order five on the Frobenius target.

These exhaust all points. Finally \(\operatorname{div}(A^{(1)}(x^{(1)}))=Z_A^{(1)}-12O^{(1)}\), yielding the claimed line-bundle identity. \(\square\)

The use of Frobenius constants in these changes of basis is essential: \(t^{10}\), \(t^{15}\), and \((c/y)^5\) are fifth powers. There is no illicit use of arbitrary functions as generic scalar coefficients in \(B_X\).

## 5. Arithmetic theorem for divisors supported on \(R_X\)

### 5.1 Exact finite-field certificates

Let \(k_0=\mathbf F_{25}\), and let \(\phi\) denote arithmetic \(25\)-power Frobenius on geometric points and divisor classes of the curve defined over \(k_0\). This arithmetic action is not the relative Frobenius pullback on divisors.

The exact polynomial checks give:

1. \(P\) and \(A\) are squarefree and coprime, \(Q'=PA^2\), and \(B_0^5+Q\equiv0\pmod P\).
2. The monic scalar multiple of \(A\) is the coded row \((5,2,6,7,1)\). It is irreducible over \(\mathbf F_{25}\).
3. In \(K_4=\mathbf F_{25}[x]/(A)\),
\[
P(x)^{(25^4-1)/3}=[11],\qquad [11]^3=1,\quad [11]\ne1.\tag{5.1}
\]
The irreducibility certificate consists of \(x^{25^4}\equiv x\pmod A\) and \(\gcd(A,x^{25^2}-x)=1\). These suffice in degree four; the additional degree-one gcd is also recorded. All remainders are in the certificate.

It follows that every root of \(A\) lies in \(\mathbf F_{25^4}\). In each of its cubic fibers, \(\phi^4\) fixes \(x\) and multiplies \(y\) by \([11]\). Thus it cycles the three points of the fiber, and all twelve points lie in \(\mathbf F_{25^{12}}\).

### 5.2 Cartier matrix and its precise semilinearity

A basis of regular differentials, in the order used by the code, is
\[
\left(dx/y,\ xdx/y,\ x^2dx/y,\ dx/y^2,\ xdx/y^2,\ldots,x^5dx/y^2\right).\tag{5.2}
\]
At finite branch points these forms are regular because \(v(dx)=2\) and \(v(y)=1\). At infinity, \(v(x^idx/y^j)=10j-4-3i\); precisely the displayed nine forms meet the required bounds. They are independent and the genus is nine, so they form a basis.

Let \(H\) be the matrix such that, for coefficient columns over \(k\),
\[
C(v)=H v^{1/5}.
\]
For a basis element with denominator exponent \(j\), choose \(j'\in\{1,2\}\) satisfying \(5j'\equiv j\pmod3\), and set \(a=(5j'-j)/3\). Then
\[
\frac{x^i dx}{y^j}=\left(\frac1{y^{j'}}\right)^5 x^i P(x)^a dx.
\]
The defining Cartier formula retains the coefficients at powers \(x^{5\ell+4}\) and takes their fifth roots. Thus the coefficient at \(x^\ell dx/y^{j'}\) is the fifth root of the coefficient of \(x^{5\ell+4}\) in \(x^iP^a\). Here \(a=3\) for \(j=1\), and \(a=1\) for \(j=2\). This directly derives the matrix; no matrix convention from another source is presumed. See [R1] for general computational background.

The resulting coded rows are:

```
H =
[ 0,  0,  0, 12, 21, 11,  6, 18,  0]
[ 0,  0,  0,  6, 20, 14, 13,  9, 12]
[ 0,  0,  0,  0,  0,  0,  0,  1,  6]
[ 1, 19, 21,  0,  0,  0,  0,  0,  0]
[24, 11,  6,  0,  0,  0,  0,  0,  0]
[ 1, 20, 10,  0,  0,  0,  0,  0,  0]
[13, 17, 13,  0,  0,  0,  0,  0,  0]
[24, 14, 23,  0,  0,  0,  0,  0,  0]
[18,  7, 22,  0,  0,  0,  0,  0,  0]
```

Since the entries lie in \(\mathbf F_{25}\), inverse fifth power on these **matrix entries** equals fifth power. Set
\[
M=H H^{(5)}.
\]
Then, on arbitrary coefficient columns over \(k\),
\[
C^{2d}(v)=M^d v^{1/25^d}.\tag{5.3}
\]
It would be incorrect to drop the semilinear factor on a vector defined over a larger field.

The key executed certificate is
\[
\Xi=I+M^4+M^8,\qquad \det\Xi=[2]\ne0.\tag{5.4}
\]
The complete matrices \(M,M^4,M^8,\Xi\), and an explicit two-sided inverse of \(\Xi\), are in `certificates/exact_checks.json`. The entry point recomputes them, checks both inverse products, checks the determinant, and checks
\[
(M^4-I)\Xi=M^{12}-I.
\]
As a redundant check, the nullities of \(M^d-I\), for \(d=1,2,3,4,6,12\), are respectively \(0,2,0,2,2,2\).

### Lemma 5.3 — Frobenius fixes the relevant rational five-primary subgroup

On
\[
U=J(X)(\mathbf F_{25^{12}})_{(5)},
\]
the automorphism \(\sigma=\phi^4\) acts trivially. The subscript denotes the finite five-primary subgroup, not a group scheme assertion.

**Proof on elements of order five.** Let \(L\in J(X)(\mathbf F_{25^{12}})[5]\). By Lemma 2.1, its logarithmic form \(\nu\) is regular and Cartier-fixed. Equivariance makes its coefficient vector \(v\) in (5.2) rational over \(\mathbf F_{25^{12}}\). Formula (5.3), with \(d=12\), gives \(M^{12}v=v\).

Because \(\Xi\) is invertible and commutes with \(M^4-I\), the identity in (5.4) implies \(M^4v=v\). Using \(C^8\nu=\nu\) now gives
\[
v=M^4v^{1/25^4}=v^{1/25^4}.
\]
The last equality follows by applying coefficientwise inverse \(25^4\)-power to \(M^4v=v\), since \(M\) is defined over \(\mathbf F_{25}\). Therefore \(\nu\) is fixed by \(\phi^4\). Injectivity and equivariance of the logarithmic map imply \(\phi^4L=L\).

**Extension to all five-power orders.** The group \(U\) is finite and \(\sigma^3=1\). Multiplication by three is invertible on \(U\), so
\[
e=3^{-1}(1+\sigma+\sigma^2)
\]
is an idempotent endomorphism with image \(U^\sigma\). By the order-five case, \(e\) is the identity on \(U[5]\). Hence \(\ker e\) has no nonzero element of order five. A nonzero finite five-group always has such an element, so \(\ker e=0\). Thus \(e=1\) and \(U=U^\sigma\). \(\square\)

This is a finite-group averaging argument on a torsion subgroup, **not** averaging of the embedded line or its sections.

### Theorem 5.4 — proof of Theorem A

Every \([P-O]\), for \(P\in R_X\), has order prime to five.

**Proof.** The statement is trivial for \(P=O\). For a finite \(P\in Z_A\), its class lies in the finite group \(J(X)(\mathbf F_{25^{12}})\). Let \(a_P\) be its five-primary component. By Lemma 5.3 this component is fixed by \(\sigma=\phi^4\).

By (5.1), \(P,\sigma P,\sigma^2P\) are exactly one cubic fiber over a root \(r\) of \(A\). The principal divisor of \(x-r\) gives
\[
[P-O]+[\sigma P-O]+[\sigma^2P-O]=0.
\]
Taking five-primary components and using \(\sigma a_P=a_P\) yields \(3a_P=0\). Since three is invertible on a five-group, \(a_P=0\). The class therefore has prime-to-five order. Any degree-zero divisor on the specified support is an integral combination of these classes, so it too has prime-to-five order.

The corresponding assertion on \(X^{(1)}\) follows by twisting the base field automorphism. This transports geometric divisor classes and preserves their orders. It is not an argument using relative Frobenius pullback, which could have a nontrivial order-five kernel. \(\square\)

## 6. Elimination of all selections with at most six projected points

### Lemma 6.1 — three degree-zero lines in a degree-zero rank-two bundle

Let \(V\) be a rank-two vector bundle of degree zero on a smooth proper connected curve. If \(V\) contains three distinct saturated degree-zero lines, then \(V\simeq L\oplus L\), and all its saturated degree-zero lines are isomorphic to \(L\).

**Proof.** Two distinct lines \(L_1,L_2\) have a nonzero determinant map \(L_1\otimes L_2\to\det V\). Both sides have degree zero, so the nonzero section has no zero. Thus \(V=L_1\oplus L_2\). A third line distinct from both summands has nonzero projections to each. A nonzero map between degree-zero line bundles is an isomorphism, so \(L_1\simeq L_2\simeq L\). The same projection argument applies to any other degree-zero subline. \(\square\)

### Theorem 6.2 — proof of Theorem C

There is no witness with \(\#h(\operatorname{Supp}E)\le6\).

**Proof.** Pass to a Galois closure, preserving nontriviality by Lemma 2.1, and use notation \(h:S\to X\), \(N=\deg h\). The projected support is unchanged. Choose seven distinct points in \(R_X\) missed by \(h(\operatorname{Supp}E)\), and let their reduced sum be \(D_0\).

Every Galois conjugate \(E_i\) misses all of \(h^*D_0\). Hence \(\Delta_i=R-E_i\) contains \(h^*D_0\). Define on \(X^{(1)}\)
\[
Q_0=\lambda_X+\mathcal P_X(-D_0^{(1)}).
\]
Because \(\lambda_X\) is saturated, at each point of \(D_0^{(1)}\) this modification has local form \(\langle e_1,s e_2\rangle\subset\langle e_1,e_2\rangle\), where \(e_1\) generates \(\lambda_X\). It has colength one there. Thus
\[
\deg Q_0=7-7=0,\qquad
\det Q_0=\det\mathcal P_X\otimes\mathcal O(-D_0^{(1)})
\simeq\mathcal O(7O^{(1)}-D_0^{(1)}).\tag{6.1}
\]
For each conjugate actual line \(\mathcal A_i\), its contact with \(h^{(1)*}\lambda_X\) is \(\Delta_i^{(1)}+G_i^{(1)}\). This contains \(h^{(1)*}D_0^{(1)}\). In the local form above, the contact condition says that the \(e_2\)-coefficient is divisible by \(s\). It follows that every \(\mathcal A_i\) is a subline of \(h^{(1)*}Q_0\).

It is still saturated there: the quotient embeds in \(h^{(1)*}\mathcal P_X/\mathcal A_i\), which is torsion-free. Its degree is zero. Lemma 2.2 gives at least four distinct conjugates, so Lemma 6.1 yields
\[
h^{(1)*}Q_0\simeq\mathcal A\oplus\mathcal A,
\qquad
h^{(1)*}\det Q_0\simeq\mathcal A^{\otimes2}.\tag{6.2}
\]
The right side has exact order five. But (6.1) is a degree-zero divisor class supported on \(R_X^{(1)}\), so Theorem A says that \(\det Q_0\) has order prime to five. Its pullback still has order dividing that prime-to-five integer. This contradicts (6.2).

The proof did not require \(5\nmid|\Gamma|\). It therefore excludes the stated support range even on wild-monodromy étale covers. \(\square\)

The contradiction uses the determinant of a bundle actually containing the distinct embedded conjugate lines. It does not replace a line by its orbit sum, confuse its isomorphism class with its embedding, or assume that a scalar splitting has a horizontal lift.

## 7. What was checked, and why the checks suffice for the arithmetic theorem

The verifier performs exact operations in \(\mathbf F_{25}\) using the rule \(\beta^2=\beta+3\). It exhaustively checks the field operations on all 25 elements and the 15,625 triples needed for the implemented associativity and distributivity tests. It then checks the polynomial identities and computes the Cartier matrix from its displayed formula.

The critical arithmetic implication depends on two explicit certificates:

- the cubic-residue identity (5.1), establishing the arithmetic three-cycle in each fiber;
- the invertibility certificate (5.4), establishing that arithmetic \(\phi^4\) fixes the relevant five-primary subgroup.

The matrix inverse is included rather than an unsupported statement of rank. The report supplies the proof from these certificates to prime-to-five orders of all support classes. There is no assumed equality between a Cartier matrix and a Frobenius matrix without a semilinearity convention, and no assertion that a computed kernel dimension alone counts all higher five-power torsion.

The base curve checks also justify the usual geometric assertions: squarefreeness makes the affine Kummer model smooth, \(P\) is not a cube because its roots are simple, and \(\gcd(3,10)=1\) gives a unique point at infinity. Tame Riemann–Hurwitz for the degree-three x-map, branched at ten finite points and infinity, gives \(2g-2=-6+22=16\); see [R2]. This is a verification of the **base curve**, not of any constructed cover.

The local-valuation table tests only \(0\le g_i,g_j\le12\), and is explicitly labeled a bounded sanity check. The full unbounded valuation proof is Theorem 3.1. The finite profile check likewise is not a search over covers.

## 8. A surviving counting model: why the result is not a full decision

Take the abstract group \(C_{13}\), acting by translation on each thirteen-element fiber. Over each of thirteen marked base points, select offsets \(\{0,1,2,3,4\}\) for \(E\). Over each of thirteen additional, distinct unmarked base points, put one point of \(G\) at offset zero.

Then \(N=m=13\), \(\deg E=65\), \(\deg G=13\), and \(r=13\). For every nonidentity translation, the \(G\)-intersection is zero and the \(E\)-intersection is at most \(13\cdot4=52=4N\). The total energy is
\[
13\cdot5^2+13\cdot1^2=338\le702
=\left(4+\frac2{13}\right)13^2.
\]
This model is reproduced and checked in the archive. It is **only a finite incidence model**. There is no curve, étale cover, rational function, torsion class, or horizontal connection attached to it. It proves neither existence nor independence of the remaining obstructions. Its role is to demonstrate concretely that the proved support and collision restrictions, taken alone, do not eliminate all prime-to-five numerical orbit patterns—even for a cyclic group.

## 9. Failed routes and precisely unproved implications

### 9.1 Semisimplicity is not embedded-line descent

Prime-to-five deck representations are semisimple, but averaging a section can give zero or a section spanning a different line. Nothing here concludes that an arbitrary admissible embedded line is invariant. Lemma 2.2 descends only under its actual stabilizer. Lemma 6.1 is used only after a genuine degree-zero rank-two bundle containing three distinct embedded sublines has been constructed.

### 9.2 The torsion-support theorem is downstairs, not automatically upstairs

Theorem A controls divisor classes on the explicit base curve supported on \(R_X\). It does **not** assert that every degree-zero divisor supported on \(h^*R_X\) has prime-to-five order. New five-torsion in a Prym is not excluded by the computation. The support proof avoids this issue because (6.1) is an actual downstairs determinant line whose pullback is compared with \(\mathcal A^2\).

### 9.3 Fixed-selection persistence does not control arbitrary new selections

The fixed-selection obstruction remains a supplied tool, not a universal theorem. The new argument handles a range of newly appearing selections by putting all their conjugate actual lines in the same degree-zero modification. When the projected support has at least seven points, fewer than seven base points may be missed; this degree-zero argument no longer follows.

### 9.4 Scalar vanishing is not a witness

No scalar-survival statement beyond the supplied bounds has been proved. No vanishing of the class \(\epsilon\) is used as a sufficient condition. The exact divisor identity, nontrivial order-five class, and embedded adjunction are indispensable throughout.

### 9.5 A degree-four or degree-six stabilizer quotient is not automatically an actual order-five witness

Before the arithmetic elimination, the energy inequalities would reduce six-support candidates to orbit size four or six. Descent to the stabilizer quotient could introduce a twist. It would therefore be incorrect to assert that the original question had already reduced to order-five witnesses in those degrees. The determinant contradiction in Section 6 avoids that invalid inference and eliminates the case on the original Galois witness itself.

## 10. Remaining research problem

After this archive, an allowed witness must have all of the following: an actual connected everywhere-étale cover with prime-to-five geometric Galois monodromy; a nontrivial Frobenius-trivial order-five embedded line with its stated adjunction; exact scalar data \(q=f+b^5\), \(E\), \(G\), \(T\); projected support \(7\le r\le13\); and the collision restrictions of Theorem D.

After the stated quadratic refinement it must still supply actual functions \(z,u\) with the precise divisors and \(d(z^3/u)=df\), \(u\notin k(S)^5\). No construction or nonexistence proof for this remaining range is provided.

A complete resolution would need either an obstruction addressing that range while retaining the line and its connection, or a verified geometric cover and reconstruction. The finite-field certificate, the determinant formula, and the orbit inequalities are reusable inputs to that investigation; they are not a replacement for it.

