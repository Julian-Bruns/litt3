"""Reusable checked coefficient roots; native worker threads do NO Sage work."""
import json
from pathlib import Path
import struct
import subprocess
import time
from atlas_native_rref import compile_engine
from atlas_native_tensor_input import sha


class NativeRoots:
    def __init__(self,field,folder):
        from atlas_field_maps import inverse_frobenius_map
        self.degree=int(field.degree());self.folder=Path(folder)
        self.folder.mkdir(parents=True,exist_ok=True)
        self.engine=compile_engine(Path(__file__).with_name('atlas_frobenius_roots.cpp'))
        gamma=inverse_frobenius_map(field)(field.gen());assert gamma**5==field.gen()
        modulus=bytes(int(c) for c in field.modulus().list())
        coords=bytes(int(c) for c in gamma.polynomial().list())
        value=struct.pack('<QI',0x41544c524f4f4931,self.degree)+modulus+struct.pack('<I',len(coords))+coords
        import hashlib
        self.map_sha256=hashlib.sha256(value).hexdigest()
        self.input=self.folder/('root-map-'+self.map_sha256+'.bin')
        if self.input.exists():assert sha(self.input)==self.map_sha256
        else:
            temporary=self.input.with_suffix('.tmp');temporary.write_bytes(value);temporary.replace(self.input)

    def run(self,binding):
        i=int(binding['direction']);source=Path(binding['binary'])
        assert sha(source)==binding['binary_sha256']
        target=self.folder/('roots-%02d.bin'%i);metadata=target.with_suffix('.json')
        if metadata.exists():
            record=json.loads(metadata.read_text())
            assert record['root_map_sha256']==self.map_sha256
            assert record['source_binary_sha256']==binding['binary_sha256']
            assert record['binary_sha256']==sha(target)
            assert record['all_coefficient_fifth_power_identities_verified']
            return dict(record,resumed_verified_roots=True)
        if target.exists():raise RuntimeError('Root block without completed verification metadata; inspect before retry')
        temporary=target.with_suffix('.tmp');started=time.monotonic()
        completed=subprocess.run([str(self.engine),str(self.input),str(source),str(temporary)],
                                 check=True,text=True,capture_output=True)
        record=json.loads(completed.stdout)
        assert record['degree_F5']==self.degree and record['coefficients']==3072
        assert record['all_coefficient_fifth_power_identities_verified']
        record.update(direction=i,binary=str(target.resolve()),binary_sha256=sha(temporary),
                      source_binary_sha256=binding['binary_sha256'],root_map_sha256=self.map_sha256,
                      wall_seconds=time.monotonic()-started)
        temporary.replace(target)
        pending=metadata.with_suffix('.tmp.json');pending.write_text(json.dumps(record,indent=2)+'\n');pending.replace(metadata)
        return record
