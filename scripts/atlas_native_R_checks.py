"""Hash-bound complete R-block checks; worker threads perform NO Sage work."""
import hashlib
import json
from pathlib import Path
import struct
import subprocess
import time
from atlas_native_rref import NativeRref,compile_engine


def sha(path):return hashlib.sha256(Path(path).read_bytes()).hexdigest()


class NativeRChecks:
    def __init__(self,H,B,I,folder):
        assert [tuple(M.dimensions()) for M in (H,B,I)]==[(56,64),(56,32),(32,56)]
        assert H.base_ring()==B.base_ring()==I.base_ring()
        self.native=NativeRref(H.base_ring());self.modulus=self.native.modulus
        self.degree=self.native.degree
        self.engine=compile_engine(Path(__file__).with_name('atlas_R_check.cpp'))
        self.folder=Path(folder);self.folder.mkdir(parents=True,exist_ok=True)
        temporary=self.folder/'native-R-input.tmp.bin'
        with temporary.open('wb') as stream:
            stream.write(struct.pack('<QI',0x41544c5257493031,self.degree));stream.write(self.modulus)
            for M in (H,B,I):self.native._write_matrix(stream,M)
        self.input_sha256=sha(temporary)
        self.source=self.folder/('native-R-input-'+self.input_sha256+'.bin')
        if self.source.exists():
            assert sha(self.source)==self.input_sha256;temporary.unlink()
        else:temporary.replace(self.source)

    def run(self,binary):
        before=time.monotonic()
        completed=subprocess.run([str(self.engine),str(self.source),str(binary)],
                                 check=True,text=True,capture_output=True)
        result=json.loads(completed.stdout)
        assert result['degree_F5']==self.degree and result['raw_R_rows']==56
        assert result['compact_projection_identity_verified'] is True
        result.update(native_witness_sha256=self.input_sha256,
                      wall_seconds=time.monotonic()-before)
        return result

    def check_bound(self,path,index,original_sha256):
        """No CAS access here: safe in a stdlib ThreadPoolExecutor worker."""
        path=Path(path);assert sha(path)==original_sha256
        binding=path.parent/'complete_native'/('binding-%02d.json'%index)
        b=json.loads(binding.read_text());binary=Path(b['binary'])
        assert b['direction']==index and b['original_sha256']==original_sha256
        assert b['original_path']==str(path.resolve())
        assert bytes(b['native_modulus'])==self.modulus and sha(binary)==b['binary_sha256']
        return self.run(binary)

    def pack_test_block(self,path,matrices):
        # Test-only writer, always called on the main Sage thread.
        assert [tuple(M.dimensions()) for M in matrices]==[(64,32),(32,32),(56,32)]
        with Path(path).open('wb') as stream:
            stream.write(struct.pack('<QI',0x41544c4449524f31,self.degree))
            for M in matrices:
                stream.write(struct.pack('<II',int(M.nrows()),int(M.ncols())))
                for c in M.list():
                    value=self.native.encode(c);stream.write(struct.pack('<I',len(value)));stream.write(value)
