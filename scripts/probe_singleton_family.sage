#!/usr/bin/env sage
"""One-core, bounded generic-parameter test; no family exclusion claimed.
Reuses precisely the three audited geometric chart equations.
"""
import time,sys
from pathlib import Path
from cysignals.alarm import alarm,cancel_alarm
started=time.monotonic();alarm(60)
try:
    scope={'__name__':'singleton_chart_library'}
    exec(compile(preparse(Path('scripts/backup_singleton_root_exclusion.sage').read_text()),
                 'scripts/backup_singleton_root_exclusion.sage','exec'),dict(globals(),**scope),scope)
    k=PolynomialRing(GF(5),'alpha').fraction_field()
    # Function global names need the Sage runtime, not just the exported locals.
    scope['system'].__globals__.update(globals())
    mode=sys.argv[1] if len(sys.argv)>1 else 'open'
    k,S,eq=scope['system'](mode,k)
    print('generic family',mode,'variables',S.ngens(),'equations',len(eq),flush=True)
    I=S.ideal(eq);basis=I.groebner_basis()
    print('GB',len(basis),'degrees',[f.total_degree() for f in basis],
          'dimension',I.dimension(),'seconds',time.monotonic()-started,flush=True)
except AlarmInterrupt:
    print('TIME CAP: no generic-family decision',time.monotonic()-started,flush=True)
finally:cancel_alarm()
