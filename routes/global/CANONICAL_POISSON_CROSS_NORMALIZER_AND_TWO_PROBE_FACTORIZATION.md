# Canonical Poisson cross-normalizers and a two-probe factorization test

Date: 2026-09-05. Author: /root/structural_poisson_cross_normalizer.
Status: proved below; not independently audited. These are structural
descent criteria, not a common-cover nonexistence theorem.

Let k be algebraically closed of characteristic 5. Let g:Z -> Y be a
finite etale map of smooth projective connected curves of genus at least
two, of degree d. Identify B=R(Y) with its actual differential pullback
inside S=R(Z). Use the canonical bracket and its sign convention from
[the canonical Poisson-ring note](CANONICAL_POISSON_RINGS_RETAIN_EXACTLY_THE_ETALE_CONDITION.md):
\[
 \{a u^m,b u^n\}=(n bD(a)-m aD(b))u^{m+n+1},\qquad da=D(a)u.
\]
Define a graded vector space, not an asserted associative subalgebra,
\[
 N_m=\{s\in S_m:\{s,B\}\subseteq B\},\qquad N=\bigoplus_{m\ge0}N_m.
\]
It is a Lie normalizer by Jacobi. Central elements belong to it, but
multiplying a normalizing element by an arbitrary central element need
not preserve normalization.

## 1. Complete graded normalizer

**Theorem 1.** The following hold.

1. N_0=k, and N_m=B_m whenever 5 does not divide m.
2. For every integer q>=1 there is an exact identification
   \[
   \frac{N_{5q}}{B_{5q}+S_q^5}
   \simeq
   \ker\left[
   g'^*:H^1(Y',\omega_{Y'}^q)\longrightarrow
              H^1(Z',\omega_{Z'}^q)\right].                 \tag{1}
   \]
   Here Y',Z' are the Frobenius twists, g' is the twisted map, and
   S_q^5 denotes the subspace of fifth powers of sections of weight q.
3. Consequently N_{5q}=B_{5q}+S_q^5 for q>=2. This equality also holds
   for q=1 when 5 does not divide d. When 5 divides d, the quotient
   N_5/(B_5+S_1^5) has dimension exactly one over k.

In particular the possible extra degree-five class is an actual global
descent obstruction; it must not be discarded by asserting that the
normalizer is always B+S^5.

**Proof in weights prime to 5.** Put K=k(Y), L=k(Z), and choose a
nonzero rational differential u on Y, also denoting its pullback by u.
The homogeneous fraction rings are K[u,u^{-1}] and L[u,u^{-1}]. If
s=a u^m normalizes B, its Hamiltonian derivation takes Frac(B) into
Frac(B), by the quotient rule. Choose b in K with D(b) nonzero. Then
\[
                 \{s,b\}=-m aD(b)u^{m+1}.                \tag{2}
\]
For m nonzero in k, (2) forces a in K. Thus s is a rational form
descended from Y. It is regular downstairs because its pullback is
regular and g is finite etale and surjective. Equivalently, use
integrality of S over the normal ring B. The reverse inclusion is
internal bracket closure of B. Weight zero is immediate.

**Proof in weights 5q.** There is a canonical connection
\[
 \nabla:\omega_Y^{5q}\longrightarrow\omega_Y^{5q+1},
 \qquad a(dx)^{5q}\longmapsto da\,(dx)^{5q}.             \tag{3}
\]
It is well-defined because the transition functions of omega^{5q}
are fifth powers, whose derivatives vanish. Define the same connection
on Z. For a section t of weight n,
\[
                         \{s,t\}=n t\nabla s.           \tag{4}
\]
It follows that
\[
 s\in N_{5q}\quad\Longleftrightarrow\quad
 \nabla s\text{ is pulled back from a regular section on }Y.
                                                               \tag{5}
\]
For the forward implication, bracket with a nonzero rational
degree-one form from Y, using the localized normalizer property.
This descends nabla(s) rationally. Regularity then descends along g.
The reverse implication follows directly from (4).

