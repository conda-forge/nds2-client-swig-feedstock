#!/usr/bin/env python3
# Copyright (C) 2023 Cardiff University

"""Tests for the python-nds2-client conda package.
"""

import sys

import pytest

import nds2


@pytest.mark.parametrize(("intype", "output"), [
    (nds2.channel.CHANNEL_TYPE_UNKNOWN, "UNKNOWN"),
    (nds2.channel.CHANNEL_TYPE_RAW, "raw"),
    (nds2.channel.CHANNEL_TYPE_MTREND, "m-trend"),
])
def test_channel_type_to_string(intype, output):
    assert nds2.channel.channel_type_to_string(intype) == output


@pytest.mark.parametrize(("intype", "output"), [
    (nds2.channel.DATA_TYPE_UNKNOWN, "undefined"),
    (nds2.channel.DATA_TYPE_FLOAT64, "real_8"),
    (nds2.channel.DATA_TYPE_UINT32, "uint_4"),
])
def test_data_type_to_string(intype, output):
    assert nds2.channel.data_type_to_string(intype) == output


if __name__ == "__main__":
    sys.exit(pytest.main([__file__, "-ra", "-v"]))
