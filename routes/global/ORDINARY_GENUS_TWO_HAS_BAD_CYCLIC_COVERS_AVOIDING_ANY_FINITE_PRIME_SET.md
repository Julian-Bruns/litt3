# Bad cyclic covers of ordinary genus-two curves avoiding any finite prime set

Date: 2026-09-05.
Author: `/root/x_elliptic_quotient_maps`.
Status: proved from the cited theorems, with their quantifiers checked.
This is a literature corollary, not a novelty claim.

## The result

**Theorem 1.**  Let `C` be any ordinary smooth projective genus-two curve
over `k=Fbar_5`, and let `S_0` be any finite set of primes containing
five.  There is a connected cyclic finite etale cover

\[
                         \pi:D\longrightarrow C             \tag{1.1}
\]

whose degree is coprime to every prime in `S_0` and whose source `D` is
nonordinary.

Moreover, there is a nested tower

\[
 \cdots\longrightarrow C_j\longrightarrow C_{j-1}
       \longrightarrow\cdots\longrightarrow C_1\longrightarrow C       \tag{1.2}
\]

such that:

1. every composite `C_j -> C` is connected, cyclic, and etale;
2. the successive degrees can be chosen pairwise coprime and prime to
   five;
3. the `a`-numbers and the 5-rank defects satisfy

\[
                  a(C_j)\ge j,
                  \qquad g(C_j)-f(C_j)\ge j.              \tag{1.3}
\]

In particular both quantities are unbounded in this tower.

## 1. Prime-avoiding torsion on every open part of theta

Put

\[
 A=J(C^{(1)}),\qquad
 \mathcal B_C=F_{C/k*}\mathcal O_C/\mathcal O_{C^{(1)}},
\]

and let

\[
 \Theta_C=\{L\in A:
 H^0(C^{(1)},\mathcal B_C\otimes L)\ne0\}.                \tag{2.1}
\]

