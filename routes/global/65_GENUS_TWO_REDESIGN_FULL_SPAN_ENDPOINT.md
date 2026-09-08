# The genus-two redesign and its full-span endpoint

## Status and purpose

**Status: proved; independent audit pending.**

Keep

\[
                 Y:\quad z^2=1-t^{31}
\]

over \(k=\overline{\mathbf F}_5\), but replace the genus-three curve in
the proposed counterexample by a genus-two curve \(X\).  This note proves
two things.

1. A common finite-etale cover again gives an exact order-seven diamond,
   but now the two maps to the fixed curves have degrees \(M\) and
   \(2M\).  The Jacobian norm forces \(M\geq8\).
2. If \(J(X)\) is absolutely simple, the endpoint \(M=8\) is impossible
   whenever all eight coefficients of the degree-seven norm polynomial
   are independent.

An explicit curve to which the theorem applies is

\[
             X_2:\quad u^2=x^5+4x^4+1.                 \tag{65.1}
\]

Its Jacobian is absolutely simple; a short exact certificate accompanies
this note.

The result is useful, but it also identifies the limitation of the
redesign.  It does **not** eliminate \(M=8\) when the coefficient span has
dimension \(3,4,5,6\), or \(7\).  Thus the genus-two pair is not yet a
strictly stronger proposed counterexample than the genus-three pair.

## 1. The modified seven-diamond

### Proposition 65.1 (genus-two order-seven reduction)

Let \(X/k\) be any smooth projective curve of genus two.  If \(X\) and
\(Y\) have a finite-etale cover in common, then there are smooth projective
curves \(V,C\), an integer \(M\geq2\), and finite-etale maps

\[
 \begin{array}{ccc}
 V&\xrightarrow{\ a\ }&Y\\
 \big\downarrow p&&\\[-2mm]
 C&\xrightarrow{\ c\ }&X
 \end{array}                                             \tag{65.2}
\]

such that

\[
 \deg a=M,\qquad \deg p=7,\qquad \deg c=2M,             \tag{65.3}
\]

the map \(p\) is a \(C_7\)-torsor with generator \(\beta\),

\[
                         a\beta\ne a,                    \tag{65.4}
\]

and

\[
                 g(V)=14M+1,\qquad g(C)=2M+1.            \tag{65.5}
\]

#### Proof

Take a connected common cover and then its connected Galois closure
\(W\to X\).  Let \(N=\deg(W/Y)\) and
\(G=\operatorname{Deck}(W/X)\).  Etale Riemann--Hurwitz gives

\[
                  |G|=\deg(W/X)=14N.                    \tag{65.6}
\]

Let \(P\) be a Sylow seven-subgroup of \(G\).  If the map
\(W\to Y\to S_0\), with \(S_0=\mathbf P^1(2,3,62)\), were invariant
under all of \(P\), it would descend through \(W/P\).  Writing
\(N=7^sM_0\), \(7\nmid M_0\), one would obtain

\[
                         g(W/P)-1=2M_0.                  \tag{65.7}
\]

On the other hand every smooth curve finite etale over \(S_0\) has
genus minus one divisible by seven, since

\[
                         \deg K_{S_0}=\frac{14}{93}.
\]

This contradicts (65.7).  Along a composition series of \(P\), choose
the first quotient \(P_{i+1}/P_i\simeq C_7\) at which invariance fails.
The coprime descent argument of file 38 applies unchanged through the
\(S_3\)- and \(C_{31}\)-torsors, so the chosen map to \(Y\) descends
through \(P_i\).  Put

\[
                   V=W/P_i,\qquad C=W/P_{i+1},
                   \qquad M=N/|P_i|.
\]

Then \(a:V\to Y\) has degree \(M\), \(p:V\to C\) is a \(C_7\)-torsor,
and

\[
             \deg(C/X)=\frac{14N}{7|P_i|}=2M.
\]

The first-failure choice gives (65.4), and Riemann--Hurwitz gives (65.5).
Finally \(M=1\) would give a nonvertical order-seven automorphism of
\(Y\), whereas \(\operatorname{Aut}(Y)=C_{31}\times C_2\); hence
\(M\geq2\).  \(\square\)

### Proposition 65.2 (the first endpoint is eight)

Every diamond (65.2) satisfies

\[
                              M\geq8.                    \tag{65.8}
\]

At \(M=8\), the nonzero homomorphism

\[
                 h=p_*a^*:J(Y)\longrightarrow J(C)      \tag{65.9}
\]

maps isogenously onto the entire Prym

\[
                 A:=\ker(c_*:J(C)\to J(X))^0.           \tag{65.10}
\]

