"""Inspect unused ORIGINAL ratio units in a large leading system.

This does not discard any new parameter fibre. It records exact factors
and characteristic-five support before deciding whether a new basis
calculation is worthwhile.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
d=load(str(root/'trace_exact_degree9_leading_inputs.sobj'))
R=d['ring'];H,q=R.gens();a=R.base_ring().gen()
beta=-(a^4+2*a^3+a^2+2*a)/(a^3+a^2+1)
def dec(n):
    value=R.base_ring().zero()
    for i in range(4):
        c=n%25;n//=25;value+=(R.base_ring()(c%5)+(c//5)*beta)*a^i
    return value
a0=sum(dec(c)*q^i for i,c in enumerate([89654,311173,214299,163299,315361,33043,356725,245794]))
units=[a0,q-1,q-dec(15383)]
rows=[];report=[]
for i,poly in d['rows']:
    original=poly;removed=[]
    for u in units:
        exponent=0
        while True:
            quotient,remainder=poly.quo_rem(u)
            if remainder:break
            poly=quotient;exponent+=1
        removed.append(int(exponent))
    rows.append((i,poly))
    item={'row':int(i),'removed_a0_q1_qalpha':removed,
          'old_terms':len(original.dict()),'new_terms':len(poly.dict()),
          'degrees':list(map(int,poly.degrees())),
          'H_mod5':sorted({int(e[0]%5) for e in poly.exponents()}),
          'q_mod5':sorted({int(e[1]%5) for e in poly.exponents()})}
    report.append(item);print(json.dumps(item),flush=True)
save({'ring':R,'rows':rows,'units':units,'report':report},str(root/'trace_exact_degree9_all_chart_inputs'))
(root/'trace_exact_degree9_all_chart_inputs.json').write_text(json.dumps(
    {'rows':report,'seconds':time.time()-start},indent=2)+'\n')
