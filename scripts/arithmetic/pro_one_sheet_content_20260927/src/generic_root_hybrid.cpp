#define USE_GMP_PACKING
#include "function_algebra.hpp"
#include <cstdio>
// All coefficients are homogenized with one base denominator before series
// multiplication. This removes every intermediate rational gcd. The v/series
// Kronecker spacing is proved from the degree-six three-term relation below.
static QA sum_products(const std::vector<std::pair<const QA*,const QA*>>&pairs,const std::vector<U>&sc){QA c;std::vector<UP>ds;ds.reserve(pairs.size());for(auto&[a,b]:pairs){UP d=um(a->d,b->d);if(c.d!=d){UP g=ug(c.d,d);c.d=um(c.d,ux(d,g));}ds.push_back(std::move(d));}for(size_t i=0;i<pairs.size();i++){QA p=qraw(*pairs[i].first,*pairs[i].second);UP factor=c.d==ds[i]?UP{1}:ux(c.d,ds[i]);for(int j=0;j<6;j++)c.n[j]=ua(c.n[j],uc(um(p.n[j],factor),sc[i]));}c.normal();return c;}

static constexpr int prec=73;
using Series=std::vector<QA>;
static void save_single(const std::string&f,const QA&a){auto t=f+".tmp";{std::ofstream o(t);saveq(o,a);if(!o)throw std::runtime_error("write checkpoint");}if(std::rename(t.c_str(),f.c_str()))throw std::runtime_error("rename checkpoint");}
static void readF(std::istream&i){std::string name;int n;i>>name>>n;assert(name=="F");for(int k=0;k<n;k++){int v,s;U c;i>>v>>s>>c;if(s==6){assert(!v&&c==1);continue;}F[s].resize(std::max(F[s].size(),size_t(v+1)));F[s][v]=c;}for(int j=3;j<6;j++)assert(F[j].empty());}
static int vd(const Series&a){int d=0;for(auto&q:a){assert(q.d==UP{1});for(auto&p:q.n)d=std::max(d,int(p.size())-1);}return d;}
static Series polys_product(const Series&a,const Series&b,bool square){
 int fd=0;for(auto&p:F)fd=std::max(fd,int(p.size())-1);
 // Raw S-degree at most 10, each reduction lowers S-degree at least 4.
 // Thus at most two reductions, increasing v-degree by at most 2*fd.
 int stride=vd(a)+vd(b)+2*fd+1;size_t cutoff=size_t(prec)*stride;
 std::array<UP,6>aa,bb;
 for(int j=0;j<6;j++)for(int i=0;i<prec;i++){assert(a[i].n[j].size()<=size_t(stride));accum(aa[j],a[i].n[j],i*stride);if(!square)accum(bb[j],b[i].n[j],i*stride);}
 if(square)bb=aa;
 std::array<UP,11>p;
 std::cout<<"series_product stride="<<stride<<" flattened_length="<<cutoff<<" square="<<square<<std::endl;
#pragma omp parallel for schedule(dynamic,1)
 for(int j=0;j<11;j++){UP s;for(int i=0;i<6;i++){int k=j-i;if(k<0||k>=6|| (square&&i>k))continue;UP t=um(aa[i],bb[k]);t=utrunc(std::move(t),cutoff);if(square&&i<k)t=uc(std::move(t),2);s=ua(std::move(s),t);}p[j]=std::move(s);}
 for(int j=10;j>=6;j--)if(!p[j].empty())for(int k=0;k<3;k++)if(!F[k].empty())p[j-6+k]=us(std::move(p[j-6+k]),utrunc(um(p[j],F[k]),cutoff));
 Series out(prec);for(int i=0;i<prec;i++)for(int j=0;j<6;j++)out[i].n[j]=ucut(p[j],i*stride,(i+1)*stride);
 return out;
}
static void saves(const std::string&f,const Series&a){auto t=f+".tmp";{std::ofstream o(t);o<<a.size()<<"\n";for(auto&q:a)saveq(o,q);if(!o)throw std::runtime_error("write series checkpoint");}if(std::rename(t.c_str(),f.c_str()))throw std::runtime_error("rename series checkpoint");}
static bool loads(const std::string&f,Series&a){std::ifstream i(f);if(!i)return false;int n;i>>n;if(n!=prec)throw std::runtime_error("bad series cache");a.resize(n);for(auto&q:a)q=loadq(i);return true;}
int main(int argc,char**argv){try{if(argc!=4){std::cerr<<"usage: generic_root_hybrid chart U_file prefix\n";return 2;}initfield(nullptr);std::ifstream ch(argv[1]);U r;ch>>r;readF(ch);SP[0]=QA(1);SP[1].n[1]={1};for(int i=2;i<126;i++)SP[i]=SP[i-1]*SP[1];std::ifstream ui(argv[2]);int n;ui>>n;assert(n>=prec);Series a(prec);UP D={1};for(auto&q:a){q=loadq(ui);D=um(D,ux(q.d,ug(D,q.d)));}assert((a[0]-QA(1)).zero());
 UP support=uradical(D);denominator_support=support; // Every later denominator divides a power of D.
 {std::ofstream o(std::string(argv[3])+"_support.txt");o<<support.size();for(U c:support)o<<" "<<c;o<<"\n";}
 for(auto&q:a){UP m=ux(D,q.d);for(auto&p:q.n)p=um(p,m);q.d={1};}
 std::cout<<"common_denominator_degree="<<D.size()-1<<" radical_degree="<<support.size()-1<<" polynomial_coefficient_max_v_degree="<<vd(a)<<std::endl;
 Series a2,a3;if(!loads(std::string(argv[3])+"_A2.txt",a2)){a2=polys_product(a,a,true);saves(std::string(argv[3])+"_A2.txt",a2);}std::cout<<"A2 complete maxdegree="<<vd(a2)<<std::endl;
 if(!loads(std::string(argv[3])+"_A3.txt",a3)){a3=polys_product(a2,a,false);saves(std::string(argv[3])+"_A3.txt",a3);}std::cout<<"A3 complete maxdegree="<<vd(a3)<<std::endl;
 UP D2=up(D,2),D3=up(D,3);for(int i=0;i<15;i++){a2[i].d=D2;a2[i].normal();}for(int i=1;i<prec;i++)if(i%5==1||i%5==2){a3[i].d=D3;a3[i].normal();}
 std::array<QA,15>f5;std::array<QA,3>f25;for(int i=0;i<15;i++)f5[i]=frob(a2[i],5);for(int i=0;i<3;i++)f25[i]=frob(a2[i],25);std::cout<<"normalized Frobenius factors ready"<<std::endl;
#pragma omp parallel for schedule(dynamic,1)
 for(int target=71;target<=72;target++){QA tail;for(int k=0;k<=2;k++){int m=target-25*k;std::vector<std::pair<const QA*,const QA*>>pairs;std::vector<U>sc;for(int j=0;j*5<=m;j++){pairs.emplace_back(&a3[m-5*j],&f5[j]);sc.push_back(1);}tail=tail+sum_products(pairs,sc)*f25[k];}save_single(std::string(argv[3])+"_C"+std::to_string(target)+".txt",tail);
#pragma omp critical
 std::cout<<"C"<<target<<" height="<<height(tail)<<" denominator_degree="<<tail.d.size()-1<<std::endl;}
 return 0;}catch(std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
