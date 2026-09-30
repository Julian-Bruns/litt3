"""Lift the complete resultant projection, retaining all geometric H values."""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
d=load(str(root/'inverse_eta_leading_projection.sobj'));R=d['ring'];K=R.base_ring();Q=d['qring']
reports=[]
for idx,(factor,multiplicity) in enumerate(d['projected_factorization']):
    L=Q.quotient(factor,names='qbar'); qb=L.gen();T=PolynomialRing(L,'H');H=T.gen()
    def spec(p):
        groups={}
        for (i,j),c in p.dict().items():groups.setdefault(int(i),{})[int(j)]=c
        return T({i:L(Q(v)) for i,v in groups.items()})
    pp=[spec(p) for p in d['leading_inputs']];g=gcd(pp)
    rawg=g;removed=[]
    for unit in d['units']:
        u=spec(unit)
        if not u:
            removed.append(('whole_fibre',unit));g=T.one();break
        while g.degree()>0:
            z=gcd(g,u)
            if z.degree()<=0:break
            removed.append(z);g=g//z
    print('factor',idx,'q degree',factor.degree(),'raw H gcd',rawg.degree(),
          'allowed H gcd',g.degree(),'seconds',time.time()-start,flush=True)
    record={'factor':factor,'field':L,'Hring':T,'leading_polynomials':pp,
            'raw_gcd':rawg,'allowed_gcd':g,'removed':removed}
    save(record,str(root/('inverse_eta_leading_fibre_'+str(idx))))
    reports.append({'index':idx,'q_degree':int(factor.degree()),
                    'raw_H_degree':int(rawg.degree()),'allowed_H_degree':int(g.degree())})
    (root/'inverse_eta_leading_fibres.json').write_text(json.dumps(
        {'scope':'entire quadratic-leading degeneration, not actual scales',
         'fibres':reports,'complete':len(reports)==len(d['projected_factorization']),
         'seconds':time.time()-start},indent=2,default=int)+'\n')
print('all lifted',reports,flush=True)
