for ORG in cctv wcvb wgbh whdh; do
  echo "Ingest $ORG"
  FILE=$ORG.pbcore.xml
  rm /tmp/$FILE
  curl https://s3.amazonaws.com/bostonlocaltv.org/pbcore/$FILE > /tmp/$FILE
  rake data:$ORG file=/tmp/$FILE
done
