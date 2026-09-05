# The anti-invariant Prym decomposition at `M=9`

## Status and purpose

**Status: proved; independent audit pending.**

Assume the degree-nine, full coefficient-span configuration of files 47,
53, 56, and 58.  Thus

\[
 \begin{array}{ccc}
 V&\xrightarrow{a}&Y\\
 \downarrow p&&\\[-2mm]
 C&\xrightarrow{c}&X
 \end{array}
 \qquad
 \deg a=\deg c=9,qquad \deg p=7,
\tag{60.1}
\]

and there is a double cover

\[
                         q:C\longrightarrow B          \tag{60.2}
\]

with involution \(\delta\).  The order-two automorphism \(\gamma\) of
\(V\) satisfies

\[
 p\gamma=\delta p,qquad a\gamma=\iota_Ya,             \tag{60.3}
\]

and files 53 and 58 prove

\[
                         c\delta=\iota_Xc.             \tag{60.4}
\]

The first result below eliminates both rows with \(g(B)=2\) by dimension
alone.  If \(g(B)=1\), it gives an exact orthogonal decomposition of the
Prym up to a finite, purely 3-primary gluing.  We compute all possible
polarization types and derive local norm restrictions on the remaining
endomorphism of \(J(Y)\).

Throughout, put

\[
 J=J(Y),\qquad
 h=p_*a^*:J\longrightarrow J(C),qquad
 A=\operatorname{im}(h),\qquad
 D=\operatorname{im}(c^*),                             \tag{60.5}
\]

and let

\[
                         P=\operatorname{Prym}(C/B)
\tag{60.6}
\]

be the connected kernel of \(q_*\).

## 1. Both large subvarieties are anti-invariant

### Lemma 60.1

The involution \(\delta^*\) acts as \(-1\) on both \(A\) and \(D\).
Consequently

\[
                              A,D\subseteq P.          \tag{60.7}
\]

The variety \(A\) is simple of dimension fifteen, \(D\) has dimension
three, and \(A\cap D\) is finite.

#### Proof

Functoriality of pullback and norm under the square (60.3) gives

\[
\begin{aligned}
 \delta^*h
 &=\delta^*p_*a^*
   =p_*\gamma^*a^*
   =p_*(a\gamma)^*\\
 &=p_*a^*\iota_Y^*=-h.                                \tag{60.8}
\end{aligned}
\]

Likewise, (60.4) gives

\[
                    \delta^*c^*=(c\delta)^*
                       =c^*\iota_X^*=-c^*.             \tag{60.9}
\]

If a connected abelian subvariety is anti-invariant, its image under
\(q_*\) is both fixed and negated.  That image is connected and contained
in finite 2-torsion, so it is zero.  This proves (60.7).

File 40 proves that \(J\) is absolutely simple and that \(h\ne0\).
Hence \(h\) has finite kernel onto a simple fifteen-dimensional image.
The map \(c^*\) has finite kernel because \(c_*c^*=[9]\), so \(D\) has
dimension three.  A positive-dimensional intersection \(A\cap D\) would
be a nonzero abelian subvariety of the simple variety \(A\), hence would
have dimension fifteen; this is impossible inside \(D\).  Thus the
intersection is finite. \(\square\)

### Theorem 60.2 (the genus-two rows are impossible)

One cannot have \(g(B)=2\).  Therefore the two genus-two rows of (47.15)
do not occur.

#### Proof

Since \(g(C)=19\),

\[
                         \dim P=19-g(B).
\]

If \(g(B)=2\), this dimension is seventeen.  Lemma 60.1 puts in \(P\)
two subvarieties of dimensions fifteen and three with finite intersection.
Their sum has dimension eighteen, a contradiction. \(\square\)

## 2. The exact genus-one Prym decomposition

Assume from now on that \(g(B)=1\).  The double cover (60.2) is branched
at 36 points by Theorem 47.3.

### Proposition 60.3 (orthogonal filling of the Prym)

The Prym has dimension eighteen and its induced polarization has type

\[
                         (1^{17},2).                    \tag{60.10}
\]

The addition map

\[
                  \mu:A\times D\longrightarrow P       \tag{60.11}
\]

is an isogeny.  The two factors are orthogonal for the canonical
polarization of \(J(C)\).

#### Proof

For a double cover of a genus-\(b\) curve branched at \(r>0\) points,
the restriction of the Jacobian polarization to its Prym has type

