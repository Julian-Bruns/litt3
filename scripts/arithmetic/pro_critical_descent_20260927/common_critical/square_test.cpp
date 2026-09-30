// Exact square obstructions and Bezout identities over every incidence field.
#define RESIDUAL_NO_MAIN
#include "residual.cpp"
using UP=vector<E>;
void ut(UP&a){while(a.size()&&a.back().empty())a.pop_back();}
UP ua(UP a,const UP&b){a.resize(max(a.size(),b.size()));for(int i=0;i<(int)b.size();i++)a[i]=ea(a[i],b[i]);ut(a);return a;}
UP un(UP a){for(auto&v:a)v=en(v);return a;}
UP us(UP a,const UP&b){return ua(a,un(b));}
UP uc(UP a,const E&c){for(auto&v:a)v=em(v,c);ut(a);return a;}
UP um(const UP&a,const UP&b){if(a.empty()||b.empty())return {};UP c(a.size()+b.size()-1);for(int i=0;i<(int)a.size();i++)if(a[i].size())for(int j=0;j<(int)b.size();j++)if(b[j].size())c[i+j]=ea(c[i+j],em(a[i],b[j]));ut(c);return c;}
UP uf(UP a,int n){if(a.empty())return {};int e=n==1?5:25;UP b((a.size()-1)*e+1);for(int i=0;i<(int)a.size();i++){E c=a[i];for(int j=0;j<n;j++)c=ef(c);b[i*e]=c;}ut(b);return b;}
pair<UP,UP> ud(UP a,const UP&b){if(b.empty())abort();UP q(max(0,int(a.size())-int(b.size())+1));E ib=invmod(b.back(),MOD);while(a.size()>=b.size()){
 int j=a.size()-b.size();E c=em(a.back(),ib);q[j]=c;for(int i=0;i<(int)b.size();i++)a[i+j]=es(a[i+j],em(c,b[i]));ut(a);
}ut(q);return {q,a};}
struct EG{UP g,u,v;};
EG ugcd(UP r,UP s){
 UP u={E{1}},v={},uu={},vv={E{1}};
 while(!s.empty()){
  auto [q,t]=ud(r,s);r=s;s=t;
  UP z=us(u,um(q,uu));u=uu;uu=z;
  z=us(v,um(q,vv));v=vv;vv=z;
 }
 if(r.empty())return {r,u,v};E c=invmod(r.back(),MOD);return {uc(r,c),uc(u,c),uc(v,c)};
}
vector<UP> AH,A2,A3;vector<bool> computed;
UP acube(int n){
 if(computed[n])return A3[n];UP out;
 for(int i=0;i<=n;i++)out=ua(out,um(A2[i],AH[n-i]));
 A3[n]=out;computed[n]=true;return out;
}
UP obstruct(int n){
 UP out;
 for(int k=0;k<=n/25;k++){
  UP c=uf(A2[k],2);if(c.empty())continue;
  for(int j=0;j<=(n-25*k)/5;j++){
   UP b=uf(A2[j],1);if(b.empty())continue;
   out=ua(out,um(um(acube(n-25*k-5*j),b),c));
  }
 }
 return out;
}
void savepoly(ofstream&o,const UP&p){o<<p.size()<<"\n";for(E v:p){v.resize(ND);for(int c:v)o<<c<<" ";o<<"\n";}}

#ifndef SQUARE_TEST_NO_MAIN
int main(int argc,char**argv){
 if(argc<5){cerr<<"usage square_test field.bin factors.txt residual_directory out_directory [only_factor_index]\n";return 2;}
 initfield(argv[1]);string indir=argv[3],outdir=argv[4];filesystem::create_directories(outdir);
 ifstream f(argv[2]);int nf;f>>nf;vector<KP> facs;for(int i=0;i<nf;i++){int n;f>>n;KP v(n);for(int&c:v)f>>c;facs.push_back(v);}
 auto start=chrono::steady_clock::now();
 for(int k=0;k<nf;k++){
  if(argc>=6&&k!=stoi(argv[5]))continue;
  MOD=facs[k];ND=MOD.size()-1;FROB.clear();E z={1};for(int j=0;j<ND;j++){FROB.push_back(z);z=eqshift(z,5);}
  ifstream in(indir+"/residual_"+to_string(k)+".txt");int dd,nmu,nx;in>>dd>>nmu>>nx;if(dd!=ND||nmu!=7||nx!=141)abort();
  AH=vector<UP>(141,UP(7));for(int i=0;i<7;i++)for(int j=0;j<141;j++){E c(ND);for(int&v:c)in>>v;trim(c);AH[140-j][i]=c;}
  for(auto&p:AH)ut(p);
  if(AH[0].size()!=1)abort();E ilc=invmod(AH[0][0],MOD);for(auto&p:AH)p=uc(p,ilc);
  const int MAX=80;A2=vector<UP>(MAX+1);A3=vector<UP>(MAX+1);computed=vector<bool>(MAX+1,false);
  for(int n=0;n<=MAX;n++){
   UP out;for(int j=0;j<=n/2;j++){UP term=um(AH[j],AH[n-j]);if(2*j!=n)term=uc(term,E{2});out=ua(out,term);}A2[n]=out;
  }
  cerr<<"factor="<<k<<" degree="<<ND<<" normalized and Ahat^2 computed sec="<<chrono::duration<double>(chrono::steady_clock::now()-start).count()<<endl;
  vector<UP> ob,bez;vector<int> indices;UP gg;bool excluded=false;
  for(int n=71;n<=MAX;n++){
   UP p=obstruct(n);ob.push_back(p);indices.push_back(n);
   if(n==71){gg=p;bez={UP{E{1}}};}
   else{
    EG r=ugcd(gg,p);for(auto&b:bez)b=um(r.u,b);bez.push_back(r.v);gg=r.g;
   }
   cerr<<"factor="<<k<<" coefficient="<<n<<" degree_ell="<<int(p.size())-1<<" gcd_degree="<<int(gg.size())-1<<" sec="<<chrono::duration<double>(chrono::steady_clock::now()-start).count()<<endl;
   if(gg.size()){
    bool monomial=true;for(int i=0;i+1<(int)gg.size();i++)if(gg[i].size())monomial=false;
    if(monomial){
     // Normalize, then verify sum_i bez_i * obstruction_i = ell^m exactly.
     E c=invmod(gg.back(),MOD);for(auto&b:bez)b=uc(b,c);gg=uc(gg,c);
     UP check;for(int i=0;i<(int)ob.size();i++)check=ua(check,um(bez[i],ob[i]));if(check!=gg)abort();
     ofstream out(outdir+"/square_certificate_"+to_string(k)+".txt");out<<ND<<" "<<ob.size()<<" "<<gg.size()-1<<"\n";
     for(int i=0;i<(int)ob.size();i++){out<<indices[i]<<"\n";savepoly(out,ob[i]);savepoly(out,bez[i]);}
     cerr<<"EXCLUDED factor="<<k<<" certificate_rhs=ell^"<<gg.size()-1<<" exact_Bezout_verified\n";excluded=true;break;
    }
   }
  }
  if(!excluded){cerr<<"UNRESOLVED factor="<<k<<" after coefficients 71.."<<MAX<<endl;return 10;}
 }
 cerr<<"ALL_FACTORS_EXCLUDED sec="<<chrono::duration<double>(chrono::steady_clock::now()-start).count()<<endl;
}

#endif
