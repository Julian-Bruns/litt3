// Boundary-safe global leading-row coefficients. Every H and q remains symbolic.
#define main archived_frontier_main
#include "../continuation/frontier.cpp"
#undef main
#include <tuple>
using Key=std::tuple<int,int,int>;
std::map<Key,BP> table;
BP readcached(int j,int m,int x){auto i=table.find({j,m,x});return i==table.end()?BP{}:i->second;}
void loadtable(std::string path){std::ifstream in(path);std::string head;in>>head;int j,h,q,m,x,c;while(in>>j>>h>>q>>m>>x>>c){auto& a=table[{j,m,x}];if((int)a.size()<=h)a.resize(h+1);if(a[h].deg()<q)a[h].v.resize(q+1);a[h].v[q]=c;}for(auto &[k,a]:table)a=trimB(a);}
BP coeffprod(std::array<int,3> js,int m,int x){BP out;int bound[3][3]={{46,45,43},{43,42,39},{40,38,35}};for(int m0=0;m0<=2;++m0)for(int m1=0;m1<=2;++m1){int m2=m-m0-m1;if(m2<0||m2>2)continue;int d0=bound[js[0]][m0],d1=bound[js[1]][m1],d2=bound[js[2]][m2];for(int x0=std::max(0,x-d1-d2);x0<=d0;++x0)for(int x1=std::max(0,x-x0-d2);x1<=d1&&x1<=x-x0;++x1){int x2=x-x0-x1;if(x2>d2)continue;BP t=mulB(mulB(readcached(js[0],m0,x0),readcached(js[1],m1,x1)),readcached(js[2],m2,x2));out=addB(out,t);}}return out;}
BP wcoeff(int m,int x){BP out=qB(coeffprod({0,0,0},m,x),2);Poly P2=P*P;for(int i=0;i<=10;++i)if(P.at(i)){out=addB(out,scB(qB(coeffprod({1,1,1},m,x-i),1),P.at(i)));out=addB(out,scB(qB(coeffprod({0,1,2},m,x-i),1),ff::mul(2,P.at(i))));}for(int i=0;i<=20;++i)if(P2.at(i))out=addB(out,scB(coeffprod({2,2,2},m,x-i),P2.at(i)));return out;}
std::pair<BP,int> removeq(BP z){int v=100000;for(auto&p:z)for(int q=0;q<=p.deg();++q)if(p.at(q)){v=std::min(v,q);break;}if(v==100000)return {z,0};for(auto&p:z)if(!p.zero())p=Poly(std::vector<F>(p.v.begin()+v,p.v.end()));return {z,v};}
Poly subst_affine(const BP&z,const Poly&b0,const Poly&b1){Poly out;int n=z.size()-1;for(int i=0;i<=n;++i)out=out+z[i]*ppow(-b0,i)*ppow(b1,n-i);return out;}
Poly substmod(const BP&z,const Poly&b0,const Poly&b1,const Poly&mod){ // b1 invertible modulo mod
 auto xg=[](Poly a,Poly b){Poly u(1),v,w,t(1);while(!b.zero()){auto qr=divmod(a,b);Poly un=u-qr.first*w,vn=v-qr.first*t;a=b;b=qr.second;u=w;v=t;w=un;t=vn;}F iv=ff::inv(a.v.back());return std::make_tuple(scale(a,iv),scale(u,iv),scale(v,iv));};
 auto [gg,bi,junk]=xg(b1,mod);if(gg.deg()!=0)throw std::runtime_error("b1 not invertible in eliminant algebra");Poly H=rem(-b0*bi,mod),out;for(int i=int(z.size())-1;i>=0;--i)out=rem(out*H+z[i],mod);return out;
}
#ifndef FRONTIER_NO_MAIN
int main(int argc,char**argv){try{ff::init();init_source();loadtable(argc>1?argv[1]:"inputs/E_records.tsv");std::map<std::pair<int,int>,BP>w;for(auto mk:std::vector<std::pair<int,int>>{{5,131},{5,130},{5,129},{5,128},{6,129},{6,128},{3,136},{4,133}}){w[mk]=wcoeff(mk.first,mk.second);auto [r,v]=removeq(w[mk]);int d=-1,n=0;for(auto&p:r){d=std::max(d,p.deg());for(F c:p.v)n+=(c!=0);}std::cout<<"W "<<mk.first<<' '<<mk.second<<" H_degree "<<r.size()-1<<" q_factor "<<v<<" q_degree_after "<<d<<" terms "<<n<<std::endl;}
 auto c5=w[{5,131}],c51=w[{5,130}],c52=w[{5,129}],c53=w[{5,128}],c6=w[{6,129}],c61=w[{6,128}],c3=w[{3,136}],c4=w[{4,133}];auto [b,bq]=removeq(c5);auto [r,rq]=removeq(c51);if(b.size()!=2)throw std::runtime_error("c5 not affine");show("gcd_b0_b1",gcd(b[0],b[1]));Poly elim=subst_affine(r,b[0],b[1]);while(!elim.zero()&&!elim.at(0))elim=Poly(std::vector<F>(elim.v.begin()+1,elim.v.end()));elim=scale(elim,ff::inv(elim.v.back()));show("q_eliminant_of_first_two_leading_coefficients",elim);
 auto p=addB(scB(mulB(powB(c3,3),subB(mulB(c6,c53),mulB(c61,c52))),3),powB(c4,5));auto [pn,pq]=removeq(p);int qdeg=-1;for(auto&a:pn)qdeg=std::max(qdeg,a.deg());std::cout<<"third_leading_condition H_degree "<<pn.size()-1<<" q_factor "<<pq<<" q_degree "<<qdeg<<std::endl;
 Poly image=substmod(pn,b[0],b[1],elim);show("third_condition_in_eliminant_algebra",image);show("common_gcd",gcd(elim,image));
 std::cout<<"GLOBAL_SQUARE_LOCUS_UNRESOLVED"<<std::endl;
 }catch(std::exception&e){std::cerr<<"ERROR "<<e.what()<<std::endl;return 1;}return 0;}

#endif
