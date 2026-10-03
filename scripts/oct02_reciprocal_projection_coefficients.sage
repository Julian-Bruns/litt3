#!/usr/bin/env sage
"""Universal finite-chart source projection, without global rank sweep."""
from pathlib import Path
src=Path('scripts/oct02_reciprocal_complement_global_jets.sage').read_text().split('rows=[]')[0]
exec(preparse(src))
for power in [2,3]:
    print('power',power)
    for g in direct:
        cs=[]
        for j in range(power+1):
            p=pair(jmul(jpow(Nx,power-j),jpow(N0,j)),g)
            cs.append(tuple(v*F**3*binomial(power,j)*(-1)**j for v in p))
        print(cs)
