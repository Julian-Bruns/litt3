#!/usr/bin/env python3
"""Checkpointed single-core exact census over verified coefficient-conjugacy orbits."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import time


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--orbits',required=True)
    ap.add_argument('--output-directory',required=True)
    ap.add_argument('--max-seconds',type=int,default=7200)
    args=ap.parse_args()
    root=Path(__file__).resolve().parents[2]
    orbit_path=Path(args.orbits).resolve()
    orbits=json.loads(orbit_path.read_text())
    assert orbits['status']=='PASS' and orbits['cover_count']==155
    assert sorted(v[0]*5+v[1] for o in orbits['orbits'] for v in o)==list(range(155))
    output=Path(args.output_directory).resolve()
    output.mkdir(parents=True,exist_ok=True)
    started=time.monotonic()
    result=dict(status='running',case=orbits['case'],orbit_file=str(orbit_path),
        orbit_sha256=hashlib.sha256(orbit_path.read_bytes()).hexdigest(),
        total_orbits=len(orbits['orbits']),results=[],failures=[])
    def save():
        result['seconds']=time.monotonic()-started
        (output/'summary.json').write_text(json.dumps(result,indent=2)+'\n')
    def run(command,log):
        with log.open('w') as stream:
            subprocess.run(command,cwd=root,stdout=stream,stderr=subprocess.STDOUT,
                           check=True,timeout=240)
    save()
    for number,orbit in enumerate(orbits['orbits']):
        if time.monotonic()-started>=args.max_seconds:
            result['status']='bounded_run_time_limit';break
        plane,central=orbit[0]
        prefix=output/f'plane{plane:02d}_central{central}'
        hodge=prefix.with_name(prefix.name+'_hodge.json')
        deck=prefix.with_name(prefix.name+'_deck.json')
        rank=prefix.with_name(prefix.name+'_rank.json')
        tick=time.monotonic()
        common=['sage','-python','scripts/deformations/backup_heisenberg_defect.py',
                '--case',str(orbits['case']),'--plane',str(plane),
                '--central',str(central),'--field-degree','12','--seconds','180']
        try:
            if not hodge.exists():
                run(common+['--start-column','744','--columns','6','--report-every','6',
                            '--output',str(hodge)],hodge.with_suffix('.log'))
            hs=json.loads(hodge.read_text())
            assert hs['status']=='pilot_complete' and len(hs['columns'])==6
            if not deck.exists():
                run(common+['--deck-generator-columns','--columns','750','--report-every','250',
                            '--output',str(deck)],deck.with_suffix('.log'))
            ds=json.loads(deck.read_text())
            assert ds['status']=='columns_complete' and len(ds['columns'])==750
            if not rank.exists():
                run(['sage','-python','scripts/deformations/rank_heisenberg_free_columns.py',
                     '--deck',str(deck),'--hodge',str(hodge),'--output',str(rank)],
                     rank.with_suffix('.log'))
            receipt=json.loads(rank.read_text())
            assert receipt['status']=='PASS'
            assert (receipt['case'],receipt['plane'],receipt['central'])==(orbits['case'],plane,central)
            row=dict(orbit=number,representative=[plane,central],orbit_size=len(orbit),
                     defect=receipt['defect'],rank=receipt['rank'],rank_file=str(rank),
                     hodge_sha256=hashlib.sha256(hodge.read_bytes()).hexdigest(),
                     deck_sha256=hashlib.sha256(deck.read_bytes()).hexdigest(),
                     rank_sha256=hashlib.sha256(rank.read_bytes()).hexdigest(),
                     seconds=time.monotonic()-tick)
            result['results'].append(row)
            print(json.dumps(row),flush=True)
        except Exception as exc:
            result['failures'].append(dict(orbit=number,representative=[plane,central],
                                          error=repr(exc)))
            print(json.dumps(result['failures'][-1]),flush=True)
        save()
    else:
        result['status']='PASS' if not result['failures'] else 'incomplete_with_failures'
    histogram={}
    for row in result['results']:
        key=str(row['defect']);histogram[key]=histogram.get(key,0)+row['orbit_size']
    result['weighted_defect_histogram']=histogram
    result['scope']='Actual covers of this one bad double; propagation only by recorded coefficient conjugacy.'
    save()
    print(json.dumps({key:result[key] for key in ['status','case','total_orbits',
                     'weighted_defect_histogram','seconds']}),flush=True)


if __name__=='__main__':main()
