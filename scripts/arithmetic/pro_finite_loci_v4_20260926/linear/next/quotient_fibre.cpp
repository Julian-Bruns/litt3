#include "../src/residual.hpp"
#include "io_dft.hpp"
struct Split:std::exception{Poly factor;Split(Poly p):factor(p){}};
inline Poly modulus;
struct RP{
 std::vector<Poly> c;
 RP()=default;RP(int a){if(a)c={Poly(a)%modulus};}
 RP(Poly a){a=a%modulus;if(a)c={a};}
 void trim(){while(!c.empty()&&!c.back())c.pop_back();}
 int deg()const{return int(c.size())-1;}
 Poly operator[](int i)const{return i>=0&&i<(int)c.size()?c[i]:Poly();}
 explicit operator bool()const{return !c.empty();}
 RP operator+(const RP& b)const{RP a=*this;a.c.resize(std::max(c.size(),b.c.size()));for(size_t i=0;i<b.c.size();i++)a.c[i]=(a.c[i]+b.c[i])%modulus;a.trim();return a;}
 RP operator-()const{RP a=*this;for(auto& c:a.c)c=-c;return a;}
 RP operator-(const RP& b)const{return *this+-b;}
 RP operator*(const RP& b)const{RP a;if(!*this||!b)return a;a.c.resize(c.size()+b.c.size()-1);for(size_t i=0;i<c.size();i++)if(c[i])for(size_t j=0;j<b.c.size();j++)if(b.c[j])a.c[i+j]=(a.c[i+j]+c[i]*b.c[j])%modulus;a.trim();return a;}
 RP scalar(const Poly& b)const{return *this*RP(b);}
 bool operator==(const RP& b)const{return c==b.c;}
 std::pair<RP,RP> divrem(const RP& b)const{if(!b)throw std::runtime_error("ring polynomial div0");auto[g,iv,tmp]=xgcd(b.c.back(),modulus);if(g.deg()!=0)throw Split(g);RP a=*this,q;int dd=deg()-b.deg();if(dd<0)return {q,a};q.c.resize(dd+1);for(int i=dd;i>=0;i--){Poly z=(a[i+b.deg()]*iv)%modulus;q.c[i]=z;if(z)for(int j=0;j<=b.deg();j++)a.c[i+j]=(a.c[i+j]-z*b.c[j])%modulus;}a.trim();q.trim();return {q,a};}
};
Poly loadp(fs::path p){std::ifstream f(p,std::ios::binary);int nr=read32(f),nc=read32(f);if(nr!=1)throw std::runtime_error("not vector");f.close();return Poly(read_rows(p,nr,nc)[0]);}
RP loade(fs::path p){std::ifstream f(p,std::ios::binary);int nr=read32(f),nc=read32(f);f.close();auto rows=read_rows(p,nr,nc);RP a;a.c.resize(nc);for(int l=0;l<nc;l++){Poly h;for(auto row:rows)h.c.push_back(row[l]);h.trim();a.c[l]=h%modulus;}a.trim();return a;}
void saveRP(fs::path p,const RP& a){Rows r(std::max(1,(int)a.c.size()),std::vector<F>(modulus.deg()));for(int l=0;l<(int)a.c.size();l++)for(int h=0;h<modulus.deg();h++)r[l][h]=a.c[l][h];write_rows(p,r);}
fs::path dir;int serial=0;bool all_excluded=true;
void run(Poly p){modulus=p;int id=serial++;fs::path out=dir/("quotient_"+std::to_string(id));fs::create_directories(out);write_rows(out/"modulus.bin",Rows{p.c});std::cout<<"component "<<id<<" H-degree="<<p.deg()<<"\n"<<std::flush;
 try{std::vector<RP> eq;for(int n=71;n<=77;n++)eq.push_back(loade(dir/("E"+std::to_string(n)+".bin")));RP g;std::vector<RP> U(7);
  for(int k=0;k<7;k++){RP a=g,b=eq[k];std::vector<RP> s=U,t(7);t[k]=RP(1);while(b){auto[q,r]=a.divrem(b);a=b;b=r;auto v=s;for(int j=0;j<7;j++)v[j]=s[j]-q*t[j];s=t;t=v;}
   if(!a){g=a;U=s;continue;}auto[gg,iv,z]=xgcd(a.c.back(),modulus);if(gg.deg())throw Split(gg);g=a.scalar(iv);for(auto& x:s)x=x.scalar(iv);U=s;std::cout<<" after E"<<71+k<<" gcd mu-degree="<<g.deg()<<"\n"<<std::flush;if(g.deg()==0)break;
  }
  RP chk;for(int j=0;j<7;j++)chk=chk+U[j]*eq[j];if(!(chk==g))throw std::runtime_error("quotient Bezout mismatch");int count=0;for(auto c:g.c)if(c)count++;bool excl=g&&count==1;all_excluded&=excl;saveRP(out/"gcd.bin",g);for(int j=0;j<7;j++)saveRP(out/("U"+std::to_string(71+j)+".bin"),U[j]);std::ofstream f(out/"summary.json");f<<"{\"modulus_degree\":"<<p.deg()<<",\"gcd_mu_degree\":"<<g.deg()<<",\"monomial_gcd\":"<<(excl?"true":"false")<<",\"bezout_verified\":true,\"excluded_on_mu_nonzero\":"<<(excl?"true":"false")<<"}\n";std::cout<<" component "<<id<<" Bezout verified, excluded="<<excl<<"\n"<<std::flush;
 }catch(Split& s){Poly other=p.exactdiv(s.factor);if(gcd(s.factor,other).deg())throw std::runtime_error("non-coprime splitting");write_rows(out/"split_factor.bin",Rows{s.factor.c});write_rows(out/"split_other.bin",Rows{other.c});std::ofstream f(out/"summary.json");f<<"{\"split\":true,\"factor_degree\":"<<s.factor.deg()<<",\"other_degree\":"<<other.deg()<<"}\n";f.close();std::cout<<" split into "<<s.factor.deg()<<","<<other.deg()<<"\n"<<std::flush;run(s.factor);run(other);}
}
int main(int argc,char**argv){try{input::init();dir=argc>1?argv[1]:"next/r9";auto p=loadp(dir/"gcd_radical_candidate.bin");if(gcd(p,p.deriv()).deg())throw std::runtime_error("input not squarefree");run(p);std::ofstream f(dir/"quotient_summary.json");f<<"{\"components_visited\":"<<serial<<",\"all_geometric_H_mu_candidates_excluded\":"<<(all_excluded?"true":"false")<<"}\n";return 0;}catch(std::exception&e){std::cerr<<"ERROR "<<e.what()<<"\n";return 1;}}
