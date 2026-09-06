# Independent audit: all Cartier symmetric-power HN polygons

Date: 2026-09-06. Auditor: `/root/cartier_symmetric_power_hn_major_audit`.
Audited text: `Solutions/Sol_all_symmetric_cartier_hn.md`.

**Verdict: PASS, with no breaking issue found.** The geometric argument
establishes the stated ordinary HN formula for all degrees, including
`n >= p`, assuming the precise graded Jordan lemma in Section 2. That
lemma was supplied as independently source-checked; this audit checks
its use and the exact-sequence deduction, but does not repeat the source
audit. No old audit or tensor-power theorem was used as a proof input.

## The potentially dangerous geometric step

1. **The quotient connection is correct.** Evaluation identifies the
   quotient by the pulled-back unit with `(alpha)`. Differentiating in
   the full algebra gives a constant for `alpha`, which becomes zero in
   this quotient. Thus the induced connection has `N(alpha)=0` and
   `N(alpha^i)=i alpha^(i-1)` for `i >= 2`, with the sign in
   `nabla_partial=partial-N`. On the symmetric algebra it acts by the
   derivation rule, in every degree. No division by `n!` occurs.

2. **Differential closure really is a subbundle.** Write `T` for the
   graded monomial vector space and `S_w = k[N] T_(>=w)`. In an etale
   coordinate, the Leibniz rule gives exactly

       sum_(j=0)^(p-1) nabla_partial^j(V_(>=w)) = O_C tensor S_w.

   One containment follows by expanding derivatives of coefficients;
   the other follows by applying the connection to constant monomial
   sections. Here `N^p=0` in every symmetric degree because the pth
   iterate of a derivation in characteristic p is a derivation and
   vanishes on the generators. Also `partial^p=0` on an etale coordinate
   ring. This proves stability and constant rank, including for the
   successive quotients. Intrinsic minimal connection-stable closure
   proves coordinate independence. Cartier descent consequently gives
   actual subbundles and locally free quotients downstairs.

3. **The computed graded pieces genuinely glue.** A coordinate change
   sends `alpha` to `a alpha + higher powers`, where `a` is the coordinate
   derivative. Consequently it acts on *every* monomial of total weight
   `q` by the same leading scalar `a^q`, also when `n >= p`. The induced
   graded subquotients of `S_w/S_(w+1)` therefore glue as copies of
   `omega^q`. Higher-weight transition terms preserve the filtration
   and cause no problem. This proves the assertion without asserting
   that individual Jordan blocks glue or that the bundle splits.

4. **Uniform chain length is justified.** A homogeneous Jordan
   decomposition identifies `S_w` with the sum of blocks whose top
   weights are at least `w`. Thus `S_w/S_(w+1)` consists precisely of
   blocks with top weight `w`. The only nonfree block, if present, has
   top weight `M`; the entire weight-`M` space is one-dimensional, so
   no free block can share that top weight. Every nonzero quotient
   therefore has a single common chain length. Its adjacent graded
   connection maps are isomorphisms, as required by the oper lemma.

## Semistability and the formula

For a subbundle downstairs, intersect its horizontal pullback with the
induced weight filtration. The graded connection maps inject each
upper graded piece into the next lower one tensored with `omega`, so
the ranks decrease as weights increase. Each piece embeds in a direct
sum of the same line bundle, giving the stated degree bound. The
weighted-average inequality then proves semistability of each descended
quotient. This argument does not assume semistability of a tensor or
symmetric power in positive characteristic.

The free-chain slopes strictly increase with top weight. The shorter
exceptional chain is at the unique highest top weight and has strictly
larger slope than all other factors. Hence the filtration, after
omitting zero steps, is the ordinary HN filtration. Translating bottom
weight `b` to slope exponent `2b+p-1` verifies formula (2), and the
exceptional terms and `n=0` case agree.

The graded exact-sequence deduction in Section 2 is compatible with
this use: graded free modules split off by injectivity/projectivity;
when `n=1 mod p`, the remaining cosyzygy has length `p-1` and top weight
`(p-1)n`. No ungraded-to-graded or cyclic-group-action substitution is
needed.

## Brief suggestions

No mathematical repair is required. For readability, add the displayed
local equality with `S_w` and its two-containment Leibniz justification
to Section 3; explicitly define the quotient's induced filtration using
intersection followed by image. Mention that zero filtration steps are
omitted. These would make the central geometric argument easier to
verify without changing the theorem or its scope.
