"""New lattice bound using the actual two-map congruence.

The principal marked-divisor lattice is an accepted input.  This source
intersects it with the extra condition that all three sheet counts at
each root agree modulo three.  It does not recompute the Jacobian or
assert that a vector in this smaller lattice has an actual realization.
"""
import json,sys
from pathlib import Path

out=Path(sys.argv[1]); out.parent.mkdir(parents=True,exist_ok=True)
R=PolynomialRing(ZZ,'T'); T=R.gen(); Q=T^8+T^4+1
G=R([-652173,104828,-133365,8040,4980,-494720,-65556,30252])
B=matrix(ZZ,[[(T^j*G%Q)[i] for i in range(8)] for j in range(8)])
L=B.row_module().intersection((3*identity_matrix(ZZ,8)).row_module())
C=L.basis_matrix().LLL()
record={'scope':'necessary actual norm relation lattice, principal relations plus the actual two-map sheet congruence modulo three',
 'exact_kernel':False,'conditional':False,
 'principal_generator':list(map(int,G)),
 'additional_condition':'all eight rootwise sheet-difference coordinates divisible by three',
 'basis_rows':[[int(x) for x in row] for row in C],
 'index_in_principal_lattice':int(abs(C.det())//abs(B.det())),
 'no_realization_assertion':True}
out.write_text(json.dumps(record,indent=2)+'\n')
print(json.dumps({'index':record['index_in_principal_lattice'],'basis_rows':record['basis_rows']}),flush=True)
