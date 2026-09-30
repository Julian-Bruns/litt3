"""Retain, then certify separately, the opposite sheets over the six F_sigma."""
from global_checks import *

def run():
    start=time.time();data=json.loads((ROOT/'data/leading_tail_boundary.json').read_text());rows=[]
    for row in data['fibres']:
        f=row['discriminant']
        def md(p):return pdm(p,f)[1]
        def vi(p):
            g,u,v=pxgcd(p,f);assert g==[1];return u
        xp=md(pn(row['xi_mod_discriminant']))
        up=md(pm(pm(I['e'],pa(I['c'],scale(xp,3))),vi(data['Delta'])))
        sp=md(pm(ps(data['s_numerator_constant'],pm(I['C'],xp)),vi(data['s_denominator'])))
        assert md(ps(ppow(xp,2),I['C']))==[]
        assert md(pa(pa(pm(data['Delta'],ppow(up,2)),scale(pm(pm(I['c'],I['e']),up),3)),scale(ppow(I['e'],2),2)))==[]
        assert len(pgcd(sp,f))==1
        lead_factor=md(ps(ppow(sp,6),[power(data['sigma0'],6)]))
        g,U,V=pxgcd(lead_factor,f);assert g==[1]
        assert md(ps(sp,[row['sigma']]))!=[]
        rows.append({'opposite_of_sigma':row['sigma'],'discriminant':f,'selected_u':up,'xi':xp,'s':sp,
            'leading_boundary_factor':lead_factor,'leading_factor_inverse':U,'leading_factor_bezout_V':V})
    (ROOT/'data/opposite_boundary.json').write_text(json.dumps({'fibres':rows},separators=(',',':'))+'\n')
    print(json.dumps({'opposite_ratios':144,'all_original_units':'retained','C72_leading_coefficient_unit':'PASS',
        'opposite_companion_coordinates':'PASS','seconds':round(time.time()-start,3)}))
if __name__=='__main__':run()
