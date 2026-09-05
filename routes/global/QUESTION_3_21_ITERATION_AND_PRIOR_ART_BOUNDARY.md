# Question 3.21: iteration and the precise prior-art boundary

Date checked: 2026-09-05.

Status: bounded primary-literature check and verification of a conditional formal implication. The gluing/cohomology agent checked the cited passages and proofs. This is not an independent audit of the separate ordinary-genus-two cored-correspondence finiteness input.

## 1. Exact question and later source check

Krishnamoorthy's Question 3.21 asks whether one coreless finite étale correspondence of hyperbolic curves implies the existence of infinitely many minimal coreless finite étale correspondences between the same two targets. “Minimal” means birational onto the image in the product. The question does not impose ordinarity or genus two. [*Correspondences without a core*, Question 3.21, printed p. 1184; Definition 3.3, p. 1178](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf).

The author's own publications page, marked “Last revised July 2026,” still explicitly poses this question in its description of the 2018 paper. [Krishnamoorthy, publications, entry 9](https://notnotraju.github.io/math_research/math_research.html).

The bounded search found no later primary source answering the general question or the special case with one ordinary genus-two endpoint over \(\overline{\mathbf F}_5\). This is a report of the checked sources, not certification of current openness or a priority claim. A recently revised publications page can still retain an older paper description.

The closest subsequent paper located is Bellaïche's *On self-correspondences on curves* (Algebra & Number Theory 17 (2023), no. 11, starting p. 1867). Its §1.10 and Lemma 1.10.2 construct composition by normalized fiber products and identify it with composition of graph paths on the étale locus. Those passages and their proofs were checked. Its later results concern finitary dynamics and finite complete sets, not infinitely many minimal coreless components between fixed targets. [Author preprint, §1.10, pp. 9–10](https://arxiv.org/pdf/2004.09689).

There is an explicit terminology warning: Bellaïche's Remark 2.2.4 distinguishes “having a core” from “finitary,” even for balanced self-correspondences. Lemma 2.3.4 proves that a cored correspondence \(D\) has finitary transpose-composition \(D^{\mathsf t}D\), and that a symmetric cored correspondence is itself finitary. The proof tracks fibers of the two rational functions defining the core. These statements do not say that corelessness is preserved by every irreducible component of every iterate. [Same preprint, Remark 2.2.4 and Lemma 2.3.4, pp. 16–17 and 19](https://arxiv.org/pdf/2004.09689).

## 2. The formal bridge needed for the proposed special case

Let \(X,Y\) be fixed smooth projective hyperbolic curves over an algebraically closed field. Suppose:

1. there is a coreless finite bi-étale correspondence between them;
2. only finitely many minimal finite bi-étale correspondences between \(X,Y\) have a core.

Then there are infinitely many minimal coreless finite bi-étale correspondences between \(X,Y\).

Here is the precise iteration argument. Minimalize the starting correspondence. Its connected generic two-colour graph is infinite by Krishnamoorthy's Proposition 5.10. Vertices have finite valencies equal to the two covering degrees, as explained before Corollary 5.16. Fix a generic \(X\)-vertex \(P\). Infinitely many \(Y\)-vertices are reachable from it, and every such vertex is the endpoint of an odd path. [Krishnamoorthy, §5, printed pp. 1190–1194](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf).

Odd paths are represented by the alternating fiber products of the original correspondence and its transpose. Each connected component is a smooth proper curve finite étale over both endpoint curves. Take its reduced image in \(X\times Y\) and normalize. This is a minimal correspondence, still finite étale over both targets: its function field is an intermediate field of each endpoint's finite étale extension, and intermediate connected covers remain étale.

If only finitely many such minimal images occurred, their finite generic fibers above \(P\) would contain only finitely many \(Y\)-vertices. Every reachable \(Y\)-vertex belongs to one of these fibers, contradiction. Thus the minimal images are infinite in number. Removing the finite cored set in hypothesis 2 leaves infinitely many coreless ones.

This proof works with fixed, labelled endpoints. Allowing endpoint automorphisms does not change infinitude because both hyperbolic curves have finite automorphism groups.

## 3. Pitfalls avoided

- Unbounded degrees or genera of the iterated sources alone do not prove that their minimal images are distinct. The generic-fiber count is the necessary argument.
- Some iterated components can have a core. For example, the backtracking fiber product with the transpose contains a component whose minimal endpoint image is the diagonal. The argument still needs a way to exclude infinitely many cored images; hypothesis 2 supplies one. This does not show that hypothesis 2 is necessary for the truth of the conclusion.
- Fiber products may be disconnected. One takes all connected components and counts endpoint images; there is no assumption of irreducibility of every iterate.
- The count uses the generic graph over an algebraically closed transcendence-degree-one extension, not an unexplained assertion about orbits of closed points.
- Normalizing an endpoint image is justified as an intermediate étale cover. This is not an arbitrary replacement of the source that discards one of the maps.

Consequently, a proved finite-cored-minimal-correspondence theorem for an ordinary genus-two endpoint in characteristic five supplies exactly the extra input needed to settle that restricted case of Question 3.21. The literature passages checked above supply the graph and composition machinery, but not that finiteness input. No general answer to Question 3.21 follows from this note.
