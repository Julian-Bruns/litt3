// Exact marked-content function-field calculation. No square decision is
// inferred merely from constructing this model. All raw tails retain LC^63.
#define main accepted_companion_main
#include "pro_companion140_20260928/src/native/companion.cpp"
#undef main

#ifndef ROOT9_RANK
#define ROOT9_RANK 6
#endif
static constexpr int MRANK=ROOT9_RANK;

struct MR {
 std::array<Rat,MRANK> c{};
 static inline std::array<Rat,MRANK> mod;
 static std::vector<MR> powers;
 MR(int k=0){c[0]=Rat(k);}
 MR(F k){c[0]=Rat(k);}
 explicit MR(Rat r){c[0]=std::move(r);}
 explicit operator bool()const{for(auto&x:c)if(x)return true;return false;}
 void normalize(){for(auto&x:c){assert(!x.b);x.normalize();}}
 friend MR operator+(const MR&a,const MR&b){MR z;for(int i=0;i<MRANK;i++)z.c[i]=a.c[i]+b.c[i];return z;}
 friend MR operator-(const MR&a){MR z;for(int i=0;i<MRANK;i++)z.c[i]=-a.c[i];return z;}
 friend MR operator-(const MR&a,const MR&b){return a+-b;}
 friend MR operator*(const MR&a,const MR&b){
  std::array<Rat,2*MRANK-1> v{};for(int i=0;i<MRANK;i++)if(a.c[i])for(int j=0;j<MRANK;j++)if(b.c[j])v[i+j]+=a.c[i]*b.c[j];
  for(int i=2*MRANK-2;i>=MRANK;i--)if(v[i])for(int j=0;j<MRANK;j++)v[i-MRANK+j]-=v[i]*mod[j];
  MR z;for(int i=0;i<MRANK;i++)z.c[i]=std::move(v[i]);z.normalize();return z;
 }
 MR&operator+=(const MR&b){return *this=*this+b;}
 MR&operator-=(const MR&b){return *this=*this-b;}
 MR&operator*=(const MR&b){return *this=*this*b;}
 friend bool operator==(const MR&a,const MR&b){return !bool(a-b);}
 MR inverse()const{for(int i=1;i<MRANK;i++)if(c[i])throw std::runtime_error("non-scalar inverse not licensed");return MR(c[0].inverse());}
 friend MR operator/(const MR&a,const MR&b){return a*b.inverse();}
 MR fifth()const{MR z;for(int i=0;i<MRANK;i++)if(c[i]){Rat r=c[i].fifth();for(int j=0;j<MRANK;j++)z.c[j]+=r*powers[5*i].c[j];}z.normalize();return z;}
 MR pow(int n)const{if(n>=5)return pow(n%5)*fifth().pow(n/5);MR z(1),a=*this;while(n){if(n&1)z*=a;n>>=1;if(n)a*=a;}return z;}
 static void setup(std::array<Rat,MRANK>m){mod=m;powers={MR(1)};MR h;h.c[1]=Rat(1);for(int i=1;i<=5*(MRANK-1);i++)powers.push_back(powers.back()*h);}
};
std::vector<MR> MR::powers;
Rat readrat(const ptree&v){return Rat(frow(v.get_child("numerator")))/Rat(frow(v.get_child("denominator")));}
void save_mr(std::ostream&o,const MR&r){o<<'[';for(int j=0;j<MRANK;j++){if(j)o<<',';json(o,r.c[j].normalized());}o<<']';}
void stats(const std::string&label,const std::vector<MR>&v){int deg=-1;std::array<int,5>d{};for(auto&x:v)for(auto&r:x.c){auto z=r.normalized();deg=std::max(deg,z.a.deg());for(int k=0;k<5;k++)d[k]=std::max(d[k],z.den[k]);}std::cout<<"{\"stage\":\""<<label<<"\",\"numerator_degree\":"<<deg<<",\"den\":[";for(int k=0;k<5;k++){if(k)std::cout<<',';std::cout<<d[k];}std::cout<<"]}"<<std::endl;}
#ifndef ROOT9_MARKED_NO_MAIN
int main(int argc,char**argv){try{
 if(argc<4)throw std::runtime_error("usage source-root marked_curve.json output-prefix [tails]");
 init(argv[1]);ptree data;boost::property_tree::read_json(argv[2],data);auto started=std::chrono::steady_clock::now();
 std::vector<FP>fs={FP(std::vector<F>{0,1}),frow(SOURCE.get_child("D0_q"))};
 for(auto&[k,row]:data.get_child("mu_denominator_factors")){auto it=row.begin();FP f=frow(it->second);bool seen=false;for(auto&g:fs)if(f.monic()==g.monic())seen=true;if(!seen)fs.push_back(f);}
 while(fs.size()<5)fs.push_back(fs[0]);if(fs.size()>5)throw std::runtime_error("too many denominator factors");
 Rat::setup(FP(0),{fs[0],fs[1],fs[2],fs[3],fs[4]});std::array<Rat,6>m;int i=0;for(auto&[k,row]:data.get_child("J_monic_H")){if(i<6)m[i]=readrat(row);else assert(readrat(row)==Rat(1));i++;}assert(i==7);MR::setup(m);
 MR q(Rat(FP(std::vector<F>{0,1}))),h;h.c[1]=Rat(1);MR u=h*q,mu;i=0;for(auto&[k,row]:data.get_child("mu_H"))mu.c[i++]=readrat(row);mu.normalize();
 auto co=weighted_small_critical(q,u);std::cout<<"{\"stage\":\"source\",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-started).count()<<"}"<<std::endl;
 auto mu2=mu*mu;Curve<MR> g=co[0]+co[1]*Curve<MR>(Poly<MR>(mu))+co[2]*Curve<MR>(Poly<MR>(mu2));
 auto pq=Curve<MR>::PQ;auto rr=(g.c[0].pow(3)+g.c[1].pow(3)*pq+g.c[2].pow(3)*pq.pow(2)-(g.c[0]*g.c[1]*g.c[2]*pq).scale(MR(3))).scale(q.inverse());
 assert(rr.deg()==140);for(auto&x:rr.c)x.normalize();stats("residual",rr.c);
 std::ofstream out(std::string(argv[3])+".residual.json");out<<"{\"scope\":\"Exact high coefficients x^67 through x^140; low coefficients unused\",\"poles\":[";for(int k=0;k<5;k++){if(k)out<<',';json(out,Rat::factors[k]);}out<<"],\"coefficients\":[";for(int k=0;k<=140;k++){if(k)out<<',';save_mr(out,rr[k]);}out<<"]}\n";out.close();
 if(argc<5)return 0;
 const int N=74;std::vector<MR>a(N);for(int k=0;k<N;k++)a[k]=rr[140-k];
 auto mul=[&](const std::vector<MR>&a,const std::vector<MR>&b){std::vector<MR>z(N);for(int k=0;k<N;k++){for(int j=0;j<=k;j++)if(a[j]&&b[k-j])z[k]+=a[j]*b[k-j];z[k].normalize();}return z;};
 auto frob=[&](const std::vector<MR>&v,int e){std::vector<MR>z(N);for(int k=0;e*k<N;k++)z[e*k]=v[k].pow(e);return z;};
 auto a2=mul(a,a);stats("a2",a2);auto a3=mul(a2,a);stats("a3",a3);auto a13=mul(a3,frob(a2,5));stats("a13",a13);auto a63=mul(a13,frob(a2,25));stats("a63",a63);
 std::ofstream tail(std::string(argv[3])+".tails.json");tail<<"{\"raw_exponent\":63,\"tails\":[";for(int k=71;k<=73;k++){if(k>71)tail<<',';save_mr(tail,a63[k]);}tail<<"]}\n";
 std::cout<<"{\"completed\":true,\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-started).count()<<"}"<<std::endl;
}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}}
#endif
