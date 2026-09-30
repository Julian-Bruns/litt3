#!/usr/bin/env python3
"""Independent small arithmetic replay; not a substitute for the exhaustive C++ audit."""
from __future__ import annotations
import argparse, gzip, hashlib, json, math, struct
from pathlib import Path
import verify_moments as K
from generate_pole_profiles import profiles
ROOT=Path(__file__).resolve().parents[1]
MASK=(1<<28)-1

def code(ids):return sum(x<<(7*i) for i,x in enumerate(sorted(ids)))
def rotate(c,r):return code([29*((x//29+r)%4)+x%29 for x in [(c>>(7*i))&127 for i in range(4)]])
def canonical(c):return min(rotate(c,r) for r in range(4))
def sigma(v,r=1):return tuple(K.power8(x,25**r) for x in v)

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--degrees',type=int,nargs='+',default=[15,16])
    ap.add_argument('--work-root',type=Path,help='Read fresh samples from work-root/degreeN/chunks')
    ap.add_argument('--output',type=Path,required=True)
    ap.add_argument('--reference',type=Path)
    a=ap.parse_args();ref=json.loads(a.reference.read_text()) if a.reference else None
    if not a.work_root and ref is None:raise ValueError('Need --work-root or --reference')
    zp,C,E,field=K.setup()
    for i in range(116):
        j=29*((i//29+1)%4)+i%29
        assert sigma(C[i])==C[j] and sigma(E[i])==E[j]
    burnside=[math.comb(119,4),29,math.comb(59,2),29]
    assert sum(burnside)//4==1985630
    summaries={};samples=[];all_profiles=0;record_count=0
    for degree in a.degrees:
        cfg=json.loads((ROOT/f'input/degree{degree}_profiles.json').read_text())
        assert cfg==profiles(degree-12)
        full=json.loads((ROOT/f'evidence/degree{degree}_orbits.json').read_text())
        assert full['all_profiles_moment_empty'] and full['profile_count']==len(cfg['profiles'])
        assert full['orbits_per_side']==1985630 and full['quartets_per_side']==7940751
        all_profiles+=len(cfg['profiles']);record_count+=full['total_records_audited']
        byid={p['id']:p for p in cfg['profiles']}
        for r in full['results']:
            assert r['moment_locus_empty'] and r['matching_orbit_pairs']==0 and r['matching_field_orbit_keys']==0
            assert r['complete_valid_unique_coverage'] and r['all_record_identities_passed']
            assert r['records_audited']==r['field_cross_multiplications']==3971260
            assert r['zero_numerator_counts']==r['infinite_vector_counts']==r['zero_vector_counts']==[0,0]
            rows=[x for x in full['chunks'] if x['profile']==r['profile']];cursor=0
            assert len(rows)==8
            for row in rows:
                s=row['summary'];assert s['start']==cursor and s['count']>0
                assert s['zero_numerator_counts']==[0,0] and s['zero_vectors']==s['infinite_vectors']==[[],[]]
                assert s['finite_counts']==[s['count'],s['count']]
                assert all(row['keys'][side]['bytes']==32*s['count'] for side in ('left','right'))
                cursor+=s['count']
            assert cursor==1985630
            if a.work_root:
                for row in (rows[0],rows[-1]):
                    for side in ('left','right'):
                        item=row['keys'][side];path=a.work_root/f'degree{degree}'/'chunks'/item['filename']
                        count=row['summary']['count'];index=int.from_bytes(hashlib.sha256(item['filename'].encode()).digest()[:8],'little')%count
                        if path.exists():f=path.open('rb')
                        else:f=gzip.open(Path(str(path)+'.gz'),'rb')
                        with f:f.seek(32*index);raw=f.read(32)
                        assert len(raw)==32;v=struct.unpack('<8I',raw)
                        samples.append({'degree':degree,'profile':r['profile'],'chunk':row['chunk'],'side':side,'index':index,'packed_code':v[-1],'value':list(v[:-1])})
        summaries[str(degree)]={'all_weighted_profiles':cfg['total_profiles'],'affine_profile_orbits':len(cfg['profiles']),
                                'all_moment_loci_empty':True,'records_audited':full['total_records_audited']}
    if not a.work_root:samples=ref['independent_record_samples']
    assert len(samples)==4*all_profiles
    profile_cfg={d:{p['id']:p for p in profiles(d-12)['profiles']} for d in a.degrees}
    for s in samples:
        d=s['degree'];assert d in a.degrees;w=profile_cfg[d][s['profile']]['weighted_nodes']
        pc=s['packed_code'];assert 0<=pc<(1<<30);c=pc&MASK;shift=pc>>28;assert canonical(c)==c
        cs,es=K.sums(c,C,E)
        if s['side']=='left':num=K.sub(es,K.scale(K.moment(zp,w,-2),22));den=K.sub(cs,K.scale(K.moment(zp,w,6),22))
        else:num=K.sub(cs,K.scale(K.moment(zp,w,-6),22));den=K.sub(es,K.scale(K.moment(zp,w,2),22))
        key=tuple(s['value']);assert num!=K.ZERO and den!=K.ZERO and all(0<=x<25**4 for x in key)
        assert K.mul(key,sigma(den,shift))==sigma(num,shift)
        assert all(key<=sigma(key,r) for r in (1,2,3))
    out={'scope':'independent direct-polynomial field and sample replay; exhaustive proof uses retained full C++ audit',
         'field_model':field,'label_Frobenius_action_checked':116,'sigma_absolute_Frobenius_exponent':42,
         'burnside_fixed_counts':burnside,'endpoint_orbits':1985630,'profiles':summaries,
         'retained_full_record_audit_total':record_count,'independent_record_samples':samples}
    if ref is not None:assert out==ref
    a.output.write_text(json.dumps(out,indent=2)+'\n')
    print('PASS: independent field model and all 116 coefficient-Frobenius label actions')
    print('PASS: complete profile reductions, Burnside counts, and retained complete-audit coverage')
    print(f'PASS: {len(samples)} retained records independently checked without logarithm tables or inversion')
    print(f'RETAINED FULL AUDIT: {record_count} exact record identities; no matches in selected degrees {a.degrees}')
    print('LIMIT: this small replay does not regenerate the exhaustive streams or search branch curves')
if __name__=='__main__':main()
