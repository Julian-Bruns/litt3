# Independent audit: exact local A9 realization and cyclic-16 augmentation

Date: 2026-09-05. Auditor: `/root/a9_local_realization_independent_audit` (fresh independent proof and primary-source check; no delegated audit). Verdict: **PASS**, with the coordinate and transitivity qualifications below. This audits realization only, not the ensuing Tango counterexample.

## Primary source checked

[Muskat–Pries, *Alternating group covers of the affine line*, arXiv:0908.2140](https://arxiv.org/pdf/0908.2140), §4.3, Notation 4.7, Lemma 4.8, Theorem 4.9 and its proof (printed pp. 15–17), together with Definition 2.6 and Lemma 2.11, were checked directly. Notation 4.7 defines the Galois closure of `y^(p+s) - x y^s + 1`; Theorem 4.9's proof explicitly applies to that cover, so it is not merely an unspecified existence result. With p=5 and s=4, the group is A9, the only branch point is infinity, the tame inertia order is 4, and the upper jump is 9/4. Thus the lower jump is 9. Lemma 2.11 gives faithful tame action, hence inertia F20=C5⋊C4. The source does not itself state the exact Artin–Schreier equation below; that is the independent argument audited here.

## Exact completed extension

Let E/k(a) be this splitting field and fix a point q over infinity. For a primitive ninth root ζ, the simultaneous substitution a↦ζ^5 a and b↦ζ b preserves b^9−ab^4+1. Every extension to an algebraic closure of the base automorphism consequently preserves E: transformed roots are ζ times roots of the original polynomial. Hence E/k(a^9) is Galois, with quotient C9 over Gal(E/k(a))=A9.

Its decomposition group D at q maps onto C9. Indeed, any lift of a base automorphism sends q to another point over infinity, and an element of the global A9 moves that point back to q. The kernel is the original inertia I of order 20, because k is algebraically closed. Thus |D|=180. A Sylow 3-subgroup S has order 9 and intersects I trivially; its injection into C9 is an isomorphism. In particular there really is an order-nine lift, not merely a lift whose order is divisible by nine.

The wild subgroup P=C5 is characteristic in I and therefore normal in D. The conjugation map S→Aut(P)=C4 is trivial. Let L=E_q and K=k((a^−1)). The unique degree-four tame extension L^P/K can be written T=k((t^−1)) with t^4=a. This choice preserves the literal original a coordinate; it is not an arbitrary formal reparameterization. For a generator δ of S, δ(t)=βt: its ratio with t has fourth power a constant, hence is itself constant. Moreover β^9=1 and β^4 is primitive of order nine, so β is primitive of order nine.

Normalize an Artin–Schreier generator v by τ(v)=v+1 for a generator τ of P. Since δ centralizes τ, δ(v)−v belongs to T. Thus the Artin–Schreier class [f] defining L/T is fixed by δ, with no F5-star scalar ambiguity. Over algebraically closed k, its unique reduced polar representative is a polynomial sum of c_j t^j with j>0 and 5∤j. The lower break 9 bounds j by 9, and its coefficient at 9 is nonzero. Since δ acts diagonally by β^j, uniqueness of the reduced representative forces every coefficient except c_9 to vanish. Therefore L=T(v), v^5−v=c_9 t^9, c_9≠0.

Choose d∈k* with d^9=−c_9, and put t'=dt, a'=d^4a. Then t'^4=a' and v^5−v=−t'^9. This is exactly the requested extension after a constant scaling of the global base. If retaining the original polynomial coordinate literally, its coefficient is c_9 rather than necessarily −1. These assertions hold as extensions over the specified completed base, and therefore identify the local Galois cover, not just its ramification filtration.

## Cyclic-16 augmentation

For any finite a_0, let D_0 be the full reduced fiber on U. Its degree is |A9|=181440=16·11340. There is a line bundle M with M^16≅O_U(D_0): choose degree 11340 first, then use surjectivity of multiplication by 16 on Pic^0(U)(k). Taking a sixteenth root of the canonical section defines a connected cyclic degree-16 cover V→U, totally ramified at every point of D_0 and étale elsewhere. Connectedness follows already from valuation one at any point of D_0.

The Galois closure R over k(a) is the compositum of the A9-conjugates of k(V) over k(U). Its kernel N over A9 embeds in a product of cyclic groups of order 16, so is a 2-group (indeed abelian of exponent dividing 16). All conjugates are étale off D_0 and locally split at every point outside D_0, since the residue field is algebraically closed. At D_0 they induce the same unique tame degree-16 extension of the completed local field. Consequently R/k(a) has inertia exactly C16 at a_0, and its completed extension at infinity is unchanged, exactly the F20 extension above.

Finally a surjection Gal(R/k(a))→F20 would send N to a normal 2-subgroup. Such a subgroup is trivial because O_2(F20)=1. The map would factor through the simple group A9, which has no F20 quotient. No claim of full linear disjointness from an arbitrary F20 extension is needed or proved here.

No fatal objection found. Wording correction: the transitivity used to prove D→C9 is transitivity of the **global A9**, not of I, on the infinity fiber.
