# Equivariant central extensions of the Heisenberg group

**Status:** author-checked theorem and local application, 2026-09-05.
**Author:** `/root/canonical_trace_algebra`.
**Boundary:** the cohomology calculation is standard and agrees with
Leary's explicit ring computation. The local consequence below excludes
the specified order-$5^5$ filtration, conditional on that filtration.
It does not derive the filtration from the numerical different alone,
exclude arbitrary larger wild groups, or alter the fixed curves.

## 1. Exact degree-two module and restriction to the center

Let $p>3$, and let

$$
 H=\langle x,y,z\mid x^p=y^p=z^p=1,\ z\text{ central},\
 [x,y]=z\rangle .
$$

Write $Z=\langle z\rangle\simeq\mathbf F_p$ and
$V=H/Z\simeq\mathbf F_p^2$. The commutator identifies
$Z\simeq\bigwedge^2V$. Coefficients $A=\mathbf F_p$ are trivial.

There is a natural exact sequence of $\operatorname{Aut}(H)$-modules

$$
 0\longrightarrow V^*
 \xrightarrow{\ \beta\ } H^2(H,\mathbf F_p)
 \xrightarrow{\ \mu\ } V^*\otimes Z^*
 \longrightarrow0.                                      \tag{1}
$$

Here the first arrow is the Bockstein on $H^1(H,\mathbf F_p)=V^*$.
In particular $\dim_{\mathbf F_p}H^2(H,\mathbf F_p)=4$. Also

$$
 \operatorname{res}^{H}_{Z}:H^2(H,\mathbf F_p)
       \longrightarrow H^2(Z,\mathbf F_p)
 \quad\text{is the zero map}.                            \tag{2}
$$

For a prime-to-$p$ subgroup $T\subset\operatorname{Aut}(H)$, Maschke's
theorem splits (1) as a $T$-module, giving

$$
 H^2(H,\mathbf F_p)|_T
 \simeq V^*|_T\oplus(V^*\otimes\det(V)^*)|_T.              \tag{3}
$$

No choice of a $T$-equivariant splitting is needed to deduce the
vanishing of invariants from the two displayed constituents.

### Proof by central extensions, including power data

Represent a class by a central extension

$$
 1\longrightarrow A\longrightarrow\widetilde H
 \longrightarrow H\longrightarrow1.
$$

Choose lifts $\widetilde x,\widetilde y$, and set
$\widetilde z=[\widetilde x,\widetilde y]$.
The group $\widetilde H$ has class at most three, with
$\gamma_3(\widetilde H)\subset A$; also
$\widetilde x^p,\widetilde y^p\in A$.
The class-three commutator collection identity gives, up to the harmless
choice of commutator convention,

$$
 1=[\widetilde x^p,\widetilde y]
   =\widetilde z^p
      [\widetilde z,\widetilde x]^{\binom p2}.
$$

Since $A$ has exponent $p$ and $p\mid\binom p2$, it follows that
$\widetilde z^p=1$. Thus the inverse image of $Z$ is the split elementary
abelian group $\langle\widetilde z,A\rangle\simeq C_p^2$.
This proves (2) for every class, without using a tame action.

The commutators

$$
 \mu(v,z)=[\widetilde z,\widetilde v]\in A                 \tag{4}
$$

are independent of the lifts and define an $\mathbf F_p$-bilinear map
$V\otimes Z\to A$. Changing a lift of $v$ by an element above $Z$
does not change (4), since that inverse image is abelian. The
commutators lie in the central group $A$, proving bilinearity.
This construction is natural under automorphisms and additive under
Baer sum, and so defines the arrow $\mu$ in (1).

If $\mu=0$, then $\widetilde H$ has class at most two.
The formula

$$
 \nu(v)=\widetilde v^p
$$

is now a well-defined linear map $V\to A$: the class-two power formula
has commutator correction divisible by $p$, and the commutator subgroup
has exponent $p$. If $\nu=0$, the generators
$\widetilde x,\widetilde y,\widetilde z$ satisfy the presentation of $H$,
and provide a section of the central extension. Thus $\nu$ is injective
on $\ker\mu$.

Every $\nu\in V^*$ is realized by pulling back

