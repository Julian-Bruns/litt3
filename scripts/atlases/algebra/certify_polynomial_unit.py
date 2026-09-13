#!/usr/bin/env python3
"""Extract a bounded Singular unit identity and replay it independently."""
import argparse,hashlib,json,subprocess,time
from pathlib import Path
from sage.all import GF,PolynomialRing
from cysignals.alarm import alarm,cancel_alarm,AlarmInterrupt
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('source',type=Path);p.add_argument('certificate',type=Path)
p.add_argument('--seconds',type=int,default=180)
p.add_argument('--algorithm',choices=['sage_lift','slimgb_lift','std_lift'],default='sage_lift',
               help='slimgb_lift tracks the transformation in Singular liftstd')
p.add_argument('--external-replay',action='store_true',
               help='Export multipliers and rely on the independent exact replay, skipping duplicate Sage expansion')
args=p.parse_args();start=time.monotonic();raw=args.source.read_bytes();data=json.loads(raw)
K=GF(5**data['field_degree'],'a',modulus=PolynomialRing(GF(5),'z')(data['field_modulus']))
R=PolynomialRing(K,len(data['variables']),names=data['variables'],order='degrevlex')
equations=[R({tuple(e):K(c) for e,c in f}) for f in data['equations']]
alarm(args.seconds)
try:
    if args.algorithm=='sage_lift':
        weights=list(R.one().lift(R.ideal(equations)))
    else:
        from sage.all import singular
        original=singular(R.ideal(equations))
        method=',"slimgb"' if args.algorithm=='slimgb_lift' else ''
        singular.eval('matrix certTransform; ideal certGB=liftstd('+original.name()+
                      ',certTransform'+method+');')
        basis=list(singular('certGB').sage().gens())
        if len(basis)!=1 or R(basis[0])!=1:
            print('COMPLETED_BASIS_NOT_UNIT_NO_CERTIFICATE',flush=True)
            raise SystemExit(0)
        transform=singular('certTransform').sage()
        weights=[R(transform[i,0]) for i in range(len(equations))]
    assert len(weights)==len(equations)
    if not args.external_replay:assert sum(w*f for w,f in zip(weights,equations))==1
    encode=lambda f:[[list(e),[int(x) for x in c.polynomial().list()]] for e,c in sorted(f.dict().items())]
    cert=dict(source=str(args.source.resolve()),source_sha256=hashlib.sha256(raw).hexdigest(),
        polynomial_multipliers=[[i,encode(w)] for i,w in enumerate(weights) if w],
        algorithm=args.algorithm,
        sage_identity_expansion_checked=not args.external_replay,
        scope='Exact identity in specified polynomial system; geometric chart dictionary separate')
    args.certificate.write_text(json.dumps(cert,separators=(',',':'))+'\n')
    print(json.dumps(dict(stage='unit_identity_extracted',seconds=time.monotonic()-start,
        multiplier_terms=sum(len(w.dict()) for w in weights),
        maximum_multiplier_degree=int(max(w.total_degree() for w in weights if w)))),flush=True)
except (AlarmInterrupt,KeyboardInterrupt):
    print('UNIT_EXTRACTION_TIME_LIMIT_NO_CERTIFICATE',flush=True);raise SystemExit(0)
finally:
    cancel_alarm()
    if args.algorithm!='sage_lift':singular.quit()
subprocess.run(['python3',str(Path(__file__).with_name('verify_field_macaulay_certificate.py')),
    str(args.source),str(args.certificate),'--kind','polynomial_primal',
    '--receipt',str(args.certificate.with_suffix('.replay.json'))],check=True,timeout=args.seconds)