Raynaud's theorem makes this a proper effective divisor.  Tong proves
that, for an ordinary genus-two curve, every irreducible component of
`Theta_C` is ample.  The exact source is
[Tong, Corollary 4.2.3.3](https://arxiv.org/pdf/0712.2046), together with
Corollary 4.2.2.1 and Proposition 4.2.3.2 in its proof.  The proof-level
application to arbitrary ordinary genus-two Jacobians, including split
ones, is recorded in
[the translate-free theta note](THETA_TRANSLATE_FREE_BASES_AND_FINITE_ETALE_TARGETS.md#2-application-to-every-ordinary-genus-two-curve).

Choose an irreducible component `T` and any nonempty open `U subset T`.
The subvariety `U` generates `A`: otherwise its closure `T` would lie in a
translate of a proper abelian subvariety, which is incompatible with the
ampleness of `T` on the abelian surface `A`.

We use Bjorn Poonen,
[*Multiples of subvarieties in algebraic groups over finite fields*](https://math.mit.edu/~poonen/papers/multiples.pdf),
IMRN 2005, no. 24, 1487--1498, Theorem 1.8 and its proof in Section 6.
The exact form needed here is the following consequence of Lemma 6.6.

**Poonen prime-avoidance consequence.**  If an irreducible locally closed
subvariety `U` generates a semiabelian variety `A` over an algebraic
closure of a finite field, then for every finite prime set `S_0` there is
a point of `U` whose finite order is coprime to every prime in `S_0`.

To check the direction of the prime set, descend `A,U` to a finite field.
In the proof of Theorem 1.8, Lemma 6.6 constructs a set of primes `R`
disjoint from the prescribed `S_0` such that

\[
                         U(k)+A(k)\{R\}=A(k).              \tag{2.2}
\]

Apply (2.2) to the target point zero.  Then `0=x+t` with `x in U(k)` and
`t` of order supported on `R`.  Hence `x=-t` has order supported on `R`,
and therefore prime to `S_0`.  This is why one must use the complementary
set in Poonen's proof rather than reverse the projection appearing in the
displayed statement of Theorem 1.8.  The theorem permits `U` to be
nonclosed, so finite subsets may be deleted before applying it.

Since `C` is ordinary, zero is not in `Theta_C`.  We have therefore proved:

\[
 \boxed{\text{Every nonempty open of }T\text{ contains a nonzero torsion
 point of order prime to any prescribed finite }S_0.}      \tag{2.3}
\]

## 2. A bad torsion character gives a nonordinary cyclic cover

Choose `L in T(k)` as in (2.3), and let `n>1` be its exact order.  Since
`5 not divides n`, a trivialization of `L^n` defines a connected cyclic
etale Kummer cover of `C^{(1)}` of degree `n`.  Connectedness is equivalent
to exact order `n`.  Relative Frobenius is a universal homeomorphism and
induces an equivalence of finite etale sites, so this cover is the
Frobenius twist of an actual connected cyclic etale cover `D -> C`.

On the twisted cover,

\[
 \pi^{(1)}_*\mathcal O_{D^{(1)}}
                  \simeq\bigoplus_{i=0}^{n-1}L^{-i},
 \qquad
 \mathcal B_D\simeq\pi^{(1)*}\mathcal B_C.                \tag{3.1}
\]

Projection formula gives the exact character sum

\[
 a(D)=h^0(D^{(1)},\mathcal B_D)
      =\sum_{i=0}^{n-1}
          h^0(C^{(1)},\mathcal B_C\otimes L^{-i}).         \tag{3.2}
\]

The term `i=n-1` is the twist by `L`, so one summand in (3.2) is positive
by `L in Theta_C`.  Thus `a(D)>0`, so
`D` is nonordinary.  Its degree `n` is coprime to `S_0`, proving the first
assertion of Theorem 1.

## 3. The nested cyclic tower

Inductively choose `L_j in T(k)` as follows.  Having chosen
`L_1,...,L_{j-1}` of exact orders `n_1,...,n_{j-1}`, apply (2.3) with

\[
 S_0=\{5\}\cup\{\text{prime divisors of }n_1\cdots n_{j-1}\}. \tag{4.1}
\]

This gives a new exact order `n_j>1` coprime to all preceding orders.
The points `L_j` are distinct.

Let `G_j` be the subgroup of `A(k)` generated by the `L_i` for `i<=j`.
Since their orders are pairwise coprime,

\[
                   G_j\simeq\prod_{i=1}^j C_{n_i}
                       \simeq C_{N_j},\qquad
                   N_j=\prod_{i=1}^j n_i.                 \tag{4.2}
\]

Equivalently, the tensor product of the `L_i` has exact order `N_j` and
generates `G_j`.  Its Kummer cover is connected cyclic etale of degree
`N_j`; denote the corresponding cover of `C` by `C_j`.  The inclusions
`G_{j-1} subset G_j` give compatible quotient maps
`C_j -> C_{j-1}` of degree `n_j`.  This proves the first two properties
of (1.2).

Every `L_i`, `i<=j`, occurs as a distinct character in the decomposition
of `pi_{j*}^{(1)}O_{C_j^{(1)}}`.  Applying (3.2) to the full character
group gives

\[
 a(C_j)=\sum_{L\in G_j}
           h^0(C^{(1)},\mathcal B_C\otimes L)
        \ge\sum_{i=1}^j
           h^0(C^{(1)},\mathcal B_C\otimes L_i)
        \ge j.                                             \tag{4.3}
\]

For any smooth curve, the first Frobenius-kernel dimension is at most the
dimension of the eventual nilpotent part, so

\[
                         a(C_j)\le g(C_j)-f(C_j).           \tag{4.4}
\]

Equations (4.3)--(4.4) prove (1.3).

## 4. Exact boundary

This theorem deliberately uses new prime divisors at every stage.  Each
finite composite `C_j -> C` is cyclic and abelian, but the union of the
prime supports of its degrees is infinite.  Therefore it does **not**
construct:

- a pure pro-`ell` tower;
- a tower supported on one fixed finite set of primes; or
- a second fixed target curve sharing all these covers.

There is no conflict with the finite-support stabilization theorem in
`THETA_TRANSLATE_FREE_BASES_AND_FINITE_ETALE_TARGETS.md`.  That theorem
fixes the prime set first.  The present construction escapes its finite
exceptional torsion set by enlarging the forbidden set after every chosen
bad character, and hence forcing the next bad order to use entirely new
primes.
