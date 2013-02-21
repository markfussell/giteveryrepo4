#
# MLF: This expects to be 'sourced' or the exports will have no effect
#
./bin/s3cmd/s3cmd inflate ./bin/aws/awscfn `cat s3info/s3annex_config.txt` --config=s3info/s3cmd_config.txt --recursive --parallel --workers `cat s3info/s3worker_config.txt` -v --flatten --force --include-from s3info/blob_includes.txt --exclude-from s3info/blob_excludes.txt

if [ "" == "$JAVA_HOME" ]; then
   echo "Need a JAVA_HOME"
   export JAVA_HOME="/usr/lib/jvm/jre"
fi

export AWS_CLOUDFORMATION_HOME=`pwd`/bin/aws/awscfn
export AWS_CREDENTIAL_FILE=~/.aws/awscfn_config.txt
