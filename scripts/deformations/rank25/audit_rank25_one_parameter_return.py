"""Independent finite audit of the completed scalar and preparation of root tests.

The geometric support/carry audit is separate. No fifth point is inferred
from a zero of this single scalar.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import argparse
import hashlib
import json
from pathlib import Path
import zipfile

from scripts.deformations.rank25 import rank25_one_parameter_algebra as f
from scripts.deformations.rank25 import rank25_pro_data_model as model

Z, O = f.ZERO, f.ONE
neg = lambda a: tuple(-x % 5 for x in a)
code = lambda a: sum(x*5**i for i,x in enumerate(a))


def trim(a):
    a=list(a)
    while a and a[-1]==Z:a.pop()
    return a


def plus(a,b):
    return trim([f.add(a[i] if i<len(a) else Z,b[i] if i<len(b) else Z)
                 for i in range(max(len(a),len(b)))])


def times(a,b):
    c=[Z]*max(0,len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b):c[i+j]=f.add(c[i+j],f.mul(x,y))
    return trim(c)


def divide(a,b):
    a=trim(a); b=trim(b); assert b
    q=[Z]*max(0,len(a)-len(b)+1)
    bi=f.power(b[-1],-1)
    while len(a)>=len(b):
        n=len(a)-len(b); c=f.mul(a[-1],bi); q[n]=c
        a=plus(a,[Z]*n+[neg(f.mul(c,x)) for x in b])
    return trim(q),a


def ppow(a,n,mod):
    b=[O]
    while n:
        if n&1:b=divide(times(b,a),mod)[1]
        n//=2
        if n:a=divide(times(a,a),mod)[1]
    return b


def gcd(a,b):
    while b:a,b=b,divide(a,b)[1]
    return [f.mul(x,f.power(a[-1],-1)) for x in a]


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('directory',type=Path)
    args=p.parse_args(); data=args.directory.resolve()
    root=Path(__file__).resolve().parents[3]
    complete=data/'RANK25_ONE_PARAMETER_COMPLETED'
    partial=data/'RANK25_ONE_PARAMETER_PARTIAL'
    counts={}
    for package in [complete,partial]:
        manifest=json.loads((package/'MANIFEST_SHA256.json').read_text())
        for name,h in manifest.items():
            assert hashlib.sha256((package/name).read_bytes()).hexdigest()==h,(package,name)
        counts[package.name]=len(manifest)
    with zipfile.ZipFile(root/'Research/pro_inputs/rank25_one_parameter_inputs.zip') as z:
        for name in z.namelist():
            assert z.read(name)==(complete/'inputs'/name).read_bytes()
            assert z.read(name)==(partial/'inputs'/name).read_bytes()
    a=json.loads((complete/'generated/completed_coefficients_1000_v0.json').read_text())
    b=json.loads((complete/'generated/completed_coefficients_1400_v0.json').read_text())
    c=json.loads((complete/'generated/completed_coefficients_1200_v1.json').read_text())
    for key in ['beta','gamma','first_repairs','fourth_repairs','coefficients','base_SU_polynomials','fourth_reference_adjustments']:
        assert a[key]==b[key],key
    assert a['coefficients']==b['coefficients']==c['coefficients']
    d=f.load(complete/'inputs'); omega=d['dual_row']
    for receipt in [a,b,c]:
        for key in ['beta','gamma']:
            obj=receipt[key]
            terms=[[f.digits(v) for v in row['normal']] for row in obj['terms'].values()]
            assert [f.total(row) for row in zip(*terms)]==[f.digits(v) for v in obj['normal']]
            for row in obj['terms'].values():
                assert f.total(f.mul(x,f.digits(y)) for x,y in zip(omega,row['normal']))==f.digits(row['projection'])
            assert f.total(f.digits(v['projection']) for v in obj['terms'].values())==f.digits(obj['value'])
    co={int(e):f.digits(v) for e,v in b['coefficients'].items()}
    assert co=={-75:(1,0,0,3),-25:Z,5:(1,1,0,1),25:(3,3,2,2),75:(2,1,4,4)}
    assert f.total(co.values())==(2,0,1,0)
    for precision in [500,700]:
        ex=json.loads((complete/f'generated/extreme_certificate_precision_{precision}.json').read_text())
        old=json.loads((partial/f'generated/extreme_certificate_precision_{precision}.json').read_text())
        assert ex['variants']==old['variants']
        for variant in ex['variants'].values():
            for e in [-75,75]:assert f.digits(variant['graph_sectors'][str(e)]['projected_total'])==co[e]
    cert=json.loads((complete/'generated/zero_certificate.json').read_text())
    G=[f.digits(v) for v in cert['reduced_zero_polynomial']]
    assert {5*i:f.power(v,5) for i,v in enumerate(G) if v!=Z}=={e+75:v for e,v in co.items() if v!=Z}
    derivative=trim([f.mul((i%5,0,0,0),G[i]) for i in range(1,len(G))])
    assert [i for i,v in enumerate(derivative) if v!=Z]==[15]
    assert gcd(G,derivative)==[O] and G[0]!=Z
    factors=[[f.digits(v) for v in row] for row in cert['monic_irreducible_factors_over_F625']]
    prod=[O]
    for factor in factors:
        prod=times(prod,factor); n=len(factor)-1
        assert ppow([Z,O],625**n,factor)==divide([Z,O],factor)[1]
        for r in [2,3,5,7]:
            if n%r==0:assert gcd(plus(ppow([Z,O],625**(n//r),factor),[Z,neg(O)]),factor)==[O]
    assert prod==[f.mul(v,f.power(G[-1],-1)) for v in G]
    assert sorted(len(v)-1 for v in factors)==[1,1,2,2,8,8,8]
    primary,fourth,_=model.load(Path('/Users/julian/Documents/litt3-computation-data/rank25-two-family-returns-20260912-rpDDk0/second/rank25_family_partial_audit'))
    root_value=(3,2,2,2); points=[]
    for label,lam in [('plus',root_value),('minus',neg(root_value))]:
        assert f.total(f.mul(v,f.power(lam,e)) for e,v in co.items())==Z
        q=f.power(lam,5)
        x=[f.add((2,1,3,0),f.power(q,-2)),f.mul((4,3,3,1),q),f.mul((2,2,3,4),q),
           (3,0,0,3),(0,3,1,4),f.mul((3,1,1,2),q),q,Z,Z]
        assert model.evaluate_fourth(x,fourth)==[Z]*9
        folder=data/f'root_{label}'; folder.mkdir(exist_ok=True)
        (folder/'parameters.json').write_text(json.dumps({'x':x,'lambda':lam,'q':q},indent=2)+'\n')
        points.append({'label':label,'lambda':lam,'q':q,'x':x,'parameter_file':str(folder/'parameters.json')})
    result={'status':'PASS finite audit; geometric coefficient audit and replays separate',
            'manifest_entries':counts,'all_original_input_bytes_unchanged':True,
            'same_gauge_all_normal_and_repair_records_identical':True,'changed_gauge_same_coefficients':True,
            'partial_extremes_preserved':True,'L_coefficients':co,'G':G,'factor_degrees':[len(v)-1 for v in factors],
            'factor_product_and_Rabin_checks':'PASS independent field arithmetic',
            'distinct_roots':30,'multiplicity_in_L':5,'root_point_tests':points,
            'scope':'No W5 lift or whole family height follows from this scalar.'}
    replay=data/'completed_replay'
    checked=[]; additions={}
    for name in ['completed_coefficients_1000_v0.json','completed_coefficients_1400_v0.json',
                 'completed_coefficients_1200_v1.json','extreme_certificate_precision_500.json',
                 'extreme_certificate_precision_700.json','full_precision_auxiliary_checks.json',
                 'zero_certificate.json']:
        original=json.loads((complete/'generated'/name).read_text())
        fresh=json.loads((replay/'generated'/name).read_text())
        def without_elapsed(v):
            if isinstance(v,dict):return {k:without_elapsed(x) for k,x in v.items() if k not in ['elapsed_seconds','seconds']}
            if isinstance(v,list):return list(map(without_elapsed,v))
            return v
        extra=set(fresh)-set(original)
        assert not(set(original)-set(fresh))
        if extra:
            assert name=='completed_coefficients_1200_v1.json' and extra=={'P_prev_mod25'},(name,extra)
            assert {e:v['AS_degree'] for e,v in fresh['P_prev_mod25']['sectors'].items()}=={'-50':0,'0':2,'25':3}
            additions[name]=sorted(extra)
        assert without_elapsed(original)==without_elapsed({k:fresh[k] for k in original}),('fresh replay',name)
        checked.append(name)
    result['fresh_full_source_replay']={'status':'PASS','directory':str(replay),
                                      'all_retained_mathematical_records_match':checked,
                                      'new_final_source_diagnostic_fields':additions}
    pointfile=data/'root_plus/fifth_regular_constant_4200_0.json'
    if pointfile.exists():
        r=json.loads(pointfile.read_text());x=list(map(tuple,points[0]['x']));c=list(map(tuple,r['E5']))
        assert r['E5']==r['riccati_E5']
        assert r['rho5_certified_laurent_precision']>=20
        J=model.jacobian_fourth([f.power(v,5) for v in x],fourth)
        sk=[[J[i][j] for j in (7,8)] for i in (7,8)]
        det=f.add(f.mul(sk[0][0],sk[1][1]),neg(f.mul(sk[0][1],sk[1][0])))
        aa=f.mul(f.power(det,-1),f.add(f.mul(sk[1][1],c[7]),neg(f.mul(sk[0][1],c[8]))))
        bb=f.mul(f.power(det,-1),f.add(f.mul(sk[0][0],c[8]),neg(f.mul(sk[1][0],c[7]))))
        res=[f.add(c[i],neg(f.add(f.mul(J[i][7],aa),f.mul(J[i][8],bb)))) for i in range(9)]
        quotient=[res[0],f.add(res[4],neg(f.mul((2,0,0,0),res[3]))),res[5],res[6]]
        assert quotient==[Z,Z,(0,4,2,2),(3,0,4,4)]
        assert model.rank(J)==5 and model.rank([row+[v] for row,v in zip(J,c)])==6
        co5=list(map(tuple,r['rho5_coordinates']))
        assert f.mv(primary['obstruction_dual_rows'],co5)==c
        assert f.total(f.mul(v,w) for v,w in zip(d['dual_row'],co5))==Z
        w4=json.loads((data/'root_plus/reconstructed_w4_direct_diagnostic.json').read_text())
        assert not any(any(v) for v in w4['rho4fixed'])
        result['root_point_replay']={'status':'PASS; no fifth lift at positive root, hence also its marked-involution negative',
                                    'receipt':str(pointfile),'lambda':root_value,'E5':c,'quotient':quotient,
                                    'rho5_certified_laurent_precision':r['rho5_certified_laurent_precision'],
                                    'rank_J':5,'rank_augmented':6,'regular_Riccati_agreement':True,
                                    'two_base_field_roots_excluded':True}
    (root/'Research/computations/rank25_one_parameter_return_checks.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result,indent=2))


if __name__=='__main__':main()
