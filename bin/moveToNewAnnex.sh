#=======================================
#=== moveToNewAnnex.sh
#===
#=== Change to a new annex (does not
#=== commit the change)
#===
#=======================================


die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "1 argument required, $# provided"
echo $1 | grep -E -q '^s3://' || die "S3 bucket URL required, $1 provided"

export NEW_ANNEX="$1"

./bin/inflatePaths.sh .

echo $NEW_ANNEX > s3info/s3annex_config.txt

./deflateAll.sh


