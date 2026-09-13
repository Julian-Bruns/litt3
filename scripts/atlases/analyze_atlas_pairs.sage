"""Read-only strategic S-pair combinations from a saved F4 checkpoint.

Diagnostic only: input checkpoint is never changed, sampled row provenance
is retained, and no absence of new rows is an emptiness certificate.
"""
import argparse,collections,hashlib,heapq,json,mmap,struct,time
from pathlib import Path
ap=argparse.ArgumentParser();ap.add_argument('--checkpoint',required=True)
ap.add_argument('--out',required=True);ap.add_argument('--rows',type=int,default=64)
ap.add_argument('--strategy',choices=['smallest','random','common_lcm'],default='smallest')
ap.add_argument('--inspect',action='store_true');args=ap.parse_args()
started=time.monotonic();out=Path(args.out);out.mkdir(parents=True,exist_ok=False)
f=open(args.checkpoint,'rb');mm=mmap.mmap(f.fileno(),0,access=mmap.ACCESS_READ);offset=0
def take(n):
    global offset
    p=offset;offset+=n;assert offset<=len(mm);return p
def nums(n):return struct.unpack_from('<'+'Q'*n,mm,take(8*n))
head=nums(15);assert head[:3]==(0x41544c4153463443,1,0x01020304)
_,_,_,es,hs,hds,ds,oo,fc,nv,mo,nev,ff,la,inputhash=head
assert (es,hs,hds,ds,oo,fc,mo,nev,ff,la)==(2,4,16,8,6,5,0,0,8,2)
ld,sz,lo,constant,mltdeg,lml,elo,eld,esz,hsz,ebl,hnv,evl,ndv,bpv,rsd=nums(16)
assert hnv==nv and evl==nv+1 and ld<=sz and lml<=ld
ep=take(eld*evl*es)
take(eld*hds+hsz*4+ndv*bpv*4+ndv*4+evl*4)
redp=take(ld);take(lml*8)
records=[]
for i in range(ld):
    n=nums(1)[0];p=take((n+oo)*hs);meta=struct.unpack_from('<6I',mm,p)
    assert meta[5]==n and meta[3]<ld
    cp=take(n);records.append((n,p+24,cp,struct.unpack_from('<I',mm,p+24)[0]))
np,ps=nums(2);assert np<=ps
pp=take(np*40)
counts=collections.Counter();native_pair_degrees=collections.Counter();best=[]; groups=collections.defaultdict(list)
import random
rng=random.Random(int(20260908))
for index in range(np):
    lcm,g1,g2,degree,typ=struct.unpack_from('<5Q',mm,pp+40*index)
    assert g1<ld and g2<ld and lcm<eld
    counts[degree]+=1
    erow=struct.unpack_from('<'+'H'*evl,mm,ep+lcm*evl*es)
    native_pair_degrees[int(erow[0]-erow[-1])]+=1
    if degree==5:
        cost=records[g1][0]+records[g2][0]
        score=cost if args.strategy=='smallest' else rng.random()
        if args.strategy=='common_lcm':groups[lcm].append((cost,index,(lcm,g1,g2,degree,typ)))
        item=(-score,-index,(lcm,g1,g2,degree,typ))
        if len(best)<args.rows:heapq.heappush(best,item)
        elif item>best[0]:heapq.heapreplace(best,item)
if args.strategy=='common_lcm':
    ordered=sorted(groups.values(),key=lambda g:(-len(g),sum(t[0] for t in g)/len(g)))
    chosen=[]
    for group in ordered:
        chosen.extend(sorted(group))
        if len(chosen)>=args.rows:break
    best=[(-cost,-i,q) for cost,i,q in chosen[:args.rows]]
md=nums(16);take(32);assert offset+8==len(mm)
def exp(i):
    row=struct.unpack_from('<'+'H'*evl,mm,ep+i*evl*es)
    assert row[0]==sum(row[1:]);return tuple(row[1:])