For completeness, relative Frobenius makes the relevant local-exactness
statement and its global obstruction precise. Write F_Y:Y -> Y' and
\[
 \mathcal B_Y^1=\operatorname{im}
       (F_{Y*}\mathcal O_Y\xrightarrow{d}F_{Y*}\omega_Y).
\]
The usual exact sequence for differentiation on a smooth curve, tensored
with omega_{Y'}^q and using the projection formula, is
\[
 0\longrightarrow\omega_{Y'}^q
 \xrightarrow{F}\ F_{Y*}\omega_Y^{5q}
 \xrightarrow{\nabla}\mathcal Q_{Y,q}
 \longrightarrow0,
 \qquad \mathcal Q_{Y,q}=\mathcal B_Y^1\otimes\omega_{Y'}^q.
                                                               \tag{6}
\]
Locally, the kernel consists exactly of fifth powers; this proves
exactness. The sheaf Q_{Y,q} embeds in F_{Y*}omega_Y^{5q+1}.
Relative Frobenius commutes with etale base change. Hence (6) pulls
back along g' to the corresponding sequence on Z'. In particular a
section downstairs belongs to Q_{Y,q} if its pullback does, by faithful
flatness. This also follows from Cartier compatibility and its kernel
being the locally exact forms.

Thus (5) associates to s in N_{5q} a unique section
\[
             t\in H^0(Y',\mathcal Q_{Y,q}),\qquad
             g'^*t=\nabla s.
\]
Let delta_Y and delta_Z be the connecting maps of (6). The precise
condition for t to admit such an s is
\[
                  g'^*\delta_Y(t)=\delta_Z(g'^*t)=0.     \tag{7}
\]
Moreover delta_Y is surjective: H^1(Y,omega_Y^{5q})=0 for q>=1 by
Serre duality and g(Y)>=2. Consequently every element of the kernel
on the right side of (1) is delta_Y(t) for a t satisfying (7), and
then g'^*t lifts to a global section s on Z. The kernel of the map
s -> delta_Y(t) consists exactly of B_{5q}+S_q^5: if delta_Y(t)=0,
subtract a section from Y lifting t; the difference has zero nabla
and is a fifth power on Z. This proves (1), including surjectivity.
All maps in (6) are k-linear with the relative Frobenius twists as
written. Under the usual untwisted notation the power map is
semilinear, but its image is a k-subspace because k is perfect.

For q>=2, H^1(omega^q)=0. For q=1, Serre duality identifies both
H^1 spaces with k. Pullback on H^1(omega) is dual to the trace on
H^0(O), and the latter sends 1 to d. The map in (1) is therefore
multiplication by d, up to the canonical duality identifications.
Its kernel is zero if 5 does not divide d and one-dimensional
otherwise. This proves all the assertions. QED.

## 2. Two tricanonical probes suffice

**Lemma 2 (homogeneous reconstruction identity).** For homogeneous
alpha of weight m and beta,gamma both of weight n in the same
canonical Poisson fraction ring,
\[
 m\alpha\{\beta,\gamma\}
       =n\bigl(\beta\{\alpha,\gamma\}
                        -\gamma\{\alpha,\beta\}\bigr).  \tag{8}
\]
The integers in this identity are scalars in k. To check signs, write
alpha=a u^m, beta=b u^n, gamma=c u^n. Both sides equal
mn a(cD(b)-bD(c))u^{m+2n+1}. In particular the terms involving D(a)
cancel on the right.

Choose beta,gamma in B_3 with {beta,gamma} nonzero. Such a choice
exists: the tricanonical embedding is an immersion, so among the
ratios of its coordinates some beta/gamma has nonzero differential.
Since 3 is nonzero in k, its bracket is nonzero as well.

**Theorem 3 (exact two-probe factorization criterion).** Suppose also
f:Z -> X is finite etale, let A=f^*R(X) inside S, and choose homogeneous
algebra generators alpha_1,...,alpha_r of A, all of weights 1,2,3.
For the fixed beta,gamma above, the following are equivalent:

1. There is a finite etale map h:Y -> X with f=h o g.
2. A is contained in B.
3. For every i, {alpha_i,beta} and {alpha_i,gamma} belong to B.
4. Every alpha_i belongs to the Poisson normalizer of B.

Thus exactly 2r mixed-bracket membership tests, each of weight at
most seven, suffice. They are linear subspace membership conditions
in B_{deg(alpha_i)+4} inside S_{deg(alpha_i)+4}. No choice of all
target algebra generators is needed.

**Proof.** (1) implies (2), and (2) implies (3) and (4) by internal
bracket closure. From (3), (8), with n=3 and m=deg(alpha_i), gives
\[
 \alpha_i=\frac{3}{m}
 \frac{\beta\{\alpha_i,\gamma\}-\gamma\{\alpha_i,\beta\}}
      {\{\beta,\gamma\}}\in\operatorname{Frac}(B).      \tag{9}
\]
Regularity descends, or integrality and normality apply, so alpha_i
belongs to B. This proves (2). From (4), Theorem 1 gives the same
conclusion since the generator weights are prime to 5. Finally,
(2) gives h:Y -> X by the canonical Poisson-ring reconstruction
theorem, and equality of pullbacks gives f=h o g. The differential
of h cannot have a zero: its pullback along the surjective etale
map g would give a zero of df. Hence h is finite etale. QED.

If Hom(J_X,J_Y)=0, these equivalent conditions cannot occur. Indeed
h^*:J_X -> J_Y would be nonzero, since h_*h^*=[deg h] and multiplication
by a positive integer is a nonzero isogeny, including when 5 divides
deg h. Therefore every actual common etale cover for such a pair
must fail at least one of the 2r cross-bracket memberships. This is
a necessary failure of nesting, not a contradiction to existence
of a common cover.

## 3. What trace and Cartier compatibility do not supply

The two separate Poisson embeddings supply internal bracket closure,
{A,A} contained in A and {B,B} contained in B. They do not supply any
of the mixed memberships in Theorem 3. The complete normalizer
calculation makes the desired extra assertion precise; it does
not make that assertion automatic.

For r in B and s in S, etale trace is compatible with the bracket:
\[
          \operatorname{Tr}_g\{r,s\}
                =\{r,\operatorname{Tr}_g(s)\}.          \tag{10}
\]
This follows after etale local splitting, where trace is a sum and
differentiation commutes with the sum. But (10) only specifies the
trace of a mixed bracket. It says nothing about its component outside
B. When 5 does not divide d, membership in B can be tested by equality
with d^{-1}g^*Tr_g(s); compatibility does not assert this equality.
When 5 divides d, trace even vanishes on B itself.

Cartier compatibility enters (6)-(7) by descending *local exactness
after a differential has already descended*. It does not show that
a mixed bracket, or that differential, descends in the first place.
The exceptional degree-five class describes the remaining obstruction
to splitting a normalizer element into a base section and a fifth
power. It has no effect on source generators of weights at most
three, which are the elements needed for Theorem 3.

Likewise, commuting multiplication matrices and determinant norms in
[the fixed-weight norm note](FIXED_WEIGHT_NORMS_AND_COMMUTING_CANONICAL_RING_REALIZATION.md)
retain sheets and products but do not identify the Hamiltonian action
of one leg on the other leg with a descended action.

The precise missing input is an independent, pair-specific reason
forcing the two-probe memberships (or another condition implying
them). Hom(J_X,J_Y)=0 alone cannot provide that reason: it would
contradict known actual common-cover examples with that Hom vanishing.
