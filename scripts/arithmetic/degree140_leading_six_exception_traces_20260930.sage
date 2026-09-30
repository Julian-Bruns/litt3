"""Test actual global traces in every complete leading-six exception field.

The zero-dimensional parameter algebra has length187 and is reduced.
Univariate gcds keep every scale over the algebraic closure of each field.
This is a new special-locus calculation, not a point search.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]); started=time.time()
d=load(str(root/'reciprocal_degree6_leading_factors.sobj'))
R=d['ring']; H,q=R.gens(); K=R.base_ring()
Q=d['q_polynomial'].parent(); z=Q.gen()
hp=next(f for f in d['basis'] if f.degree(H)==1)
assert hp.monomial_coefficient(H)==1
hpoly=-Q(hp.subs({H:0}))
families={name:load(str(root/(name+'_rational_coefficients.sobj')))
          for name in ['global_multiplied','global_companion','global_positive']}
results=[]
for idx,(factor,multiplicity) in enumerate(d['q_factors']):
    assert multiplicity==1
    L=Q.quotient(factor,names='b'); b=L.gen(); hh=L(hpoly)
    T=PolynomialRing(L,'mu');mu=T.gen()
    print('start factor',idx,'degree',factor.degree(),flush=True)
    # Cache images of q-coefficient polynomials across trace coefficients.
    def evaluate(poly):
        by_h={}
        for (i,j),c in poly.dict().items():
            by_h.setdefault(int(i),{})[int(j)]=c
        value=L.zero()
        for i in range(int(poly.degree(poly.parent().gen(0))),-1,-1):
            value*=hh
            if i in by_h:value+=L(Q(by_h[i]))
        return value
    psi=evaluate(families['global_multiplied']['Psi'])
    assert hh and b and psi
    images=[]; labels=[]; gcd_poly=T.zero(); completed=False
    for name,dd in families.items():
        for j in range(3):
            value=T.zero()
            for jj,n,num,(dh,dq,dp) in dd['coefficients']:
                if jj!=j:continue
                value+=evaluate(num)/(hh^dh*b^dq*psi^dp)*mu^n
            images.append(value);labels.append((name,int(j)))
            gcd_poly=gcd_poly.gcd(value)
            while gcd_poly and gcd_poly[0]==0:gcd_poly=gcd_poly//mu
            print('factor',idx,'row',name,j,'scale gcd degree',gcd_poly.degree(),
                  'seconds',round(time.time()-started,3),flush=True)
            if gcd_poly.is_one():completed=True;break
        if completed:break
    # Retain images plus the source ratio factor and its actual H-value.
    # For two coprime rows also retain a compact Bezout identity explicitly.
    certificate={'parameter_factor':factor,'H':hpoly.mod(factor),
                 'field':L,'scale_ring':T,'labels':labels,'images':images,
                 'nonzero_scale_gcd':gcd_poly}
    if len(images)==2:
        g,u,v=images[0].xgcd(images[1]);assert u*images[0]+v*images[1]==g
        certificate['bezout']=(g,u,v)
    save(certificate,str(root/('reciprocal_degree6_exception_'+str(idx))))
    results.append({'factor_index':idx,'degree':int(factor.degree()),
                    'trace_rows':labels,'nonzero_scale_gcd_degree':int(gcd_poly.degree()),
                    'excluded':completed})
    (root/'reciprocal_degree6_exception_traces.json').write_text(json.dumps(
        {'scope':'leading-six exception stratum only','factors':results,
         'complete':len(results)==len(d['q_factors']),
         'seconds':time.time()-started},indent=2)+'\n')
print('complete',json.dumps(results),flush=True)
