// Compute the common endpoint source before reducing modulo any H curve.
// This avoids repeated rational reductions inside the critical resultant.
#define main accepted_companion_main
#include "pro_companion140_20260928/src/native/companion.cpp"
#undef main
struct HR {
 Poly<Rat> p;
 HR(int k=0):p(Rat(k)){} HR(F k):p(Rat(k)){} explicit HR(Rat k):p(k){}
 explicit operator bool()const{return bool(p);}
 void normalize(){for(auto&c:p.c)c.normalize();p.trim();}
 friend HR operator+(const HR&a,const HR&b){HR z;z.p=a.p+b.p;return z;}
 friend HR operator-(const HR&a){HR z;z.p=-a.p;return z;}
 friend HR operator-(const HR&a,const HR&b){return a+-b;}
 friend HR operator*(const HR&a,const HR&b){HR z;z.p=a.p*b.p;z.normalize();return z;}
 HR&operator+=(const HR&b){return *this=*this+b;}HR&operator-=(const HR&b){return *this=*this-b;}HR&operator*=(const HR&b){return *this=*this*b;}
 friend bool operator==(const HR&a,const HR&b){return !bool(a-b);}
 HR inverse()const{assert(p.deg()==0);return HR(p[0].inverse());}
 friend HR operator/(const HR&a,const HR&b){return a*b.inverse();}
 HR fifth()const{HR z;z.p=p.fifth();z.normalize();return z;}
 HR pow(int n)const{if(n>=5)return pow(n%5)*fifth().pow(n/5);HR z(1),a=*this;while(n){if(n&1)z*=a;n>>=1;if(n)a*=a;}return z;}
};
int main(int argc,char**argv){try{
 if(argc<4)throw std::runtime_error("usage source-root model.json output.json");init(argv[1]);ptree data;boost::property_tree::read_json(argv[2],data);std::array<FP,5>poles;int i=0;for(auto&[k,r]:data.get_child("poles"))poles[i++]=frow(r);Rat::setup(FP(0),poles);HR q(ratrow(data.get_child("actual_q"))),h;h.p=Poly<Rat>(std::vector<Rat>{Rat(0),Rat(1)});auto st=std::chrono::steady_clock::now();auto co=weighted_small_critical(q,h*q);
 std::ofstream out(argv[3]);out<<"{\"scope\":\"Exact common source before H reduction; original units only\",\"poles\":[";for(int k=0;k<5;k++){if(k)out<<',';json(out,Rat::factors[k]);}out<<"],\"rows\":[";int maxh=0;
 for(int i=0;i<3;i++){if(i)out<<',';out<<'[';for(int j=0;j<3;j++){if(j)out<<',';out<<'[';for(int k=0;k<=co[i].c[j].deg();k++){if(k)out<<',';auto v=co[i].c[j][k];v.normalize();maxh=std::max(maxh,v.p.deg());json(out,v.p);}out<<']';}out<<']';}out<<"]}\n";std::cout<<"SOURCE_CACHE_PASS H_degree "<<maxh<<" seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-st).count()<<std::endl;
}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}}
