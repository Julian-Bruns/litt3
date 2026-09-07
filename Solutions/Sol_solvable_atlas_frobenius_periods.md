# Proof: separate torsor descent from descent of the second map

[Statement](../Theorems/Thm_solvable_atlas_frobenius_periods.md).
All fields of definition below mean existence of a model of the geometric
object, not descent of an arbitrarily rigidified matrix presentation.

## 1. Periods in an elementary abelian embedding problem

Let pi=pi_1(C_k). Choose a lift of arithmetic Frobenius in pi_1(C),
giving an automorphism Phi of pi, defined up to inner automorphism.
Geometric connected G-torsors are surjections pi->G up to G-conjugacy.
Every such torsor is defined over some finite extension, so its class
has finite Frobenius orbit. We bound the primes in the orbit length
inductively along a chief series of the solvable group.

Consider1->N->G->Q->1 with N=F_ell^r elementary abelian, and a fixed
surjection rho:pi->G. Let rho_0 be its projection and let d be the
Frobenius orbit length of the Q-conjugacy class of rho_0. Then

    rho_0 Phi^d = Ad(a) rho_0

for some a in Q. Choose a lift a_tilde in G. Precomposition by Phi^d
followed by Ad(a_tilde^-1) permutes the lifts of this FIXED rho_0.
Modulo conjugation by N, these lifts form a torsor under

    H^1(pi,N_(rho_0)).                                         (4)

Here N_(rho_0) has the conjugation action of Q through rho_0. To verify
the assertion without a splitting assumption on G, compare any lift
with rho: their pointwise ratio is a crossed homomorphism with values
in N; N-conjugacy changes this by a coboundary. The displayed operation
on lifts is affine over F_ell on (4). Its linear part is induced by
Phi^d together with conjugation by a_tilde^-1 on N.

The associated F_ell local system on the PROPER curve C_k is unramified.
If ell differs from the characteristic, Euler characteristic and
duality give

    dim H^1(pi,N_(rho_0)) = (2g-2)r+h^0+h^2 <= 2gr.             (5)

