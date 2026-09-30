#!/usr/bin/env sage
"""Remove the certified first-negative-quotient scroll from a module support.

The input is the exact block and its retained standard basis produced by
pure_v_quotient_support.sage. Saturation removes components supported on the
whole scroll. It does not impose the full return or determinant equations.
"""
from sage.all import singular, version
from pathlib import Path
import argparse, json, time

ap=argparse.ArgumentParser()
ap.add_argument('--input',type=Path,required=True)
ap.add_argument('--output',type=Path,required=True)
args=ap.parse_args()
args.output.mkdir(parents=True,exist_ok=True)
start=time.monotonic()
singular.eval((args.input/'input.sing').read_text())
singular.eval((args.input/'basis.sing').read_text())
singular.eval('attrib(G,"isSB",1); LIB "elim.lib";')
quadrics='z0*z2-z1^2,z0*z4-z1*z3,z0*z5-z1*z4,z1*z4-z2*z3,z1*z5-z2*z4,z3*z5-z4^2'
singular.eval('ideal I='+quadrics+';')
print('Saturating the full transpose-image module by the scroll ideal',flush=True)
singular.eval('module H=sat(G,I);')
print('Saturation finished',round(time.monotonic()-start,3),flush=True)
path=(args.output/'saturated.sing').resolve()
if path.exists(): path.unlink()
singular.eval('write("%s","module H="+string(H)+";");'%path)
out=singular.eval('size(H); dim(H); vdim(H); hilb(H,1);')
(args.output/'invariants.txt').write_text(out+'\n')
print(out,flush=True)
result={'operation':'transpose-image module saturated by the six scroll quadrics',
        'interpretation':'Residual quotient-morphism support, not a strict-return decision',
        'seconds':time.monotonic()-start,'sage_version':version()}
(args.output/'result.json').write_text(json.dumps(result,indent=2)+'\n')
