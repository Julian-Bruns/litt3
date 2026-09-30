"""Inspect one leading-coefficient ideal of exact trace combinations.

ROOT PARENT_STEM DEGREE OUTPUT_STEM [LAST_COMPLETE_ROW]
The optional row bound permits using a completed prefix checkpoint. A
unit certificate from a subset is valid; a nonunit answer is not a claim
about omitted rows. No full trace-locus decision follows from this test.
"""
import sys, json, time
from pathlib import Path

root=Path(sys.argv[1]); parent=sys.argv[2]; degree=int(sys.argv[3]); stem=sys.argv[4]
limit=int(sys.argv[5]) if len(sys.argv)>5 else None
start=time.time(); data=load(str(root/(parent+'.sobj')))
R=data['ring']; H,q=R.gens(); Psi=data['Psi']
if 'complete_through_row' in data:
    completed=int(data['complete_through_row'])
    limit=completed if limit is None else min(limit,completed)
inputs=[]; units=[]; common=R.zero()
for i,row in enumerate(data['rows']):
    if limit is not None and i>limit: continue
    if max(row['coeff'],default=-1)!=degree: continue
    N,D=row['coeff'][degree]; factor=R.one()
    for unit in (H,q,Psi):
        while N:
            Q,remainder=N.quo_rem(unit)
            if remainder: break
            N=Q; factor*=unit
    scalar=N.leading_coefficient(); N/=scalar; factor*=scalar
    inputs.append((i,N)); units.append((i,factor,D))
    common=common.gcd(N)
    print('row',i,'terms',len(N.dict()),'degrees',N.degree(H),N.degree(q),
          'common degree',common.degree(),'seconds',round(time.time()-start,2),flush=True)
save({'ring':R,'Psi':Psi,'rows':inputs,'removed_units':units,'parent':parent,
      'degree':degree,'last_complete_row':limit},str(root/(stem+'_inputs')))
print('starting leading coefficient basis',flush=True)
I=R.ideal([p for i,p in inputs]); G=list(I.groebner_basis())
save({'ring':R,'Psi':Psi,'inputs':inputs,'removed_units':units,'ideal_basis':G,
      'parent':parent,'degree':degree,'last_complete_row':limit},str(root/(stem+'_basis')))
print('basis',len(G),[(p.degree(),len(p.dict())) for p in G],
      'seconds',round(time.time()-start,2),flush=True)
sat=I.saturation(R.ideal(H*q*Psi))[0]; SG=list(sat.groebner_basis())
save({'ring':R,'basis':SG,'parent':parent},str(root/(stem+'_saturated')))
report={'scope':'leading coefficient ideal only; no full-locus decision',
        'parent':parent,'degree':degree,'rows':[i for i,p in inputs],
        'last_complete_row':limit,'localized_unit_ideal':bool(R.one() in sat),
        'basis_degrees':[int(p.degree()) for p in G],
        'saturated_basis_degrees':[int(p.degree()) for p in SG],
        'seconds':time.time()-start}
(root/(stem+'.json')).write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
