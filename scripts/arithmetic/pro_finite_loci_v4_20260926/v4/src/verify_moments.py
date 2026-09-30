#!/usr/bin/env python3
"""Small exact replay for Appendix E, using direct polynomial arithmetic.

This verifies the field model, all profile reductions, a moment-only witness,
and retained samples from the full streams. It does NOT replace the exhaustive
C++ producer/merge/full-record audit. Use reproduce_degree14.py for that replay.
"""
from __future__ import annotations
import argparse
from functools import lru_cache
import hashlib
import itertools
import json
import math
from pathlib import Path
import platform
import struct
import ff25 as F
from trace_field import certificate as trace_certificate

ROOT = Path(__file__).resolve().parents[1]
A = [1,21,14,22,13]
P = [11,22,18,5,19,20,15,16,9,22,1]
F7 = [4,22,7,20,21,7,24,1]
ZERO = (0,)*7
ONE = (1,0,0,0,0,0,0)

def polynomial_power(a: list[int], n: int, modulus: list[int]) -> list[int]:
    r=[1]
    while n:
        if n&1:r=F.pdivmod(F.pmul(r,a),modulus)[1]
        a=F.pdivmod(F.pmul(a,a),modulus)[1]
        n//=2
    return r

@lru_cache(maxsize=262144)
def decode8(a: int) -> tuple[int,...]:
    assert 0<=a<25**4
    r=[]
    for _ in range(4):r.append(a%25);a//=25
    return tuple(r)

def encode8(a: list[int] | tuple[int,...]) -> int:
    assert len(a)<=4
    return sum(c*25**i for i,c in enumerate(a))

def add8(a: int,b: int) -> int:
    return encode8(F.padd(list(decode8(a)),list(decode8(b))))

def neg8(a: int) -> int:
    return encode8(F.pneg(list(decode8(a))))

@lru_cache(maxsize=262144)
def mul8(a: int,b: int) -> int:
    return encode8(F.pdivmod(F.pmul(list(decode8(a)),list(decode8(b))),A)[1])

def power8(a: int,n: int) -> int:
    return encode8(polynomial_power(list(decode8(a)),n,A))

def add(a: tuple[int,...],b: tuple[int,...]) -> tuple[int,...]:
    return tuple(add8(x,y) for x,y in zip(a,b))

def neg(a: tuple[int,...]) -> tuple[int,...]:
    return tuple(neg8(x) for x in a)

def sub(a: tuple[int,...],b: tuple[int,...]) -> tuple[int,...]:
    return add(a,neg(b))

def scale(a: tuple[int,...],c: int) -> tuple[int,...]:
    return tuple(mul8(x,c) for x in a)

def mul(a: tuple[int,...],b: tuple[int,...]) -> tuple[int,...]:
    p=[0]*13
    for i,x in enumerate(a):
        if x:
            for j,y in enumerate(b):
                if y:p[i+j]=add8(p[i+j],mul8(x,y))
    for d in range(12,6,-1):
        for j,c in enumerate(F7[:-1]):
            p[d-7+j]=add8(p[d-7+j],neg8(mul8(p[d],c)))
    return tuple(p[:7])

def setup():
    tc=trace_certificate(P,A)
    assert tc['canonical_c']==[22,7,9,23]
    assert tc['canonical_e2']==[1,3,8,15]
    assert F.pdivmod([1]*29,F7)[1]==[]
    r=F.psub(polynomial_power([0,1],25,F7),[0,1])
    g,s,t=F.xgcd(F7,r)
    assert g==[1] and F.padd(F.pmul(s,F7),F.pmul(t,r))==[1]
    r7=F.psub(polynomial_power([0,1],25**7,F7),[0,1])
    assert not r7 and math.gcd(7,4)==1
    zp=[]
    for i in range(29):
        v=polynomial_power([0,1],i,F7)
        zp.append(tuple(v+[0]*(7-len(v))))
    assert mul(zp[-1],zp[1])==ONE and len(set(zp))==29
    C=[];E=[]
    c=encode8(tc['canonical_c']);e=encode8(tc['canonical_e2'])
    for _ in range(4):
        for j in range(29):
            C.append(scale(zp[5*j%29],c));E.append(scale(zp[8*j%29],e))
        c=power8(c,25);e=power8(e,25)
    assert c==encode8(tc['canonical_c']) and e==encode8(tc['canonical_e2'])
    return zp,C,E,{'f7':F7,'f7_divides_Phi29':True,'degree7_Frobenius_remainder':r7,
                   'linear_factor_test_remainder':r,'gcd':g,'bezout_f7':s,'bezout_remainder':t,
                   'coprime_tower_degrees':[4,7], 'field_cardinality':5**56,
                   'canonical_c':tc['canonical_c'],'canonical_e2':tc['canonical_e2']}

