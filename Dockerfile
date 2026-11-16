# Copyright 2019-present Open Networking Foundation
# Copyright 2024-present Intel Corporation
#
# SPDX-License-Identifier: Apache-2.0

FROM alpine:3.24@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf AS pod-init


# Build arguments for dynamic labels
ARG VERSION=dev
ARG VCS_URL=unknown
ARG VCS_REF=unknown
ARG BUILD_DATE=unknown

LABEL org.opencontainers.image.source="${VCS_URL}" \
    org.opencontainers.image.version="${VERSION}" \
    org.opencontainers.image.created="${BUILD_DATE}" \
    org.opencontainers.image.revision="${VCS_REF}" \
    org.opencontainers.image.url="${VCS_URL}" \
    org.opencontainers.image.title="pod-init" \
    org.opencontainers.image.description="Aether 5G Core AETHER-POD-INIT Network Function" \
    org.opencontainers.image.authors="Aether SD-Core <dev@lists.aetherproject.org>" \
    org.opencontainers.image.vendor="Aether Project" \
    org.opencontainers.image.licenses="Apache-2.0" \
    org.opencontainers.image.documentation="https://docs.sd-core.aetherproject.org/"

# bind-tools is for nslookup.
RUN apk add --no-cache bind-tools

# Run as an unprivileged user. The container that sets up core dumps on the host asks for root
# (runAsUser: 0) in its pod spec.
RUN addgroup -S -g 1000 aether && adduser -S -u 1000 -G aether aether

USER 1000:1000
