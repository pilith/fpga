####################
# Program Go-Board #
####################

#!/usr/bin/python3
import sys
import getopt
import subprocess
import re

def main():
    verilog = ''  # original fpga verilog file
    constfile = ''  # constraints .pcf file
    try:
         opts, args = getopt.getopt(sys.argv[1:], "hi:p:")
    except getopt.GetoptError:
         print('fpga_build.py \n' 
               '-i <input file> \n'
               '-p <constraints file> \n'
               )
    for opt, arg in opts:
        if opt == '-h':
            print('Help Text')
            print('fpga_build.py \n'
             '-i <input file> \n'
             '-p <constraints file> \n'
             )
            sys.exit()
        elif opt == '-i':
            verilog = arg
        elif opt == '-p':
            constfile = arg
    print(verilog)
    print(constfile)
    blif = yosys(verilog)
    asc = arachne_pnr(blif, constfile)
    fpga_file = icepack(asc)
        

def yosys(inputfile):
    '''Synthesizing the verilog file, defaults are for NANDLAND GO-Board'''
    yosys_filename = re.search('^.*(?=(.v))', inputfile)
    blif = yosys_filename.group(0) + '.blif'
    subprocess.run(['yosys', '-p synth_ice40 -blif %s' % blif, inputfile])
    return blif

def arachne_pnr(inputfile, const):
    '''Place and Route after synthesis'''
    pnr = inputfile[:-5] + '.asc'
    constfile = const
    print(constfile + '\n' + pnr)
    subprocess.run(['arachne-pnr', '-d', '1k', '-o', pnr, '-p', constfile,
                    '-P', 'vq100', inputfile])
    return pnr

def icepack(inputfile):
    '''Packing into a .bin for programming'''
    bin_file = inputfile[:-4] + '.bin'
    subprocess.run(['icepack', inputfile, bin_file])
    return bin_file
    

if __name__ == '__main__':
    # Executes only if run as script
    main()


