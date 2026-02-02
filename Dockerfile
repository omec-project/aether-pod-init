# Copyright 2019-present Open Networking Foundation
# Copyright 2024-present Intel Corporation
#
# SPDX-License-Identifier: Apache-2.0

FROM alpine:3.23@sha256:25109184c71bdad752c8312a8623239686a9a2071e8825f20acb8f2198c3f659 AS pod-init

LABEL description="ONF open source 5G Core Network" \
    version="Stage 3"

RUN apk update && apk add --no-cache bind-tools
