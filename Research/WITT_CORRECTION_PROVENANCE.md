# Are the two recent corrections inherited from a shared bad input?

2026-09-10. User-requested provenance check, not a new geometric theorem.

## 1. Secondary transfer: two differently oriented quantities

PRO_SECONDARY_NORM_TRANSFER_REQUEST.md §4 equation(3) gives the
POSITIVE divided Psi/norm comparison

    (e² phi(xi)-N eta)/5 = -eta0(1+2e)-d^5e.

Its constant coordinate -eta0 is correct. Section3 equation(2) asks
instead for the ACTUAL obstruction epsilon, under the declared
rho(S+xi)=rho(S)-Psi(xi) convention. The returned proof identifies
its constant coordinate as +eta0, because the obstruction has the
opposite orientation to that positive comparison. No norm coefficient
or integral deck relation was changed.

The prompt's phrase 'CONSTANT coordinate predicted by(3)' could invite
confusion between these quantities. This was a framing ambiguity, not
a false input asserting that the actual epsilon equaled(3). The next
dihedral prompt explicitly supplies the positive obstruction carry
+d^5q, so that ambiguity was not propagated.

## 2. Initial dihedral proof: a new Taylor combinatorial estimate

Neither PRO_DIHEDRAL_INITIAL_OBSTRUCTION_REQUEST.md nor the earlier
secondary-transfer prompt supplies the erroneous bound
n+floor(n/2)-v5(n!). It was introduced in the returned proof for a
quadratic displacement variation. It counts all n displacement factors
as changed, whereas a quadratic term changes exactly TWO.

The exact coefficient is binomial(n,2)/n!=1/(2(n-2)!), giving

    2+floor(n/2)-v5((n-2)!) >=3.

The correction weakens the estimate but preserves the required zero
modulo125. It changes no coefficient in epsilon=d^5q or the asserted
B_t=0. The valid bound follows for n>=4 from v5(m!)<=m/4, with n2,3
checked directly. The actual Taylor expression in LSYZ§5 uses precisely
the factorial n! that leads to this combinatorial coefficient.

## 3. Shared geometric input rechecked directly

Both arguments use the actual weight-one filtered/graded construction.
Reopened primary source LSZ1311.6424, Lemmas4.7 and4.10, and
LSYZ1404.0538 §5. In column convention its relevant matrices are

    tilde connection=5d+[[5alpha,25beta],[gamma,5delta]],
    tilde filtered morphism=[[g1,5b],[0,g0]].

The graded diagonal/lower-Higgs entries are prescribed; these are not
raw rescaled arbitrary graph matrices. Modulo5 the connection operator
is O-linear, off-diagonal and square-zero, hence D² is divisible by5.
This justifies the operator bound used in the corrected Taylor estimate.
It is independent of the sign convention in Section1. The primary
construction and the stored prompt inputs agree on this fact.

scripts/verify_witt_comparison_conventions.py independently replays
all125 leading norm triples and the four sufficient Taylor bounds
through degree20000, including factorials divisible by5. The all-degree
argument is the inequality above, not the finite search. This script
does NOT replace the geometric proofs or their focused audits.

Conclusion: the two corrections have different causes. No shared false
input was found. The first distinguishes a comparison from an obstruction;
the second is an overstrong estimate newly introduced by the model.
The displayed B_t=0 conclusion and the previous transfer survive both
checks. Historical prompts are retained unchanged as provenance, while
current proofs use the corrected convention and bound explicitly.
