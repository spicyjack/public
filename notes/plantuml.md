# PlantUML Notes #

There's a `~/.bashrc.d` script located in
`public.git/rc_scripts/bashrc.d/plantuml`.

The default extension for PlantUML files is `*.pu`.

## Running PlantUML ##
Generate a PNG file from a PlantUML file

    java -jar plantuml.jar file1.pu

Explicitly generate a PNG file from a PlantUML file

    java -jar plantuml.jar -tpng file1.pu

Generate a SVG file from a PlantUML file

    java -jar plantuml.jar -tsvg file1.pu

Generate a PDF file from a PlantUML file

    java -jar plantuml.jar -tpdf file1.pu

Generate a Unicode ASCII art text file using from a PlantUML file

    java -jar plantuml.jar -tutxt file1.pu

Generate a PNG from a PlantUML file into a different directory

    java -jar plantuml.jar -o /path/to/output/dir file1.pu


vim: filetype=markdown shiftwidth=2 tabstop=2
