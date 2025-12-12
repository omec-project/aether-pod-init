# Copyright 2019-present Open Networking Foundation
# Copyright 2024-present Intel Corporation
#
# SPDX-License-Identifier: Apache-2.0

FROM alpine:3.23@sha256:51183f2cfa6320055da30872f211093f9ff1d3cf06f39a0bdb212314c5dc7375 AS pod-init

LABEL description="ONF open source 5G Core Network" \
    version="Stage 3"

RUN apk update && apk add --no-cache bind-tools
