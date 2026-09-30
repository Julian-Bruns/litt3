#define USE_GMP_PACKING
#include "fast_univariate.hpp"
#include <cstdio>
static void readF(std::istream&in){std::string name;int n;in>>name>>n;assert(name=="F");for(int k=0;k<n;k++){int v,s;U c;in>>v>>s>>c;if(s==6){assert(!v&&c==1);continue;}F[s].resize(std::max(F[s].size(),size_t(v+1)));F[s][v]=c;}}
static void saveu(std::ostream&o,const UP&p){o<<p.size();for(U c:p)o<<" "<<c;o<<"\n";}
static void bs(std::ostream&o,const UP&p){uint64_t n=p.size();o.write((char*)&n,sizeof(n));o.write((char*)p.data(),n*sizeof(U));}
static UP bl(std::istream&i){uint64_t n;i.read((char*)&n,sizeof(n));UP p(n);i.read((char*)p.data(),n*sizeof(U));if(!i)throw std::runtime_error("bad checkpoint");return p;}
int main(int argc,char**argv){try{if(argc!=4){std::cerr<<"usage: generic_norm_rowprimitive chart tail prefix\n";return 2;}initfield(nullptr);std::ifstream fi(argv[1]);U r;fi>>r;readF(fi);SP[0]=QA(1);SP[1].n[1]={1};for(int i=2;i<126;i++)SP[i]=SP[i-1]*SP[1];std::ifstream ti(argv[2]);QA p=loadq(ti);p.d={1};std::array<std::array<UP,7>,6>M;
 for(int j=0;j<6;j++){QA u=qraw(p,SP[j]);for(int i=0;i<6;i++)M[i][j]=std::move(u.n[i]);}M[0][6]={1};
 for(int k=0;k<5;k++){std::string file=std::string(argv[3])+"_primitive_stage"+std::to_string(k)+".bin";std::ifstream cache(file,std::ios::binary);if(cache){for(auto&row:M)for(auto&a:row)a=bl(cache);std::cout<<"loaded primitive stage="<<k<<std::endl;continue;}
  int pivot=k;while(pivot<6&&M[pivot][k].empty())pivot++;if(pivot==6)throw std::runtime_error("singular generic multiplication matrix");if(pivot!=k)std::swap(M[pivot],M[k]);UP pk=M[k][k];std::cout<<"start primitive stage="<<k<<" pivotdegree="<<pk.size()-1<<std::endl;
#pragma omp parallel for schedule(dynamic,1)
  for(int i=k+1;i<6;i++){UP g;for(int j=k+1;j<7;j++){M[i][j]=us(um(pk,M[i][j]),um(M[i][k],M[k][j]));if(!M[i][j].empty())g=g.empty()?uc(M[i][j],kinv(M[i][j].back())):ugfast(g,M[i][j]);}M[i][k]={};if(g.empty())throw std::runtime_error("zero primitive row");if(g.size()>1)for(int j=k+1;j<7;j++)M[i][j]=ux(M[i][j],g);
#pragma omp critical
  std::cout<<"row="<<i<<" removed_content_degree="<<g.size()-1<<" lastdegree="<<int(M[i][5].size())-1<<std::endl;
  }
  {std::ofstream o(file+".tmp",std::ios::binary);for(auto&row:M)for(auto&a:row)bs(o,a);o.flush();if(!o)throw std::runtime_error("write primitive checkpoint");}if(std::rename((file+".tmp").c_str(),file.c_str()))throw std::runtime_error("rename primitive checkpoint");
 }
 QA x;for(int i=5;i>=0;i--){if(M[i][i].empty())throw std::runtime_error("zero backsolve diagonal");UP rhs=um(x.d,M[i][6]);for(int j=i+1;j<6;j++)rhs=us(rhs,um(M[i][j],x.n[j]));UP g=ugfast(rhs,M[i][i]);UP multiplier=ux(M[i][i],g);x.n[i]=ux(rhs,g);for(int j=i+1;j<6;j++)x.n[j]=um(x.n[j],multiplier);x.d=um(x.d,multiplier);x.normal();std::cout<<"backsolve row="<<i<<" common_denominator_degree="<<x.d.size()-1<<std::endl;}
 UP D=x.d;x.d={1};QA check=qraw(p,x);if(check.n[0]!=D)throw std::runtime_error("scalar certificate mismatch");for(int j=1;j<6;j++)if(!check.n[j].empty())throw std::runtime_error("nonconstant certificate remainder");
 std::ofstream o(std::string(argv[3])+"_certificate.txt");saveu(o,D);saveq(o,x);std::ofstream n(std::string(argv[3])+"_norm.txt");saveu(n,D);std::cout<<"PASS exact_product_identity=1 scalar_degree="<<D.size()-1<<" adjugate_height="<<height(x)<<std::endl;return 0;
}catch(std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
