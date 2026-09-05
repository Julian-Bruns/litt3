# The sign norm carries the even branching

**Status: proved; independently audited (PASS, 2026-09-04).**

Auditor: `c14_elliptic_translation`.
[Verdict and non-breaking observations](audits/83_SIGN_NORM_BRANCH_CARRIER_AND_COPRIME_DESCENT_AUDIT.md).
No breaking objections were found.

This is an all-degree refinement of the full-orbit construction in file
81. It does not assume that a field intersection has its expected degree.
Instead it constructs an explicit quadratic subfield using the product of
the hyperelliptic square roots. When the residual covering degree is prime
to the orbit prime, all branching is carried by this one double cover.

The assertions are parameterized in the orbit prime and both genera. They
do not require classifying subgroups of a signed permutation group.

## 1. Setup

Work over an algebraically closed field of characteristic different from
two and from an odd prime \(r\). Use the notation and conclusions of file
81:

\[
g(X)=s+1,\quad g(Y)=rs+1,\quad k(Y)=k(t,z),\quad z^2=f(t),
\]

\[
V\xrightarrow{a}Y,\qquad V\xrightarrow{p}C\xrightarrow{c}X,
\qquad \deg a=\deg c=M,\quad \deg p=r,
\]

where all three maps are finite etale, \(p\) is cyclic with generator
\(\beta\), and \(a\beta\ne a\). Set

\[
F=k(C),\quad K=k(V),\quad t_i=\beta^i(t),\quad z_i=\beta^i(z),
\quad P(T)=\prod_i(T-t_i).
\]

Let \(B\) be the coefficient field of \(P\), let \(D\subset F\) be
the full interpolation field, and put

\[
E=B(t),\quad E'=B(t,z),\quad E_*=D(t)=D(t,z),
\quad L=B(t_i,z_i:0\le i<r).
\]

Write

\[
e=[F:B],\quad j=[D:B],\quad m=[F:D],\quad d=[E:k(t)].
\]

Then \(e=mj\), \(ed=2M\), \([K:E_*]=m\), and
\(E_*\subseteq L\subseteq K\). All these function fields are
separable over \(B\). As usual we also denote their smooth projective
curves by the field letters.

Let

\[
H=\operatorname{Gal}(L/B)\subseteq (C_2)^r\rtimes S_r.
\]

The stabilizer \(H_0\) of the chosen sign selection
\(\{(t_i,z_i)\}_i\) has fixed field \(D\), contains \(\beta\), and
embeds in \(S_r\).

Define the explicit sign norm and its field by

\[
w=\prod_{i=0}^{r-1}z_i,\qquad
w^2=\operatorname{Norm}_{E/B}(f(t)),\qquad A=B(w).
\tag{83.1}
\]

Since \(\beta\) fixes \(w\), this field is contained in \(F\).
In fact \(A\subseteq D\): the stabilizer \(H_0\) permutes the chosen
\(z_i\), and therefore fixes their product. Put

\[
\epsilon:H\longrightarrow C_2,\qquad
\sigma(w)=(-1)^{\epsilon(\sigma)}w,\qquad
\nu=[A:B]\in\{1,2\}.
\]

Thus \(A=L^{\ker\epsilon}\), and \(\nu=1\) precisely when the norm
in (83.1) is a square in \(B\).

## 2. Uniform inertia and the canonical branch carrier

### Theorem 83.1

In the above setting:

1. \(j\equiv1\) or \(2\pmod r\), and \(v_r(|H|)=1\).
2. Every inertia group of \(L/B\) is tame cyclic, of order
   \(1,2,r\), or \(2r\). Its intersection with \(\ker\epsilon\)
   has order either one or \(r\).
3. Every ramification index of \(C/A\) is either one or \(r\).
4. If \(r\nmid m\), then
   \[
                   L/A,\quad C/A,\quad D/A
                   \quad\text{are finite etale}.
   \tag{83.2}
   \]
   In particular,
   \[
       g(A)=\frac{\nu ds}{2}+1,\qquad
       [C:A]=\frac{mj}{\nu},\qquad
       g(D)=\frac{jds}{2}+1.
   \tag{83.3}
   \]

Thus in the coprime case the explicit map \(A\to B\), of degree at
most two, accounts for all ramification above the coefficient curve.

#### Proof

Identify sign selections with the vertices of \(\{0,1\}^r\), with the
chosen selection at zero. The coordinate cycle \(\beta\) has exactly
two fixed vertices: zero and the all-one vertex. Its other orbits have
size \(r\). The \(H\)-orbit of zero is \(\beta\)-stable and contains
zero, so its size \(j\) is congruent to one or two modulo \(r\).
In particular \(r\nmid j\). Since \(H_0\subseteq S_r\) contains an
\(r\)-cycle, \(v_r(|H_0|)=1\); multiplying by its index \(j\) proves
the first assertion.

