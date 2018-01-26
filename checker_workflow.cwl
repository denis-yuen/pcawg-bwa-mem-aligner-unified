cwlVersion: v1.0
class: Workflow

requirements:
  MultipleInputFeatureRequirement: {}

inputs:
  output_file_basename:
    type: string
    inputBinding:
      position: 10
      prefix: --output-file-basename
    doc: the basename to use for output files
  download_reference_files:
    type: string
    inputBinding:
      position: 11
      prefix: --download-reference-files
    doc: should we attempt to download the reference files ["true", "false"]
  reference_gz_fai:
    type: File
    inputBinding:
      position: 3
      prefix: --reference-gz-fai
    doc: the reference *.fa.gz.fai file
  reference_gz:
    type: File
    inputBinding:
      position: 2
      prefix: --reference-gz
    doc: the reference *.fa.gz file
  reference_gz_pac:
    type: File
    inputBinding:
      position: 7
      prefix: --reference-gz-pac
    doc: the reference *.fa.gz.pac file
  reference_gz_amb:
    type: File
    inputBinding:
      position: 4
      prefix: --reference-gz-amb
    doc: the reference *.fa.gz.amb file
  reads:
    type:
      type: array
      items: File
    inputBinding:
      position: 1
      prefix: --files
  reference_gz_bwt:
    type: File
    inputBinding:
      position: 6
      prefix: --reference-gz-bwt
    doc: the reference *.fa.gz.bwt file
  output_dir:
    type: string
    inputBinding:
      position: 9
      prefix: --output-dir
    doc: the output directory
  reference_gz_sa:
    type: File
    inputBinding:
      position: 8
      prefix: --reference-gz-sa
    doc: the reference *.fa.gz.sa file
  reference_gz_ann:
    type: File
    inputBinding:
      position: 5
      prefix: --reference-gz-ann
    doc: the reference *.fa.gz.ann file


outputs:
  workflow_output_file:
    type: File
    outputSource: checker/report_file

steps:
  real_workflow:
    run: Dockstore.cwl
    in:
      output_file_basename: output_file_basename
      download_reference_files: download_reference_files
      reference_gz_fai: reference_gz_fai
      reference_gz: reference_gz
      reference_gz_pac: reference_gz_pac
      reference_gz_amb: reference_gz_amb
      reads: reads
      reference_gz_bwt: reference_gz_bwt
      output_dir: output_dir
      reference_gz_sa: reference_gz_sa
      reference_gz_ann: reference_gz_ann
    out: [merged_output_bai, merged_output_unmapped_metrics, merged_output_bam, merged_output_metrics, merged_output_unmapped_bai,merged_output_unmapped_bam]
      
  checker:
    run: pcawg-bwa-mem-aligner.checker.cwl
    in: 
      result_files:
        source: [real_workflow/merged_output_bai, real_workflow/merged_output_unmapped_metrics, real_workflow/merged_output_bam, real_workflow/merged_output_metrics, real_workflow/merged_output_unmapped_bai, real_workflow/merged_output_unmapped_bam]
        linkMerge: merge_flattened
    out: [report_file]
