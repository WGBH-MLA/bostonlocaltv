for ORG in cctv wcvb wgbh whdh; do
  echo "Ingest $ORG"
  rake data:$ORG RAILS_ENV=development file=../bostonlocaltv-s3/pbcore/$ORG.pbcore.xml
done
