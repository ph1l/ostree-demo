#!/bin/bash -xe

FROM_REF=$1
TO_REF=$2

ostree --repo=repo static-delta generate --min-fallback-size=0 \
	--filename=delta-update-file --from="$FROM_REF" "$TO_REF"
