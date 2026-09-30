#!/usr/bin/env python3
"""Restartable exhaustive Hermite evaluation; this is polynomial interpolation, not a search."""
from __future__ import annotations
import argparse, concurrent.futures, hashlib, json, os, pathlib, struct, subprocess
import numpy as np

def sha(path):
    h = hashlib.sha256()
    with open(path, 'rb') as f:
        for b in iter(lambda: f.read(1 << 20), b''): h.update(b)
    return h.hexdigest()

def main():
    ap=argparse.ArgumentParser()
    ap.add_argument('prefix'); ap.add_argument('--executable', default='work/projector')
    ap.add_argument('--jobs', type=int, default=4); ap.add_argument('--chunk', type=int, default=4096)
    ap.add_argument('--skip-recover', action='store_true')
    args=ap.parse_args(); prefix=pathlib.Path(args.prefix).resolve()
    exe=str(pathlib.Path(args.executable).resolve()); meta_path=str(prefix)+'.meta.json'
    with open(meta_path) as f: meta=json.load(f)
    N,L=int(meta['N']),int(meta['L']); mh=sha(meta_path)
    expected_magic=0x315345444e435043
    def verify(start, count):
        name=f'{prefix}.nodes.{start}.bin'
        try:
            with open(name+'.json') as f: record=json.load(f)
            if not all(int(record[k])==v for k,v in [('start',start),('count',count),('N',N),('L',L)]): return False
            if record['source_meta_sha256'] != mh or record['output_sha256'] != sha(name): return False
            with open(name,'rb') as f: header=struct.unpack('<8Q',f.read(64))
            if header != (expected_magic,N,L,328,start,count,0,0): return False
            if os.stat(name).st_size !=64+2*L*count*4: return False
            return True
        except (OSError,ValueError,KeyError,struct.error): return False
    def task(start):
        count=min(args.chunk,N-start)
        reused=verify(start,count)
        if not reused:
            log=f'{prefix}.nodes.{start}.log'
            with open(log,'w') as f:
                subprocess.run([exe,'nodes',str(prefix),str(start),str(count),'1'],stdout=f,stderr=subprocess.STDOUT,check=True)
            if not verify(start,count): raise RuntimeError(f'Invalid chunk {start}')
        print(json.dumps({'verified_chunk':[start,count], 'reused':reused}),flush=True)
        return start,count
    with concurrent.futures.ThreadPoolExecutor(max_workers=args.jobs) as pool:
        completed=list(pool.map(task,range(0,N,args.chunk)))
    sample=str(prefix)+'.samples.bin'; tmp=sample+'.tmp'
    with open(tmp,'wb') as f:
        f.write(struct.pack('<8Q',expected_magic,N,L,328,0,N,0,0)); f.truncate(64+2*L*N*4)
    out=np.memmap(tmp,dtype='<u4',mode='r+',offset=64,shape=(2,L,N))
    coverage=np.zeros(N,dtype=np.uint8); records=[]
    for start,count in sorted(completed):
        assert verify(start,count)
        inp=np.memmap(f'{prefix}.nodes.{start}.bin',dtype='<u4',mode='r',offset=64,shape=(2,L,count))
        assert np.all(inp < 390625)
        assert not np.any(coverage[start:start+count]); coverage[start:start+count]=1
        out[:,:,start:start+count]=inp
        with open(f'{prefix}.nodes.{start}.bin.json') as f: records.append(json.load(f))
    assert np.all(coverage==1); out.flush(); del out
    os.replace(tmp,sample)
    evidence={'N':N,'L':L,'complete_nonoverlapping_coverage':True,'source_meta_sha256':mh,'samples_sha256':sha(sample),'chunks':records}
    with open(str(prefix)+'.coverage.json','w') as f: json.dump(evidence,f,indent=2); f.write('\n')
    print(json.dumps({'full_Hermite_coverage':'PASS','samples_sha256':evidence['samples_sha256']}),flush=True)
    if not args.skip_recover:
        subprocess.run([exe,'recover',str(prefix),sample,str(prefix)+'.polynomials.json'],check=True)

if __name__=='__main__': main()
