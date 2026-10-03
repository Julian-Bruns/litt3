#!/usr/bin/env python3
"""Retain a fingerprint/prefix of a bounded UNKNOWN proof, remove its bulk."""
import argparse, hashlib, json
from pathlib import Path


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--directory',required=True,type=Path)
    args=ap.parse_args();out=args.directory
    result=json.loads((out/'solve_result.json').read_text())
    assert result['status']=='UNKNOWN; no incidence decision'
    proof=out/'unsat.drat';assert proof.exists()
    digest=hashlib.sha256();size=0;header=b''
    with proof.open('rb') as stream:
        while True:
            chunk=stream.read(1024**2)
            if not chunk:break
            if not header:header=chunk[:4096]
            digest.update(chunk);size+=len(chunk)
    assert size==result['proof_bytes']
    prefix=out/'partial_proof_prefix.bin';prefix.write_bytes(header)
    disposition=dict(status='incomplete UNKNOWN bulk proof removed',original_bytes=size,
                     original_sha256=digest.hexdigest(),prefix_file=prefix.name,
                     prefix_bytes=len(header),prefix_sha256=hashlib.sha256(header).hexdigest(),
                     useful_records_retained=['genuine.cnf','result.json','decode.json','solver.log',
                                              'solve_result.json','solve_checkpoint.json'],
                     proof_verified=False,scope='no SAT/UNSAT or incidence decision')
    (out/'partial_proof_disposition.json').write_text(json.dumps(disposition,indent=2)+'\n')
    proof.unlink();print(json.dumps(disposition))


if __name__=='__main__':main()
