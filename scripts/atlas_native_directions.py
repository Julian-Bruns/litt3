"""Exact compact-atlas blocks in a verified native coefficient-field model.

The original KU/K40/Bc coordinates and all56 raw R rows are returned unchanged.
Polynomial Wronskians are checked against their full fifth-power expansions.
"""
import json,time
from atlas_native_rref import NativeRref
from atlas_residue_projection import ResidueProjection
from atlas_series import coefficients


class NativeDirections:
    def __init__(self,data,KU,K40,Qc,Bc,Iproj,D,curve_power,piv5,
                 curve_inverse5,curve_expansions,monsU,mons192,mons320):
        from sage.all import matrix,PolynomialRing
        self.original_field=data['k']; self.matrix=matrix
        def layers(k,d):
            if d['kind']=='finite_field': return [(k,d)]
            return layers(k.base_ring(),d['base'])+[(k,d)]
        self.bridge=NativeRref(data['k'],layers(data['k'],data['field_description']))
        self.field=self.bridge.native_field; self.native=NativeRref(self.field)
        self.a=self.bridge.to_native(data['a']); self.R=PolynomialRing(self.field,'x'); self.x=self.R.gen()
        self.F=self.R([self.bridge.to_native(c) for c in data['F'].list()]); self.Fp=self.F.derivative()
        self.monsU=monsU; self.mons192=mons192; self.mons320=mons320; self.piv5=list(piv5)
        self.KU=self.flatten(KU); self.T40=[self.poly(row,mons192) for row in self.flatten(K40).rows()]
        self.dT40=[self.delta(v) for v in self.T40]
        self.Nprojection=self.flatten(Qc.transpose()).apply_map(lambda c:c**5)
        self.Bc5=self.flatten(Bc).apply_map(lambda c:c**5)
        self.Dbc5=self.flatten(D*Bc).apply_map(lambda c:c**5); self.Iproj=self.flatten(Iproj)
        self.curve_power=curve_power; self.curve_inverse5=curve_inverse5
        gaps=[1,2,4,5,7,8,11,14,17]
        domain=[-g for g in gaps]+list(range(1,32)); target=[-g for g in gaps]+list(range(1,48))
        self.projection=ResidueProjection(curve_expansions,domain,target)
        curve_field=self.projection.field
        self.curveU=matrix(curve_field,[coefficients(curve_expansions[m],self.projection.u_exponents)
                                      for m in monsU]).transpose()

    def flatten(self,M):
        return self.matrix(self.field,M.nrows(),M.ncols(),
            [self.bridge.to_native(c) for c in M.list()],implementation='generic')

    def restore(self,M):
        return self.matrix(self.original_field,M.nrows(),M.ncols(),
            [self.bridge.from_native(c) for c in M.list()])

    def base_multiply(self,A,B): return self.native.multiply(A,B,base_generator=self.a)

    def poly(self,v,mons):
        # One coefficient-list constructor per polynomial, no repeated sums.
        components=[{} for _ in range(3)]
        for c,(i,j) in zip(v,mons):
            if c: components[j][i]=c
        return tuple(self.R(d) for d in components)

    def delta(self,v):
        ans=[self.R.zero() for _ in range(3)]
        for j,f in enumerate(v):
            ans[(j+2)%3]+=f.derivative()*self.F**((j+2)//3)
            if j: ans[j-1]+=2*j*f*self.Fp
        return tuple(ans)

    def mul(self,v,w):
        ans=[self.R.zero() for _ in range(3)]
        for j,f in enumerate(v):
            for h,g in enumerate(w): ans[(j+h)%3]+=f*g*self.F**((j+h)//3)
        return tuple(ans)

    def direction(self,i):
        started=time.monotonic(); uv=self.KU.row(i); up=self.poly(uv,self.monsU); du=self.delta(up)
        wh=[tuple(a-b for a,b in zip(self.mul(up,dt),self.mul(tp,du)))
            for tp,dt in zip(self.T40,self.dT40)]
        wc=self.matrix(self.field,[[v[j][h] for h,j in self.mons320] for v in wh],implementation='generic').transpose()
        assert all(self.poly(wc.column(h),self.mons320)==wh[h] for h in range(64))
        coords=self.base_multiply(self.curve_inverse5,wc.matrix_from_rows(self.piv5))
        assert self.base_multiply(self.curve_power,coords)==wc
        Nc=self.native.multiply(coords.transpose(),self.Nprojection)
        n_seconds=time.monotonic()-started
        U=self.base_multiply(self.curveU,self.matrix(self.field,len(uv),1,list(uv),implementation='generic')).column(0)
        raw=self.projection.raw(U,self.Bc5,self.Dbc5,None,
            multiply=self.native.multiply,base_multiply=self.base_multiply)
        compact=self.native.multiply(self.Iproj,raw)
        r_seconds=time.monotonic()-started-n_seconds
        answer=tuple(self.restore(M) for M in (Nc,compact,raw))
        print(json.dumps(dict(direction=int(i),backend='native_field_fixed_curve_projection',
            N_seconds=n_seconds,R_seconds=r_seconds,
            restore_seconds=time.monotonic()-started-n_seconds-r_seconds,
            total_seconds=time.monotonic()-started)),flush=True)
        return answer

    def coupled_R_certificate(self,tensors,Bc):
        """Explicit defect=H*N witness, stronger than comparing two ranks."""
        from sage.all import block_matrix
        started=time.monotonic()
        NN=block_matrix(self.field,1,32,[self.flatten(entry[0]) for entry in tensors])
        RR=block_matrix(self.field,1,32,[self.flatten(entry[2]) for entry in tensors])
        identity=self.matrix(self.field,56,56,[1 if i==j else 0
            for i in range(56) for j in range(56)],implementation='generic')
        defect=self.native.multiply(identity-self.native.multiply(self.flatten(Bc),self.Iproj),RR)
        A,C=self.native.rref(NN)
        pivots=[next(j for j,c in enumerate(row) if c) for row in A.rows()]
        assert pivots==sorted(set(pivots))
        weights=defect.matrix_from_columns(pivots)
        assert self.native.multiply(weights,A)==defect
        witness=self.native.multiply(weights,C)
        assert self.native.multiply(witness,NN)==defect
        print(json.dumps(dict(stage='full_coupled_R_original_row_witness',
            N_rank=A.nrows(),defect_rows=56,columns=NN.ncols(),
            seconds=time.monotonic()-started,exact_identity_verified=True)),flush=True)
        return self.restore(witness)
