// Exact full norm reconstruction at a finite, possibly nonreduced ratio algebra.
// The only inversions are units explicitly checked in the quotient K[q]/M.
#include "field.cpp"
#include <ctime>
static EP truncate_ep(EP a,int n){if(a.len()>n)a.a.resize((size_t)n*ED);a.norm();return a;}
static EP frobenius_truncated(const EP&a,int iter,int length){
 int p=1;for(int i=0;i<iter;i++)p*=5;EP out;
 out.a.assign((size_t)length*ED,0);
 for(int i=0;i<a.len() && i*p<length;i++){
  E e=epower(a.coeff(i),p);copy(e.begin(),e.end(),out.a.begin()+(size_t)i*p*ED);
 }
 out.norm();return out;
}
extern "C" int finite_norm_tails(const int* raw,int nurows,const int* mod,int d,
 const int* uin,const int* nun,const int* ppoly,int* normout,int* tailsout){
 try{
  ff_init();if(d<1 || d>2048 || mod[d]!=1)return -1;
  ED=d;EM.assign(mod,mod+d+1);const int count=3*3*47;
  clock_t begin=clock();E q(ED,0);if(ED==1)q[0]=neg(EM[0]);else q[1]=1;
  E u(uin,uin+ED),nu(nun,nun+ED),up=eone();
  KP vals((size_t)count*ED,0);
  for(int i=0;i<nurows;i++){
   E b=up;
   for(int j=0;j<9;j++){
    for(int k=0;k<count;k++){
     int c=raw[((size_t)i*count+k)*9+j];if(!c)continue;
     int* to=vals.data()+(size_t)k*ED;
     for(int h=0;h<ED;h++)if(b[h])to[h]=add(to[h],mul(c,b[h]));
    }
    // Multiplication by the actual quotient variable q, no dense product.
    int top=b.back();for(int h=ED-1;h>=0;h--)b[h]=sub(h?b[h-1]:0,mul(top,EM[h]));
   }
   up=emul(up,u);
  }
  E q2=emul(q,q),tau=emul(q2,nu);vector<EP>th(3);
  E tp=eone();
  for(int s=0;s<3;s++){
   for(int j=0;j<3;j++){
    EP a(KP(vals.begin()+(size_t)(s*3+j)*47*ED,vals.begin()+(size_t)(s*3+j+1)*47*ED));
    th[j]=epadd(th[j],epscale(a,tp));
   }
   tp=emul(tp,tau);
  }
  fprintf(stderr,"finite norm degree %d: Theta evaluated, CPU %.3f\n",d,double(clock()-begin)/CLOCKS_PER_SEC);fflush(stderr);
  EP P;P.a.assign((size_t)11*ED,0);for(int i=0;i<11;i++)P.a[(size_t)i*ED]=ppoly[i];P.norm();
  EP Pbar=epscale(P,q2);EP N=epadd(eppower(th[0],3),epadd(epmul(eppower(th[1],3),Pbar),epmul(eppower(th[2],3),eppower(Pbar,2))));
  E two=eone();two[0]=2;N=epadd(N,epscale(epmul(epmul(epmul(th[0],th[1]),th[2]),Pbar),two));
  if(N.len()!=141)return -2;
  copy(N.a.begin(),N.a.end(),normout);
  E il=einv(N.coeff(140));EP A;A.a.resize((size_t)73*ED);
  for(int i=0;i<73;i++){E c=emul(N.coeff(140-i),il);copy(c.begin(),c.end(),A.a.begin()+(size_t)i*ED);}A.norm();
  fprintf(stderr,"finite norm degree %d: full norm, CPU %.3f\n",d,double(clock()-begin)/CLOCKS_PER_SEC);fflush(stderr);
  EP A2=truncate_ep(epmul(A,A),73),A3=truncate_ep(epmul(A2,A),73);
  EP C=truncate_ep(epmul(truncate_ep(epmul(A3,frobenius_truncated(A2,1,73)),73),frobenius_truncated(A2,2,73)),73);
  for(int i=0;i<2;i++){E v=C.coeff(71+i);copy(v.begin(),v.end(),tailsout+(size_t)i*ED);}
  fprintf(stderr,"finite norm degree %d: exact tails, CPU %.3f\n",d,double(clock()-begin)/CLOCKS_PER_SEC);fflush(stderr);
  return 0;
 }catch(const exception&ex){fprintf(stderr,"finite norm error: %s\n",ex.what());return -3;}
}

// Independent source-array path: evaluate q^4*Rtilde directly, without using
// Theta components, cubic norm multiplication, or the square-tail algorithm.
extern "C" int finite_residual_values(const int*raw,int rows,const int*mod,int d,
 const int*uin,const int*nun,int*out){
 try{
  ff_init();if(d<1||d>2048||mod[d]!=1)return -1;
  ED=d;EM.assign(mod,mod+d+1);const int count=7*141;
  E q(ED,0);if(d==1)q[0]=neg(EM[0]);else q[1]=1;
  E u(uin,uin+d),nu(nun,nun+d),up=eone();KP vals((size_t)count*d,0);
  for(int i=0;i<rows;i++){
   E mon=up;
   for(int j=0;j<9;j++){
    for(int k=0;k<count;k++){
     int c=raw[((size_t)i*count+k)*9+j];if(!c)continue;
     int*dst=vals.data()+(size_t)k*d;
     for(int h=0;h<d;h++)if(mon[h])dst[h]=add(dst[h],mul(c,mon[h]));
    }
    int top=mon.back();for(int h=d-1;h>=0;h--)mon[h]=sub(h?mon[h-1]:0,mul(top,EM[h]));
   }
   up=emul(up,u);
  }
  E q2=emul(q,q),tau=emul(q2,nu),tp=emul(q2,q2);
  fill(out,out+(size_t)141*d,0);E temp(d);
  for(int s=0;s<7;s++){
   for(int x=0;x<141;x++){
    emul_to(temp.data(),vals.data()+(size_t)(s*141+x)*d,tp.data());
    for(int j=0;j<d;j++)out[(size_t)x*d+j]=add(out[(size_t)x*d+j],temp[j]);
   }
   tp=emul(tp,tau);
  }
  return 0;
 }catch(const exception&ex){fprintf(stderr,"finite residual error: %s\n",ex.what());return -3;}
}
