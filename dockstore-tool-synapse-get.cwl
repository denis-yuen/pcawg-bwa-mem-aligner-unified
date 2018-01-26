#!/usr/bin/env cwl-runner

class: CommandLineTool
id: "synapse-get"
label: "Synapse get tool"

cwlVersion: v1.0

$namespaces:
  dct: http://purl.org/dc/terms/
  foaf: http://xmlns.com/foaf/0.1/

dct:creator:
  "@id": "http://orcid.org/0000-0001-9758-0176"
  foaf:name: James Eddy
  foaf:mbox: "mailto:james.a.eddy@gmail.com"

requirements:
- class: DockerRequirement
  dockerPull: quay.io/ga4gh-dream/dockstore-tool-synapse-get:1.7.2

inputs:
  config_file:
    type: File
    inputBinding:
      position: 1
      prefix: -c

  recursive:
    type: boolean
    inputBinding:
      position: 2
      prefix: -r

  synapse_id:
    type: string?
    inputBinding:
      position: 3
      prefix: -i

  query:
    type: string?
    inputBinding:
      position: 4
      prefix: -q

outputs:
  output:
    type: Any
    outputBinding:
      glob: "synapse_files/*"

baseCommand: ["bash", "/usr/local/bin/synapse_get"]
