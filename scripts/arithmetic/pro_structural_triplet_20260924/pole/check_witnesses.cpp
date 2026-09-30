// Check every supplied linear inconsistency witness. This checker does not
// perform Gaussian elimination and does not assume the generator is correct.
#include "field_and_system.hpp"
#include <fstream>
#include <string>
using namespace std;
uint32_t read_u32(istream& i){uint32_t n=0;for(int k=0;k<4;k++){int c=i.get();if(c<0)throw runtime_error("Truncated certificate");n|=uint32_t(c)<<(8*k);}return n;}
int main(int argc,char**argv){try{
    if(argc!=2)throw runtime_error("Usage: check_witnesses PATH_TO_linear_witnesses.bin");
    ifstream cert(argv[1],ios::binary);if(!cert)throw runtime_error("Cannot open certificate");
    string magic(8,' ');cert.read(magic.data(),8);
    if(magic!="SFCPLIN1"||read_u32(cert)!=787176||read_u32(cert)!=7)throw runtime_error("Bad header");
    init();endpoints_init();int total=0,inconsistent=0,consistent=0;
    for(int z=0;z<116;z++)for(int f=0;f<116;f++)for(int g=f;g<116;g++){
        total++;array<int,7>w;bool zero=true;
        for(int i=0;i<7;i++){w[i]=read_u32(cert);if(w[i]<0||w[i]>=Q)throw runtime_error("Invalid field code");if(w[i])zero=false;}
        const bool expected=(z==0&&f==58&&g==58)||(z==58&&f>=29&&f<58&&g==f+58);
        if(zero!=expected)throw runtime_error("Certificate's consistent-case list differs");
        if(zero){consistent++;continue;}
        auto sys=system_at(z,f,g);
        for(int j=0;j<5;j++){int dot=0;for(int i=0;i<7;i++)dot=add(dot,mul(w[i],sys.augmented[i][j]));if(dot!=(j==4?1:0))throw runtime_error("Invalid left-null inconsistency witness");}
        inconsistent++;
    }
    if(cert.peek()!=char_traits<char>::eof())throw runtime_error("Trailing certificate data");
    if(total!=787176||inconsistent!=787146||consistent!=30)throw runtime_error("Wrong counts");
    cout<<"PASS: all 787146 witnesses satisfy w*A=0 and w*rhs=1.\n";
    cout<<"PASS: precisely the listed 30 cases have zero records.\n";
    cout<<"PASS: header, field codes, record count, and end-of-file checked.\n";
}catch(const exception&e){cerr<<"ERROR: "<<e.what()<<"\n";return 1;}}

