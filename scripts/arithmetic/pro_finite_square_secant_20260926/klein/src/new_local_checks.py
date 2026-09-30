#!/usr/bin/env python3
"""Exhaust all 100 P-root pairs for the refined local spectrum and second jet."""
import argparse
import json
import sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'prior/src'))
import local_spectrum as F

def compute():
    old=json.loads((ROOT/'prior/evidence/local_spectrum.json').read_text())
    # Independently certify the field and that every geometric root is included.
    H=F.H
    assert H==old['extension_modulus_over_F25']
    assert F.pgcd(H,F.psub(F.ppow([0,1],25**2,H),[0,1]))==[1]
    assert not F.pmod(F.psub(F.ppow([0,1],25**4,H),[0,1]),H)
    roots=old['roots_of_P_in_extension']
    prod=[1]
    for x in roots: prod=F.epm(prod,[F.en(x),1])
    assert len(set(roots))==10 and prod==F.P
    P,A=F.P,F.A
    Ad,Add=F.pder(A),F.pder(F.pder(A))
    Pd,Pdd=F.pder(P),F.pder(F.pder(P))
    aval=[]; jval=[]; kval=[]
    for x in roots:
        A0,A1,A2=(F.evale(poly,x) for poly in (A,Ad,Add))
        P1,P2=(F.evale(poly,x) for poly in (Pd,Pdd))
        assert A0 and A1 and P1
        a=F.em(A1,F.ep(A0,-1))
        da=F.es(F.em(A2,F.ep(A0,-1)),F.em(a,a))
        b=F.em(P2,F.ep(F.em(2,P1),-1))
        J=F.em(F.ea(da,F.em(a,b)),F.ep(a,-2))
        K=F.em(F.em(F.ep(P1,26),F.ep(A1,13)),F.ep(A0,-61))
        aval.append(a); jval.append(J); kval.append(K)
    assert kval==old['K_values'] and len(set(jval))==10
    sigma=old['spectrum_polynomial_ascending_F25']
    reduced=F.pexact(sigma,[4,1]) # Z-1 over F25
    assert len(reduced)==91 and F.peval(reduced,1)!=0
    assert F.pgcd(reduced,F.pder(reduced))==[1]
    pair_rows=[]; ratios=set()
    for ia,alpha in enumerate(roots):
        for ib,beta in enumerate(roots):
            ratio=F.em(kval[ib],F.ep(kval[ia],-1))
            # t(s)/t(0) = 1 + second*s^2+..., at a branch-incidence point.
            second=F.em(F.em(F.ep(aval[ia],2),F.ep((2*13)%5,-1)),F.es(jval[ia],jval[ib]))
            assert bool(second)==(ia!=ib)
            if ia!=ib:
                ratios.add(ratio)
                assert F.evale(reduced,ratio)==0
            pair_rows.append({'alpha_index':ia,'beta_index':ib,
                              'epsilon29':ratio,'t_second_coefficient_over_t0':second,
                              'diagonal_incidence_excluded':ia==ib})
    assert len(ratios)==90 and 1 not in ratios
    generated=[1]
    for ratio in sorted(ratios): generated=F.epm(generated,[F.en(ratio),1])
    assert generated==reduced
    out={
        'scope':'Complete finite local spectrum and second jet; NOT global compatibility or a cover search.',
        'extension_modulus_over_F25':H,'extension_encoding':old['extension_encoding'],
        'roots_of_P_in_extension':roots,'J_values':jval,
        'distinct_J_values':len(set(jval)),
        'refined_spectrum_polynomial_ascending_F25':reduced,
        'refined_spectrum_degree':90,'nonempty_incidence_epsilon_candidates_count':2610,
        'ordered_pairs':pair_rows,
        'warning':'Nonzero second jets do not assert full formal or global existence.'}
    print('PASS: extension irreducibility; ten roots multiply to the entire P.')
    print('PASS: all 100 ordered pairs; J values distinct:',len(set(jval)))
    print('J values:',jval)
    print('PASS: Sigma/(Z-1) squarefree of degree 90, nonzero at Z=1 and Z=0.')
    assert reduced[0]
    print('Nonempty-incidence epsilon candidates: 2610, not a global epsilon bound.')
    print('Off-diagonal second jets nonzero: 90; diagonal t-ramification excluded: 10.')
    return out

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path); ap.add_argument('--check',type=Path)
    args=ap.parse_args(); out=compute()
    if args.output: args.output.write_text(json.dumps(out,indent=2,sort_keys=True)+'\n')
    if args.check:
        assert out==json.loads(args.check.read_text()),'Stored result differs.'
        print('PASS: stored refined spectrum matches exact regeneration.')
if __name__=='__main__': main()
