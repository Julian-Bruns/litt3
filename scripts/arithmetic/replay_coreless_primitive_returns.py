#!/usr/bin/env python3
"""Replay one returned certificate suite in an external working directory."""
import argparse
import json
import os
from pathlib import Path
import platform
import shutil
import subprocess
import sys


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('suite',choices=['recognition','rank3','plane'])
    parser.add_argument('--output',type=Path,required=True)
    args=parser.parse_args()
    repo=Path(__file__).resolve().parents[2]
    out=args.output.resolve()
    if out.is_relative_to(repo):
        raise SystemExit('Generated artifacts must be outside the research workspace.')
    if out.exists():
        raise SystemExit('Use a fresh output directory; existing evidence is retained.')
    src=Path(__file__).resolve().parent/'pro_coreless_20260923'/args.suite
    shutil.copytree(src,out,ignore=shutil.ignore_patterns('__pycache__','*.pyc'))
    env=os.environ.copy()
    if args.suite=='recognition':
        inc=out/'compiler_include'/'bits'
        inc.mkdir(parents=True)
        headers=['algorithm','array','cassert','cstdint','iostream','map','random','set',
                 'stdexcept','string','utility','vector']
        (inc/'stdc++.h').write_text(''.join('#include <'+h+'>\n' for h in headers))
        env['CPLUS_INCLUDE_PATH']=str(inc.parent)
        if platform.system()=='Darwin':
            env['DEVELOPER_DIR']='/Applications/Xcode.app/Contents/Developer'
        (out/'certificates'/'data').mkdir(exist_ok=True)
        command=[sys.executable,str(out/'run_all.py')]
    elif args.suite=='rank3':
        command=[sys.executable,str(out/'verify_all.py')]
    else:
        command=[sys.executable,str(out/'certificates'/'verify_all.py'),'--json',str(out/'results.json')]
    result=subprocess.run(command,cwd=out,env=env,text=True,capture_output=True)
    (out/'replay.stdout').write_text(result.stdout)
    (out/'replay.stderr').write_text(result.stderr)
    (out/'replay_receipt.json').write_text(json.dumps({'suite':args.suite,'command':command,
        'returncode':result.returncode,'python':platform.python_version(),
        'scope':'Exact certificate replay; no unrestricted existence decision.'},indent=2)+'\n')
    print(result.stdout,end='')
    if result.stderr: print(result.stderr,end='',file=sys.stderr)
    raise SystemExit(result.returncode)


if __name__=='__main__':
    main()
