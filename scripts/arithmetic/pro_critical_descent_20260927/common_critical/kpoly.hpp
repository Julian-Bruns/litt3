#ifndef KPOLY_HPP
#define KPOLY_HPP
#include <vector>
#include <random>
#include <boost/multiprecision/cpp_int.hpp>
using KP=std::vector<int>;
using boost::multiprecision::cpp_int;
void trim(KP&a){while(a.size()&&!a.back())a.pop_back();}
KP pa(KP a,const KP&b){a.resize(std::max(a.size(),b.size()));for(size_t i=0;i<b.size();i++)a[i]=add(a[i],b[i]);trim(a);return a;}
KP pn(KP a){for(int&c:a)c=neg(c);return a;}
KP ps(KP a,const KP&b){return pa(a,pn(b));}
KP sc(KP a,int c){for(int&v:a)v=mul(v,c);trim(a);return a;}
KP pm(const KP&a,const KP&b){if(a.empty()||b.empty())return {};KP c(a.size()+b.size()-1);for(size_t i=0;i<a.size();i++)if(a[i])for(size_t j=0;j<b.size();j++)if(b[j])c[i+j]=add(c[i+j],mul(a[i],b[j]));trim(c);return c;}
std::pair<KP,KP> pd(KP a,const KP&b){if(b.empty())abort();KP q(std::max(0,int(a.size())-int(b.size())+1));int ib=inv(b.back());while(a.size()>=b.size()){size_t j=a.size()-b.size();int c=mul(a.back(),ib);q[j]=c;for(size_t i=0;i<b.size();i++)a[i+j]=sub(a[i+j],mul(c,b[i]));trim(a);}trim(q);return {q,a};}
KP md(const KP&a,const KP&m){return pd(a,m).second;}
KP monic(KP a){return a.empty()?a:sc(a,inv(a.back()));}
KP gd(KP a,KP b){while(b.size()){KP r=md(a,b);a=b;b=r;}return monic(a);}
KP mpow(KP a,cpp_int n,const KP&m){KP b={1};a=md(a,m);while(n>0){if((n&1)!=0)b=md(pm(b,a),m);n>>=1;if(n>0)a=md(pm(a,a),m);}return b;}
KP invmod(KP a,const KP&m){KP r=m,s=a,u={},v={1};while(!s.empty()){auto [q,t]=pd(r,s);r=s;s=t;KP z=ps(u,pm(q,v));u=v;v=z;}if(r.size()!=1)abort();return md(sc(u,inv(r[0])),m);}
#endif