The maps \(K\to L\to E'\to Y\) are intermediate maps of the etale
map \(V\to Y\), and hence are etale. The stabilizer in \(H\) of a
signed root \((t_i,z_i)\) is a conjugate of
\(\operatorname{Gal}(L/E')\); the negative root has the same
stabilizer. Consequently inertia in \(L/B\) acts freely on all \(2r\)
signed roots. Its order divides \(2r\). Because the characteristic
divides neither two nor \(r\), the inertia is tame and cyclic, without
any assumption that the characteristic is prime to \(|H|\).

We need the following elementary parity fact. If a signed permutation
\(\tau\) is an involution and is fixed-point-free on signed roots,
then

\[
                            \epsilon(\tau)=1.           \tag{83.4}
\]

Indeed, its coordinate permutation is an involution on the odd number
\(r\) of coordinates, and hence has an odd number of fixed coordinates.
At each fixed coordinate, fixed-point-freeness forces a sign change.
On each transposed coordinate pair, the two sign changes agree because
\(\tau^2=1\), and therefore contribute even parity. The total sign
parity is odd. For cyclic inertia of order two or \(2r\), apply (83.4)
to its unique involution. Its intersection with \(\ker\epsilon\)
therefore has order one or \(r\); odd inertia of order \(r\) already
lies in the kernel. This proves assertion 2.

The inertia groups of \(L/A\) are precisely these intersections.
Since \(K/L\) and \(K/F\) are etale, multiplicativity of local
ramification indices shows that \(F/A\) has the same ramification
indices as \(K/A\), namely one or \(r\). This proves assertion 3.

Suppose now that \(r\nmid m\). Since \([K:L]\mid m\), the order-
\(r\) automorphism \(\beta\) cannot fix a point of \(L\): otherwise
its action on the etale fiber in \(V\), of cardinality \([K:L]\),
would be free, since \(\beta\) acts freely on \(V\). That would
force \(r\mid[K:L]\). Every subgroup of order \(r\) in \(H\) is a
Sylow subgroup by assertion 1, and hence is conjugate to
\(\langle\beta\rangle\). No inertia group can therefore contain an
element of order \(r\). The inertia of \(L/A\) is trivial by
assertion 2. This proves that \(L/A\) is etale.

The etaleness of \(K/L\), followed by passage to intermediate fields
\(F\) and \(D\), proves the rest of (83.2). Finally,

\[
g(C)-1=Ms=\frac{mj}{\nu}\bigl(g(A)-1\bigr),
\qquad M=\frac{mjd}{2},
\]

which gives (83.3). \(\square\)

## 3. A square sign norm forces a uniform spectral bound

### Theorem 83.2

Assume that \(\operatorname{Norm}_{E/B}(f(t))\) is a square in \(B\).
Then \(E'\to E\) is etale and

\[
                         g(E)=\frac{drs}{2}+1.         \tag{83.5}
\]

Let \(b=g(B)\). The spectral incidence gives

\[
                         b\ge\frac{ds}{2}
                                 -\frac{(r-1)d}{r}+1.
\tag{83.6}
\]

If the coefficient system is nonpencil, so its birational image has
degree \(d\) in projective dimension at least two, then

\[
                              d\ge s+2.                \tag{83.7}
\]

If also \(r\nmid m\), then the stronger conclusions hold:

\[
                        b=\frac{ds}{2}+1,
                        \qquad d\ge s+3.               \tag{83.8}
\]

#### Proof

The square-norm assumption says \(\epsilon=0\). By the parity fact
(83.4), no inertia group of \(L/B\) can have even order. Consequently
all ramification indices in its intermediate covers are odd. The
extension \(E'/E\) has degree at most two, so is unramified, including
the possibility that it is the identity.

Put \(\lambda=[E':E]\in\{1,2\}\). Since \([Y:k(t)]=2\), the
etale map \(E'\to Y\) has degree \(\lambda d/2\). Thus

\[
g(E')-1=\frac{\lambda d}{2}\,rs
       =\lambda\bigl(g(E)-1\bigr),
\]

which gives (83.5).

The integral incidence curve \(P(T)=0\) in \(B\times\mathbf P^1\)
has normalization \(E\) and divisor class with degrees \(r,d\) over
the two projections. Its arithmetic genus is

\[
                         rb+(r-1)(d-1).
\]

This follows directly from adjunction on the product; its equation has
coefficient line bundle of degree \(d\). Comparing arithmetic and
geometric genus with (83.5) gives (83.6).

A birational projective curve of degree \(d\), not contained in a
line, has geometric genus at most \((d-1)(d-2)/2\), by a general
birational plane projection and the plane genus bound. Hence (83.6)
implies

\[
d\ge s+1+\frac2r.
\]

Since \(d,s\) are integers and \(r\ge3\), this is (83.7). Finally,
when \(r\nmid m\), Theorem 83.1 gives \(A=B\) and
\(b=ds/2+1\). The same plane bound then gives
\(d(d-s-3)\ge0\), proving (83.8). \(\square\)

## 4. What this does and does not resolve

The theorem replaces an unspecified choice of a quadratic core by the
explicit sign norm (83.1). In the coprime residual case, it produces an
actual etale span

\[
                              X\longleftarrow C\longrightarrow A.
\]

The lower curve \(A\) carries a map of degree at most two to the
coefficient curve. Neither that span nor (83.3) asserts that \(A\)
maps to \(Y\), that its involution lifts to \(C\), or that it yields
a smaller common cover of the original pair. Those remain separate
questions.

The lower bounds on \(d\) are uniform in \(M\), but do not exclude
arbitrarily large \(d\). For nonsquare norm the theorem instead
isolates the branching in a canonical double cover; controlling that
cover, or proving that it descends further, is still necessary for an
all-degree nonexistence theorem.
