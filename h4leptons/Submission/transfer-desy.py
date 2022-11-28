import subprocess as process
import os

int main( int argc, char **argv ) {

    TOKEN=process.getoutput("cat token.txt")
    ## print(f"token = {TOKEN}")

    INPUTFILE=argv[0]
    DESY_STORAGE=argv[1]+"/"+argv[0]

    transfer_command = "curl -L -X PUT -H \"Authorization: Bearer " + str(TOKEN) + "\"" + " --upload-file " + INPUTFILE + " " + DESY_STORAGE
    ##print(f"transfer command = {transfer_command}")
    os.system(transfer_command)
}
