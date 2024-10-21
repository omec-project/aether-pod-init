#
# Copyright 2019-present Open Networking Foundation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#

VERSION                  ?= $(shell cat ./VERSION)
KUBE_VERSION		 ?= v1.15.3

DOCKER_TAG               ?= ${VERSION}
DOCKER_REGISTRY          ?=
DOCKER_REPOSITORY        ?=
DOCKER_BUILD_ARGS        ?=
DOCKER_BUILD_TARGET      ?= pod-init
DOCKER_IMAGENAME         ?= ${DOCKER_REGISTRY}${DOCKER_REPOSITORY}${DOCKER_BUILD_TARGET}:${DOCKER_TAG}

## Docker labels. Only set ref and commit date if committed
DOCKER_LABEL_VCS_URL     ?= $(shell git remote get-url $(shell git remote))
DOCKER_LABEL_VCS_REF     ?= $(shell git diff-index --quiet HEAD -- && git rev-parse HEAD || echo "unknown")
DOCKER_LABEL_COMMIT_DATE ?= $(shell git diff-index --quiet HEAD -- && git show -s --format=%cd --date=iso-strict HEAD || echo "unknown" )
DOCKER_LABEL_BUILD_DATE  ?= $(shell date -u "+%Y-%m-%dT%H:%M:%SZ")

# https://docs.docker.com/engine/reference/commandline/build/#specifying-target-build-stage---target
docker-build:
	docker build $(DOCKER_BUILD_ARGS) \
		--target ${DOCKER_BUILD_TARGET} \
		--tag ${DOCKER_IMAGENAME} \
		--build-arg "KUBE_LATEST_VERSION=${KUBE_VERSION}" \
		--label "org.label-schema.schema-version=1.0" \
		--label "org.label-schema.name=${DOCKER_BUILD_TARGET}" \
		--label "org.label-schema.version=${VERSION}" \
		--label "org.label-schema.vcs-url=${DOCKER_LABEL_VCS_URL}" \
		--label "org.label-schema.vcs-ref=${DOCKER_LABEL_VCS_REF}" \
		--label "org.label-schema.build-date=${DOCKER_LABEL_BUILD_DATE}" \
		--label "org.opencord.vcs-commit-date=${DOCKER_LABEL_COMMIT_DATE}" \
		.

docker-push:
	docker push ${DOCKER_IMAGENAME}

test: docker-build

.PHONY: docker-build docker-push test
