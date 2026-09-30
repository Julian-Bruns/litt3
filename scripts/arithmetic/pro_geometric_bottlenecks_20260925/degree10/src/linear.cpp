#include "algebra.hpp"
using namespace alg;
struct Var{int i,a,b;};
struct Point{array<Ar,6>N; F k=0; Ar D2;};
vector<Var> vars;
Point unit(int j){Point p;if(j<0)return p;auto v=vars[j];if(v.i==6)p.k=1;else if(v.i==2){p.D2=ax(v.a,v.b);p.N[2]=am(ax(0,2),p.D2);}else p.N[v.i]=ax(v.a,v.b);return p;}
Poly tt;
vector<F> constraints(const Point&p,bool lin,F r){
 vector<F> out;
 for(int j=1;j<=5;j++){
  Ar c;for(int i=0;i<=j;i++)c=aa(c,ap(p.N[i],scale(pp(scale(B,4),j-i),binom(5-i,j-i))));
  for(int b=0;b<3;b++){
   int exponent=max(0,(j-b+2)/3);Poly z=rem(c[b],pp(P,exponent));
   for(int a=0;a<10*exponent;a++)out.push_back(coeff(z,a));
  }
 }
 for(int j=0;j<=4;j++){
  Ar c;for(int i=0;i<=5-j;i++)c=aa(c,ap(p.N[i],scale(pp(scale(L,4),5-i-j),binom(5-i,j))));
  c=ap(c,ps(Q,pp(L,5)));if(j==0)c=aa(c,ac(ap(ax(0,10),pp(tt,3)),p.k));
  c=ar(c,pp(tt,5-j));for(int b=0;b<3;b++)for(int a=0;a<3*(5-j);a++)out.push_back(coeff(c[b],a));
 }
 for(int j=0;j<=10;j++){
  Ar c;if(j<=5)c=p.N[j];if(j>=5)c=aa(c,ap(p.N[j-5],Q));if(j==10)c=aa(c,ac(ap(ax(0,10),pp(tt,3)),p.k));
  int d=10+12*j-max(0,j-5);
  for(int b=0;b<3;b++)for(int a=0;a<=50;a++)if(3*a+10*b>d)out.push_back(coeff(c[b],a));
 }
 if(lin)out.push_back(eval(p.D2[0],r));else out.push_back(coeff(p.D2[1],1));
 return out;
}
int main(int argc,char**argv){
 try{
 init();tt=scale(exact(A,Poly{neg(25),1}),inv(13));
 cout<<"field q="<<q<<" primitive="<<primitive<<" alpha=25\n";
 if(!rem(ps(Q,pp(B,5)),pp(P,2)).empty())throw runtime_error("B identity");
 if(!rem(ps(Q,pp(L,5)),pp(A,3)).empty())throw runtime_error("L identity");
 if(derivative(Q)!=pm(P,pp(A,2)))throw runtime_error("Q derivative");
 auto rr=roots(P);if(rr.size()!=10)throw runtime_error("P roots");cout<<"P roots:";for(auto r:rr)cout<<" "<<r;cout<<"\n";
 vars.clear();for(auto [a,b]:basis(14))vars.push_back({2,a,b});for(int i=3;i<=5;i++)for(auto [a,b]:basis(i==3?46:i==4?57:70))vars.push_back({i,a,b});vars.push_back({6,0,0});
 string dir=argc>1?argv[1]:"data";
 ofstream fields(dir+"/field.json");fields<<"{\"characteristic\":5,\"q\":"<<q<<",\"primitive\":"<<primitive<<",\"alpha\":25,\"t\":";jpoly(fields,tt);fields<<",\"P_roots\":";jpoly(fields,rr);fields<<",\"variables\":[";for(size_t j=0;j<vars.size();j++){if(j)fields<<",";fields<<"["<<vars[j].i<<","<<vars[j].a<<","<<vars[j].b<<"]";}fields<<"]}\n";
 for(int caseid=0;caseid<=10;caseid++){
  bool lin=caseid>0;F r=lin?rr[caseid-1]:0;Point origin;origin.N[0][0]=lin?Poly{neg(r),1}:Poly{1};
  vector<F> rhs=constraints(origin,lin,r);int m=rhs.size(),n=vars.size();vector<vector<F>> mat(m,vector<F>(n+1));
  for(int k=0;k<m;k++)mat[k][n]=neg(rhs[k]);
  for(int j=0;j<n;j++){auto col=constraints(unit(j),lin,r);for(int k=0;k<m;k++)mat[k][j]=col[k];}
  vector<int> piv;int rank=0;
  for(int j=0;j<n;j++){
   int k=rank;while(k<m&&!mat[k][j])k++;if(k==m)continue;swap(mat[k],mat[rank]);
   F c=inv(mat[rank][j]);for(int l=j;l<=n;l++)mat[rank][l]=mul(mat[rank][l],c);
   for(int i=0;i<m;i++)if(i!=rank&&mat[i][j]){F c=mat[i][j];for(int l=j;l<=n;l++)mat[i][l]=sub(mat[i][l],mul(c,mat[rank][l]));}
   piv.push_back(j);rank++;
  }
  for(int k=rank;k<m;k++)if(mat[k][n])throw runtime_error("inconsistent linear system");
  vector<int> free;for(int j=0;j<n;j++)if(find(piv.begin(),piv.end(),j)==piv.end())free.push_back(j);
  if(free.size()!=7)throw runtime_error("dimension not seven");
  vector<F> particular(n);for(int i=0;i<rank;i++)particular[piv[i]]=mat[i][n];vector<vector<F>> null;
  for(int j:free){vector<F>z(n);z[j]=1;for(int i=0;i<rank;i++)z[piv[i]]=neg(mat[i][j]);null.push_back(z);}
  // Freshly reconstruct the affine point and homogeneous directions and recheck.
  for(int s=-1;s<int(null.size());s++){
   auto &w=s<0?particular:null[s];Point p=s<0?origin:Point{};
   for(int j=0;j<n;j++)if(w[j]){Point u=unit(j);p.k=add(p.k,mul(w[j],u.k));p.D2=aa(p.D2,ac(u.D2,w[j]));for(int i=0;i<6;i++)p.N[i]=aa(p.N[i],ac(u.N[i],w[j]));}
   auto z=constraints(p,lin,r);for(F e:z)if(e)throw runtime_error("reconstruction did not satisfy constraints");
   F E=add(add(24,mul(4,25)),mul(23,alg::pow(25,3)));
   F eta=add(add(11,mul(18,alg::pow(25,2))),mul(20,alg::pow(25,3)));
   if(coeff(p.N[3][1],12)!=mul(E,p.k))throw runtime_error("universal N3 coefficient");
   if(coeff(p.N[5][1],20)!=mul(8,p.k)||coeff(p.N[5][0],23))throw runtime_error("universal N5 infinity coefficients");
   Ar constant=aa(ap(p.N[5],Q),ac(ap(ax(0,10),pp(tt,3)),p.k));
   if(coeff(constant[1],38)!=mul(eta,p.k))throw runtime_error("universal coefficient 124");
   F HH=0;const int cc[4]={2,6,3,12};
   for(int j=0;j<4;j++)HH=add(HH,mul(cc[j],coeff(p.D2[0],j)));
   if(coeff(p.D2[0],4)!=HH)throw runtime_error("D2 Cartier hyperplane");
  }
  ofstream out(dir+"/space_"+to_string(caseid)+".json");out<<"{\"case\":"<<caseid<<",\"linear\":"<<(lin?"true":"false")<<",\"r\":"<<r<<",\"rows\":"<<m<<",\"columns\":"<<n<<",\"rank\":"<<rank<<",\"free_indices\":[";for(size_t j=0;j<free.size();j++){if(j)out<<",";out<<free[j];}out<<"],\"particular\":";jpoly(out,particular);out<<",\"directions\":[";for(size_t j=0;j<null.size();j++){if(j)out<<",";jpoly(out,null[j]);}out<<"]}\n";
  cout<<"case "<<caseid<<" r="<<r<<" rows="<<m<<" cols="<<n<<" rank="<<rank<<" affine dimension="<<free.size()<<" all 8 reconstructions and universal coefficient identities pass\n";
 }
 }catch(exception&e){cerr<<"ERROR: "<<e.what()<<"\n";return 1;}
}