report=dict(checkpoint=str(Path(args.checkpoint).resolve()),bytes=len(mm),
    header_input_fingerprint=int(inputhash),stored_checksum=int(struct.unpack_from('<Q',mm,len(mm)-8)[0]),
    full_checksum_recomputed=False,basis_rows=int(ld),monomials=int(eld),
    pending_by_degree={str(d):int(n) for d,n in counts.items()},
    pending_by_native_lcm_degree={str(d):int(n) for d,n in native_pair_degrees.items()},
    selection=args.strategy,
    selected=[dict(pair_index=-j,parents=list(q[1:3]),lcm=list(exp(q[0])),input_terms=int(records[q[1]][0]+records[q[2]][0])) for cost,j,q in sorted(best,reverse=True)],
    mathematical_scope='Read-only diagnostic on saved, previously used checkpoint; no original-ideal certificate.')
report['marked_redundant_rows']=sum(bool(mm[redp+i]) for i in range(ld))
report['active_leading_rows']=int(lml)
report['leading_monomial_bidegrees_and_coefficient_exponent']={str(e):int(n) for e,n in
    collections.Counter((sum(exp(rec[3])[:32]),sum(exp(rec[3])[32:-1]),exp(rec[3])[-1]) for rec in records).items()}
report['distinct_leading_monomials_after_coefficient_drop']=len(set(exp(rec[3])[:-1] for rec in records))
print('checkpoint parsed',ld,'basis rows;',dict(counts),'pending; selected supports',
      [r['input_terms'] for r in report['selected'][:10]],flush=True)
if not args.inspect:
    k=GF(25,'a',modulus=PolynomialRing(GF(5),'j')([2,4,1]));a=k.gen()
    from functools import lru_cache
    @lru_cache(maxsize=int(512))
    def polynomial(i):
        n,p,cp,lm=records[i]
        ids=struct.unpack_from('<'+'I'*n,mm,p)
        return [(exp(j),int(mm[cp+h])) for h,j in enumerate(ids)]
    rows=[]
    for _,_,q in sorted(best,reverse=True):
        le=exp(q[0]);ans={}
        for sign,g in [(1,q[1]),(-1,q[2])]:
            poly=polynomial(g);lead=exp(records[g][3]);shift=tuple(x-y for x,y in zip(le,lead))
            assert min(shift)>=0
            inv=pow(int(poly[0][1]),-1,5)
            for e,c in poly:
                ee=tuple(x+y for x,y in zip(e,shift))
                val=k(sign*c*inv)*a**ee[-1];ex=ee[:-1]
                ans[ex]=ans.get(ex,k.zero())+val
        rows.append({e:c for e,c in ans.items() if c})
    monomials=sorted(set(e for row in rows for e in row),key=lambda e:(sum(e),tuple(-i for i in reversed(e))),reverse=True)
    index={e:j for j,e in enumerate(monomials)}
    A=matrix(k,len(rows),len(monomials),sparse=False)
    for i,row in enumerate(rows):
        for e,c in row.items():A[i,index[e]]=c
    E=A.augment(identity_matrix(k,len(rows)));E.echelonize()
    R=E[:,:A.ncols()];change=E[:,A.ncols():]
    assert change*A==R
    dims=collections.Counter();output=[]
    for i in range(R.nrows()):
        nz=[j for j,c in enumerate(R.row(i)) if c]
        d=max((sum(monomials[j]) for j in nz),default=-1);dims[d]+=1
        if d<=3 and nz:
            output.append(dict(degree=int(d),provenance=[str(c) for c in change.row(i)],
                terms=[[list(monomials[j]),str(R[i,j])] for j in nz]))
    report.update(original_row_degrees=dict(collections.Counter(max((sum(e) for e in r),default=-1) for r in rows)),
        monomial_v_tail_bidegrees={str(e):int(n) for e,n in collections.Counter((sum(e[:32]),sum(e[32:])) for r in rows for e in r).items()},
        original_terms=sum(len(r) for r in rows),combined_terms=sum(bool(c) for c in R.list()),
        combined_row_degrees=dict(dims),combination_matrix_replayed=True,
        matrix_shape=list(A.dimensions()),new_low_degree_rows=output)
    print('EXACT combination replay PASS',A.dimensions(),'degree distribution',dict(dims),flush=True)
report['seconds']=time.monotonic()-started
(out/'report.json').write_text(json.dumps(report,indent=2,default=int)+'\n')
