#!/usr/bin/env python3
"""Check the L!=0 consequence of the frozen complete A=0 traversal."""
import hashlib,json
from pathlib import Path


def main():
    directory=Path(__file__).resolve().parents[3]/'litt3-computation-data/oct01_local_continuation/mixed/direction_boundary_all'
    state=json.loads((directory/'checkpoint.json').read_text())
    assert state['status']=='complete' and state['next_index']==602667
    source=Path(__file__).resolve().parent
    for name,want in state['script_hashes'].items():assert hashlib.sha256((source/name).read_bytes()).hexdigest()==want
    integrity=json.loads((directory/'integrity.json').read_text());assert integrity['status']=='PASS'
    cursor=0;events=0;sources=0
    for record in integrity['chunk_manifest']:
        raw=(directory/record['file']).read_bytes();assert hashlib.sha256(raw).hexdigest()==record['sha256']
        chunk=json.loads(raw);assert chunk['begin']==cursor
        cursor=chunk['end'];sources+=chunk['counts']['sources']
        events+=chunk['counts'].get('linear_boundary_empty',0)
    assert cursor==sources==602667 and events==0
    assert state['counters'].get('linear_boundary_empty',0)==0
    result=dict(status='PASS',source_count=sources,chunks=len(integrity['chunk_manifest']),
        linear_boundary_empty_events=events,frozen_script_hashes=state['script_hashes'],
        checkpoint_sha256=hashlib.sha256((directory/'checkpoint.json').read_bytes()).hexdigest(),
        integrity_sha256=hashlib.sha256((directory/'integrity.json').read_bytes()).hexdigest(),
        scope='record/provenance check only; mathematical finite-field computation not repeated',
        implication='frozen build_boundary returns empty_stage iff source L=0; frozen scanner counts exactly those events')
    path=directory.parent/'source_linear_boundary_records.json';path.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result))


if __name__=='__main__':main()
