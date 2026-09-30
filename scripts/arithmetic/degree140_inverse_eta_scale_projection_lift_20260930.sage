"""Lift the complete projected support of the actual divided-scale equations.

The projected polynomial is an exact radical necessary support, not a
finite-field sample. All irreducible factors and their whole residue fields
are retained. Remove only original chart units or proved exclusions.
"""
import sys,json,time,struct
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
d=load(str(root/'inverse_eta_scale_resultants.sobj'))
R=d['ring'];K=R.base_ring();a=K.gen();Q=PolynomialRing(K,'q');q=Q.gen()
beta=-(a^4+2*a^3+a^2+2*a)/(a^3+a^2+1)
def dec(n):
    n=int(n);v=K.zero()
    for i in range(4):
        c=n%25;n//=25;v+=(K(c%5)+(c//5)*beta)*a^i
    return v
raw=(root/'inverse_eta_scale_projection_gcd_allowed_gcd.bin').read_bytes()
nn=struct.unpack_from('<i',raw)[0]
assert len(raw)==4*(nn+1)
g=Q([dec(n) for n in struct.unpack_from('<'+'i'*nn,raw,4)])
assert g.degree()==195 and gcd(g,g.derivative()).is_one()
fac=g.factor();assert prod(f^m for f,m in fac)*fac.unit()==g
print('projected factors',[(f.degree(),m) for f,m in fac],flush=True)
save(dict(d,qring=Q,projected_gcd=g,projected_factorization=fac),
     str(root/'inverse_eta_scale_projection'))
reports=[]
for idx,(factor,multiplicity) in enumerate(fac):
    L=Q.quotient(factor,names='qbar');qb=L.gen()
    T=PolynomialRing(L,'H');H=T.gen()
    def spec(p):
        groups={}
        for (i,j),c in p.dict().items():groups.setdefault(int(i),{})[int(j)]=c
        return T({i:L(Q(v)) for i,v in groups.items()})
    pp=[spec(p) for p in d['scale_resultants']]
    rawg=gcd(pp);gg=rawg;removed=[]
    for ki,unit in enumerate(d['units']):
        u=spec(unit)
        if not u:
            removed.append({'unit':ki,'whole_fibre':True});gg=T.one();break
        while gg.degree()>0:
            z=gcd(gg,u)
            if z.degree()<=0:break
            removed.append({'unit':ki,'factor':z});gg=gg//z
    print('factor',idx,'q degree',factor.degree(),'raw H gcd',rawg.degree(),
          'allowed H gcd',gg.degree(),'seconds',time.time()-start,flush=True)
    record={'factor':factor,'field':L,'Hring':T,'resultant_polynomials':pp,
            'raw_gcd':rawg,'allowed_gcd':gg,'removed':removed}
    save(record,str(root/('inverse_eta_scale_projection_fibre_'+str(idx))))
    reports.append({'index':idx,'q_degree':int(factor.degree()),
                    'raw_H_degree':int(rawg.degree()),'allowed_H_degree':int(gg.degree())})
    (root/'inverse_eta_scale_projection_lift.json').write_text(json.dumps(
        {'scope':'entire necessary projected support, before simultaneous scale lifting',
         'projected_degree':int(g.degree()),
         'factors':[(int(f.degree()),int(m)) for f,m in fac],
         'fibres':reports,'complete':len(reports)==len(fac),
         'seconds':time.time()-start},indent=2,default=int)+'\n')
print('all lifted',reports,flush=True)
