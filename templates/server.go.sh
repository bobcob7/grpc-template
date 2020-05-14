#!/bin/bash
cd $(dirname $(dirname $(readlink -f $0)))
if [ -z "pkg/${SERVICE}" ]; then
    echo "Usage: SERVICE=[name] SERVICE_CAMEL=[Name] $0"
    exit 255
fi
OUTPUT="server/${SERVICE}/server.go"
if [ ! -f "$OUTPUT" ]; then
    mkdir -p server/${SERVICE}
    envsubst < templates/server.go.tpl > $OUTPUT
    impl -dir rpc/${SERVICE} 'svc *Server' ${SERVICE}.${SERVICE_CAMEL}Server >> $OUTPUT
    echo "~ $OUTPUT"
fi
