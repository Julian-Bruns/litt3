# Odd abelian covers after a double cover have proper axis theta

Date: 2026-09-05. Author: `/root`.
Status: author proof. The key opposite-component/degree contradiction
received a focused PASS from `/root/canonical_trace_algebra`, 2026-09-05.
The proof is a new deduction in this investigation, not a priority claim.

Throughout k=Fbar_5. All curves are smooth projective and connected.

## 1. An unbounded-degree vanishing theorem

Let Y be ordinary of genus two, let a:U -> Y be finite etale of degree
two, and let b:W -> U be a connected abelian Galois etale cover whose
degree is odd and prime to five. Set q=a b. Then

\[
 q^{(1)*}J(Y^{(1)})\not\subset\Theta_W.                       \tag{1}
\]

Equivalently, for L in a nonempty open subset of J(Y^(1)),

\[
          H^0(W^{(1)},B_W\otimes q^{(1)*}L)=0.                \tag{2}
\]

There is no bound on deg b or its prime support, and no assumption
that W -> Y is Galois. In particular its odd abelian characters need
not be anti-invariant under the double-cover involution.

Every actual intermediate f:Z -> Y of q satisfies the same conclusion.
So does every such intermediate after a further Galois five-group
refinement W' -> W. For any actual second finite etale map g:Z -> X,
the two-leg locus

\[
 \{(L,M):h^0(B_Z\otimes f^{(1)*}L\otimes g^{(1)*}M)>0\}
                                                               \tag{3}
\]

is proper: its M=O slice already has a nonempty good open.
Thus these configurations satisfy the proposed claim (R), without
needing additional assumptions on X, minimality, or its Gauss map.

This does not prove (R) for unrestricted monodromy, or solve Litt 3.

## 2. The genus-three Jacobian and its mandatory theta contribution

Write tau for the involution of U/Y and, on the untwisted Jacobians,

\[
 P=(\ker\operatorname{Nm}_a)^0,\qquad A=a^*J(Y)\subset J(U).
\]

We use the same letters for their scalar Frobenius twists when working
inside J(U^(1)); all torsion line classes in the rest of the proof are
on that twist. Riemann--Hurwitz gives g(U)=3. The Prym P is elliptic,
A is an abelian surface, and

\[
                    P\cap A=P[2]                              \tag{4}
\]

scheme-theoretically. The principal Jacobian polarization restricts
to degree two on P. Its polarization map is multiplication by two
under the elliptic principal polarization, giving (4). The direct
degree proof and the norm component calculation are in Section 3.1
of the
[genus-two Prym theorem](ODD_GENERALIZED_DIHEDRAL_TOWERS_OVER_ORDINARY_GENUS_TWO_HAVE_FINITE_NONORDINARY_TARGETS.md).

Since J(U)/P is ordinary, Tong's Dirac property gives P not contained
in Theta_U. Consequently D=Theta_U|P is an effective divisor of degree

\[
                            \deg D=2(5-1)=8.                   \tag{5}
\]

More precisely D has a compulsory contribution of degree at least four:

- If P is ordinary, the four nonzero points of ker(V_P) lie in D.
  They are distinct and have order five. This follows directly by
  tensoring the Frobenius exact sequence with the corresponding
  nontrivial line bundle L with F_U^*L=O_U.
- If P is supersingular, D has multiplicity exactly four at zero.
  Indeed the connected identity component of ker(V_J(U)) equals
  ker(V_P), of length five: the complementary Jacobian quotient is
  ordinary. On k[t]/(t^5), Dirac restricts a theta equation to a
  nonzero multiple of t^4.

