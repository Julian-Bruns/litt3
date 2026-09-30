# Proof: exclude the trace-zero quartic scalar

[Statement](../../Theorems/cartier_and_spin/klein_four_nonzero_quadratic_trace.md).
This is a local continuation of the received
[quadratic-sector theorem](klein_four_quadratic_scalar_exclusion.md),
not a claim made in that reply. Use its fields, projections and four
equations(1)–(2). All endpoint sums are unaveraged.

## Neither endpoint can be invariant

The quadratic and balanced exclusions give epsilon outside L.
If Q were half-turn-invariant, its U_Q,V_Q would lie in L.
The first fourth-trace equation then reads
\[
\epsilon(U_Q-\eta x^{625})=-V_Q-\eta\bar y^5,
\]
with both parenthesized sides in L. Linear independence of1,epsilon
over L forces U_Q,V_Q in K. The nonzero eigenvalue4 coefficient of
g then implies T4(Q;4)=0. Invariance already kills characters2,3;
phasewise vanishing makes Q balanced, contrary to the earlier theorem.
Endpoint interchange proves the same for H.

We will also use this elementary criterion: vanishing of character4
and either character2 or3 forces a four-label endpoint to be balanced.
At each phase character4 requires equal even- and odd-type counts,
as their difference has absolute value at most four. A two-label
group has weights ±1 and ±2 for either odd character, so cannot
vanish. A four-label group has two occurrences of each parity.
Writing its even and odd counts explicitly shows that odd-character
vanishing forces one occurrence of every type. This proves the
criterion without enumeration.

## Pure quartic eigencharacters are impossible

Suppose sigma(epsilon)=2epsilon. The eigenvalue3 part of the second
old equation is epsilon C_Q,4=0. Phasewise vanishing therefore also
gives E_Q,4=0. The first old equation now gives C_H,3=0, hence
U_H,3=0. The eigenvalue3 part of the second fourth-trace equation
gives epsilon V_H,4=0. Thus characters3 and4 both vanish at H,
forcing the forbidden balanced endpoint.

The actual interchange
(Q,H,epsilon,x,y) -> (H,Q,epsilon^-1,bar(x),bar(y)) preserves all
four equations. It excludes the eigenvalue3 scalar too. In
particular epsilon^4 cannot lie in K: such a scalar would be a
sigma-eigenvector with eigenvalue in F5*, and the other eigenvalues
would put it in L, already excluded.

## A necessary two-endpoint matching

Suppose now sigma^2(epsilon)=-epsilon. Write
epsilon=b+c, with b in G2 and c in G3. The pure cases just excluded
allow b,c to be nonzero. Put
\[
w=(c^2-b^2)/c\ne0.
\]
Nonvanishing follows from b!=±c, since G2 and G3 intersect in zero.
The eigenvalue3 parts of the second old equation and first fourth
trace give
\[
c(C_{Q,1}-\eta y)+bC_{Q,4}=0,
\quad c(U_{Q,1}-\eta x^{625})+bU_{Q,4}=0.
\]
Their eigenvalue2 parts consequently give
\[
E_{H,2}=wC_{Q,4},\qquad V_{Q,2}=-wU_{Q,4}.\tag{3}
\]
The inverse scalar is also trace-zero, so the same identities hold
with endpoints interchanged.

The exact canonical coefficient identities are
e2=c2, g2=[17]c2 and f4=[17]c4, with every factor nonzero.
Write T_lam(R;m)=sum lam^i zeta^(mj). Eliminating w from(3) gives
\[
T_2(H;8)T_4(Q;17)+T_2(Q;4)T_4(Q;5)=0,\tag{4}
\]
\[
T_2(Q;8)T_4(H;17)+T_2(H;4)T_4(H;5)=0.\tag{5}
\]
These identities have coefficients in F5, despite the F25 jet data.

The second identity in(3) implies T2(Q;4)=0 exactly when
T4(Q;17)=0. Either would make Q balanced by the criterion above.
Thus both are nonzero; the same holds at H. This justifies every
denominator and every character-zero exclusion in the computation.

## Complete matching, with all repeated labels

Normalize an occurrence of Q to(0,0) by simultaneous root rotation
and the allowed parameter rescaling. The latter translates Q phases
by h and H phases by minus h, and multiplies epsilon by an element
of K*. It preserves the trace-zero hypothesis. All other Q occurrences
are arbitrary sorted triples from116 labels; H is an arbitrary
four-label multiset. Therefore this covers every actual configuration.

