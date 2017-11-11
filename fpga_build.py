#!/usr/bin/python3

####################
# Program Go-Board #
####################

import sys
import getopt
import subprocess
import re

def main():
    fpga_top = ''       # Top level verilog project file
    fpga_module = []    # optional fpga module files
    constfile = ''      # constraints .pcf file
    try:
         opts, args = getopt.getopt(sys.argv[1:], "ht:p:")
    except getopt.GetoptError:
         print('fpga_build.py ' 
               '-t <input file> \n'
               '-p <constraints file> \n'
               '\n'
               'List module files last, with a space between each file.')

    for opt, arg in opts:
        if opt == '-h':
            print('Help Text')
            print('fpga_build.py \n'
               '-t <input file> \n'
               '-p <constraints file> \n'
               '\n'
               'List module files last, with a space between each file.')
            sys.exit()
        elif opt == '-t':
            fpga_top = arg
        elif opt == '-p':
            constfile = arg
        elif opt == '-m':
            fpga_module = arg
    
    if len(sys.argv) >= 3:
        for a in sys.argv[3:]:
            fpga_module.append(a)
    
    if not fpga_module:
        blif = yosys(fpga_top)
    else:
        blif = yosys(fpga_top, fpga_module)
    asc = arachne_pnr(blif, constfile)
    fpga_file = icepack(asc)
        

def yosys(inputfile, args):
    '''Synthesizing the fpga_top file, defaults are for NANDLAND GO-Board'''
    yosys_filename = re.search('^.*(?=(.v))', inputfile)
    blif = yosys_filename.group(0) + '.blif'
    #if not module:
    #    subprocess.run(['yosys', '-Q', '-p synth_ice40 -blif %s' % blif, 
    #                    inputfile])
    #else:
    subprocess.run(['yosys', '-Q', '-q', '-p synth_ice40 -blif %s' % blif, 
                        inputfile, *args])
    print("########## SYNTHESIS FINISHED ###########")
    return blif

def arachne_pnr(inputfile, const):
    '''Place and Route after synthesis'''
    pnr = inputfile[:-5] + '.asc'
    constfile = const
    subprocess.run(['arachne-pnr', '-d', '1k', '-o', pnr, '-p', constfile,
                    '-P', 'vq100', inputfile])
    print("######### PLACE AND ROUTE COMPLETE ########")
    return pnr

def icepack(inputfile):
    '''Packing into a .bin for programming'''
    bin_file = inputfile[:-4] + '.bin'
    subprocess.run(['icepack', inputfile, bin_file])
    print("#########################\n"
          "#### FPGA FILE READY ####\n"
          "#########################")
    return bin_file
    

if __name__ == '__main__':
    # Executes only if run as script
    # Check and see if any arguments are passed. print help if no
    try:
        arg1 = sys.argv[1]
    except IndexError:
        print('fpga_build.py \n' 
               '-t <input file> \n'
               '-p <constraints file> \n'
               '\n'
               'List module files last, with a space between each file.'
             )
        sys.exit(1)
    main()



