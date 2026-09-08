# Coefficient-field coarsening and the four degree-fourteen profiles

Version 2, 2026-09-08: same three audited statements, compressed proofs
and explicit characteristic-five Castelnuovo applicability. Original PASS
with one minor wording correction: /root/coefficient_coarsening_audit,
2026-09-04, [audit metadata](audits/47_COEFFICIENT_COARSENING_AUDIT.md).
This edit is not a new independent audit. The parameter-free observation
at the end of §1 is author prose.

Over k=Fbar5 retain the ACTUAL etale seven-diamond

\[
 V\xrightarrow[\;M\;]{a}Y,\qquad
 V\xrightarrow[\;7\;]{p}C\xrightarrow[\;M\;]{c}X,\qquad
 X:v^2=q^7-q+1,\quad Y:z^2=1-t^{31},
\]

with p cyclic, generator β, and aβ≠a. Thus g(C)=2M+1,
g(V)=14M+1. Both original legs are retained on the SAME source.
The [norm-polynomial construction](44_NORMED_HYPERELLIPTIC_BRANCH_PENCIL.md)
gives the separable minimal polynomial P(T)=Nm_(V/C)(T−t), a
basepoint-free coefficient space W⊂H^0(C,L), and deg L=2M.
The [nonpencil theorem](44_NORMED_HYPERELLIPTIC_BRANCH_PENCIL.md#4-the-audited-nonpencil-theorem) gives
3≤dim W≤8. Write

\[
 F=k(C),\quad K=k(V)=F(t),\quad
 B=\text{normalization of the coefficient image},\quad
 e=[F:k(B)],\quad A=\mathcal O(1)|_B,\quad d=\deg A .
\]

The same letter denotes a curve and its function field only when specified.

## 1. The exact spectral square (Proposition 47.1)

Put E=k(B)(t), also denoting its smooth projective curve. Then

\[
 ed=2M,\quad [E:k(B)]=7,\quad [E:k(t)]=d,\quad
 [K:E]=e,\quad F\otimes_{k(B)}E=K.                    \tag{47.5}
\]

Thus V is the normalization of C×_B E, with horizontal degree e and
vertical degree seven. All coefficients of monic P belong to k(B).

**Proof.** If b_7 is the leading coefficient section, the ratios b_i/b_7
generate k(B) and are exactly the coefficients of P. A factorization
over k(B) would factor P over F, so P stays irreducible of degree seven.
Basepoint-freeness gives L=q_B^*A, where q_B:C→B, proving ed=2M.
Now FE=K and [K:F]=[E:k(B)]=7. This DEGREE EQUALITY proves linear
disjointness, the tensor identity, and [K:E]=e; an intersection-degree
shortcut is not used. Finally [K:k(t)]=2M gives [E:k(t)]=d. QED.

The algebraic proof uses only that P is the minimal polynomial of a
primitive t and that its coefficient sections are basepoint-free. Replacing
seven by ANY finite degree preserves the same normalized-square argument;
no group action or Jacobian simplicity is used in this step. This is a
scope observation, not an enlargement of the original audit.

## 2. Where the hyperelliptic root lies (Proposition 47.2)

Exactly one of the following holds:

- z∈E: e divides M, and V→E→Y are finite etale of degrees e,M/e.
- z∉E: e is even, E'=E(z) is the normalized pullback of Y→P1_t
  to E, and V→E'→Y are finite etale of degrees e/2,2M/e.

**Proof.** The polynomial Z²−(1−t³¹) either splits over E or gives a
quadratic subextension of K/E. Tower degrees prove the formulas. Each
displayed field containing k(Y) is intermediate in the ACTUAL etale
extension K/k(Y), so its two maps are etale. QED.

In particular every odd-degree coefficient coarsening with e>1 factors the original
Y-leg through a smaller etale cover. In the second case one must NOT
infer a quadratic field inside F from compositum degrees: the
[full-orbit construction](81_FULL_ORBIT_INTERPOLATION_AND_CUBIC_SIGN_MONODROMY.md)
retains every sign choice. At e=2 specifically, E'=K, so this issue vanishes.

## 3. Full span at M=9 (Theorem 47.3)

If M=9 and dim W=8, then e=2 and the coefficient image has degree
nine in P7. Put b=g(B). Necessarily b∈{1,2}, and:

- z∉E, K=E(z), and V is the normalization of E×_(P1_t)Y.
- K/k(B) is Galois with group C14 or D14. The involution γ fixing E
  satisfies γ(t)=t, γ(z)=−z, and aγ=ι_Y a.
- C→B is a tame double cover with 40−4b reduced branch points.
- The degree-nine map t:E→P1 is unramified off
  \(\mathcal A=\mu_{31}\cup\{\infty\}\); above that set its indices
  belong to {1,2}.

The four necessary numerical profiles, retaining (47.15), are:

| Gal(K/k(B)) | g(B) | g(E) | #Br(C/B) | deg Diff(E/P1_t) |
|---|---:|---:|---:|---:|
| C14 | 1 | 1 | 36 | 18 |
| C14 | 2 | 8 | 32 | 32 |
| D14 | 1 | 55 | 36 | 126 |
| D14 | 2 | 56 | 32 | 128 |

In the last row EVERY one of the 32 special fibers has type \(2^4 1\).
These are necessary profiles, not assertions that any is realized.

**Proof.** Nondegeneracy in P7 gives d≥7. As ed=18, e≤2. The
Castelnuovo bounds are

\[
 \pi(18,7)=16<19=g(C),\qquad \pi(9,7)=2.              \tag{47.12}
\]

They apply in characteristic five: if a nondegenerate degree-d curve
in P7 were strange, projection from its strange point would have zero
differential. After removing common zeros and taking fifth roots, its
seven remaining coordinates would give seven independent sections in
degree at most floor(d/5). But h^0 of a nonnegative degree-a line
bundle on any smooth curve is at most a+1, which is at most four here.
Thus both images are nonstrange. The first bound excludes e=1; the
second gives e=2,d=9,b≤2.

Since 2 does not divide 9, §2 gives z∉E and K=E(z). The splitting
field of P over k(B) lies between E and K, so is E or K. If it is E,
its compositum with the Galois quadratic F/k(B) is still Galois; if
it is K, normality is immediate. Thus K/k(B) is Galois of order 14,
hence C14 or D14. The root stabilizer has order two and fixes t but
negates z, giving γ and aγ=ι_Y a.

Because V→C is etale, every inertia group meets its C7 subgroup
trivially; it therefore has order one or two. Riemann–Hurwitz for C/B
gives 40−4b branch points. Also the composite V→Y→P1_t has index
two over \(\mathcal A\), and index one elsewhere. The tower through E
therefore gives exactly the asserted index restrictions for E/P1_t,
without a separability assumption about a plane Gauss map.

For C14, all order-two inertia dies in E/B, so E→B is etale and

\[
 g(E)=7b-6.                                           \tag{47.16}
\]

For D14, a reflection has cycle type \(2^3 1\) on its seven cosets,
giving three different contributions per branch point and hence

\[
 g(E)=b+54.                                           \tag{47.17}
\]

The cyclic formula excludes b=0. In the dihedral case, E=k(B)(t)
means the maps of degrees seven and nine generate E; Castelnuovo–Severi
gives g(E)≤7b+48, excluding b=0 as well. Thus b∈{1,2}.
Finally the separable degree-nine t-map has different degree 2g(E)+16,
giving the table. At most four index-two points lie in each degree-nine
fiber. The last row reaches the total maximum 32·4=128, forcing type
\(2^4 1\) in all special fibers. QED.

## Scope

The audited four-profile theorem is retained independently of later
generalizations. The [Prym refinement](58_X_CENTRAL_GLUE_CONGRUENCES.md#3-both-factors-lie-in-the-prym-genus-two-is-impossible)
and [dihedral genus-one exclusion](61_D14_GENUS_ONE_ROW_IMPOSSIBLE.md)
are separate arguments; they are not duplicated here. The later
[all-dimension quadratic sieve](67_GENERAL_DOUBLE_COEFFICIENT_COARSENING.md)
has author-only scope. For dimensions three through seven, §1–2 still
apply, but the four-row theorem does not. No arbitrary common-cover
exclusion or simultaneous Galois closure is asserted.
