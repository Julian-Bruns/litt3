"""Only the short leading jets of Tr(t*x^j*delta(Lambda)/eta)."""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
source=Path(__file__).with_name('degree140_polynomial_multiplier_localized_20260930.sage').read_text()
source=source[:source.index('out={(n,j):')].replace('N=26;','N=10;')
exec(preparse(source))
Z=large
phi=div(frobenius(Z)+qpoly,frobenius(y))
ss=div(gs[0]*Z^3+gs[1]*Z^2+gs[2]*Z+gs[3],frobenius(y))
eta=div(3*gs[1]-gs[0]*Z,2*y^3)
lam=-(div(ss,phi)+div(tt^3,phi^2))
assert eta.valuation()==-16 and lam.valuation()==-4
base=div(df*lam.derivative()^2,eta)*tt
leading=[]
for j,n in enumerate([3,4,5]):
 val=div(base,lam^(n+1));assert val.precision_absolute()>3*j-1
 leading.append(-project(val[3*j-1]))
save({'ring':R,'leading':leading,'eta_jets':[project(eta[-16+i]) for i in range(3)],
      'lambda_jets':[project(lam[-4+i]) for i in range(3)]},str(root/'inverse_eta_multiplied_leading'))
report={'scope':'only leading coefficients; not a global scale decision',
 'coefficients':[{ 'numerator':str(c.numerator()),'denominator':str(c.denominator()) } for c in leading],
 'seconds':time.time()-start}
(root/'inverse_eta_multiplied_leading.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