For each Q with both characters nonzero, equation(4) specifies
\[
T_2(H;8)=-T_2(Q;4)T_4(Q;5)/T_4(Q;17).\tag{6}
\]
The exact calculation indexes all H by their left side. Equal sums
retain all endpoint preimages; no injectivity of this character sum
is assumed. Each lookup candidate is then tested against(5).

| Complete set | Count |
| --- | ---: |
| All four-label H multisets | 7940751 |
| H excluded by a zero character | 8555 |
| Indexed H, with all collisions retained | 7932196 |
| Normalized Q multisets | 266916 |
| Q excluded by a zero character | 289 |
| Nonzero Q queries | 266627 |
| Endpoint pairs satisfying(4) | 93015 |
| Endpoint pairs satisfying(4) and(5) | 503 |

The largest lookup bucket has229 different endpoints; all are tested.
No moment or scalar field is sampled. Batch inversion is exact and
each reconstructed inverse is multiplied back by its denominator.

For the503 remaining pairs, reconstruct the full necessary determinant
\[
(E_Q/\eta-\bar x)(E_H/\eta-x)
 -(C_Q/\eta-y)(C_H/\eta-\bar y)=0.\tag{7}
\]
Writing x=x0+beta x1 and y=y0+beta y1 over K+=F_(5^7), its seven
nonscalar coordinates are affine linear. Exactly502 pairs have
inconsistent linear equations. The last is
Q=(0,0,0,0), H=(58,58,58,58). Its unique linear solution is
(x0,x1,y0,y1)=(2,0,2,0), and the scalar determinant is2, not zero.
Thus no remaining pair satisfies even the old equations. The entire
trace-zero scalar case is excluded.

Finally, if epsilon^2 were in L, the automorphism sigma^2 would send
epsilon to epsilon or minus epsilon. The first alternative is the
already excluded quadratic scalar field; the second was just excluded.
The only proper intermediate fields of F/K are K and L, so epsilon^2
has degree four over K as claimed.

## Reproduction and independent verification

The primary
[matching program](../../scripts/arithmetic/klein_four_odd_scalar_matching.cpp)
uses F25[zeta]/f7. Its
[compact output](../../../litt3-computation-data/quadratic_scalar_reply_20260926/odd_matching.json)
and [503-pair list](../../../litt3-computation-data/quadratic_scalar_reply_20260926/odd_matching.pairs.tsv)
are retained. A separate
[absolute-field verifier](../../scripts/arithmetic/verify_klein_four_odd_matching.cpp)
uses F5[zeta]/m14, different arithmetic and reverse-order enumeration.
It independently reconstructs the complete candidate set, including
all collisions, and verifies exact equality of the503 pairs.
The field bridge m14=f7 times its coefficient-fifth-power conjugate
was separately checked, with
m14=(1,2,4,0,4,4,3,1,3,4,4,0,4,2,1).

The [primary moment test](../../scripts/arithmetic/klein_four_odd_scalar_fourth.py)
uses the previously verified elementary linear/quadric routine.
The [independent Sage verifier](../../scripts/arithmetic/verify_klein_four_odd_scalar_fourth.py)
instead constructs(7) directly, obtains its linear matrix by evaluation,
and checks all503 systems. It also reconstructs the canonical projection
constants used in(3)–(6). Both implementations give502 linear
inconsistencies and the single nonzero scalar determinant2.

Compile either C++ source with clang++ -std=c++17 -O3 -Wall -Wextra
-pedantic, leaving assertions enabled. Run the primary executable
with an external output-prefix argument. Pass the resulting
.pairs.tsv to the absolute-field verifier. Run each Python test with
that TSV argument and --output followed by an external JSON path;
use sage -python for the independent test.
Receipts are
[matching](../../../litt3-computation-data/quadratic_scalar_reply_20260926/verify_odd_matching.log)
and [moment determinant](../../../litt3-computation-data/quadratic_scalar_reply_20260926/verify_odd_fourth.log).

This proves a necessary-system exclusion in every degree. It neither
constructs nor excludes all quartic-scalar comparisons, and it does
not extract a shared tensor from an arbitrary common cover.
