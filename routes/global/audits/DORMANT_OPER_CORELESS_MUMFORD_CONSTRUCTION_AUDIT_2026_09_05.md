# Independent audit: coreless Mumford span preserving a dormant oper

Date: 2026-09-05. Auditor: Codex agent `dormant_mumford_coreless_construction_audit`.
Scope: complete independent reading of `DORMANT_OPER_CORELESS_MUMFORD_CONSTRUCTION.md`, checking the named arithmetic construction, the common regular dormant PGL2-oper, and specialization to Fbar5. No descendant agents used. The original construction note is unchanged.

**Verdict: PASS for the stated existence theorem.** The proof works with the standard meaning of an algebraic PGL2-oper and relative p-curvature. There is a concrete citation-location correction and several short explanations worth adding, recorded below. None changes the construction. This verdict does not certify a Litt counterexample or any correspondence involving the project's specified curves or pluriform.

## Arithmetic lattice and the actual finite etale span

The polynomial T^2+T+1 has discriminant 2, a nonsquare in F5, so the two named finite ramification places are distinct and have degrees one and two. The usual quaternion classification permits precisely this even ramification set, with infinity split.

[Papikian--Wei, Section 9.2, printed p. 612](https://ems.press/content/serial-article-files/26279) explicitly supplies the asserted uniformization, freeness of the projective unit group when an even-degree ramified prime occurs, action without inversions, and finiteness of the tree quotient. These hypotheses match the chosen discriminant. Theorem 9.1 supplies the proper smooth curve underlying their discussion.

The genus estimate follows without any separate genus formula: a discrete free group has trivial compact vertex stabilizers, so the finite connected quotient of the 6-regular tree has e=3v and b1=e-v+1=2v+1. Its Schottky rank, hence the Mumford-curve genus, is at least three. The same reasoning applies to finite-index subgroups, and conjugation preserves the endpoint genus.

The commensurator claim is valid, but can be made explicit. For O'=alpha O alpha^-1 choose a nonzero ideal a of A with aO contained in O'. A unit u in O satisfying u=1 modulo aO has both u and u^-1 in O': indeed u^-1-1=-u^-1(u-1) belongs to aO. This finite-index congruence subgroup is contained in O'^*. Interchanging O and O' proves commensurability. Projectivizing preserves it.

Thus Delta is finite index in both torsionfree Schottky groups. Their quotient maps are actual finite etale analytic covers and algebraize to finite etale maps of proper smooth curves. This is a construction of a span, rather than merely an abstract group correspondence.

## Nondiscreteness and corelessness

For each noncentral b, alpha_N=1+T^-N b remains noncentral, is invertible, and approaches the identity. Finitely many commutators can therefore all be placed inside the displayed principal congruence pro-5 subgroup U. At least one is nonidentity: noncommuting Schottky elements have different pairs of fixed points, and an element centralizing both must be the identity in PGL2. This justifies the centralizer assertion in the note.

The no-order-five argument is correct. If a projective element represented by x in D^* has fifth power scalar, its minimal polynomial divides X^5-c. Since D is division the minimal polynomial is irreducible, and since D has degree two it has degree at most two. An irreducible factor of X^5-c in characteristic five has degree one or five. Therefore x is scalar. The embedding D^*/F^* into PGL2(K) is injective: an element of D that becomes scalar after splitting commutes with all of D and is already in F.

A nonidentity delta in H intersect U has infinite order. In a pro-5 group delta^(5^m) tends to the identity, since this happens in every finite quotient; these powers are distinct. Alternatively, discreteness would make H intersect U finite and hence a finite 5-group, contradicting the absence of order-five elements. Both arguments in the note are sound.

A core function pulls back to a nonconstant meromorphic function on Omega invariant under both Gamma and Gamma', hence H. The exceptional-set argument works. The poles are countable because they are the inverse image of a finite pole divisor on Z under the quotient by countable Delta. Every nonidentity Mobius transformation has at most two fixed points, including in positive characteristic. There are consequently only countably many excluded points. Omega contains an uncountable open disk, so the requested point z exists. Its orbit points under the identity-approaching sequence are distinct, remain in a sufficiently small analytic disk eventually, and approach z. The one-variable analytic identity theorem forces local constancy. On the connected smooth rigid curve Omega this forces constancy. Characteristic five does not invalidate the identity theorem: the argument uses zeros, not the implication that a zero derivative implies constancy.

## Analytic oper and algebraization

The diagonal action on Omega times P1 preserves the trivial *relative* projective connection. Although the base coordinate changes by a Mobius map, the change of fiber frame is a constant PGL2 matrix over the analytic ground field, whose relative differential is zero. The diagonal section is equivariant, and in a local trivialization its developing coordinate is z. Its derivative gives the required invertible Kodaira--Spencer map. There is no point at the omitted boundary that must be filled: the quotient is already proper and all its points have uniformizing neighborhoods in Omega.

Trivial relative connection has p-curvature zero for every relative derivation D, because nabla_D^p and nabla_(D^[p]) agree coefficientwise. This is a local identity and is preserved by the descent transition functions. The shared object on Delta gives the two compatible pullback identifications directly.

For GAGA, the adjoint bundle formulation in the note suffices. Algebraize the rank-three bundle, its bracket, Borel subbundle, and O-linear splitting of the relative first principal-parts sequence. Analytification is compatible with that sequence; bracket compatibility of the connection is a tensor identity and remains true algebraically. In characteristic five Aut(sl2)=PGL2 as a smooth group scheme, and the resulting Lie-algebra frame scheme is the requisite torsor. The local sl2 form and Borel type can be checked on the analytic fibers and descend faithfully. A bracket-compatible connection gives the principal connection; faithfulness of the adjoint representation and of its differential detects zero p-curvature. Transversality is likewise an isomorphism of coherent sheaves detected analytically.

**Citation correction:** Appendix A.1 of the linked Conrad paper reviews properness, flatness and quasi-finiteness; it is not the precise location of the coherent GAGA equivalence. The proof of Lemma 4.3.2, printed pp. 37–38, explicitly states the proper-scheme/coherent-sheaf equivalence and points to Example 3.2.6. Cite these locations instead. [Conrad, Relative ampleness in rigid geometry](https://math.stanford.edu/~conrad/papers/amplepaperfinal.pdf).

There is no unresolved imperfect-field obstruction. The note constructs and algebraizes over C_infinity, an algebraically closed complete field of characteristic five. It need not first descend the oper to K. If one instead works over imperfect K, all connections must be K-relative and Frobenius statements must use the relative twist. The displayed local p-curvature calculation remains valid. In particular, no assertion about an absolute connection over F5 is needed or justified by constancy of matrices in K.

## Spreading and specialization

Curves, finite maps, vector bundles, bracket, Borel reduction, jet splitting and matching isomorphisms are finite-presentation algebraic data, so they descend together to a finitely generated field inside C_infinity. Relative p-curvature is also finite algebraic data, using the relative Frobenius twist or its local p-linear formula. Smoothness, properness, geometric integrality, finite etaleness and oper transversality persist after shrinking the spreading base; the vanishing and compatibility identities can be retained there. Any hypothetical generic geometric core would survive field extension to C_infinity, contradicting the analytic proof.

[Krishnamoorthy, Lemma 4.10, printed p. 1188](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf), states that a geometric fiber with a core forces the generic correspondence to have a core under the stated smooth proper hyperbolic and finite etale hypotheses. Its contrapositive is exactly the direction used here. Corollary 4.12 explicitly draws the specialization-to-the-algebraic-closure-of-the-prime-field consequence. All hypotheses are met after the indicated shrinking. A nonempty finite-type F5 base has a closed point with finite residue field; its geometric fiber therefore gives the claimed Fbar5 example and the matching dormant oper.

## Recommended nonbreaking clarifications and scope limits

1. Correct the Conrad citation to Example 3.2.6 / the proof of Lemma 4.3.2.
2. State once that analytic connections and GAGA are taken over C_infinity; use relative connections and relative p-curvature over every spreading base.
3. Add the short congruence-subgroup argument and explain why the pulled-back pole set is countable.
4. State the centralizer argument using noncommuting Schottky elements, and make clear that the Lie-algebra automorphism identity is a group-scheme identity in characteristic five.

No effective choice of N or finite-field equations has been checked or supplied. The unrelated characteristic-three uniqueness remark was not needed for this proof and was not audited. The audit establishes failure of the unrestricted implication “common regular dormant PGL2-oper implies a core”; it leaves every additional condition involving the project's special pluriform or generalized Cartier operator untouched.
