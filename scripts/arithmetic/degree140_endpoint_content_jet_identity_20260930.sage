"""New universal endpoint identity, checked in a truncated formal DVR.

Allow all coefficient jets through order five; only the two stated
source congruences are imposed. The conclusion concerns fixed content,
not squareness or actual étaleness by itself.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
names=[f'{v}{j}' for v in ['a','b','c','e','u','k'] for j in range(6)]
R=PolynomialRing(GF(5),names=names)
S=PowerSeriesRing(R,'t',default_prec=6);t=S.gen()
dd=dict(zip(names,R.gens()))
series={v:sum(dd[f'{v}{j}']*t^j for j in range(6)).add_bigoh(6)
        for v in ['a','b','c','e','u','k']}
a,b,e,u,k=[series[v] for v in ['a','b','e','u','k']]
c=t*series['c'];q=t^3*u;tau=t^3*(-u*e+t^2*k)
d=b^2+2*a*c;B=a^5*q^2+b^5*q+2*c^5;T=b^5+2*a^5*q
U=2*e*a^2+a*b*c+2*b^3
KK=a*c^3+b^2*c^2+b^3*e+3*a^2*e^2+3*a*b*c*e
C0=2*q*e*a^5+q*a^4*b*c+2*q*a^3*b^3+e*b^5-a^2*c^4-2*a*b^2*c^3+b^4*c^2
D2=4*B^2
D1=4*B*C0+4*tau*(T^2-2*a^5*B)
D0=3*a^3*B*KK+4*tau*a^3*(3*U*T+d^4)+4*tau^2*a^10
a0,b0,c0,e0,u0,k0=[dd[v+'0'] for v in ['a','b','c','e','u','k']]
R0=k0*b0^5+u0*c0^2*b0^4+2*e0*c0^5
expected=[4*a0^3*(a0^2*e0+2*b0^3)*R0,4*b0^5*R0,R.zero()]
for i,D in enumerate([D0,D1,D2]):
    assert all(D[j]==0 for j in range(5)),('exact division',i)
    assert D[5]==expected[i],('endpoint identity',i)
save({'coefficient_ring':R,'endpoint_factor':R0,'constant_coefficients':expected},
     str(root/'endpoint_content_jet_identity'))
report={'status':'proved_polynomial_identity','arbitrary_jets_through':int(5),
        'coefficient_variables':int(R.ngens()),'checks':int(18),
        'seconds':time.time()-start}
(root/'endpoint_content_jet_identity.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
