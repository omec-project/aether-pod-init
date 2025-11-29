# Copyright 2019-present Open Networking Foundation
# Copyright 2024-present Intel Corporation
#
# SPDX-License-Identifier: Apache-2.0

FROM alpine:3.22@sha256:4b7ce07002c69e8f3d704a9c5d6fd3053be500b7f1c69fc0d80990c2ad8dd412 AS pod-init

LABEL description="ONF open source 5G Core Network" \
    version="Stage 3"

RUN apk update && apk add --no-cache bind-tools
