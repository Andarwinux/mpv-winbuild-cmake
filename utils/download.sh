#!/bin/sh
while ! ninja -C /build download; do
    sleep 1
done
