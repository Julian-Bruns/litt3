#!/usr/bin/env python3
"""Produce five exact linear/quadratic certificates, not a profile search.

The five cases represent the five Frobenius orbits of the *single* remaining
phase in the complementary-double-label endpoint sector. There is no endpoint
multiset enumeration, pole-profile enumeration, or enumeration of field elements.
"""
from pathlib import Path
import argparse, json
import structural_field as F
import moment_linearization as M

def generate():
    out={'scope':'Complementary double labels only; necessary moment equations, not curves.',
         'phase_representatives':[0,1,2,28,27],
         'normalization':'Q=(b0,b0,b2,b2); H=(b1*zeta^g,b1*zeta^g,b3*zeta^g,b3*zeta^g)',
         'phase_orbits':[], 'cases':[], 'decoded_points':[]}
    seen=set()
    for g in out['phase_representatives']:
        orbit=sorted({g*pow(25,k,29)%29 for k in range(7)})
        assert not seen.intersection(orbit);seen.update(orbit);out['phase_orbits'].append(orbit)
        cert=M.analyze([0,0,58,58],[29+g,29+g,87+g,87+g])
        cert['phase_representative']=g
        assert cert['rank']==3
        out['cases'].append(cert)
        for index,p in enumerate(cert.get('tested_isolated_points',[])):
            assert p['valid_nonzero_scale'] and p['scale_unique']
            dec=[F.decode_moments(p['x_M2'],p['y_M6'],r) for r in range(5)]
            out['decoded_points'].append({'phase_representative':g,'point_index':index,
                 'point':p,'decodings_by_mass_residue':dec,
                 'minimum_mass':min(v['least_positive_mass'] for v in dec)})
    assert seen==set(range(29))
    assert len(out['decoded_points'])==6
    out['minimum_sector_mass']=min(p['minimum_mass'] for p in out['decoded_points'])
    assert out['minimum_sector_mass']==37
    witness=out['decoded_points'][0]
    assert witness['phase_representative']==1
    p=witness['point'];d=F.decode_moments(p['x_M2'],p['y_M6'],37)
    assert d['allowed_weight_lift_exists'] and d['least_positive_mass']==37
    assert not p['epsilon_in_K14']
    out['moment_only_degree49']={
        'degree':49,'mass':37,'Q':[0,0,58,58],'H':[30,30,88,88],
        'x_M2':p['x_M2'],'y_M6':p['y_M6'],'epsilon':p['epsilon'],
        'weights':d['residue_weights'],'is_actual_curve':False,
        'warning':'No S, ramification, nonlinear endpoint identities, or etale cover is constructed.'}
    return json.loads(json.dumps(out))

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path,required=True)
    ap.add_argument('--reference',type=Path)
    ar=ap.parse_args();out=generate()
    if ar.reference:assert out==json.loads(ar.reference.read_text())
    ar.output.write_text(json.dumps(out,indent=2)+'\n')
    print('PASS: five linear systems, five quadratics, six moment points, 30 inverse Fourier transforms')
    print('Minimum complementary-double-label sector mass: 37 (degree 49); no actual curve asserted')
    if ar.reference:print('PASS: regenerated evidence matches reference exactly')
if __name__=='__main__':main()
