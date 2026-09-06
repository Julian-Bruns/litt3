# Independent audit: Cartier endomorphism HN filtration

Auditor: `/root/cartier_endomorphism_hn_major_audit` (independent agent).
Date: 2026-09-06.
Verdict: **PASS; no breaking objection found.**

Audited source:
[CARTIER_ENDOMORPHISM_HN_IS_THE_DIFFERENTIAL_OPERATOR_FILTRATION.md](../CARTIER_ENDOMORPHISM_HN_IS_THE_DIFFERENTIAL_OPERATOR_FILTRATION.md).
The source was not edited. The audit read its pairing dependency,
[file22, Proposition 2](../22_CARTIER_BUNDLE_ETALE_FUNCTORIALITY_AND_LIMITS.md),
and independently checked the statement and conventions of
[Sun, Theorem 2.2, arXiv:math/0611360v2, page 5](https://arxiv.org/pdf/math/0611360).
No audit archive or finite-prime matrix computation is a proof dependency.

## General odd characteristic

The operator construction is intrinsic. For order less than p the usual
local differential-operator basis consists of ordinary derivatives, with
invertible factorials. Killing 1 removes precisely the multiplication
term. These operators commute with multiplication by pth powers and kill
the Frobenius image of O_C1, so they act on B. Coordinate changes preserve
both this action and the order filtration; the order-j symbol gives T^j.

The trace computation is valid over the coordinate ring, not just at the
zero fiber. Reducing a monomial exponent by p introduces a factor t^p but
can create a diagonal coefficient only when a-j is divisible by p. In
the stated bounds this means a=j. For that case the falling-factorial
polynomial has degree between 1 and p-2 and zero constant term, and its
sum over F_p vanishes. Passing to B removes the constant basis vector
without introducing another diagonal term.

The fiberwise injection is valid despite R=k[t]/(t^p) being nonreduced.
In a relation sum a_j partial^j=0, evaluation successively on 1,t,...
isolates j! a_j after the previous coefficients vanish. No cancellation
or division by a nonunit of R is used. If a nonzero D has largest index
m, then partial composed with D has coefficient f_m at index m+1;
derivatives of coefficients contribute only to lower indices. The bound
m+1<=p-1 is exactly what makes the independence argument applicable.
Consequently a D with constant image is zero. Equal ranks and this
fiberwise injection give the claimed vector-bundle isomorphism.

Sun's theorem applies to relative Frobenius of the stated smooth
projective curve over the algebraically closed field. Every T^j is a
stable line bundle; genus at least two supplies stability of F_*T^j.
Its rank is p and its degree is (p-1-2j)(g-1), as follows directly from
Euler characteristic. These slopes strictly decrease in the order
filtration, proving that it is the ordinary HN filtration. The scalar
trace splitting is available because p-1 is nonzero. The p=3 endpoint
also works: End_0(B) is the single stable quotient F_*T of slope zero.

The finite etale compatibility assertions follow from the relative
Frobenius Cartesian square, flat base change, and the etale locality of
differential operators and their symbols. No stability-under-arbitrary-
pullback assertion is needed.

## Characteristic five

The Raynaud pairing is well-defined modulo pth powers: changing the
second representative leaves its differential unchanged, and changing
the first adds an exact form after pulling out a pth power through
Cartier. Alternation follows from Cartier killing d(ab). Locally its
matrix on t,...,t^(p-1) has nonzero antidiagonal entries j for i+j=p,
times the target differential du, which verifies perfection directly.

The symplectic Lie algebra identification is correctly twisted:
sp(B)=Sym^2(B) tensor omega_C1^(-1). The derivation identity in (6)
proves that F_*T lies in sp(B). This is a subbundle there: its inclusion
is already fiberwise injective into End_0(B), and sp(B) is a direct
summand of End_0(B) in this characteristic.

The trace form on sp4 is perfect in characteristic five, including the
off-diagonal entries of the symmetric Q and R blocks, where the only
extra coefficient is 2. The positive stable slope of L=F_*T and negative
stable slope of L^dual force the restricted trace pairing to vanish.
Perfection and the rank-five subbundle property imply that the map
sp(B)->L^dual is surjective on every fiber and has kernel exactly L.
Thus (7) is an exact sequence of bundles and its stable end terms of
slopes 2(g-1)/5 and -2(g-1)/5 make it the full HN filtration.

The adjoint decomposition and primitive exterior splitting are correct
in characteristic five. The contraction of the inverse form is a unit
(up to normalization it is 2); the identity has nonzero trace 4. Hence
End_0(B)=sp(B) direct_sum P. HN slopes of a direct sum are the merged
slopes of its summands. The previously computed positive and negative
pieces exhaust sp(B), forcing P to be semistable of slope zero.
All quoted symmetric-square and tensor-square slopes and ranks follow
after the indicated canonical-line-bundle twist.

## Nonbreaking suggestions and scope

- It may help to state explicitly that L is a subbundle of sp(B), as
  justified above, before invoking the maximal-isotropic argument.
- The phrase "all degree-two tensor polygons" can be made explicit as
  B tensor B, Sym^2(B), Lambda^2(B), End(B), End_0(B), and their dual or
  line-twisted versions. Here B^dual=B tensor omega_C1^(-1), so tensors
  involving the dual give no additional polygon. This should not be
  read as a statement about arbitrary subbundles or additional curve
  dependent constructions.
- In fact P is stable and isomorphic to F_*T^2: uniqueness of HN and the
  direct-sum decomposition identify P with the middle stable graded
  piece of End_0(B). This strengthening is optional and is not needed
  for the source's conclusion.

The result establishes a universal-invariant boundary in the stated
scope. It neither solves Litt3 nor proves universality of higher tensor
HN polygons, section counts, theta divisors, or the Cartier bundle itself.
