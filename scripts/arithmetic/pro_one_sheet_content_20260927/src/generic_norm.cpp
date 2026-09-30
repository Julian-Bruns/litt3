#define USE_GMP_PACKING
#include "fast_univariate.hpp"
#include <cstdio>
static void readF(std::istream&in){std::string name;int n;in>>name>>n;assert(name=="F");for(int k=0;k<n;k++){int v,s;U c;in>>v>>s>>c;if(s==6){assert(!v&&c==1);continue;}F[s].resize(std::max(F[s].size(),size_t(v+1)));F[s][v]=c;}}
static void saveu(std::ostream&o,const UP&p){o<<p.size();for(U c:p)o<<" "<<c;o<<"\n";}
static UP loadu(std::istream&i){int n;i>>n;UP p(n);for(U&c:p)i>>c;if(!i)throw std::runtime_error("bad polynomial");return p;}
static void bs(std::ostream&o,const UP&p){uint64_t n=p.size();o.write((char*)&n,sizeof(n));o.write((char*)p.data(),n*sizeof(U));}
static UP bl(std::istream&i){uint64_t n;i.read((char*)&n,sizeof(n));UP p(n);i.read((char*)p.data(),n*sizeof(U));if(!i)throw std::runtime_error("bad checkpoint");return p;}
int main(int argc,char**argv){try{if(argc!=4){std::cerr<<"usage: generic_norm chart tail_file output_prefix\n";return 2;}initfield(nullptr);std::ifstream fi(argv[1]);U r;fi>>r;readF(fi);SP[0]=QA(1);SP[1].n[1]={1};for(int i=2;i<126;i++)SP[i]=SP[i-1]*SP[1];std::ifstream ci(argv[2]);QA p=loadq(ci);UP den=p.d;p.d={1};std::array<std::array<UP,7>,6>M;for(int j=0;j<6;j++){QA u=qraw(p,SP[j]);assert(u.d==UP{1});for(int i=0;i<6;i++)M[i][j]=std::move(u.n[i]);}M[0][6]={1};UP prev={1};
 for(int k=0;k<5;k++){std::string filename=std::string(argv[3])+"_stage"+std::to_string(k)+".bin";std::ifstream cached(filename,std::ios::binary);if(cached){prev=bl(cached);for(auto&row:M)for(auto&a:row)a=bl(cached);std::cout<<"loaded stage="<<k<<" pivotdegree="<<prev.size()-1<<std::endl;continue;}int pivot=k;while(pivot<6&&M[pivot][k].empty())pivot++;if(pivot==6)throw std::runtime_error("zero norm: singular multiplication matrix");if(pivot!=k)std::swap(M[pivot],M[k]);UP pk=M[k][k];std::cout<<"start stage="<<k<<" pivotdegree="<<pk.size()-1<<std::endl;
#pragma omp parallel for schedule(dynamic,1)
 for(int i=k+1;i<6;i++){for(int j=k+1;j<7;j++)M[i][j]=ux(us(um(pk,M[i][j]),um(M[i][k],M[k][j])),prev);M[i][k]={};}
 prev=std::move(pk);{std::ofstream out(filename+".tmp",std::ios::binary);bs(out,prev);for(auto&row:M)for(auto&a:row)bs(out,a);out.flush();if(!out)throw std::runtime_error("failed stage checkpoint write");}if(std::rename((filename+".tmp").c_str(),filename.c_str()))throw std::runtime_error("failed atomic stage rename");std::cout<<"finish stage="<<k<<" lastdegree="<<int(M[5][5].size())-1<<std::endl;}
 UP D=M[5][5];if(D.empty())throw std::runtime_error("norm identically zero");QA x;for(int i=5;i>=0;i--){UP rhs=um(D,M[i][6]);for(int j=i+1;j<6;j++)rhs=us(rhs,um(M[i][j],x.n[j]));x.n[i]=ux(rhs,M[i][i]);}
 size_t raw_degree=D.size()-1;x.d=D;x.normal();D=x.d;x.d={1};std::cout<<"primitive elimination scalar raw_degree="<<raw_degree<<" reduced_degree="<<D.size()-1<<" adjugate_height="<<height(x)<<std::endl;
 QA chk=qraw(p,x);if(chk.n[0]!=D)throw std::runtime_error("norm certificate constant mismatch");for(int i=1;i<6;i++)if(!chk.n[i].empty())throw std::runtime_error("norm certificate nonconstant remainder");
 std::ofstream o(std::string(argv[3])+"_certificate.txt");saveu(o,D);saveq(o,x);std::ofstream nd(std::string(argv[3])+"_norm.txt");saveu(nd,D);std::cout<<"PASS elimination_scalar_degree="<<D.size()-1<<" adjugate_height="<<height(x)<<" exact_product_identity=1\n";
 return 0;}catch(std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
