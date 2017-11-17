ENV["projectdir"] ? @projectdir=ENV["projectdir"] : @projectdir = "HGAP_Assembly"
ENV["ccsprojectdir"] ? @projectdir=ENV["ccsprojectdir"] : @ccsprojectdir = "CCS"

directory "lib"

file "lib/inputfiles.fofn" => ["lib"] do
	sh "ls -l /tsl/data/dropbox/sebastian/F16FTSECKF2158_PHYgpyM/Pi-junsi/r001404_42161_160919_*/*subreads.bam | awk '{print $9}' > lib/inputfiles.fofn"
end

file "lib/subreads.xml" => ["lib/inputfiles.fofn"] do
	sh "source smrtlink-5.0.1; dataset create --type SubreadSet lib/subreads.xml lib/inputfiles.fofn"
end


task :run_hgap => ["lib/subreads.xml"] do
	puts "Running HGAP4 using smrtlink 5.0.1"
	sh "source smrtlink-5.0.1; pbsmrtpipe pipeline-id --entry eid_subread:lib/subreads.xml --preset-xml /tsl/software/testing/smrtlink/5.0.1/x86_64/lib/hgap_workflow_options_preset.xml --preset-xml lib/hgap_options.xml -o #{@projectdir} pbsmrtpipe.pipelines.polished_falcon_fat"
end
task :run_ccs => ["lib/subreads.xml"] do
	puts "Running CCS using smrtlink v5.0.1"
	sh "source smrtlink-5.0.1; pbsmrtpipe pipeline-id --entry eid_subread:lib/subreads.xml --preset-xml /tsl/software/testing/smrtlink/5.0.1/x86_64/lib/workflow_options_preset.xml --preset-xml lib/ccs.preset.xml -o #{@ccsprojectdir} pbsmrtpipe.pipelines.sa3_ds_ccs"
end
task :default => [:run_hgap, :run_ccs]
