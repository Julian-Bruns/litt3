"""PREPARED ONLY: new ordinary finite-C5 contact-five necessary gate.

The accepted contact-ten PSC7/8 certificate is NOT a contact-five
certificate. This fresh run must continue the exact integral PRS to
indices0..4 and emit all newly used coefficients. No old PSC array or
unrecorded recurrence state is used. Run only after the parent inspects
this source and approves a one-thread core lease with a HARD external30s
timeout. Partial data, a timeout, or a retained factor makes no decision.

Scope: the original actual endpoint functions over char5, kappa^3=1,
finite unitz, s=z(P)^3 outside0,1, Xi/P(xi)/q0(xi) all nonzero, actual
uniform pi-index5 with different at least8. The frozen numerator has
contact at least5 in the ordinary X1 parameter. Its quadratic norm N
then has a root of multiplicity at least5. In char5 ANY such root gives
gcd(N,N') degree at least5: at multiplicity5 the derivative of the leading
term vanishes, and at multiplicity>=6 the usual bound is already>=5.
For fixed degrees46,45 this forces PSC0..4 to vanish. Exceptional s0/1,
finite P-branches, Xi0 and q0-zero branches are retained, not extrapolated.
"""
from pathlib import Path
import hashlib

# Reuse only the frozen setup, exact helpers and tiny deficient-remainder
# calibration. The source is pinned byte-for-byte; its PRS is NOT executed.
# This avoids maintaining a second independent copy of field encoding,
# norm polynomial or Ducos/Lazard helpers. The original successful source
# and its external numerical certificate remain untouched.
frozen_path=Path(__file__).with_name('oct03_frozen_conic_principal_subresultant_probe.sage')
frozen_bytes=frozen_path.read_bytes()
frozen_hash=hashlib.sha256(frozen_bytes).hexdigest()
assert frozen_hash=='1d0af74316396703298b23f142e0d24c41b9c141c81218eba8c36a9a0b9f0b47'
marker='# Instrumented schoolbook subresultants, equivalent to Sage'
frozen_text=frozen_bytes.decode()
assert frozen_text.count(marker)==1
setup=frozen_text.split(marker)[0]
exec(compile(setup,str(frozen_path),'exec'),globals())
emit({'event':'new_contact_five_setup',
      'frozen_setup_sha256':frozen_hash,
      'reused_scope':'setup/helpers/tiny deficient-remainder calibration only; no old PRS or PSC data',
      'new_necessary_root_multiplicity':5,
      'new_necessary_gcd_degree':5,
      'new_required_PSC_indices':list(range(5)),
      'retained_exceptions':['s=0','s=1','finite P-branches','Xi=0','q0=0'],
      'scope':'actual ordinary finite uniform-C5, different>=8, kappa^3=1; necessary gate only'})

# Replace the setup's contact-ten recorder. Its old recorder was defined
# but never invoked, since the old PRS body was excluded above.
used={}
candidate=None
def record_psc(j,poly):
    global candidate
    if j<0 or j>4: return False
    value=Rs(poly[j])
    if j in used:
        assert used[j]==value
        return False
    used[j]=value
    if value:
        candidate=value if candidate is None else gcd(candidate,value)
    reduced=None if candidate is None else strip_known(candidate)
    emit({'event':'principal_subresultant','index':int(j),
          'coefficient_degree_s':-1 if value==0 else int(value.degree()),
          'coefficient_codes':[code(c) for c in value.list()],
          'used_indices':sorted(int(i) for i in used),
          'common_factor_away_from_known_exceptions_degree':None if reduced is None else int(reduced.degree()),
          'common_factor_away_from_known_exceptions_codes':None if reduced is None else[code(c) for c in reduced.list()]})
    if reduced is not None and reduced.degree()==0:
        emit({'event':'necessary_contact_five_gate_excluded',
              'used_indices':sorted(int(i) for i in used),
              'conclusion':'No frozen norm root multiplicity>=5 for any geometric s outside0,1; only stated ordinary finite-C5 locus',
              'unresolved':['s=1 diagonal frozen branch','finite P-branches','Xi=0','q0=0','actual source existence']})
        return True
    return False

# Same exact integral PRS recurrence and deficient-index handling as the
# pinned source. Every step is newly computed for this lower threshold.
A=Nd
scale=Nd.leading_coefficient()**(N.degree()-Nd.degree())
B=N.pseudo_quo_rem(-Nd)[1]
step=0
decided=False
while B:
    if time.monotonic()-started>25:
        emit({'event':'soft_budget_unresolved','conclusion':'No decision; partial new lower-PSC data only'})
        break
    step+=1
    da=int(A.degree());eb=int(B.degree());delta=da-eb
    assert delta>=1
    emit({'event':'subresultant_remainder','step':step,'index':da-1,'degree_X':eb,
          'maximum_coefficient_degree_s':max(int(c.degree()) for c in B.list() if c)})
    if record_psc(da-1,B):
        decided=True;break
    if delta>1:
        C=scalar_exact_div(B.leading_coefficient()**(delta-1)*B,scale**(delta-1))
        for j in range(eb+1,da-1):
            if record_psc(j,R.zero()):
                decided=True;break
        if decided: break
        if record_psc(eb,C):
            decided=True;break
    else:
        C=B
    if eb==0: break
    denominator=scale**delta*A.leading_coefficient()
    B=scalar_exact_div(A.pseudo_quo_rem(-B)[1],denominator)
    A=C
    scale=A.leading_coefficient()
if not decided:
    reduced=None if candidate is None else strip_known(candidate)
    emit({'event':'finished_contact_five_unresolved',
          'used_indices':sorted(int(i) for i in used),
          'common_factor_degree':None if reduced is None else int(reduced.degree()),
          'common_factor_codes':None if reduced is None else[code(c) for c in reduced.list()],
          'conclusion':'Necessary factor or incomplete computation retained; no all-geometric contact-five decision'})
