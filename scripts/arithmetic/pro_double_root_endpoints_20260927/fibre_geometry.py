"""Verify complete, disjoint geometric coverage of the new F25* projection divisor."""
from exact import *
import json
from fibres_u import fibre_modulus

def run(verify=False):
    fac=json.loads((ROOT/'evidence/ratio_factorizations.json').read_text())
    old=[1]
    for name in ['b','e','leading_boundary','zero_F_projection']:old=pm(old,fac[name]['polynomial'])
    records=[]
    for u0 in range(1,25):
        original,mod,removed=fibre_modulus(u0)
        assert power(u0,25)==u0 and mod==original and not removed
        xi=pa(pc(DATA['b'],u0),DATA['c'])
        F=pa(pa(pc(DATA['a0'],power(u0,3)),pc(DATA['b'],power(u0,2))),pa(pc(DATA['c'],u0),DATA['e']))
        opens={'q':[0,1],'d':DATA['d'],'ordinary':xi,'F':F}
        for q0 in DATA['excluded_q']:opens[f'q_minus_{q0}']=[neg(q0),1]
        tests={'fibre_separability':pder(mod),'old_projection_divisor':old,**opens}
        witnesses={}
        for name,poly in tests.items():
            g,s,t=pxgcd(mod,poly);assert g==[1]
            assert pa(pm(s,mod),pm(t,poly))==[1]
            witnesses[name]={'polynomial':poly,'bezout_modulus':s,'bezout_polynomial':t}
        C=json.loads((ROOT/'evidence'/f'fibre_u_{u0}.json').read_text())
        assert C['status']=='excluded_all_geometric_scales' and C['geometric_ratio_count']==9 and C['algebra_length']==9
        assert C['modulus_on_original_open']==mod
        records.append({'u_code':u0,'modulus':mod,'witnesses':witnesses})
    out={'projection_divisor':'u^24-1','all_geometric_u_values':'F25*',
         'fibres':24,'geometric_ratios_per_fibre':9,'geometric_ratio_count':216,
         'all_original_open_factors_are_units':True,'all_fibres_squarefree':True,
         'disjoint_from_archived_65_ratios':True,'total_distinct_excluded_ratios':281,'records':records}
    p=ROOT/'evidence/fibre_geometry.json'
    if verify:assert out==json.loads(p.read_text())
    else:p.write_text(json.dumps(out,separators=(',',':'))+'\n')
    print('All 216 ratios over u^24-1=0 lie on the original ordinary open. All fibre algebras are squarefree; none overlaps the old 65 ratios.',flush=True)
    return out

if __name__=='__main__':
    import sys
    run('--verify' in sys.argv)
