# Pro prompting: researcher and user reports

2026-09-10. User requested experience from actual users, superseding the
OpenAI Docs skill's official-only source preference for this task.
This note records prompt-design evidence, not mathematical proof inputs.

## Evidence consulted

| Firsthand source | Relevant observation | How much it establishes |
| --- | --- | --- |
| [Gowers's research account](https://gowers.wordpress.com/2026/05/08/a-recent-experience-with-chatgpt-5-5-pro/) | After Pro left technical claims unchecked, Gowers explicitly asked it to check them, then requested a complete mathematical write-up. His account describes further progress after those follow-ups. | A successful research workflow with expert assessment, not a controlled test of individual phrases or a GPT-6 runtime result. |
| [Huang's released experiment](https://github.com/yichenhuang/sum-product), [actual prompt code](https://github.com/yichenhuang/sum-product/blob/main/run.py) | Uses successive planning, construction, and critical-review calls. The author reports seven complete correct outputs among eight trials and publishes all transcripts, including the failure. | Stronger provenance than a timing screenshot. Still one known-result task, different model, and three actual calls; putting these stages into one prompt is our untested adaptation. Its assertion that the theorem is already known must not be transplanted to our open target. |
| [Researcher's Reddit account](https://www.reddit.com/r/OpenAI/comments/1qco4d7/52_pro_makes_progress_on_decades_long_math/) | Reports steering a model into attempting a hard problem with selected literature, clues, and encouragement; also reports falsely telling it the problem was already solved. | Anecdotal, confounded bundle of changes. Supports testing constructive framing, not claiming a causal effect or importing the false premise. |
| [Pro timing discussion](https://www.reddit.com/r/ChatGPTPro/comments/1urfp2q/thinking_time_limited_at_90_minutes/) | Contains a suggestion to allow time and online exploration, alongside sharply conflicting duration reports. | A low-confidence phrasing idea. No reliable fixed-time control or clean comparison. |
| [Long-run report](https://www.reddit.com/r/ChatGPTPro/comments/1psu3tt/how_long_can_you_make_gpt_52_pro_think_v2_revamped/) | The author reports both a long completed task and a long incorrect answer; commenters also describe stalled runs. | Reason to measure verified progress separately from elapsed time. |

The curated [research-prompt collection](https://github.com/merlinhu1/Battle-tested-Research-Prompts)
was a discovery aid. For the principal workflow recommendation, the
original researcher account and original experiment code were opened.
The shared Rybin chat link yielded no readable transcript here, so its
reposted snippets were not treated as a verified experiment.

## Changes made to the current request

The initial phrasing revision of `PRO_CYCLIC25_INITIAL_TWO_DIGIT_REQUEST.md`
retained the same actual family, proved inputs, open class, and
finite-level consequence. A subsequent independently proved algebraic
input was added as recorded below; it was not obtained from the
prompting research.

- Neutral title: evaluate the obstruction; do not presuppose it is nonzero.
- Direct permission for a substantial calculation and autonomous
  intermediate work, followed by proof and verification in the response.
- A newly isolated identity becomes the next task to attack, rather
  than automatically the stopping point. Methods remain flexible.
- Critical coefficient checked by a second derivation or exact
  finite-precision computation; sign, coefficient Frobenius, canonical
  origin, and free-fourth-digit independence are explicit checks.
- A different zero set is an acceptable mathematical answer. No false
  claim that our hoped-for criterion is known, and no demand to produce
  an affirmative result regardless of evidence.
- No clock minimum, token-padding request, arbitrary number of failed
  approaches, or long prohibition block. Literature/computation serve
  the actual unresolved step. All submission guidance stays in chat.

These are changes to encourage sustained useful work. No Pro trial of
the revised request has yet occurred, and no runtime or success gain is
claimed. Most detailed accessible evidence concerned earlier Pro models.

## Check performed before handoff

Re-read the entire current request, current continuation, and the
canonical cyclic-five theorem. Replayed
`verify_cyclic25_function_filtration.py`: all 625 basis products and
the first integral carry pass. This only rechecks its stated algebraic
inputs; it is not an evaluation of the prompt or the unknown geometric
Theta. At that handoff the additive-preparation draft was still
unreviewed and was not included as a proved input.

Subsequently, the independent mixed-additive theorem passed its bounded
audit and 1,337 exact diagnostic samples. It is now recorded as
`cyclic_power_additive_norm` and added to Section4 of the same request,
replacing the weaker scalar-only input. This removes a potential repeat
algebraic subproblem, not the new geometric Hodge comparison. The user
was told of this mathematical strengthening separately from the wording.

For the next returned answer, record new verified output, known-result
overlap, coefficient/precision defects, and whether a promising missing
step was actually pursued. Record runtime separately. One uncontrolled
run cannot isolate the effect of the new wording.

## User-supplied Astra suggestion, 17:05 CEST

The user supplied an anecdote recommending an objective task list and
a closing quality-over-speed instruction, with time allowed for thorough
work. The report itself describes the behavior as variable and the
phrasing as experimental; no additional source or measured effect was
supplied. It is recorded as a suggestion to test, not verified evidence
of control over runtime.

Integrated it by replacing the final prose directions with five concrete
completion items: construct the comparison, account for divided repair
terms, evaluate both coordinates, independently check the coefficient,
and determine the zero set with its actual geometric consequence.
These are parts of the same existing target, not five new research tasks.
Removed redundant pacing language from the opening and added the closing
instruction: quality is more important than speed; take the time needed;
avoid shortcuts on the difficult comparison and verification; pursue
remaining concrete routes before concluding. The requested anti-laziness
sentiment is expressed as this task-specific standard. Sections1--4 and
all mathematical inputs are unchanged. All user/submission instructions
remain outside the model-only request.

## Returned run, reviewed 18:20 CEST

The revised request returned after39m43s with the requested evaluated
class Theta_t(d,b)=d^5e and a new integral quadratic-product lemma.
Its 625 product checks,25 pure cases/free digits and200 mixed cases
replayed locally. A focused medium audit passed the actual geometric
comparison after making oper normalization explicit, and separately
passed its general simple-defect scope. Independent jet checks passed.
The new comparison, not just the known linear algebra, was supplied.
This was a useful response with a verifiable new result. There is no
controlled comparison proving that wording caused its duration/success.
Next user request is for a somewhat larger task at the new bottleneck;
retain the concrete task list and quality-over-speed standard.

## Next larger target, 18:28 CEST

PRO_CYCLIC25_UNIFORM_DESCENT_REQUEST.md asks one reusable all-level
descent theorem plus its full-tower consequence. Before drafting:
reviewed canonical initial/general-scope proof, cyclic5 all-level proof,
mixed-additive theorem and inventory; tested86 function products/order
budgets and replayed650 C25 mixed norm samples including later norm
digits. Remaining geometric reference dependence is stated as work,
not hidden in an input. CYCLIC25_UNIFORM_DESCENT_LOOKAHEAD.md records
why this is new and why jumping to125 would add an uncontrolled channel.

OpenAI Docs skill was used for prompt structure. Current
[Astra guidance](https://developers.openai.com/api/docs/guides/latest-model#prompting-best-practices)
was fetched; no model, effort setting or submission method was changed.
The user-preferred objective checklist and quality-over-speed closing
are retained. The local mathematical scope test, not a claim about
runtime control, is the justification for the larger request.
