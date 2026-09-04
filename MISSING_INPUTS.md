# Missing inputs and reproducibility limits

This checkout is a partial export. A displayed computation is locally
reproducible only when its input equations and derivation, or an executable
certificate containing them, are present. A filename, command, cached output,
or finite point scan is not a proof by itself.

## Global route

The rewritten active files no longer depend on the former
`01_MASTER_INDEX.md` or on unexplained source labels. The following
mathematical inputs are nevertheless absent:

- the calculation excluding a weakly ramified wild over-orbifold;
- the finite arithmetic elimination excluding a non-weak wild
  over-orbifold, formerly attributed to
  `COMP-LOCAL-ARITHMETIC-CHECKS` and `ALG-LOCAL-SEARCH`;
- an exact, convention-compatible classical reference proving
  \(\operatorname{Comm}^+(\Delta(31,31,31))=\Delta(2,3,62)\);
- a characteristic-\(5\) theorem carrying the needed tame over-orbifold
  factorization from characteristic zero; and
- a simultaneous finite-Galois refinement or another valid bridge from an
  arbitrary self-correspondence to one presentation-compatible
  over-orbifold.

The common-cover descent in file `10` is no longer on this list: its
uniqueness and cocycle argument is now written out. The five items above
belong only to the alternative over-orbifold route; the profile-extraction
route has its own open Task 01.

## Profile-4 route

- Missing note `165` supplied normal-form coefficient identities assumed in
  entry-one files `171` and `174`. Those two files are conditional on those
  displayed inputs. The formal calculations in files `172` and `177` are
  self-contained and do not depend on note `165`.
- No active file derives the full entry-one bidegree normal form, proves that
  it exhausts the no-further-highpoint stratum, or supplies models or
  exclusions for the surviving degree-three and degree-four strata. File
  `162` only classifies those strata and proves field generation.
- Missing notes `52`, `60`, and `62`, together with their scripts, reportedly
  tested special subfamilies of the no-highpoint residual ansatz. Their
  recorded resultant summaries are not reproducible here and, even if
  reproduced, would need normalization-aware branch analysis.
- No active proof extracts the residual ansatz of file `170` from every
  no-highpoint profile pair. In particular, the six cross-values encoded as
  \(2,3,4\) are not justified by coordinate normalization.

No active entry-one theorem now depends on the formerly cited note `166` or
on archived files `169` and `173`.

## Double-fiber route

There are five logically separate groups of missing data.

### 1. Entry-zero specialization and normalization

The boundary and tangent calculation in file `79` does not establish that
the entry-zero parameters satisfy \(c=d=2\). With

\[
\pi=cd,\qquad \mathcal N=(1-c)(1-d),\qquad \alpha=z(P_0),
\]

the shared boundary scalar is \(K=\pi\alpha^{31}\), and the compatible exact
norm constants are

\[
\begin{aligned}
\operatorname{Nm}_{k(C)/k(x)}(z)
 &=-\pi\alpha^{31}\frac{(x-1)^2}{x^4(x-c)(x-d)},\\
\operatorname{Nm}_{k(C)/k(z)}(x)
 &=-\pi\frac{(z-\alpha)^{31}}{z^{34}(z+1)},\\
\operatorname{Nm}_{k(C)/k(z)}(x-1)
 &=\mathcal N\frac{(z-1)^2}{z^2}.
\end{aligned}
\]

The old proof effectively replaced these three constants by \(1\), although
a defining equation has only one overall scalar. Its comparisons were
therefore identities, not proofs of
\(\alpha^{31}=1\), \(\mathcal N=1\), or \(\pi=-1\). No retained argument
excludes the complementary parameter locus or shows that every entry-zero
pair enters the specialized tower. This is isolated as
[Task 00B](tasks/00B_ENTRY_ZERO_SPECIALIZATION_OR_COVERAGE.md).

Even if \(c=d=2\) is later proved, that only gives \(-\pi=1\) and
\(\mathcal N=1\); it does not give \(\alpha^{31}=1\) or the formerly used
boundary scalar \(K=-1\). Because the original formal equation and programs
are absent, any reconstruction must audit whether those further constants
were used.

### 2. Missing repeated-\(u^{20}\) transition

The retained layer chain has a material hole:

```text
97 simple-u20 -> [100 repeated-u20: absent] -> 101 simple-u25
                                              -> 104 repeated-u25
```

File `100_REPEATED_U20_MISSING_GATE.md` is only a guardrail describing the
obligation. It contains no replacement proof.

### 3. Unreproduced repeated-layer identities

The decisive closed-response and scalar identities in files `81`, `92`,
`96`, and `104` came from absent symbolic programs. Their determinant
consequences are proved conditionally, but the premises are not. This gap is
independent of note `100` and is isolated as
[Task 00A](tasks/00A_REPROVE_REPEATED_LAYER_IDENTITIES.md).

### 4. Basin and coordinate-map inputs

File `159` proves the structure of the displayed five-point ideal \(J\).
What is absent is:

- the original low-data ideal \(I_{127}\), its pivot, and a saturation
  certificate proving H127;
- the derivation of the displayed discriminant formula from the original
  basin parameterization; and
- the affine parameterization identifying the six-coordinate point
  \(r_{129}\) with the 19-coordinate terminal point called `P129`.

Older notes associated the latter data with missing numbered sources such as
`154` and `155`, but those numbers are not substitutes for a map.

### 5. Tail and terminal extraction

The full chart generator lists, repeated-\(e30\) equations, saturation
products, terminal-stratum ideals, and derivations of the recorded
\(e35,e40,e45,e50\) systems are absent. Their extraction claims therefore
remain `certificate-transcript`, even where the displayed final matrices or
one-variable systems can be checked directly.

None of the cited `.py`, `.sage`, `.sage.py`, `.sing`, or `.json` artifacts
is present. The old `pro_prompts/`, `pro_outputs/`, and cache directories are
also absent.

## Consequence for task order

Recovering note `100` alone does not make the tower self-contained. A full
entry-zero proof first needs Task 00B or another argument covering the whole
entry-zero branch. It also needs Tasks 00 and 00A, H127 in Task 04, the
generator and coverage theorem in Task 05, and exact reconstruction of every
terminal equation used there. See [the task router](tasks/README.md).
