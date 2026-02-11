#!/bin/sh
while ! ninja -C /build update toolchains-update; do
    sleep 1
done
