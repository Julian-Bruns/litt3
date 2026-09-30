#!/usr/bin/env python3
"""Independent direct quotient-polynomial checks of linear-pencil equations."""
import argparse,hashlib,json,math,random,re
from pathlib import Path
import check_klein_four_constant_pencils as C

T=C.T;F=C.F;Z=C.Z;O=C.O


def add(a,b):return tuple(T.add(x,y) for x,y in zip(a,b))
def neg(a):return tuple(T.neg(x) for x in a)
def sub(a,b):return add(a,neg(b))
def scalar(a,c):return tuple(T.mul(x,c) for x in a)
def mul(a,b,tau,upsilon):
    cross=T.mul(a[1],b[1])
    return (T.add(T.mul(a[0],b[0]),T.mul(cross,upsilon)),
            T.add(T.add(T.mul(a[0],b[1]),T.mul(a[1],b[0])),T.mul(cross,tau)))


def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('directory',type=Path)
    args=ap.parse_args();p=args.directory
    targets=json.loads((p/'linear_pencil_targets.json').read_text())
    assert (targets['source_targets'],targets['frobenius_closure'],targets['full_targets'])==(142,284,3364)
    log=(p/'linear_pencil_subsets.log').read_text()
    last=log.splitlines()[-1]
    nums={k:int(v) for k,v in re.findall(r'(\w+)=(\d+)',last)}
    assert nums==dict(normalized_subsets=math.comb(28,11),representatives=128037,covered=math.comb(28,11),targets=3364,zero_h6=0,first_equation=0,both_equations=0)
    label_log=(p/'near_word_jets.log').read_text()
    assert 'LINEAR pair_labels=143 quadratic_only_pairs=0 quadratic_only_characters=2' in label_log
    rgen=random.Random(26092617);z=(0,1,0,0,0,0,0);zs=[C.power(z,i) for i in range(29)]
    root=(Z,O);unit=(O,Z);zero=(Z,Z);checks=[]
    for it in range(48):
        js=sorted(rgen.sample(range(29),12));pol=[O]
        for i in range(29):
            if i not in js:pol=C.pm(pol,[T.neg(zs[i]),O])
        q0,rem0=C.divide([Z]*22+[O],pol)
        q1,rem1=C.divide([Z]*23+[O],pol)
        # A direct quotient computation gives the coefficients formerly h5,h6.
        a0=C.scale(T.mul(pol[0],q0[0]),2)
        a1=C.scale(T.mul(pol[0],q1[0]),2)
        assert a1!=Z
        target=targets['targets'][rgen.randrange(len(targets['targets']))]
        lam,nu,tau,ups=[tuple(a) for a in target]
        zparam=scalar(sub(root,(a0,Z)),T.inv(a1))
        quot=[]
        for i in range(max(len(q0),len(q1))):
            quot.append(add((q0[i] if i<len(q0) else Z,Z),scalar(zparam,q1[i] if i<len(q1) else Z)))
        word=[zero]*(len(pol)+len(quot)-1)
        for i,a in enumerate(pol):
            for j,b in enumerate(quot):word[i+j]=add(word[i+j],scalar(b,C.scale(a,2)))
        assert word[0]==root
        assert all(v==zero for v in word[17:22])
        assert word[22]==scalar(unit,C.scale(O,2)) and word[23]==scalar(zparam,C.scale(O,2))
        actual_s=sub(word[1],mul(root,zparam,tau,ups))
        # Recover the separate elementary-symmetric formula from J.
        elem=[O]+[Z]*6
        for i in js:
            for k in range(6,0,-1):elem[k]=T.add(elem[k],T.mul(zs[i],elem[k-1]))
        invprod=zs[(-sum(js))%29]
        m=C.scale(T.mul(invprod,elem[6]),3)
        alpha=Z
        for i in js:alpha=T.add(alpha,zs[(-i)%29])
        bnum=T.add(T.mul(m,alpha),C.scale(T.mul(invprod,elem[5]),4))
        cnum=C.scale(T.mul(T.mul(invprod,invprod),T.sub(T.mul(elem[4],elem[6]),T.mul(elem[5],elem[5]))),4)
        expected=(T.mul(T.sub(cnum,ups),T.inv(m)),T.mul(T.sub(bnum,tau),T.inv(m)))
        assert actual_s==expected
        assert T.add(T.mul(lam,m),tau)!=bnum
        assert actual_s[1]!=lam
        checks.append({'complement':js,'target_trace':tau,'coefficient_match':False})
    old=json.loads((p/'minimum_word_summary.json').read_text())['degree89_character_allocations']
    after=[r for r in old if all(d!=0 or c<=14 for c,d in zip(r['c'],r['d']))]
    assert len(after)==1 and after[0]['c']==[17,17,14] and after[0]['d']==[1,1,0]
    out={'status':'PASS','scope':'48 independent quadratic-algebra quotient constructions, complete-log coverage and exact degree89 elimination; not geometric-cover enumeration.',
         'independent_checks':checks,'complete_enumeration':nums,'degree89_after_constant_bound':after,'degree89_after_linear_pair_bound':[],
         'sources_and_evidence_sha256':{}}
    files=[p/'near_word_jets.log',p/'linear_pencil_targets.json',p/'linear_pencil_subsets.log',p/'constant_pencil_independent.json',Path(__file__)]
    files+=list(Path(__file__).parent.glob('klein_four_linear_pencil*'))
    for f in files:out['sources_and_evidence_sha256'][str(f)]=hashlib.sha256(f.read_bytes()).hexdigest()
    (p/'linear_pencil_independent.json').write_text(json.dumps(out,indent=2)+'\n')
    print('PASS:48 direct quadratic-algebra polynomial reconstructions,full coverage,degree89 excluded by the two proved pencil restrictions.')


if __name__=='__main__':main()
