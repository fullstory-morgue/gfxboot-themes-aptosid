#!/bin/sh

set -e

# releases not using svg, no contents available
#	chaos:Χάος:2007-01:
#	tartaros:Τάρταρς:2007-02:

# releases not currently buildable, as they've not yet been ported from kde3 
# to kde4
#	gaia:Γάια:2007-03:
#	eros:Έρως:2007-04:
#	nyx:Νυξ:2008-01:
#	erebos:Έρεβος:2008-02:
#	ourea:Ουρέα:2008-03:
#	pontos:Πόντος:2008-04:
#	ouranos:Οὐρανος:2009-01:
#	momos:Μώμος:2009-03:
#	moros:Μόρος:2009-04:
#	hypnos:Ύπνος:2010-01:
#	aether:Αιθήρ:2009-02:

# old style, currently not yet supported, packaging

RELEASES="
	void:ασάφεια:0-0:
	keres:Κῆρες:2010-02:
	apate:Ἀπάτη:2010-03:
	geras:Γῆρας:2011-01:
	imera:Ἡμέρα:2011-02:
	ponos:Πόνος:2011-03:
	thanatos:Θάνατος:2012-01:
"

GFXBOOT_VERSION="4.3.5"

[ -d ./debian ] || exit 1
cat ./debian/templates/control.source.in > debian/control
for i in $RELEASES; do
	# write debian/control from templates
	sed	-e s/\@CODENAME_SAFE\@/$(echo ${i} | cut -d\: -f1)/g \
		-e s/\@CODENAME\@/$(echo ${i} | cut -d\: -f2)/g \
		-e s/\@VERSION\@/$(echo ${i} | cut -d\: -f3)/g \
		-e s/\@GFXBOOT_VERSION\@/${GFXBOOT_VERSION}/g \
			./debian/templates/gfxboot-themes-aptosid-VERSION-CODENAME_SAFE-core.in \
			./debian/templates/gfxboot-themes-aptosid-VERSION-CODENAME_SAFE.in \
				>> ./debian/control

	if [ -d "./themes/$(echo ${i} | cut -d\: -f3)-$(echo ${i} | cut -d\: -f1)/data-install" ]; then
		cat debian/templates/text.svg > "./themes/$(echo ${i} | cut -d\: -f3)-$(echo ${i} | cut -d\: -f1)/data-install/text.svg"
	fi
done
