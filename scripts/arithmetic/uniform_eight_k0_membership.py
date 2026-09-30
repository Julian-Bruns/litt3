"""Exhaust K0-scalar one-endpoint memberships for uniform eight-label profiles.
Every root occurs twice. Prime-field eight-phase independence reduces each
occupied phase to one of sixteen packets. This is a coefficient test only.
"""
import argparse,itertools,json,time,hashlib
from pathlib import Path
from sage.all import GF,PolynomialRing

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--output',required=True)
    ap.add_argument('--mass',type=int,choices=(8,9))
    args=ap.parse_args();start=time.time()
    F=GF(5);R=PolynomialRing(F,'z')
    K=GF(5**14,'z',modulus=R([1,2,4,0,4,4,3,1,3,4,4,0,4,2,1]));z=K.gen()
    beta=K([1,1,0,0,4,3,3,1,1,3,1,2,1,1]);assert beta**2==beta+3 and z**29==1
    code=lambda n:K(n%5)+(n//5)*beta
    enc=lambda a:sum(int(a.polynomial()[i])*5**i for i in range(14))
    phases=[z**j for j in range(29)]
    cap=args.mass if args.mass else 2
    packets=[v for v in itertools.product(range(cap+1),repeat=4)
             if sum(v)>0 and (not args.mass or sum(v)<=args.mass)
             and sum(v[i]*pow(3,i,5) for i in range(4))%5==0]
    sequences=[]
    def rec(rem,seq):
        if not any(rem):sequences.append(tuple(seq));return
        for v in packets:
            if all(v[i]<=rem[i] for i in range(4)):
                rec(tuple(rem[i]-v[i] for i in range(4)),seq+[v])
    def mass_rec(rem,seq):
        if not rem:sequences.append(tuple(seq));return
        for v in packets:
            if sum(v)<=rem:mass_rec(rem-sum(v),seq+[v])
    if args.mass:
        mass_rec(args.mass,[])
        assert max(map(len,sequences))<=4
    else:
        rec((2,2,2,2),[])
        assert len(packets)==16 and len(sequences)==46
    candidates=[];free=[];tested=0;by_size={};halfturn=0;nonhalfturn=0
    keys={};digest=hashlib.sha256()
    for seq in sequences:
        weights=[[sum(v[i]*pow(2,l*i,5) for i in range(4))%5 for v in seq] for l in (1,2)]
        for tail in itertools.combinations(range(1,29),len(seq)-1):
            js=(0,)+tail;tested+=1;by_size[len(seq)]=by_size.get(len(seq),0)+1
            s=[[sum((K(w)*phases[e*j%29] for w,j in zip(ws,js)),K(0)) for e in (17,4)] for ws in weights]
            lam=None;bad=False
            for (a,b),c in zip(s,(code(10),code(18))):
                if not a:
                    if b:bad=True;break
                elif lam is None:lam=c*b/a
                elif lam*a!=c*b:bad=True;break
            if bad:continue
            labels=[4*j+i for v,j in zip(seq,js) for i in range(4) for _ in range(v[i])]
            labels.sort();assert len(labels)==(args.mass or 8)
            if lam is None:
                assert all(v[0]%5==v[1]%5==v[2]%5==v[3]%5 for v in seq)
                free.append(labels);continue
            assert lam
            ht=all(v[0]==v[2] and v[1]==v[3] for v in seq)
            halfturn+=int(ht);nonhalfturn+=int(not ht)
            k=lam**29;key=enc(k);keys.setdefault(key,[]).append(len(candidates))
            candidates.append((lam,k,labels))
            digest.update((str((enc(lam),labels))+'\n').encode())
    assert tested==({8:126341,9:635980}[args.mass] if args.mass else 29149)
    inverse_classes=[]
    for key,indices in keys.items():
        lam,k,l=candidates[indices[0]];ik=enc(1/k)
        if ik in keys and key<=ik:
            inverse_classes.append({'key':key,'inverse_key':ik,
                                    'multiplicities':[len(indices),len(keys[ik])],
                                    'first':[enc(lam),l],
                                    'second':[enc(candidates[keys[ik][0]][0]),candidates[keys[ik][0]][2]]})
    result={'status':'COMPLETE_ONE_ENDPOINT','mass':args.mass,'tested_normalized':tested,'by_size':by_size,
            'free_balanced':len(free),'finite_candidates':len(candidates),'halfturn':halfturn,
            'nonhalfturn':nonhalfturn,'scalar_mu29_classes':len(keys),
            'inverse_class_count':len(inverse_classes),'inverse_classes':inverse_classes,
            'candidate_sha256':digest.hexdigest(),'seconds':round(time.time()-start,3),
            'scope':'K0 membership at the stated cardinality/profile; not an actual cover decision'}
    Path(args.output).parent.mkdir(parents=True,exist_ok=True)
    Path(args.output).write_text(json.dumps(result,indent=2)+'\n')
    print({k:v for k,v in result.items() if k!='inverse_classes'},flush=True)

if __name__=='__main__':main()
