#!/usr/bin/env sage-python
"""Completion audit of one fixed bad-double Heisenberg census.

Reuses the audited geometric and central-Frobenius constructions. Checks
every artifact edge and actual local cover, reconstructs all complete
Hodge ranks with actual group elements and PARI dense finite-field rank.
Does not regenerate every Laurent Hodge column.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
import argparse
from collections import Counter, defaultdict
from hashlib import sha256
from itertools import product
from math import comb
from pathlib import Path
import json
import time

from sage.all import GF, PolynomialRing, matrix, vector
from scripts.deformations.audit_actual_heisenberg_defect import IndependentBase


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--case',type=int,choices=(0,2),required=True)
    ap.add_argument('--output',required=True)
    args=ap.parse_args()
    start=time.monotonic()
    root=Path(__file__).resolve().parents[2]
    data=root/'Research/computations'
    folder=root.parent/'litt3-computation-data/heisenberg125-census-20260911'/('case%d'%args.case)
    result={'status':'running','case':args.case,'inputs':{},'rows':[]}
    def read(path):
        blob=path.read_bytes()
        digest=sha256(blob).hexdigest()
        result['inputs'][str(path.resolve())]=digest
        return json.loads(blob),digest
    def save(stage):
        result['seconds']=time.monotonic()-start
        Path(args.output).write_text(json.dumps(result,indent=2)+'\n')
        print(json.dumps({'stage':stage,'case':args.case,'rows':len(result['rows']),
                          'seconds':result['seconds']}),flush=True)

    summary,summary_hash=read(folder/'summary.json')
    assert summary['status']=='PASS' and not summary['failures']
    assert summary['case']==args.case
    orbit_path=data/('heisenberg125_frobenius_case%d.json'%args.case)
    assert Path(summary['orbit_file']).resolve()==orbit_path.resolve()
    orbits,orbit_hash=read(orbit_path)
    assert orbit_hash==summary['orbit_sha256']
    previous,_=read(data/'heisenberg_frobenius_independent_audit_20260911.json')
    assert previous['status']=='PASS'
    assert previous['inputs'][str(orbit_path)]==orbit_hash
    count=51 if args.case==0 else 42
    assert summary['total_orbits']==orbits['orbit_count']==count
    assert orbits['case']==args.case and orbits['cover_count']==155
    assert len(summary['results'])==len(orbits['orbits'])==count
    assert sorted(row['orbit'] for row in summary['results'])==list(range(count))
    labels=[tuple(pair) for orbit in orbits['orbits'] for pair in orbit]
    assert len(labels)==len(set(labels))==155
    assert set(labels)==set(product(range(31),range(5)))
    # The transport table must induce exactly the saved full-cover cycles.
    permutation={tuple(w['source']):tuple(w['target']) for w in orbits['witnesses']}
    assert set(permutation)==set(labels)==set(permutation.values())
    for cycle in orbits['orbits']:
        for i,pair in enumerate(cycle):
            assert permutation[tuple(pair)]==tuple(cycle[(i+1)%len(cycle)])
    assert [len(orbit) for orbit in orbits['orbits']]==orbits['orbit_lengths']

    source,source_hash=read(data/'backup_bad_double_cyclic_directions.json')
    raw,raw_hash=read(data/('backup_bad_double_jet_%d.json'%args.case))
    assert orbits['source_sha256']==source_hash
    assert previous['inputs'][str(data/'backup_bad_double_cyclic_directions.json')]==source_hash
    assert previous['inputs'][str(data/('backup_bad_double_jet_%d.json'%args.case))]==raw_hash
    code_hashes={
        'scripts/deformations/backup_heisenberg_defect.py':'ae3166a720728fe3284a7e04f3d3fb5b289136f69e41e78cb5b3ed8d8909aa4b',
        'scripts/deformations/rank_heisenberg_free_columns.py':'49159a5118253de168ccb0e4bc01a54951c9c332ce020079efd4b4f8c5d86120',
        'scripts/deformations/run_heisenberg_census.py':'6a0fce67b11cad9b6bfdd5a1adff2364b1f0dce09364ba70acb563efaabdc791',
        'scripts/deformations/audit_actual_heisenberg_defect.py':'9659239f82751aa96391417c648ad8d99ff656fe60831dbfe91fa725277d6d6b'}
    for name,expected in code_hashes.items():
        actual=sha256((root/name).read_bytes()).hexdigest()
        assert actual==expected
        result['inputs'][str(root/name)]=actual
    case=source['cases'][args.case]
    assert (raw['case_id'],raw['source_index'],raw['twist_index'],raw['kind'])==(
        args.case,case['source'],case['target'],case['kind'])
    p=GF(5)
    P=PolynomialRing(p,'t')
    k=GF(5**12,name='b',modulus=P(source['coefficient_field_modulus']))
    decode=lambda co:k(list(co))
    alpha=decode(source['alpha_embedding'])
    assert alpha**3+alpha+1==0
    base=IndependentBase(k,alpha,raw)
    B=base.B
    fixed=matrix(k,[[decode(co) for co in row] for row in case['as_basis']],
                 implementation='generic').transpose()
    assert fixed.is_invertible()
    def cocycle(v):
        co=fixed*vector(k,v)
        return sum((base.mono(*key)*a for key,a in zip(base.obasis,co)),B(0))
    plane_data=[]
    actual_base_planes=[]
    for number,plane in enumerate(case['planes']):
        v1,v2=[vector(p,v) for v in plane['coefficient_basis']]
        complement=next(vector(p,[int(i==j) for i in range(3)]) for j in range(3)
                        if matrix(p,[v1,v2,[int(i==j) for i in range(3)]]).rank()==3)
        chi1,chi2,chi3=[cocycle(v) for v in (v1,v2,complement)]
        local=[base.split(chi**5-chi,False) for chi in (chi1,chi2)]
        assert all(not any(co) for co,uu,oo in local)
        f1,f2=[row[1] for row in local]
        g1,g2=[-row[2] for row in local]
        cross=-chi1**5*f2+g1*chi2
        assert not any(base.split(cross,False)[0])
        is_base=all(not (fixed*v)[2] for v in (v1,v2))
        assert is_base==plane['pulled_back_from_B']
        if is_base:actual_base_planes.append(number)
        plane_data.append((chi1,chi2,chi3,f1,f2,g1,g2,cross,complement))
    assert actual_base_planes==[0]
    result['original_base_plane']=0
    result['fixed_pair']={'kind':case['kind'],'source_index':case['source'],
                          'twist_index':case['target'],'parameter_modulus':[1,1,0,1],
                          'R':raw['R'],'A':raw['A']}

    order=sorted(product(range(5),repeat=3),key=lambda a:(sum(a)+a[2],a))
    position={key:i for i,key in enumerate(order)}
    operators=[]
    for axis in (0,2):
        cols=[]
        for key in order:
            for j in range(6):
                out={}
                for d in range(key[axis]+1):
                    lower=list(key);lower[axis]=d
                    out[6*position[tuple(lower)]+j]=k(comb(key[axis],d))
                cols.append(out)
        operators.append(cols)
    g,c=operators
    def act(operator,v):
        out=defaultdict(lambda:k(0))
        for j,a in v.items():
            for i,b in operator[j].items():out[i]+=a*b
        return {i:a for i,a in out.items() if a}
    def decode_base(value):
        return sum((base.components[i]*B(base.L({int(e):decode(co) for e,co in aa.items()}))
                    for i,aa in enumerate(value)),B(0))
    def parse_columns(receipt,expected_columns):
        assert len(receipt['columns'])==len(expected_columns)
        assert {row['column'] for row in receipt['columns']}==set(expected_columns)
        parsed={}
        for row in receipt['columns']:
            j=row['column']
            assert row['monomial']==list(order[j//6])
            assert all(str(int(i))==i and 0<=int(i)<750 for i in row['entries'])
            parsed[j]={int(i):decode(co) for i,co in row['entries'].items()}
            assert all(parsed[j].values())
        return parsed

    cover_defects={}
    rank_histogram=Counter()
    for row in sorted(summary['results'],key=lambda r:r['orbit']):
        tick=time.monotonic()
        number=row['orbit']
        orbit=orbits['orbits'][number]
        plane,central=orbit[0]
        assert row['representative']==[plane,central] and row['orbit_size']==len(orbit)
        prefix='plane%02d_central%d_'%(plane,central)
        paths={kind:folder/(prefix+kind+'.json') for kind in ('hodge','deck','rank')}
        assert Path(row['rank_file']).resolve()==paths['rank'].resolve()
        receipts={}
        for kind,path in paths.items():
            receipt,digest=read(path)
            assert digest==row[kind+'_sha256']
            receipts[kind]=receipt
        hs,ds,rr=[receipts[kind] for kind in ('hodge','deck','rank')]
        assert hs['status']=='pilot_complete' and ds['status']=='columns_complete' and rr['status']=='PASS'
        assert hs['column_kind']=='Hodge' and ds['column_kind']=='deck_h'
        assert Path(rr['hodge_source']).resolve()==paths['hodge'].resolve()
        assert Path(rr['deck_source']).resolve()==paths['deck'].resolve()
        for name in ('case','plane','central','field_modulus','alpha','gluing','affine_rhs','infinity_rhs',
                     'as_plane_coefficients','central_complement','base_plane','plane_rank'):
            assert hs[name]==ds[name]
        for receipt in (hs,ds,rr):
            assert (receipt['case'],receipt['plane'],receipt['central'])==(args.case,plane,central)
            assert receipt['base_plane']==(plane==0)
            assert receipt['plane_rank']==case['planes'][plane]['rank']
        assert hs['field_modulus']==source['coefficient_field_modulus']
        assert decode(hs['alpha'])==alpha
        assert hs['as_plane_coefficients']==case['planes'][plane]['coefficient_basis']
        chi1,chi2,chi3,f1,f2,g1,g2,cross,complement=plane_data[plane]
        assert hs['central_complement']==list(map(int,complement))
        primitive=central*chi3
        assert [decode_base(hs['gluing'][name]) for name in ('chi1','chi2','kappa')]==[chi1,chi2,primitive]
        co,uu,oo=base.split(cross+primitive**5-primitive,False)
        assert not any(co)
        assert list(map(decode_base,hs['affine_rhs']))==[f1,f2,-uu]
        assert list(map(decode_base,hs['infinity_rhs']))==[g1,g2,oo]
        psi=parse_columns(hs,range(744,750))
        hd=parse_columns(ds,range(750))
        h=[hd[i] for i in range(750)]
        for j in range(750):
            v={j:k(1)}
            assert act(g,act(h,v))==act(c,act(h,act(g,v)))
            vv=v
            for _ in range(5):vv=act(h,vv)
            assert vv==v
        complete_columns=[]
        for j in range(744,750):
            vc=psi[j]
            for _ in range(5):
                vh=vc
                for _ in range(5):
                    vg=vh
                    for _ in range(5):
                        complete_columns.append(vg)
                        vg=act(g,vg)
                    vh=act(h,vh)
                vc=act(c,vc)
        full=matrix(k,750,750,{(i,j):a for j,col in enumerate(complete_columns) for i,a in col.items()},
                    sparse=False,implementation='generic')
        independent_rank=int(full.__pari__().matrank())
        independent_defect=750-independent_rank
        assert rr['rank']==row['rank']==independent_rank
        assert rr['defect']==row['defect']==independent_defect
        assert rr['genus']==251 and rr['tangent_dimension']==750
        assert rr['deck_relations_checked_on']==750
        assert rr['free_generators']==6 and rr['full_group_basis_monomials']==125
        assert len(rr['rank_progression'])==125 and rr['rank_progression'][-1]==independent_rank
        assert all(a<=b for a,b in zip(rr['rank_progression'],rr['rank_progression'][1:]))
        for label in orbit:
            key=tuple(label)
            assert key not in cover_defects
            cover_defects[key]=independent_defect
        rank_histogram[independent_rank]+=1
        result['rows'].append({'orbit':number,'representative':[plane,central],
            'orbit_size':len(orbit),'rank':independent_rank,'defect':independent_defect,
            'all750_deck_relations':True,'actual_cover_data':True,
            'seconds':time.monotonic()-tick})
        save('orbit_rank_PASS')
    assert set(cover_defects)==set(labels)
    weighted=Counter(cover_defects.values())
    assert {str(d):n for d,n in weighted.items()}==summary['weighted_defect_histogram']
    if args.case==0:
        assert weighted=={29:150,37:5}
        high={label for label,d in cover_defects.items() if d==37}
        assert high=={(0,j) for j in range(5)}
        result['high_defect_plane']=0
        result['high_defect_plane_is_original_base_plane']=True
    else:
        assert weighted=={29:155}
        result['high_defect_plane']=None
    result['cover_defects']={'%d,%d'%label:d for label,d in sorted(cover_defects.items())}
    result['orbit_rank_histogram']={str(rank):n for rank,n in rank_histogram.items()}
    result['weighted_defect_histogram']={str(d):n for d,n in weighted.items()}
    result['orbits_checked']=count
    result['cover_count']=155
    result['matrix_artifacts_checked']=3*count
    result['summary_sha256']=summary_hash
    result['status']='PASS'
    save('complete_fixed_case')


if __name__=='__main__':
    main()
