# Focused audit: the returned N5 partial analysis

Auditor: `/root/audit_n5_returned_partial`. Date: 2026-09-10.

Verdict: **PASS for the scoped partial claims**, with the explicit
canonical-bundle identification below. **N5 remains unproved and
undisproved.** The return supplies neither an actual counterexample
with a full compatible upper tower nor the higher comparison needed
for descent. No common-cover exclusion or finite look-ahead bound
follows. This is a prose audit, not formal verification.

Reviewed input: the unchanged `n5_partial_analysis.md` and `verify_n5.py`
in `/Users/julian/Documents/litt3-computation-data/n5-returned-20260910-K8jdVx/n5_analysis/`.
Their SHA256 values are respectively
`ec9b6f611937bd278bca37254d699c75ea3bfa32b13f3a12bf8264b4da32d2e7`
and `c38ee0e253032ede5d3dfe1b2d7b09a2161cbbd53b0e2554c7bcc8de4efff142`.

The scope is the returned Sections 2–6: the characteristic-five
quotient and pairing, neutral obstruction pullback and the relative
operator, regular integral negative cohomology on an individual
Galois reference, and the regular-lattice norm example. The canonical
statements and dependencies were inspected with the workspace CLI;
only proofs needed for these comparisons were opened. No existing
whole-theorem audit status is upgraded by this note.

## 1. The quotient bundle agrees with the existing convention

The canonical definition is

    E_r = pi^(1)_* V_(pi^*r+q),

using the FULL canonical double, including its split case. The return
instead writes the same symbol for `A_r=coker(j_r)`, where
`j_r:T_(C^(1)) -> F_*T_C`. This requires a comparison, not a silent
replacement of [the definition](../../Definitions/Def_projective_connections.md).
Here is that comparison.

In the returned oper frame, the normal p-curvature coefficient is

    c = r^2 + 3r'' = -s,
    s = (r'' - 3r^2)/3.

