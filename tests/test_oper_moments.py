from pathlib import Path
import json
import platform
import struct
import subprocess
import tempfile
import unittest

SOURCE=Path(__file__).resolve().parents[1]/'scripts/oper_moments.c'


@unittest.skipUnless(platform.system()=='Darwin' and platform.machine()=='arm64','Apple ARM integer SIMD')
class MomentTests(unittest.TestCase):
    def test_all_moments_against_integer_reference(self):
        with tempfile.TemporaryDirectory() as folder:
            base=Path(folder)/'probe';exe=Path(folder)/'moments';d=67;length=160
            subprocess.run(['cc','-O3','-march=armv8.2-a+dotprod','-Xpreprocessor','-fopenmp',
                '-I/opt/homebrew/opt/libomp/include',str(SOURCE),'-L/opt/homebrew/opt/libomp/lib','-lomp','-o',str(exe)],check=True)
            # Companion operator of t^67 = 1+2t+4t^33, plus named coordinates.
            row=bytearray(d);row[0]=1;row[1]=2;row[33]=4
            Path(str(base)+'.u8').write_bytes(row)
            mapping=list(range(1,d))+[-1]
            Path(str(base)+'.map.i32').write_bytes(struct.pack('<'+'i'*d,*mapping))
            coords=list(range(15));coords[13]=1
            Path(str(base)+'.meta').write_text(f'{d} 1 13 0\n'+' '.join(map(str,coords))+'\n')
            subprocess.run([str(exe),str(base),str(length),'2'],check=True,capture_output=True)
            seed=0x719eb231da4916f5;mask=(1<<64)-1;v=[]
            for _ in range(d):
                seed^=(seed<<13)&mask;seed^=seed>>7;seed^=(seed<<17)&mask;v.append(seed%5)
            expected=[[] for _ in range(16)]
            for _ in range(length):
                expected[0].append(v[0])
                for i,c in enumerate(coords):expected[i+1].append(v[c])
                v=v[1:]+[sum(a*b for a,b in zip(row,v))%5]
            actual=Path(str(base)+'.moments.u8').read_bytes()
            self.assertEqual(actual,bytes(sum(expected,[])))
            meta=json.loads(Path(str(base)+'.moments.json').read_text())
            self.assertEqual(meta['binary_file'],'probe.moments.u8')


if __name__=='__main__':unittest.main()
