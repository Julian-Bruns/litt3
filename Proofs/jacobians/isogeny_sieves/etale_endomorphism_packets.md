# Proof: packet bounds, arithmetic input, and the actual map stabilizer

Consolidation/root,2026-09-09. General group inequality: earlier95/96
audit PASS2026-09-04. The abelian exact multiplicity/factor extraction and
minimal-source extension retain author-only status. The local arithmetic
replacement in Section2 passed its bounded independent audit on
16 September2026.

## 1. Free action and one rational packet

Put s=h−1 and choose ℓ≠char(k). For any nonidentity γ∈G, its graph
is disjoint from the diagonal, since q is étale. The cohomological
Lefschetz formula gives Tr(γ|H¹_et(W,Q_ℓ))=2. At the identity Hurwitz
gives dimension2+2|G|s. Semisimplicity in characteristic zero therefore gives

\(H^1_{\mathrm{et}}(W,\mathbf Q_\ell)\simeq\mathbf Q_\ell^2\oplus\mathbf Q_\ell[G]^{2s}.\) (3)

This argument includes p-torsion in G. The relevant fixed-point formula
is [Milne, Étale Cohomology, Thm25.1](https://www.jmilne.org/math/CourseNotes/LEC.pdf),
whose cycle-class proof imposes no prime-to-p order on the automorphism.

For the rational central idempotent belonging to χ, the image P_χ in
J(W), defined up to isogeny, consequently has dimension s[F:Q]c².
The trivial idempotent gives J(C).

The entire A-isotypic part of P_χ is A^m, preserved by every endomorphism:
Hom between distinct simple isogeny types is zero. Thus G acts on K^m.
For a constituent χ of this action, its simple K-algebra has center FK
and form M_(c/e)(Δ), where dim_(FK)Δ=e². Every nonzero simple module
has K-dimension ce[F:F∩K]. Hence

\(m\ge ce[F:F\cap K],\quad md\le s[F:\mathbf Q]c^2,\)

which proves (1). This applies to each constituent that occurs, not only
to one arbitrarily chosen character of the deck group.

For abelian G, c=e=1 and K⊗Q(ζ_n) is a product of a_n fields each of
degree b_n over K. All its modules have dimension divisible by b_n,
giving the exact multiplicity statement. Summing packets proves the
no-new-factor assertion. The same argument gives isomorphisms of rational
Hom spaces via norm and pullback when no new A-factor occurs; no equality
of integral Hom lattices is asserted.

If a cover W→C dominates a curve X, norm-pullback f_*f^*=[deg f]
makes every simple factor of J(X) occur in J(W), even for an inseparable
map. For the actual common-cover application, W is the genuine Galois
closure of ONE leg and its composed map to X is still finite étale.

An abelian subgroup B≤G gives c≤[G:B]: restrict χ to B, choose a linear
constituent, and apply Frobenius reciprocity to its induction. This proves
the bounded-index consequences without a bound on |G|.

## 2. The geometric endomorphism field from local Cartier data


Geometric simplicity of J(X), already proved in fixed_pair_arithmetic,
remains an input. The new argument uses only a small Cartier matrix;
it does not re-prove simplicity.

First, let A/F_q be absolutely simple of ODD dimension d, with positive
p-rank and all Newton slopes in {0,1/2,1}. Then
\[
\operatorname{End}^0_{\bar{\mathbf F}_q}(A)
=\mathbf Q(\pi_q),\qquad [\mathbf Q(\pi_q):\mathbf Q]=2d.
\]
Indeed, over every finite extension its center is a CM field L: a real
Weil number would give only slope1/2. The Honda--Tate local invariants
of its division algebra D are zero away from p and are
\(\lambda_v[L_v:\mathbf Q_p]\bmod1\) at p. Their denominators divide2.
Thus the index s of D is1 or2. The identity 2d=s[L:Q], with [L:Q]
even and d odd, excludes s=2. Hence End^0 over every finite extension
is a field of degree2d. Each field contains the base
endomorphism field and has the same degree, hence is equal to it.
All geometric endomorphisms are defined over a finite extension. See [Oort, Theorem5.4 and Sections15,17](https://math.nyu.edu/~tschinke/books/finite-fields/submitted/oort.pdf)
for the Honda--Tate formulas.

There is a useful general local test. Suppose a CM field M=Q(pi_q) of
degree2d has a unit place v over p of local degree a. If an odd prime
ell satisfies ell not dividing a and ell*a>d, then M contains no
cyclic degree-ell subfield. Such a subfield L would be totally real.
Its local degree at w=v|L is1 or ell, and divides a, hence is1.
The conjugate place c(v) is distinct from v, since pi_q*c(pi_q)=q
and v is a unit place. Both lie over w, and their local degrees sum
to2a. This exceeds [M:L]=2d/ell, a contradiction. A simple nonzero
irreducible factor of degree a of the Frobenius polynomial modulo p
certifies precisely such a unit place by Hensel lifting; no assumption
on the index of Z[pi_q] in the ring of integers is needed.

Here is the complete small input for the fixed X. Write kappa=a for
the root used in the exact checker, so kappa^2+4kappa+2=0. Use
\[
\omega_i=x^i\,dx/y\ (0\le i\le2),\qquad
\eta_j=x^j\,dx/y^2\ (0\le j\le5).
\]
In this order Cartier is C(v)=Cmat v^(1/5), with blocks
Cmat=(0,B;A,0). For P the defining degree-ten polynomial,
\[
A_{ji}=([x^{5j+4-i}]P^3)^5,\qquad
B_{ij}=([x^{5i+4-j}]P)^5.
\]
The exponents5 take inverse Frobenius on F25. They follow from
1/y=P^3/y^10 and 1/y^2=P/y^5 and the Cartier coefficient rule.
The [small exact checker](../../../scripts/arithmetic/fixed_x_local_endomorphism_certificate.sage)
reconstructs both blocks from P and verifies
\[
\operatorname{rank}A=\operatorname{rank}B=3,\quad
\det(BA^{(5)})=3\kappa,\quad
\det(T-C^2)=T^3(T+1)^2\phi(T),\quad
\phi=T^4+T^3+3T^2+3.
\]
Thus the stable Cartier rank is6 and a(X)=3, consistently with the
earlier independent Cartier--Petri calculation.

The cubic deck action has eigenvalues zeta3 and zeta3^(-1) on the
rational Dieudonné module. Since5 is inert in Q(zeta3), semilinear
Frobenius exchanges these two eigenspaces within every slope summand.
Every slope therefore has even multiplicity. Slopes0 and1 each occur
six times. Among the six remaining slopes, a non-half complementary
pair would have denominator b>=3; each member has multiplicity
divisible by lcm(2,b), whose minimum is4. Such a pair would require at
least eight dimensions. Therefore
\[
\operatorname{NP}(JX)=0^6,(1/2)^6,1^6.
\]
The preceding odd-dimensional argument now proves geometric End^0 is
the degree18 field M=Q(pi25).

The Cartier--Hasse--Witt congruence gives
\[
P_{\pi_{25}}(T)\equiv T^9\det(T-C^2)
=T^{12}(T+1)^2\phi(T)\pmod5.
\]
The displayed quartic is irreducible. One elementary certificate is
\[
T^{25}-T\equiv T^3+2T+1\pmod\phi,
\]
\[
2T^2\phi+(3T^3+3T^2+3T+1)(T^3+2T+1)=1.
\]
A reducible quartic would have a factor of degree one or two, so these
identities suffice. The simple unit factor phi gives a=4. Taking
ell=3,d=9 in the local test excludes cyclic cubic subfields of M.
The visible order-three action gives K0=Q(zeta3) inside M. If
M intersect Q^ab exceeded K0, its degree would be6 or18, and its
abelian Galois group would have a cyclic cubic quotient. This would
produce the excluded subfield. Hence M intersect Q^ab=K0.

The [executed receipt](../../../../litt3-computation-data/canonical_power_return_20260916/fixed_x_local_endomorphism.json)
records the exact blocks and polynomial checks. These replace the
large field discriminant in proving the same endomorphism input.
They do not strengthen the already established all-degree packet
inequality in Section1 or remove its large-character cases. The
[bounded audit](../../../Research/audits/LOCAL_ENDOMORPHISM_CERTIFICATE_AUDIT_2026_09_16.md)
checks the local proof, the semilinear orientation and an independent
small replay.

The earlier independent [three-prime certificate](../../../scripts/arithmetic/fixed_x_endomorphism_field.sage)
is retained. Its real trace polynomial has cycle types(9),(8,1),(7,2)
at2,107,11 and hence Galois group S9, providing the stronger real-field
information when needed. The local proof above does not depend on
that computation or on the previously computed field discriminant.

## 3. The actual source gives a faithful multiplicity module

For the jointly minimal span let r:W→Z, v=(fr)^*∈Hom⁰(JX,JW), and
let U=K[G]v. G acts by inverse pullback, so H fixes v and K[G/H]→U.

Two surjective maps a,b:W→X inducing the same Jacobian homomorphism
are equal. Indeed, their Abel maps differ by a constant translation that
stabilizes the Abel image of X. Its finite translation stabilizer acts
freely on X and trivially on JX. For its quotient π, the norm identity
π^*π_*=[|K_0|] is surjective, so g(X/K_0)≥g(X). Étale Hurwitz forces
K_0=1. This works also in p-divisible order.

Therefore Stab_G(v) consists precisely of the automorphisms fixing k(X)
and k(Y), hence their actual compositum k(Z); it is H. The kernel of
the G-action on U is normal and contained in the core-free subgroup H,
so is trivial. The coset sum maps to q^*g_*f^*, zero when Hom(JX,JY)=0.
Thus U is a quotient of the augmentation representation, with dimension
at most[G:H]−1 and no invariant part. Frobenius reciprocity makes every
constituent H-spherical; Section1 applies to each. Intersecting their
kernels gives the stated necessary faithfulness test.

Neither faithfulness nor (1) bounds the covering degree. For example the
natural augmentation representation of A_D is faithful and irreducible
of dimension D−1, so the inequality is a lower bound on D. This is an
explicit surviving representation pattern, not a geometric realization.
