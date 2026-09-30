"""The other companion sheet over Disc(f)|_{s=0}; no sheet is discarded."""
from global_checks import *

def run():
    ts=time.time();saved=json.loads((ROOT/'data/leading_tail_boundary.json').read_text())
    f=disc_sigma(0);C=I['C'];D=saved['Delta'];e=I['e'];c=I['c'];b=I['b']
    assert len(f)==25 and len(pgcd(f,deriv(f)))==1
    def m(p):return pdm(p,f)[1]
    def vi(p):
        g,u,v=pxgcd(p,f);assert g==[1];return u
    xp=m(pn(pm(saved['s_numerator_constant'],vi(C))))
    up=m(pm(pm(e,pa(c,scale(xp,3))),vi(D)))
    sp=m(pm(ps(saved['s_numerator_constant'],pm(C,xp)),vi(saved['s_denominator'])))
    assert m(ps(ppow(xp,2),C))==[]
    assert m(pa(pa(pm(D,ppow(up,2)),scale(pm(pm(c,e),up),3)),scale(ppow(e,2),2)))==[]
    assert m(pa(saved['s_numerator_constant'],pm(C,xp)))==[]
    assert len(pgcd(sp,f))==1
    licensed=pm(saved['licensed_q_pole_product'],saved['leading_boundary_product'])
    gcd,U,V=pxgcd(f,licensed);assert gcd==[1]
    out={'discriminant':f,'selected_u':up,'xi':xp,'s':sp,'degree':24,
         'factor_degrees':ddf_degrees(f),'licensed_and_previously_excluded_product':licensed,
         'coprimality_U':U,'coprimality_V':V,
         'interpretation':'other (nonzero-s) companion sheet above the s=0 cubic discriminant'}
    (ROOT/'data/norm_s_boundary.json').write_text(json.dumps(out,separators=(',',':'))+'\n')
    print(json.dumps({'degree':24,'factor_degrees':out['factor_degrees'],'all_24_ratios_allowed':True,
        'disjoint_from_144_leading_tail_boundary':True,'ratio_identities':'PASS','seconds':round(time.time()-ts,3)}))
if __name__=='__main__':run()