#### Proof

The orbit-divisor argument of Lemma 40.2 depends only on
\(\deg p=7\) and the gonality of \(Y\), and proves \(h\ne0\).  File 40
proves that \(J(Y)\) is absolutely simple of dimension fifteen.  Hence
the image of \(h\) is a fifteen-dimensional simple abelian variety.

The composite \(c_*h:J(Y)\to J(X)\) is zero: a nonzero homomorphism from
the simple fifteen-fold \(J(Y)\) to the twofold \(J(X)\) is impossible.
Thus the image lies in (65.10), whose dimension is

\[
             g(C)-g(X)=2M-1.
\]

It follows that \(2M-1\geq15\), proving \(M\geq8\).  Equality of the
dimensions at \(M=8\) proves the last assertion. \(\square\)

## 2. The explicit absolutely simple genus-two curve

### Proposition 65.3

The curve \(X_2\) in (65.1) is smooth of genus two, and its geometric
Jacobian is absolutely simple.

#### Proof

In characteristic five the derivative of \(x^5+4x^4+1\) is \(x^3\),
which is coprime to the polynomial because its constant term is one.
The odd-degree hyperelliptic model is therefore smooth of genus two.

Direct point counting gives

\[
       \#X_2(\mathbf F_5)=7,\qquad
       \#X_2(\mathbf F_{25})=31.
\]

Consequently the Frobenius polynomial of its Jacobian is

\[
             P(T)=T^4+T^3+3T^2+5T+25.                  \tag{65.11}
\]

Its reduction modulo two is

\[
             T^4+T^3+T^2+T+1=\Phi _5(T),
\]

which is irreducible over \(\mathbf F_2\).  Thus \(P\) is irreducible
over \(\mathbf Q\), so the Jacobian is simple over \(\mathbf F_5\).
The coefficient of \(T^2\) is prime to five, so it is ordinary.

Let \(\pi\) be a root and \(K=\mathbf Q(\pi)\).  Modulo thirteen one has

\[
 P(T)=(T+3)(T+6)(T^2+5T+5),                            \tag{65.12}
\]

and the quadratic factor is irreducible because \(5\) is not a square
modulo thirteen.  Hence the Galois group of the splitting field contains
a transposition.  In particular the quartic field \(K\) is not normal.

The Weil involution \(\pi\mapsto5/\pi\) makes \(K\) a quartic CM field.
It is primitive: if it contained an imaginary quadratic subfield, its
compositum with the real quadratic subfield \(K^+\) would make \(K\)
biquadratic and therefore normal, contrary to (65.12).

For completeness, this already gives absolute simplicity directly.
The only proper subfield of this primitive quartic CM field is \(K^+\).
If \(\mathbf Q(\pi^n)\) were proper for some \(n>0\), then
\(\pi^n=\bar\pi^n\), so \(\pi/\bar\pi\) would be a root of unity in
\(K\).  A nonnormal quartic CM field contains no roots of unity other
than \(\{\pm1\}\): any further one generates an imaginary quadratic
field or the whole of a quartic cyclotomic, hence normal, field.  Neither
sign can occur here.  The sign \(+1\) would make \(\pi\) real, while the
sign \(-1\) would give \(\pi^2=-5\), contradicting the irreducibility of
(65.11).  Therefore

\[
                    \mathbf Q(\pi^n)=K\quad(n\geq1).
\]

The Frobenius polynomial over every finite extension consequently remains
the irreducible degree-four minimal polynomial of \(\pi^n\).  The
Jacobian remains simple over every finite extension, and hence is
absolutely simple over \(k\). \(\square\)

## 3. Excluding the full coefficient span at `M=8`

Retain a diamond (65.2) with \(M=8\).  Put

\[
 P(T)=\operatorname{Nm}_{V/C}(T-t),\qquad
 L=\mathcal O_C(2D_\infty),
\]

and let \(W\subseteq H^0(C,L)\) be the span of the eight homogeneous
coefficients of \(P\).  As in files 44 and 46,

\[
                 \deg L=16,\qquad 3\leq\dim W\leq8.    \tag{65.13}
\]

### Theorem 65.4 (no full-span endpoint)

Suppose that \(J(X)\) is absolutely simple.  Then a diamond with

\[
                         M=8,\qquad\dim W=8             \tag{65.14}
\]

does not exist.  In particular this applies to \(X=X_2\).

#### Proof

Let

\[
          \phi:C\longrightarrow\mathbf P(W^\vee)=\mathbf P^7
\]

be the coefficient map, let \(B\) be the normalization of its image, and
write

