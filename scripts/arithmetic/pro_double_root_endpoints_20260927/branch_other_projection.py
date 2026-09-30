"""Inspect the exact fixed-degree (2,2) branch-content projection."""
from exact import *
from branch_root import strip,weight,ud
from curve_eliminate import projection,remove_support
import rank9 as R
import json,sys,time

def run(x):
 tic=time.time();base=ROOT/'work/branch_root'/f'x_{x}';d=json.loads((base/'data.json').read_text())
 c,b,a=d['components'][0]['nu_coefficients'];f,e,dd=d['components'][1]['nu_coefficients']
 v=R.minus(R.times(a,f),R.times(c,dd));w=R.minus(R.times(a,e),R.times(b,dd));z=R.minus(R.times(b,f),R.times(c,e))
 h=R.minus(R.times(v,v),R.times(w,z));pp,powers=strip([h]);h=pp[0]
 print('ROOT',x,'2x2 fixed resultant weight',weight(h),'degree_u',ud(h),'units',powers,flush=True)
 units=pm(pm([0,1],DATA['d']),DATA['b']);p=projection(h,units)
 for key in ['content','quadratic_resultant','allowed_projection','removed_projection_factor']:print(key,len(p[key])-1,flush=True)
 print('content surviving',len(remove_support(p['content'],units)[0])-1,flush=True)
 print('h1 pivot overlap',len(pgcd(p['primitive_linear_remainder'][1],p['allowed_projection']))-1,flush=True)
 rad=pexact(p['allowed_projection'],pgcd(p['allowed_projection'],pder(p['allowed_projection'])))
 print('single derivative quotient degree',len(rad)-1,flush=True)
 p.update({'determinant':h,'determinant_unit_powers':powers,'units_used_to_remove':units,'scale_subresultants':[v,w,z]})
 (base/'projection.json').write_text(json.dumps(p,separators=(',',':'))+'\n');print('seconds',time.time()-tic,flush=True)
 return p
if __name__=='__main__':run(int(sys.argv[1]) if len(sys.argv)>1 else 14)
