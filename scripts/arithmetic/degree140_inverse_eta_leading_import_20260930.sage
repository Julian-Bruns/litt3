"""Import exact q-resultants and isolate their allowed projected support."""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
d=load(str(root/'inverse_eta_quadratic_leading_inputs.sobj'));R=d['ring'];H,q0=R.gens();K=R.base_ring();a=K.gen()
beta=-(a^4+2*a^3+a^2+2*a)/(a^3+a^2+1);cache={0:K.zero()}
def dec(n):
    n=int(n)
    if n not in cache:
        t=n;v=K.zero()
        for i in range(4):
            c=t%25;t//=25;v+=(K(c%5)+(c//5)*beta)*a^i
        cache[n]=v
    return cache[n]
P=PolynomialRing(K,'q');q=P.gen()
raw=json.loads((root/'inverse_eta_leading_resultants.json').read_text())
rs=[P([dec(c) for c in r]) for r in raw['resultants']]
gg=P([dec(c) for c in raw['gcd']]);bez=[P([dec(c) for c in r]) for r in raw['bezout']]
assert rs[0]*bez[0]+rs[1]*bez[1]==gg
chart=P(d['units'][4](0,q))*q*(q-1)*(q-dec(15383))
removed=[]
while True:
    g=gcd(gg,chart)
    if g.degree()<=0:break
    removed.append(g);gg=gg//g
print('projected gcd after original q-units',gg.degree(),'removed',sum(g.degree() for g in removed),flush=True)
fac=gg.factor();print('factor degrees/multiplicities',[(p.degree(),m) for p,m in fac],flush=True)
save(dict(d,qring=P,resultants=rs,bezout=bez,original_gcd=P([dec(c) for c in raw['gcd']]),
          projected_gcd=gg,removed_q_factors=removed,projected_factorization=fac),str(root/'inverse_eta_leading_projection'))
report={'scope':'necessary projected leading degeneration, not a scale decision',
        'q_degree':int(gg.degree()),'factors':[(int(p.degree()),int(m)) for p,m in fac],
        'seconds':time.time()-start}
(root/'inverse_eta_leading_projection.json').write_text(json.dumps(report,indent=2,default=int)+'\n')
print(report,flush=True)
