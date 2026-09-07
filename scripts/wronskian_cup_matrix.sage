#!/usr/bin/env sage
"""Exact24x24 cup matrices for the stable J space and saved extensions."""
from pathlib import Path
source=Path('scripts/wronskian_matrix_pencil.sage').read_text()
marker="for sample in saved['samples']:"
assert source.count(marker)==1
exec(preparse(source.split(marker)[0]))
dual=json.loads(Path('Research/computations/wronskian_serre_dual.json').read_text())
canon=json.loads(Path('Research/computations/canonical_atlas_system.json').read_text())
prior=json.loads(Path('Research/computations/wronskian_matrix_pencil.json').read_text())
S=matrix(k,[parse(row) for row in dual['S_matrix']])
Bc=matrix(k,[parse(row) for row in canon['Bc']])
mons32=basis(32); mons64=basis(64)
ss=[poly(vector(k,[int(j==i) for j in range(24)]),mons32) for i in range(24)]
products=[[coeff(mul(u,v),mons64) for v in ss] for u in ss]
assert all(poly(products[i][j],mons64)==mul(ss[i],ss[j]) for i in range(24) for j in range(24))
def cup(eta):
    functional=eta*S
    M=matrix(k,[[functional*p for p in row] for row in products])
    assert M==M.transpose()
    return M
out={'scope':'Exact cup-matrix probes; one full-rank J example rejects the proposed universal-singularity shortcut','definition':'M_eta(s,t)=Res_O eta*s*t*theta','L32_monomials':mons32,'samples_J':[],'samples_extension':[]}
for seed in range(202609091,202609096):
    rng=random.Random(seed)
    beta=vector(k,[k(rng.randrange(5))+a*rng.randrange(5) for _ in range(32)])
    eta=Bc*beta; M=cup(eta)
    item={'seed':seed,'beta':enc(beta),'rank':M.rank(),'determinant':str(M.det())}
    if not out['samples_J']: item['matrix']=[enc(row) for row in M.rows()]
    out['samples_J'].append(item)
    print('J seed',seed,'rank',M.rank(),flush=True)
for sample in prior['samples']:
    eta=parse(sample['normalized_eta_coefficients']); M=cup(eta)
    out['samples_extension'].append({'seed':sample['seed'],'rank':M.rank(),'determinant':str(M.det()),'eta_in_J':bool(eta in Bc.column_space())})
    print('extension seed',sample['seed'],'rank',M.rank(),flush=True)
out['universal_J_singularity_shortcut_refuted']=any(s['rank']==24 for s in out['samples_J'])
out['elapsed_seconds']=time.monotonic()-started
Path('Research/computations/wronskian_cup_matrix.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
