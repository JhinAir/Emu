#!/bin/bash

#SBATCH --job-name=Emu.PBJelly_gapfilling
#SBATCH --partition=basic
#SBATCH --cpus-per-task=24
#SBATCH --mem=100000
#SBATCH --mail-type=ALL
#SBATCH --output=Emu.PBJelly_gapfilling.o
#SBATCH --error=Emu.PBJelly_gapfilling.e

/home/user/liu/Software/PBSuite_15.8.24/bin/fakeQuals.py Emu.Company.R3.fasta Emu.Company.R3.qual

source /home/user/liu/Software/PBSuite_15.8.24/setup.sh

/home/user/liu/Software/PBSuite_15.8.24/bin/Jelly.py setup Emu.jellyprotocol.xml

/home/user/liu/Software/PBSuite_15.8.24/bin/Jelly.py mapping Emu.jellyprotocol.xml

/home/user/liu/Software/PBSuite_15.8.24/bin/Jelly.py support Emu.jellyprotocol.xml -x "-m 20"

/home/user/liu/Software/PBSuite_15.8.24/bin/Jelly.py extraction Emu.jellyprotocol.xml

/home/user/liu/Software/PBSuite_15.8.24/bin/Jelly.py assembly Emu.jellyprotocol.xml

/home/user/liu/Software/PBSuite_15.8.24/bin/Jelly.py output Emu.jellyprotocol.xml
