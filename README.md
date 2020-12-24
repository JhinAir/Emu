This page demonstrates all the analyses in the paper, titled "A new emu genome illuminates the evolution of genome configuration and nuclear architecture of avian chromosomes".

## Genome assembly
```
1) Using [falcon] to do the pacbio assembly
    bash ./01.Pacbio_assembly/falcon.sh
2) 10x scaffolding
# Reads pre_process.
  bash ./02.10x_scaffolding/01.Reads/01_pre_process.sh
# Using Scaff10x for the initial scaffolding.
  bash ./02.10x_scaffolding/02.Scaff10x/02_Scaff10x.sh
# Using ARCS and LINKS for the second round of scaffolding.
  bash ./02.10x_scaffolding/03.ARCS_LINKS/03_Longranger_ARCS_LINKS.sh
3) HiC scaffolding
# DovetailGenomics scaffolding. Available HiRise software is at https://github.com/DovetailGenomics/HiRise_July2015_GR.
# Using juicer to produce hic matrix.
  bash ./03.HiC/02.Juicer.sh
# Using 3D-DNA for further scaffolding.
  bash ./03.HiC/03.3D_DNA.sh
# Using juicerbox for manually correction.
```
## Genome annotation
```
1) RepeatMask
    bash ./01.RepeatMask/01.RepeatModeler.sh & bash ./01.RepeatMask/02.RepeatMasker.sh
    # tandem repeat detection using trf.
    bash ./01.RepeatMask/03.TandomRepeat.sh
2) The first round of maker
    bash ./02.Maker_R1/round1.sh
3) Gene model preduction
    bash ./03.Augustus_SNAP/Augustus.sh & bash ./03.Augustus_SNAP/SNAP.sh
4) The second round of maker
    bash ./04.Maker_R2/round2.sh
5) Using PASA to correct the gene annotation
    bash ./05.PASA/Emu.Trinity.sh & bash ./05.PASA/02.Emu.PASA.sh
# Details can be found in https://github.com/umd-byob/presentations/tree/master/2015/0324-RepeatMasker-RepeatModeler and https://gist.github.com/darencard/bb1001ac1532dd4225b030cf0cd61ce2.
```
## Comparative genomics
```
1) Pairwise alignment
# Using lastal to do pairwise genome alignments.
  bash ./01.Pairwise_alignment/Emu.Chicken.PairwiseAlign.sh
2) Synteny visualization
  circos ./02.Synteny_visualization/Turtle.Emu.circos.conf
3) Rearrangement detection
# Merge the local small syntenic blocks produced by lastal.
  bash ./03.Rearrangement_detection/01.Block_Merge.sh
# Classify genomic rearrangements (INV, TRANS and INV_TRANS)
  bash ./03.Rearrangement_detection/02.Rearrangement_Detection.sh
```
## Hi-C analysis
```
1) Generating HiC matrix with HiCExplorer & HiCPro
  bash ./01.HiC_matrix/01.HiCExplorer_P1.sh & bash ./01.HiC_matrix/01.HiCExplorer_P2.sh
  bash ./01.HiC_matrix/02.HiC-Pro.sh
2) TAD-calling and plot using HiCExplorer
  bash ./02.HiC_tad/1.TAD_detection.sh & bash ./02.HiC_tad/02.TAD_plot.sh
3) AB compartment
# AB compartments were generated using cooler.
  bash ./03.AB_compartment/01.PCA.sh
# Compartmentalization using cooler.
  bash ./03.AB_compartment/02.Compartmentalization.sh
# Calculating compartment strength
  bash ./03.AB_compartment/03.Compartment_strength.sh
```
## Sex chromosome evolution
```
1) ZW similarity
  Details can be found at https://github.com/lurebgi/BOPsexChr.
2) Using genewise to evaluate the degeneration of W-linked genes
  bash ./02.W_degeneration/Genewise.sh
3) ZW HiC interaction
  bash ./03.ZW_HiC_interaction/ZW.Interaction.Window.sh
```

[falcon]: https://pb-falcon.readthedocs.io/en/latest/