In degree1 fundamental-group and etale cohomology agree; h^0,h^2<=r.
The finite-coefficient Grothendieck--Ogg--Shafarevich formula used here is
stated explicitly in equation(1.1.1) of
[C. Miller, Equicharacteristic etale cohomology in dimension one](https://arxiv.org/pdf/0906.4093).
There is no equicharacteristic-coefficient substitution in this argument.

For ell=p instead, let M be the rank-r F_p local system and let
A=M tensor_(F_p) O_C be its associated vector bundle. This bundle is
trivialized by a connected finite etale cover, so deg A=0 and h0(A)<=r:
pullback injects its global sections into the r-dimensional space of
constant sections upstairs. The usual Frobenius on O gives a global
semilinear map F on A, and etale-locally the Artin--Schreier sequence
is the exact sequence0->M->A --F-1-->A->0. For a finite-dimensional
k-vector space with any semilinear F, F-1 is surjective and its fixed
space has F_p dimension at most the k-dimension. Applying this first
to H0(A) and then to H1(A) gives

    dim_(F_p) H1(C,M) <= h1(A) = r(g-1)+h0(A) <= gr.            (5p)

The semilinear assertion, including its proof by stable filtration and
additive polynomial equations, is
[Stacks Lemma59.63.2](https://stacks.math.columbia.edu/tag/0A3J).
The twisted sequence above is obtained from the ordinary sequence in
that section by etale descent through GL_r(F_p) transition matrices.
Thus p-torsion in G is allowed, with the sharper b_i=gr bound.

For m<=b_i, every prime divisor of an affine transformation's order on
F_ell^m is ell or divides ell^j-1 for some1<=j<=m. This follows from
|AGL_m(F_ell)|=ell^m |GL_m(F_ell)| and the product formula for |GL_m|.
Thus each such prime is allowed by(1). If e is the order of our affine
transformation, rho Phi^(de) is G-conjugate to rho. In particular the
G-torsor's Frobenius period divides de. The surjective lifts form an
invariant subset; restricting to them does not affect this conclusion.
Induction from the trivial group proves the asserted prime support.

A Frobenius-invariant conjugacy class really has a torsor model over
that finite field. To see this directly, the arithmetic exact sequence
splits over hat(Z): a lift of its topological generator defines a
continuous section. If rho Phi^d=Ad(b)rho, extend rho to the semidirect
product pi semidirect hat(Z) by sending this field's Frobenius to b.
The equality is exactly the required compatibility; the extension is
continuous and has finite image. It defines a constant G-torsor over
F_(q^d), with the prescribed connected geometric fiber. Thus no extra
field-of-moduli obstruction introduces an uncontrolled prime.

## 2. Prime-power groups: the same H1 controls every central layer

For G an ell-group, take a central series with successive factors C_ell.
Start over F_(q^D_ell), where Frobenius acts trivially on H1(C,F_ell).
At each step of Section1 the coefficient local system is now the SAME
trivial F_ell local system: the kernel is central. Conjugation by the
chosen lift a_tilde also acts trivially on it. After any ell-power
extension the linear Frobenius action is still the identity. Therefore
the affine action on the set of lifts is a TRANSLATION, of order1 or ell.
At most a central layers suffice, giving D_ell*ell^a as a field degree.
This allows arbitrarily large ell-groups without an increasing list of
prime-to-ell period factors. For ell=p use H1_et(C,F_p), not all coherent
H1(O_C); the twisted Artin--Schreier argument above guarantees finiteness.

For the fixed X, the Frobenius polynomial recorded in
`fixed_pair_arithmetic` reduces modulo3 to

    (T+1)^4 (T+2)^6 (T^2+1)^4.                              (6a)

Its roots have orders2,1,4, respectively. Every Jordan block has size
at most6, so the ninth power kills the unipotent part. Equivalently
(6a) divides T^36-1 over F3, and Cayley--Hamilton gives T_Frob^36=I.
The same conclusion holds for the dual or inverse Frobenius convention.
Thus D_3 divides36, proving the torsor consequence. Frobenius on the
etale group scheme Pic(X)[3] is dual to the same cohomology action;
it too is killed by the36th power, proving(4). The factorization and
the orders were checked exactly in Sage against the recorded degree18
integer polynomial. No semisimplicity modulo3 is assumed.

## 3. The second map: a small integral Hom lattice

Now fix a model of W->C as a constant G-torsor over a finite field.
This part does not require solvability or prime-to-characteristic order.
Let

    Lambda = Hom_G(J(D_k),J(W_k)).

This is a finite-rank free abelian group, and all of its generators are
defined over a common finite extension. Consequently Frobenius acts
on Lambda through a finite-order integral matrix. We bound its rank
using BOTH the G-torsor and the target D.

Take an auxiliary prime ell different from the characteristic. Since
the G-action on W is free, the cohomological Lefschetz formula gives
trace(a|H^1(W,Q_ell))=2 for every a!=1 in G. Riemann--Hurwitz gives
dim H^1(W)=2+2|G|(g-1). Thus, as characteristic-zero G-representations,

    H^1(W,Q_ell) = 2 triv + (2g-2) regular.                      (6)

For the trace assertion the graph of a is disjoint from the diagonal,
so its intersection number is zero. This argument allows wild-order
automorphisms, since they act freely. See Theorem25.1 and its diagonal/
graph proof in
[Milne, Lectures on Etale Cohomology](https://www.jmilne.org/math/CourseNotes/LEC.pdf).
Semisimplicity here is over Q_ell, not over a modular coefficient field.

The invariant part of H^1(D,Q_ell) has dimension2g(D/G). Equation(6)
therefore gives

    dim Hom_G(H^1(D),H^1(W))
       = (2g-2)*2h + 2*2g(D/G) = R.                            (7)

The Tate-module realization of geometric homomorphisms is injective,
so rank Lambda<=R. The direction of Tate-module duality reverses the
Hom in(7), but the dimension is the same by semisimplicity and(6).
Only injectivity and finite generation are needed, not Tate surjectivity;
see Theorem9.14 of
[Milne, Abelian Varieties](https://www.jmilne.org/math/CourseNotes/AV110.pdf).

If a finite-order integral matrix of rank r has order divisible by a
prime L, its cyclic group contains an element of order L. A nontrivial
rational representation of C_L has dimension at least L-1, because
the cyclotomic polynomial Phi_L has that degree. Therefore L<=r+1.
After an extension of degree e whose prime divisors are at most R+1,
Frobenius acts trivially on Lambda and in particular fixes f^*:J(D)->J(W).

It remains essential to recover f, not just a Jacobian map. Nonconstant
maps W->D are determined by their induced homomorphism of Jacobians
when h>=2. Here is a proof. If f_1,f_2 have the same homomorphism, their
composites with an Abel--Jacobi embedding of D differ by translation by
a fixed point a of J(D). Surjectivity onto D means that translation by
a preserves the embedded D; it induces an automorphism alpha of D
acting identically on its Jacobian. Aut(D) is finite. If alpha had order
n>1, the Q_ell-cohomology of D/<alpha>, being the invariant subspace,
would still have dimension2h. But Riemann--Hurwitz for the separable
quotient D->D/<alpha> would give2h-2>=n(2h-2), a contradiction. Thus
alpha=id and f_1=f_2. Pullbacks on Jacobians suffice because norm and
pullback are dual under the canonical polarizations.

Apply this to f and its Frobenius conjugate. Fixing f^* fixes f itself,
which therefore descends. Multiplying the degrees from Sections1 and2
proves(2) and the assertion for any functorial invariant. The second
map was never replaced by a freely chosen Jacobian summand.

## 4. The two high-residue-degree oper orbits

Both order216 groups are solvable: the triangle group is
(C6 x C6) semidirect S3, and the Hessian group is(C3)^2 semidirect
SL2(F3), with SL2(F3)=Q8 semidirect C3. A subgroup G is again solvable,
has order dividing2^3*3^3, and its chief factors therefore have ell=2
or3 and rank at most3. This deliberately coarse bound is sufficient.

For an actual component W in an atlas of X,

    deg(W/H) = 8|G|/9,

so9 divides|G|. Riemann--Hurwitz for H->H/G gives

    18 >= |G|(2g(H/G)-2),

hence g(H/G)<=2. Thus (5) uses at most54 dimensions, while (7) gives
R<=4*8*10+8=328. The primes359,1831 and the orders in(3) can be checked
by trial division and repeated multiplication modulo the indicated prime;
they violate BOTH possible sources of field-period primes.

The geometric datum extracted from the atlas is defined over F25.
For clarity, the construction is intrinsic: descend the canonical
normalized bundles on H from `hermitian_atlas_extension_criterion`,
form V=E/O and its character line tau, and fix theta=O_X(8O), defined
over F25. Then W_2=V tensor(theta tensor tau^2)^-1 has canonical
Frobenius connection and unique oper line, as in
`dormant_rank_two_candidates`. Its projective oper class is therefore
Galois-equivariant. The scalar oper chart and its cubic deck quotient
are defined over F25. No choice of an isomorphism j, quotient frame,
or torsion trivialization is part of this invariant. A field of
definition of the atlas fixes the normalized oper point.

The audited enumeration and the representative manifest record degrees
718 and7324 for orbit_0010 and orbit_0011. The relevant manifest is
Research/computations/oper_representatives_manifest.json, SHA256
263cdce34475e4f16a1feb6fc965d441ed88ff7d95f3ae5eef19f7f7a092cc86.
Its residue degree divides every extension degree fixing the point,
contradicting(1)-(3). This proof does not assume tau=0.

The final conditional assertion uses the alternatives already proved
in `hermitian_monodromy_genus_sieve`. The full PGU case remains: its
torsor is nonsolvable, so Section1 supplies no period restriction for it.
