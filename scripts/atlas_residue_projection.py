"""Exact fixed-curve replacement for the two compact-atlas Laurent remainders.

All operators are over F25 and commute with EVERY coefficient-field extension.
The full 56-row residual is retained. No oper acyclicity/rank assumption enters.
"""
from atlas_series import coefficients


class ResidueProjection:
    def __init__(self,expansions,domain,target):
        from sage.all import matrix,identity_matrix
        self.domain=list(domain); self.target=list(target)
        self.lower=-197; self.upper=132; self.shift=85
        self.exponents=list(range(self.lower,self.upper+1)); size=len(self.exponents)
        self.index={e:i for i,e in enumerate(self.exponents)}
        self.field=next(iter(expansions.values())).parent().base_ring()
        self.monomials=sorted(expansions,key=lambda m:3*m[0]+10*m[1],reverse=True)
        poles=[3*i+10*j for i,j in self.monomials]
        assert len(poles)==len(set(poles)) and min(poles)==0 and max(poles)==197
        X=matrix(self.field,[coefficients(expansions[m],self.exponents)
                             for m in self.monomials]).transpose()
        pivots=[self.index[-p] for p in poles]
        H=X.matrix_from_rows(pivots)
        assert all(H[i,i]==1 and all(H[i,j]==0 for j in range(i+1,H.ncols()))
                   for i in range(H.nrows()))
        selector=matrix(self.field,len(pivots),size)
        for i,j in enumerate(pivots): selector[i,j]=1
        self.remainder=identity_matrix(self.field,size)-X*H.inverse()*selector
        assert self.remainder*X==0 and self.remainder*self.remainder==self.remainder
        # After affine reduction every negative pole is a gap, at most17.
        assert all(not self.remainder.row(self.index[e]) for e in range(self.lower,-17))
        self.rho=self.remainder.matrix_from_rows([self.index[e] for e in self.target])
        translated=matrix(self.field,size,size)
        for i,e in enumerate(self.exponents):
            if e+self.shift in self.index:
                translated[i,:]=self.remainder[self.index[e+self.shift],:]
        self.twice=self.rho*translated
        # No needed outer coefficient depends on a discarded high coefficient.
        assert all(not self.rho.column(self.index[e]) for e in range(48,self.upper+1))
        self.u_exponents=list(range(-112,218)); self.u_index={e:i for i,e in enumerate(self.u_exponents)}

    def multiplication_window(self,u_coefficients,eta_exponents):
        """Columns of truncated multiplication by U*t^(5e), without products."""
        from sage.all import matrix
        field=u_coefficients.base_ring(); zero=field.zero()
        assert len(u_coefficients)==len(self.u_exponents)
        return matrix(field,[[u_coefficients[self.u_index[e-5*h]]
            if e-5*h in self.u_index else zero for h in eta_exponents]
            for e in self.exponents])

    def raw(self,u_coefficients,Bc5,Dbc5,embed_matrix,multiply=None,base_multiply=None):
        """The ORIGINAL 56-by32 R block before compact projection."""
        if multiply is None: multiply=lambda A,B:A*B
        if base_multiply is None: base_multiply=lambda A,B:multiply(embed_matrix(A),B)
        left=base_multiply(self.twice,self.multiplication_window(u_coefficients,self.target))
        right=base_multiply(self.rho,self.multiplication_window(u_coefficients,self.domain))
        return multiply(left,Bc5)-multiply(right,Dbc5)
