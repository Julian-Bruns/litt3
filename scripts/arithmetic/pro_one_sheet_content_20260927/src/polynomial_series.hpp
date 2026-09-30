#pragma once
#include "function_algebra.hpp"
static constexpr int PS_PREC=73;
using PSeries=std::vector<QA>;
static int ps_vd(const PSeries&a){int d=0;for(auto&q:a){assert(q.d==UP{1});for(auto&p:q.n)d=std::max(d,int(p.size())-1);}return d;}
static int ps_len(const PSeries&a){int n=a.size();while(n&&a[n-1].zero())n--;return n;}
static PSeries ps_mul(const PSeries&a,const PSeries&b,bool square=false){
 assert(a.size()==PS_PREC&&b.size()==PS_PREC);for(int j=3;j<6;j++)assert(F[j].empty());int fd=0;for(auto&p:F)fd=std::max(fd,int(p.size())-1);
 // S exponents start at most 10. Each reduction S^6=-F2*S^2-F1*S-F0
 // decreases that exponent by at least four: at most two reductions.
 int stride=ps_vd(a)+ps_vd(b)+2*fd+1;size_t cutoff=size_t(PS_PREC)*stride;
 int na=ps_len(a),nb=ps_len(b);std::array<UP,6>aa,bb;
 for(int j=0;j<6;j++){for(int i=0;i<na;i++)accum(aa[j],a[i].n[j],i*stride);if(!square)for(int i=0;i<nb;i++)accum(bb[j],b[i].n[j],i*stride);trim(aa[j]);trim(bb[j]);}if(square)bb=aa;
 std::array<UP,11>p;
#pragma omp parallel for schedule(dynamic,1)
 for(int j=0;j<11;j++){UP s;for(int i=0;i<6;i++){int k=j-i;if(k<0||k>=6||(square&&i>k))continue;UP t=utrunc(um(aa[i],bb[k]),cutoff);if(square&&i<k)t=uc(std::move(t),2);s=ua(std::move(s),t);}p[j]=std::move(s);}
 for(int j=10;j>=6;j--)if(!p[j].empty())for(int k=0;k<3;k++)if(!F[k].empty())p[j-6+k]=us(std::move(p[j-6+k]),utrunc(um(p[j],F[k]),cutoff));
 PSeries out(PS_PREC);for(int i=0;i<PS_PREC;i++)for(int j=0;j<6;j++)out[i].n[j]=ucut(p[j],i*stride,(i+1)*stride);return out;
}
static PSeries ps_add(PSeries a,const PSeries&b){for(int i=0;i<PS_PREC;i++)for(int j=0;j<6;j++)a[i].n[j]=ua(std::move(a[i].n[j]),b[i].n[j]);return a;}
static PSeries ps_scale(PSeries a,U c){for(auto&q:a)for(auto&p:q.n)p=uc(std::move(p),c);return a;}
static PSeries ps_shift(const PSeries&a,int n){PSeries out(PS_PREC);for(int i=0;i+n<PS_PREC;i++)out[i+n]=a[i];return out;}
static PSeries ps_scalar(const PSeries&a,const UP&power_series,const UP&base){PSeries out(PS_PREC);
#pragma omp parallel for schedule(dynamic,1)
 for(int i=0;i<PS_PREC;i++)for(int j=0;j<=i&&j<int(power_series.size());j++)if(power_series[j])for(int k=0;k<6;k++)out[i].n[k]=ua(std::move(out[i].n[k]),uc(a[i-j].n[k],power_series[j]));
 for(auto&q:out)for(auto&p:q.n)p=um(p,base);return out;}
