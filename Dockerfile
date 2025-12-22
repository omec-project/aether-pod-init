# Copyright 2019-present Open Networking Foundation
# Copyright 2024-present Intel Corporation
#
# SPDX-License-Identifier: Apache-2.0

FROM alpine:3.23@sha256:865b95f46d98cf867a156fe4a135ad3fe50d2056aa3f25ed31662dff6da4eb62 AS pod-init

LABEL description="ONF open source 5G Core Network" \
    version="Stage 3"

RUN apk update && apk add --no-cache bind-tools
