hicTransform --matrix emu_40kb.h5 --method obs_exp --outFileName emu_40kb.oe.h5

hicConvertFormat --matrices emu_40kb.oe.h5 --inputFormat h5 --outputFormat ginteractions --resolutions 40000 --outFileName emu_40kb.oe.ginteractions

perl cal_intra_compartment_strength.pl emu.40Kb.autosome.cis.vecs.tsv.pca emu_40kb.oe.ginteractions.tsv Emu.intra_compartment_strength

perl cal_inter_compartment_strength.pl emu.40Kb.autosome.cis.vecs.tsv.pca emu_40kb.oe.ginteractions.tsv Emu.inter_compartment_strength
