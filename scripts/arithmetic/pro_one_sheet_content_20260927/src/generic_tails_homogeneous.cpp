#define USE_GMP_PACKING
#include "polynomial_series.hpp"
static void readF(std::istream&i){std::string name;int n;i>>name>>n;assert(name=="F");for(int k=0;k<n;k++){int v,s;U c;i>>v>>s>>c;if(s==6){assert(!v&&c==1);continue;}F[s].resize(std::max(F[s].size(),size_t(v+1)));F[s][v]=c;}}
int main(int argc,char**argv){try{if(argc!=6){std::cerr<<"usage: generic_tails_homogeneous chart coordinates Ecache prefix branch\n";return 2;}initfield(nullptr);std::ifstream ch(argv[1]);U r;ch>>r;readF(ch);SP[0]=QA(1);SP[1].n[1]={1};for(int i=2;i<126;i++)SP[i]=SP[i-1]*SP[1];std::ifstream co(argv[2]);QA H=loadq(co);std::array<QA,4>mu;for(auto&m:mu)m=loadq(co);int branch=std::stoi(argv[5]);assert(branch>=0&&branch<4);QA scalevar=mu[branch],musq=scalevar*scalevar;
 std::ifstream ee(argv[3]);std::array<std::array<std::array<QA,47>,3>,3>E;for(auto&mm:E)for(auto&yy:mm)for(auto&c:yy)c=loadq(ee);
 std::array<PSeries,3>e;int degree[3]={46,43,40};UP D={1};for(int j=0;j<3;j++){e[j].resize(PS_PREC);for(int i=0;i<=degree[j];i++){int x=degree[j]-i;e[j][i]=E[0][j][x]+E[1][j][x]*scalevar+E[2][j][x]*musq;auto&d=e[j][i].d;D=um(D,ux(d,ug(D,d)));}}
 QA ell=e[2][0];for(auto&a:e)for(auto&q:a){UP m=ux(D,q.d);for(auto&p:q.n)p=um(p,m);q.d={1};}
 std::cout<<"E homogeneous denominator_degree="<<D.size()-1<<" maxdegrees="<<ps_vd(e[0])<<","<<ps_vd(e[1])<<","<<ps_vd(e[2])<<std::endl;
 auto a3=ps_mul(ps_mul(e[0],e[0],true),e[0]);std::cout<<"a3 complete\n"<<std::flush;
 auto b3=ps_mul(ps_mul(e[1],e[1],true),e[1]);std::cout<<"b3 complete\n"<<std::flush;
 auto c3=ps_mul(ps_mul(e[2],e[2],true),e[2]);std::cout<<"c3 complete\n"<<std::flush;
 auto abc=ps_mul(ps_mul(e[0],e[1]),e[2]);std::cout<<"abc complete\n"<<std::flush;
 UP P={11,22,18,5,19,20,15,16,9,22,1};U pr=ue(P,r);std::reverse(P.begin(),P.end());UP v6(7),v3(4);v6[6]=1;v3[3]=pr;
 PSeries V=ps_add(ps_add(ps_scalar(c3,um(P,P),v6),ps_shift(ps_scalar(ps_add(b3,ps_scale(abc,2)),P,v3),1)),ps_shift(ps_scalar(a3,{1},{kmul(pr,pr)}),2));
 UP base=um(v6,up(D,3));QA ilc=scalar(powq(inverse(ell),3),{1},base);assert((V[0]*ilc-QA(1)).zero());
#pragma omp parallel for schedule(dynamic,1)
 for(int i=0;i<PS_PREC;i++)V[i]=V[i]*ilc;
 std::ofstream o(std::string(argv[4])+"_U.txt");o<<PS_PREC<<"\n";for(auto&q:V)saveq(o,q);std::cout<<"normalized_U complete precision=73\n";return 0;
}catch(std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
