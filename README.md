# Litt Problem 3 working repository

[Problem 3](https://www.problemsilike.com/3) asks whether every pair of
smooth projective curves of genus at least two over an algebraic closure of a
finite field has a common finite étale cover. This repository develops a
possible negative answer over

\[
k=\overline{\mathbb F}_5,
\qquad Y:\ y^{31}=x(x-1).
\]

The problem is **not solved here**. The active material now gives a
refereed conditional framework, together with several exact local lemmas,
but the global extraction and all three surviving profile-4 branches still
have open gates.

## Agent reading protocol

For the current investigation, read [update.md](update.md) first; it
identifies the active frontier and corrections to older material.

Audit records are reference material, not routine reading. Use the verdict,
auditor, date, and brief objections linked from each theorem. Do not open
the full audit record unless there is a concrete reason to doubt the
theorem or investigate an objection. This keeps audit transcripts out of
the working context unless they are needed.

1. Read this file, [STRUCTURE.md](STRUCTURE.md), and
   [MISSING_INPUTS.md](MISSING_INPUTS.md).
2. Choose one target in [tasks/README.md](tasks/README.md).
3. Read that target's route README and only the source files listed there.
4. Treat a `certificate-transcript` as a claim to reconstruct, not as a
   reproducible proof.
5. Do not use `archive/` as proof input. The dated synthesis in `reference/`
   is useful for provenance, but the active modular files control status.

Historical numbers in filenames are identifiers, not a recommended reading
order.

## What is proved

- The smooth projective model of \(Y\) has genus \(15\), and
  \(Y\to S=\mathbb P^1(31,31,31)\) is a representable finite étale
  \(\mu_{31}\)-torsor.
- The symmetric quotient is
  \(S_0=[S/S_3]\simeq\mathbb P^1(2,3,62)\), with
  \(\deg K_{S_0}=14/93\).
- If every finite étale self-correspondence of \(S\) is visible over
  \(S_0\), then any curve sharing a finite étale cover with \(Y\) has
  \(g\equiv1\pmod 7\). In particular, no genus-\(3\) curve shares such a
  cover with \(Y\). The required descent, including its cocycle, is proved
  in the active global route.
- For the proposed profile-4 pair, the high-point quotient argument excludes
  three incidence cells, identifies the two entry-zero representatives, and
  excludes the paired entry-zero case.
- For the entry-zero representative, file `79` fixes the compatible norm
  constants and the tangent leading form. Its audit shows that these
  comparisons do **not** establish \(x(Q_1)=x(Q_\infty)=2\); reaching that
  specialization, or
  treating its complement, is a new open gate.
- Several local ramification, simple-layer, determinant, and displayed
  basin-quotient calculations are proved under their explicitly stated
  inputs. See the route indexes for their exact scope.

None of these statements proves visibility or profile-4 nonexistence.

## Active dependency picture

```text
non-visible self-correspondence
             |
             v
Task 01: profile extraction (open)
             |
             v
fixed profile-4 pair
     |              |                 |
     v              v                 v
Task 02         Task 03       entry-zero norm audit 79
entry-one       no-highpoint            |
(open)          (open)                  v
                            Task 00B: specialization/coverage
                                      |
                                      v
                            repeated-layer identities (00A)
                            + missing repeated-u20 (00)
                            + basin containment H127 (04)
                            + coverage and terminal extraction (05)
                                      |
                                      v
                             entry-zero exclusion (open)
     |              |                 |
     +--------------+-----------------+
                    |
                    v
                 visibility
                    |
                    v
       proved descent + canonical degree
                    |
                    v
     conditional negative answer to Problem 3
```

File `79` proves the correctly normalized boundary and tangent formulas from
its displayed inputs. The old further arrow to \(c=d=2\) was circular: it
set several independent norm constants equal to one even though the defining
equation has only one overall scalar. Task 00B must justify the specialization
used by the retained tower, exclude its complement, or replace the tower by a
uniform argument.

Tasks 00, 00A, and 00B are independent prerequisites. Recovering the missing
repeated-\(u^{20}\) note does not prove the transcript-only response identities
in files `81`, `92`, `96`, and `104`; neither repair establishes that every
entry-zero pair lies in the specialized tower. Conversely, solving Task 00B
does not fill either formal-layer evidence gap. The terminal transcripts also
need derivations from the actual local equations, not just verification of
their displayed final polynomials.

There is a separate global over-orbifold route. It currently needs both wild
exclusions, an exact complex commensurator reference, a characteristic-\(5\)
tame specialization/overgroup theorem, and a simultaneous finite-envelope
bridge. It does not presently establish visibility and is not a substitute
for Task 01.

## Evidence labels

- `proved-text`: the retained file contains a proof of the stated result.
- `conditional-proof`: the implication is proved, but one or more named
  premises are not established in this checkout.
- `certificate-transcript`: formulas or output are recorded, but their
  derivation or executable certificate is absent.
- `open`: a target, not an established theorem.
- `missing dependency`: an input is known to be absent.
- `archived`: deliberately outside the active proof graph.

A file can contain more than one label; always use the status attached to the
specific assertion being cited.

Throughout, unrestricted variables range over \(k\), not over \(\mathbb F_5\).
Prime-field computations may verify polynomial identities or serve as
regression tests, but sampling \(\mathbb F_5\)-points does not prove a claim
over \(\overline{\mathbb F}_5\). In particular, never replace \(a^5\) by
\(a\) for an unrestricted parameter.

The original workflow note is preserved in
[archive/PROVENANCE.md](archive/PROVENANCE.md).
