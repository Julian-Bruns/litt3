#include "field.hpp"
#include <chrono>
using namespace exact;
const std::array<F,10> ROOTS={9,14,2514,7367,20130,104315,139659,154113,281660,364472};
const std::array<F,10> QBOUND={10149,287131,206388,98115,363438,222658,366267,256870,262368,151691};
const std::array<F,10> QPIVOT={118020,113341,133780,96788,248365,389423,152600,227317,132264,310452};
struct Vmon{int block,i,j;};
using Source=std::array<Fun,4>;
std::vector<Vmon> mons;
F eps,eta,Cd,Ca;
Poly tp,U0;
void initdata(){init();eps=24+4*25+23*15625;eta=11+18*625+20*15625;Cd=3+10*25+625+14*15625;Ca=18+14*25+10*625+19*15625;tp=tpoly();U0=quo(Q-frob(L0),power(tp,3));
 for(int block=0;block<4;block++){int lim=std::array<int,4>{14,46,57,70}[block];for(int j=0;j<3;j++)for(int i=0;3*i+10*j<=lim;i++)mons.push_back({block,i,j});}
 assert(mons.size()==156);
}
Source fromvec(const std::vector<F>&v){Source out;for(unsigned i=0;i<mons.size();i++)if(v[i]){auto m=mons[i];out[m.block]=out[m.block]+monom(m.i,m.j+(m.block==0?2:0),v[i]);}return out;}
std::vector<F> constraints(const Source&s,F r){
 auto G2=s[0],G3=s[1],G4=s[2],G5=s[3];std::vector<F> out;
 auto append=[&](const Fun&f,const Poly&modulus){for(auto&a:f.a){auto rem=mod(a,modulus);for(int i=0;i<deg(modulus);i++)out.push_back(coeff(rem,i));}};
 std::array<Fun,3> numer={G3-scale(Fun(B0)*G2,3),G4-scale(Fun(B0)*G3,2)+scale(Fun(power(B0,2))*G2,3),G5-Fun(B0)*G4+Fun(power(B0,2))*G3-Fun(power(B0,3))*G2};
 for(int i=0;i<3;i++)for(int j=0;j<3;j++){
  unsigned n=(i+3-j+2)/3;Poly modulus=power(P,n);auto rem=mod(numer[i].a[j],modulus);for(int k=0;k<deg(modulus);k++)out.push_back(coeff(rem,k));
 }
 append(Fun(U0)*(G5-Fun(L0)*G4+Fun(power(L0,2))*G3-Fun(power(L0,3))*G2),power(tp,2));
 append(G4-scale(Fun(L0)*G3,2)+scale(Fun(power(L0,2))*G2,3),tp);
 auto D=divide_y(G2,2);out.push_back(eval(D.a[0],r));
 Fun total=Fun(Q)*G5;
 out.push_back(coeff(total.a[0],42));out.push_back(coeff(total.a[1],39));
 assert(out.size()==150);return out;
}
std::vector<F> rhs(){std::vector<F>b(150);Fun y10=monom(0,10);auto z=fmod(y10,power(tp,2));int idx=120;for(auto&p:z.a)for(int i=0;i<6;i++)b[idx++]=neg(coeff(p,i));
 Fun top=Fun(power(tp,3))*y10;b[148]=neg(coeff(top.a[0],42));b[149]=neg(coeff(top.a[1],39));return b;}
