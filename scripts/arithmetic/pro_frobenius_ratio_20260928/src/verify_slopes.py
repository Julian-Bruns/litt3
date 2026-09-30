"""Replay all 26 exact slope certificates and complete geometric coverage."""
import argparse,json,time
from pathlib import Path
import ext
from ext import Element as E, EP
from ff import Poly
from residual import RATIO,peval,check_open,Tails,residual
from residual_jet import residual_jet
from factor import irreducible
from slope_boundary import make_model
from leading_slope import top_coefficients,c72_leading
ROOT=Path(__file__).resolve().parents[1]


def run_checks(signs=(1,4),full_cross_checks=True):
    start=time.time();blocks=[];mods=[]
    for sign in signs:
        name='plus' if sign==1 else 'minus'
        model=json.loads((ROOT/f'data/slope_{name}_model.json').read_text())
        regen=make_model(sign,save=False)
        assert all(model[k]==v for k,v in regen.items() if k!='elapsed_seconds')
        N=Poly(model['norm_squarefree']);old=Poly(model['old_q_units'])
        assert N.degree()==72 and N==Poly(model['norm_allowed'])
        assert N.gcd(N.derivative())==1 and N.gcd(old)==1
        assert N.gcd(Poly(model['r1']))==1
        assert Poly(model['r1_exception'])==1
        factors=[Poly(f) for f in model['factors']];product=Poly(1)
        for f in factors:
            assert irreducible(f);product=product*f
        assert product==N
        summary=[]
        for i,f in enumerate(factors):
            t=time.time()
            cert=json.loads((ROOT/f'data/slope_certificates/slope_{name}_{i}.json').read_text())
            assert cert['sign']==sign and cert['modulus']==f.tolist()
            assert cert['factor_index']==i and cert['s_cube']==model['s_cube']
            assert cert['tail_indices']==[71,72] and cert['mu_power']==0
            q=ext.context(f);u=-peval(model['r0'],q)/(peval(model['r1'],q)*peval(RATIO['b'],q))
            V=check_open(q,u);s=V/(u**3*peval(RATIO['d'],q))
            assert s**3==model['s_cube']
            aa,bb,dd=top_coefficients(q,u)
            assert bb
            if sign==1:assert not dd and aa
            else:assert not aa and dd
            _,A=residual_jet(q,u,72)
            assert A[4][3]==aa and A[8][6]==bb
            ts=Tails(A,max_n=72);lhs=EP()
            for n,cs,deg in zip(cert['tail_indices'],cert['bezout_coefficients'],cert['tail_degrees']):
                tail=ts.tail(n);assert tail.degree()==deg
                lhs=lhs+EP([E(row) for row in cs])*tail
            assert lhs==1
            full=False
            if full_cross_checks and i==len(factors)-1:
                _,fullA=residual(q,u)
                assert all(A[j]==fullA[j] for j in range(73))
                full=True
            block={'sign':sign,'factor_index':i,'degree':f.degree(),
                   'certificate':f'data/slope_certificates/slope_{name}_{i}.json',
                   'identity':'U*C71+V*C72=1','tail_degrees':cert['tail_degrees'],
                   'full_residual_cross_check':full,'elapsed_seconds':round(time.time()-t,3)}
            print('slope certificate verified',block,flush=True)
            blocks.append(block);summary.append(block)
        mods.append(N)
    if len(mods)==2:
        assert mods[0].gcd(mods[1])==1
        old_a1=Poly(json.loads((ROOT/'data/a1_reduced.json').read_text())['norm_squarefree'])
        assert all(m.gcd(old_a1)==1 for m in mods)
        assert len(blocks)==26 and sum(b['degree'] for b in blocks)==144
    out={'status':'all listed complete slope fibres excluded; global decision remains unresolved',
         'blocks':blocks,'geometric_ratios_excluded':sum(b['degree'] for b in blocks),
         'distinct_q_values':sum(m.degree() for m in mods),
         'all_scales':'arbitrary geometric scales; polynomial identity 1',
         'elapsed_seconds':round(time.time()-start,3)}
    if len(mods)==2:out['combined_totals']={'certificate_blocks':43,'ratios_excluded':374,'q_values_excluded':354}
    print('SLOPE_VERIFICATION_SUMMARY_JSON='+json.dumps(out,sort_keys=True),flush=True)
    return out

if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--sign',choices=['plus','minus']);ap.add_argument('--save-summary',action='store_true');ap.add_argument('--skip-full-cross-checks',action='store_true');args=ap.parse_args()
    signs=(1,4) if args.sign is None else (1,) if args.sign=='plus' else (4,)
    out=run_checks(signs,not args.skip_full_cross_checks)
    if args.save_summary:(ROOT/'checks/slope_verification.json').write_text(json.dumps(out,indent=2)+'\n')