\[
                    (1^{r/2-1},2^b).                  \tag{60.12}
\]

This follows, for example, by choosing branch cuts in the usual integral
homology calculation: the \(r/2-1\) branch-cut pairs are unimodular and
the \(b\) anti-invariant lifts of base pairs have intersection multiplied
by two.  The calculation is unchanged for a tame double cover in
characteristic five.  Taking \((b,r)=(1,36)\) gives (60.10).

Lemma 60.1 gives \(\dim A+\dim D=18=\dim P\) and finite intersection, so
(60.11) is an isogeny.

Finally, file 40 proves

\[
                         c_*h=0.                        \tag{60.13}
\]

The Rosati adjoint of \(c^*\) is \(c_*\).  Hence the pullback of the
polarization pairing between \(D\) and \(A\) is zero, which is exactly
their orthogonality. \(\square\)

## 3. The finite gluing and all polarization types

Let

\[
 K_c=\ker(c^*:J(X)\longrightarrow D),qquad
                         \kappa=|K_c|.                  \tag{60.14}
\]

### Proposition 60.4 (the four polarization possibilities)

One has

\[
                         \kappa\in\{1,3,9\}.            \tag{60.15}
\]

Write \(\lambda_D\) and \(\lambda_A\) for the polarizations induced from
\(J(C)\).  The 3-primary type of \(\lambda_D\), and hence that of
\(\lambda_A\), is one of

\[
\begin{array}{c|c|c}
K_c&\text{3-primary type of }\lambda_D
   &\text{full type of }\lambda_A\\ \hline
0&(9,9,9)&(1^{12},9,9,18)\\
C_3&(3,9,9)&(1^{12},3,9,18)\\
C_9&(1,9,9)&(1^{13},9,18)\\
C_3^2&(1,9,9)\text{ or }(3,3,9)
 &(1^{13},9,18)\text{ or }(1^{12},3,3,18).
\end{array}                                             \tag{60.16}
\]

In particular, if \(r=\log_3\kappa\), then

\[
 \deg\lambda_D=3^{12-2r},\qquad
 \deg\lambda_A=4\cdot3^{12-2r}.                       \tag{60.17}
\]

The kernel of (60.11) is purely 3-primary.  Its projection to either
factor identifies it with the full 3-primary polarization kernel, so

\[
 |A\cap D|=3^{12-2r}.                                  \tag{60.18}
\]

#### Proof

A line bundle on \(X\) trivialized by the connected degree-nine cover
\(C\to X\) defines a finite abelian quotient of the geometric monodromy
whose kernel contains the subgroup corresponding to \(C\).  The order of
that quotient divides the index nine.  Equivalently, the character group
\(K_c\) has order dividing nine.  Since \(c_*c^*=[9]\), its exponent also
divides nine.  This proves (60.15) and leaves the four group structures in
(60.16).

The pullback of the induced polarization is

\[
                   (c^*)^*\lambda_D=9\lambda_X.         \tag{60.19}
\]

Thus \(K_c\) is an isotropic subgroup of the symplectic module
\(J(X)[9]\simeq(\mathbf Z/9)^6\), and

\[
                   \ker\lambda_D=K_c^\perp/K_c.         \tag{60.20}
\]

The elementary-divisor calculation in this six-dimensional symplectic
module gives, respectively,

\[
 (9,9,9),\quad(3,9,9),\quad(1,9,9),quad
 (1,9,9)\text{ or }(3,3,9).                            \tag{60.21}
\]

For clarity, the last two alternatives for \(C_3^2\) correspond to
whether its image in \(J(X)[3]\) spans a nondegenerate or an isotropic
plane.  Formula (60.17) for \(\lambda_D\) also follows immediately from
(60.19) by taking degrees.

At every odd prime, (60.10) is principal.  The usual complementary-
subvariety calculation in a principally polarized Tate module therefore
identifies the polarization kernels of the two orthogonal factors in
(60.11), with opposite commutator pairings.  Hence the 3-primary type of
\(\lambda_A\) is the same as that of \(\lambda_D\), and the addition
kernel is the graph of the resulting anti-isometry.

