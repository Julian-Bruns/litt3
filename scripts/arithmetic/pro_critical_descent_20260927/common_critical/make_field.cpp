#include <cstdint>
#include <fstream>
#include <iostream>
#include <vector>
static int a25[25][25],m25[25][25],n25[25];
int mul(int a,int b){
 int aa[4],bb[4],c[7]={};
 for(int i=0;i<4;i++){aa[i]=a%25;a/=25;bb[i]=b%25;b/=25;}
 for(int i=0;i<4;i++)for(int j=0;j<4;j++)c[i+j]=a25[c[i+j]][m25[aa[i]][bb[j]]];
 int f[4]={5,2,6,7};
 for(int i=6;i>=4;i--)for(int j=0;j<4;j++)c[i-4+j]=a25[c[i-4+j]][n25[m25[c[i]][f[j]]]];
 return c[0]+25*c[1]+625*c[2]+15625*c[3];
}
int power(int a,int n){int b=1;for(;n;n>>=1,a=mul(a,a))if(n&1)b=mul(b,a);return b;}
int main(int argc,char**argv){
 if(argc!=2)return 2;
 for(int a=0;a<25;a++)for(int b=0;b<25;b++){
 int x=a%5,y=a/5,u=b%5,v=b/5;
 a25[a][b]=(x+u)%5+5*((y+v)%5);
 m25[a][b]=(x*u+3*y*v)%5+5*((x*v+y*u+y*v)%5);
 }
 for(int a=0;a<25;a++)n25[a]=(5-a%5)%5+5*((5-a/5)%5);
 const int N=390625;
 int g=2;for(;g<N;g++)if(power(g,N-1)==1&&power(g,(N-1)/2)!=1&&power(g,(N-1)/3)!=1&&power(g,(N-1)/13)!=1&&power(g,(N-1)/313)!=1)break;
 std::vector<int32_t> exp(2*(N-1)),log(N,-1);
 int x=1;for(int i=0;i<N-1;i++){if(log[x]!=-1){std::cerr<<"not primitive\n";return 3;}exp[i]=x;log[x]=i;x=mul(x,g);}
 for(int i=0;i<N-1;i++)exp[i+N-1]=exp[i];
 std::ofstream out(argv[1],std::ios::binary);out.write((char*)exp.data(),4*exp.size());out.write((char*)log.data(),4*log.size());
 std::cout<<"field_order="<<N<<" primitive_code="<<g<<" complete_cycle="<<(x==1)<<"\n";
}
