#!/bin/bash
# Many thanks to Tenforce for the following DPU installation scripts
#

URL="http://localhost:8080/master/api/1"

install_dpu() {
    dpu_file=$(ls $1)

    echo -n "..installing $dpu_file: "
    outputfile="/var/log/unifiedviews/dpu_out.out"

    # fire cURL and wait until it finishes
    curl --user $MASTER_API_USER:$MASTER_API_PASSWORD --fail --silent --output $outputfile -X POST -H "Cache-Control: no-cache" -H "Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW" -F file=@$dpu_file ${URL}/import/dpu/jar?force=true 
    wait $!

    # check if the installation went well
    outcontents=`cat $outputfile`
    echo $outcontents
}


if [ "$(ls -A /unifiedviews/target/dpu)" ]; then
    exit 0
else
    echo "---------------------------------------------------------------------"
    echo "Installing DPUs.."
    echo "..target instance: $URL"
    echo "---------------------------------------------------------------------"
    echo "Waiting for Web service to be set online"

    i=0
    until $(curl --output /dev/null --silent --head --fail --user $MASTER_API_USER:$MASTER_API_PASSWORD ${URL}/pipelines) || [ "$i" -gt 36 ]; do
        i=$((i+1))
        printf '.'
        sleep 5
    done

    for f in /unifiedviews/plugins/*/target/*.jar; do 
        install_dpu "$f"; 
    done
fi  

