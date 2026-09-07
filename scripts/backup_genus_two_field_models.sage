#!/usr/bin/env sage
"""Freeze exact finite-field models before concurrent backup jobs."""
import json
from pathlib import Path
root=Path(__file__).resolve().parents[1]
outside=Path('/Users/julian/Documents/litt3-computation-data/backup-genus-two')
target=root/'Research/computations/backup_genus_two_field_models.json'
data=json.loads(target.read_text()) if target.exists() else {}
set_random_seed(20260907)
for degree,old in [(15,'tensor_trivial_p500.json'),(120,'tensor_twist0_p500.json'),(360,None)]:
    key=str(degree)
    if key in data: continue
    if old and (outside/old).exists():
        saved=json.loads((outside/old).read_text())
        modulus=saved['field_modulus']
    else:
        k=GF(5**degree,name='c')
        modulus=[int(c) for c in k.modulus().list()]
    R=PolynomialRing(GF(5),'x')
    assert R(modulus).degree()==degree and R(modulus).is_irreducible()
    data[key]=modulus
target.write_text(json.dumps(data,indent=1)+'\n')
print('Frozen field models',sorted(data),str(target),flush=True)
