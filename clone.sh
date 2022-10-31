#!/bin/sh

echo "Cloning repositories..."

PERCONA_DEV_DIR=$HOME/dev/percona
DEV_DIR=$HOME/dev

# PMM
git clone git@github.com:percona/pmm.git $PERCONA_DEV_DIR/pmm
git clone git@github.com:Percona-Lab/pmm-submodules.git $PERCONA_DEV_DIR/pmm-submodules

# PMM exporters
git clone git@github.com:percona/mongodb_exporter.git $PERCONA_DEV_DIR/exporters/mongodb_exporter
