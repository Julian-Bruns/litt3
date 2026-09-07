#!/usr/bin/env python3
"""Native parallel regression against the preserved serial engine.

Run explicitly with --output DIRECTORY; no production checkpoints are touched.
All checkpoint mathematical bytes and DAG bytes must match, not just ranks.
"""
import argparse
import hashlib
import json
from pathlib import Path
import random
import runpy
import struct
import subprocess
import time

ROOT=Path(__file__).resolve().parents[1]
DATA=ROOT.parent/'litt3-computation-data'
OLD_SOURCE=DATA/'atlas-predecessor-b4/chart-23/eliminate.cpp'
OLD_SHA='e809c9cff1d70b37683ddff94ad5ebd9ffbcef4cdb38c7aeb55152d299b42e16'


def mathematical_checkpoint(path):
    data=Path(path).read_bytes()
    assert len(data)>=76
    # Offset56 contains only elapsed double; trailing8 checksum includes it.
    return data[:56]+data[64:-8]


def verify(output):
    output=Path(output);output.mkdir(parents=True,exist_ok=False)
    assert hashlib.sha256(OLD_SOURCE.read_bytes()).hexdigest()==OLD_SHA
    code=runpy.run_path(str(ROOT/'scripts/mixed_atlas_certificate.sage'))['CPP_GENERAL']
    source=output/'parallel.cpp';source.write_text(code)
    binaries={}
    for name,cpp in [('old',OLD_SOURCE),('new',source)]:
        binary=output/name
        subprocess.run(['c++','-O3','-std=c++17','-pthread',str(cpp),'-o',str(binary)],check=True)
        binaries[name]=binary
    rng=random.Random(2532)
    raw=output/'raw.bin';nr,nc=160,180
    with raw.open('wb') as stream:
        stream.write(struct.pack('<II',nr,nc))
        for row in range(nr):
            values=[rng.randrange(25) if rng.random()<.35 else 0 for _ in range(nc)]
            if row%11==0:values=[0]*nc
            if row==nr-1:values=[0]*(nc-1)+[1]
            pairs=[(c,v) for c,v in enumerate(values) if v]
            stream.write(struct.pack('<I',len(pairs)))
            stream.write(struct.pack('<'+'I'*len(pairs),*(c for c,v in pairs)))
            stream.write(bytes(v for c,v in pairs))
    def invoke(name,binary,matrix,boundary,pred='',threads=1,maxrows=2**32-1):
        folder=output/name;folder.mkdir(exist_ok=True)
        cmd=[str(binary),str(matrix),str(folder/'dag.bin'),str(folder/'weights.bin'),
             '120',str(512*1024**2),str(folder/'state.cp'),str(boundary),'10000',str(maxrows),
             '-1','',name,'{}',str(pred),str(threads),'0']
        result=subprocess.run(cmd,check=True,capture_output=True,text=True,timeout=125)
        return folder,json.loads(result.stdout)
    def equal(a,b):
        assert mathematical_checkpoint(a/'state.cp')==mathematical_checkpoint(b/'state.cp'),(a,b,'checkpoint')
        for name in ['dag.bin','weights.bin','weights.bin.relation','state.cp.pure_b.bin']:
            aa,bb=a/name,b/name
            assert aa.exists()==bb.exists(),(name,'missing')
            if aa.exists():assert aa.read_bytes()==bb.read_bytes(),(a,b,name)
    results=[]
    cases=[('random',raw,nc-1,''),
        ('actual28',DATA/'atlas-predecessor-tests/chart-28/matrix.bin',320,
         DATA/'atlas-predecessor-tests/chart-28/predecessor.bin'),
        ('zero_descendants',DATA/'atlas-predecessor-tests/zero-descendant/matrix.bin',2,
         DATA/'atlas-predecessor-tests/zero-descendant/predecessor.bin')]
    for label,matrix,boundary,pred in cases:
        old,oldresult=invoke(label+'-old',binaries['old'],matrix,boundary,pred)
        for threads in [1,10]:
            new,result=invoke(label+f'-new{threads}',binaries['new'],matrix,boundary,pred,threads)
            equal(old,new)
            assert result['native_threads']==threads
            results.append(dict(case=label,threads=threads,exact_checkpoint_and_dag=True,
                                status=result['status'],rows=result['rows_processed']))
        # Commit only a prefix with the old engine, then resume with10 workers.
        resumed,_=invoke(label+'-migration',binaries['old'],matrix,boundary,pred,maxrows=2)
        resumed,result=invoke(label+'-migration',binaries['new'],matrix,boundary,pred,threads=10,maxrows=37)
        serialprefix,_=invoke(label+'-prefix',binaries['old'],matrix,boundary,pred,maxrows=39)
        equal(resumed,serialprefix)
        resumed,result=invoke(label+'-migration',binaries['new'],matrix,boundary,pred,threads=10)
        equal(old,resumed)
        results.append(dict(case=label,old_checkpoint_parallel_resume=True,exact_intermediate_prefix=True))
        print(label,'PASS',flush=True)
    report=dict(status='PASS',serial_engine_sha256=OLD_SHA,
        parallel_engine_sha256=hashlib.sha256(code.encode()).hexdigest(),tests=results)
    (output/'verification.json').write_text(json.dumps(report,indent=2)+'\n')
    return report


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--output',required=True)
    args=parser.parse_args();verify(args.output)