$$
 0\longrightarrow\mathbf F_p\longrightarrow
 \mathbf Z/p^2\mathbf Z\longrightarrow\mathbf F_p
 \longrightarrow0
$$

along $\nu:H\to\mathbf F_p$. These are exactly the Bockstein classes.
Consequently $\ker\mu\simeq V^*$, including the two possible power-data
parameters; they have not been discarded by assuming exponent $p$.

Finally, every map in the target of $\mu$ is realized. On the
four-dimensional $\mathbf F_p$-space with basis $x,y,z,a$, put

$$
 [x,y]=z,\qquad [z,x]=\gamma a,\qquad [z,y]=\delta a,
 \qquad a\text{ central}.                               \tag{5}
$$

For arbitrary $\gamma,\delta\in\mathbf F_p$, these brackets satisfy
Jacobi and have class at most three. The truncated
Baker–Campbell–Hausdorff law

$$
 u*v=u+v+\frac12[u,v]
        +\frac1{12}\bigl([u,[u,v]]+[v,[v,u]]\bigr)         \tag{6}
$$

therefore gives a group of order $p^4$ and exponent $p$.
The denominators are invertible because $p>3$.
Its quotient by $\langle a\rangle$ is $H$, and its map (4) has the
arbitrary specified coordinates $\gamma,\delta$ (up to the fixed
commutator sign convention). This proves surjectivity, hence (1).

Equations (5)–(6) also give explicit non-split central extensions when
there is no equivariance restriction. The assertion is not that all
central extensions of $H$ split.

### Primary-source check

Leary's [The mod-p cohomology rings of some p-groups](https://arxiv.org/pdf/0711.4831),
Theorem 6 and its proof (PDF pp. 6–9), give the four degree-two classes
$x,x',Y,Y'$: two Bocksteins and two triple Massey products.
The proof checks their independence by explicit restricted cocycles
and determines their automorphism action by naturality. This is an
exact match for the dimension and two kinds of classes in (1).
The argument above records the needed module filtration and
restriction-to-center fact directly in extension language; it does not
claim a new computation of the cohomology ring.

## 2. Cubic equivariance forces splitting

Suppose now $p\equiv-1\pmod3$, $p>3$, and $T=C_3$ acts irreducibly
on $V$. Its two eigenvalues over $\mathbf F_{p^2}$ are a primitive
cube root and its inverse. In particular $\det(V)|_T=1$, so $T$
acts trivially on $Z$. Equations (1)–(3) give

$$
 H^2(H,\mathbf F_p)|_{C_3}\simeq V^*\oplus V^*,
 \qquad H^2(H,\mathbf F_p)^{C_3}=0.                       \tag{7}
$$

For $p=5$, the characteristic polynomial of a generator on this
four-dimensional cohomology group is

$$
 (T^2+T+1)^2,
$$

and the determinant of its action minus the identity is $3^2=4$
in $\mathbf F_5$, so there is no fixed vector.

Hence every $C_3$-equivariant central extension of $H$ by a trivial
$C_5$ splits. Indeed, its extension class must be fixed, so is zero.
One can also choose an equivariant splitting: the set of sections is
a torsor under $\operatorname{Hom}(H,C_5)=V^*$, and averaging a
$C_3$-cocycle gives a fixed section because three is invertible.
Thus the split statement retains the given quotient map, not merely
the isomorphism type of the middle group.

The same vanishing holds for any trivial elementary-abelian coefficient
module $A$, by tensoring (1) with $A$. More generally, for any
prime-to-$p$ group $T$, it suffices that both
$(V^*)^T$ and $(V^*\otimes\det(V)^*)^T$ vanish.

**Limits:** a nontrivial action on a larger coefficient module can
introduce invariant tensor factors. The result is not an induction
through arbitrary kernels or arbitrary quotients. The assumption
$p>3$ is essential to the class-three construction used above.

## 3. A general local consequence of the splitting

Let $K=k((t))$ with $k$ algebraically closed of characteristic $p$.
Let $M/K$ be an actual Galois extension with group $H$ and largest
upper ramification break $u_0$. Suppose an actual central extension
$L/K$ of this fixed quotient has split group extension

