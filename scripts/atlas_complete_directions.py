"""Whole-direction FLINT arithmetic with one shared coefficient-field context.

The binary contains the ORIGINAL KU/K40/Qc/Bc/Iproj coordinates in a
verified field model. All fixed-curve operations remain over F25. The
output is decoded back to the original field, including all 56 raw R rows.
The inherited coupled-R proof supplies an exact original-row witness.
"""
import hashlib
import json
from pathlib import Path
import struct
import subprocess
import tempfile
import time

from atlas_native_directions import NativeDirections
from atlas_native_rref import NativeRref,compile_engine
from atlas_residue_projection import ResidueProjection
from atlas_series import coefficients


class CompleteNativeDirections(NativeDirections):
    def __init__(self,data,KU,K40,Qc,Bc,Iproj,D,curve_power,piv5,
                 curve_inverse5,curve_expansions,monsU,mons192,mons320,
                 cache_directory=None):
        from sage.all import matrix
        started=time.monotonic()
        self.original_field=data['k'];self.matrix=matrix
        def layers(k,d):
            if d['kind']=='finite_field':return [(k,d)]
            return layers(k.base_ring(),d['base'])+[(k,d)]
        self.bridge=NativeRref(data['k'],layers(data['k'],data['field_description']))
        self.field=self.bridge.native_field;self.native=NativeRref(self.field)
        self.a=self.bridge.to_native(data['a'])
        self.Iproj=self.flatten(Iproj)
        self.direction_engine=compile_engine(Path(__file__).with_name('atlas_direction_kernel.cpp'))
        expected=lambda n:sorted([(i,j) for j in range(3) for i in range(n//3+1)
            if 3*i+10*j<=n],key=lambda m:3*m[0]+10*m[1])
        assert all(list(actual)==expected(n) for actual,n in
                   [(monsU,112),(mons192,192),(mons320,320)])
        curve_field=curve_power.base_ring();curve_a=curve_field.gen()
        assert list(curve_field.modulus())==[2,4,1]
        def embed(c):
            return sum((data['k'](v)*data['a']**i
                        for i,v in enumerate(c.polynomial().list())),data['k'].zero())
        f0=[1,2,3,0,4,0,0,1,4,2,1];f1=[2,4,3,1,3,4,3,3,1,4,0]
        assert data['F'].list()==[embed(curve_field(c0)+c1*curve_a)
                                for c0,c1 in zip(f0,f1)]
        inverse_embedding={embed(c):c for c in curve_field}
        if D.base_ring()!=curve_field:
            D=matrix(curve_field,D.nrows(),D.ncols(),[inverse_embedding[c] for c in D.list()])
        gaps=[1,2,4,5,7,8,11,14,17]
        projection=ResidueProjection(curve_expansions,
            [-g for g in gaps]+list(range(1,32)),[-g for g in gaps]+list(range(1,48)))
        curveU=matrix(curve_field,[coefficients(curve_expansions[m],projection.u_exponents)
                                  for m in monsU]).transpose()
        generic=[KU,K40,Qc.transpose(),Bc,Iproj]
        base=[D,curve_power,curve_inverse5,curveU,projection.rho,projection.twice]
        assert [tuple(M.dimensions()) for M in generic]==[(32,104),(64,184),(56,32),(56,32),(32,56)]
        assert [tuple(M.dimensions()) for M in base]==[(40,56),(312,56),(56,56),(330,104),(56,330),(56,330)]
        assert list(piv5)==sorted(set(piv5)) and len(piv5)==56
        # The full fifth-power left-inverse identity is checked before packing.
        assert curve_inverse5*curve_power.matrix_from_rows(piv5)==matrix.identity(curve_field,56)
        if cache_directory is None:
            self._temporary=tempfile.TemporaryDirectory(prefix='atlas-complete-directions-')
            folder=Path(self._temporary.name)
        else:
            folder=Path(cache_directory);folder.mkdir(parents=True,exist_ok=True)
        self.cache_directory=folder
        temporary=folder/'direction-input.bin.tmp'
        with temporary.open('wb') as stream:
            stream.write(struct.pack('<QI',0x41544c4449523031,self.bridge.degree))
            stream.write(self.bridge.modulus)
            a=self.bridge.encode(data['a']);stream.write(struct.pack('<I',len(a)));stream.write(a)
            for M in generic:self.bridge._write_matrix(stream,M)
            for M in base:
                assert M.base_ring()==curve_field
                for row in M.rows():
                    for c in row:
                        values=c.polynomial().list()+[0,0]
                        stream.write(bytes((int(values[0]),int(values[1]))))
            stream.write(struct.pack('<'+'I'*56,*map(int,piv5)))
        self.input_sha256=hashlib.sha256(temporary.read_bytes()).hexdigest()
        self.source=folder/('direction-input-'+self.input_sha256+'.bin')
        if self.source.exists():
            assert hashlib.sha256(self.source.read_bytes()).hexdigest()==self.input_sha256
            temporary.unlink()  # Our redundant, fully identified temporary only.
        else:temporary.replace(self.source)
        self.setup=dict(backend='FLINT_complete_original_direction',
            degree_F5=self.bridge.degree,field_model=self.bridge.field_model,
            input_bytes=self.source.stat().st_size,input_sha256=self.input_sha256,
            setup_seconds=time.monotonic()-started)
        print(json.dumps(self.setup),flush=True)

    def direction(self,i):
        started=time.monotonic()
        with tempfile.TemporaryDirectory(prefix='atlas-complete-direction-output-') as td:
            final=self.cache_directory/('block-%02d-%s.bin'%(i,self.input_sha256))
            meta=final.with_suffix('.json')
            if final.exists() and meta.exists():
                record=json.loads(meta.read_text())
                assert record['input_sha256']==self.input_sha256 and record['direction']==i
                assert record['binary_sha256']==hashlib.sha256(final.read_bytes()).hexdigest()
                target=final;record=dict(record,resumed_native_binary=True)
            else:
                target=Path(td)/'output.bin'
                proc=subprocess.run([str(self.direction_engine),str(self.source),str(int(i)),str(target)],
                                    check=True,capture_output=True,text=True)
                record=json.loads(proc.stdout)
            with target.open('rb') as stream:
                magic,degree=struct.unpack('<QI',stream.read(12))
                assert (magic,degree)==(0x41544c4449524f31,self.bridge.degree)
                result=[]
                for rows,cols in [(64,32),(32,32),(56,32)]:
                    assert struct.unpack('<II',stream.read(8))==(rows,cols)
                    values=[]
                    for _ in range(rows*cols):
                        length=struct.unpack('<I',stream.read(4))[0]
                        assert length<=degree
                        value=stream.read(length)
                        assert len(value)==length and all(c<5 for c in value)
                        values.append(self.bridge.decode(value))
                    result.append(self.matrix(self.original_field,rows,cols,values))
                assert not stream.read(1)
            record.update(bridge_total_seconds=time.monotonic()-started,
                          input_sha256=self.input_sha256)
            if target!=final:
                digest=hashlib.sha256(target.read_bytes()).hexdigest()
                if final.exists():assert hashlib.sha256(final.read_bytes()).hexdigest()==digest
                else:target.replace(final)
                record['binary_sha256']=digest
                temporary=meta.with_suffix('.json.tmp')
                temporary.write_text(json.dumps(record)+'\n');temporary.replace(meta)
            self.last_record=record
            print(json.dumps(record),flush=True)
            return tuple(result)

    def bind_checkpoint(self,i,original):
        """Tie the verified native bytes to their decoded original coordinates."""
        binary=self.cache_directory/('block-%02d-%s.bin'%(i,self.input_sha256))
        metadata=json.loads(binary.with_suffix('.json').read_text())
        assert metadata['binary_sha256']==hashlib.sha256(binary.read_bytes()).hexdigest()
        binding=dict(schema=1,direction=int(i),binary=str(binary.resolve()),
            native_modulus=list(self.bridge.modulus),input_sha256=self.input_sha256,
            binary_sha256=metadata['binary_sha256'],
            original_path=str(Path(original).resolve()),
            original_sha256=hashlib.sha256(Path(original).read_bytes()).hexdigest())
        target=self.cache_directory/('binding-%02d.json'%i);temporary=target.with_suffix('.json.tmp')
        temporary.write_text(json.dumps(binding)+'\n');temporary.replace(target)