At two, \(\lambda_D\) is principal by (60.19).  The kernel of the
addition isogeny embeds in both polarization kernels, so it has no
2-primary part.  Thus (60.11) is an isomorphism on 2-adic Tate modules,
and the single elementary divisor two in (60.10) belongs to
\(\lambda_A\).  Combining this with the 3-primary list (60.21) gives the
full types in (60.16).  The order of the common 3-primary polarization
kernel is its polarization degree, namely (60.18). \(\square\)

## 4. Consequences for the Rosati norm on `J(Y)`

Factor \(h\) as

\[
            J\xrightarrow{\varpi}A\hookrightarrow J(C),
\qquad d=\deg\varpi,                                   \tag{60.22}
\]

and put

\[
                         s=h^\dagger h\in\operatorname{End}(J).
\tag{60.23}
\]

### Proposition 60.5 (local norm restrictions)

With \(r=\log_3\kappa\),

\[
 \sqrt{\deg s}=d\,2\,3^{6-r}.                         \tag{60.24}
\]

Moreover

\[
 v_2(d)\equiv4\pmod5,qquad
 v_3(d)\equiv r-1\pmod5.                              \tag{60.25}
\]

In particular, the second congruence reads

\[
\begin{array}{c|ccc}
r&0&1&2\\ \hline
v_3(d)\pmod5&4&0&1.
\end{array}                                             \tag{60.26}
\]

The endomorphism \(s\) cannot be multiplication by a rational integer.

#### Proof

Pullback of the induced polarization gives

\[
                    \varpi^*\lambda_A=\lambda_Js.
\tag{60.27}
\]

Taking degrees and using (60.17) proves (60.24).

File 40 identifies the center of \(\operatorname{End}^0(J)\) with the
degree-ten CM field

\[
 E=\mathbf Q(\zeta_{31})^{\langle5\rangle}.
\]

Its maximal real subfield \(E^+\) has degree five.  If
\(n=\operatorname{Nrd}_{\mathscr D/E}(s)\), Rosati symmetry gives
\(n\in E^+\), and integrality of \(s\) makes \(n\) an algebraic integer.
The Tate determinant formula is

\[
 \deg s=N_{E/\mathbf Q}(n)
       =N_{E^+/\mathbf Q}(n)^2.                         \tag{60.28}
\]

Both 2 and 3 are inert in \(E^+\).  Indeed, their classes have order five
in

\[
 (\mathbf Z/31)^\times/langle-1,5\rangle;
\]

one has \(2^5\equiv1\) and \(3^5\equiv-5\pmod{31}\), with no smaller
positive exponent landing in \(\langle-1,5\rangle\).  Therefore the
2- and 3-adic valuations of \(|N_{E^+/\mathbf Q}(n)|\) are multiples of
five.  Applying this to (60.24) gives

\[
 v_2(d)+1\equiv0\pmod5,qquad
 v_3(d)+6-r\equiv0\pmod5,
\]

which is (60.25).

Finally, every type in (60.16) has exponent eighteen.  If \(s=[m]\),
then (60.27) realizes \(\lambda_A\) as a quotient of \(m\lambda_J\), so
the exponent of \(\ker\lambda_A\) divides \(m\).  Hence \(18\mid m\).
On the other hand Proposition 42.1 gives

\[
 \operatorname{Tr}(s\mid H^1(Y))
       =378-\sum_{j=1}^6 I_j\leq378.                    \tag{60.29}
\]

For \(s=[m]\), the left side is \(30m\), whereas \(m\geq18\) would make
it at least 540.  Thus \(s\) is not scalar. \(\square\)

## 5. Exact remaining obstruction

The genus-two coarsenings are now eliminated.  In genus one, the
polarization calculation does not by itself produce a contradiction:
quotients of a principally polarized fifteen-fold can have each of the
four types in (60.16).  What is special here is that the quotient must be
produced by the geometric norm (60.23).

Thus an endomorphism-theoretic continuation has a precise target.  One
must rule out a **noncentral** positive Rosati-symmetric endomorphism
\(s\in\operatorname{End}(J(Y))\) satisfying simultaneously

\[
 0<s<[63],\qquad
 \operatorname{Tr}(s)\leq378,                          \tag{60.30}
\]

the four polarization-kernel possibilities (60.16), and the valuation
conditions (60.25).  Alternatively one may use the simultaneous
\(C_{14}\)- or \(D_{14}\)-cover geometry to exclude the two remaining
genus-one rows directly.  No contradiction from the rational Honda
algebra alone is asserted here.
