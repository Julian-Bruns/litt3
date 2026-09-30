#!/usr/bin/env python3
"""Independent direct-field, polynomial and coverage checks for constant pencils."""
import argparse,hashlib,itertools,json,random,re
from pathlib import Path
import klein_four_constant_pencil_targets as T
import check_klein_four_constant_character_jet as N
import klein_four_constant_character_jet as J

F=T.F;Z=T.ZERO;O=T.ONE


def power(a,n):
    v=O
    while n:
        if n&1:v=T.mul(v,a)
        a=T.mul(a,a);n//=2
    return v
def scale(a,c):return tuple(F.f.mul(x,c) for x in a)
def pm(a,b):
    r=[Z]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b):r[i+j]=T.add(r[i+j],T.mul(x,y))
    return r
def divide(a,b):
    a=list(a);q=[Z]*(len(a)-len(b)+1)
    for i in range(len(a)-1,len(b)-2,-1):
        c=T.mul(a[i],T.inv(b[-1]));q[i-len(b)+1]=c
        for j,v in enumerate(b):a[i-len(b)+1+j]=T.sub(a[i-len(b)+1+j],T.mul(c,v))
    return q,a[:len(b)-1]
def rank(cols):
    a=[[T.coord(c,i) for c in cols] for i in range(4)];r=0
    for j in range(len(cols)):
        p=next((i for i in range(r,4) if a[i][j]!=Z),None)
        if p is None:continue
        a[r],a[p]=a[p],a[r];unit=T.inv(a[r][j]);a[r]=[T.mul(v,unit) for v in a[r]]
        for i in range(4):
            if i!=r:
                c=a[i][j];a[i]=[T.sub(v,T.mul(c,w)) for v,w in zip(a[i],a[r])]
        r+=1
    return r


def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('directory',type=Path)
    args=ap.parse_args();root=args.directory
    data=json.loads((root/'near_word_jets.json').read_text());old=F.construct_data()
    assert data['root_data']==old
    alphas=list(map(tuple,old['alpha_roots']));bases=list(map(tuple,old['B_base']))
    om=(F.ZERO,F.ONE)+(F.ZERO,)*5;nzs=[N.power(om,i) for i in range(29)]
    z=(0,1,0,0,0,0,0);zs=[power(z,i) for i in range(29)]
    const=[]
    for a in alphas:
        cv=F.es(F.ei(F.ev(F.f.der(F.f.A),a)),13)
        lv=F.em(cv,F.ea(F.em(F.ev(F.f.der(F.f.P),a),F.ei(F.ev(F.f.P,a))),F.en(F.em(F.ev(F.f.der(F.f.der(F.f.A)),a),F.ei(F.ev(F.f.der(F.f.A),a))))))
        const.append((cv,lv))
    rng=random.Random(26092613);checks=0
    for case in data['cases']:
        for es in [(0,0,0,0),(0,1,0,1),(0,0,1,2),(0,1,2,3)]+[(0,*[rng.randrange(29) for _ in range(3)]) for _ in range(3)]:
            labels=[]
            for j,e in zip(case['roots'],es):
                b=N.times(N.lift(bases[j]),nzs[e]);cv,lv=const[j]
                labels.append((N.lift(alphas[j]),b,N.times(N.lift(cv),N.power(b,4)),N.times(N.lift(lv),N.power(b,5))))
            for i,sg in enumerate(J.SIGNS):
                vals=[]
                for j in range(4):
                    v=N.Z
                    for l,s in zip(labels,sg):v=N.plus(v,N.scalar(l[j],s))
                    vals.append(v)
                a,b,da,db=vals
                bb=N.times(b,b);ab=N.times(a,b);num=N.minus(N.times(da,b),N.times(a,db))
                for offset,cols in [(1,[bb,ab,num]),(2,[bb,ab,N.times(a,a),num])]:
                    value=N.Z
                    for term in case['polynomials'][3*i+offset]:
                        exponent=sum(e*t for e,t in zip(es,term[:4]))%29
                        value=N.plus(value,N.times(N.lift(term[4:]),nzs[exponent]))
                    assert (value==N.Z)==(rank(cols)<len(cols)),(case['roots'],es,i,offset)
                    checks+=1
    log=(root/'near_word_jets.log').read_text()
    assert 'TOTAL tested=268279 retained=268279 coincident_leading_labels=19610' in log
    targets=json.loads((root/'constant_pencil_targets.json').read_text())
    assert len(targets['nonrational_targets'])==142 and len(targets['rational_targets'])==1
    slog=(root/'constant_pencil_subsets.log').read_text()
    assert 'sum_hits=45 full_hits=0 rational_targets_not_checked=1' in slog
    samples=re.findall(r'^SUM target=(\d+) complement_mask=(\d+)$',slog,re.M)
    assert len(samples)==45
    for ti,mask in samples:
        mask=int(mask);assert mask.bit_count()==14
        c=[O]
        for i in range(29):
            if not mask>>i&1:c=pm(c,[T.neg(zs[i]),O])
        q,_=divide([Z]*22+[O],c)
        slope=T.mul(c[1],T.inv(c[0]));intercept=scale(T.mul(c[0],q[1]),2)
        target=targets['nonrational_targets'][int(ti)]
        assert slope==tuple(target['slope'])
        assert intercept!=tuple(target['intercept'])
    rlog=(root/'constant_pencil_rational.log').read_text()
    assert 'normalized_subsets=37442160 representatives=191280 covered=37442160 matching_labels=1' in rlog
    matches=re.findall(r'^MATCH complement_mask=(\d+) coefficient_frobenius=(\d+) phase=(\d+)$',rlog,re.M)
    assert matches==[('29641591','0','1')]
    mask=int(matches[0][0]);c=[O]
    for i in range(29):
        if not mask>>i&1:c=pm(c,[T.neg(zs[i]),O])
    q,_=divide([Z]*22+[O],c);r0=scale(zs[28],22);s0=scale(zs[3],8)
    q[0]=T.mul(r0,T.inv(scale(c[0],2)));word=[scale(v,2) for v in pm(c,q)]
    assert word[0]==r0 and word[1]==s0 and word[22]==scale(O,2)
    assert all(v==Z for v in word[16:22])
    ri,si=word[15],word[14]
    assert power(ri,29)==scale(O,22)
    assert power(ri,29)!=scale(O,F.f.powf(22,29))
    assert T.mul(si,power(ri,3))==scale(O,12)
    out={'status':'PASS','scope':'Independent bounded Moore checks plus every retained additive subset hit and the sole rational first-endpoint orbit; complete coverage is in the separate enumerators.',
         'direct_Moore_rank_checks':checks,'additive_subset_hits_independently_excluded':45,
         'rational_orbit':{'complement_mask':mask,'phase':1,'word':word,'terminal_r':ri,'terminal_s':si,'terminal_norm_code':22,'required_norm_code':F.f.powf(22,29)},
         'leading_label_collisions_retained':19610,'sha256':{}}
    paths=[root/n for n in ['near_word_jets.json','near_word_jets.log','constant_pencil_targets.json','constant_pencil_subsets.log','constant_pencil_rational.log']]
    paths+=list(Path(__file__).parent.glob('klein_four_constant_pencil*'))+[Path(__file__)]
    for p in paths:out['sha256'][str(p)]=hashlib.sha256(p.read_bytes()).hexdigest()
    (root/'constant_pencil_independent.json').write_text(json.dumps(out,indent=2)+'\n')
    print('PASS:',checks,'direct rank checks,45 direct subset exclusions,one terminal endpoint exclusion; all leading-label collisions retained.')


if __name__=='__main__':main()
