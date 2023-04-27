#!/usr/bin/env bash
#
# Repository packages compiler
#
#
# Copyright Identiter: GPL-3.0
# Copyright (C) 2022~2023 UsiFX <xprjkts@gmail.com>
#

OBJECTS=("liquid-core" "liquid-dock" "liquid-terminal" "liquid-neofetch" "liquid-settings" "liquid-branding-wallpapers" "ttf-material-design-icons" "cutefish-sddm-theme")

if [[ -z "$object_directory" ]]; then
	export OUT=$(pwd)/out
	echo "Using $OUT as Work Directory"
else
	export OUT="$object_directory"
	echo "Using $OUT as Work Directory"
fi

[[ -d "$OUT" ]] || mkdir "$OUT"

main()
{
  for COUNT_OBJECTS in ${OBJECTS[@]}
  do
    cd $COUNT_OBJECTS || exit
    makepkg -s -f && mv -f *.pkg.tar.zst ${OUT} 
    cd ..
  done
}

help()
{
  echo "usage: build_pkgs.sh [OPTS]"
  echo ""
  echo "options:"
  echo "  --clean     clean the work directory"
  echo "  --compile   start the packages compilation"
  echo "  --help      print this menu"
  echo ""
}

for opts in "${@}"
do
  case "${opts}" in
    "--compile") main ;;
    "--clean") rm -rf "$OUT" && echo "CLEAN $OUT" ;;
    "--help") help ;;
  esac
done

[[ $# -lt "1" ]] && help