These are precisely the compulsory contributions used in the
[elliptic polarization bounds](ELLIPTIC_CHARACTER_DIRECTIONS_AND_POLARIZATION_CONTROLLED_A_NUMBERS.md).
The primary input is
[Tong, Definitions 1.2.7.1 and 1.2.7.4 and Theorem 1.2.7.7](https://arxiv.org/pdf/0712.2046).

Also

\[
                           A\not\subset\Theta_U.              \tag{6}
\]

For epsilon the two-torsion class defining U/Y, projection formula
and a_*O_U=O_Y direct-sum epsilon identify its bad locus on J(Y^(1))
with the union of Theta_Y and its epsilon translate. Raynaud's theorem
makes both proper. This proves (6).

## 3. Only fourth-order Prym classes can give a bad translate

### Lemma

Let alpha in P(k) have order prime to five. If

\[
                         \alpha+A\subset\Theta_U,             \tag{7}
\]

then alpha has exact order four.

### Proof

Suppose first 2alpha is not in A. Raynaud theta is symmetric, so both
alpha+A and -alpha+A are distinct irreducible components of Theta_U.
Each has multiplicity at least one. Neither contains P, since P is
not contained in Theta_U. By (4), their restrictions to P are the
disjoint reduced degree-four divisors on

\[
                   \alpha+P[2],\qquad-\alpha+P[2].             \tag{8}
\]

Together these already consume the entire degree eight in (5).
Every point in (8) has order prime to five. Also neither coset
contains zero: otherwise alpha lies in P[2], contrary to 2alpha
not belonging to A. Thus both supports miss the compulsory degree-four
contribution from Section 2, whether it is nonzero five-torsion or
the origin. The effective residual divisor would have positive degree
in addition to the eight from (8), contradicting (5).

Therefore 2alpha belongs to P intersect A=P[2], hence 4alpha=0.
If alpha belongs to P[2], its A-translate is A, ruled out by (6).
The only remaining possibility is exact order four. This proves the
lemma. No point counting over a finite subfield is involved.

There are twelve such points in P[4], representing the three nonzero
classes in P[4]/P[2]. The lemma leaves these as possible exceptions;
it does not assert that any of them actually gives a component.

## 4. Arbitrary odd characters, not just anti-invariant ones

Let Q=J(U^(1))/A and pi:J(U^(1)) -> Q. The restriction
pi|P:P -> Q is an isogeny with kernel P[2], hence of degree four.
It is therefore an isomorphism on geometric torsion subgroups of
odd order prime to five.

For any gamma in J(U^(1))(k) of odd order prime to five, there is
a unique alpha in P(k) of the same permitted torsion type with
pi(alpha)=pi(gamma). Thus gamma-alpha belongs to A. By Section 3,

\[
                          \gamma+A\not\subset\Theta_U.        \tag{9}
\]

Now let Lambda be the finite character subgroup defining W/U.
Etale base change and character decomposition yield

\[
 H^0(W^{(1)},B_W\otimes q^{(1)*}L)
   =\bigoplus_{\gamma\in\Lambda}
        H^0(U^{(1)},B_U\otimes\gamma\otimes a^{(1)*}L).
                                                               \tag{10}
\]

Signs on the character labels are immaterial because Lambda is a
group. Each summand vanishes on a nonempty open subset of J(Y^(1))
by (9) and surjectivity of a^*:J(Y^(1)) -> A. The intersection of
these finitely many opens is nonempty, since J(Y^(1)) is irreducible.
This proves (1)--(2).

## 5. Actual non-Galois intermediates and five-group refinements

If W -> Z -> Y are actual finite etale maps, pullback injects

\[
 H^0(Z^{(1)},B_Z\otimes f^{(1)*}L)
   \hookrightarrow H^0(W^{(1)},B_W\otimes q^{(1)*}L).
\]

Thus the same open proves the intermediate statement. The
[five-group refinement invariance theorem](P_GROUP_REFINEMENT_INVARIANCE_OF_RESTRICTED_RAYNAUD_THETA.md)
preserves the vanishing locus after a further actual Galois five-group
cover W' -> W. Its proof uses a filtration of the regular modular
representation by trivial factors; no averaging in characteristic five
is used. Pullback again handles any actual intermediate of W'/Y.

Equivalently, this applies to a Galois closure group G with a normal
five-subgroup R such that G/R has an abelian subgroup N of odd order
prime to five and index two. No inversion assumption on its action
is needed. Take W/R, then its degree-two quotient by N, and apply the
theorem followed by the actual R-refinement. Abelian index-one
quotients are already covered by the earlier character-filtration
criterion.

For the two-leg statement (3), take M=O. The proof never requires the
second map to descend to U or to W/R; it uses only an already good
slice on the original common source.

## 6. Exact remaining boundaries

- The base must be ordinary genus two in this proof. It provides both
  the elliptic Prym and its degree-eight theta restriction with the
  compulsory degree-four contribution.
- The finite fourth-order exceptions are not removed here. In
  particular ordinary exponent-four abelian covers of Y do not by
  themselves eliminate fourth-order Prym classes on U.
- Normal five-group refinement is allowed; arbitrary extensions or
  arbitrary nonabelian groups are not thereby controlled.
- This is a new positive instance of (R), not a proof that no common
  cover exists in the full problem. Further use of (R) still has to
  respect the separate cofinality and correspondence-tower gaps.
