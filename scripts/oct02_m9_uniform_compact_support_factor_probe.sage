#!/usr/bin/env sage
"""Known-boundary deflation of the NEW one-J rational critical-x support."""
import json,time,signal,argparse
from pathlib import Path
parser=argparse.ArgumentParser();parser.add_argument('--uniform-gap',action='store_true');args=parser.parse_args();started=time.monotonic()
def expired(s,f):raise TimeoutError('compact support known-boundary factor probe hard10s')
signal.signal(signal.SIGALRM,expired);signal.setitimer(signal.ITIMER_REAL,10)
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform');meta=json.loads((folder/'compact_norm_symbolic_prototype.json').read_text());d=json.loads((folder/'source_e_J111_case00_gap.json').read_text()) if args.uniform_gap else meta
R5=PolynomialRing(GF(5),'t');E=GF(5**8,'e',modulus=R5(meta['field_modulus']));beta=E(meta['beta']);R=PolynomialRing(E,'x');x=R.gen();F=R.fraction_field()
def code(c):return E(c%5)+E(c//5)*beta
def poly(cs):return R([code(c) for c in cs])
P=poly([11,22,18,5,19,20,15,16,9,22,1]);A=poly([1,21,14,22,13]);Z=poly([15,19,24,12,10,19,3,24,18,16]);q=poly([13,18,24]);q3=poly([1,22,9,1])
num=R([E(v) for v in d['numerator']]);den=R([E(v) for v in d['denominator']]);S=PolynomialRing(F,'z');z=S.gen();lam=-q3(x)/q(x);delta=S(q3.list())+lam*S(q.list());assert not delta(x)
KP=S(Z.list())*delta;KP=KP.quo_rem(S(P.list()))[0]
# The marked root x is already known.  Norm only through the complementary
# quadratic, avoiding generic rational-function Sylvester determinants.
qa=delta[2]+x;qb=delta[1]+delta[2]*x+x*x
def root_norm(g):
 a,b=F.zero(),F.zero()
 for c in reversed(g.list()):a,b=c-qb*b,a-qa*b
 return (g(x)*(a*a-qa*a*b+qb*b*b)).numerator()
boundaries={'q_infinity':q,'critical_discriminant':((qa*qa-4*qb)*delta.derivative()(x)**2).numerator(),
 'cubic_branch':root_norm(S(P.list())), 'selected_critical':root_norm(S(A.list())), 'K_zero':root_norm(KP)}
stripped=num;removed=[]
for label,b in boundaries.items():
 removed_degree=0
 while b.degree()>0:
  g=stripped.gcd(b)
  if g.degree()<=0:break
  stripped//=g;removed_degree+=g.degree()
 removed.append({'boundary':label,'removed_degree':int(removed_degree),'boundary_degree':int(b.degree())})
factors=[{'degree':int(f.degree()),'multiplicity':int(m)} for f,m in stripped.factor()]
out={'scope':'One-J source compact norm support only; exact boundary deflation and residual factor degrees, no source-fiber realization or full parameter closure.',
 'raw_numerator_degree':int(num.degree()),'raw_denominator_degree':int(den.degree()),'deflated_degree':int(stripped.degree()),'removed':removed,'residual_factors':factors,
 'deflated_polynomial':[[int(c) for c in v.polynomial().list()] for v in stripped.list()],'seconds':time.monotonic()-started}
if args.uniform_gap:
 pole_allowed=q*boundaries['critical_discriminant'];remaining=den
 while remaining.degree()>0:
  h=remaining.gcd(pole_allowed)
  if h.degree()<=0:break
  remaining//=h
 assert remaining.degree()==0
 out.update(scope='Uniform pole3 B0 gap-only norm. Numerator coprime known simple critical boundaries; all denominator support is q=0 or critical discriminant. This supports regular extension to simple branch/selectedcritical markings, not repeated critical normalization.',denominator_other_support_degree=int(remaining.degree()),all_known_numerator_boundary_gcds_zero=all(v['removed_degree']==0 for v in removed))
(folder/('uniform_gap_support_boundaries.json' if args.uniform_gap else 'compact_support_known_boundary_deflation.json')).write_text(json.dumps(out,indent=2,default=int)+'\n')
print('DEFLATEDdegree',stripped.degree(),'factors',factors,'seconds',out['seconds'],flush=True);signal.setitimer(signal.ITIMER_REAL,0)
