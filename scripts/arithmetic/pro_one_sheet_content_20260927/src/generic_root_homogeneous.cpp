#define USE_GMP_PACKING
#include "function_algebra.hpp"
#include <cstdio>
// All coefficients are homogenized with one base denominator before series
// multiplication. This removes every intermediate rational gcd. The v/series
// Kronecker spacing is proved from the degree-six three-term relation below.
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
int main(int argc,char**argv){try{if(argc!=4){std::cerr<<"usage: generic_root_homogeneous chart U_file prefix\n";return 2;}initfield(nullptr);std::ifstream ch(argv[1]);U r;ch>>r;readF(ch);SP[0]=QA(1);SP[1].n[1]={1};for(int i=2;i<126;i++)SP[i]=SP[i-1]*SP[1];std::ifstream ui(argv[2]);int n;ui>>n;assert(n>=prec);Series a(prec);UP D={1};for(auto&q:a){q=loadq(ui);D=um(D,ux(q.d,ug(D,q.d)));}assert((a[0]-QA(1)).zero());
 UP support=uradical(D);{std::ofstream o(std::string(argv[3])+"_support.txt");o<<support.size();for(U c:support)o<<" "<<c;o<<"\n";}
 for(auto&q:a){UP m=ux(D,q.d);for(auto&p:q.n)p=um(p,m);q.d={1};}
 std::cout<<"common_denominator_degree="<<D.size()-1<<" radical_degree="<<support.size()-1<<" polynomial_coefficient_max_v_degree="<<vd(a)<<std::endl;
 Series a2,a3;if(!loads(std::string(argv[3])+"_A2.txt",a2)){a2=polys_product(a,a,true);saves(std::string(argv[3])+"_A2.txt",a2);}std::cout<<"A2 complete maxdegree="<<vd(a2)<<std::endl;
 if(!loads(std::string(argv[3])+"_A3.txt",a3)){a3=polys_product(a2,a,false);saves(std::string(argv[3])+"_A3.txt",a3);}std::cout<<"A3 complete maxdegree="<<vd(a3)<<std::endl;
 std::array<QA,15> f5;std::array<QA,3>f25;for(int i=0;i<15;i++)f5[i]=frob(a2[i],5);for(int i=0;i<3;i++)f25[i]=frob(a2[i],25);UP den=up(D,63);std::cout<<"Frobenius factors ready; denominator_degree="<<den.size()-1<<std::endl;
 for(int target: {71,72}){QA tail;for(int k=0;k<=2;k++){int m=target-25*k;QA sum;for(int j=0;5*j<=m;j++){QA p=qraw(a3[m-5*j],f5[j]);for(int z=0;z<6;z++)sum.n[z]=ua(std::move(sum.n[z]),p.n[z]);}QA p=qraw(sum,f25[k]);for(int z=0;z<6;z++)tail.n[z]=ua(std::move(tail.n[z]),p.n[z]);}
 tail.d=den;tail.normal();save_single(std::string(argv[3])+"_C"+std::to_string(target)+".txt",tail);std::cout<<"C"<<target<<" height="<<height(tail)<<" denominator_degree="<<tail.d.size()-1<<std::endl;}
 return 0;}catch(std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
