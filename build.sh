#!/bin/sh

mkdir output

set -e

for militiaMember in militia_members/*
do
  militiaMember=$(basename $militiaMember)
  xsltproc template.xml militia_members/$militiaMember/info.xml > militia_members/$militiaMember/$militiaMember.html &
done

wait

for militiaMember in militia_members/*
do
  militiaMember=$(basename $militiaMember)
  wkhtmltopdf --dpi 380 --page-size letter militia_members/$militiaMember/$militiaMember.html output/$militiaMember.pdf &
  wkhtmltoimage militia_members/$militiaMember/$militiaMember.html output/$militiaMember.png &
done

wait

gs -q -sPAPERSIZE=letter -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=TheWellRegulatedMilitia.pdf output/*.pdf
