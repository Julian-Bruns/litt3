#include "algebra.hpp"
K decode(uint64_t c){K a;for(int j=0;j<7;j++){a.v[j]=c%25;c/=25;}if(c)throw runtime_error("bad code");return a;}
int main(){try{init();uint64_t state=0x6a09e667f3bcc909ULL;
 cout<<"# a b a_plus_b a_times_b a_inverse a_power_5 (native field codes)\n";
 for(int i=0;i<256;i++){
  state=state*6364136223846793005ULL+1442695040888963407ULL;uint64_t ac=state%6103515625ULL;if(!ac)ac=1;
  state=state*6364136223846793005ULL+1442695040888963407ULL;uint64_t bc=state%6103515625ULL;
  K a=decode(ac),b=decode(bc);
  cout<<ac<<" "<<bc<<" "<<(a+b).code()<<" "<<(a*b).code()<<" "<<a.inv().code()<<" "<<a.pow(5).code()<<"\n";
 }
 return 0;}catch(const exception&e){cerr<<e.what()<<endl;return 1;}}