Thus it differs by a sign from the canonical normalized quartic.
The Hodge-projection map is the cohomology map of this p-curvature
normal projection, up to the harmless overall sign convention.
The sheaf composite in [LSYZ, Theorem 6.2](https://arxiv.org/html/1404.0538v2)
was checked directly; the existing higher-flow dictionary is retained.
No flat periodicity line is discarded from the input tuple.

Let `B=F_*T_C` and write

    D_r(v)=v'''-4rv'-2r'v.

Cartier duality identifies `B^vee tensor omega_(C^(1))` with
`F_*omega_C^2`. Under this identification the dual of `j_r` is
the twisted Cartier map `C_1(c ·)`. The returned concomitant identity
shows that `Car(u D_r(v) dz)` is alternating. Admissibility makes
the vector defining `j_r` primitive: at a zero of its lower entry
`c`, nilpotence and horizontality give `c'=0`, while the nonzero
upper entry forces `c''!=0`. The zero has order exactly two, hence
the Frobenius-pushforward fiber vector is nonzero. Horizontality also
gives `D_r(c)=0`, so the image of `j_r` lies in the radical.

The five Pfaffian identities then give rank four in every fiber.
Consequently the radical is exactly `j_r(T_(C^(1)))`, and the third
Bol operator induces a natural isomorphism

    A_r -> ker[C_1(c ·):F_*omega_C^2 -> omega_(C^(1))^2].

The sign `c=-s` does not change this kernel. In
[the canonical-double factorization](../../Solutions/Sol_etale_double_dormant_pairs.md),
Section 2, the exact identity `dDelta_r(v)=partial^4(sv)` identifies
this kernel with the nilpotent tangent sheaf. Its local involution
splits it into the dormant tangent bundles for `r+q` and `r-q` on
the actual double; the same factorization is valid for local regular
sections, including the zeros of `q`. Descent therefore identifies
it with the canonical `E_r`, including when the double splits.

This proves the needed compatibility. The two constructions of a
perfect canonical-valued alternating form need not be asserted to
have identical normalization. The returned form is natural under
actual etale pullback, which is sufficient for its trace argument.
The existing canonical pairing was already proved in
[symplectic_p_cover_section_growth](../../Solutions/Sol_symplectic_p_cover_section_growth.md),
Section 5.

Since the two negative lines have no global sections, the quotient
sequence identifies `H^0(A_r)=ker(psi)` and `H^1(A_r)=coker(psi)`.
Together with the bundle pairing this gives `O_C=K_C^vee`, retaining
the relative Frobenius twists. It does **not** give a nondegenerate
scalar alternating pairing on `K_C` itself, or universal evenness
of the defect.

## 2. Neutral wild-degree pullback and the relative defect

These assertions are correct for the original degree-five map, with
no Galois hypothesis. Under `d_T=d_C`, section pullback for the actual
etale pullback bundle is an isomorphism. Every section upstairs is
therefore pulled back, and its trace is `5s=0`. Polarized Serre duality
identifies pullback on `H^1(A_r)` with the transpose of this trace.
Hence

    h^*:O_C -> O_T is zero.

The same proof works for any individual finite etale degree divisible
by five that preserves the defect. This is a useful general corollary
of the existing duality inputs, now written explicitly; it is not a
new higher-periodicity obstruction calculation.

Pullback on both negative `H^1` spaces is injective, using the
individual Galois closure and negative `H^0` Cartan–Leray. Thus the
returned snake sequence for `Q=V_T/h^*V_C`, with its twisted domain,
is legitimate. Its first kernel map is an isomorphism by equal
dimensions. The zero cokernel map just proved gives

    K_Q = O_C,    O_Q = O_T,

canonically through that sequence. Both relative dimensions are
exactly `d`. In particular, the prime-to-five proof's invertible
relative block is absent here.

The single-step interpretation is also valid, provided the lower
compatible reference and full previous tuple already exist through
the stated level. The upper primary obstruction can always be
repaired. If a compatible lower next lift exists, every compatible
upper next lift descends by a unique lower kernel correction. None
of this creates the missing lower next lift or proves that an upper
repair can continue indefinitely.

## 3. Regular integral cohomology and cochain sections

For the individual Galois closure `q:Z->C`, with transitive
`G <= S5`, put `N=3g(C)-3`. On an actual descended curve reference,

    H^1(Z_W,T_(Z_W/W)) = W[G]^N

noncanonically, and the same holds over each `W_j`. The proof is
sound; no neutrality assumption on the closure is needed.

For clarity, Cartan–Leray for every subgroup gives
`H^i(K,H^1(Z,T_Z))=0` for `i>0`, because the negative `H^0` row is
zero and the quotient is a curve. Restriction to the cyclic Sylow
five-subgroup is free: any shorter indecomposable cyclic block has
nonzero `H^1`. Its prime-to-five index then makes the whole module
projective over `k[G]`.

For each simple module `S`, equivariant Serre duality and descent
identify `Hom_G(H^1(Z,T_Z),S)` with sections of
`omega_C^2 tensor E_S`. The associated bundle `E_S` has degree zero
and becomes trivial on `Z`. Its Serre-dual tangent twist has no
sections after that pullback, so Riemann–Roch gives dimension
`N dim(S)`. These are precisely the projective-cover multiplicities
of `k[G]^N`. Integral cohomology is free over `W` and commutes with
reduction; lifting the `N` regular-module generators and comparing
ranks proves the integral assertion. The truncated argument uses
the same reduction and length comparison.

The negative two-affine Cech complex has an exact sequence
`0->C^0->C^1->H^1->0`. Projectivity splits the last map equivariantly;
injectivity of the first makes its inverse on boundaries equivariant.
This proves the claimed cochain sections and boundary primitives.
It extends the already established cyclic-reference argument to the
other degree-five groups. It supplies choices on an actual descended
reference, not an action of `G` on the given upper tower before
descent has been proved. The original point stabilizer is retained,
and defect neutrality means `K_Z^G=K_Z^H`, not `dim K_Z=d`.

## 4. The regular-lattice norm example is correct

For `G=S5`, `H=S4`, and `e_H=N_H/24`, the left permutation module
`P=W[G]e_H` is an actual projective summand of `W[G]`. Right
multiplication by `e_H` projects onto this summand. Therefore

    L=I-R_(e_H)+(1/24)R_(N_G)

is exactly the permutation norm `J` on `P` and the identity on
`W[G](1-e_H)`. All right multiplications commute with the specified
left deck action; the subgroup embedding has not changed.

The integral vector `N_G-5N_H` has norm zero, is `H`-fixed, and is
a unit multiple of `(-4,1,1,1,1)` in the permutation basis. The kernel
dimensions modulo five are `4,1,1,2` for the full space and the
`G`, `H`, and two-letter-stabilizer invariant spaces. The coefficient
pairing makes `L` self-adjoint, so its kernel/cokernel duality is
compatible with the necessary representation-level duality above.
This does not realize the Cartier-polarized geometric complex or
its higher comparison.

Root replayed the supplied script unchanged in Sage's Python in
about 0.70 seconds: all Bol/Pfaffian identities, regular-lattice
tests, and the nonprime-field Frobenius check passed. This auditor
read the script and checked its algebraic meanings; no independent
heavy run or package installation was performed. Coefficient
Frobenius remains Frobenius on `W(k)`, not the fifth-power operation
on arbitrary Witt vectors.

## 5. New versus already recorded, and the remaining blocker

The cyclic-even-defect assertion is already contained in the stronger
[symplectic_p_cover_section_growth](../../Theorems/Thm_symplectic_p_cover_section_growth.md):
every odd defect strictly increases under every nontrivial cover
whose Galois closure is a five-group, including non-Galois covers.
The return repeats its two-step unipotent/cup-form proof in the
cyclic special case. It must not be recorded as new progress.

The canonical rank-four defect bundle, its canonical-valued pairing,
and prime-to-five neutral descent also already existed. Useful
additional statements in this return are the explicit wild-degree
zero map and exact relative defect, the quotient/third-Bol
presentation, the extension of regular integral references to the
other degree-five groups, and the embedding of the existing norm
test into that regular module class. These are partial structural
facts; they do not strengthen the established full cyclic descent
theorem or establish N5.

The blocker is unchanged and precisely identified: no actual higher
oper comparison evaluates a divided residual that forces the
non-descending norm displacement to vanish, and no actual curve
and full compatible continuation realizes that displacement.
The Hecke identities and the conditional Sylow reduction do not
fill this gap. Preserve the original map, full input tuple and given
upper tower in any next attempt. The original common-cover problem
remains unsolved.
