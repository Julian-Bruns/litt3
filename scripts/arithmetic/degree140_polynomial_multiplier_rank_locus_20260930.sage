"""Resume only the locus calculation from the completed unit-pivot block."""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
prefix=sys.argv[2] if len(sys.argv)>2 else 'polynomial_multiplier_rank'
data=load(str(root/(prefix+'_inputs.sobj')))
R=data['ring'];equations=data['equations'];chart=data['chart']
report={'scope':'rank degeneration only, not actual covers',
        'pivot_positions':[[int(r),int(c)] for r,c in data['pivots']],
        'pivot_units_verified_in_construction':True,
        'equation_degrees':[list(map(int,e.degrees())) for e in equations],
        'equation_terms':[len(e.dict()) for e in equations]}
(root/(prefix+'_inputs.json')).write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
print('collective gcd',gcd(equations),flush=True)
I=R.ideal(equations).saturation(R.ideal(chart))[0]
gb=list(I.groebner_basis())
save({'ring':R,'basis':gb,'inputs':equations},str(root/(prefix+'_locus')))
report['unit_ideal']=bool(R.one() in I)
report['basis_degrees']=[list(map(int,f.degrees())) for f in gb]
if not report['unit_ideal']:
    report['dimension']=int(I.dimension())
    if I.dimension()==0:report['length']=int(I.vector_space_dimension())
report['seconds']=time.time()-start
(root/(prefix+'_locus.json')).write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
