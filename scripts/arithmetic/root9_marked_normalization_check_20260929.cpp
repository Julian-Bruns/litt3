#define main accepted_companion_main
#include "pro_companion140_20260928/src/native/companion.cpp"
#undef main
int main(int argc,char**argv){init(argv[1]);F q(2),u(3);auto co=small_critical(q,u);std::ofstream o(argv[2]);o<<"{\"q\":2,\"u\":3,\"co\":[";for(int i=0;i<3;i++){if(i)o<<',';o<<'[';for(int j=0;j<3;j++){if(j)o<<',';json(o,co[i].c[j]);}o<<']';}o<<"]}\n";}
