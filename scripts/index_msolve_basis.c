/* Memory-bounded index of the locally generated msolve -g2 output.
 * Each polynomial occupies one line; index byte ranges and leading terms
 * before/after specializing the LAST variable to a quadratic field element.
 * This is an index, NOT a Groebner-basis certificate. */
#define _POSIX_C_SOURCE 200809L
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <stdint.h>

static int cmp(const unsigned *a, const unsigned *b, int n) {
    unsigned da=0,db=0;
    for(int i=0;i<n;i++){da+=a[i];db+=b[i];}
    if(da!=db)return da>db?1:-1;
    for(int i=n-1;i>=0;i--)if(a[i]!=b[i])return a[i]<b[i]?1:-1;
    return 0;
}
static void fail(const char *message) {fprintf(stderr,"%s\n",message);exit(2);}
int main(int argc,char **argv) {
    if(argc!=2)fail("usage: index_msolve_basis FILE");
    FILE *in=fopen(argv[1],"r");if(!in)fail("cannot open input");
    char *line=NULL,*names[64];size_t cap=0;ssize_t len;int n=0,number=0;
    while(1){
        off_t offset=ftello(in);len=getline(&line,&cap,in);if(len<0)break;
        if(line[0]=='#'){
            char *p=strstr(line,"#variable order:");
            if(p){p+=strlen("#variable order:");char *save=NULL;
                for(char *tok=strtok_r(p,", \t\r\n",&save);tok;tok=strtok_r(NULL,", \t\r\n",&save)){
                    if(n>=64)fail("too many variables");names[n++]=strdup(tok);
                }
            }
            continue;
        }
        char *p=line;while(isspace(*p)||*p=='[')p++;
        if(!*p||*p==']')continue;
        if(n<2||strcmp(names[n-1],"zeta"))fail("last variable must be zeta");
        unsigned best[64]={0},prime[64]={0};unsigned long terms=0;
        while(*p&&*p!=','&&*p!=']'){
            while(isspace(*p))p++;
            if(!*p||*p==','||*p==']')break;
            if(*p=='+')p++;
            if(!isdigit(*p))fail("expected positive coefficient");
            char *end;long coefficient=strtol(p,&end,10);p=end;
            if(coefficient<1||coefficient>4)fail("expected nonzero F5 coefficient");
            unsigned e[64]={0};
            while(*p=='*'){
                p++;char *start=p;while(isalnum(*p)||*p=='_')p++;
                size_t width=p-start;int v=-1;
                for(int i=0;i<n;i++)if(strlen(names[i])==width&&!strncmp(start,names[i],width)){v=i;break;}
                if(v<0||*p!='^')fail("unrecognized variable/exponent");
                p++;long exponent=strtol(p,&end,10);if(end==p||exponent<1||exponent>65535)fail("bad exponent");
                p=end;if(e[v])fail("repeated variable factor");e[v]=(unsigned)exponent;
            }
            if(!terms)memcpy(prime,e,sizeof(prime));
            if(!terms||cmp(e,best,n-1)>0)memcpy(best,e,sizeof(best));
            if(number>0&&e[n-1]>1)fail("nonreduced coefficient-field term");
            terms++;
        }
        if(!terms)fail("empty polynomial");
        printf("%d\t%lld\t%lld\t%lu",number++,(long long)offset,(long long)len,terms);
        for(int i=0;i<n-1;i++)printf("\t%u",best[i]);
        for(int i=0;i<n;i++)printf("\t%u",prime[i]);
        putchar('\n');
    }
    fprintf(stderr,"indexed %d polynomials in %d variables\n",number,n);
    if(ferror(in))fail("input read error");
    free(line);for(int i=0;i<n;i++)free(names[i]);fclose(in);return 0;
}
