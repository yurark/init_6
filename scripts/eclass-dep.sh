#!/bin/bash

# To run "./eclass-dep.sh >> eclass-dep.graph; dot -Tpng eclass-dep.graph > eclass-dep.png"

cd ../eclass

echo "##Command to get the layout: \"dot -Tpng eclass-dep.graph > eclass-dep.png\""
echo "digraph g {"
echo "  graph [fontsize=30 labelloc=\"t\" label=\"\nsys-kernel/geek-sources project\neclass dependency graphs\nAndrey Ovcharov, "`date +"%Y-%m-%d"`"\n\n\" splines=true overlap=false rankdir = \"LR\"];"
echo "  ratio = auto;"

for eclass_name in $(ls -1 | grep eclass); do
	file=$(basename "$eclass_name" )
	stub=${file%.*}
	_stub=$(echo $stub | sed "s/-/_/")
	echo "  \"${_stub}\" [ style = \"filled, bold\" penwidth = 5 fillcolor = \"lightblue2\" fontname = \"Courier New\" shape = \"Mrecord\" label =<<table border=\"0\" cellborder=\"0\" cellpadding=\"3\" bgcolor=\"lightblue2\"><tr><td bgcolor=\"black\" align=\"center\" colspan=\"2\"><font 
    color=\"lightblue2\">$eclass_name</font></td></tr>"
	for export_function in $(grep "EXPORT_FUNCTIONS" $eclass_name | cut -d " " -f 2- ); do
		echo "<tr><td align=\"left\" port=\"$export_function\">$export_function</td></tr>"
	done
	echo -n "</table>> ];"
	echo ""
done

echo "  subgraph cluster_0 {"
echo "		  node [style=filled];"
echo "		    eutils"
echo ""
echo "		    rpm"
echo ""
echo "		  label = \"System eclass\`es\";"
echo "		  color=blue"
echo "  }"
echo "  subgraph cluster_1 {"
echo "		  node [style=filled];"
echo ""

core_eclasses="geek-sources.eclass brand.eclass build.eclass deblob.eclass fix.eclass src-vanilla.eclass src-rh.eclass src-uek.eclass patch.eclass squeue.eclass upatch.eclass utils.eclass vars.eclass"

for eclass_name in $core_eclasses; do
	file=$(basename "$eclass_name" )
	stub=${file%.*}

#	for inherit_eclass in $(grep -e "inherit " $eclass_name | cut -d " " -f 2- | sed "s/ ;;//" | tr '\n' ' '); do
	for inherit_eclass in $(grep -e "inherit " $eclass_name | cut -d " " -f 2- | head -1 ); do
		_stub=$(echo $stub | sed "s/-/_/")
		_inherit_eclass=$(echo $inherit_eclass | sed "s/-/_/")
		echo "		    ${_stub} -> ${_inherit_eclass} [ penwidth = 1 color=\"#ff0000\" ];"
	done
	echo ""
done

echo "		  label = \"Core eclass\`es\";"
echo "		  color=blue"
echo "	  }"
echo ""

for inherit_eclass in $(grep -e "inherit " geek-sources.eclass | cut -d " " -f 2- | sed "/src-vanilla utils fix upatch squeue vars/d" | sed "s/ ;;//" | tr '\n' ' '); do
	_inherit_eclass=$(echo $inherit_eclass | sed "s/-/_/")
	echo "  geek_sources -> ${_inherit_eclass}"
done
echo ""

for eclass_name in $(ls -1 | grep -v $(echo "$core_eclasses" | sed -e "s/ /\\\|/g") | grep eclass); do
#for eclass_name in $(ls -1 | grep eclass); do
	file=$(basename "$eclass_name" )
	stub=${file%.*}
	for inherit_eclass in $(grep -e "inherit " $eclass_name | cut -d " " -f 2- | sed "s/ ;;//" | tr '\n' ' '); do
		_stub=$(echo $stub | sed "s/-/_/")
		_inherit_eclass=$(echo $inherit_eclass | sed "s/-/_/")
		echo "  ${_stub} -> ${_inherit_eclass}"
	done
	echo ""
done

echo "}"
echo ""

cd ../scripts
