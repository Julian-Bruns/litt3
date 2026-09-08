# Proof: one tangent bundle, two different choices of cyclic cover

[Statement](../Theorems/Thm_tangent_bundle_cyclic_refinements.md).
Author /root,2026-09-08. This assembles the canonical-double factorization
with classical theta and finite-field results; it is not a new theta theorem.

## 1. Dormant tangent bundle and its stability

In a uniformizer t write a quadratic as v(dt)². Linearizing the dormant
equation E(r)=r''−3r²=0 gives Bol_r(v)=v''−r v. Its kernel on GLOBAL
regular quadratics is zero exactly at reduced dormant points. It is O_(C^(1))-linear
after F_* because derivatives kill Frobenius-pulled-back functions.

Here is an explicit coordinate check, which also identifies its jet bundle.
For x=x(t), u=x', the quadratic and its first derivative change by

    (v_t,v_t')^T = [[u²,0],[2uu',u³]] (v_x,v_x')^T.

Using r_t=u²r_x−{x,t}/2 and characteristic5 gives

    v_t''−r_t v_t = u^4(v_x''−r_x v_x).

Thus the differential system (v,v')'=(v',r v) is a regular connection
on J^1(omega²). Its p-curvature is zero since r is dormant: locally it
is the same scalar second-order connection defining r. Cartier descent
therefore gives a rank2 vector bundle V_r; the first-coordinate map
identifies it with ker(F_*Bol_r). Its global sections are precisely the
actual dormant tangent vectors, not merely solutions over the function field.

The jet sequence is

    0→omega³→J^1(omega²)→omega²→0.

It has determinant omega^5. Hence 5deg(V_r)=5(2g−2), giving the claimed
degree and chi(V_r)=0. If A⊂V_r is a line subbundle, F^*A is horizontal.
It cannot lie in the oper line omega³: the second fundamental map of
that line to omega² tensor omega is an isomorphism. Therefore its
projection to omega² is nonzero, so

    5deg A<=deg omega²=4(g−1)<5(g−1).

This proves stability. Cartier descent, jets and the scalar equation
commute with etale base change, giving V_(h^*r)=h^(1)*V_r.

## 2. The rank-four bundle, including a split root torsor

Use the actual canonical torsor pi:C_s→C from
[etale_double_dormant_pairs](Sol_etale_double_dormant_pairs.md).
Its tautological q changes sign under the involution tau. The connection
rho=pi^*r+q is dormant on all components, with tau^*rho=pi^*r−q.
Define E_r=pi^(1)_*V_rho. It is locally free of rank4. For connected C_s,
its genus is2g−1 and chi(V_rho)=0. For the split torsor, the two summands
each have Euler characteristic zero. Finite pushforward and Riemann–Roch
in either case give chi(E_r)=0 and deg(E_r)=4(g−1).

The previously proved tangent factorization identifies H^0(E_r) with
T_nil(C,r): on a connected double this is the invariant part of two
exchanged dormant tangent summands; on the split double it is their
direct sum. The identification is natural. In particular, retaining
the FULL double torsor, instead of selecting a component before base
change, proves h^(1)*E_r=E_(h^*r) even when the torsor splits upstairs.

For a cyclic prime-to5 cover, its character decomposition on C^(1)
and projection formula now give(1) for either bundle. Character lines
are defined on C^(1); transporting the cover back through relative
Frobenius yields an actual cover of C. No identification of a torsion
line with its fifth power is needed. Covers may equivalently be described
by either character convention, since inversion permutes the labels.

## 3. The two classical inputs, with their exact hypotheses

For any positive-rank vector bundle B on a smooth curve with chi(B)=0,
let D_B={L in J:h^0(B tensor L)>0}. Either D_B=J, or D_B is the support
of an effective ample theta divisor numerically rank(B)Theta. Indeed,
acyclicity at one twist forces semistability (a destabilizing subbundle
has positive Euler characteristic at every twist). The determinant of
an equal-rank two-term cohomology complex defines the divisor.
[Raynaud, Section1.8 and Proposition1.8.1](https://www.numdam.org/article/BSMF_1982__110__103_0.pdf)
give its class in arbitrary characteristic. Sections1.6–1.8, including
the proof, were read directly. Proposition1.6.2 also gives a proper theta
divisor for every semistable rank2 bundle of Euler characteristic zero,
so it applies to EVERY V_r, even when h^0(V_r)>0. No assertion that every rank4 bundle has
a proper theta divisor is being used.

[Raynaud, Lemma4.3.5 (Serre)](https://www.numdam.org/article/BSMF_1982__110__103_0.pdf)
says that a divisor D on a Jacobian admits an order-ell subgroup meeting
D only possibly at0 when ell!=p and ell+1>D·C_Abel. Its proof counts
torsion points by intersection and compares with the number of lines
in J[ell]. The lemma and proof were read directly.

Over a finite-field algebraic closure, for a locally closed irreducible
subvariety U GENERATING an abelian variety A, and any finite prime set S,
[Poonen, Lemma6.6](https://math.mit.edu/~poonen/papers/multiples.pdf)
gives U(k)+A(k){R}=A(k) for some prime set R disjoint from S. Apply to0
after deleting0 from U: one obtains a nonzero point of U whose order
avoids S. The proof of Lemmas6.4–6.6 was read. The complementary prime
set is essential; projecting onto S-torsion would reverse this conclusion.

## 4. Good subgroups, with an explicit bound

Apply Section3 to the finite collection B_i of tangent bundles. Each
D_i is a proper effective theta divisor: automatically for dormant r,
and by the explicit hypothesis for active r. It may contain0.
The sum D=sum D_i has class RTheta, where R=sum rank(B_i).
An Abel curve has intersection g with Theta, so D·C_Abel=Rg.
For every prime satisfying(2), Serre's lemma gives an order-ell subgroup
Lambda whose NONZERO points avoid every D_i. Formula(1) then leaves
exactly the identity-character contribution h^0(B_i), preserving each
defect. If all h^0(B_i)=0 the entire subgroup, including0, avoids D.
If the family is empty the assertion is immediate from any nonzero
order-ell line. This proof imposes no condition on the Jacobian or on k
beyond the stated algebraic closure and characteristic.

## 5. Bad subgroups, with no fixed set of allowable primes

Now k=bar(F_5) and J is simple. For every B_i, its bad locus is either
all J or a nonempty divisor by Section3. A component of the divisor has
dimension g−1>=1. On a simple abelian variety its nonempty opens generate
J: no such open can be contained in a translate of a proper abelian
subvariety. Poonen therefore supplies a nonzero bad character of order
coprime to any prescribed finite prime set. The same argument works for
the whole-J case. All data descend to a finite field after a finite
constant extension; geometric simplicity and the locally closed condition
are preserved. No simultaneous finite field for the infinite tower is needed.

Enumerate the finite collection. At stage j, choose one bad character
L_(j,i) for each B_i, adjoining the prime divisors of each chosen order
to the avoided set before the next choice. All chosen orders are>1 and
pairwise coprime. Their character group through stage j is consequently
cyclic of order the product N_j. Its actual connected Kummer cover of
C^(1), and inverse Frobenius transport to C, gives C_j. These can be
chosen compatibly so C_j→C_(j−1) has the product of the new orders as its
degree. Successive degrees are pairwise coprime and avoid the original S.

For B_i, its j selected bad characters and the identity are distinct
summands of(1). The identity contributes h^0(B_i), each selected character
at least one. This proves(3). The proof only uses the generating-component
condition, giving the more general formulation. No simplicity claim for
the Jacobians of the growing covers is necessary: every character is
chosen on the ORIGINAL C^(1).

## 6. Simultaneous growth while retaining both actual maps

Start with the specified actual Z_0→X,Y. Add the prime divisors of both
leg degrees to S. Apply the previous construction to both endpoint
families, choosing ALL characters across BOTH endpoints with pairwise
coprime orders, by enlarging S after every choice. Let X_j→X,Y_j→Y be
the two resulting cyclic towers. The orders of these covers are coprime
to each other and to both original leg degrees.

The pullback Z_0×_X X_j is connected: a cyclic Galois extension of degree
coprime to[k(Z_0):k(X)] is linearly disjoint from k(Z_0). The analogous
Y-pullback is connected. Their compositum over Z_0 is again connected
and cyclic, since its two Galois groups have coprime orders. Call this
smooth projective etale curve Z_j. It surjects etale onto both X_j and
Y_j. Pullback of regular quadratic tangent vectors is injective and
preserves the relevant curvature equation. Thus every endpoint defect
on Z_j is at least the already established defect on its endpoint cover,
hence at least j. Nestedness follows from the chosen nested character groups.

The finite avoided prime set can contain any user-prescribed primes.
This constructs actual cyclic refinements above every chosen Z_0, not
just an abstract direct sum of representations or one-leg Jacobian data.
Minimality and corelessness of a presentation are NOT preserved or needed.

## 7. What this does and does not repair

The good and bad constructions choose different subgroups. Both are
available for the backup's finite90-object pool. The negative statement
therefore cannot be fixed merely by finding a larger finite pool on an
endpoint with simple Jacobian. It does not rule out a good minimal source.
The positive statement cannot repair a bad source, since its existing
tangent vectors pull back injectively.

[Wakabayashi1602.07061, Section5](https://arxiv.org/pdf/1602.07061)
fixes a degree d BEFORE defining the open (d,n)-dormant-ordinary locus.
Its generic-cover theorem is not a single open locus controlling every
cyclic degree on every finite-field-valued curve. Hence the bad towers
do not contradict it. Neither construction proves that two endpoint
connections are compatible, supplies a clump, or excludes a common cover.

## 8. Recovering the connection and its canonical double from the bundles

The stable bundles V_r,V_s have equal slopes, so a nonzero morphism is
an isomorphism. Pull it back by Frobenius. Cartier descent gives a
horizontal isomorphism between the two scalar connections on
J=J^1(omega²). The subbundle omega³ is the unique maximal-slope line
in J: its quotient omega² has strictly smaller degree. Thus the
isomorphism preserves this line. Its maps on the subbundle and quotient
are constant nonzero scalars d and a, respectively, since C is projective.

In the local jet coordinates (v,v'), its matrix is consequently
A=[[a,0],[b,d]]. Put M_r=[[0,1],[r,0]], and likewise for s.
Horizontality means

    A'=M_s A−A M_r=[[b,d−a],[s a−d r,−b]].

The upper row forces b=0 and d=a; the lower left entry then forces
s=r. Conversely scalar maps are horizontal. This proves(4), including
the dimension claim, without any assumption that the jet extension is
nonsplit. Apply it on the common source using etale functoriality to
obtain(5). Equality after a further cover descends because pullback of
the regular quadratic difference f^*r_X−g^*r_Y is injective.

Now suppose the canonical double pi:T→C of an active r is connected.
Its deck transformation exchanges the two distinct dormant connections
r_+=pi^*r+q and r_−=pi^*r−q. Formula(4) shows that V_+ and V_− are
nonisomorphic stable bundles of the same slope. Etale base change gives

    pi^(1)*E_r=V_+ direct-sum V_−.

In particular E_r is semistable: a destabilizing subbundle would pull
back to one of this semistable direct sum. If E_r were not stable, a
proper saturated subbundle of equal slope would pull back to an
equal-slope subbundle of V_+ direct-sum V_−. Such a subbundle is one
of the summands. Indeed, in the category of semistable bundles of this
slope the two summands are nonisomorphic simple objects, so the subobjects
of their direct sum are precisely the sums of subsets. One can also
prove this by projecting to each summand and using stability. But the
deck involution exchanges the two summands, whereas a pulled-back
subbundle is invariant. This contradiction proves stability of E_r.
For a split torsor the displayed decomposition occurs already on C,
and E_r is polystable but not stable. The same argument on any actual
etale cover proves the asserted splitting test, even if its degree is
divisible by5 or its map is not Galois.

Finally suppose E_r is isomorphic to E_s for two active connections.
Choose a connected component of the fiber product of their canonical
double torsors. It is finite etale and surjects onto C, and both torsors
split there. The isomorphism therefore identifies two unordered pairs
of distinct stable dormant bundles. Uniqueness of the stable summands
and(4) identify the unordered pairs of dormant connections themselves.
Taking the midpoint, which is defined since2 is invertible, gives the
equality of the pulled-back r and s. The quadratic difference descends
this equality to C. The converse follows from the definition of E.
Apply the same argument on Z to obtain the two-leg active criterion.

Thus growth of H^0(V_r) under refinements does not undermine these exact
matching tests. It concerns maps from O, whose slope is different, not
the equal-slope Hom spaces used above. Nevertheless no argument here
forces a nonzero Hom between the two endpoint families.
