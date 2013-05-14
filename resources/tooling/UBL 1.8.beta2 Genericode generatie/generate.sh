clear
echo "*********************************************************************************************************"
echo "* Transforming UBL 1.8.beta2 Genericode Schematron into XSLT "
echo "* - - - - - - - - - - - - - - - - - - - - - - - - - - - - "
echo "* Script writen by : Bas van Driel"
echo "*                    Edwin Luinstra"
echo "* - - - - - - - - - - - - - - - - - - - - - - - - - - - - "
echo "*"
echo "* How does it work?"
echo "*"
echo "* 1. We use the Crane tooling set from:"
echo "*    http://www.cranesoftwrights.com/resources/ubl/index.htm"
echo "*    look for 'Schematron implementation of CVA files for validation'"
echo "*    This toolset was also stored in our project in /resources/Crane-cva2sch-...."
echo "*    So you do not need to re-download it. :)"
echo "*"
echo "* 2. The toolset needs some specific jars, which are manually"
echo "*    copy-paste-ed into the utility folder in the Crane folder"
echo "* "
echo "* 3. Once the toolset is in place, we download the specifications for UBL"
echo "*    we want to generate Genericode validation for"
echo "*    Thus, we went to :" 
echo "*    http://www.logius.nl/producten/gegevensuitwisseling/digipoort/documentatie/berichtenstandaard/ubl/"
echo "*    And downloaded : 1.8.beta2.zip"
echo "* "
echo "* 4. Extract this zip, and you will find \(amongst others\) a"
echo "*    directory called cl/, this will contain genericode files"
echo "*    We copied this complete directory into the one you are in now."
echo "*    Since in older versioe than 1.8.beta2, there is no cva dir. We copied the one for 1.8.beta2,  "
echo "*    because it includes the almost all of the same files, and thus can be reused."
echo "*    We removed the includes (compared to 1.8.beta2) for:"
echo "*        - cl/gc/InvoicePeriodDescriptionCode.gc"
echo "*    we renamed it and put it in:"
echo "*    cva/UBL-DefaultDTQ-2.0-NL-1.8.beta2.cva"
echo "* "
echo "* 5. We created the UBL_1_7_namespace_constraints.sch"
echo "*    Make sure that if you are repeating this process for a new version"
echo "*    you check that the namespace in this file matches namespaces in the"
echo "*    UBL-DefaultDTQ-2-0-NL-1.8.beta2.cva"
echo "* "
echo "* 6. Be ware ! The UBL_1_7_namespace_constraints.sch does not contain"
echo "*    much, but it DOES INCLUDE the generated schematron from the "
echo "*    UBL-DefaultDTQ-2.0-NL-1.8.beta2.cva that contains ALL validations !"
echo "*    Thus, if you change this script for some new xsl-generation"
echo "*    make sure you also update the import statement in UBL_1_7_namespace_constraints.sch"
echo "* "
echo "* 7. The output of the xslt generation is copied into the src/main/resources folder"
echo "*    where it can be found by our code. "
echo "* "
echo "* "
echo "*    That s all folks !"
echo "*********************************************************************************************************"

# step 1, create schematron xsl generator template from cva rules
sh ../Crane-cva2sch-20120423-1830z/utility/xslt.sh UBL-DefaultDTQ-2.0-NL-1.7.cva ../Crane-cva2sch-20120423-1830z/utility/Crane-cva2schXSLT.xsl output/UBL-DefaultDTQ-2.0-NL-1.8.beta2.sch.xsl

# step 2, exercise schematron xsl generator over itself, creating schematron output
sh ../Crane-cva2sch-20120423-1830z/utility/xslt.sh output/UBL-DefaultDTQ-2.0-NL-1.8.beta2.sch.xsl output/UBL-DefaultDTQ-2.0-NL-1.8.beta2.sch.xsl output/UBL-DefaultDTQ-2.0-NL-1.8.beta2.sch

# step 3, Transform UBL_1_7_namespace_constraints (which INCLUDES the above output file UBL-DefaultDTQ-2.0-NL-1.8.beta2.sch !) into the final schematron file 
sh ../Crane-cva2sch-20120423-1830z/utility/xslt.sh UBL_1_7_namespace_constraints.sch ../Crane-cva2sch-20120423-1830z/utility/iso_schematron_assembly.xsl output/Invoice-Genericode.sch

# step 4, Transform the final schematron file into an XSLT.
sh ../Crane-cva2sch-20120423-1830z/utility/xslt.sh output/Invoice-Genericode.sch ../Crane-cva2sch-20120423-1830z/utility/Message-Schematron-terminator.xsl output/Invoice-Genericode.xsl

cp output/Invoice-Genericode.xsl ../../../src/main/resources/nl/clockwork/efactuur/nl/domain/ubl/1.8.beta2/.

rm -rf output