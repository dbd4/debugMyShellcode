#include <fcntl.h>
#include <sys/mman.h>
#include <sys/prctl.h>
#include <unistd.h>

int main(int argc, char const *argv[]){
	char *buf = mmap(0,0x1000,PROT_EXEC|PROT_READ|PROT_WRITE,MAP_ANONYMOUS|MAP_PRIVATE,-1,0);
	if(argc == 2){
		read(open(argv[1],O_RDONLY),buf,0x1000);
	}else{
		read(0,buf,0x1000);
	}
	((void(*)())buf)();
}
