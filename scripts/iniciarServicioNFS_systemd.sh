#!/bin/sh
systemctl start nfsd.service rpc-idmapd.service rpc-mountd.service rpcbind.service
