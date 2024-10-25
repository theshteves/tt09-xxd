# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import functools

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@functools.lru_cache
def fib(n): return fib(n-1) + fib(n-2) if n > 1 else 1

@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")

    # Set the input values you want to test
    dut.ui_in.value = 20
    dut.uio_in.value = 30

    assert True
    '''
    #TODO: handle 8-bit overflow
    for n in range(13):
        expected_fibonacci = fib(n)
        #print(f'{n} => {expected_fibonacci}')

        await ClockCycles(dut.clk, 1)
        assert dut.uo_out.value == expected_fibonacci
    '''
