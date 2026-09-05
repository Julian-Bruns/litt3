# Joint-geometry literature boundary, 5 September 2026

This is a bounded literature-search record, not a new theorem or an
audit of every cited paper. It preserves the useful conclusions from
the two named subagents without requiring their chats to be loaded.
The root agent read Krishnamoorthy's invariant-line-bundle argument;
the other source assessments below are the agents' targeted reviews.

## Shared image and cores

Reviewer: `x_elliptic_quotient_maps`, 2026-09-05.

- Catanese--Rollenske, Lemma 6.1 and Remark 6.2, give the closest
  intersection-theoretic characterization. Their normalization and
  ramification terms recover the numerical balance used in file 100,
  not a stronger bound on the normalization defect. The paper is in
  characteristic zero; its intersection identities are algebraic.
  [Primary PDF](https://www.math.uni-bielefeld.de/~rollenske/papers/kodairafibrations.pdf).
- Krishnamoorthy, *Correspondences without a core*, studies the joint
  correspondence itself. An invariant line bundle is a pair of line
  bundles on the two targets together with an isomorphism of their
  pullbacks to the same source. The etale differential maps supply
  exactly such a canonical pair. Without a core, each invariant line
  bundle has at most one independent invariant section (Proposition
  8.2), and the degree-zero Picard group scheme is finite (Lemma 8.9).
  His question whether a positive-characteristic coreless etale
  correspondence always has an invariant pluricanonical form is an
  open question in this source, not an available theorem (Question
  9.7). Its clump theorem needs a finite set saturated under **both**
  maps. The preimage of the singular locus in file 100 is not known
  to have that property.
  [Published paper](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf).
- The correspondence having a core is the condition that permits a
  further cover simultaneously Galois over both legs. Alternating
  separate Galois closures does not establish that condition. The
  paper's characteristic-zero Shimura conclusions cannot simply be
  transferred to characteristic five.
- Bounds for pairwise coincidences, such as Fuertes--Gonzalez-Diez,
  Theorem 2.9, do not bound arbitrary multibranch conductor length.
  [Primary PDF](https://ddd.uab.cat/pub/pubmat/02141493v37n2/02141493v37n2p339.pdf).

For a fixed curve X and an etale Galois cover W/X with deck group H,
the standard tame bound gives
\([\operatorname{Aut}(W):H]\le84(g(X)-1)\) if the whole automorphism
action is tame. The bounded search found neither a usable uniform
bound nor a verified unbounded counterexample in the wild case.
Standard superlinear automorphism bounds do not settle it. In
particular, large automorphism groups in known Nakajima-extremal
unramified towers do not by themselves give unbounded index over the
deck group. No wild index bound may be assumed.

## Dormant opers and canonical lifts

Reviewer: `c14_elliptic_translation`, 2026-09-05.

Verdict: no theorem found that guarantees a single dormant oper on
the source descending through both legs.

- Wakabayashi's pullback results preserve dormancy. Ordinariness of
  the pullback implies ordinariness downstairs. The converse requires
  additional generality and abelian prime-to-p hypotheses. These
  remain one-leg results.
  [Primary source](https://arxiv.org/abs/1602.07061).
- The rigidity of indigenous/PGL2 opers makes the descent condition
  precise: on a Galois cover, invariance of the isomorphism class
  under the deck group supplies descent, since uniqueness gives the
  cocycle. For two maps the missing assertion is nonemptiness of
  the intersection of the two pullback images, not existence of
  separate objects. Dormant indigenous bundles are generally not
  uniquely selected by the curve: in genus two their generic number
  is (p^3-p)/24, equal to five for p=5.
  [Primary source](https://arxiv.org/abs/1411.1191).
- Mochizuki's canonicality comparison already assumes the upstairs
  ordinary indigenous bundle is a pullback. It transports canonicality
  after descent; it does not create descent or synchronize two maps.
  [Corollary 3.5, printed p. 114](https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Theory%20of%20Ordinary%20p-adic%20Curves.pdf).
- Hoshi's characteristic-three result warns that nilpotent ordinary
  indigenous bundles can become nonordinary after an etale cover.
  This is not a result specifically about dormant bundles in
  characteristic five.
  [Theorem C](https://www.kurims.kyoto-u.ac.jp/~yuichiro/rims1811revised.pdf).
- The recent higher-level duality and relative-Frobenius descent
  papers do not supply the two-etale-leg compatibility.
  [Higher-level work](https://arxiv.org/abs/2201.11266),
  [relative-Frobenius descent](https://arxiv.org/abs/2408.12267).

## Relation to the new proof frontier

Files 101--102 instead measure descent of the **already specified**
differential identification from the normalization to its singular
joint image. They do not assume the existence of an extra invariant
oper, a common core, or a saturated finite orbit. Their new interpolation
bound controls the p-primary gluing exponent by branch count, with
no dependence on contact orders. Large tangent-ratio orders and
large branch counts remain genuine unbounded parameters.