$$
 1\longrightarrow C_p\longrightarrow\operatorname{Gal}(L/K)
 \longrightarrow H\longrightarrow1.
$$

Choose a section. The resulting second projection onto $C_p$ gives
a cyclic extension $N/K$, and

$$
 L=MN,\qquad M\cap N=K.
$$

Its nontrivial Artin–Schreier character has positive integral upper
break $n$, with $p\nmid n$. Upper ramification groups are compatible
with both quotient projections. Their kernels intersect trivially,
so the largest upper break of $L/K$ is exactly

$$
 \boxed{\max(u_0,n)}.                                    \tag{8}
$$

In particular, **a split central $C_p$ step cannot introduce a new
nonintegral largest upper break above $u_0$**. This is a
group-independent local consequence of splitting, and it does not
assume that an abstract group or ramification profile is realizable.

Combined with (7), this supplies a reusable equivariant-central
obstruction whenever the fixed quotient is Heisenberg and the tame
cubic action is irreducible on its abelianization.

## 4. The supplied order-$5^5$ profile is impossible

Assume an actual local inertia action has wild group $P$ of order
$5^5$ and a tame subgroup $C_3$, with the following lower groups.
The exponents here mean group orders, not an assumption that all
the groups are elementary abelian.

| Lower indices | Order |
| --- | --- |
| $1$ | $5^5$ |
| $2,\ldots,6$ | $5^3$ |
| $7,\ldots,66$ | $5^2$ |
| $67,\ldots,1116$ | $5$ |
| $1117,\ldots$ | $1$ |

The different contribution is indeed

$$
 (5^5-1)+5(5^3-1)+60(5^2-1)+1050(5-1)=9384.
$$

For the wild $P$-extension the upper breaks are

$$
 1,\qquad
 1+\frac5{25}=\frac65,\qquad
 \frac65+\frac{60}{125}=\frac{42}{25},\qquad
 \frac{42}{25}+\frac{1050}{625}=\frac{84}{25}.             \tag{9}
$$

Set $B=G_7$ and $A=G_{67}$. As ramification groups, both are normal
in the full inertia group and are preserved by the tame action.

### The Heisenberg quotient is forced

The quotient $Q=P/B$ has order $125$. Upper-quotient compatibility
gives its upper breaks $1,6/5$, equivalently lower breaks $1,6$.
Its subgroup $G_2/B$ has order five and is central, and its quotient
$P/G_2=G_1/G_2$ is elementary abelian of order 25.

The tame $C_3$ action on $G_1/G_2$ is irreducible: the first
ramification-grade embedding into $k$ makes it multiplication by
a primitive cubic scalar, and that scalar has degree two over
$\mathbf F_5$. Its action on the central order-five subgroup is
trivial because $\operatorname{Aut}(C_5)$ has order four.

The fifth-power map $Q/(G_2/B)\to G_2/B$ is linear and equivariant,
as in the class-two power calculation. Irreducibility forces it
to vanish, so $Q$ has exponent five. If $Q$ were abelian, its
nonintegral upper break $6/5$ would violate the integrality of
abelian upper jumps. Therefore $Q$ is precisely the exponent-five
Heisenberg group. No unspecified quotient-group hypothesis has
been assumed.

### The next central step must split

The quotient $R=P/A$ has order $625$ and upper breaks
$1,6/5,42/25$, equivalently lower breaks $1,6,66$.
There is an actual tame-equivariant exact sequence

$$
 1\longrightarrow B/A\longrightarrow R\longrightarrow Q
 \longrightarrow1.
$$

The kernel $B/A$ has order five and is normal in the $5$-group $R$,
so is central. The tame $C_3$ acts trivially on it. By (7) this
extension splits, retaining the given projection $R\to Q$.

Apply (8) to the corresponding local fields over $K=L_{\rm top}^P$.
The largest upper break of the $R$-extension must be either $6/5$
or an integer at least two. But (9) requires it to be $42/25$.
This is a contradiction.

Thus the supplied order-$5^5$ profile admits no local inertia action
with the stated tame cubic symmetry. The contradiction already
occurs in the order-$625$ quotient; no analysis of the final
relative break $1116$ is needed. The argument also avoids any
normalization of the weak quotient into a translation model.