\[
 e=[k(C):k(B)],\qquad d=\deg\mathcal O_B(1).
\]

The coefficient-field argument of Proposition 47.1 uses only the norm
polynomial and gives

\[
                              ed=16.                    \tag{65.15}
\]

The image is nondegenerate, so \(d\geq7\).  Hence \(e=1\) or \(2\).
If \(e=1\), Castelnuovo's bound for a degree-sixteen curve in
\(\mathbf P^7\) is

\[
                 \pi(16,7)=12<17=g(C),
\]

a contradiction.  Therefore

\[
                   e=2,\qquad d=8,\qquad g(B)\leq1,    \tag{65.16}
\]

the last inequality being \(\pi(8,7)=1\).

Set

\[
 F=k(C),\qquad K=k(V),\qquad k(E)=k(B)(t).
\]

The normalized spectral square gives

\[
 [K:F]=[k(E):k(B)]=7,qquad [K:k(E)]=2,qquad
 [k(E):k(t)]=8.                                       \tag{65.17}
\]

Moreover \(P(T)\) is irreducible over \(k(B)\), and all its seven roots
lie in \(K\).  Its splitting field is thus either the degree-seven field
inside \(K\) or all of \(K\).  Since \(F/k(B)\) is quadratic, it follows
in either case that \(K/k(B)\) is Galois, with group \(C_{14}\) or
\(D_{14}\).

Let \(b=g(B)\).  The quadratic cover \(C\to B\) is tame and has

\[
                              r=36-4b                   \tag{65.18}
\]

branch points.  The cover \(K/F\) is etale, so all nontrivial inertia in
\(K/k(B)\) has order two.  Taking the quotient by a root stabilizer of
order two gives

\[
 g(E)=
 \begin{cases}
     7b-6,&\operatorname{Gal}(K/B)=C_{14},\\
     b+48,&\operatorname{Gal}(K/B)=D_{14}.
 \end{cases}                                           \tag{65.19}
\]

Indeed, in the cyclic case \(E\to B\) is etale.  In the dihedral case a
reflection has cycle type \(2^3 1\) on seven letters, and
Riemann--Hurwitz gives

\[
       2g(E)-2=7(2b-2)+3(36-4b)=2b+94.
\]

We next locate the hyperelliptic square root
\(z^2=1-t^{31}\).  If \(z\in k(E)\), then \(E\to Y\) is an intermediate
finite-etale cover of \(V\to Y\), of degree four.  It would have

\[
                              g(E)=4(15-1)+1=57,         \tag{65.20}
\]

which is none of the values in (65.19) for \(b\leq1\).  Hence

\[
                         z\notin k(E),\qquad K=k(E)(z). \tag{65.21}
\]

If \(b=0\), the cyclic case in (65.19) is already impossible, while the
dihedral case gives \(g(E)=48\).  But \(E\) then has separable maps of
coprime degrees seven and eight to \(B\simeq\mathbf P^1\) and
\(\mathbf P^1_t\).  Their function fields generate \(k(E)\), and the
Castelnuovo--Severi inequality gives

\[
                         g(E)\leq(7-1)(8-1)=42,
\]

again a contradiction.  Thus

\[
                                  b=1.                  \tag{65.22}
\]

It remains to use the two Pryms.  Let \(\gamma\) be the order-two root
stabilizer in \(\operatorname{Gal}(K/B)\), and let \(\delta\) be its
descent to \(C\).  Equation (65.21) gives

\[
                p\gamma=\delta p,\qquad a\gamma=\iota_Ya.
\]

Consequently

\[
                              \delta^*h=-h.             \tag{65.23}
\]

By Proposition 65.2, \(A=\operatorname{im}h\) is the entire
fifteen-dimensional Prym of \(c:C\to X\).  Put

\[
                              D=\operatorname{im}(c^*).
\]

Then \(\dim D=2\), the varieties \(A,D\) are orthogonal complements in
the principally polarized \(J(C)\), and their intersection is finite.
Since \(\delta\) preserves \(A\), it also preserves \(D\).  Transporting
its restriction through the isogeny \(c^*:J(X)\to D\) gives an element

\[
                    u\in\operatorname{End}^0(J(X)),\qquad u^2=1.
\]

Absolute simplicity makes this endomorphism algebra a division algebra,
so \(u=1\) or \(-1\).

We use the elementary rigidity fact that for nonconstant maps
\(f,g:T\to X\), with \(g(X)=2\), equality \(f^*=g^*\) implies \(f=g\).
Indeed, Abel--Jacobi shows that \(f\) and \(g\) differ by a translation
stabilizing the Abel--Jacobi copy of \(X\).  Its stabilizer is finite; a
nontrivial element would act freely on the genus-two curve, contradicting
\(g(X)-1=1\) by etale Riemann--Hurwitz.  Thus the translation is zero.

