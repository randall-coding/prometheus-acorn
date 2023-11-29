#!/bin/bash

acorn build -t ghcr.io/randall-coding/acorn/prometheus && \
acorn push ghcr.io/randall-coding/acorn/prometheus && \
acorn run -n prometheus ghcr.io/randall-coding/acorn/prometheus