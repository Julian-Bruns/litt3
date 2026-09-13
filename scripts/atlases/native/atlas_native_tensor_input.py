"""Read-only indexed native coefficients of a hash-bound ORIGINAL tensor.

Search may use these already verified direction bytes. Independent unit
replay ALWAYS reconstructs from the original JSON instead. Neither a
nonunit output nor a bounded search failure is an exclusion.
"""
import hashlib
import json
import mmap
from pathlib import Path
import struct


def sha(path):
    digest=hashlib.sha256()
    with Path(path).open('rb') as stream:
        while chunk:=stream.read(8*1024**2):digest.update(chunk)
    return digest.hexdigest()


def cache_path(tensor):return Path(tensor).parent/'native-original-input.json'


class NativeTensorInput:
    def __init__(self,tensor,source_sha256):
        self.header=json.loads(cache_path(tensor).read_text())
        assert self.header['source_sha256']==source_sha256
        assert self.header['source_tensor']==str(Path(tensor).resolve())
        self.rooted=bool(self.header.get('all_native_fifth_roots_verified'))
        if self.rooted:
            assert len(self.header['root_blocks'])==32
            assert all(b['all_coefficient_fifth_power_identities_verified'] for b in self.header['root_blocks'])
        prefix='root_' if self.rooted else ''
        index=Path(self.header[prefix+'index_path']);assert sha(index)==self.header[prefix+'index_sha256']
        self.offsets=index.read_bytes();assert len(self.offsets)==32*96*32*8
        self.files=[];self.maps=[]
        blocks=self.header['root_blocks'] if self.rooted else self.header['blocks']
        for i,binding in enumerate(blocks):
            assert binding['direction']==i
            if self.rooted:assert binding['source_binary_sha256']==self.header['blocks'][i]['binary_sha256']
            binary=Path(binding['binary']);assert sha(binary)==binding['binary_sha256']
            stream=binary.open('rb');mapped=mmap.mmap(stream.fileno(),0,access=mmap.ACCESS_READ)
            magic=0x41544c524f4f5431 if self.rooted else 0x41544c4449524f31
            assert struct.unpack_from('<QI',mapped)==(magic,self.header['field_model']['degree_F5'])
            self.files.append(stream);self.maps.append(mapped)

    def coefficient(self,key,i,r,h):
        row=r if key=='N_tensor' else r+64
        assert key in ('N_tensor','R_tensor') and 0<=i<32 and 0<=h<32
        assert 0<=r<(64 if key=='N_tensor' else 32)
        offset=struct.unpack_from('<Q',self.offsets,((i*96+row)*32+h)*8)[0]
        mapped=self.maps[i];length=struct.unpack_from('<I',mapped,offset)[0]
        assert length<=self.header['field_model']['degree_F5']
        value=mapped[offset+4:offset+4+length]
        assert len(value)==length and all(c<5 for c in value)
        return value

    def close(self):
        for mapped in self.maps:mapped.close()
        for stream in self.files:stream.close()
        self.maps=[];self.files=[]