def pair_reduction():
    h=sorted({pow(25,i,29) for i in range(7)})
    group=sorted(set(h)|{(-x)%29 for x in h})
    assert len(h)==7 and len(group)==14 and 2 not in group
    classes={'one2':29,'two1':0,'two2':0}
    for a,b in itertools.combinations(range(29),2):
        difference=(b-a)%29
        if difference in group:classes['two1']+=1
        else:
            assert difference in {2*x%29 for x in group}
            classes['two2']+=1
    assert classes=={'one2':29,'two1':203,'two2':203}
    return {'powers_of_25_mod29':h,'with_inversion':group,
            'all_mass_two_weighted_profiles':435,'profile_orbit_sizes':classes,
            'endpoint_multiset_count':math.comb(119,4),
            'ordered_multiset_pairs_per_profile':math.comb(119,4)**2}

def sums(code: int,C,E):
    inds=[(code>>(7*i))&127 for i in range(4)]
    assert code<2**28 and inds==sorted(inds) and inds[-1]<116
    c=e=ZERO
    for i in inds:c=add(c,C[i]);e=add(e,E[i])
    return c,e

def moment(zp,weighted,r):
    result=ZERO
    for exponent,weight in weighted:result=add(result,scale(zp[r*exponent%29],weight%5))
    return result

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path,required=True)
    ap.add_argument('--reference',type=Path)
    ap.add_argument('--chunks',type=Path,help='Read 96 fresh deterministic record samples from regenerated streams')
    args=ap.parse_args()
    cfg=json.loads((ROOT/'input/moment_profiles.json').read_text())
    assert cfg['field_modulus_F25_ascending']==F7 and cfg['degree']==14
    zp,C,E,field=setup()
    reductions=pair_reduction()
    summaries={};audits={}
    for profile in cfg['profiles']:
        summaries[profile]=json.loads((ROOT/f'evidence/moments/{profile}_merged.json').read_text())
        audits[profile]=json.loads((ROOT/f'evidence/moments/{profile}_audit.json').read_text())
        a=summaries[profile];b=audits[profile]
        assert a['quartets_checked']==7940751 and a['ordered_quartet_pairs_covered']==7940751**2
        assert a['range_coverage_complete'] and a['moment_locus_empty']
        assert all(a[k]==0 for k in ['all_pair_ratio_hits','zero_a_count','zero_b_count','zero_both_count'])
        assert b['all_record_identities_passed'] and b['record_identities_checked']==2*7940751
    chunkdata=json.loads((ROOT/'evidence/moments/chunks.json').read_text())
    for profile in cfg['profiles']:
        row=[r for r in chunkdata['chunks'] if r['profile']==profile]
        assert len(row)==16
        cursor=0
        for r in row:
            assert r['range_start']==cursor and r['quartets_checked']>0
            assert not any(r[k] for k in ['zero_a_count','zero_b_count','zero_both_count'])
            for side in ['left','right']:assert r['keys'][side]['bytes']==32*r['quartets_checked']
            cursor+=r['quartets_checked']
        assert cursor==7940751
    if args.chunks:
        samples=[]
        for profile in cfg['profiles']:
            for chunk in range(16):
                for side in ['left','right']:
                    stem=f'{profile}.{chunk:02d}.json.{side}.keys'
                    path=args.chunks/stem
                    size=path.stat().st_size
                    assert size%32==0
                    index=int.from_bytes(hashlib.sha256(stem.encode()).digest()[:8],'little')%(size//32)
                    with path.open('rb') as f:f.seek(32*index);raw=f.read(32)
                    values=struct.unpack('<8I',raw)
                    samples.append({'profile':profile,'chunk':chunk,'side':side,
                                    'record_index':index,'label_code':values[-1],
                                    'value_GF8_z_basis':list(values[:-1])})
    elif args.reference:
        samples=json.loads(args.reference.read_text())['independent_python_record_samples']
    else:
        raise ValueError('Supply --chunks to generate samples or --reference to replay them')
    assert len(samples)==96
    for sample in samples:
        pc=cfg['profiles'][sample['profile']]
        cs,es=sums(sample['label_code'],C,E)
        a=sub(es,scale(moment(zp,pc['weighted_nodes'],-2),22))
        b=sub(cs,scale(moment(zp,pc['weighted_nodes'],6),22))
        key=tuple(sample['value_GF8_z_basis'])
        assert a!=ZERO and b!=ZERO
        if sample['side']=='left':assert mul(key,b)==a
        else:assert mul(key,a)==mul(zp[pc['kappa_zeta_exponent']],b)
    witness=json.loads((ROOT/'input/moment_only_witness.json').read_text())
    weights=witness['weights_by_zeta_exponent'];weighted=list(enumerate(weights))
    assert sum(weights)==29 and witness['n']==41 and sum(x!=0 for x in weights)==15
    assert all(x in [0,1,2,3,4,6] for x in weights)
    moments={r:moment(zp,weighted,r) for r in [-2,-6,2,6]}
    for r,val in moments.items():assert val==(witness['moments'][str(r)],)+(0,)*6
    co=eo=ZERO
    for i in range(4):co=add(co,C[29*i]);eo=add(eo,E[29*i])
    assert co==(5,)+(0,)*6 and eo==(22,)+(0,)*6
    eps=witness['epsilon_F25_code']
    assert scale(sub(eo,scale(moments[-2],22)),eps)==sub(co,scale(moments[-6],22))
    assert scale(sub(co,scale(moments[6],22)),eps)==sub(eo,scale(moments[2],22))
    assert eps!=0 and all(scale(zp[4*j%29],eps)!=ONE for j,w in weighted if w)
    out={'python_version':platform.python_version(), 'field_certificate':field,
         'degree14_profile_reduction':reductions,'complete_search_summaries':summaries,
         'full_record_audits':audits,'independent_python_record_samples':samples,
         'independent_python_record_checks_passed':96,
         'moment_only_witness_verified':witness,
         'scope_warning':'The n=41 datum satisfies two necessary moments only; it is not an actual candidate or a reconstructed cover.',
         'degrees_newly_excluded':[14],'remaining_degree_range':[15,87],
         'actual_witnesses_constructed':0,'target_status':'PARTIAL / EXISTENCE UNRESOLVED'}
    if args.reference:
        reference=json.loads(args.reference.read_text());reference.pop('python_version',None)
        actual=dict(out);actual.pop('python_version',None)
        assert actual==reference,'reference mismatch'
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(out,indent=2,sort_keys=True)+'\n')
    print('PASS: direct-polynomial F_(5^56) model and irreducibility certificate')
    print('PASS: all 435 degree-14 weighted node profiles reduce to the three checked cases')
    print('PASS: retained complete-search and full-record-audit summaries, with contiguous chunk coverage')
    print('PASS: 96 stream records independently checked by direct Python polynomial arithmetic')
    print('PASS: explicit n=41 moment-only datum; NOT an actual curve or endpoint pair')
    print('RESULT: degree 14 excluded by the exhaustive computation; degrees 15..87 unresolved')
    print('FAST REPLAY LIMIT: this command does not re-enumerate the 23,822,253 endpoint multisets')

if __name__=='__main__':main()
