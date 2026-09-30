// Certificate verifier: reconstruct the two coefficients and check Bezout=1.
#define SQUARE_TEST_NO_MAIN
#include "square_test.cpp"
UP readup(ifstream&in){int n;in>>n;if(n<0||n>1000)abort();UP p(n);for(E&v:p){v.resize(ND);for(int&c:v){in>>c;if(c<0||c>=NN)abort();}trim(v);}ut(p);return p;}
int main(int argc,char**argv){
 if(argc!=5){cerr<<"usage verify_square field.bin factors.txt residual_directory certificate_directory\n";return 2;}
 initfield(argv[1]);ifstream ff(argv[2]);int nf;ff>>nf;vector<KP> facs;for(int k=0;k<nf;k++){int n;ff>>n;KP p(n);for(int&c:p)ff>>c;facs.push_back(p);}
 for(int k=0;k<nf;k++){
  MOD=facs[k];ND=MOD.size()-1;FROB.clear();E z={1};for(int j=0;j<ND;j++){FROB.push_back(z);z=eqshift(z,5);}
  ifstream in(string(argv[3])+"/residual_"+to_string(k)+".txt");int dd,nmu,nx;in>>dd>>nmu>>nx;if(dd!=ND||nmu!=7||nx!=141)abort();
  AH=vector<UP>(141,UP(7));for(int i=0;i<7;i++)for(int j=0;j<141;j++){E c(ND);for(int&v:c)in>>v;trim(c);AH[140-j][i]=c;}if(!in)abort();for(auto&p:AH)ut(p);
  if(AH[0].size()!=1)abort();E ilc=invmod(AH[0][0],MOD);for(auto&p:AH)p=uc(p,ilc);
  A2=vector<UP>(73);A3=vector<UP>(73);computed=vector<bool>(73,false);
  for(int n=0;n<=72;n++)for(int j=0;j<=n/2;j++){UP term=um(AH[j],AH[n-j]);if(2*j!=n)term=uc(term,E{2});A2[n]=ua(A2[n],term);}
  ifstream cert(string(argv[4])+"/square_certificate_"+to_string(k)+".txt");int deg,count,rhs;cert>>deg>>count>>rhs;if(deg!=ND||count!=2||rhs!=0)abort();
  UP sum;
  for(int j=0;j<2;j++){
   int index;cert>>index;if(index!=71+j)abort();UP p=readup(cert),b=readup(cert);UP actual=obstruct(index);
   if(actual!=p){cerr<<"OBSTRUCTION_MISMATCH factor="<<k<<" index="<<index<<endl;return 3;}
   if(p.size()!=48)abort();sum=ua(sum,um(b,p));
   cerr<<"factor="<<k<<" index="<<index<<" obstruction_degree="<<p.size()-1<<" Bezout_multiplier_degree="<<int(b.size())-1<<" reconstructed\n";
  }
  if(!cert||sum!=UP{E{1}}){cerr<<"BEZOUT_FAILURE factor="<<k<<endl;return 4;}
  cerr<<"CERTIFICATE_VERIFIED factor="<<k<<" extension_degree="<<ND<<" exact_rhs=1\n";
 }
 cerr<<"ALL_FIVE_SQUARE_CERTIFICATES_VERIFIED\n";
}
