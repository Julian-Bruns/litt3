#!/usr/bin/env python3
"""Polynomial unit certificates for the reduced concentrated top model."""
import argparse,json,sys
from pathlib import Path
ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(ARCHIVE/'src'))
from exact import Field,Poly
from cubic_extension import CubicExtension
from shifted_concentrated_projection import extended_gcd


def unit_identity(p,functions):
    gcd=[];coefficients=[[] for _ in functions]
    for i,f in enumerate(functions):
        if not f:continue
        if not gcd:
            factor=p.k.inv(f[-1]);gcd=p.scale(f,factor);coefficients[i]=[factor]
        else:
            gcd,a,b=extended_gcd(p,gcd,f)
            coefficients=[p.mul(a,c) for c in coefficients]
            coefficients[i]=p.add(coefficients[i],b)
        if gcd==[1]:break
    total=[]
    for c,f in zip(coefficients,functions):total=p.add(total,p.mul(c,f))
    assert total==gcd==[1]
    return coefficients


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True)
    args=ap.parse_args();e=CubicExtension(Field(args.work/'cache'));p=Poly(e)
    data=json.loads((args.work/'data/concentrated_top_compatibility.json').read_text())
    old=data['ordinary_compatibility_coefficients'];pivot=next(i for i,c in enumerate(old) if c)
    indices=[i for i,label in enumerate(data['top_labels']) if label[0]==4 and label[2]>0]
    assert len(indices)==5
    records=[]
    for item in data['records']:
        new=item['new_compatibility_coefficients']
        reduced=[p.sub(f,p.scale(new[pivot],e.div(old[i],old[pivot]))) for i,f in enumerate(new)]
        yfunctions=[new[i] for i in indices]
        records.append({'root_K_code':item['root_K_code'],'sheet_suffix':item['sheet_suffix'],
                        'reduced_new_functions':reduced,
                        'independence_identity':unit_identity(p,reduced),
                        'v_equals_y_top_column_indices':indices,
                        'v_equals_y_functions':yfunctions,
                        'v_equals_y_nonvanishing_identity':unit_identity(p,yfunctions)})
    report={'scope':'two top forms independent on the 21-function space at every slope; new m5 form nonzero for v=cy*y at every slope',
            'ordinary_pivot':pivot,'records':records,'verified_unit_identities':18}
    (args.work/'data/concentrated_top_unit_identities.json').write_text(json.dumps(report,separators=(',',':'))+'\n')
    print(json.dumps({'endpoint_records':9,'unit_identities':18,'outcome':'PASS'}))


if __name__=='__main__':main()
