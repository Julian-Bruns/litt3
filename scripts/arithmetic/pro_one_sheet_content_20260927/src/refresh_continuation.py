"""Update statements strictly from passed case verifications; no proof by counts."""
from pathlib import Path
import json,subprocess,sys
ROOT=Path(__file__).resolve().parents[1]
def main():
 subprocess.run([sys.executable,str(ROOT/'src/update_status.py')],cwd=ROOT,check=True)
 new=[]
 for p in sorted((ROOT/'evidence').glob('generation_*.json')):
  r=json.loads(p.read_text());assert r['status']=='PASS';new.append(r['name'])
 note='''
## Current continuation: execution and provenance

`evidence/inherited_recheck_current.json` records an independent recheck of
all four whole branches actually contained in the supplied checkpoint and
both boundary families. The two additional, previously reported but unarchived
checks were not assumed.

`evidence/fresh_foundation_replay.json` records fresh reconstruction starting
with source only. Both foundational replay drivers passed, and all 44 generated
foundational files also present in the archive match byte-for-byte, including
the full compact residual, integral charts, and both boundary certificate families.

New completed branches regenerated and independently verified in this
continuation: NAMES.

For each such branch, `evidence/generation_NAME.json` gives exact commands,
source/input hashes, return codes, elapsed execution times, and evidence-bearing
log excerpts. The computation starts with the full compact residual. Each joined
branch verifier then checks the global polynomial identities, support coverage,
and all finite-algebra unit identities. These are geometric algebra certificates,
not bounded finite-field searches.

The new generation command is:

```sh
python src/solve_branch.py --compile
python src/solve_branch.py ENDPOINT_BRANCH --threads 2
```

Replace ENDPOINT_BRANCH by a named installed case, for example 145049_large1.
It is restartable in `build/new_branches/ENDPOINT_BRANCH`, with unchanged
arithmetic source/input hashes. Concurrent duplicate requests are serialized by
a file lock. To rerun the source-only foundation check in a fresh directory:

```sh
python src/replay_foundation.py --workdir build/foundation_again
```

The alternative `replay_branch.py` command in the main README additionally
compares regenerated files with the installed certificates. That orchestration
was not separately run end-to-end for each newly generated branch in this
continuation; the executed generator and independent verifiers are listed above.
Inherited bounded arithmetic audits remain labelled audits, not locus proofs.
Unused alternative engines carry no new verification claim.
'''.replace('NAMES',', '.join('`'+n+'`' for n in new) if new else 'none yet')
 lemma='''
## 14. Why localization and all closed fibres prove scheme-theoretic emptiness

The following elementary ring lemma explains why the support computations
cover nilpotents as well as geometric points. It requires no computational
certificate and no reducedness or irreducibility hypothesis.

**Lemma.** Let B be a commutative ring, I an ideal, and
h=f1*...*fm. If I*B[1/h]=B[1/h] and I+(fi)=B for every i, then I=B.

**Proof.** In C=B/I the first condition says C[1/h]=0, so h^N=0
for some nonnegative integer N. Each second condition says that fi is a
unit in C. Thus h is a unit in C. A nilpotent unit forces 1=0, hence C=0.
This also covers m=0, where h=1. QED.

For each retained rational-scale branch, take B to be its full coordinate
ring localized only at the original opens and its actual rational-coordinate
and scale denominators, and I=(C71,C72). The globally defined tails in B
are obtained from the actual residual and its invertible leading coefficient.
Their representations over K(v)[S]/F can have additional base denominators;
their complete squarefree support is h.

The global scalar product identities and support-stripped Bezout identity
prove the lemma's first condition. For every factor fi, the finite-fibre
certificates prove the second: either the original opens make the fibre
empty, or the exact open saturation retains its entire allowed S algebra
and the displayed tail combination is one in that algebra. Saturation is
checked by F=F_allowed*F_removed, an inverse of the open polynomial on
F_allowed, and the vanishing of its sixth power on F_removed. No reduction
of F_allowed is taken. Factoring the squarefree base support therefore
does not silently discard any thickening: the lemma itself concludes
that the original ideal is the unit ideal, before reduction.

The pair of tail equations is only necessary for a polynomial square.
Its unit ideal already excludes the full square system; no assumption
that two tails suffice to construct a square is made.
'''
 content_note='''
## 15. The compact normalization preserves fixed coefficient content

This is an algebraic proof; no computational certificate is needed.
Fix w with w^3=q, a unit on the original open. Denote the two unscaled
polynomials defining D(w*mu) by f_un(W),g_un(W), and the two polynomials
inside the compact Ehat resultant by f_hat(T),g_hat(T). From G_i=w*Ghat_i
and y=w*z_c, their translated coefficients satisfy

`g_i=w^(1-i)*ghat_i` for i=2,3,4,5, and `Qbar=w^-5*Qhat`.

Substituting W=T/w, using q^3=w^9, gives the exact polynomial identities

`f_un(T/w)=w^-9*f_hat(T)`, `g_un(T/w)=w^-3*g_hat(T)`.

For a fixed Sylvester degree pair (10,2), scaling the variable by w^-1
multiplies the resultant by w^-20. Scaling the two polynomials by w^-9
and w^-3 multiplies it by w^(-9*2-3*10)=w^-48. Hence

`w^-20*D(w*mu)=w^-48*Res_(10,2)(f_hat,g_hat)`.

After the prescribed exact division by t^5 this is

`Ehat=w^28*D(w*mu)/t^5`.

The resultant scaling identities follow first for universal polynomials
and hence specialize to every coefficient-degree drop. No critical
leading coefficient, y, or P is inverted; only the already nonzero
constant w is used. A mu coefficient is multiplied by a nonzero constant
power of w, so its order at the corresponding curve point is unchanged.
Taking the minimum over all three coefficients proves equality of the
fixed contents before scale selection. Finally the cubic norm sends
w^28 to w^84=q^28, recovering exactly

`R=q^-28*Norm(Ehat)`.

This identifies both the square tested by the generators and the content
notion of INPUTS.md with the original normalized family, for every
geometric cube-root choice.
'''
 p=ROOT/'REPORT.md';p.write_text(p.read_text()+'\n## 13. Continuation verification record\n'+note+lemma+content_note)
 release=ROOT/'evidence/release_verification.json'
 if release.exists():
  verification=json.loads(release.read_text());assert verification['status']=='PASS'
  release_note='''
### Fresh release verification

`evidence/release_verification.json` records an executed independent check
from a fresh extraction: the manifest, both boundary certificate families,
every installed whole branch, and a second manifest check all passed.
The mathematical source/data/evidence files are bound by their recorded hashes.
To repeat this certificate check in parallel, run:

```sh
python src/verify_release.py --workers 4
```

This command checks certificates and coverage, not tail regeneration.
The separate full-generation records above document that provenance.
'''
 else:
  release_note='''
### Release coordinator status at this checkpoint

`src/verify_release.py` is a newly added parallel certificate coordinator.
It has not yet been executed and is not evidence for this checkpoint.
The executed individual verifiers and generator records are listed above.
'''
 p=ROOT/'README.md';p.write_text(p.read_text()+note+release_note)
 p=ROOT/'REPORT.md';p.write_text(p.read_text()+release_note)
 p=ROOT/'claims.json';j=json.loads(p.read_text());ids={c['id'] for c in j['claims']}
 additions=[{'id':'current_foundation_replay','status':'computationally_checked','statement':'A fresh source-only reconstruction regenerated both boundary certificate families and matched all 44 foundational files present in the archive byte-for-byte.','evidence':['evidence/fresh_foundation_replay.json','src/replay_foundation.py']},{'id':'current_inherited_recheck','status':'computationally_checked','statement':'All four archived complete branches and both boundary families passed independent certificate verification in this continuation.','evidence':['evidence/inherited_recheck_current.json']}]
 additions.append({'id':'open_closed_fibre_unit_lemma','status':'proved_theoretically','statement':'A unit ideal after inverting h, together with unit ideals on every factor fibre of h, is the unit ideal in the original ring, with nilpotents retained.','evidence':['REPORT.md#14-why-localization-and-all-closed-fibres-prove-scheme-theoretic-emptiness'],'computational_certificates_needed':False})
 additions.append({'id':'compact_content_normalization','status':'proved_theoretically','statement':'Ehat=w^28*D(w*mu)/t^5, so the compact normalization preserves fixed coefficient content and recovers the exact residual norm, including all fixed-degree resultant specializations.','evidence':['REPORT.md#15-the-compact-normalization-preserves-fixed-coefficient-content','INPUTS.md#fixed-coefficient-content'],'computational_certificates_needed':False})
 additions.append({'id':'two_tail_necessity','status':'proved_theoretically','statement':'A degree-140 square has C71=C72=0 in the normalized formal root U^63 modulo s^73 in characteristic five; no converse is used.','evidence':['REPORT.md#square-tail-identities','INPUTS.md#actual-square-criterion'],'computational_certificates_needed':False})
 for c in additions:
  if c['id'] not in ids:j['claims'].append(c)
 for c in j['claims']:
  if c['id']=='source' and 'evidence/fresh_foundation_replay.json' not in c['evidence']:c['evidence'].append('evidence/fresh_foundation_replay.json')
 p.write_text(json.dumps(j,indent=2)+'\n')
if __name__=='__main__':main()
