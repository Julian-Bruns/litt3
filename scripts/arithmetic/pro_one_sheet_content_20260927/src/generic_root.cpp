#include "function_algebra.hpp"
#include <cstdio>
static int prec=73;
using Series=std::vector<QA>;
static QA sum_products(const std::vector<std::pair<const QA*,const QA*>>&pairs,const std::vector<U>&sc){QA c;std::vector<UP>ds;ds.reserve(pairs.size());for(auto&[a,b]:pairs){UP d=um(a->d,b->d);if(c.d!=d){UP g=ug(c.d,d);c.d=um(c.d,ux(d,g));}ds.push_back(std::move(d));}for(size_t i=0;i<pairs.size();i++){QA p=qraw(*pairs[i].first,*pairs[i].second);UP factor=c.d==ds[i]?UP{1}:ux(c.d,ds[i]);for(int j=0;j<6;j++)c.n[j]=ua(c.n[j],uc(um(p.n[j],factor),sc[i]));}c.normal();return c;}
static QA coeff_square(const Series&a,int n){std::vector<std::pair<const QA*,const QA*>>p;std::vector<U>sc;for(int i=0;2*i<n;i++)if(!a[i].zero()&&!a[n-i].zero()){p.emplace_back(&a[i],&a[n-i]);sc.push_back(2);}if(n%2==0&&!a[n/2].zero()){p.emplace_back(&a[n/2],&a[n/2]);sc.push_back(1);}return sum_products(p,sc);}
static QA coeff_product(const Series&a,const Series&b,int n){std::vector<std::pair<const QA*,const QA*>>p;std::vector<U>sc;for(int i=0;i<=n;i++)if(!a[i].zero()&&!b[n-i].zero()){p.emplace_back(&a[i],&b[n-i]);sc.push_back(1);}return sum_products(p,sc);}
static void readF(std::istream&in){std::string name;int n;in>>name>>n;assert(name=="F");for(int k=0;k<n;k++){int v,s;U c;in>>v>>s>>c;if(s==6){assert(!v&&c==1);continue;}F[s].resize(std::max(F[s].size(),size_t(v+1)));F[s][v]=c;}}
static void save_single(const std::string&f,const QA&a){const auto t=f+".tmp";{std::ofstream o(t);saveq(o,a);o.flush();if(!o)throw std::runtime_error("failed coefficient checkpoint write");}if(std::rename(t.c_str(),f.c_str()))throw std::runtime_error("failed atomic checkpoint rename");}
static bool load_single(const std::string&f,QA&a){std::ifstream i(f);if(!i)return false;a=loadq(i);return true;}
int main(int argc,char**argv){try{if(argc<4){std::cerr<<"usage: generic_root chart U_file output_prefix\n";return 2;}initfield(nullptr);std::ifstream in(argv[1]);U r;in>>r;readF(in);SP[0]=QA(1);SP[1].n[1]={1};for(int i=2;i<126;i++)SP[i]=SP[i-1]*SP[1];std::ifstream uu(argv[2]);int n;uu>>n;assert(n>=73);Series u(prec);for(auto&a:u)a=loadq(uu);assert((u[0]-QA(1)).zero());
 UP d={1};for(auto&a:u)if(a.d!=d){UP g=ug(d,a.d);d=um(d,ux(a.d,g));}denominator_support=uradical(d);std::cout<<"input_common_denominator_degree="<<d.size()-1<<" radical_degree="<<denominator_support.size()-1<<std::endl;
 // Exact support audit, required for the gcd shortcut in QA::normal.
 for(auto&a:u){UP rem=a.d;while(rem.size()>1){UP g=ug(rem,denominator_support);if(g.size()<=1)throw std::runtime_error("unsupported denominator");rem=ux(rem,g);}}
 {std::ofstream o(std::string(argv[3])+"_support.txt");o<<denominator_support.size();for(U c:denominator_support)o<<" "<<c;o<<"\n";}
 Series u2(prec),u3(prec);
#pragma omp parallel for schedule(dynamic,1)
 for(int i=0;i<prec;i++){std::string file=std::string(argv[3])+"_U2_"+std::to_string(i)+".txt";if(!load_single(file,u2[i])){u2[i]=coeff_square(u,i);save_single(file,u2[i]);}
#pragma omp critical
 std::cout<<"U2 coefficient="<<i<<" height="<<height(u2[i])<<std::endl;
 }
#pragma omp parallel for schedule(dynamic,1)
 for(int i=1;i<prec;i++){if(i%5!=1&&i%5!=2)continue;std::string file=std::string(argv[3])+"_U3_"+std::to_string(i)+".txt";if(!load_single(file,u3[i])){u3[i]=coeff_product(u2,u,i);save_single(file,u3[i]);}
#pragma omp critical
 std::cout<<"U3 coefficient="<<i<<" height="<<height(u3[i])<<std::endl;
 }
 std::array<QA,15>f5;std::array<QA,3>f25;
 for(int i=0;i<15;i++){std::string file=std::string(argv[3])+"_F5_"+std::to_string(i)+".txt";if(!load_single(file,f5[i])){f5[i]=frob(u2[i],5);save_single(file,f5[i]);}std::cout<<"F5 "<<i<<" height="<<height(f5[i])<<std::endl;}
 for(int i=0;i<3;i++){std::string file=std::string(argv[3])+"_F25_"+std::to_string(i)+".txt";if(!load_single(file,f25[i])){f25[i]=frob(u2[i],25);save_single(file,f25[i]);}std::cout<<"F25 "<<i<<" height="<<height(f25[i])<<std::endl;}
 for(int target: {71,72}){QA tail;for(int k=0;k<=2;k++){int m=target-25*k;std::vector<std::pair<const QA*,const QA*>>pairs;std::vector<U>sc;for(int j=0;j*5<=m;j++){pairs.emplace_back(&u3[m-5*j],&f5[j]);sc.push_back(1);}QA v=sum_products(pairs,sc);tail=tail+v*f25[k];}save_single(std::string(argv[3])+"_C"+std::to_string(target)+".txt",tail);std::cout<<"C"<<target<<" height="<<height(tail)<<" numerator_degrees=";for(auto&a:tail.n)std::cout<<int(a.size())-1<<",";std::cout<<" denominator_degree="<<tail.d.size()-1<<std::endl;}
 return 0;
 }catch(std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
