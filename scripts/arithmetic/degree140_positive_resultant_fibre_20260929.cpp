// New geometric fibre elimination by exact fixed-degree resultants.
#include "degree140_trace_engine_20260929.hpp"
#include <chrono>
using namespace criticaltrace;
struct Bnd{int j,n,dh,dq,dp,bh,bq;};
F resultant(Poly a,Poly b){
 if(a.empty()||b.empty())return 0;F r=1;
 while(b.deg()>0){int m=a.deg(),n=b.deg();auto c=divmod(a,b).second;if(c.empty())return 0;
  r=mul(r,power(b.back(),m-c.deg()));if(m*n%2)r=neg(r);a=b;b=c;
 }
 return mul(r,power(b[0],a.deg()));
}
F fixed_resultant(const Poly&a,const Poly&b,int m,int n){
 if(a.empty()||b.empty())return 0;int r=a.deg(),s=b.deg();if(r<m&&s<n)return 0;
 F z=resultant(a,b);if(r<m){z=mul(z,power(b.back(),m-r));if((m-r)*n%2)z=neg(z);}if(s<n)z=mul(z,power(a.back(),n-s));return z;
}
std::array<Poly,3> interpolate_three(const std::vector<F>&xs,const std::array<std::vector<F>,3>&ys){
 Poly all{1};for(F x:xs)all=all*Poly{neg(x),1};Poly der=derivative(all);std::array<Poly,3> out;
 for(size_t i=0;i<xs.size();i++){Poly l=pdivide(all,Poly{neg(xs[i]),1});F v=inv(eval(der,xs[i]));for(int k=0;k<3;k++)out[k]=out[k]+scale(l,mul(ys[k][i],v));}return out;
}
int main(int argc,char**argv){try{
 if(argc!=7){std::cerr<<"usage: resultant_fibre FIELD BOUNDS COEFF_BIN H_COUNT Q_COUNT Q_CODE\n";return 2;}
 loadfield(argv[1]);std::ifstream bf(argv[2]);int nc;bf>>nc;std::vector<Bnd>bs(nc);for(auto&b:bs)bf>>b.j>>b.n>>b.dh>>b.dq>>b.dp>>b.bh>>b.bq;
 int nh=std::stoi(argv[4]),nq=std::stoi(argv[5]);F q=std::stoi(argv[6]);if(!q)throw std::runtime_error("zero q");
 std::vector<F> data((size_t)nc*nh*nq);std::ifstream input(argv[3],std::ios::binary);input.read((char*)data.data(),4*data.size());if(!input)throw std::runtime_error("incomplete global data");
 F a0=eval(Poly{89654,311173,214299,163299,315361,33043,356725,245794},q),a1=mul(q,add(299833,mul(232505,q)));if(!a0||!a1||q==1)throw std::runtime_error("outside ratio chart");Poly psi{a0,a1};
 std::array<std::vector<Poly>,3> p;for(auto&v:p)v.resize(17);int dh[3]={},dp[3]={};for(auto b:bs){dh[b.j]=std::max(dh[b.j],b.dh-b.n);dp[b.j]=std::max(dp[b.j],b.dp);}
 auto start=std::chrono::steady_clock::now();
 for(int k=0;k<nc;k++){
  auto b=bs[k];Poly N(nh);for(int h=0;h<nh;h++){F z=0;for(int i=nq-1;i>=0;i--)z=add(mul(z,q),data[((size_t)k*nh+h)*nq+i]);N[h]=z;}N.trim();
  Poly v=scale(N*ppow(psi,dp[b.j]-b.dp),power(q,-b.dq));v.insert(v.begin(),dh[b.j]+b.n-b.dh,0);v.trim();p[b.j][b.n]=v;
 }
 int degH[3]={};for(auto&v:p){int cut=100000;for(auto&r:v)if(!r.empty()){int z=0;while(!r[z])z++;cut=std::min(cut,z);}for(auto&r:v)if(!r.empty())r.erase(r.begin(),r.begin()+cut);while(v.back().empty())v.pop_back();}
 for(int j=0;j<3;j++)for(auto&r:p[j])degH[j]=std::max(degH[j],r.deg());
 int m=p[0].size()-1,n=std::max(p[1].size(),p[2].size())-1,bound=n*degH[0]+m*std::max(degH[1],degH[2]);
 std::vector<F> xs;std::array<std::vector<F>,3> ys;
 for(F h=0;h<=bound;h++){
  Poly v[3];for(int j=0;j<3;j++){for(auto&r:p[j])v[j].push_back(eval(r,h));v[j].trim();}
  xs.push_back(h);ys[0].push_back(fixed_resultant(v[0],v[1],m,n));ys[1].push_back(fixed_resultant(v[0],v[2],m,n));ys[2].push_back(fixed_resultant(v[0],v[1]+v[2],m,n));
 }
 auto rs=interpolate_three(xs,ys);Poly g=gcd(gcd(rs[0],rs[1]),rs[2]);Poly before=g;
 int h_power=0,psi_power=0;while(!g.empty()&&g[0]==0){g.erase(g.begin());h_power++;}while(g.deg()>0){auto qr=divmod(g,psi);if(!qr.second.empty())break;g=qr.first;psi_power++;}if(!g.empty())g=scale(g,inv(g.back()));
 std::cout<<"{\"q_code\":"<<q<<",\"rescaled_mu\":\"mu=H*u\",\"H_degrees\":["<<degH[0]<<','<<degH[1]<<','<<degH[2]<<"],\"resultant_degree_bound\":"<<bound<<",\"resultants\":[";for(int i=0;i<3;i++){if(i)std::cout<<',';jsonpoly(std::cout,rs[i]);}
 std::cout<<"],\"common_gcd_degree\":"<<before.deg()<<",\"removed_H_power\":"<<h_power<<",\"removed_Psi_power\":"<<psi_power<<",\"residual_gcd\":";jsonpoly(std::cout,g);std::cout<<",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
