#!/usr/bin/env python3
"""Restartable full projective-orbit moment search; no branch curves are searched."""
from __future__ import annotations
import argparse, concurrent.futures, gzip, hashlib, json, math
from pathlib import Path
import shutil, subprocess, sys
ROOT=Path(__file__).resolve().parents[1]
CHUNK=262144

def digest(p):
    h=hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda:f.read(1024*1024),b''):h.update(b)
    return h.hexdigest()

def run(cmd,log=None):
    if log:
        with log.open('w') as f:subprocess.run(cmd,check=True,stdout=f,stderr=subprocess.STDOUT)
    else:subprocess.run(cmd,check=True)

def restore(p):
    q=Path(str(p)+'.gz')
    if not p.exists() and q.exists():
        tmp=Path(str(p)+'.restore')
        with gzip.open(q,'rb') as f,tmp.open('wb') as g:shutil.copyfileobj(f,g,1024*1024)
        tmp.replace(p)

def compress(p):
    q=Path(str(p)+'.gz');tmp=Path(str(q)+'.tmp')
    with p.open('rb') as f,tmp.open('wb') as raw:
        with gzip.GzipFile(filename='',mode='wb',fileobj=raw,compresslevel=1,mtime=0) as g:shutil.copyfileobj(f,g,1024*1024)
    tmp.replace(q);p.unlink()

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--workdir',type=Path,required=True)
    ap.add_argument('--config',type=Path,default=ROOT/'input/degree15_profiles.json')
    ap.add_argument('--evidence',type=Path,default=ROOT/'evidence/degree15_orbits.json')
    ap.add_argument('--jobs',type=int,default=2)
    ap.add_argument('--record-evidence',action='store_true',help='Write rather than compare exhaustive evidence')
    ap.add_argument('--keep-raw',action='store_true')
    ap.add_argument('--compiler',default='g++')
    args=ap.parse_args()
    if sys.byteorder!='little':raise RuntimeError('Raw streams require little-endian words')
    if args.jobs<1:raise ValueError('jobs must be positive')
    work=args.workdir.resolve();chunks=work/'chunks';binary=work/'bin';logs=work/'logs'
    for d in (chunks,binary,logs):d.mkdir(parents=True,exist_ok=True)
    cfg=json.loads(args.config.read_text());reference=None
    if not args.record_evidence:reference=json.loads(args.evidence.read_text())
    for src in ('search_moment_orbits','audit_merge_orbits'):
        run([args.compiler,'-O3','-std=c++17',str(ROOT/f'src/{src}.cpp'),'-o',str(binary/src)])
    rows=[];results=[]
    def generate(p,k):
        nodes=','.join(f'{e}:{w}' for e,w in p['weighted_nodes']);name=f"{p['id']}.{k:02d}"
        stem=chunks/name;summary=Path(str(stem)+'.json');receipt=Path(str(stem)+'.receipt.json')
        start=k*CHUNK;count=min(CHUNK,1985630-start)
        paths=[Path(str(stem)+f'.{s}.keys') for s in ('left','right')]
        for path in paths:restore(path)
        good=False
        if summary.exists() and receipt.exists() and all(x.exists() for x in paths):
            try:
                row=json.loads(receipt.read_text());actual=json.loads(summary.read_text())
                good=(row['summary']==actual and actual['start']==start and actual['count']==count and actual['nodes']==nodes
                      and all(x.stat().st_size==32*count and digest(x)==row['keys'][s]['sha256'] for s,x in zip(('left','right'),paths)))
            except (KeyError,ValueError,OSError):pass
        if not good:
            temp=Path(str(stem)+'.temporary')
            run([str(binary/'search_moment_orbits'),'--nodes',nodes,'--start',str(start),'--limit',str(CHUNK),'--output',str(temp)],logs/(name+'.generation.log'))
            for suffix in ('.left.keys','.right.keys','.json'):Path(str(temp)+suffix).replace(Path(str(stem)+suffix))
            actual=json.loads(summary.read_text())
            assert actual['start']==start and actual['count']==count and actual['nodes']==nodes
            row={'profile':p['id'],'chunk':k,'summary':actual,'keys':{}}
            for side,path in zip(('left','right'),paths):
                assert path.stat().st_size==32*count
                row['keys'][side]={'filename':path.name,'bytes':path.stat().st_size,'sha256':digest(path)}
            receipt.write_text(json.dumps(row,indent=2)+'\n')
        return row
    def process_profile(p):
        local_rows=[generate(p,k) for k in range(math.ceil(1985630/CHUNK))]
        nodes=','.join(f'{e}:{w}' for e,w in p['weighted_nodes']);output=work/(p['id']+'.audit.json')
        run([str(binary/'audit_merge_orbits'),'--prefix',str(chunks/p['id']),'--nodes',nodes,'--chunks',str(math.ceil(1985630/CHUNK)),'--output',str(output)],logs/(p['id']+'.audit.log'))
        r=json.loads(output.read_text());r['profile']=p['id']
        if not args.keep_raw:
            for row in local_rows:
                for side in ('left','right'):compress(chunks/row['keys'][side]['filename'])
        print(f"AUDITED {p['id']}: records={r['records_audited']} matching_orbit_pairs={r['matching_orbit_pairs']}",flush=True)
        return local_rows,r
    with concurrent.futures.ThreadPoolExecutor(max_workers=args.jobs) as executor:
        tasks=[executor.submit(process_profile,p) for p in cfg['profiles']]
        for task in concurrent.futures.as_completed(tasks):
            rr,r=task.result();rows.extend(rr);results.append(r)
    rows.sort(key=lambda r:(r['profile'],r['chunk']));results.sort(key=lambda r:r['profile'])
    evidence={'scope':'necessary endpoint moments, full geometric labels and scales, not a curve enumeration',
              'degree':cfg['degree'],'chunk_size':CHUNK,'profile_count':len(cfg['profiles']),
              'quartets_per_side':7940751,'orbits_per_side':1985630,'total_records_audited':sum(r['records_audited'] for r in results),
              'all_profiles_moment_empty':all(r['moment_locus_empty'] for r in results),'results':results,'chunks':rows}
    current=work/'complete_evidence.json';current.write_text(json.dumps(evidence,indent=2)+'\n')
    if args.record_evidence:
        args.evidence.parent.mkdir(parents=True,exist_ok=True);args.evidence.write_text(current.read_text())
        print('RECORDED complete evidence',args.evidence,flush=True)
    else:
        if evidence!=reference:raise AssertionError('Full exact evidence differs from archive')
        print('PASS: exhaustive results and all chunk hashes match retained evidence',flush=True)
    if not args.keep_raw:print('Completed raw streams gzip-compressed profile by profile',flush=True)
    print('RESULT', 'all selected degree profiles excluded' if evidence['all_profiles_moment_empty'] else 'moment survivors remain',flush=True)
if __name__=='__main__':main()
