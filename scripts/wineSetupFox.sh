#!/bin/sh

server_wine_fox_url=http://archserver/~repo/archlinux/wine/zips

fox26_url='FPD26.zip'
vfp8_url='VFP8.zip'
libfoxpro69_url='LIBFOXPRO69.zip'
vfp_desktop_url='VisualFoxPro8.desktop'
fox26_desktop_url='FOXPRO26.desktop'

fox_download=$(echo $fox26_url $vfp8_url $libfoxpro69_url $vfp_desktop_url $fox26_desktop_url)



WINE_DIR=$HOME/.wine

if [ -d "$WINE_DIR" ]
then
	echo "Directory already exists!!!"
	mkdir $WINE_DIR/downloads
else

	mkdir -p $WINE_DIR/downloads

fi

for i in $fox_download
do
	myurl=$server_wine_fox_url/$i
	wget $myurl -O $WINE_DIR/downloads/$(basename $myurl)
done

winecfg

cp $WINE_DIR/downloads/$fox26_url $WINE_DIR/drive_c/
cd $WINE_DIR/drive_c/
unzip $fox26_url
rm $fox26_url

cd windows/system32
cp $WINE_DIR/downloads/$libfoxpro69_url ./
unzip $libfoxpro69_url
rm $libfoxpro69_url

cd $WINE_DIR/drive_c/Archivos\ de\ programa/
cp $WINE_DIR/downloads/$vfp8_url ./
unzip $vfp8_url
rm $vfp8_url
cd Microsoft\ Visual\ FoxPro\ 8/ 
#wine vfp8.exe
cd ..
mv Microsoft\ Visual\ FoxPro\ 8/ VFP8

cd

mkdir bin
cd bin 

ln -s $WINE_DIR/drive_c/Archivos\ de\ programa/VFP8/vfp8.exe vfp8.exe
touch vfp8.sh
chmod a+x vfp8.sh
echo "#!/bin/bash" >> vfp8.sh
echo "wine $HOME/bin/vfp8.exe" >> vfp8.sh

#ln -s $WINE_DIR/drive_c/FPD26/FOXPRO.EXE FOXPRO.EXE
touch FOXPRO.sh
chmod a+x FOXPRO.sh
echo "#!/bin/bash" >> FOXPRO.sh
echo "cd $WINE_DIR/drive_c/FPD26/" >> FOXPRO.sh
echo "dosbox FOXPRO.EXE" >> FOXPRO.sh



cd $HOME/Desktop
 cp $WINE_DIR/downloads/$vfp_desktop_url $HOME/Desktop
 cp $WINE_DIR/downloads/$fox26_desktop_url    $HOME/Desktop
echo ".........[done]"




