#pragma once
#include "finite_generic.hpp"
// Exact series convolution. Pack v and the series variable only while their
// degrees cannot overlap; reduce v before reducing the monic S relation.
// Therefore no irreducibility or reducedness of either finite algebra is used.
static ES es_fast(const ES&a,const ES&b,bool square=false){
 int d=VF.size()-1,m=SF.size()-1;assert(d>=1&&m>=1&&SF.back()==BP{1});int stride=2*d-1;
 std::vector<UP>A(m),B(m);for(int j=0;j<m;j++){for(int i=0;i<int(a.size())&&i<FP;i++)if(j<int(a[i].n.size())){assert(a[i].n[j].size()<=size_t(d));accum(A[j],a[i].n[j],i*stride);}if(!square)for(int i=0;i<int(b.size())&&i<FP;i++)if(j<int(b[i].n.size())){assert(b[i].n[j].size()<=size_t(d));accum(B[j],b[i].n[j],i*stride);}trim(A[j]);trim(B[j]);}if(square)B=A;
 std::vector<std::vector<BP>>p(2*m-1,std::vector<BP>(FP));
 for(int k=0;k<2*m-1;k++){UP raw;for(int j=0;j<m;j++){int l=k-j;if(l<0||l>=m||(square&&j>l))continue;UP t=utrunc(um(A[j],B[l]),FP*stride);if(square&&j<l)t=uc(std::move(t),2);raw=ua(std::move(raw),t);}for(int i=0;i<FP;i++)p[k][i]=br(ucut(raw,i*stride,(i+1)*stride));}
 for(int k=2*m-2;k>=m;k--)for(int j=0;j<m;j++)if(!SF[j].empty())for(int i=0;i<FP;i++)if(!p[k][i].empty())p[k-m+j][i]=us(std::move(p[k-m+j][i]),bm(p[k][i],SF[j]));
 ES out(FP);for(int i=0;i<FP;i++){out[i].n.resize(m);for(int j=0;j<m;j++)out[i].n[j]=std::move(p[j][i]);st(out[i].n);}return out;
}
static ES es_fast_square(const ES&a){return es_fast(a,a,true);}
static ES sqrt_fast_power(const ES&u){auto u2=es_fast_square(u);auto u3=es_fast(u2,u);return es_fast(es_fast(u3,esf(u2,5)),esf(u2,25));}