If \(u=1\), this rigidity gives \(c\delta=c\).  Then \(c\) factors through
the quotient \(C\to B\), impossible because that quotient is ramified at
the \(32\) points supplied by (65.18), while \(c\) is etale.  Therefore
\(u=-1\).  Since the hyperelliptic involution \(\iota_X\) acts as \(-1\)
on \(J(X)\), rigidity now gives

\[
                              c\delta=\iota_Xc.          \tag{65.24}
\]

Equations (65.23)--(65.24) put both \(A\) and \(D\) in
\(\operatorname{Prym}(C/B)\).  They have finite intersection, so their
sum has dimension

\[
                              15+2=17.
\]

But (65.22) gives

\[
                    \dim\operatorname{Prym}(C/B)=17-1=16,
\]

the final contradiction. \(\square\)

## 4. What polarization alone says at the endpoint

The equality case in Proposition 65.2 also gives an exact numerical test
for any later attack on the coefficient spans of dimensions three through
seven.

### Proposition 65.5 (the two-primary polarization constraint)

Assume \(M=8\), let

\[
 K_c=\ker(c^*:J(X)\to J(C)),\qquad |K_c|=2^r,
\]

and factor \(h\) as an isogeny followed by the inclusion of its image,

\[
                 J(Y)\xrightarrow{\varpi}A\lhook\joinrel\longrightarrow J(C),
                 \qquad d=\deg\varpi.
\]

Then

\[
                  0\leq r\leq4,
 \qquad
                  \deg(\lambda_A)=2^{16-2r},           \tag{65.25}
\]

where \(\lambda_A\) is the polarization induced from \(J(C)\).  If
\(s=h^\dagger h\in\operatorname{End}(J(Y))\), then

\[
                 \sqrt{\deg s}=d\,2^{8-r},
 \qquad
                 v_2(d)+8-r\equiv0\pmod5.              \tag{65.26}
\]

#### Proof

A torsion line bundle on \(X\) killed by pullback to the connected
degree-sixteen cover \(C\) is a character of a finite abelian quotient of
the monodromy group whose order divides sixteen.  Hence
\(|K_c|=2^r\) with \(0\leq r\leq4\).

Put \(D=\operatorname{im}(c^*)\).  Pulling its induced polarization back
to \(J(X)\) gives

\[
                         (c^*)^*\lambda_D=16\lambda_X.
\]

Since \(c^*:J(X)\to D\) has degree \(2^r\), taking degrees gives

\[
                         \deg\lambda_D=2^{16-2r}.
\]

At \(M=8\), the complementary subvariety \(A\) fills the Prym of \(c\),
so complementary-subvariety duality in the principally polarized
\(J(C)\) gives \(\deg\lambda_A=\deg\lambda_D\).  Pulling \(\lambda_A\)
back by \(\varpi\) now gives

\[
                         \lambda_Ys=\varpi^*\lambda_A,
\]

and hence the first equality in (65.26).

File 40 identifies the center of \(\operatorname{End}^0(J(Y))\), and
[the reduced-norm calculation](58_X_CENTRAL_GLUE_CONGRUENCES.md#5-local-restrictions-on-the-actual-norm-proposition-605) shows that the reduced norm of a Rosati-positive integral
endomorphism has norm from the real center equal to
\(\sqrt{\deg s}\).  The prime two is inert in that real degree-five
field.  Its valuation in this norm is therefore divisible by five.
Applying this to the first equality in (65.26) proves the congruence.
\(\square\)

For each \(r=0,1,2,3,4\), congruence (65.26) has nonnegative solutions
for \(v_2(d)\).  Thus the inert-prime polarization test by itself gives no
endpoint contradiction; it must be combined with the coefficient geometry
or with more information about the actual norm endomorphism.

## 5. Strategic boundary

For \(X=X_2\), any common cover now has either

\[
                         M\geq9,
\]

or

\[
             M=8\quad\text{and}\quad3\leq\dim W\leq7. \tag{65.27}
\]

The genus-two redesign therefore does create a rigid new endpoint, and
the full-span part of that endpoint is completely excluded by structural
arguments.  It does not remove the low-span alternatives (65.27).  Those
alternatives have additional coefficient-field factorizations because
\(16\) has several divisors; this is less arithmetically rigid than the
prime-square endpoint \(M=9\) in the genus-three construction.  On the
evidence currently proved, the redesign is a useful parallel test case,
not a replacement for the original pair.
