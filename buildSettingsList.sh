#create all of the individual ones
for i in `find -name Dockerfile -exec dirname {} \; | sed 's#\./##g'`; do 
    VERSION=`echo $i | sed 's|/| |g' | awk '{print $1}'`
    OS=`echo $i | sed 's|/| |g' | awk '{print $2}'`
    VARIANT=`echo $i | sed 's|/| |g' | awk '{print $3}'`
    NAME="${VERSION}-${VARIANT}-${OS}"

    echo "master /$i/ $NAME"; 
done

#create all the minor release variants
for i in `ls -d [0-9].[0-9]`; do
    OS=$(ls -d $i/* | tail -n 1)
    for k in `find $OS -mindepth 1 -type d`; do
        NAME=`basename $k`
        echo "master /$k/ $i-$NAME"; 
    done
    echo "master /$k/ $i"; 
done

#create all the major release variants
for i in `ls -d [0-9].[0-9] | sed 's/\./ /g' | awk '{print $1}' | sort -u`; do
    for j in `ls -d $i.[0-9]/* | tail -n 1`; do
        for k in `find $j -mindepth 1 -type d`; do
            NAME=`basename $k`
            echo "master /$k/ $i-$NAME"; 
        done
        echo "master /$k/ $i"; 
    done
done

#create all of the "latest" variations
LATEST=`ls -d [0-9].[0-9]/* | sort | tail -n 1`
for i in `find $LATEST -mindepth 1 -type d`; do
    NAME=`basename $i`
    echo "master /$i/ latest-$NAME"; 
done

#"latest" is same as latest-cli version
echo "master /$LATEST/cli/ latest"
