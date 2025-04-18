#!/bin/sh
while ! ninja -C /build update; do
    sleep 1
done
