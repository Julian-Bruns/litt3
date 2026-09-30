// Independent coefficient recurrence for the unique formal square root.
// It does not use the Frobenius-63 product, polynomial EP multiplication,
// the norm construction, or the moment/primitive-element algorithm.
#include "field.cpp"
extern "C" int endpoint_root_recurrence(const int*norm,const int*mod,int d,int*out){
 try{
  ff_init();if(d<1||d>2048||mod[d]!=1)return -1;
  ED=d;EM.assign(mod,mod+d+1);E il=einv(E(norm+140*d,norm+141*d));vector<E>b(73,E(d,0));b[0]=eone();
  for(int n=1;n<=72;n++){
   E s(d,0);
   for(int i=1;i*2<n;i++){
    E z=emul(b[i],b[n-i]);for(int j=0;j<d;j++)s[j]=add(s[j],mul(2,z[j]));
   }
   if(n%2==0)s=eadd(s,emul(b[n/2],b[n/2]));
   E a=emul(E(norm+(140-n)*d,norm+(141-n)*d),il);
   for(int j=0;j<d;j++)b[n][j]=mul(3,sub(a[j],s[j]));
  }
  copy(b[71].begin(),b[71].end(),out);copy(b[72].begin(),b[72].end(),out+d);return 0;
 }catch(const exception&ex){fprintf(stderr,"independent root recurrence: %s\n",ex.what());return -3;}
}