std::array<F,4> topcoords(const Source&s){auto D=divide_y(s[0],2);return {coeff(D.a[1],1),coeff(s[2].a[0],19),coeff(s[2].a[2],12),coeff(s[3].a[2],16)};}
struct Chart{F r;std::vector<std::vector<F>> vectors;std::vector<int> freecols;std::array<Source,7> s;};
Chart chart(F r){std::vector<std::vector<F>>m(154,std::vector<F>(161));auto b=rhs();for(unsigned j=0;j<156;j++){std::vector<F>v(156);v[j]=1;auto s=fromvec(v);auto c=constraints(s,r);for(int i=0;i<150;i++)m[i][j]=c[i];auto top=topcoords(s);for(int i=0;i<4;i++)m[150+i][j]=top[i];}
 for(int i=0;i<150;i++)m[i][156]=b[i];for(int i=0;i<4;i++)m[150+i][157+i]=1;
 auto rr=rref(m,156);assert(rr.piv.size()==154);std::vector<int>free;
 for(int j=0;j<156;j++)if(std::find(rr.piv.begin(),rr.piv.end(),j)==rr.piv.end())free.push_back(j);
 assert(free.size()==2);Chart c;c.r=r;c.freecols=free;c.vectors.resize(7,std::vector<F>(156));
 for(int k=0;k<5;k++)for(int i=0;i<154;i++)c.vectors[k][rr.piv[i]]=rr.m[i][156+k];
 for(int k=0;k<2;k++){c.vectors[5+k][free[k]]=1;for(int i=0;i<154;i++)c.vectors[5+k][rr.piv[i]]=neg(rr.m[i][free[k]]);}
 for(int k=0;k<7;k++){
  c.s[k]=fromvec(c.vectors[k]);auto out=constraints(c.s[k],r);assert(out==(k?std::vector<F>(150):b));auto top=topcoords(c.s[k]);for(int i=0;i<4;i++)assert(top[i]==F(k==i+1));
  assert(coeff(c.s[k][1].a[1],12)==(k==0?eps:0));
  assert(coeff(c.s[k][1].a[0],15)==add(mul(Ca,top[0]),mul(Cd,top[1])));
 }
 return c;
}
void writechart(const Chart&c,std::string file){std::ofstream o(file);o<<"{\n\"r\":"<<c.r<<",\n\"field\":\"F25(alpha), alpha^4+[7]alpha^3+[6]alpha^2+[2]alpha+[5]=0\",\n\"coordinates\":[\"constant\",\"h\",\"w\",\"e\",\"f\",\"k1\",\"k2\"],\n\"free_monomials\":[";
 for(int k=0;k<2;k++){if(k)o<<',';auto m=mons[c.freecols[k]];o<<'['<<m.block+2<<','<<m.i<<','<<m.j<<']';}o<<"],\n\"source\":[\n";
 for(int k=0;k<7;k++){if(k)o<<",\n";o<<'[';for(int b=0;b<4;b++){if(b)o<<',';printfun(o,c.s[k][b]);}o<<']';}o<<"]\n}\n";}
#ifndef RECONSTRUCT_LIBRARY
int main(int argc,char**argv){try{
 initdata();std::cout<<"field cardinality="<<CARD<<" primitive K-code="<<primitive<<"\n";
 assert(eval(A,25)==0);assert(diff(Q)==P*power(A,2));quo(Q-frob(B0),power(P,2));quo(Q-frob(L0),power(A,3));assert(gcd(P,diff(P))==Poly{1});assert(gcd(A,diff(A))==Poly{1});assert(gcd(P,A)==Poly{1});
 std::cout<<"PASS exact input identities, squarefreeness, coprimality\n";
 for(auto r:ROOTS)assert(eval(P,r)==0);auto rsort=ROOTS;std::sort(rsort.begin(),rsort.end());assert(std::adjacent_find(rsort.begin(),rsort.end())==rsort.end());
 std::cout<<"PASS ten distinct listed roots of P\n";
 std::string dest=argc>1?argv[1]:"data";
 for(unsigned j=0;j<ROOTS.size();j++){auto c=chart(ROOTS[j]);writechart(c,dest+"/chart_"+std::to_string(c.r)+".json");std::cout<<"r="<<c.r<<" rank=150 augmented_top_rank=154 affine_dimension=6 kernel_dimension=2 PASS all 7 source vectors and top-coordinate identities\n";}
 return 0;
 }catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
#endif
