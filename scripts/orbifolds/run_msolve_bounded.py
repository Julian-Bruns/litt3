#!/usr/bin/env python3
"""Run a native exact solver with explicit wall-time and RSS bounds."""
from pathlib import Path
import argparse
import hashlib
import json
import os
import signal
import subprocess
import time


def main():
    ap=argparse.ArgumentParser()
    ap.add_argument('directory',type=Path)
    ap.add_argument('--seconds',type=int,default=900)
    ap.add_argument('--threads',type=int,default=4)
    ap.add_argument('--memory-gib',type=int,default=8)
    ap.add_argument('--saturation',action='store_true')
    ap.add_argument('--executable',default='msolve')
    ap.add_argument('--projected',action='store_true')
    a=ap.parse_args();root=a.directory.resolve()
    input_file=root/('saturation.ms' if a.saturation else 'linear.ms')
    output_file=root/('basis.ms' if a.saturation else 'parametrization.ms')
    options=['-S','-g','2'] if a.saturation else ['-P','2','-c','0']
    command=[a.executable]+options+['-t',str(a.threads),'-v','2',
        '-f',str(input_file),'-o',str(output_file)]
    environment=os.environ.copy()
    if a.projected:environment['MSOLVE_PROJECTED_DUMP']=str(root/'projected.ms')
    started=time.monotonic();peak=0;reason='completed'
    with (root/'native_output.txt').open('w') as out,(root/'native_stderr.txt').open('w') as err:
        process=subprocess.Popen(command,stdout=out,stderr=err,start_new_session=True,env=environment)
        print('PID',process.pid,'bounded at',a.seconds,'seconds and',a.memory_gib,'GiB RSS',flush=True)
        while process.poll() is None:
            time.sleep(1)
            raw=subprocess.run(['ps','-o','rss=','-p',str(process.pid)],
                capture_output=True,text=True).stdout.strip()
            peak=max(peak,int(raw or 0))
            elapsed=time.monotonic()-started
            if elapsed>a.seconds or peak>a.memory_gib*1024*1024:
                reason='timeout' if elapsed>a.seconds else 'memory_bound'
                os.killpg(process.pid,signal.SIGTERM);process.wait();break
        if process.returncode<0 and reason=='completed':reason='external_stop'
        if process.returncode==86 and a.projected:reason='projected_candidates_require_exact_verification'
    receipt={'command':command,'status':reason,'exit_code':process.returncode,
             'seconds':time.monotonic()-started,'peak_rss_kib':peak,
             'input_sha256':hashlib.sha256(input_file.read_bytes()).hexdigest(),
             'solver_version':subprocess.run([a.executable,'-V'],capture_output=True,text=True).stdout.strip(),
             'projected':a.projected}
    if Path(a.executable).is_file():receipt['executable_sha256']=hashlib.sha256(Path(a.executable).read_bytes()).hexdigest()
    (root/'native_receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
    print(json.dumps(receipt),flush=True)


if __name__=='__main__':main()
